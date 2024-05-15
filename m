Return-Path: <linux-wireless+bounces-7718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05F68C6CDF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 21:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CA71F210A6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16ED3BBD4;
	Wed, 15 May 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fKjkob5K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035823219F
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801336; cv=none; b=EyVX+GUC6oF6yNI/wmAs8jpjB3txnRFPA1HEpJgOtYz36Mvq3B9hhdzwo/HkgmDC27zC1RZYldCiU/CFaqtn7Nt8HBn6WwT9eW0APNsJqWoSq2NQvKtqUEgUSYmT9mZbFazK878oegtDhGTFtGAzLzkYQd83T0GiQgq2Vm8k58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801336; c=relaxed/simple;
	bh=lK3mwzXWQUTlaPCb4A9K5qLO6+7bApyP9qEMTEpvAmM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESGpm5IhUASmjl8RgQUPjTRWTmwRnp6gIwkU1fwx9Unzo+od5db0mIC+YYeQag8Vq3owqD+TflSnriHGjgPzq8y6ESMQ3j7faFXJqeFU14/CB4V4SWGopaiEnH08rWhKXqoI/yu7eeaT1IexhnG5nobXg6uFj5CcM+LiuGH1A04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fKjkob5K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FIOVqq021782;
	Wed, 15 May 2024 19:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=cHo15Pf
	/w2P+bJNHNdCciijo+wFZi3KNT4QmJCoIoEk=; b=fKjkob5KksiSdygJe/r1CV2
	jBpB/m/a/Akay/Om46GuVkqFTTjgHK/gu9V+cPmo1PqeJzoYrjpqGWNpmMe0mL+q
	9skMn5B12strUAhxbcmkRkrMui8zL+Mk6CTHcCMC2W2KED740zTY2MUk/5WxAoJ/
	NAx2V346YDx0FZxuQFKcf1ImnhghnlJZ+CYdbab+WCQGKlLi/DvHUzXqqsrhKk/9
	2klP37uv7VpizUCiXdJtcCEN6DALnPeQzyODcoUXxwCmWqc/SOr2eP1uUmqBIxGD
	oTmGuNuFqVc+cMEuXSGU6WMn9SwdSRqppLA649s9pug4BGp4qwvHQzo9pMgywOA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y45vbc06k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 19:28:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FJSjQK018217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 19:28:45 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 12:28:44 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: Add Dynamic VLAN support
Date: Wed, 15 May 2024 12:28:30 -0700
Message-ID: <20240515192830.995013-1-quic_msinada@quicinc.com>
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
X-Proofpoint-GUID: 2kz3jVPqML9wMaiuz_jp1nSI_TiiOpdR
X-Proofpoint-ORIG-GUID: 2kz3jVPqML9wMaiuz_jp1nSI_TiiOpdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_12,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150138

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
v2: rename rsvd3 to rsvd0

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
index 814c02f876d6..02b7db06b24e 100644
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
+	__le32 rsvd0[6];
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


