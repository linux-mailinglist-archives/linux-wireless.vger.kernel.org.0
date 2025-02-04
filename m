Return-Path: <linux-wireless+bounces-18383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1467A26C40
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DBB165E4C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B34413212A;
	Tue,  4 Feb 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UW4n1yk3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0321FF7B9
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738651491; cv=none; b=XKTS4KHWDU33a8Ocyj+zEUDasS2g8igEqrPmOT1oc96P9rvThZAKgFAwEUpDftokRy8hvfXqkxGEzo64GsHnoPfnVeHMUnY+g8oq0ICgdP4qEQMiC0/oPlaUSspV9o14Ph+oQNxtJafSq/rMdSwijvFVXzhlQmrK/3XvrlzrX/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738651491; c=relaxed/simple;
	bh=v7WWfIPmK99t370YFUjLsDuH92aEhQi8ezcU3J8a5OM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QphSATV6Ei4z/ihAAvCFyZScWiakUwGQjXQ3cUROHlrklNfKAOao8imIqL3pw1NqZe2rIVD9+kZNrmBOy5uoKvYoZb6HtStblPYGLtgJIO47b4pfulRRR2cOaVCKyblC8PTYUxiqsioWgU9RSnS7DyuCa+eNu/Ol8V0XvsHB3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UW4n1yk3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5145eYP6010319;
	Tue, 4 Feb 2025 06:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R/U7Ll7zPy0QA8AuiZPGzjkE2eFO9YJCW+IPUX+XdEg=; b=UW4n1yk3jbi69oh2
	865kUK7677sVUjuGbFZXtTB3sv6/TOTVss/v4SkHO+hwVtnx93OrCaOniQhLjoMN
	3Q3khjsL8JOHL4D55+ohoWk8M19nK73mIQX6iL9hO2wBA71dn/RLpK4QXqC80ChB
	NrRPL/4vsqYvpP2BnSxkkj4LmC9d6apBvFsaZY+8T8XwqIn/Yd6cM0X/8CpuqE3e
	IFjKOA0FRM/hExKnRvnO6nsU9u80UQOLooLQoVD6o5Kijs7hSJH4BsrjNzD3hCrX
	fFCG0dEwB6TPtUqEVkd4ukgaQabhoa0wGqGmQBh6Er2YJ2/AX46UYmIA1HtRt2po
	gap27g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kcxm83vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 06:44:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5146ijq8030771
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 06:44:45 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 22:44:43 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v5 2/5] wifi: ath12k: Support Latency Stats
Date: Tue, 4 Feb 2025 12:14:14 +0530
Message-ID: <20250204064417.3671928-3-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: n34VCnAQiyMTjlvnqxd3lu2OSUt5zjKc
X-Proofpoint-ORIG-GUID: n34VCnAQiyMTjlvnqxd3lu2OSUt5zjKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=978 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040052

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request latency stats from firmware through HTT stats
type 25. These stats give information about count of transmitted and
received MAC Protocol Data Units(PDU) and Service Data Units(SDU)
and other latency stats.

Sample output:
-------------
echo 25 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_STATS_LATENCY_CTX_TLV:
duration = 0
tx_msdu_cnt = 0
tx_mpdu_cnt = 0
rx_msdu_cnt = 0
rx_mpdu_cnt = 0

HTT_STATS_LATENCY_PROF_TLV:
Latency name = PROF_SCH_ENQ_TQM_CMDS
count = 0
minimum = 4294967295
maximum = 0
.....

HTT_STATS_LATENCY_CNT_TLV:
prof_enable_cnt = 39

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 94 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 34 +++++++
 2 files changed, 128 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 9998c5cf7ab0..0abca93e0802 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2838,6 +2838,91 @@ ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_latency_prof_ctx_tlv(const void *tag_buf, u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_latency_prof_ctx_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_LATENCY_CTX_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "duration = %u\n",
+			 le32_to_cpu(htt_stats_buf->duration));
+	len += scnprintf(buf + len, buf_len - len, "tx_msdu_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "tx_mpdu_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_mpdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_msdu_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_mpdu_cnt = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->rx_mpdu_cnt));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_latency_prof_cnt(const void *tag_buf, u16 tag_len,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_latency_prof_cnt_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_LATENCY_CNT_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "prof_enable_cnt = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->prof_enable_cnt));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_latency_prof_stats_tlv(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_latency_prof_stats_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	if (le32_to_cpu(htt_stats_buf->print_header) == 1) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "HTT_STATS_LATENCY_PROF_TLV:\n");
+	}
+
+	len += scnprintf(buf + len, buf_len - len, "Latency name = %s\n",
+			 htt_stats_buf->latency_prof_name);
+	len += scnprintf(buf + len, buf_len - len, "count = %u\n",
+			 le32_to_cpu(htt_stats_buf->cnt));
+	len += scnprintf(buf + len, buf_len - len, "minimum = %u\n",
+			 le32_to_cpu(htt_stats_buf->min));
+	len += scnprintf(buf + len, buf_len - len, "maximum = %u\n",
+			 le32_to_cpu(htt_stats_buf->max));
+	len += scnprintf(buf + len, buf_len - len, "last = %u\n",
+			 le32_to_cpu(htt_stats_buf->last));
+	len += scnprintf(buf + len, buf_len - len, "total = %u\n",
+			 le32_to_cpu(htt_stats_buf->tot));
+	len += scnprintf(buf + len, buf_len - len, "average = %u\n",
+			 le32_to_cpu(htt_stats_buf->avg));
+	len += scnprintf(buf + len, buf_len - len, "histogram interval = %u\n",
+			 le32_to_cpu(htt_stats_buf->hist_intvl));
+	len += print_array_to_buf(buf, len, "histogram", htt_stats_buf->hist,
+				  ATH12K_HTT_LATENCY_PROFILE_NUM_MAX_HIST, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
 static void
 ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(const void *tag_buf, u16 tag_len,
 					     struct debug_htt_stats_req *stats_req)
@@ -4741,6 +4826,15 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_OBSS_PD_TAG:
 		ath12k_htt_print_pdev_obss_pd_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_LATENCY_CTX_TAG:
+		ath12k_htt_print_latency_prof_ctx_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_LATENCY_CNT_TAG:
+		ath12k_htt_print_latency_prof_cnt(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_LATENCY_PROF_STATS_TAG:
+		ath12k_htt_print_latency_prof_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG:
 		ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index a4dd894df077..1b835473f419 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -138,6 +138,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO	= 22,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
+	ATH12K_DBG_HTT_EXT_STATS_LATENCY_PROF_STATS	= 25,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE_EXT	= 30,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF	= 31,
 	ATH12K_DBG_HTT_EXT_STATS_TXBF_OFDMA		= 32,
@@ -206,6 +207,9 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
 	HTT_STATS_PDEV_OBSS_PD_TAG			= 88,
 	HTT_STATS_HW_WAR_TAG				= 89,
+	HTT_STATS_LATENCY_PROF_STATS_TAG		= 91,
+	HTT_STATS_LATENCY_CTX_TAG			= 92,
+	HTT_STATS_LATENCY_CNT_TAG			= 93,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
 	HTT_STATS_RX_PDEV_RATE_EXT_STATS_TAG		= 103,
@@ -1340,6 +1344,36 @@ struct ath12k_htt_pdev_obss_pd_stats_tlv {
 	__le32 num_sr_ppdu_abort_flush_cnt;
 } __packed;
 
+#define ATH12K_HTT_STATS_MAX_PROF_STATS_NAME_LEN	32
+#define ATH12K_HTT_LATENCY_PROFILE_NUM_MAX_HIST		3
+#define ATH12K_HTT_INTERRUPTS_LATENCY_PROFILE_MAX_HIST	3
+
+struct ath12k_htt_latency_prof_stats_tlv {
+	__le32 print_header;
+	s8 latency_prof_name[ATH12K_HTT_STATS_MAX_PROF_STATS_NAME_LEN];
+	__le32 cnt;
+	__le32 min;
+	__le32 max;
+	__le32 last;
+	__le32 tot;
+	__le32 avg;
+	__le32 hist_intvl;
+	__le32 hist[ATH12K_HTT_LATENCY_PROFILE_NUM_MAX_HIST];
+}  __packed;
+
+struct ath12k_htt_latency_prof_ctx_tlv {
+	__le32 duration;
+	__le32 tx_msdu_cnt;
+	__le32 tx_mpdu_cnt;
+	__le32 tx_ppdu_cnt;
+	__le32 rx_msdu_cnt;
+	__le32 rx_mpdu_cnt;
+} __packed;
+
+struct ath12k_htt_latency_prof_cnt_tlv {
+	__le32 prof_enable_cnt;
+} __packed;
+
 #define ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS		14
 #define ATH12K_HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS		8
 #define ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS		8
-- 
2.25.1


