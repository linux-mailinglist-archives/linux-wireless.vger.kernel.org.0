Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44327260AFE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 08:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgIHGc2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 02:32:28 -0400
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:52972
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728501AbgIHGcW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 02:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599546741;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=DRDFdkuR5hjzn5yO8yI0axuytRv3//bsANKL+E0XtwI=;
        b=FrCFiy9OcgR++m/Ebnbv6p9OsGX9cm/X7ljKX2YdAQYw5DZXGoNH31vE+3AJ9Yop
        hDZSoBi/DTYx9CsiqljpaIC5Rrt43X6wwJ+8QPhwUT7u+01Zs+ZskMp2ZB0gepInplB
        WPkWbSnr5+CE/5/smGcXV5OhHBEwau4/0XJs26ek=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599546741;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=DRDFdkuR5hjzn5yO8yI0axuytRv3//bsANKL+E0XtwI=;
        b=LXCXed9e9VVDlMyTKfhKAPzWn3o728xEl3Sl+N5W8pzfhuaVrsUNnWSd80MpZy5Q
        ihz4nfsxt+edbV3Wx2L3IYKk53qP6rGF+lxRoj9d0uOhIz8GlWNiA+baPL+5gXA60uE
        0chIyt+xUO+q9Ew3afCTmkpifD5UBF1BB9TtRENs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE1FBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Naralasetty <vnaralas@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [PATCHv2] ath11k: add raw mode and software crypto support
Date:   Tue, 8 Sep 2020 06:32:21 +0000
Message-ID: <010101746c6a52d9-18302a2c-0d6d-4057-aa4b-95960c809646-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.08-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding raw mode tx/rx support. Also, adding support
for software crypto which depends on raw mode.

To enable raw mode tx/rx:
insmod ath11k.ko frame_mode=0

To enable software crypto:
insmod ath11k.ko crypto_mode=1

These modes could be helpful in debugging crypto related issues.

Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
v2:
 * addressed Kalle comments.

 drivers/net/wireless/ath/ath11k/core.c  | 27 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h  |  9 ++++++++
 drivers/net/wireless/ath/ath11k/debug.h |  2 ++
 drivers/net/wireless/ath/ath11k/dp_rx.c |  7 +++++--
 drivers/net/wireless/ath/ath11k/dp_tx.c | 37 +++++++++++++++++++++++----------
 drivers/net/wireless/ath/ath11k/mac.c   | 27 ++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/wmi.c   |  4 ++++
 7 files changed, 91 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 437b112..ea6d1d0 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -18,6 +18,16 @@ EXPORT_SYMBOL(ath11k_debug_mask);
 module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
+static unsigned int ath11k_crypto_mode;
+module_param_named(crypto_mode, ath11k_crypto_mode, uint, 0644);
+MODULE_PARM_DESC(crypto_mode, "crypto mode: 0-hardware, 1-software");
+
+/* frame mode values are mapped as per enum ath11k_hw_txrx_mode */
+unsigned int ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
+module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
+MODULE_PARM_DESC(frame_mode,
+		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)");
+
 static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.hw_rev = ATH11K_HW_IPQ8074,
@@ -580,6 +590,23 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		return ret;
 	}
 
+	switch (ath11k_crypto_mode) {
+	case ATH11K_CRYPT_MODE_SW:
+		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
+		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+		break;
+	case ATH11K_CRYPT_MODE_HW:
+		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
+		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+		break;
+	default:
+		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
+		return -EINVAL;
+	}
+
+	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
+		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
+
 	mutex_lock(&ab->core_lock);
 	ret = ath11k_core_start(ab, ATH11K_FIRMWARE_MODE_NORMAL);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index d21191c..a8c77de 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -35,6 +35,8 @@
 
 #define ATH11K_INVALID_HW_MAC_ID	0xFF
 
+extern unsigned int ath11k_frame_mode;
+
 enum ath11k_supported_bw {
 	ATH11K_BW_20	= 0,
 	ATH11K_BW_40	= 1,
@@ -54,6 +56,13 @@ enum wme_ac {
 #define ATH11K_VHT_MCS_MAX	9
 #define ATH11K_HE_MCS_MAX	11
 
+enum ath11k_crypt_mode {
+	/* Only use hardware crypto engine */
+	ATH11K_CRYPT_MODE_HW,
+	/* Only use software crypto */
+	ATH11K_CRYPT_MODE_SW,
+};
+
 static inline enum wme_ac ath11k_tid_to_ac(u32 tid)
 {
 	return (((tid == 0) || (tid == 3)) ? WME_AC_BE :
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 1cfe548..5571727 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -26,6 +26,8 @@ enum ath11k_debug_mask {
 	ATH11K_DBG_TESTMODE	= 0x00000400,
 	ATH11k_DBG_HAL		= 0x00000800,
 	ATH11K_DBG_PCI		= 0x00001000,
+	ATH11K_DBG_DP_TX	= 0x00001000,
+	ATH11K_DBG_DP_RX	= 0x00002000,
 	ATH11K_DBG_ANY		= 0xffffffff,
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index f3ca73d..a507c12 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2133,8 +2133,6 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 	mcast = is_multicast_ether_addr(hdr->addr1);
 	fill_crypto_hdr = mcast;
 
-	is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
-
 	spin_lock_bh(&ar->ab->base_lock);
 	peer = ath11k_peer_find_by_addr(ar->ab, hdr->addr2);
 	if (peer) {
@@ -2148,6 +2146,8 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 	spin_unlock_bh(&ar->ab->base_lock);
 
 	err_bitmap = ath11k_dp_rx_h_attn_mpdu_err(rx_desc);
+	if (enctype != HAL_ENCRYPT_TYPE_OPEN && !err_bitmap)
+		is_decrypted = ath11k_dp_rx_h_attn_is_decrypted(rx_desc);
 
 	/* Clear per-MPDU flags while leaving per-PPDU flags intact */
 	rx_status->flag &= ~(RX_FLAG_FAILED_FCS_CRC |
@@ -2350,6 +2350,9 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 		   !!(status->flag & RX_FLAG_MMIC_ERROR),
 		   !!(status->flag & RX_FLAG_AMSDU_MORE));
 
+	ath11k_dbg_dump(ar->ab, ATH11K_DBG_DP_RX, NULL, "dp rx msdu: ",
+			msdu->data, msdu->len);
+
 	/* TODO: trace rx packet */
 
 	ieee80211_rx_napi(ar->hw, NULL, msdu, napi);
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index a9632b7..6565d98 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -13,6 +13,10 @@ static enum hal_tcl_encap_type
 ath11k_dp_tx_get_encap_type(struct ath11k_vif *arvif, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct ath11k_base *ab = arvif->ar->ab;
+
+	if (test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags))
+		return HAL_TCL_ENCAP_TYPE_RAW;
 
 	if (tx_info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)
 		return HAL_TCL_ENCAP_TYPE_ETHERNET;
@@ -79,6 +83,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	struct ath11k_dp *dp = &ab->dp;
 	struct hal_tx_info ti = {0};
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
@@ -142,11 +147,17 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	ti.encap_type = ath11k_dp_tx_get_encap_type(arvif, skb);
 	ti.meta_data_flags = arvif->tcl_metadata;
 
-	if (info->control.hw_key)
-		ti.encrypt_type =
-			ath11k_dp_tx_get_encrypt_type(info->control.hw_key->cipher);
-	else
-		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
+	if (ti.encap_type == HAL_TCL_ENCAP_TYPE_RAW) {
+		if (key) {
+			ti.encrypt_type =
+				ath11k_dp_tx_get_encrypt_type(key->cipher);
+
+			if (ieee80211_has_protected(hdr->frame_control))
+				skb_put(skb, IEEE80211_CCMP_MIC_LEN);
+		} else {
+			ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
+		}
+	}
 
 	ti.addr_search_flags = arvif->hal_addr_search_flags;
 	ti.search_type = arvif->search_type;
@@ -156,7 +167,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	ti.bss_ast_hash = arvif->ast_hash;
 	ti.dscp_tid_tbl_idx = 0;
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    ti.encap_type != HAL_TCL_ENCAP_TYPE_RAW) {
 		ti.flags0 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_IP4_CKSUM_EN, 1) |
 			     FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_UDP4_CKSUM_EN, 1) |
 			     FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_UDP6_CKSUM_EN, 1) |
@@ -176,10 +188,11 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		ath11k_dp_tx_encap_nwifi(skb);
 		break;
 	case HAL_TCL_ENCAP_TYPE_RAW:
-		/*  TODO: for CHECKSUM_PARTIAL case in raw mode, HW checksum offload
-		 *	  is not applicable, hence manual checksum calculation using
-		 *	  skb_checksum_help() is needed
-		 */
+		if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {
+			ret = -EINVAL;
+			goto fail_remove_idr;
+		}
+		break;
 	case HAL_TCL_ENCAP_TYPE_ETHERNET:
 		/* no need to encap */
 		break;
@@ -242,6 +255,9 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	spin_unlock_bh(&tcl_ring->lock);
 
+	ath11k_dbg_dump(ab, ATH11K_DBG_DP_TX, NULL, "dp tx msdu: ",
+			skb->data, skb->len);
+
 	atomic_inc(&ar->dp.num_tx_pending);
 
 	return 0;
@@ -352,7 +368,6 @@ ath11k_dp_tx_process_htt_tx_complete(struct ath11k_base *ab,
 
 	wbm_status = FIELD_GET(HTT_TX_WBM_COMP_INFO0_STATUS,
 			       status_desc->info0);
-
 	switch (wbm_status) {
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_OK:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f4a085b..75800f3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -42,12 +42,6 @@
 	.max_power              = 30, \
 }
 
-/* frame mode values are mapped as per enum ath11k_hw_txrx_mode */
-static unsigned int ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
-module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
-MODULE_PARM_DESC(frame_mode,
-		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)");
-
 static const struct ieee80211_channel ath11k_2ghz_channels[] = {
 	CHAN2G(1, 2412, 0),
 	CHAN2G(2, 2417, 0),
@@ -2380,6 +2374,9 @@ static int ath11k_install_key(struct ath11k_vif *arvif,
 
 	reinit_completion(&ar->install_key_done);
 
+	if (test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
+		return 0;
+
 	if (cmd == DISABLE_KEY) {
 		/* TODO: Check if FW expects  value other than NONE for del */
 		/* arg.key_cipher = WMI_CIPHER_NONE; */
@@ -2411,8 +2408,13 @@ static int ath11k_install_key(struct ath11k_vif *arvif,
 		return -EOPNOTSUPP;
 	}
 
+	if (test_bit(ATH11K_FLAG_RAW_MODE, &ar->ab->dev_flags))
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV |
+			      IEEE80211_KEY_FLAG_RESERVE_TAILROOM;
+
 install:
 	ret = ath11k_wmi_vdev_install_key(arvif->ar, &arg);
+
 	if (ret)
 		return ret;
 
@@ -2484,6 +2486,9 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
 		return 1;
 
+	if (test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
+		return 1;
+
 	if (key->keyidx > WMI_MAX_KEY_INDEX)
 		return -ENOSPC;
 
@@ -4436,6 +4441,8 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	if (ieee80211_set_hw_80211_encap(vif, hw_encap))
 		param_value = ATH11K_HW_TXRX_ETHERNET;
+	else if (test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags))
+		param_value = ATH11K_HW_TXRX_RAW;
 	else
 		param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
 
@@ -6109,7 +6116,6 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ieee80211_hw_set(ar->hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(ar->hw, AP_LINK_PS);
 	ieee80211_hw_set(ar->hw, SPECTRUM_MGMT);
-	ieee80211_hw_set(ar->hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(ar->hw, CONNECTION_MONITOR);
 	ieee80211_hw_set(ar->hw, SUPPORTS_PER_STA_GTK);
 	ieee80211_hw_set(ar->hw, WANT_MONITOR_VIF);
@@ -6176,8 +6182,11 @@ static int __ath11k_mac_register(struct ath11k *ar)
 
 	ath11k_reg_init(ar);
 
-	/* advertise HW checksum offload capabilities */
-	ar->hw->netdev_features = NETIF_F_HW_CSUM;
+	if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {
+		ar->hw->netdev_features = NETIF_F_HW_CSUM;
+		ieee80211_hw_set(ar->hw, SW_CRYPTO_CONTROL);
+		ieee80211_hw_set(ar->hw, SUPPORT_FAST_XMIT);
+	}
 
 	ret = ieee80211_register_hw(ar->hw);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index a209e74..adde14a 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3366,6 +3366,10 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	config.rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
 	config.rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
 	config.rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
+
+	if (test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags))
+		config.rx_decap_mode = TARGET_DECAP_MODE_RAW;
+
 	config.scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
 	config.bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
 	config.roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
-- 
2.7.4

