Return-Path: <linux-wireless+bounces-13329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99E98AB45
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F291F23733
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 17:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F88198842;
	Mon, 30 Sep 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AkNNUmcl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496F198833
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718047; cv=none; b=ChUGLDQLeFl1FSoM/UP6GBGPvBQdfUwy/Ceq8zc5hH76c8AP5ccwu1oEwMEiQDjMR48Tg8KEaIuUXvdHF2Rc6iV+IRT1xTfQnmNEEXg56led3uQs+P0FRI3MHbveKdOGsIHlOo9Bv+hR4WNG+jqhfiIv06M7E8nT7j1InV+rivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718047; c=relaxed/simple;
	bh=aCEtr1ziJ6dBLZz21UJHuZ5QgQ0JdHecbLQXqEiTUb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYZxCjEsCxTptB/rZo7pmPCjiadIus1hJOkwGA2vJSlwOYWPZsW9UHMJgBsrxk0TWsYJl5JTPDldR0Qb3vK6hzyK998CZln8Kfv/PQ55O+LlVo8ma2aPy4jAV0JaaQ9tbmVkjxX1egjr5qIj6n2CrdC3Jx2ckrG1QSujLO/65/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AkNNUmcl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBRjv4024568;
	Mon, 30 Sep 2024 17:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tt4BVRPp932Ga7s4u3vQjw1OzdV/YfrxUt4kqRqnJCE=; b=AkNNUmclZD7/zCC0
	jKY5GmzqiJyLMLLta1ersTTKhFRE5dfFHWz+thVj//dvzpH8Hsmv5qal1ELgrFNg
	sAr9say2dSnuUT+ypp8QxLTs/swUUWvSF8hcVu4I6lUZpj3QV49LxnBhqgX8MPin
	PfuSQKk7xX++bI+d1rHyclYZpDf4ByhzNmRribscIMOROwKGAx6yHFbcbcUjsFS+
	Wc4rzvgKxbjlMu4ob4+YAxbCrJ3x+4a/WO81Z9xTjD1lDTNPzqCM880QkQ758XP9
	3oB3aZzEhwWs6cZHbegzgQwGVJP2hEnS7hOsf1+/1r/ABQx2iyx+8dDU8fUxrXjG
	T/7nMA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa675gwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:40:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48UHeer7013931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:40:40 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 10:40:38 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: Support pdev Puncture Stats
Date: Mon, 30 Sep 2024 23:10:10 +0530
Message-ID: <20240930174010.617123-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930174010.617123-1-quic_rdevanat@quicinc.com>
References: <20240930174010.617123-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: r3Kz9zNNIUiHXFg1cmYjdsjjA9imAOL9
X-Proofpoint-ORIG-GUID: r3Kz9zNNIUiHXFg1cmYjdsjjA9imAOL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300127

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
index 8016f1b007f2..9dbf2b6555e3 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2627,6 +2627,141 @@ ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
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
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	int i;
+	const char *direction;
+	const char *preamble;
+	const char *ppdu_type;
+	u32 mac_id__word;
+	u32 subband_limit;
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
 ath12k_htt_print_pdev_sched_algo_ofdma_stats_tlv(const void *tag_buf, u16 tag_len,
 						 struct debug_htt_stats_req *stats_req)
@@ -2921,6 +3056,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_DMAC_RESET_STATS_TAG:
 		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_PUNCTURE_STATS_TAG:
+		ath12k_htt_print_puncture_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG:
 		ath12k_htt_print_pdev_sched_algo_ofdma_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 6978c3243ee3..e6e2bcbe95a7 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -137,6 +137,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 	ATH12K_DBG_HTT_EXT_AST_ENTRIES			= 41,
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
+	ATH12K_DBG_HTT_DBG_PDEV_PUNCTURE_STATS		= 46,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
 	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
 
@@ -203,6 +204,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
 	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
 	HTT_STATS_DMAC_RESET_STATS_TAG			= 155,
+	HTT_STATS_PDEV_PUNCTURE_STATS_TAG		= 158,
 	HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG	= 165,
 
 	HTT_STATS_MAX_TAG,
@@ -1140,4 +1142,40 @@ struct ath12k_htt_ast_entry_tlv {
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
 #endif
-- 
2.25.1


