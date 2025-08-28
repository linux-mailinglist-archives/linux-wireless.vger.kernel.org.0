Return-Path: <linux-wireless+bounces-26826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181A4B3A84A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A60A036E4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D0433768B;
	Thu, 28 Aug 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kXsKJH4F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16733CEB5
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402599; cv=none; b=Nh2Xk2dmz28+dEHvRFn67kgABAzBTLKT25jreBfRv8TyzDG34BVKa+b4N+wVHeoCA3jwwicWzXsIrUbZSXl3nO5D6ngPSmZRnt8l8gVzhibUwQ3cKmohLfzjou6AZCwgAoOuym2fRyIwCOxiIIyM5i85f8duQZ55RAtgFvO62yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402599; c=relaxed/simple;
	bh=DJACJWcnD0QuDbDk8Jxn1KBcJD0kigrhhVDKcnSHDL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5+HEFfdOs2n0Wm2Dx9EWckeBg3/OXl6H4zThmjc2MhnpKFaa2dk9Gm2upijY4edmPB8gp5PXiBOWnAjXHtAoURIurZCQbM4Gpmvm9FOQbCIl9WTbzhyy7mPvPCHNcx3p3Lfaq2Cf494/dxEvUKZcz9Tt/hVP+Og+PmvLcd6dM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kXsKJH4F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SE2k3w029258;
	Thu, 28 Aug 2025 17:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	By4abRl/nSq0BPzOsNwcLVkGNLd/yH91AzIYYVBkEwo=; b=kXsKJH4F9R8ijWIZ
	gVnjV2VTi83Lrgq0jgHXfA0uvAIrI//8WLTaJDDoWLn6GlghgI0p0x1rjeKoIXaa
	/cAK/BKlwuN9Ggf6IDtOcHgQuDKhvRT85QZfiChViLRmo76GCnyBnlfUmP0OP/bI
	+FH40W4V0EyInWXGQFZd1FfoG/6Z2IegRzPYtfB1ETjRCpaDfrPH9Kuuu8nANail
	oEf4ouNdih7uLKwy0Nbyd0YHDsFJ5jJPGXU0uv8y1CrYVH21q5Yh++eQ5kLzlBLV
	LYzysBfU1BhkXneD/M/yTXFXDZdgm2jt7uFhQ3tfMk/o4EgQHHr6ewbmCahQXeHv
	FjOSMw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w31b2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaYxf009077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:34 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:33 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 16/20] wifi: ath12k: Move ath12k_dp_tx and related APIs to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:49 +0530
Message-ID: <20250828173553.3341351-17-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68b093a3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=7SphimUZNnBotK8wGKYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXwqVDzmb6ryML
 TTXc0G5y6DulCCisBVNiVk6xV/6ABxuVnUtxWAQuSkdOcZ0YtPtMjf+QogxUaR0zDRLGleK75wk
 FV8Al0Q0iRimQ0pgCGjJ8lj9PXrl3P+a7eoNfjii0rv/K1+c93ROyJDIKrjb+3G/+EwTsRVgPzf
 D6Kyy/45HeijoLV2OKUEWBO/AMulVTowR06U8BqGM7kOKVW7k+Whuxm67pMBaALNQ5QUduYV29T
 IZyX1icSzoBaYy6pD1OF5nQZku6u/w0Dj8bygPAAwxWuzmex/0B+x5lFxWS7pwIVJ3G+s0uD6G6
 spQayM8v3AEgxNZfdI2NZAeg1d1kXDDKOYhEtvCpl5rgcULnqeH1YBAbJS/YRxHZW+Xw4KYokUm
 HDqS98/k
X-Proofpoint-GUID: OUZnk8Dyl13KzWds7le65oyGLG2pU5N7
X-Proofpoint-ORIG-GUID: OUZnk8Dyl13KzWds7le65oyGLG2pU5N7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move arch specific TX data path to wifi7 directory as part of Next
Generation (NG) Driver Framework.

Architecture specific APIs:
ath12k_hal_tx_cmd_ext_desc_setup
ath12k_dp_prepare_htt_metadata
ath12k_dp_tx

The moved APIs will be a part of dp_tx.c file inside wifi7 directory.
wifi7/dp_tx.c file will continue to be part of ath12k.ko temporarily
until the corresponding infra for movement to ath12k_wifi7.ko arrives
in upcoming patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c       | 363 ------------------
 drivers/net/wireless/ath/ath12k/dp_tx.h       |   3 -
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 363 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   3 +
 4 files changed, 366 insertions(+), 366 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index f1649744c78b..c7b0fc22c1a7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -109,26 +109,6 @@ struct ath12k_tx_desc_info *ath12k_dp_tx_assign_buffer(struct ath12k_dp *dp,
 	return desc;
 }
 
-static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
-					     struct hal_tx_msdu_ext_desc *tcl_ext_cmd,
-					     struct hal_tx_info *ti)
-{
-	tcl_ext_cmd->info0 = le32_encode_bits(ti->paddr,
-					      HAL_TX_MSDU_EXT_INFO0_BUF_PTR_LO);
-	tcl_ext_cmd->info1 = le32_encode_bits(0x0,
-					      HAL_TX_MSDU_EXT_INFO1_BUF_PTR_HI) |
-			       le32_encode_bits(ti->data_len,
-						HAL_TX_MSDU_EXT_INFO1_BUF_LEN);
-
-	tcl_ext_cmd->info1 |= le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
-				le32_encode_bits(ti->encap_type,
-						 HAL_TX_MSDU_EXT_INFO1_ENCAP_TYPE) |
-				le32_encode_bits(ti->encrypt_type,
-						 HAL_TX_MSDU_EXT_INFO1_ENCRYPT_TYPE);
-}
-
-#define HTT_META_DATA_ALIGNMENT 0x8
-
 void *ath12k_dp_metadata_align_skb(struct sk_buff *skb, u8 tail_len)
 {
 	struct sk_buff *tail;
@@ -142,29 +122,6 @@ void *ath12k_dp_metadata_align_skb(struct sk_buff *skb, u8 tail_len)
 	return metadata;
 }
 
-/* Preparing HTT Metadata when utilized with ext MSDU */
-static int ath12k_dp_prepare_htt_metadata(struct sk_buff *skb)
-{
-	struct hal_tx_msdu_metadata *desc_ext;
-	u8 htt_desc_size;
-	/* Size rounded of multiple of 8 bytes */
-	u8 htt_desc_size_aligned;
-
-	htt_desc_size = sizeof(struct hal_tx_msdu_metadata);
-	htt_desc_size_aligned = ALIGN(htt_desc_size, HTT_META_DATA_ALIGNMENT);
-
-	desc_ext = ath12k_dp_metadata_align_skb(skb, htt_desc_size_aligned);
-	if (!desc_ext)
-		return -ENOMEM;
-
-	desc_ext->info0 = le32_encode_bits(1, HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_FLAG) |
-			  le32_encode_bits(0, HAL_TX_MSDU_METADATA_INFO0_ENCRYPT_TYPE) |
-			  le32_encode_bits(1,
-					   HAL_TX_MSDU_METADATA_INFO0_HOST_TX_DESC_POOL);
-
-	return 0;
-}
-
 static void ath12k_dp_tx_move_payload(struct sk_buff *skb,
 				      unsigned long delta,
 				      bool head)
@@ -219,326 +176,6 @@ int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
 	return ret;
 }
 
-int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
-		 bool is_mcast)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
-	struct hal_tx_info ti = {};
-	struct ath12k_tx_desc_info *tx_desc;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
-	struct hal_tcl_data_cmd *hal_tcl_desc;
-	struct hal_tx_msdu_ext_desc *msg;
-	struct sk_buff *skb_ext_desc = NULL;
-	struct hal_srng *tcl_ring;
-	struct ieee80211_hdr *hdr = (void *)skb->data;
-	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct dp_tx_ring *tx_ring;
-	u8 pool_id;
-	u8 hal_ring_id;
-	int ret;
-	u8 ring_selector, ring_map = 0;
-	bool tcl_ring_retry;
-	bool msdu_ext_desc = false;
-	bool add_htt_metadata = false;
-	u32 iova_mask = ab->hw_params->iova_mask;
-	bool is_diff_encap = false;
-	bool is_null_frame = false;
-
-	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
-		return -ESHUTDOWN;
-
-	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
-	    !ieee80211_is_data(hdr->frame_control))
-		return -EOPNOTSUPP;
-
-	pool_id = skb_get_queue_mapping(skb) & (ATH12K_HW_MAX_QUEUES - 1);
-
-	/* Let the default ring selection be based on current processor
-	 * number, where one of the 3 tcl rings are selected based on
-	 * the smp_processor_id(). In case that ring
-	 * is full/busy, we resort to other available rings.
-	 * If all rings are full, we drop the packet.
-	 * TODO: Add throttling logic when all rings are full
-	 */
-	ring_selector = ab->hw_params->hw_ops->get_ring_selector(skb);
-
-tcl_ring_sel:
-	tcl_ring_retry = false;
-	ti.ring_id = ring_selector % ab->hw_params->max_tx_ring;
-
-	ring_map |= BIT(ti.ring_id);
-	ti.rbm_id = ab->hw_params->hal_ops->tcl_to_wbm_rbm_map[ti.ring_id].rbm_id;
-
-	tx_ring = &dp->tx_ring[ti.ring_id];
-
-	tx_desc = ath12k_dp_tx_assign_buffer(dp, pool_id);
-	if (!tx_desc)
-		return -ENOMEM;
-
-	ti.bank_id = arvif->bank_id;
-	ti.meta_data_flags = arvif->tcl_metadata;
-
-	if (ahvif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
-	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags)) {
-		if (skb_cb->flags & ATH12K_SKB_CIPHER_SET) {
-			ti.encrypt_type =
-				ath12k_dp_tx_get_encrypt_type(skb_cb->cipher);
-
-			if (ieee80211_has_protected(hdr->frame_control))
-				skb_put(skb, IEEE80211_CCMP_MIC_LEN);
-		} else {
-			ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
-		}
-
-		msdu_ext_desc = true;
-	}
-
-	if (gsn_valid) {
-		/* Reset and Initialize meta_data_flags with Global Sequence
-		 * Number (GSN) info.
-		 */
-		ti.meta_data_flags =
-			u32_encode_bits(HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM,
-					HTT_TCL_META_DATA_TYPE) |
-			u32_encode_bits(mcbc_gsn, HTT_TCL_META_DATA_GLOBAL_SEQ_NUM);
-	}
-
-	ti.encap_type = ath12k_dp_tx_get_encap_type(ab, skb);
-	ti.addr_search_flags = arvif->hal_addr_search_flags;
-	ti.search_type = arvif->search_type;
-	ti.type = HAL_TCL_DESC_TYPE_BUFFER;
-	ti.pkt_offset = 0;
-	ti.lmac_id = ar->lmac_id;
-
-	ti.vdev_id = arvif->vdev_id;
-	if (gsn_valid)
-		ti.vdev_id += HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;
-
-	ti.bss_ast_hash = arvif->ast_hash;
-	ti.bss_ast_idx = arvif->ast_idx;
-	ti.dscp_tid_tbl_idx = 0;
-
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    ti.encap_type != HAL_TCL_ENCAP_TYPE_RAW) {
-		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_IP4_CKSUM_EN) |
-			     u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_UDP4_CKSUM_EN) |
-			     u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_UDP6_CKSUM_EN) |
-			     u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TCP4_CKSUM_EN) |
-			     u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TCP6_CKSUM_EN);
-	}
-
-	ti.flags1 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO3_TID_OVERWRITE);
-
-	ti.tid = ath12k_dp_tx_get_tid(skb);
-
-	switch (ti.encap_type) {
-	case HAL_TCL_ENCAP_TYPE_NATIVE_WIFI:
-		is_null_frame = ieee80211_is_nullfunc(hdr->frame_control);
-		if (ahvif->vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
-			if (skb->protocol == cpu_to_be16(ETH_P_PAE) || is_null_frame)
-				is_diff_encap = true;
-
-			/* Firmware expects msdu ext descriptor for nwifi/raw packets
-			 * received in ETH mode. Without this, observed tx fail for
-			 * Multicast packets in ETH mode.
-			 */
-			msdu_ext_desc = true;
-		} else {
-			ath12k_dp_tx_encap_nwifi(skb);
-		}
-		break;
-	case HAL_TCL_ENCAP_TYPE_RAW:
-		if (!test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
-			ret = -EINVAL;
-			goto fail_remove_tx_buf;
-		}
-		break;
-	case HAL_TCL_ENCAP_TYPE_ETHERNET:
-		/* no need to encap */
-		break;
-	case HAL_TCL_ENCAP_TYPE_802_3:
-	default:
-		/* TODO: Take care of other encap modes as well */
-		ret = -EINVAL;
-		atomic_inc(&ab->device_stats.tx_err.misc_fail);
-		goto fail_remove_tx_buf;
-	}
-
-	if (iova_mask &&
-	    (unsigned long)skb->data & iova_mask) {
-		ret = ath12k_dp_tx_align_payload(ab, &skb);
-		if (ret) {
-			ath12k_warn(ab, "failed to align TX buffer %d\n", ret);
-			/* don't bail out, give original buffer
-			 * a chance even unaligned.
-			 */
-			goto map;
-		}
-
-		/* hdr is pointing to a wrong place after alignment,
-		 * so refresh it for later use.
-		 */
-		hdr = (void *)skb->data;
-	}
-map:
-	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
-	if (dma_mapping_error(ab->dev, ti.paddr)) {
-		atomic_inc(&ab->device_stats.tx_err.misc_fail);
-		ath12k_warn(ab, "failed to DMA map data Tx buffer\n");
-		ret = -ENOMEM;
-		goto fail_remove_tx_buf;
-	}
-
-	if ((!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
-	     !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
-	     !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
-	     ieee80211_has_protected(hdr->frame_control)) ||
-	    is_diff_encap) {
-		/* Firmware is not expecting meta data for qos null
-		 * nwifi packet received in ETH encap mode.
-		 */
-		if (is_null_frame && msdu_ext_desc)
-			goto skip_htt_meta;
-
-		/* Add metadata for sw encrypted vlan group traffic
-		 * and EAPOL nwifi packet received in ETH encap mode.
-		 */
-		add_htt_metadata = true;
-		msdu_ext_desc = true;
-		ti.meta_data_flags |= HTT_TCL_META_DATA_VALID_HTT;
-skip_htt_meta:
-		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
-		ti.encap_type = HAL_TCL_ENCAP_TYPE_RAW;
-		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
-	}
-
-	tx_desc->skb = skb;
-	tx_desc->mac_id = ar->pdev_idx;
-	ti.desc_id = tx_desc->desc_id;
-	ti.data_len = skb->len;
-	skb_cb->paddr = ti.paddr;
-	skb_cb->vif = ahvif->vif;
-	skb_cb->ar = ar;
-
-	if (msdu_ext_desc) {
-		skb_ext_desc = dev_alloc_skb(sizeof(struct hal_tx_msdu_ext_desc));
-		if (!skb_ext_desc) {
-			ret = -ENOMEM;
-			goto fail_unmap_dma;
-		}
-
-		skb_put(skb_ext_desc, sizeof(struct hal_tx_msdu_ext_desc));
-		memset(skb_ext_desc->data, 0, skb_ext_desc->len);
-
-		msg = (struct hal_tx_msdu_ext_desc *)skb_ext_desc->data;
-		ath12k_hal_tx_cmd_ext_desc_setup(ab, msg, &ti);
-
-		if (add_htt_metadata) {
-			ret = ath12k_dp_prepare_htt_metadata(skb_ext_desc);
-			if (ret < 0) {
-				ath12k_dbg(ab, ATH12K_DBG_DP_TX,
-					   "Failed to add HTT meta data, dropping packet\n");
-				goto fail_free_ext_skb;
-			}
-		}
-
-		ti.paddr = dma_map_single(ab->dev, skb_ext_desc->data,
-					  skb_ext_desc->len, DMA_TO_DEVICE);
-		ret = dma_mapping_error(ab->dev, ti.paddr);
-		if (ret)
-			goto fail_free_ext_skb;
-
-		ti.data_len = skb_ext_desc->len;
-		ti.type = HAL_TCL_DESC_TYPE_EXT_DESC;
-
-		skb_cb->paddr_ext_desc = ti.paddr;
-		tx_desc->skb_ext_desc = skb_ext_desc;
-	}
-
-	hal_ring_id = tx_ring->tcl_data_ring.ring_id;
-	tcl_ring = &ab->hal.srng_list[hal_ring_id];
-
-	spin_lock_bh(&tcl_ring->lock);
-
-	ath12k_hal_srng_access_begin(ab, tcl_ring);
-
-	hal_tcl_desc = ath12k_hal_srng_src_get_next_entry(ab, tcl_ring);
-	if (!hal_tcl_desc) {
-		/* NOTE: It is highly unlikely we'll be running out of tcl_ring
-		 * desc because the desc is directly enqueued onto hw queue.
-		 */
-		ath12k_hal_srng_access_end(ab, tcl_ring);
-		ab->device_stats.tx_err.desc_na[ti.ring_id]++;
-		spin_unlock_bh(&tcl_ring->lock);
-		ret = -ENOMEM;
-
-		/* Checking for available tcl descriptors in another ring in
-		 * case of failure due to full tcl ring now, is better than
-		 * checking this ring earlier for each pkt tx.
-		 * Restart ring selection if some rings are not checked yet.
-		 */
-		if (ring_map != (BIT(ab->hw_params->max_tx_ring) - 1) &&
-		    ab->hw_params->tcl_ring_retry) {
-			tcl_ring_retry = true;
-			ring_selector++;
-		}
-
-		goto fail_unmap_dma_ext;
-	}
-
-	spin_lock_bh(&arvif->link_stats_lock);
-	arvif->link_stats.tx_encap_type[ti.encap_type]++;
-	arvif->link_stats.tx_encrypt_type[ti.encrypt_type]++;
-	arvif->link_stats.tx_desc_type[ti.type]++;
-
-	if (is_mcast)
-		arvif->link_stats.tx_bcast_mcast++;
-	else
-		arvif->link_stats.tx_enqueued++;
-	spin_unlock_bh(&arvif->link_stats_lock);
-
-	ab->device_stats.tx_enqueued[ti.ring_id]++;
-
-	ath12k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
-
-	ath12k_hal_srng_access_end(ab, tcl_ring);
-
-	spin_unlock_bh(&tcl_ring->lock);
-
-	ath12k_dbg_dump(ab, ATH12K_DBG_DP_TX, NULL, "dp tx msdu: ",
-			skb->data, skb->len);
-
-	atomic_inc(&ar->dp.num_tx_pending);
-
-	return 0;
-
-fail_unmap_dma_ext:
-	if (skb_cb->paddr_ext_desc)
-		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-				 skb_ext_desc->len,
-				 DMA_TO_DEVICE);
-fail_free_ext_skb:
-	kfree_skb(skb_ext_desc);
-
-fail_unmap_dma:
-	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
-
-fail_remove_tx_buf:
-	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
-
-	spin_lock_bh(&arvif->link_stats_lock);
-	arvif->link_stats.tx_dropped++;
-	spin_unlock_bh(&arvif->link_stats_lock);
-
-	if (tcl_ring_retry)
-		goto tcl_ring_sel;
-
-	return ret;
-}
-
 void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 			     struct dp_tx_ring *tx_ring,
 			     struct ath12k_tx_desc_params *desc_params)
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index 67ab7b3f55ea..8405a0baf95b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -16,9 +16,6 @@ struct ath12k_dp_htt_wbm_tx_status {
 };
 
 int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);
-int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
-		 bool is_mcast);
 int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask);
 int
 ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 149e211aa225..49d219a195c5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -10,6 +10,369 @@
 #include "../peer.h"
 #include "dp_tx.h"
 
+static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
+					     struct hal_tx_msdu_ext_desc *tcl_ext_cmd,
+					     struct hal_tx_info *ti)
+{
+	tcl_ext_cmd->info0 = le32_encode_bits(ti->paddr,
+					      HAL_TX_MSDU_EXT_INFO0_BUF_PTR_LO);
+	tcl_ext_cmd->info1 = le32_encode_bits(0x0,
+					      HAL_TX_MSDU_EXT_INFO1_BUF_PTR_HI) |
+			       le32_encode_bits(ti->data_len,
+						HAL_TX_MSDU_EXT_INFO1_BUF_LEN);
+
+	tcl_ext_cmd->info1 |= le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
+				le32_encode_bits(ti->encap_type,
+						 HAL_TX_MSDU_EXT_INFO1_ENCAP_TYPE) |
+				le32_encode_bits(ti->encrypt_type,
+						 HAL_TX_MSDU_EXT_INFO1_ENCRYPT_TYPE);
+}
+
+#define HTT_META_DATA_ALIGNMENT 0x8
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
+int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
+		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
+		 bool is_mcast)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = &ab->dp;
+	struct hal_tx_info ti = {};
+	struct ath12k_tx_desc_info *tx_desc;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
+	struct hal_tcl_data_cmd *hal_tcl_desc;
+	struct hal_tx_msdu_ext_desc *msg;
+	struct sk_buff *skb_ext_desc = NULL;
+	struct hal_srng *tcl_ring;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct dp_tx_ring *tx_ring;
+	u8 pool_id;
+	u8 hal_ring_id;
+	int ret;
+	u8 ring_selector, ring_map = 0;
+	bool tcl_ring_retry;
+	bool msdu_ext_desc = false;
+	bool add_htt_metadata = false;
+	u32 iova_mask = ab->hw_params->iova_mask;
+	bool is_diff_encap = false;
+	bool is_null_frame = false;
+
+	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
+		return -ESHUTDOWN;
+
+	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
+	    !ieee80211_is_data(hdr->frame_control))
+		return -EOPNOTSUPP;
+
+	pool_id = skb_get_queue_mapping(skb) & (ATH12K_HW_MAX_QUEUES - 1);
+
+	/* Let the default ring selection be based on current processor
+	 * number, where one of the 3 tcl rings are selected based on
+	 * the smp_processor_id(). In case that ring
+	 * is full/busy, we resort to other available rings.
+	 * If all rings are full, we drop the packet.
+	 * TODO: Add throttling logic when all rings are full
+	 */
+	ring_selector = ab->hw_params->hw_ops->get_ring_selector(skb);
+
+tcl_ring_sel:
+	tcl_ring_retry = false;
+	ti.ring_id = ring_selector % ab->hw_params->max_tx_ring;
+
+	ring_map |= BIT(ti.ring_id);
+	ti.rbm_id = ab->hw_params->hal_ops->tcl_to_wbm_rbm_map[ti.ring_id].rbm_id;
+
+	tx_ring = &dp->tx_ring[ti.ring_id];
+
+	tx_desc = ath12k_dp_tx_assign_buffer(dp, pool_id);
+	if (!tx_desc)
+		return -ENOMEM;
+
+	ti.bank_id = arvif->bank_id;
+	ti.meta_data_flags = arvif->tcl_metadata;
+
+	if (ahvif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
+	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags)) {
+		if (skb_cb->flags & ATH12K_SKB_CIPHER_SET) {
+			ti.encrypt_type =
+				ath12k_dp_tx_get_encrypt_type(skb_cb->cipher);
+
+			if (ieee80211_has_protected(hdr->frame_control))
+				skb_put(skb, IEEE80211_CCMP_MIC_LEN);
+		} else {
+			ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
+		}
+
+		msdu_ext_desc = true;
+	}
+
+	if (gsn_valid) {
+		/* Reset and Initialize meta_data_flags with Global Sequence
+		 * Number (GSN) info.
+		 */
+		ti.meta_data_flags =
+			u32_encode_bits(HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM,
+					HTT_TCL_META_DATA_TYPE) |
+			u32_encode_bits(mcbc_gsn, HTT_TCL_META_DATA_GLOBAL_SEQ_NUM);
+	}
+
+	ti.encap_type = ath12k_dp_tx_get_encap_type(ab, skb);
+	ti.addr_search_flags = arvif->hal_addr_search_flags;
+	ti.search_type = arvif->search_type;
+	ti.type = HAL_TCL_DESC_TYPE_BUFFER;
+	ti.pkt_offset = 0;
+	ti.lmac_id = ar->lmac_id;
+
+	ti.vdev_id = arvif->vdev_id;
+	if (gsn_valid)
+		ti.vdev_id += HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;
+
+	ti.bss_ast_hash = arvif->ast_hash;
+	ti.bss_ast_idx = arvif->ast_idx;
+	ti.dscp_tid_tbl_idx = 0;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    ti.encap_type != HAL_TCL_ENCAP_TYPE_RAW) {
+		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_IP4_CKSUM_EN) |
+			     u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_UDP4_CKSUM_EN) |
+			     u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_UDP6_CKSUM_EN) |
+			     u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TCP4_CKSUM_EN) |
+			     u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TCP6_CKSUM_EN);
+	}
+
+	ti.flags1 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO3_TID_OVERWRITE);
+
+	ti.tid = ath12k_dp_tx_get_tid(skb);
+
+	switch (ti.encap_type) {
+	case HAL_TCL_ENCAP_TYPE_NATIVE_WIFI:
+		is_null_frame = ieee80211_is_nullfunc(hdr->frame_control);
+		if (ahvif->vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
+			if (skb->protocol == cpu_to_be16(ETH_P_PAE) || is_null_frame)
+				is_diff_encap = true;
+
+			/* Firmware expects msdu ext descriptor for nwifi/raw packets
+			 * received in ETH mode. Without this, observed tx fail for
+			 * Multicast packets in ETH mode.
+			 */
+			msdu_ext_desc = true;
+		} else {
+			ath12k_dp_tx_encap_nwifi(skb);
+		}
+		break;
+	case HAL_TCL_ENCAP_TYPE_RAW:
+		if (!test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
+			ret = -EINVAL;
+			goto fail_remove_tx_buf;
+		}
+		break;
+	case HAL_TCL_ENCAP_TYPE_ETHERNET:
+		/* no need to encap */
+		break;
+	case HAL_TCL_ENCAP_TYPE_802_3:
+	default:
+		/* TODO: Take care of other encap modes as well */
+		ret = -EINVAL;
+		atomic_inc(&ab->device_stats.tx_err.misc_fail);
+		goto fail_remove_tx_buf;
+	}
+
+	if (iova_mask &&
+	    (unsigned long)skb->data & iova_mask) {
+		ret = ath12k_dp_tx_align_payload(ab, &skb);
+		if (ret) {
+			ath12k_warn(ab, "failed to align TX buffer %d\n", ret);
+			/* don't bail out, give original buffer
+			 * a chance even unaligned.
+			 */
+			goto map;
+		}
+
+		/* hdr is pointing to a wrong place after alignment,
+		 * so refresh it for later use.
+		 */
+		hdr = (void *)skb->data;
+	}
+map:
+	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(ab->dev, ti.paddr)) {
+		atomic_inc(&ab->device_stats.tx_err.misc_fail);
+		ath12k_warn(ab, "failed to DMA map data Tx buffer\n");
+		ret = -ENOMEM;
+		goto fail_remove_tx_buf;
+	}
+
+	if ((!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	     !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
+	     !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
+	     ieee80211_has_protected(hdr->frame_control)) ||
+	    is_diff_encap) {
+		/* Firmware is not expecting meta data for qos null
+		 * nwifi packet received in ETH encap mode.
+		 */
+		if (is_null_frame && msdu_ext_desc)
+			goto skip_htt_meta;
+
+		/* Add metadata for sw encrypted vlan group traffic
+		 * and EAPOL nwifi packet received in ETH encap mode.
+		 */
+		add_htt_metadata = true;
+		msdu_ext_desc = true;
+		ti.meta_data_flags |= HTT_TCL_META_DATA_VALID_HTT;
+skip_htt_meta:
+		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
+		ti.encap_type = HAL_TCL_ENCAP_TYPE_RAW;
+		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
+	}
+
+	tx_desc->skb = skb;
+	tx_desc->mac_id = ar->pdev_idx;
+	ti.desc_id = tx_desc->desc_id;
+	ti.data_len = skb->len;
+	skb_cb->paddr = ti.paddr;
+	skb_cb->vif = ahvif->vif;
+	skb_cb->ar = ar;
+
+	if (msdu_ext_desc) {
+		skb_ext_desc = dev_alloc_skb(sizeof(struct hal_tx_msdu_ext_desc));
+		if (!skb_ext_desc) {
+			ret = -ENOMEM;
+			goto fail_unmap_dma;
+		}
+
+		skb_put(skb_ext_desc, sizeof(struct hal_tx_msdu_ext_desc));
+		memset(skb_ext_desc->data, 0, skb_ext_desc->len);
+
+		msg = (struct hal_tx_msdu_ext_desc *)skb_ext_desc->data;
+		ath12k_hal_tx_cmd_ext_desc_setup(ab, msg, &ti);
+
+		if (add_htt_metadata) {
+			ret = ath12k_dp_prepare_htt_metadata(skb_ext_desc);
+			if (ret < 0) {
+				ath12k_dbg(ab, ATH12K_DBG_DP_TX,
+					   "Failed to add HTT meta data, dropping packet\n");
+				goto fail_free_ext_skb;
+			}
+		}
+
+		ti.paddr = dma_map_single(ab->dev, skb_ext_desc->data,
+					  skb_ext_desc->len, DMA_TO_DEVICE);
+		ret = dma_mapping_error(ab->dev, ti.paddr);
+		if (ret)
+			goto fail_free_ext_skb;
+
+		ti.data_len = skb_ext_desc->len;
+		ti.type = HAL_TCL_DESC_TYPE_EXT_DESC;
+
+		skb_cb->paddr_ext_desc = ti.paddr;
+		tx_desc->skb_ext_desc = skb_ext_desc;
+	}
+
+	hal_ring_id = tx_ring->tcl_data_ring.ring_id;
+	tcl_ring = &ab->hal.srng_list[hal_ring_id];
+
+	spin_lock_bh(&tcl_ring->lock);
+
+	ath12k_hal_srng_access_begin(ab, tcl_ring);
+
+	hal_tcl_desc = ath12k_hal_srng_src_get_next_entry(ab, tcl_ring);
+	if (!hal_tcl_desc) {
+		/* NOTE: It is highly unlikely we'll be running out of tcl_ring
+		 * desc because the desc is directly enqueued onto hw queue.
+		 */
+		ath12k_hal_srng_access_end(ab, tcl_ring);
+		ab->device_stats.tx_err.desc_na[ti.ring_id]++;
+		spin_unlock_bh(&tcl_ring->lock);
+		ret = -ENOMEM;
+
+		/* Checking for available tcl descriptors in another ring in
+		 * case of failure due to full tcl ring now, is better than
+		 * checking this ring earlier for each pkt tx.
+		 * Restart ring selection if some rings are not checked yet.
+		 */
+		if (ring_map != (BIT(ab->hw_params->max_tx_ring) - 1) &&
+		    ab->hw_params->tcl_ring_retry) {
+			tcl_ring_retry = true;
+			ring_selector++;
+		}
+
+		goto fail_unmap_dma_ext;
+	}
+
+	spin_lock_bh(&arvif->link_stats_lock);
+	arvif->link_stats.tx_encap_type[ti.encap_type]++;
+	arvif->link_stats.tx_encrypt_type[ti.encrypt_type]++;
+	arvif->link_stats.tx_desc_type[ti.type]++;
+
+	if (is_mcast)
+		arvif->link_stats.tx_bcast_mcast++;
+	else
+		arvif->link_stats.tx_enqueued++;
+	spin_unlock_bh(&arvif->link_stats_lock);
+
+	ab->device_stats.tx_enqueued[ti.ring_id]++;
+
+	ath12k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
+
+	ath12k_hal_srng_access_end(ab, tcl_ring);
+
+	spin_unlock_bh(&tcl_ring->lock);
+
+	ath12k_dbg_dump(ab, ATH12K_DBG_DP_TX, NULL, "dp tx msdu: ",
+			skb->data, skb->len);
+
+	atomic_inc(&ar->dp.num_tx_pending);
+
+	return 0;
+
+fail_unmap_dma_ext:
+	if (skb_cb->paddr_ext_desc)
+		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
+				 skb_ext_desc->len,
+				 DMA_TO_DEVICE);
+fail_free_ext_skb:
+	kfree_skb(skb_ext_desc);
+
+fail_unmap_dma:
+	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
+
+fail_remove_tx_buf:
+	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
+
+	spin_lock_bh(&arvif->link_stats_lock);
+	arvif->link_stats.tx_dropped++;
+	spin_unlock_bh(&arvif->link_stats_lock);
+
+	if (tcl_ring_retry)
+		goto tcl_ring_sel;
+
+	return ret;
+}
+
 static void
 ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 				 struct ath12k_tx_desc_params *desc_params,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
index 4361beb99666..42faf664f8f8 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
@@ -7,5 +7,8 @@
 #ifndef ATH12K_DP_TX_WIFI7_H
 #define ATH12K_DP_TX_WIFI7_H
 
+int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
+		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
+		 bool is_mcast);
 void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
 #endif
-- 
2.34.1


