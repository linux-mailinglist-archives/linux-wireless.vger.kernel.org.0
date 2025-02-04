Return-Path: <linux-wireless+bounces-18386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC3FA26C43
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAB41886B86
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 06:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922431F8AD3;
	Tue,  4 Feb 2025 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tapv7yTx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FF2040BE
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738651498; cv=none; b=EKtCMby9pajm/+zlGv5RHGhqiJli+1uKZWsIZlSwcEXOVfc397DKpFz32l2wzACPbfBt+EfC1KFdXqkdwxqOtytO8PXv3V3SHi278oZnnsLfWNkNCLsShK7JybqsPBNn92zX5iT+1hipcM4l37GS3vGwRncI5oOPzN23pUb2nAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738651498; c=relaxed/simple;
	bh=7AQ3AocGD5NjvnUhwPyMPFGMPG4vTWj6pH2KPQ5kPI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DG0sJ9568Bg2KeF4WhIS4QM1Xvb7djExlmHZ+arowlq5tx6DpMBeKtq23FQsVC9K+aC6MqQoFgh5YrRumak0vDzUItlpdyJmvUUA+mULrQl32frh49eVloDppBbNWOJWgEEUqGMJwiTvYFGvOkTTP9517fi5ij1srs+NULLvmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tapv7yTx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQgAD026957;
	Tue, 4 Feb 2025 06:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VFN4CWPchTn+Lpq3SpG3OjDd1dgQC5drTBTzijBg6DY=; b=Tapv7yTxr6XNFruy
	ij0cEbYyW81SLLJ8sSFpsdWEmdpHJvmf7RsrxlaVNv/yyoZPlrK3d/zSkLgHhiDH
	QcRfm3CBjskasWQBN7L/BCLCFE88vuYHW96r8sX3BxlLTUiMfnVQvfkttSm/v+Yq
	wrY37Jx8IqTkLFMroIPrxNhmP7rKDhOoKCwsOSTojIuDD7BXMj3gDz5QK5I1PD3m
	ZdGdPX1A6Ur2nZ2jTz5AtIgKtTH7KXlYPRgnb+zSfHME/r0bVeNiJc9aheTfgSmp
	vZXgqlQeAXYBHePvHCFupAIdjTnZZEMeuSuehBZoxuMHDGGeuIvS5YrzcwT9pmHt
	bFeG5A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufs3a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 06:44:54 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5146isEF022813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 06:44:54 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 22:44:51 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v5 5/5] wifi: ath12k: Support Received FSE Stats
Date: Tue, 4 Feb 2025 12:14:17 +0530
Message-ID: <20250204064417.3671928-6-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204064417.3671928-1-quic_rdevanat@quicinc.com>
References: <20250204064417.3671928-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: hx-TEWZsCp_INPbYiCXAzOqujvL5HsfN
X-Proofpoint-ORIG-GUID: hx-TEWZsCp_INPbYiCXAzOqujvL5HsfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040052

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request received Finite State Entropy stats from
firmware through HTT stats type 28. These stats give software and
hardware FSE stats such as cache entry count, full cache count,
current and peak occupancy count, pending search counts, etc.

Sample output:
-------------
echo 28 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_STATS_RX_FSE_STATS_TLV:
=== Software RX FSE STATS ===
Enable count  = 0
Disable count = 0
Cache invalidate entry count = 0
Full cache invalidate count = 0

=== Hardware RX FSE STATS ===
Cache hits count = 0
Cache no. of searches = 0
Cache occupancy peak count:
[0] = 0 [1-16] = 0 [17-32] = 0 [33-48] = 0 [49-64] = 0 [65-80] = 0 [81-96] = 0 [97-112] = 0 [113-127] = 0 [128] = 0
Cache occupancy current count:
[0] = 0 [1-16] = 0 [17-32] = 0 [33-48] = 0 [49-64] = 0 [65-80] = 0 [81-96] = 0 [97-112] = 0 [113-127] = 0 [128] = 0
Cache search square count:
[0] = 0 [1-50] = 0 [51-100] = 0 [101-200] = 0 [201-255] = 0 [256] = 0
Cache search peak pending count:
[0] = 0 [1-2] = 0 [3-4] = 0 [Greater/Equal to 5] = 0
Cache search tot pending count:
[0] = 0 [1-2] = 0 [3-4] = 0 [Greater/Equal to 5] = 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 91 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 22 +++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 935ea9852a8e..1c0d5fa39a8d 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -3200,6 +3200,94 @@ ath12k_htt_print_ul_mumimo_trig_stats(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_rx_fse_stats_tlv(const void *tag_buf, u16 tag_len,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_fse_stats_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_RX_FSE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "=== Software RX FSE STATS ===\n");
+	len += scnprintf(buf + len, buf_len - len, "Enable count  = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_enable_cnt));
+	len += scnprintf(buf + len, buf_len - len, "Disable count = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_disable_cnt));
+	len += scnprintf(buf + len, buf_len - len, "Cache invalidate entry count = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_cache_invalidate_entry_cnt));
+	len += scnprintf(buf + len, buf_len - len, "Full cache invalidate count = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_full_cache_invalidate_cnt));
+
+	len += scnprintf(buf + len, buf_len - len, "\n=== Hardware RX FSE STATS ===\n");
+	len += scnprintf(buf + len, buf_len - len, "Cache hits count = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_num_cache_hits_cnt));
+	len += scnprintf(buf + len, buf_len - len, "Cache no. of searches = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_num_searches_cnt));
+	len += scnprintf(buf + len, buf_len - len, "Cache occupancy peak count:\n");
+	len += scnprintf(buf + len, buf_len - len, "[0] = %u [1-16] = %u [17-32] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[0]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[1]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[2]));
+	len += scnprintf(buf + len, buf_len - len, "[33-48] = %u [49-64] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[3]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[4]));
+	len += scnprintf(buf + len, buf_len - len, "[65-80] = %u [81-96] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[5]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[6]));
+	len += scnprintf(buf + len, buf_len - len, "[97-112] = %u [113-127] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[7]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[8]));
+	len += scnprintf(buf + len, buf_len - len, "[128] = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_peak_cnt[9]));
+	len += scnprintf(buf + len, buf_len - len, "Cache occupancy current count:\n");
+	len += scnprintf(buf + len, buf_len - len, "[0] = %u [1-16] = %u [17-32] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[0]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[1]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[2]));
+	len += scnprintf(buf + len, buf_len - len, "[33-48] = %u [49-64] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[3]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[4]));
+	len += scnprintf(buf + len, buf_len - len, "[65-80] = %u [81-96] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[5]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[6]));
+	len += scnprintf(buf + len, buf_len - len, "[97-112] = %u [113-127] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[7]),
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[8]));
+	len += scnprintf(buf + len, buf_len - len, "[128] = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_cache_occupancy_curr_cnt[9]));
+	len += scnprintf(buf + len, buf_len - len, "Cache search square count:\n");
+	len += scnprintf(buf + len, buf_len - len, "[0] = %u [1-50] = %u [51-100] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_square_cnt[0]),
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_square_cnt[1]),
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_square_cnt[2]));
+	len += scnprintf(buf + len, buf_len - len, "[101-200] = %u [201-255] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_square_cnt[3]),
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_square_cnt[4]));
+	len += scnprintf(buf + len, buf_len - len, "[256] = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_square_cnt[5]));
+	len += scnprintf(buf + len, buf_len - len, "Cache search peak pending count:\n");
+	len += scnprintf(buf + len, buf_len - len, "[0] = %u [1-2] = %u [3-4] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_peak_cnt[0]),
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_peak_cnt[1]),
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_peak_cnt[2]));
+	len += scnprintf(buf + len, buf_len - len, "[Greater/Equal to 5] = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_peak_cnt[3]));
+	len += scnprintf(buf + len, buf_len - len, "Cache search tot pending count:\n");
+	len += scnprintf(buf + len, buf_len - len, "[0] = %u [1-2] = %u [3-4] = %u ",
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_pending_cnt[0]),
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_pending_cnt[1]),
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_pending_cnt[2]));
+	len += scnprintf(buf + len, buf_len - len, "[Greater/Equal to 5] = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->fse_search_stat_pending_cnt[3]));
+
+	stats_req->buf_len = len;
+}
+
 static void
 ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(const void *tag_buf, u16 tag_len,
 					     struct debug_htt_stats_req *stats_req)
@@ -5121,6 +5209,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_RX_PDEV_UL_MUMIMO_TRIG_STATS_TAG:
 		ath12k_htt_print_ul_mumimo_trig_stats(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_RX_FSE_STATS_TAG:
+		ath12k_htt_print_rx_fse_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG:
 		ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 9700412c03e0..c2a02cf8a38b 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -141,6 +141,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_LATENCY_PROF_STATS		= 25,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_UL_TRIG_STATS		= 26,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_UL_MUMIMO_TRIG_STATS	= 27,
+	ATH12K_DBG_HTT_EXT_STATS_FSE_RX				= 28,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE_EXT		= 30,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF		= 31,
 	ATH12K_DBG_HTT_EXT_STATS_TXBF_OFDMA			= 32,
@@ -215,6 +216,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_RX_PDEV_UL_TRIG_STATS_TAG		= 94,
 	HTT_STATS_RX_PDEV_UL_OFDMA_USER_STATS_TAG	= 95,
 	HTT_STATS_RX_PDEV_UL_MUMIMO_TRIG_STATS_TAG	= 97,
+	HTT_STATS_RX_FSE_STATS_TAG			= 98,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
 	HTT_STATS_RX_PDEV_RATE_EXT_STATS_TAG		= 103,
@@ -1450,6 +1452,26 @@ struct ath12k_htt_rx_ul_mumimo_trig_stats_tlv {
 	__le32 mumimo_bsc_trig_rx_qos_null_only;
 } __packed;
 
+#define ATH12K_HTT_RX_NUM_MAX_PEAK_OCCUPANCY_INDEX	10
+#define ATH12K_HTT_RX_NUM_MAX_CURR_OCCUPANCY_INDEX	10
+#define ATH12K_HTT_RX_NUM_SQUARE_INDEX			6
+#define ATH12K_HTT_RX_NUM_MAX_PEAK_SEARCH_INDEX		4
+#define ATH12K_HTT_RX_NUM_MAX_PENDING_SEARCH_INDEX	4
+
+struct ath12k_htt_rx_fse_stats_tlv {
+	__le32 fse_enable_cnt;
+	__le32 fse_disable_cnt;
+	__le32 fse_cache_invalidate_entry_cnt;
+	__le32 fse_full_cache_invalidate_cnt;
+	__le32 fse_num_cache_hits_cnt;
+	__le32 fse_num_searches_cnt;
+	__le32 fse_cache_occupancy_peak_cnt[ATH12K_HTT_RX_NUM_MAX_PEAK_OCCUPANCY_INDEX];
+	__le32 fse_cache_occupancy_curr_cnt[ATH12K_HTT_RX_NUM_MAX_CURR_OCCUPANCY_INDEX];
+	__le32 fse_search_stat_square_cnt[ATH12K_HTT_RX_NUM_SQUARE_INDEX];
+	__le32 fse_search_stat_peak_cnt[ATH12K_HTT_RX_NUM_MAX_PEAK_SEARCH_INDEX];
+	__le32 fse_search_stat_pending_cnt[ATH12K_HTT_RX_NUM_MAX_PENDING_SEARCH_INDEX];
+} __packed;
+
 #define ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS		14
 #define ATH12K_HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS		8
 #define ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS		8
-- 
2.25.1


