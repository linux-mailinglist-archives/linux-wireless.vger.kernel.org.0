Return-Path: <linux-wireless+bounces-7259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D088BD820
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 01:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413A7B2202B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D415B126;
	Mon,  6 May 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JrYXxXx8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35E132C1C
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037495; cv=none; b=PdpuIGwgVT0Woe0XkfhUh462zq5UZ8F47XxVIAJ+3Q30Iu1IR3lLlPDF/px+2sucxnsU0OtGSFrKWAyPniYlDD+yfH0YC7z4n5ojsu0p+5OPF51O5KxL9qD7BWezttI3hdKmJImLNfjfoCREJoY7RgUJ+VBKGXrBM9VceE8AKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037495; c=relaxed/simple;
	bh=yNEJUHp7YmsyZbZI2eLJ3KfwmGPdkW1BbZFJ+46ye0w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f2SM4mhnO0Nqrk8PEzfTmBfMKptQoi77ObyU5tAxhc4SY5aMwx+SOzG7YBuJPGwThzMwcQik4iUFXA8t1Dzo7e1mzUBi+Qpd/Hl0/TklP4s12NbAMYRAv5sCVBLYEZYyqFElbX6VtBuNCU6FLiKdmGuOfyHUUV7v9kL9Bzuuf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JrYXxXx8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446MWJO1023824;
	Mon, 6 May 2024 23:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=P5EUndn
	OkQh9AQNB/pesB358zdmpfK2xqtxUJXvDrdE=; b=JrYXxXx896B8QNQKOw0o0WR
	TFgHuUuA2ONN92vQdiMmVbVaw9GynbK78hrFX6qJBZ6Av1KHeEealA191EFck2Sw
	mnrQmXv6HVcH5cQSB4o4TEJOlviCnCMj+zdJE5HoY3OsmYnfgpccCeSVq9FPmHU0
	JoxWn1nSBcokrGBcqxvVoSsIJPed3cQpvsFDYGT1ubUcEdKu4Y8Z9zbQDlLRCMqz
	PC0It3U+E22bB36bEThR7BB1MKjPsP2+hMCMUxONZhyl/loMhdrVQbK1czunw2NY
	8x4malUqID0eWbMrJQNTQJej/r2zzJuMx6DXNG+UJnqd5pobYhIwaUCW7rI02Bw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxxj1h947-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 23:18:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446NI5o4002183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 23:18:05 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 May 2024 16:18:05 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH] wifi: ath12k: Add Dynamic VLAN support
Date: Mon, 6 May 2024 16:17:52 -0700
Message-ID: <20240506231752.942567-1-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: InGLVV6XD9UlxdEtsOln4T6rYS9bHgUB
X-Proofpoint-ORIG-GUID: InGLVV6XD9UlxdEtsOln4T6rYS9bHgUB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_17,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 clxscore=1011 adultscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060169

Add support for dynamic VLAN. VLAN group traffic is encapsulated and
encrypted in mac80211 and driver needs to set flags for the VLAN group
traffic to skip hardware encapsulation and encryption.

VLAN group traffic utilizes ext MSDU and HTT Metadata to set
encapsulation type to RAW and encryption type to OPEN in order to
inform firmware to skip hardware encapsulation and encryption.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c    | 60 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/hal_desc.h | 25 +++++++++
 drivers/net/wireless/ath/ath12k/hw.c       |  6 ++-
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index a7c7a868c14c..2a7c312ad3f9 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -124,6 +124,44 @@ static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
 						 HAL_TX_MSDU_EXT_INFO1_ENCRYPT_TYPE);
 }
 
+#define HTT_META_DATA_ALIGNMENT 0x8
+
+static void *ath12k_dp_metadata_align_skb(struct sk_buff *skb, u8 tail_len)
+{
+	struct sk_buff *tail;
+	void *metadata;
+
+	if (unlikely(skb_cow_data(skb, tail_len, &tail) < 0))
+		return NULL;
+
+	metadata = pskb_put(skb, tail, tail_len);
+	memset(metadata, 0, tail_len);
+	return metadata;
+}
+
+/* Preparing HTT Metadata when utilized with ext MSDU */
+static int ath12k_dp_prepare_htt_metadata(struct sk_buff *skb)
+{
+	struct hal_tx_msdu_metadata *desc_ext;
+	u8 htt_desc_size;
+	/* Size rounded of multiple of 8 bytes */
+	u8 htt_desc_size_aligned;
+
+	htt_desc_size = sizeof(struct hal_tx_msdu_metadata);
+	htt_desc_size_aligned = ALIGN(htt_desc_size, HTT_META_DATA_ALIGNMENT);
+
+	desc_ext = ath12k_dp_metadata_align_skb(skb, htt_desc_size_aligned);
+	if (!desc_ext)
+		return -ENOMEM;
+
+	desc_ext->info0 = le32_encode_bits(1, HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_FLAG) |
+			  le32_encode_bits(0, HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_TYPE) |
+			  le32_encode_bits(1,
+					   HAL_TX_MSDU_METADATA_INFO0_HOST_TX_DESC_POOL);
+
+	return 0;
+}
+
 int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 		 struct sk_buff *skb)
 {
@@ -145,6 +183,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 	u8 ring_selector, ring_map = 0;
 	bool tcl_ring_retry;
 	bool msdu_ext_desc = false;
+	bool add_htt_metadata = false;
 
 	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
@@ -248,6 +287,18 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 		goto fail_remove_tx_buf;
 	}
 
+	if (!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	    !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
+	    !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
+	    ieee80211_has_protected(hdr->frame_control)) {
+		/* Add metadata for sw encrypted vlan group traffic */
+		add_htt_metadata = true;
+		msdu_ext_desc = true;
+		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
+		ti.encap_type = HAL_TCL_ENCAP_TYPE_RAW;
+		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
+	}
+
 	tx_desc->skb = skb;
 	tx_desc->mac_id = ar->pdev_idx;
 	ti.desc_id = tx_desc->desc_id;
@@ -269,6 +320,15 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 		msg = (struct hal_tx_msdu_ext_desc *)skb_ext_desc->data;
 		ath12k_hal_tx_cmd_ext_desc_setup(ab, msg, &ti);
 
+		if (add_htt_metadata) {
+			ret = ath12k_dp_prepare_htt_metadata(skb_ext_desc);
+			if (ret < 0) {
+				ath12k_dbg(ab, ATH12K_DBG_DP_TX,
+					   "Failed to add HTT meta data, dropping packet\n");
+				goto fail_unmap_dma;
+			}
+		}
+
 		ti.paddr = dma_map_single(ab->dev, skb_ext_desc->data,
 					  skb_ext_desc->len, DMA_TO_DEVICE);
 		ret = dma_mapping_error(ab->dev, ti.paddr);
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 814c02f876d6..3e472e0edbcb 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -2984,4 +2984,29 @@ struct hal_mon_dest_desc {
  *	updated by SRNG.
  */
 
+#define HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_FLAG		BIT(8)
+#define HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_TYPE		GENMASK(16, 15)
+#define HAL_TX_MSDU_METADATA_INFO0_HOST_TX_DESC_POOL	BIT(31)
+
+struct hal_tx_msdu_metadata {
+	__le32 info0;
+	__le32 rsvd3[6];
+} __packed;
+
+/* hal_tx_msdu_metadata
+ * valid_encrypt_type
+ *		if set, encrypt type is valid
+ * encrypt_type
+ *		0 = NO_ENCRYPT,
+ *		1 = ENCRYPT,
+ *		2 ~ 3 - Reserved
+ * host_tx_desc_pool
+ *		If set, Firmware allocates tx_descriptors
+ *		in WAL_BUFFERID_TX_HOST_DATA_EXP,instead
+ *		of WAL_BUFFERID_TX_TCL_DATA_EXP.
+ *		Use cases:
+ *		Any time firmware uses TQM-BYPASS for Data
+ *		TID, firmware expect host to set this bit.
+ */
+
 #endif /* ATH12K_HAL_DESC_H */
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index f4c827015821..e089e08408af 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -891,7 +891,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP) |
-					BIT(NL80211_IFTYPE_MESH_POINT),
+					BIT(NL80211_IFTYPE_MESH_POINT) |
+					BIT(NL80211_IFTYPE_AP_VLAN),
 		.supports_monitor = false,
 
 		.idle_ps = false,
@@ -1036,7 +1037,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP) |
-					BIT(NL80211_IFTYPE_MESH_POINT),
+					BIT(NL80211_IFTYPE_MESH_POINT) |
+					BIT(NL80211_IFTYPE_AP_VLAN),
 		.supports_monitor = false,
 
 		.idle_ps = false,
-- 
2.34.1


