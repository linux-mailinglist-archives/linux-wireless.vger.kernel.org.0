Return-Path: <linux-wireless+bounces-17390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF47A0AFAB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D80C1652B8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124D231A26;
	Mon, 13 Jan 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UI1o8YF+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B2231C9C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736752334; cv=none; b=pjuKsh+3yCsu7lKCwCgwCU3S5kubqEdza22dqdsvKRRYwVk3ACtsn4fbiUin9wgLRBM6rvzye6wCeAaRoVPcUc0rkMRdndiFnlFk0NQlXbmzR407pURYPt8dkqOFy3cKZbTXOdVRnhjv0gUpJUUnJeLcKt/xY7glQ44oEPYFJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736752334; c=relaxed/simple;
	bh=aCQ+60GGLd1ApoKn37iJfBNJqhzzt9Ct7mHDUDrbuhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m07M18L0bg1ifRVwZ1FUXgcZVJ9tl8c5L+TkN8t53Zn8FP5WdHWdyGSRFddJhwuBOmW2uJ/7Wq5pe4bwDHOH2vljZjnv6dzxgDLHxAwf0ha0GTXPlLv2o4J1cSU5x4UD8jgJxWq3rjS18l0Et5FAsKEygeIFF92f0JU8rAIb6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UI1o8YF+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D4tUJe003923;
	Mon, 13 Jan 2025 07:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWR1KdB8UHfgIGUt+igvIycQlGJXZTzODtLFwIe0WxI=; b=UI1o8YF+4NhgR1RE
	5eBPZGXlduqh7Fu4DVyHdtQphf6yvIoIanVN0Vdes8BILW8JkXZaEvRp4SyNH1N6
	g+C8S+RN1ubEMH16uygj3D+RRHWHFiFRFVAn9FoCTf6oqiQEeA32nImgjvMMJUi2
	mS0lxYAdtDF9v4DYCAyBQ6XYGuGGo56DIpuC4mRYsydaCj3Q+K9K/dTUbZHiSk0r
	Fv5ZGZvGwmVWTKftAzkV9gkUigglOG4XZYfePneBo+pOsaUGxn3bnA25gRZNSosk
	SGHUulDz7EFIsVs2a3wxVEUPg0q3vn/GqtPJ+Kw9MirxzcFqMqlQXqDPxgsFoV9K
	lbq9mQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444v7288sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:12:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D7CAox008780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:12:10 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 Jan 2025 23:12:08 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v3 2/6] wifi: ath12k: Support Latency Stats
Date: Mon, 13 Jan 2025 12:41:40 +0530
Message-ID: <20250113071144.3397293-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113071144.3397293-1-quic_rdevanat@quicinc.com>
References: <20250113071144.3397293-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: y5c9UiQeygJKSgCiSsKIVj5hY2WBFS48
X-Proofpoint-ORIG-GUID: y5c9UiQeygJKSgCiSsKIVj5hY2WBFS48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxlogscore=895 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130060

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

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 94 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 34 +++++++
 2 files changed, 128 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 7381e5a615d0..9bc4cf8d91ab 100644
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
@@ -4250,6 +4335,15 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
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
index 238a45e0d296..4578c5a6d12d 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -136,6 +136,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO	= 22,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
+	ATH12K_DBG_HTT_EXT_STATS_LATENCY_PROF_STATS	= 25,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF	= 31,
 	ATH12K_DBG_HTT_EXT_STATS_TXBF_OFDMA		= 32,
 	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
@@ -201,6 +202,9 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
 	HTT_STATS_PDEV_OBSS_PD_TAG			= 88,
 	HTT_STATS_HW_WAR_TAG				= 89,
+	HTT_STATS_LATENCY_PROF_STATS_TAG		= 91,
+	HTT_STATS_LATENCY_CTX_TAG			= 92,
+	HTT_STATS_LATENCY_CNT_TAG			= 93,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
 	HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG		= 108,
@@ -1158,6 +1162,36 @@ struct ath12k_htt_pdev_obss_pd_stats_tlv {
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


