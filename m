Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC138E414
	for <lists+linux-wireless@lfdr.de>; Mon, 24 May 2021 12:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhEXKdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 May 2021 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhEXKdh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 May 2021 06:33:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECFC061574
        for <linux-wireless@vger.kernel.org>; Mon, 24 May 2021 03:32:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso9222499pjb.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 May 2021 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HQTXhEyEl48NQ8gO/DKR6ofXIuEzZCeyByaqxCNn+s=;
        b=gdirCc4rbzyzRMSS8Q2ippBLX6o0bCtuioQqXULxlLZtVPFIrAlPyyU8D2MI3YiANl
         K0LfFwhJy9TpAUtgBXg1TVhd8om6dDObA8QfvOduJ2mVH1H0EOk9gT/1FG8j9LeyA1mr
         7ijjCEryX4be9LeaKZm/PuodKwni8oZE4f+d/v7SSr8eCN58pqQlobInmqJXd+PaoMGL
         LPl63I3HsfOAvyAMQ+bvIvxMsb8aXeJGSgsX983DZpjny6/5tPo+MCjjiiW+BcpFoZe1
         xHEpUbf93au0ZKxxIdfleBDkwaHmmZbDM3cvn3kOkF5qfjYSi6CnwqiU0CP3tO1a9tZu
         0P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HQTXhEyEl48NQ8gO/DKR6ofXIuEzZCeyByaqxCNn+s=;
        b=i0I1+iRPgXgV6kaL2ldmGyqe7/8e/B4LS1+zcqjDbBesTin8oMwvYeXSFkWh2ovZuf
         mcyIkxYawODrWIWj+jumXEpVUFkOB69C+HkwuP68OXtVwGLH8kFkFeTgqi4r/ye/rHz/
         TIcV22riGAEauzDQIHM8dfKFVEMmE/4yZRkbu9CtZzRSYn5/1ggT2l1ehuhqrGGklpQd
         Lif0XoyrAWPhOLDPmUrP3/BU7tX0T5+XYqwbaRUpbqoWXqklQV0lmrmqrworPPdydwu7
         fyuB6RepW901dSyfeaHqEKpE2rVMiA8dQUDu6ZFqYuTv+r+0EYXjd0IzVdthKXb5ECnp
         POeA==
X-Gm-Message-State: AOAM533/CI6ptV01C/OAlStNcTXe5TqlsVyjz9HjiBXHbjrkB9K4GC2W
        0CYHlMGPKPcieTX6YGvoxecpJeuxAMIoKA==
X-Google-Smtp-Source: ABdhPJxiSeIyCLhUkCqkols+9AmFj6lOQDaEdmksxJXoCeSHhKft9kQ5Vm74tZ0dxX0B3klLgyO8fQ==
X-Received: by 2002:a17:90a:4493:: with SMTP id t19mr24048707pjg.217.1621852327270;
        Mon, 24 May 2021 03:32:07 -0700 (PDT)
Received: from localhost.localdomain ([140.138.152.65])
        by smtp.gmail.com with ESMTPSA id j5sm389017pfj.185.2021.05.24.03.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:32:06 -0700 (PDT)
From:   Zhijun You <hujy652@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Zhijun You <hujy652@gmail.com>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        John Crispin <john@phrozen.org>
Subject: [RFC] ath10k: add tx hw 802.11 encapsulation offloading support
Date:   Mon, 24 May 2021 18:31:30 +0800
Message-Id: <20210524103130.66693-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support of encap offload for ath10k which uses ethernet
datapath. The feature is enabled via a new module parmeter.
If enabled, the driver will enable the feature on a per vif basis if the requirements
are met.

Currently only implement for 32bit target with 3-addr AP and STA mode.

Improves TCP throughput when the feature is enabled.

Tested-on: QCA9984 firmware version 10.4-3.9.0.2-00131(Netgear R7800)

Co-developed-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Zhijun You <hujy652@gmail.com>
---
RFC because it's been almost two years since the original patch was
sent.

Changes since original John Crispin's v10 patch
* check if the target is 32bit
* remove the ATH10K_SKB_F_HW_80211_ENCAP flag and use tx_info flag
instead
* add ath10k_mac_op_update_vif_offload function for runtime change

Should we use a module param for frame mode like in ath11k instead a
dedicated param for each datapath and should we try to use
tx_status_ext()?
---
 drivers/net/wireless/ath/ath10k/core.c   | 15 ++++
 drivers/net/wireless/ath/ath10k/core.h   |  2 +
 drivers/net/wireless/ath/ath10k/htt_tx.c | 25 ++++---
 drivers/net/wireless/ath/ath10k/mac.c    | 95 ++++++++++++++++++------
 drivers/net/wireless/ath/ath10k/txrx.c   |  8 +-
 5 files changed, 110 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 2f9be182fbfb..2031c8d4e358 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -34,6 +34,7 @@ static bool uart_print;
 static bool skip_otp;
 static bool rawmode;
 static bool fw_diag_log;
+static bool ethernetmode;
 
 unsigned long ath10k_coredump_mask = BIT(ATH10K_FW_CRASH_DUMP_REGISTERS) |
 				     BIT(ATH10K_FW_CRASH_DUMP_CE_DATA);
@@ -46,6 +47,7 @@ module_param(skip_otp, bool, 0644);
 module_param(rawmode, bool, 0644);
 module_param(fw_diag_log, bool, 0644);
 module_param_named(coredump_mask, ath10k_coredump_mask, ulong, 0444);
+module_param(ethernetmode, bool, 0644);
 
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 MODULE_PARM_DESC(uart_print, "Uart target debugging");
@@ -54,6 +56,7 @@ MODULE_PARM_DESC(cryptmode, "Crypto mode: 0-hardware, 1-software");
 MODULE_PARM_DESC(rawmode, "Use raw 802.11 frame datapath");
 MODULE_PARM_DESC(coredump_mask, "Bitfield of what to include in firmware crash file");
 MODULE_PARM_DESC(fw_diag_log, "Diag based fw log debugging");
+MODULE_PARM_DESC(ethernetmode, "Use ethernet frame datapath");
 
 static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 	{
@@ -3281,12 +3284,24 @@ static void ath10k_core_register_work(struct work_struct *work)
 	/* peer stats are enabled by default */
 	set_bit(ATH10K_FLAG_PEER_STATS, &ar->dev_flags);
 
+	if (ethernetmode && rawmode) {
+		ath10k_err(ar, "invalid configuration, ethernet and rawmode data path can not coexist\n");
+		status = -EINVAL;
+		goto err;
+	}
+
 	status = ath10k_core_probe_fw(ar);
 	if (status) {
 		ath10k_err(ar, "could not probe fw (%d)\n", status);
 		goto err;
 	}
 
+	/* Ethernet mode only works for 32bit target */
+	if (!ar->hw_params.target_64bit && ethernetmode)
+		ar->ethernetmode = true;
+	else
+		ar->ethernetmode = false;
+
 	status = ath10k_mac_register(ar);
 	if (status) {
 		ath10k_err(ar, "could not register to mac80211 (%d)\n", status);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 648ed36f845f..f119c04fb5fe 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1298,6 +1298,8 @@ struct ath10k {
 	s32 tx_power_2g_limit;
 	s32 tx_power_5g_limit;
 
+	bool ethernetmode;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index d6b8bdcef416..968d9f63f222 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -1188,8 +1188,11 @@ static u8 ath10k_htt_tx_get_tid(struct sk_buff *skb, bool is_eth)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ath10k_skb_cb *cb = ATH10K_SKB_CB(skb);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
-	if (!is_eth && ieee80211_is_mgmt(hdr->frame_control))
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+		return skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	else if (!is_eth && ieee80211_is_mgmt(hdr->frame_control))
 		return HTT_DATA_TX_EXT_TID_MGMT;
 	else if (cb->flags & ATH10K_SKB_F_QOS)
 		return skb->priority & IEEE80211_QOS_CTL_TID_MASK;
@@ -1436,15 +1439,17 @@ static int ath10k_htt_tx_32(struct ath10k_htt *htt,
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
+	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
+		if ((ieee80211_is_action(hdr->frame_control) ||
+		     ieee80211_is_deauth(hdr->frame_control) ||
+		     ieee80211_is_disassoc(hdr->frame_control)) &&
+		     ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+		} else if (!(skb_cb->flags & ATH10K_SKB_F_NO_HWCRYPT) &&
+			   txmode == ATH10K_HW_TXRX_RAW &&
+			   ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+		}
 	}
 
 	skb_cb->paddr = dma_map_single(dev, msdu->data, msdu->len,
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index bb6c5ee43ac0..ee64039c3726 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3703,12 +3703,16 @@ ath10k_mac_tx_h_get_txmode(struct ath10k *ar,
 			   struct sk_buff *skb)
 {
 	const struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	const struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(skb);
 	__le16 fc = hdr->frame_control;
 
 	if (!vif || vif->type == NL80211_IFTYPE_MONITOR)
 		return ATH10K_HW_TXRX_RAW;
 
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+		return ATH10K_HW_TXRX_ETHERNET;
+
 	if (ieee80211_is_mgmt(fc))
 		return ATH10K_HW_TXRX_MGMT;
 
@@ -3866,6 +3870,13 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
 	bool noack = false;
 
 	cb->flags = 0;
+	cb->vif = vif;
+	cb->txq = txq;
+	cb->airtime_est = airtime;
+
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+		return;
+
 	if (!ath10k_tx_h_use_hwcrypto(vif, skb))
 		cb->flags |= ATH10K_SKB_F_NO_HWCRYPT;
 
@@ -3904,9 +3915,6 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
 		cb->flags |= ATH10K_SKB_F_RAW_TX;
 	}
 
-	cb->vif = vif;
-	cb->txq = txq;
-	cb->airtime_est = airtime;
 	if (sta) {
 		arsta = (struct ath10k_sta *)sta->drv_priv;
 		spin_lock_bh(&ar->data_lock);
@@ -4015,6 +4023,9 @@ static int ath10k_mac_tx(struct ath10k *ar,
 	const struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(skb);
 	int ret;
 
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+		goto skip_encap;
+
 	/* We should disable CCK RATE due to P2P */
 	if (info->flags & IEEE80211_TX_CTL_NO_CCK_RATE)
 		ath10k_dbg(ar, ATH10K_DBG_MAC, "IEEE80211_TX_CTL_NO_CCK_RATE\n");
@@ -4038,6 +4049,7 @@ static int ath10k_mac_tx(struct ath10k *ar,
 		}
 	}
 
+skip_encap:
 	if (!noque_offchan && info->flags & IEEE80211_TX_CTL_TX_OFFCHAN) {
 		if (!ath10k_mac_tx_frm_has_freq(ar)) {
 			ath10k_dbg(ar, ATH10K_DBG_MAC, "mac queued offchannel skb %pK len %d\n",
@@ -4087,6 +4099,7 @@ void ath10k_offchan_tx_work(struct work_struct *work)
 	int ret;
 	unsigned long time_left;
 	bool tmp_peer_created = false;
+	struct ieee80211_tx_info *info;
 
 	/* FW requirement: We must create a peer before FW will send out
 	 * an offchannel frame. Otherwise the frame will be stuck and
@@ -4106,8 +4119,13 @@ void ath10k_offchan_tx_work(struct work_struct *work)
 		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac offchannel skb %pK len %d\n",
 			   skb, skb->len);
 
-		hdr = (struct ieee80211_hdr *)skb->data;
-		peer_addr = ieee80211_get_DA(hdr);
+		info = IEEE80211_SKB_CB(skb);
+		if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+			peer_addr = skb->data;
+		} else {
+			hdr = (struct ieee80211_hdr *)skb->data;
+			peer_addr = ieee80211_get_DA(hdr);
+		}
 
 		spin_lock_bh(&ar->data_lock);
 		vdev_id = ar->scan.vdev_id;
@@ -4639,7 +4657,7 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct ieee80211_sta *sta = control->sta;
 	struct ieee80211_txq *txq = NULL;
-	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ieee80211_hdr *hdr;
 	enum ath10k_hw_txrx_mode txmode;
 	enum ath10k_mac_tx_path txpath;
 	bool is_htt;
@@ -4659,7 +4677,6 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 
 	if (is_htt) {
 		spin_lock_bh(&ar->htt.tx_lock);
-		is_presp = ieee80211_is_probe_resp(hdr->frame_control);
 
 		ret = ath10k_htt_tx_inc_pending(htt);
 		if (ret) {
@@ -4670,14 +4687,19 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
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
+			ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt, is_presp);
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
@@ -5441,6 +5463,36 @@ static int ath10k_mac_set_txbf_conf(struct ath10k_vif *arvif)
 					 ar->wmi.vdev_param->txbf, value);
 }
 
+static void ath10k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
+					     struct ieee80211_vif *vif)
+{
+	struct ath10k *ar = hw->priv;
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	u32 vdev_param, param_value;
+	int ret;
+
+	if (!ar->ethernetmode ||
+	    (vif->type != NL80211_IFTYPE_STATION &&
+	     vif->type != NL80211_IFTYPE_AP))
+		vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+
+	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
+		param_value = ATH10K_HW_TXRX_ETHERNET;
+	else
+		param_value = ATH10K_HW_TXRX_NATIVE_WIFI;
+
+	vdev_param = ar->wmi.vdev_param->tx_encap_type;
+	ret = ath10k_wmi_vdev_set_param(ar, arvif->vdev_id, vdev_param,
+					param_value);
+
+	/* 10.X firmware does not support this VDEV parameter. Do not warn */
+	if (ret && ret != -EOPNOTSUPP) {
+		ath10k_warn(ar, "failed to set vdev %i TX encapsulation: %d\n",
+			    arvif->vdev_id, ret);
+		vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	}
+}
+
 /*
  * TODO:
  * Figure out how to handle WMI_VDEV_SUBTYPE_P2P_DEVICE,
@@ -5634,15 +5686,7 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 
 	arvif->def_wep_key_idx = -1;
 
-	vdev_param = ar->wmi.vdev_param->tx_encap_type;
-	ret = ath10k_wmi_vdev_set_param(ar, arvif->vdev_id, vdev_param,
-					ATH10K_HW_TXRX_NATIVE_WIFI);
-	/* 10.X firmware does not support this VDEV parameter. Do not warn */
-	if (ret && ret != -EOPNOTSUPP) {
-		ath10k_warn(ar, "failed to set vdev %i TX encapsulation: %d\n",
-			    arvif->vdev_id, ret);
-		goto err_vdev_delete;
-	}
+	ath10k_mac_op_update_vif_offload(hw, vif);
 
 	/* Configuring number of spatial stream for monitor interface is causing
 	 * target assert in qca9888 and qca6174.
@@ -9327,6 +9371,7 @@ static const struct ieee80211_ops ath10k_ops = {
 	.config				= ath10k_config,
 	.add_interface			= ath10k_add_interface,
 	.remove_interface		= ath10k_remove_interface,
+	.update_vif_offload		= ath10k_mac_op_update_vif_offload,
 	.configure_filter		= ath10k_configure_filter,
 	.bss_info_changed		= ath10k_bss_info_changed,
 	.set_coverage_class		= ath10k_mac_op_set_coverage_class,
@@ -9936,6 +9981,8 @@ int ath10k_mac_register(struct ath10k *ar)
 	ieee80211_hw_set(ar->hw, QUEUE_CONTROL);
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
+	if (ar->ethernetmode)
+		ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 
 	if (!test_bit(ATH10K_FLAG_RAW_MODE, &ar->dev_flags))
 		ieee80211_hw_set(ar->hw, SW_CRYPTO_CONTROL);
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 7c9ea0c073d8..5876381f27cd 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -51,6 +51,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 	struct ath10k_txq *artxq;
 	struct sk_buff *msdu;
 	u8 flags;
+	struct ieee80211_vif *vif;
 
 	ath10k_dbg(ar, ATH10K_DBG_HTT,
 		   "htt tx completion msdu_id %u status %d\n",
@@ -80,6 +81,8 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 	}
 
 	flags = skb_cb->flags;
+	vif = skb_cb->vif;
+
 	ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
 	ath10k_htt_tx_dec_pending(htt);
 	if (htt->num_pending_tx == 0)
@@ -130,7 +133,10 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 		info->status.is_valid_ack_signal = true;
 	}
 
-	ieee80211_tx_status(htt->ar->hw, msdu);
+	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)
+		ieee80211_tx_status_8023(htt->ar->hw, vif, msdu);
+	else
+		ieee80211_tx_status(htt->ar->hw, msdu);
 	/* we do not own the msdu anymore */
 
 	return 0;
-- 
2.25.1

