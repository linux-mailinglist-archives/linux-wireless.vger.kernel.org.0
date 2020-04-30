Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCEA1C0040
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 17:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgD3P2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgD3P2W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 11:28:22 -0400
X-Greylist: delayed 88257 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Apr 2020 08:28:22 PDT
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8EC035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 08:28:22 -0700 (PDT)
Received: from [149.224.97.242] (helo=bertha8.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jUB6o-0006xy-Sr; Thu, 30 Apr 2020 17:28:18 +0200
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V2] ath11k: add tx hw 802.11 encapusaltion offloading support
Date:   Thu, 30 Apr 2020 17:28:14 +0200
Message-Id: <20200430152814.18481-1-john@phrozen.org>
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
Changes in V2
* use an enum for datapath mode
* minor fixes as suggested by Julian

 drivers/net/wireless/ath/ath11k/core.h  |  5 +++
 drivers/net/wireless/ath/ath11k/dp_tx.c | 17 +++++++--
 drivers/net/wireless/ath/ath11k/mac.c   | 46 ++++++++++++++++++++-----
 3 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 5c767d87c174..12c0a4de3506 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -60,9 +60,14 @@ static inline enum wme_ac ath11k_tid_to_ac(u32 tid)
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
index 8c3f973923d6..a8f3accb7d3e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -16,7 +16,11 @@ ath11k_txq_tcl_ring_map[ATH11K_HW_MAX_QUEUES] = { 0x0, 0x1, 0x2, 0x2 };
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
 
@@ -40,8 +44,11 @@ static void ath11k_dp_tx_encap_nwifi(struct sk_buff *skb)
 static u8 ath11k_dp_tx_get_tid(struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ath11k_skb_cb *cb = ATH11K_SKB_CB(skb);
 
-	if (!ieee80211_is_data_qos(hdr->frame_control))
+	if (cb->flags & ATH11K_SKB_HW_80211_ENCAP)
+		return skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	else if (!ieee80211_is_data_qos(hdr->frame_control))
 		return HAL_DESC_REO_NON_QOS_TID;
 	else
 		return skb->priority & IEEE80211_QOS_CTL_TID_MASK;
@@ -88,7 +95,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
 
-	if (!ieee80211_is_data(hdr->frame_control))
+	if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) &&
+	    !ieee80211_is_data(hdr->frame_control))
 		return -ENOTSUPP;
 
 	pool_id = skb_get_queue_mapping(skb) & (ATH11K_HW_MAX_QUEUES - 1);
@@ -149,7 +157,10 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 *	  skb_checksum_help() is needed
 		 */
 	case HAL_TCL_ENCAP_TYPE_ETHERNET:
+		/* no need to encap */
+		break;
 	case HAL_TCL_ENCAP_TYPE_802_3:
+	default:
 		/* TODO: Take care of other encap modes as well */
 		ret = -EINVAL;
 		goto fail_remove_idr;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index aef012912003..735526b34024 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -33,6 +33,11 @@
 	.max_power              = 30, \
 }
 
+/* frame mode values are mapped as per enum ath11k_hw_txrx_mode */
+static unsigned int ath11k_ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
+module_param_named(ath11k_frame_mode, ath11k_ath11k_frame_mode, uint, 0644);
+MODULE_PARM_DESC(ath11k_frame_mode, "Datapath frame mode");
+
 static const struct ieee80211_channel ath11k_2ghz_channels[] = {
 	CHAN2G(1, 2412, 0),
 	CHAN2G(2, 2417, 0),
@@ -3806,10 +3811,10 @@ static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
 
 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
 {
+	struct sk_buff *msdu = skb;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(msdu);
 	struct ath11k *ar = ctx;
 	struct ath11k_base *ab = ar->ab;
-	struct sk_buff *msdu = skb;
-	struct ieee80211_tx_info *info;
 
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	idr_remove(&ar->txmgmt_idr, buf_id);
@@ -3849,6 +3854,7 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *info;
 	dma_addr_t paddr;
 	int buf_id;
 	int ret;
@@ -3860,11 +3866,14 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
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
@@ -3961,6 +3970,7 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 			     struct ieee80211_tx_control *control,
 			     struct sk_buff *skb)
 {
+	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
 	struct ath11k *ar = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
@@ -3969,7 +3979,9 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	bool is_prb_rsp;
 	int ret;
 
-	if (ieee80211_is_mgmt(hdr->frame_control)) {
+	if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
+		skb_cb->flags |= ATH11K_SKB_HW_80211_ENCAP;
+	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
 		ret = ath11k_mac_mgmt_tx(ar, skb, is_prb_rsp);
 		if (ret) {
@@ -4245,6 +4257,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	struct vdev_create_params vdev_param = {0};
 	struct peer_create_params peer_param;
 	u32 param_id, param_value;
+	int hw_encap = 0;
 	u16 nss;
 	int i;
 	int ret;
@@ -4339,7 +4352,22 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 	param_id = WMI_VDEV_PARAM_TX_ENCAP_TYPE;
-	param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
+	if (ath11k_ath11k_frame_mode == ATH11K_HW_TXRX_ETHERNET)
+		switch (vif->type) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP_VLAN:
+		case NL80211_IFTYPE_AP:
+			hw_encap = 1;
+			break;
+		default:
+			break;
+		}
+
+	if (ieee80211_set_hw_80211_encap(vif, hw_encap))
+		param_value = ATH11K_HW_TXRX_ETHERNET;
+	else
+		param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
+
 	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    param_id, param_value);
 	if (ret) {
-- 
2.20.1

