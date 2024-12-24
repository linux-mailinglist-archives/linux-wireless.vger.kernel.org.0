Return-Path: <linux-wireless+bounces-16764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361F69FBC70
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 11:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1215E16EA59
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276B1C5493;
	Tue, 24 Dec 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zc4GqxNG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318EC1C5484
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035655; cv=none; b=GMZckLmvZgv3bzHoxp+6WvgGPbdeJWAT5R1GidvQmuhq35Fj+U221E+N/xdhGCB7u/eTCHiPzevfdvFdTg6ZTe9rVcPfDo348+V3agwM19H0vKir+uNUvy6DvrteGyI9HNMgtNuSlryIyjtAD7quYvxKnIN6ebaKv2w/Mw5yBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035655; c=relaxed/simple;
	bh=j9uinEzB/Zu2BsWnONI+xB8bf5nxmWlPUiJk8yyAOkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aC2kQmdS1vL1pkUWn7JctdQX1x8coErJVqx3deHCedf9m1AM2P+hlNXs4d3jrNDwrGBIaqgk2beNE+SfaX/P4rwA1zllPS2LGPIzn/c/0SQmWLwWaMBQNNIPqWmn960TJvoW7xuhwG2uLLve0DiaMf/XUFZMHv3D4Cr8cMquObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zc4GqxNG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO6vUf7025265;
	Tue, 24 Dec 2024 10:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ARsxb6IWscFOktmJf9KuIvHIr+26QmgKNUOiRz5C8nc=; b=Zc4GqxNGaSKtJmQ2
	jPvsDdjZzcmI9Z+ZRE5pwEp0yVIQRUwfuEzKOqr6XPjegSw/gxQ8yuPQ+P0WSEC5
	uoU8Hs92FHiTPrFP+utu5do4j9bPG/qKtyodB6zw5o1SQnLgSCBOpF8WO2uFTARw
	A/xSEerBwLWZ4JO6tkZALuZSXu5ixrem+fkD6qzahKTK2EuY7YWAUXa9kRNFmS2Q
	eMgRrupXaLlxtOsrHm/LmV+F+EtQv3x0NJCQw+L3P1rYp0xbztxxmn0e0sgYxI0S
	zHB6OwJNJW6B5q3HI5N15aTROyLSsrKJAstKpnoSUecXGY27Xt7n4UNbyFH8M2xD
	apt57Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qr55s3pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:20:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOAKpWo010655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:20:51 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 02:20:49 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v2 6/6] wifi: ath12k: Support Received FSE Stats
Date: Tue, 24 Dec 2024 15:50:13 +0530
Message-ID: <20241224102013.1530055-7-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224102013.1530055-1-quic_rdevanat@quicinc.com>
References: <20241224102013.1530055-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n6xccWE6KgDlzXHbDj8YzckhMh3zSuoK
X-Proofpoint-GUID: n6xccWE6KgDlzXHbDj8YzckhMh3zSuoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412240087

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
index ba1cf6953536..f1eb5f993ab2 100644
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
@@ -4498,6 +4586,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
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
index 043211773c78..34d87a9f9b08 100644
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
@@ -1357,6 +1359,26 @@ struct ath12k_htt_rx_ul_mumimo_trig_stats_tlv {
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


