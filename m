Return-Path: <linux-wireless+bounces-16443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112EE9F4337
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 06:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF95188E304
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 05:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD05156F2B;
	Tue, 17 Dec 2024 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dOFq0Jko"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992983CC7
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 05:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414878; cv=none; b=W5qWW0O7LWo8z5LzMIGTqxaSXMpkABhXKCVVMxLjWdvRgnjRTC6w+ZoDzlnCWl587UL/nFKuZHqNJR2rH89GpYRRT1F7Bhm1/M5CMwOFPmQWmzK4OygbL31nU6OGJif/NhpQ8pmhol4LQZqJO5DsQoqdCbi2YZ7PlWdmhLUjuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414878; c=relaxed/simple;
	bh=eklSHzKw/VQ/QPLBICkfWYjjtcmu9zfkDnNPjt4cxaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyElbJyL9lsfrMJAbHxrJQzSIapc/QxtBF9qxFM6DR4KznHkmPIuYrJgiNaB5fS4YAnEtyw/MeAfkeKVSIMUhpCDjwdaOhoJ5QLiHZUf9V6VEfLU5e3FDBlynKbDfBCVLPpCaE6hUSOp9x+BbQIULsIDATShuBIVQhAErEV/s1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dOFq0Jko; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGNsv8N003465;
	Tue, 17 Dec 2024 05:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aDSW0Jx8jJ0MnBzwo023HfY9qDRHL9tI9vcUPhpPzyk=; b=dOFq0Jko2r46vW3o
	VipHphxRtTjJENMMWpABhIJIfyxk9OgqXpd48qWWAjud+nXy+Y03WJDWTMVetdBF
	shm45/GUSpEzrWR9aRdAISF/DWDoCVIFcIMVKoFLiXCvGcc84OAvH9X3n51rSNxV
	SqHLH4XiBxnc2Nl3l7Mxy2bdM9dcSMOS1Twbh9BTZcIg69akmxxWXOoJX2n7roo7
	x5N/9LUecuMCol6LdqQ5npOdXVUyrkDE51+b6SHS4rpKu1OKRp8p9i6vlkbIEhWV
	CAQN2Bc911B/l8lFp20HOTh2bB5twFDnDbnIVaiplNUtTXR2hxNt540gi3fEPsG8
	gmxw2g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jx9ygpac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 05:54:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH5sWSW025578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 05:54:32 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 21:54:30 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v4 2/2] wifi: ath12k: Support pdev Puncture Stats
Date: Tue, 17 Dec 2024 11:24:08 +0530
Message-ID: <20241217055408.1293764-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217055408.1293764-1-quic_rdevanat@quicinc.com>
References: <20241217055408.1293764-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ngKzwnA45-UFvBIf881BnLU6y3aAuSJe
X-Proofpoint-ORIG-GUID: ngKzwnA45-UFvBIf881BnLU6y3aAuSJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170047

From: Rajat Soni <quic_rajson@quicinc.com>

Add support to request pdev puncture stats from firmware through
HTT stats type 46. These stats give the count of number of
subbands used in different wifi standards.

Sample output:
-------------
echo 46 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_PDEV_PUNCTURE_STATS_TLV:
mac_id = 0
tx_ofdm_su_last_used_pattern_mask = 0x00000001
tx_ofdm_su_num_subbands_used_cnt_01 = 217
tx_ofdm_su_num_subbands_used_cnt_02 = 0
tx_ofdm_su_num_subbands_used_cnt_03 = 0
.....

HTT_PDEV_PUNCTURE_STATS_TLV:
mac_id = 0
tx_ax_dl_mu_ofdma_last_used_pattern_mask = 0x00000000
tx_ax_dl_mu_ofdma_num_subbands_used_cnt_01 = 0
tx_ax_dl_mu_ofdma_num_subbands_used_cnt_02 = 0
tx_ax_dl_mu_ofdma_num_subbands_used_cnt_03 = 0
.....

HTT_PDEV_PUNCTURE_STATS_TLV:
mac_id = 0
tx_be_dl_mu_ofdma_last_used_pattern_mask = 0x00000000
tx_be_dl_mu_ofdma_num_subbands_used_cnt_01 = 0
tx_be_dl_mu_ofdma_num_subbands_used_cnt_02 = 0
tx_be_dl_mu_ofdma_num_subbands_used_cnt_03 = 0
.....

HTT_PDEV_PUNCTURE_STATS_TLV:
mac_id = 0
rx_ax_ul_mu_ofdma_last_used_pattern_mask = 0x00000000
rx_ax_ul_mu_ofdma_num_subbands_used_cnt_01 = 0
rx_ax_ul_mu_ofdma_num_subbands_used_cnt_02 = 0
rx_ax_ul_mu_ofdma_num_subbands_used_cnt_03 = 0
.....

HTT_PDEV_PUNCTURE_STATS_TLV:
mac_id = 0
rx_be_ul_mu_ofdma_last_used_pattern_mask = 0x00000000
rx_be_ul_mu_ofdma_num_subbands_used_cnt_01 = 0
rx_be_ul_mu_ofdma_num_subbands_used_cnt_02 = 0
rx_be_ul_mu_ofdma_num_subbands_used_cnt_03 = 0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 138 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  38 +++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 9294ef41a169..90f92769b89c 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -3522,6 +3522,141 @@ ath12k_htt_print_ast_entry_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static const char*
+ath12k_htt_get_punct_dir_type_str(enum ath12k_htt_stats_direction direction,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const char *direction_str = "unknown";
+	u32 len = stats_req->buf_len;
+
+	switch (direction) {
+	case ATH12K_HTT_STATS_DIRECTION_TX:
+		direction_str = "tx";
+		break;
+	case ATH12K_HTT_STATS_DIRECTION_RX:
+		direction_str = "rx";
+		break;
+	default:
+		break;
+	}
+
+	stats_req->buf_len = len;
+	return direction_str;
+}
+
+static const char*
+ath12k_htt_get_punct_ppdu_type_str(enum ath12k_htt_stats_ppdu_type ppdu_type,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const char *ppdu_type_str = "unknown";
+	u32 len = stats_req->buf_len;
+
+	switch (ppdu_type) {
+	case ATH12K_HTT_STATS_PPDU_TYPE_MODE_SU:
+		ppdu_type_str = "su";
+		break;
+	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_MIMO:
+		ppdu_type_str = "dl_mu_mimo";
+		break;
+	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_MIMO:
+		ppdu_type_str = "ul_mu_mimo";
+		break;
+	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_OFDMA:
+		ppdu_type_str = "dl_mu_ofdma";
+		break;
+	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_OFDMA:
+		ppdu_type_str = "ul_mu_ofdma";
+		break;
+	default:
+		break;
+	}
+
+	stats_req->buf_len = len;
+	return ppdu_type_str;
+}
+
+static const char*
+ath12k_htt_get_punct_pream_type_str(enum ath12k_htt_stats_param_type pream_type,
+				    struct debug_htt_stats_req *stats_req)
+{
+	const char *pream_type_str = "unknown";
+	u32 len = stats_req->buf_len;
+
+	switch (pream_type) {
+	case ATH12K_HTT_STATS_PREAM_OFDM:
+		pream_type_str = "ofdm";
+		break;
+	case ATH12K_HTT_STATS_PREAM_CCK:
+		pream_type_str = "cck";
+		break;
+	case ATH12K_HTT_STATS_PREAM_HT:
+		pream_type_str = "ht";
+		break;
+	case ATH12K_HTT_STATS_PREAM_VHT:
+		pream_type_str = "ac";
+		break;
+	case ATH12K_HTT_STATS_PREAM_HE:
+		pream_type_str = "ax";
+		break;
+	case ATH12K_HTT_STATS_PREAM_EHT:
+		pream_type_str = "be";
+		break;
+	default:
+		break;
+	}
+
+	stats_req->buf_len = len;
+	return pream_type_str;
+}
+
+static void
+ath12k_htt_print_puncture_stats_tlv(const void *tag_buf, u16 tag_len,
+				    struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_puncture_stats_tlv *stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	const char *direction;
+	const char *ppdu_type;
+	const char *preamble;
+	u32 mac_id__word;
+	u32 subband_limit;
+	u8 i;
+
+	if (tag_len < sizeof(*stats_buf))
+		return;
+
+	mac_id__word = le32_to_cpu(stats_buf->mac_id__word);
+	subband_limit = min(le32_to_cpu(stats_buf->subband_cnt),
+			    ATH12K_HTT_PUNCT_STATS_MAX_SUBBAND_CNT);
+
+	direction = ath12k_htt_get_punct_dir_type_str(le32_to_cpu(stats_buf->direction),
+						      stats_req);
+	ppdu_type = ath12k_htt_get_punct_ppdu_type_str(le32_to_cpu(stats_buf->ppdu_type),
+						       stats_req);
+	preamble = ath12k_htt_get_punct_pream_type_str(le32_to_cpu(stats_buf->preamble),
+						       stats_req);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_PUNCTURE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id__word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len,
+			 "%s_%s_%s_last_used_pattern_mask = 0x%08x\n",
+			 direction, preamble, ppdu_type,
+			 le32_to_cpu(stats_buf->last_used_pattern_mask));
+
+	for (i = 0; i < subband_limit; i++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "%s_%s_%s_num_subbands_used_cnt_%02d = %u\n",
+				 direction, preamble, ppdu_type, i + 1,
+				 le32_to_cpu(stats_buf->num_subbands_used_cnt[i]));
+	}
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	stats_req->buf_len = len;
+}
+
 static void
 ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
 				      struct debug_htt_stats_req *stats_req)
@@ -3933,6 +4068,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_AST_ENTRY_TAG:
 		ath12k_htt_print_ast_entry_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_PUNCTURE_STATS_TAG:
+		ath12k_htt_print_puncture_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_DMAC_RESET_STATS_TAG:
 		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 9a9dd368c5d6..4b59976fbc35 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -143,6 +143,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_PDEV_PER_STATS		= 40,
 	ATH12K_DBG_HTT_EXT_AST_ENTRIES			= 41,
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
+	ATH12K_DBG_HTT_DBG_PDEV_PUNCTURE_STATS		= 46,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
 	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
 	ATH12K_DGB_HTT_EXT_STATS_PDEV_MBSSID_CTRL_FRAME	= 54,
@@ -223,6 +224,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TXBF_OFDMA_AX_STEER_STATS_TAG		= 150,
 	HTT_STATS_DMAC_RESET_STATS_TAG			= 155,
 	HTT_STATS_PHY_TPC_STATS_TAG			= 157,
+	HTT_STATS_PDEV_PUNCTURE_STATS_TAG		= 158,
 	HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG	= 165,
 	HTT_STATS_TXBF_OFDMA_AX_STEER_MPDU_STATS_TAG	= 172,
 	HTT_STATS_PDEV_MBSSID_CTRL_FRAME_STATS_TAG	= 176,
@@ -1311,6 +1313,42 @@ struct ath12k_htt_ast_entry_tlv {
 	__le32 info;
 } __packed;
 
+enum ath12k_htt_stats_direction {
+	ATH12K_HTT_STATS_DIRECTION_TX,
+	ATH12K_HTT_STATS_DIRECTION_RX
+};
+
+enum ath12k_htt_stats_ppdu_type {
+	ATH12K_HTT_STATS_PPDU_TYPE_MODE_SU,
+	ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_MIMO,
+	ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_MIMO,
+	ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_OFDMA,
+	ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_OFDMA
+};
+
+enum ath12k_htt_stats_param_type {
+	ATH12K_HTT_STATS_PREAM_OFDM,
+	ATH12K_HTT_STATS_PREAM_CCK,
+	ATH12K_HTT_STATS_PREAM_HT,
+	ATH12K_HTT_STATS_PREAM_VHT,
+	ATH12K_HTT_STATS_PREAM_HE,
+	ATH12K_HTT_STATS_PREAM_EHT,
+	ATH12K_HTT_STATS_PREAM_RSVD1,
+	ATH12K_HTT_STATS_PREAM_COUNT,
+};
+
+#define ATH12K_HTT_PUNCT_STATS_MAX_SUBBAND_CNT	32
+
+struct ath12k_htt_pdev_puncture_stats_tlv {
+	__le32 mac_id__word;
+	__le32 direction;
+	__le32 preamble;
+	__le32 ppdu_type;
+	__le32 subband_cnt;
+	__le32 last_used_pattern_mask;
+	__le32 num_subbands_used_cnt[ATH12K_HTT_PUNCT_STATS_MAX_SUBBAND_CNT];
+} __packed;
+
 struct ath12k_htt_dmac_reset_stats_tlv {
 	__le32 reset_count;
 	__le32 reset_time_lo_ms;
-- 
2.25.1


