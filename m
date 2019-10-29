Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD4E83ED
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 10:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfJ2JNQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 05:13:16 -0400
Received: from nbd.name ([46.4.11.11]:53998 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731200AbfJ2JNP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 05:13:15 -0400
Received: from p5dcfbe82.dip0.t-ipconnect.de ([93.207.190.130] helo=bertha.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iPNYu-0005ZW-3Z; Tue, 29 Oct 2019 10:13:12 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Subject: [PATCH V9 3/3] ath10k: add tx hw 802.11 encapusaltion offloading support
Date:   Tue, 29 Oct 2019 10:13:04 +0100
Message-Id: <20191029091304.7330-4-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029091304.7330-1-john@phrozen.org>
References: <20191029091304.7330-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for ethernet rxtx mode to the driver. The feature
is enabled via a new module parameter. If enabled to driver will enable
the feature on a per vif basis if all other requirements were met.

Testing on a IPQ4019 based hardware shows a increase in TCP throughput
of ~20% when the feature is enabled.

Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath10k/core.c   | 11 ++++
 drivers/net/wireless/ath/ath10k/core.h   |  3 +
 drivers/net/wireless/ath/ath10k/htt_tx.c | 24 +++++---
 drivers/net/wireless/ath/ath10k/mac.c    | 76 +++++++++++++++++++-----
 drivers/net/wireless/ath/ath10k/txrx.c   | 11 +++-
 5 files changed, 100 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index dc45d16e8d21..6fc637c73e26 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -33,6 +33,7 @@ static bool uart_print;
 static bool skip_otp;
 static bool rawmode;
 static bool fw_diag_log;
+static bool ethernetmode;
 
 unsigned long ath10k_coredump_mask = BIT(ATH10K_FW_CRASH_DUMP_REGISTERS) |
 				     BIT(ATH10K_FW_CRASH_DUMP_CE_DATA);
@@ -45,6 +46,7 @@ module_param(skip_otp, bool, 0644);
 module_param(rawmode, bool, 0644);
 module_param(fw_diag_log, bool, 0644);
 module_param_named(coredump_mask, ath10k_coredump_mask, ulong, 0444);
+module_param(ethernetmode, bool, 0644);
 
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 MODULE_PARM_DESC(uart_print, "Uart target debugging");
@@ -53,6 +55,7 @@ MODULE_PARM_DESC(cryptmode, "Crypto mode: 0-hardware, 1-software");
 MODULE_PARM_DESC(rawmode, "Use raw 802.11 frame datapath");
 MODULE_PARM_DESC(coredump_mask, "Bitfield of what to include in firmware crash file");
 MODULE_PARM_DESC(fw_diag_log, "Diag based fw log debugging");
+MODULE_PARM_DESC(ethernetmode, "Use ethernet frame datapath");
 
 static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 	{
@@ -3007,6 +3010,14 @@ static void ath10k_core_register_work(struct work_struct *work)
 	/* peer stats are enabled by default */
 	set_bit(ATH10K_FLAG_PEER_STATS, &ar->dev_flags);
 
+	if (ethernetmode && rawmode) {
+		ath10k_err(ar, "ethernet and raw mode cannot co-exist\n");
+		status = -EINVAL;
+		goto err;
+	}
+
+	ar->ethernetmode = ethernetmode;
+
 	status = ath10k_core_probe_fw(ar);
 	if (status) {
 		ath10k_err(ar, "could not probe fw (%d)\n", status);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 4d7db07db6ba..89f2d2982f37 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -109,6 +109,7 @@ enum ath10k_skb_flags {
 	ATH10K_SKB_F_MGMT = BIT(3),
 	ATH10K_SKB_F_QOS = BIT(4),
 	ATH10K_SKB_F_RAW_TX = BIT(5),
+	ATH10K_SKB_F_HW_80211_ENCAP = BIT(6),
 };
 
 struct ath10k_skb_cb {
@@ -1211,6 +1212,8 @@ struct ath10k {
 	struct ath10k_bus_params bus_param;
 	struct completion peer_delete_done;
 
+	bool ethernetmode;
+
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 2ef717f18795..403b6843da9e 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -1144,6 +1144,10 @@ static u8 ath10k_htt_tx_get_tid(struct sk_buff *skb, bool is_eth)
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ath10k_skb_cb *cb = ATH10K_SKB_CB(skb);
 
+	/* Firmware takes care of tid classification for ethernet format */
+	if (cb->flags & ATH10K_SKB_F_HW_80211_ENCAP)
+		return skb->priority % IEEE80211_QOS_CTL_TID_MASK;
+
 	if (!is_eth && ieee80211_is_mgmt(hdr->frame_control))
 		return HTT_DATA_TX_EXT_TID_MGMT;
 	else if (cb->flags & ATH10K_SKB_F_QOS)
@@ -1370,15 +1374,17 @@ static int ath10k_htt_tx_32(struct ath10k_htt *htt,
 	txbuf_paddr = htt->txbuf.paddr +
 		      (sizeof(struct ath10k_htt_txbuf_32) * msdu_id);
 
-	if ((ieee80211_is_action(hdr->frame_control) ||
-	     ieee80211_is_deauth(hdr->frame_control) ||
-	     ieee80211_is_disassoc(hdr->frame_control)) &&
-	     ieee80211_has_protected(hdr->frame_control)) {
-		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
-	} else if (!(skb_cb->flags & ATH10K_SKB_F_NO_HWCRYPT) &&
-		   txmode == ATH10K_HW_TXRX_RAW &&
-		   ieee80211_has_protected(hdr->frame_control)) {
-		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+	if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)) {
+		if ((ieee80211_is_action(hdr->frame_control) ||
+		     ieee80211_is_deauth(hdr->frame_control) ||
+		     ieee80211_is_disassoc(hdr->frame_control)) &&
+		    ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+		} else if (!(skb_cb->flags & ATH10K_SKB_F_NO_HWCRYPT) &&
+			   txmode == ATH10K_HW_TXRX_RAW &&
+			   ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+		}
 	}
 
 	skb_cb->paddr = dma_map_single(dev, msdu->data, msdu->len,
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 12dad659bf68..4b4abf27182c 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3426,12 +3426,16 @@ ath10k_mac_tx_h_get_txmode(struct ath10k *ar,
 			   struct sk_buff *skb)
 {
 	const struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	const struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(skb);
 	__le16 fc = hdr->frame_control;
 
 	if (!vif || vif->type == NL80211_IFTYPE_MONITOR)
 		return ATH10K_HW_TXRX_RAW;
 
+	if (tx_info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)
+		return ATH10K_HW_TXRX_ETHERNET;
+
 	if (ieee80211_is_mgmt(fc))
 		return ATH10K_HW_TXRX_MGMT;
 
@@ -3584,6 +3588,15 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
 			ieee80211_is_data_qos(hdr->frame_control);
 
 	cb->flags = 0;
+	cb->vif = vif;
+	cb->txq = txq;
+	cb->airtime_est = airtime;
+
+	if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
+		cb->flags |= ATH10K_SKB_F_HW_80211_ENCAP;
+		return;
+	}
+
 	if (!ath10k_tx_h_use_hwcrypto(vif, skb))
 		cb->flags |= ATH10K_SKB_F_NO_HWCRYPT;
 
@@ -3602,10 +3615,6 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
 		cb->flags |= ATH10K_SKB_F_NO_HWCRYPT;
 		cb->flags |= ATH10K_SKB_F_RAW_TX;
 	}
-
-	cb->vif = vif;
-	cb->txq = txq;
-	cb->airtime_est = airtime;
 }
 
 bool ath10k_mac_tx_frm_has_freq(struct ath10k *ar)
@@ -3715,6 +3724,9 @@ static int ath10k_mac_tx(struct ath10k *ar,
 	const struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(skb);
 	int ret;
 
+	if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)
+		goto skip_encap;
+
 	/* We should disable CCK RATE due to P2P */
 	if (info->flags & IEEE80211_TX_CTL_NO_CCK_RATE)
 		ath10k_dbg(ar, ATH10K_DBG_MAC, "IEEE80211_TX_CTL_NO_CCK_RATE\n");
@@ -3738,6 +3750,7 @@ static int ath10k_mac_tx(struct ath10k *ar,
 		}
 	}
 
+skip_encap:
 	if (info->flags & IEEE80211_TX_CTL_TX_OFFCHAN) {
 		if (!ath10k_mac_tx_frm_has_freq(ar)) {
 			ath10k_dbg(ar, ATH10K_DBG_MAC, "queued offchannel skb %pK\n",
@@ -3787,6 +3800,7 @@ void ath10k_offchan_tx_work(struct work_struct *work)
 	int ret;
 	unsigned long time_left;
 	bool tmp_peer_created = false;
+	struct ieee80211_tx_info *info;
 
 	/* FW requirement: We must create a peer before FW will send out
 	 * an offchannel frame. Otherwise the frame will be stuck and
@@ -3806,8 +3820,14 @@ void ath10k_offchan_tx_work(struct work_struct *work)
 		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac offchannel skb %pK\n",
 			   skb);
 
-		hdr = (struct ieee80211_hdr *)skb->data;
-		peer_addr = ieee80211_get_DA(hdr);
+		info = IEEE80211_SKB_CB(skb);
+
+		if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
+			peer_addr = skb->data;
+		} else {
+			hdr = (struct ieee80211_hdr *)skb->data;
+			peer_addr = ieee80211_get_DA(hdr);
+		}
 
 		spin_lock_bh(&ar->data_lock);
 		vdev_id = ar->scan.vdev_id;
@@ -4335,7 +4355,7 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct ieee80211_sta *sta = control->sta;
 	struct ieee80211_txq *txq = NULL;
-	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ieee80211_hdr *hdr;
 	enum ath10k_hw_txrx_mode txmode;
 	enum ath10k_mac_tx_path txpath;
 	bool is_htt;
@@ -4366,14 +4386,20 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 			return;
 		}
 
-		ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt, is_presp);
-		if (ret) {
-			ath10k_dbg(ar, ATH10K_DBG_MAC, "failed to increase tx mgmt pending count: %d, dropping\n",
-				   ret);
-			ath10k_htt_tx_dec_pending(htt);
-			spin_unlock_bh(&ar->htt.tx_lock);
-			ieee80211_free_txskb(ar->hw, skb);
-			return;
+		if (is_mgmt) {
+			hdr = (struct ieee80211_hdr *)skb->data;
+			is_presp = ieee80211_is_probe_resp(hdr->frame_control);
+
+			ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt,
+							     is_presp);
+			if (ret) {
+				ath10k_dbg(ar, ATH10K_DBG_MAC, "failed to increase tx mgmt pending count: %d, dropping\n",
+					   ret);
+				ath10k_htt_tx_dec_pending(htt);
+				spin_unlock_bh(&ar->htt.tx_lock);
+				ieee80211_free_txskb(ar->hw, skb);
+				return;
+			}
 		}
 		spin_unlock_bh(&ar->htt.tx_lock);
 	}
@@ -5130,10 +5156,12 @@ static int ath10k_mac_set_txbf_conf(struct ath10k_vif *arvif)
 static int ath10k_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
 	struct ath10k_peer *peer;
 	enum wmi_sta_powersave_param param;
+	int hw_encap = 0;
 	int ret = 0;
 	u32 value;
 	int bit;
@@ -5225,6 +5253,22 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 		break;
 	}
 
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_AP_VLAN:
+		if (wdev->netdev->ieee80211_ptr->use_4addr)
+			break;
+	/* fall through */
+	case NL80211_IFTYPE_AP:
+		hw_encap = 1;
+		break;
+	default:
+		break;
+	}
+
+	ieee80211_set_hw_80211_encap(vif, ar->ethernetmode & hw_encap);
+
 	/* Using vdev_id as queue number will make it very easy to do per-vif
 	 * tx queue locking. This shouldn't wrap due to interface combinations
 	 * but do a modulo for correctness sake and prevent using offchannel tx
@@ -8789,6 +8833,8 @@ int ath10k_mac_register(struct ath10k *ar)
 	ieee80211_hw_set(ar->hw, QUEUE_CONTROL);
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
+	if (ar->ethernetmode)
+		ieee80211_hw_set(ar->hw, SUPPORTS_80211_ENCAP);
 
 	if (!test_bit(ATH10K_FLAG_RAW_MODE, &ar->dev_flags))
 		ieee80211_hw_set(ar->hw, SW_CRYPTO_CONTROL);
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 4102df016931..608d6d6967fa 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -50,6 +50,8 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 	struct ath10k_skb_cb *skb_cb;
 	struct ath10k_txq *artxq;
 	struct sk_buff *msdu;
+	struct ieee80211_vif *vif;
+	u8 flags;
 
 	ath10k_dbg(ar, ATH10K_DBG_HTT,
 		   "htt tx completion msdu_id %u status %d\n",
@@ -78,6 +80,9 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 		artxq->num_fw_queued--;
 	}
 
+	flags = skb_cb->flags;
+	vif = skb_cb->vif;
+
 	ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
 	ath10k_htt_tx_dec_pending(htt);
 	if (htt->num_pending_tx == 0)
@@ -121,7 +126,11 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 		info->status.is_valid_ack_signal = true;
 	}
 
-	ieee80211_tx_status(htt->ar->hw, msdu);
+	if (flags & ATH10K_SKB_F_HW_80211_ENCAP)
+		ieee80211_tx_status_8023(htt->ar->hw, vif, msdu);
+	else
+		ieee80211_tx_status(htt->ar->hw, msdu);
+
 	/* we do not own the msdu anymore */
 
 	return 0;
-- 
2.20.1

