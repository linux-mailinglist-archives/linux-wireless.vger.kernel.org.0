Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF4F37ABD3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhEKQYY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 12:24:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23522 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhEKQYV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 12:24:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620750194; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pQwCwJWEhZma3f+oKYFsF3f4tDxqU+4kJj6JEMfHSGo=; b=YiSmrxFUQAyrsyTBIEYZSjECBouYV/zxKhxDrAM/uSWUZ83A1JhTEctN9Iwc4AtzWHPLSqVi
 iLOMtCChCGvhZqA7Z7YKHcg/ETGMq+6u+c87XgMKn3toM5/fJi0PCWM3L3VLaJWnOOGRnOE7
 A8FLEjmYRoitBDe5UwtjFufF3iE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 609aaf61aaabe992f2ea87ba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 May 2021 16:22:57
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9012AC43149; Tue, 11 May 2021 16:22:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-96-12-nat.elisa-mobile.fi [85.76.96.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22B91C433D3;
        Tue, 11 May 2021 16:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22B91C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/7] ath11k: add dp support for WCN6855
Date:   Tue, 11 May 2021 19:22:09 +0300
Message-Id: <20210511162214.29475-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511162214.29475-1-jouni@codeaurora.org>
References: <20210511162214.29475-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

hal rx descriptor is different for WCN6855 and there are such a lot
of handlers processing this descriptor in data path. So add separate
handling for this target.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hw.c      | 201 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h      |   1 +
 drivers/net/wireless/ath/ath11k/rx_desc.h |  87 ++++++++++
 3 files changed, 289 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index d9d7c4608052..023047df954c 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -45,6 +45,13 @@ static void ath11k_hw_qcn9074_tx_mesh_enable(struct ath11k_base *ab,
 				     true);
 }
 
+static void ath11k_hw_wcn6855_tx_mesh_enable(struct ath11k_base *ab,
+					     struct hal_tcl_data_cmd *tcl_cmd)
+{
+	tcl_cmd->info3 |= FIELD_PREP(HAL_QCN9074_TCL_DATA_CMD_INFO3_MESH_ENABLE,
+				     true);
+}
+
 static void ath11k_init_wmi_config_qca6390(struct ath11k_base *ab,
 					   struct target_resource_config *config)
 {
@@ -489,6 +496,166 @@ static u8 *ath11k_hw_qcn9074_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
 	return &desc->u.qcn9074.msdu_payload[0];
 }
 
+static bool ath11k_hw_wcn6855_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MSDU_END_INFO2_FIRST_MSDU_WCN6855,
+			   __le32_to_cpu(desc->u.wcn6855.msdu_end.info2));
+}
+
+static bool ath11k_hw_wcn6855_rx_desc_get_last_msdu(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MSDU_END_INFO2_LAST_MSDU_WCN6855,
+			   __le32_to_cpu(desc->u.wcn6855.msdu_end.info2));
+}
+
+static u8 ath11k_hw_wcn6855_rx_desc_get_l3_pad_bytes(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_END_INFO2_L3_HDR_PADDING,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_end.info2));
+}
+
+static u8 *ath11k_hw_wcn6855_rx_desc_get_hdr_status(struct hal_rx_desc *desc)
+{
+	return desc->u.wcn6855.hdr_status;
+}
+
+static bool ath11k_hw_wcn6855_rx_desc_encrypt_valid(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.wcn6855.mpdu_start.info1) &
+	       RX_MPDU_START_INFO1_ENCRYPT_INFO_VALID;
+}
+
+static u32 ath11k_hw_wcn6855_rx_desc_get_encrypt_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO2_ENC_TYPE,
+			 __le32_to_cpu(desc->u.wcn6855.mpdu_start.info2));
+}
+
+static u8 ath11k_hw_wcn6855_rx_desc_get_decap_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_DECAP_FORMAT,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info2));
+}
+
+static u8 ath11k_hw_wcn6855_rx_desc_get_mesh_ctl(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO2_MESH_CTRL_PRESENT,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info2));
+}
+
+static bool ath11k_hw_wcn6855_rx_desc_get_mpdu_seq_ctl_vld(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_CTRL_VALID,
+			   __le32_to_cpu(desc->u.wcn6855.mpdu_start.info1));
+}
+
+static bool ath11k_hw_wcn6855_rx_desc_get_mpdu_fc_valid(struct hal_rx_desc *desc)
+{
+	return !!FIELD_GET(RX_MPDU_START_INFO1_MPDU_FCTRL_VALID,
+			   __le32_to_cpu(desc->u.wcn6855.mpdu_start.info1));
+}
+
+static u16 ath11k_hw_wcn6855_rx_desc_get_mpdu_start_seq_no(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO1_MPDU_SEQ_NUM,
+			 __le32_to_cpu(desc->u.wcn6855.mpdu_start.info1));
+}
+
+static u16 ath11k_hw_wcn6855_rx_desc_get_msdu_len(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO1_MSDU_LENGTH,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info1));
+}
+
+static u8 ath11k_hw_wcn6855_rx_desc_get_msdu_sgi(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_SGI,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info3));
+}
+
+static u8 ath11k_hw_wcn6855_rx_desc_get_msdu_rate_mcs(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_RATE_MCS,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info3));
+}
+
+static u8 ath11k_hw_wcn6855_rx_desc_get_msdu_rx_bw(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_RECV_BW,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info3));
+}
+
+static u32 ath11k_hw_wcn6855_rx_desc_get_msdu_freq(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.wcn6855.msdu_start.phy_meta_data);
+}
+
+static u8 ath11k_hw_wcn6855_rx_desc_get_msdu_pkt_type(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_PKT_TYPE,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info3));
+}
+
+static u8 ath11k_hw_wcn6855_rx_desc_get_msdu_nss(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MSDU_START_INFO3_MIMO_SS_BITMAP,
+			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info3));
+}
+
+static u8 ath11k_hw_wcn6855_rx_desc_get_mpdu_tid(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(RX_MPDU_START_INFO2_TID_WCN6855,
+			 __le32_to_cpu(desc->u.wcn6855.mpdu_start.info2));
+}
+
+static u16 ath11k_hw_wcn6855_rx_desc_get_mpdu_peer_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.wcn6855.mpdu_start.sw_peer_id);
+}
+
+static void ath11k_hw_wcn6855_rx_desc_copy_attn_end(struct hal_rx_desc *fdesc,
+						    struct hal_rx_desc *ldesc)
+{
+	memcpy((u8 *)&fdesc->u.wcn6855.msdu_end, (u8 *)&ldesc->u.wcn6855.msdu_end,
+	       sizeof(struct rx_msdu_end_wcn6855));
+	memcpy((u8 *)&fdesc->u.wcn6855.attention, (u8 *)&ldesc->u.wcn6855.attention,
+	       sizeof(struct rx_attention));
+	memcpy((u8 *)&fdesc->u.wcn6855.mpdu_end, (u8 *)&ldesc->u.wcn6855.mpdu_end,
+	       sizeof(struct rx_mpdu_end));
+}
+
+static u32 ath11k_hw_wcn6855_rx_desc_get_mpdu_start_tag(struct hal_rx_desc *desc)
+{
+	return FIELD_GET(HAL_TLV_HDR_TAG,
+			 __le32_to_cpu(desc->u.wcn6855.mpdu_start_tag));
+}
+
+static u32 ath11k_hw_wcn6855_rx_desc_get_mpdu_ppdu_id(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.wcn6855.mpdu_start.phy_ppdu_id);
+}
+
+static void ath11k_hw_wcn6855_rx_desc_set_msdu_len(struct hal_rx_desc *desc, u16 len)
+{
+	u32 info = __le32_to_cpu(desc->u.wcn6855.msdu_start.info1);
+
+	info &= ~RX_MSDU_START_INFO1_MSDU_LENGTH;
+	info |= FIELD_PREP(RX_MSDU_START_INFO1_MSDU_LENGTH, len);
+
+	desc->u.wcn6855.msdu_start.info1 = __cpu_to_le32(info);
+}
+
+static
+struct rx_attention *ath11k_hw_wcn6855_rx_desc_get_attention(struct hal_rx_desc *desc)
+{
+	return &desc->u.wcn6855.attention;
+}
+
+static u8 *ath11k_hw_wcn6855_rx_desc_get_msdu_payload(struct hal_rx_desc *desc)
+{
+	return &desc->u.wcn6855.msdu_payload[0];
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
@@ -625,6 +792,40 @@ const struct ath11k_hw_ops qcn9074_ops = {
 	.rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
 };
 
+const struct ath11k_hw_ops wcn6855_ops = {
+	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
+	.wmi_init_config = ath11k_init_wmi_config_qca6390,
+	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_qca6390,
+	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_qca6390,
+	.tx_mesh_enable = ath11k_hw_wcn6855_tx_mesh_enable,
+	.rx_desc_get_first_msdu = ath11k_hw_wcn6855_rx_desc_get_first_msdu,
+	.rx_desc_get_last_msdu = ath11k_hw_wcn6855_rx_desc_get_last_msdu,
+	.rx_desc_get_l3_pad_bytes = ath11k_hw_wcn6855_rx_desc_get_l3_pad_bytes,
+	.rx_desc_get_hdr_status = ath11k_hw_wcn6855_rx_desc_get_hdr_status,
+	.rx_desc_encrypt_valid = ath11k_hw_wcn6855_rx_desc_encrypt_valid,
+	.rx_desc_get_encrypt_type = ath11k_hw_wcn6855_rx_desc_get_encrypt_type,
+	.rx_desc_get_decap_type = ath11k_hw_wcn6855_rx_desc_get_decap_type,
+	.rx_desc_get_mesh_ctl = ath11k_hw_wcn6855_rx_desc_get_mesh_ctl,
+	.rx_desc_get_mpdu_seq_ctl_vld = ath11k_hw_wcn6855_rx_desc_get_mpdu_seq_ctl_vld,
+	.rx_desc_get_mpdu_fc_valid = ath11k_hw_wcn6855_rx_desc_get_mpdu_fc_valid,
+	.rx_desc_get_mpdu_start_seq_no = ath11k_hw_wcn6855_rx_desc_get_mpdu_start_seq_no,
+	.rx_desc_get_msdu_len = ath11k_hw_wcn6855_rx_desc_get_msdu_len,
+	.rx_desc_get_msdu_sgi = ath11k_hw_wcn6855_rx_desc_get_msdu_sgi,
+	.rx_desc_get_msdu_rate_mcs = ath11k_hw_wcn6855_rx_desc_get_msdu_rate_mcs,
+	.rx_desc_get_msdu_rx_bw = ath11k_hw_wcn6855_rx_desc_get_msdu_rx_bw,
+	.rx_desc_get_msdu_freq = ath11k_hw_wcn6855_rx_desc_get_msdu_freq,
+	.rx_desc_get_msdu_pkt_type = ath11k_hw_wcn6855_rx_desc_get_msdu_pkt_type,
+	.rx_desc_get_msdu_nss = ath11k_hw_wcn6855_rx_desc_get_msdu_nss,
+	.rx_desc_get_mpdu_tid = ath11k_hw_wcn6855_rx_desc_get_mpdu_tid,
+	.rx_desc_get_mpdu_peer_id = ath11k_hw_wcn6855_rx_desc_get_mpdu_peer_id,
+	.rx_desc_copy_attn_end_tlv = ath11k_hw_wcn6855_rx_desc_copy_attn_end,
+	.rx_desc_get_mpdu_start_tag = ath11k_hw_wcn6855_rx_desc_get_mpdu_start_tag,
+	.rx_desc_get_mpdu_ppdu_id = ath11k_hw_wcn6855_rx_desc_get_mpdu_ppdu_id,
+	.rx_desc_set_msdu_len = ath11k_hw_wcn6855_rx_desc_set_msdu_len,
+	.rx_desc_get_attention = ath11k_hw_wcn6855_rx_desc_get_attention,
+	.rx_desc_get_msdu_payload = ath11k_hw_wcn6855_rx_desc_get_msdu_payload,
+};
+
 #define ATH11K_TX_RING_MASK_0 0x1
 #define ATH11K_TX_RING_MASK_1 0x2
 #define ATH11K_TX_RING_MASK_2 0x4
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 4e7261c0dca1..6e924f628f22 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -205,6 +205,7 @@ extern const struct ath11k_hw_ops ipq8074_ops;
 extern const struct ath11k_hw_ops ipq6018_ops;
 extern const struct ath11k_hw_ops qca6390_ops;
 extern const struct ath11k_hw_ops qcn9074_ops;
+extern const struct ath11k_hw_ops wcn6855_ops;
 
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
diff --git a/drivers/net/wireless/ath/ath11k/rx_desc.h b/drivers/net/wireless/ath/ath11k/rx_desc.h
index 0cdb4a1f816e..79c50804d7dc 100644
--- a/drivers/net/wireless/ath/ath11k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath11k/rx_desc.h
@@ -368,6 +368,7 @@ struct rx_attention {
 #define RX_MPDU_START_INFO2_BSSID_HIT		BIT(9)
 #define RX_MPDU_START_INFO2_BSSID_NUM		GENMASK(13, 10)
 #define RX_MPDU_START_INFO2_TID			GENMASK(17, 14)
+#define RX_MPDU_START_INFO2_TID_WCN6855		GENMASK(18, 15)
 
 #define RX_MPDU_START_INFO3_REO_DEST_IND		GENMASK(4, 0)
 #define RX_MPDU_START_INFO3_FLOW_ID_TOEPLITZ		BIT(7)
@@ -546,6 +547,31 @@ struct rx_mpdu_start_qcn9074 {
 	__le32 ht_ctrl;
 } __packed;
 
+struct rx_mpdu_start_wcn6855 {
+	__le32 info3;
+	__le32 reo_queue_desc_lo;
+	__le32 info4;
+	__le32 pn[4];
+	__le32 info2;
+	__le32 peer_meta_data;
+	__le16 info0;
+	__le16 phy_ppdu_id;
+	__le16 ast_index;
+	__le16 sw_peer_id;
+	__le32 info1;
+	__le32 info5;
+	__le32 info6;
+	__le16 frame_ctrl;
+	__le16 duration;
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	__le16 seq_ctrl;
+	u8 addr4[ETH_ALEN];
+	__le16 qos_ctrl;
+	__le32 ht_ctrl;
+} __packed;
+
 /* rx_mpdu_start
  *
  * rxpcu_mpdu_filter_in_category
@@ -804,6 +830,20 @@ struct rx_msdu_start_qcn9074 {
 	__le16 vlan_stag_c1;
 } __packed;
 
+struct rx_msdu_start_wcn6855 {
+	__le16 info0;
+	__le16 phy_ppdu_id;
+	__le32 info1;
+	__le32 info2;
+	__le32 toeplitz_hash;
+	__le32 flow_id_toeplitz;
+	__le32 info3;
+	__le32 ppdu_start_timestamp;
+	__le32 phy_meta_data;
+	__le16 vlan_ctag_ci;
+	__le16 vlan_stag_ci;
+} __packed;
+
 /* rx_msdu_start
  *
  * rxpcu_mpdu_filter_in_category
@@ -988,7 +1028,9 @@ struct rx_msdu_start_qcn9074 {
 
 #define RX_MSDU_END_INFO2_REPORTED_MPDU_LEN	GENMASK(13, 0)
 #define RX_MSDU_END_INFO2_FIRST_MSDU		BIT(14)
+#define RX_MSDU_END_INFO2_FIRST_MSDU_WCN6855	BIT(28)
 #define RX_MSDU_END_INFO2_LAST_MSDU		BIT(15)
+#define RX_MSDU_END_INFO2_LAST_MSDU_WCN6855	BIT(29)
 #define RX_MSDU_END_INFO2_SA_IDX_TIMEOUT	BIT(16)
 #define RX_MSDU_END_INFO2_DA_IDX_TIMEOUT	BIT(17)
 #define RX_MSDU_END_INFO2_MSDU_LIMIT_ERR	BIT(18)
@@ -1037,6 +1079,31 @@ struct rx_msdu_end_ipq8074 {
 	__le16 sa_sw_peer_id;
 } __packed;
 
+struct rx_msdu_end_wcn6855 {
+	__le16 info0;
+	__le16 phy_ppdu_id;
+	__le16 ip_hdr_cksum;
+	__le16 reported_mpdu_len;
+	__le32 info1;
+	__le32 ext_wapi_pn[2];
+	__le32 info4;
+	__le32 ipv6_options_crc;
+	__le32 tcp_seq_num;
+	__le32 tcp_ack_num;
+	__le16 info3;
+	__le16 window_size;
+	__le32 info2;
+	__le16 sa_idx;
+	__le16 da_idx;
+	__le32 info5;
+	__le32 fse_metadata;
+	__le16 cce_metadata;
+	__le16 sa_sw_peer_id;
+	__le32 rule_indication[2];
+	__le32 info6;
+	__le32 info7;
+} __packed;
+
 #define RX_MSDU_END_MPDU_LENGTH_INFO		GENMASK(13, 0)
 
 #define RX_MSDU_END_INFO2_DA_OFFSET		GENMASK(5, 0)
@@ -1400,10 +1467,30 @@ struct hal_rx_desc_qcn9074 {
 	u8 msdu_payload[0];
 } __packed;
 
+struct hal_rx_desc_wcn6855 {
+	__le32 msdu_end_tag;
+	struct rx_msdu_end_wcn6855 msdu_end;
+	__le32 rx_attn_tag;
+	struct rx_attention attention;
+	__le32 msdu_start_tag;
+	struct rx_msdu_start_wcn6855 msdu_start;
+	u8 rx_padding0[HAL_RX_DESC_PADDING0_BYTES];
+	__le32 mpdu_start_tag;
+	struct rx_mpdu_start_wcn6855 mpdu_start;
+	__le32 mpdu_end_tag;
+	struct rx_mpdu_end mpdu_end;
+	u8 rx_padding1[HAL_RX_DESC_PADDING1_BYTES];
+	__le32 hdr_status_tag;
+	__le32 phy_ppdu_id;
+	u8 hdr_status[HAL_RX_DESC_HDR_STATUS_LEN];
+	u8 msdu_payload[0];
+} __packed;
+
 struct hal_rx_desc {
 	union {
 		struct hal_rx_desc_ipq8074 ipq8074;
 		struct hal_rx_desc_qcn9074 qcn9074;
+		struct hal_rx_desc_wcn6855 wcn6855;
 	} u;
 } __packed;
 
-- 
2.25.1

