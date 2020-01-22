Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE31457DA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2020 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVO3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jan 2020 09:29:38 -0500
Received: from nbd.name ([46.4.11.11]:42202 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVO3i (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jan 2020 09:29:38 -0500
Received: from [31.29.40.139] (helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iuH0i-0001HH-A8; Wed, 22 Jan 2020 15:29:36 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [RESEND] ath11k: add tx hw 802.11 encapusaltion offloading support
Date:   Wed, 22 Jan 2020 15:29:30 +0100
Message-Id: <20200122142930.19239-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for ethernet rxtx mode to the driver. The feature
is enabled via a new module parameter. If enabled to driver will enable
the feature on a per vif basis if all other requirements were met.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/core.h  |  5 +++
 drivers/net/wireless/ath/ath11k/dp_tx.c | 16 ++++++++--
 drivers/net/wireless/ath/ath11k/mac.c   | 41 ++++++++++++++++++++-----
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 25cdcf71d0c4..15676dce98b1 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -59,9 +59,14 @@ static inline enum wme_ac ath11k_tid_to_ac(u32 tid)
 		WME_AC_VO);
 }
 
+enum ath11k_skb_flags {
+	ATH11K_SKB_HW_80211_ENCAP = BIT(0),
+};
+
 struct ath11k_skb_cb {
 	dma_addr_t paddr;
 	u8 eid;
+	u8 flags;
 	struct ath11k *ar;
 	struct ieee80211_vif *vif;
 } __packed;
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 918305dda106..3206f432f65b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -15,7 +15,11 @@ ath11k_txq_tcl_ring_map[ATH11K_HW_MAX_QUEUES] = { 0x0, 0x1, 0x2, 0x2 };
 static enum hal_tcl_encap_type
 ath11k_dp_tx_get_encap_type(struct ath11k_vif *arvif, struct sk_buff *skb)
 {
-	/* TODO: Determine encap type based on vif_type and configuration */
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+
+	if (tx_info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)
+		return HAL_TCL_ENCAP_TYPE_ETHERNET;
+
 	return HAL_TCL_ENCAP_TYPE_NATIVE_WIFI;
 }
 
@@ -39,8 +43,11 @@ static void ath11k_dp_tx_encap_nwifi(struct sk_buff *skb)
 static u8 ath11k_dp_tx_get_tid(struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ath11k_skb_cb *cb = ATH11K_SKB_CB(skb);
 
-	if (!ieee80211_is_data_qos(hdr->frame_control))
+	if (cb->flags & ATH11K_SKB_HW_80211_ENCAP)
+		return skb->priority % IEEE80211_QOS_CTL_TID_MASK;
+	else if (!ieee80211_is_data_qos(hdr->frame_control))
 		return HAL_DESC_REO_NON_QOS_TID;
 	else
 		return skb->priority & IEEE80211_QOS_CTL_TID_MASK;
@@ -87,7 +94,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
 
-	if (!ieee80211_is_data(hdr->frame_control))
+	if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) &&
+	    !ieee80211_is_data(hdr->frame_control))
 		return -ENOTSUPP;
 
 	pool_id = skb_get_queue_mapping(skb) & (ATH11K_HW_MAX_QUEUES - 1);
@@ -148,6 +156,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 *	  skb_checksum_help() is needed
 		 */
 	case HAL_TCL_ENCAP_TYPE_ETHERNET:
+		/* no need to encap */
+		break;
 	case HAL_TCL_ENCAP_TYPE_802_3:
 		/* TODO: Take care of other encap modes as well */
 		ret = -EINVAL;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 556eef9881a7..f56adba5f838 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -33,6 +33,10 @@
 	.max_power              = 30, \
 }
 
+static unsigned int ath11k_ethernet_mode;
+module_param_named(ethernet_mode, ath11k_ethernet_mode, uint, 0644);
+MODULE_PARM_DESC(ethernet_mode, "Use ethernet frame datapath");
+
 static const struct ieee80211_channel ath11k_2ghz_channels[] = {
 	CHAN2G(1, 2412, 0),
 	CHAN2G(2, 2417, 0),
@@ -3633,6 +3637,7 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *info;
 	dma_addr_t paddr;
 	int buf_id;
 	int ret;
@@ -3644,11 +3649,14 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 	if (buf_id < 0)
 		return -ENOSPC;
 
-	if ((ieee80211_is_action(hdr->frame_control) ||
-	     ieee80211_is_deauth(hdr->frame_control) ||
-	     ieee80211_is_disassoc(hdr->frame_control)) &&
-	     ieee80211_has_protected(hdr->frame_control)) {
-		skb_put(skb, IEEE80211_CCMP_MIC_LEN);
+	info = IEEE80211_SKB_CB(skb);
+	if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)) {
+		if ((ieee80211_is_action(hdr->frame_control) ||
+		     ieee80211_is_deauth(hdr->frame_control) ||
+		     ieee80211_is_disassoc(hdr->frame_control)) &&
+		     ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(skb, IEEE80211_CCMP_MIC_LEN);
+		}
 	}
 
 	paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
@@ -3745,6 +3753,7 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 			     struct ieee80211_tx_control *control,
 			     struct sk_buff *skb)
 {
+	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB((struct sk_buff *)skb);
 	struct ath11k *ar = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
@@ -3753,7 +3762,10 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	bool is_prb_rsp;
 	int ret;
 
-	if (ieee80211_is_mgmt(hdr->frame_control)) {
+	skb_cb->flags = 0;
+	if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
+		skb_cb->flags = ATH11K_SKB_HW_80211_ENCAP;
+	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
 		ret = ath11k_mac_mgmt_tx(ar, skb, is_prb_rsp);
 		if (ret) {
@@ -4028,6 +4040,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	struct vdev_create_params vdev_param = {0};
 	struct peer_create_params peer_param;
 	u32 param_id, param_value;
+	int hw_encap = 0;
 	u16 nss;
 	int i;
 	int ret;
@@ -4119,7 +4132,21 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 	param_id = WMI_VDEV_PARAM_TX_ENCAP_TYPE;
-	param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_AP:
+		hw_encap = 1;
+		break;
+	default:
+		break;
+	}
+
+	if (ieee80211_set_hw_80211_encap(vif, ath11k_ethernet_mode && hw_encap))
+		param_value = ATH11K_HW_TXRX_ETHERNET;
+	else
+		param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
+
 	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    param_id, param_value);
 	if (ret) {
-- 
2.20.1

