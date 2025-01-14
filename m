Return-Path: <linux-wireless+bounces-17491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B1A106DD
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 13:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EF23A8C65
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71361236A65;
	Tue, 14 Jan 2025 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q05uRmc+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AC236A7D
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858363; cv=none; b=fRtQDrP8/nO6RY2acFlJ6bS37Xkh01tIIlQXK/FhVuFIeCPwT62PBW4GlSVVM9KPhzDwbyMb+TdvcPPxVh9iwy6+SPhh4ze/QVXLgWmBX3xPV4sd4GCFmxvOb4tQEuxMTKQ9sYP/mrcpKbfTGBBXBLf7kDwZoUbTZMKT3LazoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858363; c=relaxed/simple;
	bh=3iFIzgwYyj6cG8NJwf9vTVsNpC7L0CM9dK4oicbJooY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqpZHYY+MspIYjhiiRfcN6CBxiSAdZxVULuyBrYTMBXYSofg+5x6fnvhS7Un1/uY29midqXAI7ilKm8UixzlZnBVvtXBpuUJgrruyfSCTX4Vcl+sZVZR9ZujgR00svgS/Ap0McEVYBNsyHmGIqvbJ56MkvTBZLh6ouU7xC4COMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q05uRmc+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EBFDnO002021;
	Tue, 14 Jan 2025 12:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jyU6CVlnJdip/+hLWM3/xG5Sa7VTzRnaAuws3t4PQ8E=; b=Q05uRmc+sXHINMVk
	kPxIAWotGylFomTwSxjfqyFULDf5pMp+t+EaEeDORcPa01PvU9nRNF0jBWGWO+EM
	gryDU8EFcGiiWHexbPyt5RUicu5+pmTXs9cQof5FyowQ459sfakGxwL3sS0XExk+
	oBO6q2xkQR6CeOq+1YwL3G6GU5GTT+/cDy5aGBEw6nvkoD0L9MkOplCa3915i9CE
	GwMiCqZUPL+asqK5iNg4IbcrLg6RweY21gDSVlGoBHQEChkHi5mOflz/BOjYPkqE
	aDI+Jfy05TVlYgyzcSw30cCrPi90WXRgddwdXmp3cNvm+QFlQHaEg0ALqyF515HG
	ESBpHg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445pvnr5bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 12:39:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ECdIaq006802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 12:39:18 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 04:39:16 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v4 5/5] wifi: ath12k: Support Received FSE Stats
Date: Tue, 14 Jan 2025 18:08:35 +0530
Message-ID: <20250114123835.882926-6-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114123835.882926-1-quic_rdevanat@quicinc.com>
References: <20250114123835.882926-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: L5_ta9SMrK0A70D9T4UQhmMZr_7aDHzH
X-Proofpoint-ORIG-GUID: L5_ta9SMrK0A70D9T4UQhmMZr_7aDHzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140105

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

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 91 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 22 +++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index e74245c7ed0e..82fe47ec5a31 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -3526,6 +3526,94 @@ ath12k_htt_print_ul_mumimo_trig_stats(const void *tag_buf, u16 tag_len,
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
 static void ath12k_htt_print_dlpager_entry(const struct ath12k_htt_pgs_info *pg_info,
 					   int idx, char *str_buf)
 {
@@ -4649,6 +4737,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_RX_PDEV_UL_MUMIMO_TRIG_STATS_TAG:
 		ath12k_htt_print_ul_mumimo_trig_stats(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_RX_FSE_STATS_TAG:
+		ath12k_htt_print_rx_fse_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_DLPAGER_STATS_TAG:
 		ath12k_htt_print_dlpager_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 588211605e80..bafe7c3935cd 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -139,6 +139,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_LATENCY_PROF_STATS		= 25,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_UL_TRIG_STATS		= 26,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_UL_MUMIMO_TRIG_STATS	= 27,
+	ATH12K_DBG_HTT_EXT_STATS_FSE_RX				= 28,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF		= 31,
 	ATH12K_DBG_HTT_EXT_STATS_TXBF_OFDMA			= 32,
 	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS			= 36,
@@ -210,6 +211,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_RX_PDEV_UL_TRIG_STATS_TAG		= 94,
 	HTT_STATS_RX_PDEV_UL_OFDMA_USER_STATS_TAG	= 95,
 	HTT_STATS_RX_PDEV_UL_MUMIMO_TRIG_STATS_TAG	= 97,
+	HTT_STATS_RX_FSE_STATS_TAG			= 98,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
 	HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG		= 108,
@@ -1359,6 +1361,26 @@ struct ath12k_htt_rx_ul_mumimo_trig_stats_tlv {
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
 enum ath12k_htt_stats_page_lock_state {
 	ATH12K_HTT_STATS_PAGE_LOCKED	= 0,
 	ATH12K_HTT_STATS_PAGE_UNLOCKED	= 1,
-- 
2.25.1


