Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5919D488EF6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jan 2022 04:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiAJDlm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jan 2022 22:41:42 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:41729 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbiAJDlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jan 2022 22:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641786102; x=1673322102;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=6atlCaAsXX8JPSzTnDoXyLuEau0LhlnX5CmM9kGW+vM=;
  b=d6qyxnKyOc4MiWKsfGs6rhW2j+teHF/tjGqNH+HaZ+yElLa3Bgy0JmXU
   f0JMClndPgkE/wZzVUTH1+QIlM2W4ad0xE4MFCRMvAwz88CS1qnGS5AzC
   B4vh84JlEX4GMVpdXDAXgdCSaD4wJD6NG0+ZEVh93kduvacB8XwGEK+GZ
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Jan 2022 19:41:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 19:41:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 19:41:41 -0800
Received: from seevalam-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 19:41:39 -0800
From:   Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Subject: [PATCH] ath11k: Add support for dynamic vlan
Date:   Mon, 10 Jan 2022 09:11:30 +0530
Message-ID: <1641786090-10232-1-git-send-email-quic_seevalam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Advertise AP-VLAN interface type for vlan support in driver.
Metadata information in dp_tx is added to notify firmware
that multicast/broadcast packets are encrypted in software.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01073-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c  |  6 +++
 drivers/net/wireless/ath/ath11k/dp_tx.c | 74 ++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/dp_tx.h | 14 +++++++
 drivers/net/wireless/ath/ath11k/hw.h    |  1 +
 drivers/net/wireless/ath/ath11k/mac.c   |  5 +++
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 293563b..0b2407e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -86,6 +86,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
 		.supports_suspend = false,
+		.supports_ap_vlan = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.supports_regdb = false,
 		.fix_l1ss = true,
@@ -150,6 +151,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
 		.supports_suspend = false,
+		.supports_ap_vlan = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.supports_regdb = false,
 		.fix_l1ss = true,
@@ -213,6 +215,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
 		.supports_suspend = true,
+		.supports_ap_vlan = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.supports_regdb = true,
 		.fix_l1ss = true,
@@ -276,6 +279,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.num_vdevs = 8,
 		.num_peers = 128,
 		.supports_suspend = false,
+		.supports_ap_vlan = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.supports_regdb = false,
 		.fix_l1ss = true,
@@ -339,6 +343,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
 		.supports_suspend = true,
+		.supports_ap_vlan = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.supports_regdb = true,
 		.fix_l1ss = false,
@@ -401,6 +406,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
 		.supports_suspend = true,
+		.supports_ap_vlan = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.supports_regdb = true,
 		.fix_l1ss = false,
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 91d6244..211a604 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -78,6 +78,44 @@ enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher)
 	}
 }
 
+#define HTT_META_DATA_ALIGNMENT    0x8
+
+static int ath11k_dp_metadata_align_skb(struct sk_buff *skb, u8 align_len)
+{
+	if (unlikely(skb_cow_head(skb, align_len)))
+		return -ENOMEM;
+
+	skb_push(skb, align_len);
+	memset(skb->data, 0, align_len);
+	return 0;
+}
+
+static int ath11k_dp_prepare_htt_metadata(struct sk_buff *skb,
+					  u8 *htt_metadata_size)
+{
+	u8 htt_desc_size;
+	/* Size rounded of multiple of 8 bytes */
+	u8 htt_desc_size_aligned;
+	struct htt_tx_msdu_desc_ext *desc_ext;
+	int ret;
+
+	htt_desc_size = sizeof(*desc_ext);
+	htt_desc_size_aligned = ALIGN(htt_desc_size, HTT_META_DATA_ALIGNMENT);
+
+	ret = ath11k_dp_metadata_align_skb(skb, htt_desc_size_aligned);
+	if (unlikely(ret))
+		return ret;
+
+	desc_ext = (struct htt_tx_msdu_desc_ext *)skb->data;
+	desc_ext->info0 =
+		__cpu_to_le32(FIELD_PREP(HTT_TX_MSDU_DESC_INFO0_VALID_ENCRYPT_TYPE, 1) |
+			      FIELD_PREP(HTT_TX_MSDU_DESC_INFO0_ENCRYPT_TYPE, 0) |
+			      FIELD_PREP(HTT_TX_MSDU_DESC_INFO0_HOST_TX_DESC_POOL, 1));
+	*htt_metadata_size = htt_desc_size_aligned;
+
+	return 0;
+}
+
 int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 struct ath11k_sta *arsta, struct sk_buff *skb)
 {
@@ -95,6 +133,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	int ret;
 	u8 ring_selector = 0, ring_map = 0;
 	bool tcl_ring_retry;
+	u8 align_pad, htt_meta_size = 0;
 
 	if (unlikely(test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags)))
 		return -ESHUTDOWN;
@@ -211,15 +250,42 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		goto fail_remove_idr;
 	}
 
+	/* Add metadata for sw encrypted vlan group traffic */
+	if (!test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
+	    !info->control.hw_key &&
+	    ieee80211_has_protected(hdr->frame_control)) {
+		/* HW requirement is that metadata should always point to a
+		 * 8-byte aligned address. So we add alignment pad to start of
+		 * buffer. HTT Metadata should be ensured to be multiple of 8-bytes
+		 *  to get 8-byte aligned start address along with align_pad added
+		 */
+		align_pad = ((unsigned long)skb->data) & (HTT_META_DATA_ALIGNMENT - 1);
+		ret = ath11k_dp_metadata_align_skb(skb, align_pad);
+		if (unlikely(ret))
+			goto fail_remove_idr;
+
+		ti.pkt_offset += align_pad;
+		ret = ath11k_dp_prepare_htt_metadata(skb, &htt_meta_size);
+		if (unlikely(ret))
+			goto fail_pull_skb;
+
+		ti.pkt_offset += htt_meta_size;
+		ti.meta_data_flags |= HTT_TCL_META_DATA_VALID_HTT;
+		ti.flags0 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_TO_FW, 1);
+		ti.encap_type = HAL_TCL_ENCAP_TYPE_RAW;
+		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
+	}
+
 	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(ab->dev, ti.paddr))) {
 		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 		ath11k_warn(ab, "failed to DMA map data Tx buffer\n");
 		ret = -ENOMEM;
-		goto fail_remove_idr;
+		goto fail_pull_skb;
 	}
 
-	ti.data_len = skb->len;
+	ti.data_len = skb->len - ti.pkt_offset;
 	skb_cb->paddr = ti.paddr;
 	skb_cb->vif = arvif->vif;
 	skb_cb->ar = ar;
@@ -274,6 +340,10 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 fail_unmap_dma:
 	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
 
+fail_pull_skb:
+	if (ti.pkt_offset)
+		skb_pull(skb, ti.pkt_offset);
+
 fail_remove_idr:
 	spin_lock_bh(&tx_ring->tx_idr_lock);
 	idr_remove(&tx_ring->txbuf_idr,
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
index e87d65b..95f8757 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
@@ -15,6 +15,20 @@ struct ath11k_dp_htt_wbm_tx_status {
 	int ack_rssi;
 };
 
+#define HTT_TX_MSDU_DESC_INFO0_VALID_ENCRYPT_TYPE	BIT(8)
+#define HTT_TX_MSDU_DESC_INFO0_ENCRYPT_TYPE		GENMASK(16, 15)
+#define HTT_TX_MSDU_DESC_INFO0_HOST_TX_DESC_POOL	BIT(31)
+
+struct htt_tx_msdu_desc_ext {
+	__le32 info0;
+	__le32 info1;
+	__le32 info2;
+	__le32 info3;
+	__le32 info4;
+	__le32 info5;
+	__le32 info6;
+} __packed;
+
 void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts);
 int ath11k_dp_tx_htt_h2t_ver_req_msg(struct ath11k_base *ab);
 int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 29934b3..dfe8d4c 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -181,6 +181,7 @@ struct ath11k_hw_params {
 	u32 num_vdevs;
 	u32 num_peers;
 	bool supports_suspend;
+	bool supports_ap_vlan;
 	u32 hal_desc_sz;
 	bool supports_regdb;
 	bool fix_l1ss;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07f499d..b035e29 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8469,6 +8469,11 @@ static int __ath11k_mac_register(struct ath11k *ar)
 		 */
 		ar->hw->wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
 
+	if (ab->hw_params.supports_ap_vlan) {
+		ar->hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP_VLAN);
+		ar->hw->wiphy->software_iftypes |= BIT(NL80211_IFTYPE_AP_VLAN);
+	}
+
 	/* Apply the regd received during initialization */
 	ret = ath11k_regd_update(ar);
 	if (ret) {
-- 
2.7.4

