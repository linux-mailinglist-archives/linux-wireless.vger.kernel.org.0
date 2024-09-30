Return-Path: <linux-wireless+bounces-13325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A098AAFB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 19:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0541F21971
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD3194096;
	Mon, 30 Sep 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mRat9Izw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260B193416
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716764; cv=none; b=h6Q8ytFM6PtDIMjPD2Nit8u6ijwxsHvoPgitfUXND88JKZ/DnwVcsAiO1PqnIPR4+RXBOyYgdn5/gowzQpyRliuW5UEoQgcZwV7gbhKuQm9jSBFWAxrJOH3dvWHL/+cPoildO+h8pcHBlXleoyYVE6wSNOUU6tyrLkes+w4AT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716764; c=relaxed/simple;
	bh=7H8xyNY2x1fy7hYtPGPRT6paQVLXBEmByKzcQsM9p4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ht/fOCw1MhOhIMuo68nTehAwT/aljO6nhrsxG9XRygLqiZ5/LkW0vnZT5h2GKEFrFc6sH2xtABuhk6bkjNbRvv062dzrDl24ROsvQ8ahedlAhhoitLi5CQT3/IYR788fatWJEcSj44EYlamO9ArAoY9SbRH/j9NNLner0XUOIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mRat9Izw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBeGEv028443;
	Mon, 30 Sep 2024 17:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y1mHFURBTDKpLRo6FdUZC8d2X95x6krR9LETfcTAUW4=; b=mRat9Izw+jbwY2LN
	ePr1GkrPh9Ee05db/LLtptaFe6NANiNAtIXUBQqQ6haBYC9vdEIWDBdpFEKpHrRk
	o827q6injo/jTmFqQ6Yx4WcH7p+JBtu7CwN7vfL+sWf5NJyQA4h/5bj+z5aPD/E+
	RVm8xg9Fnemid5EQtGdkc5uBJyqq2YFasxJuJx3uwWNA1TD5a2ZbUHi3whpWhWWq
	V5FLBIvJfoVPFju45EhQBFDASFEIPNXKY3KlLgVSjMvXUOVVajjGeU+Y4zSsYJFv
	o2FWBNserW774Lgilo+ykS8eERQdRUbcC3Ul9e9easBuLkI4V3qFoWiDh2MGmR7i
	s1RTdw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x94hdh9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:19:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48UHJI3o015265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:19:18 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 10:19:15 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sidhanta Sahu
	<quic_sidhanta@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: Support Pdev Scheduled Algorithm Stats
Date: Mon, 30 Sep 2024 22:47:04 +0530
Message-ID: <20240930171705.596703-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930171705.596703-1-quic_rdevanat@quicinc.com>
References: <20240930171705.596703-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: E5fzX3xF9LJneY3xz5kgfhZ_5iD7Pd76
X-Proofpoint-ORIG-GUID: E5fzX3xF9LJneY3xz5kgfhZ_5iD7Pd76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300124

From: Sidhanta Sahu <quic_sidhanta@quicinc.com>

Add support to request scheduled algorithm stats from firmware
through HTT stats type 49. These stats give information such
as count of DLOFDMA enabled, disabled, probed and monitored
based on rate and latency, consecutive number of MPDUs tried
and succeeded, etc.

Note: WCN7850 firmware version -
WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
does not support HTT stats type 49.

Sample output:
-------------
echo 49 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_PDEV_SCHED_ALGO_TLV:
mac_id = 0
rate_based_dlofdma_enabled_count =  0:0, 1:0, 2:0, 3:0
rate_based_dlofdma_disabled_count =  0:0, 1:0, 2:0, 3:0
rate_based_dlofdma_probing_count =  0:0, 1:0, 2:0, 3:0
rate_based_dlofdma_monitoring_count =  0:0, 1:0, 2:0, 3:0
chan_acc_lat_based_dlofdma_enabled_count =  0:0, 1:0, 2:0, 3:0
chan_acc_lat_based_dlofdma_disabled_count =  0:0, 1:0, 2:0, 3:0
chan_acc_lat_based_dlofdma_monitoring_count =  0:0, 1:0, 2:0, 3:0
downgrade_to_dl_su_ru_alloc_fail =  0:0, 1:0, 2:0, 3:0
candidate_list_single_user_disable_ofdma =  0:0, 1:0, 2:0, 3:0
dl_cand_list_dropped_high_ul_qos_weight =  0:0, 1:0, 2:0, 3:0
ax_dlofdma_disabled_due_to_pipelining =  0:0, 1:0, 2:0, 3:0
dlofdma_disabled_su_only_eligible =  0:0, 1:0, 2:0, 3:0
dlofdma_disabled_consec_no_mpdus_tried =  0:0, 1:0, 2:0, 3:0
dlofdma_disabled_consec_no_mpdus_success =  0:0, 1:0, 2:0, 3:0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 67 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 20 ++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 64aed7990dfd..f6dc338dd311 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2534,6 +2534,70 @@ ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_pdev_sched_algo_ofdma_stats_tlv(const void *tag_buf, u16 tag_len,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_sched_algo_ofdma_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id_word = le32_to_cpu(htt_stats_buf->mac_id__word);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_SCHED_ALGO_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += print_array_to_buf(buf, len, "rate_based_dlofdma_enabled_count",
+				  htt_stats_buf->rate_based_dlofdma_enabled_cnt,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "rate_based_dlofdma_disabled_count",
+				  htt_stats_buf->rate_based_dlofdma_disabled_cnt,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "rate_based_dlofdma_probing_count",
+				  htt_stats_buf->rate_based_dlofdma_disabled_cnt,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "rate_based_dlofdma_monitoring_count",
+				  htt_stats_buf->rate_based_dlofdma_monitor_cnt,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "chan_acc_lat_based_dlofdma_enabled_count",
+				  htt_stats_buf->chan_acc_lat_based_dlofdma_enabled_cnt,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "chan_acc_lat_based_dlofdma_disabled_count",
+				  htt_stats_buf->chan_acc_lat_based_dlofdma_disabled_cnt,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "chan_acc_lat_based_dlofdma_monitoring_count",
+				  htt_stats_buf->chan_acc_lat_based_dlofdma_monitor_cnt,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "downgrade_to_dl_su_ru_alloc_fail",
+				  htt_stats_buf->downgrade_to_dl_su_ru_alloc_fail,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "candidate_list_single_user_disable_ofdma",
+				  htt_stats_buf->candidate_list_single_user_disable_ofdma,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "dl_cand_list_dropped_high_ul_qos_weight",
+				  htt_stats_buf->dl_cand_list_dropped_high_ul_qos_weight,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "ax_dlofdma_disabled_due_to_pipelining",
+				  htt_stats_buf->ax_dlofdma_disabled_due_to_pipelining,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "dlofdma_disabled_su_only_eligible",
+				  htt_stats_buf->dlofdma_disabled_su_only_eligible,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "dlofdma_disabled_consec_no_mpdus_tried",
+				  htt_stats_buf->dlofdma_disabled_consec_no_mpdus_tried,
+				  ATH12K_HTT_NUM_AC_WMM, "\n");
+	len += print_array_to_buf(buf, len, "dlofdma_disabled_consec_no_mpdus_success",
+				  htt_stats_buf->dlofdma_disabled_consec_no_mpdus_success,
+				  ATH12K_HTT_NUM_AC_WMM, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -2710,6 +2774,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_DMAC_RESET_STATS_TAG:
 		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG:
+		ath12k_htt_print_pdev_sched_algo_ofdma_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 120615fbe853..ae738396b10a 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -136,6 +136,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -198,6 +199,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
 	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
 	HTT_STATS_DMAC_RESET_STATS_TAG			= 155,
+	HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG	= 165,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -1063,4 +1065,22 @@ struct ath12k_htt_dmac_reset_stats_tlv {
 	__le32 drain_dest_ring_mask;
 } __packed;
 
+struct ath12k_htt_pdev_sched_algo_ofdma_stats_tlv {
+	__le32 mac_id__word;
+	__le32 rate_based_dlofdma_enabled_cnt[ATH12K_HTT_NUM_AC_WMM];
+	__le32 rate_based_dlofdma_disabled_cnt[ATH12K_HTT_NUM_AC_WMM];
+	__le32 rate_based_dlofdma_probing_cnt[ATH12K_HTT_NUM_AC_WMM];
+	__le32 rate_based_dlofdma_monitor_cnt[ATH12K_HTT_NUM_AC_WMM];
+	__le32 chan_acc_lat_based_dlofdma_enabled_cnt[ATH12K_HTT_NUM_AC_WMM];
+	__le32 chan_acc_lat_based_dlofdma_disabled_cnt[ATH12K_HTT_NUM_AC_WMM];
+	__le32 chan_acc_lat_based_dlofdma_monitor_cnt[ATH12K_HTT_NUM_AC_WMM];
+	__le32 downgrade_to_dl_su_ru_alloc_fail[ATH12K_HTT_NUM_AC_WMM];
+	__le32 candidate_list_single_user_disable_ofdma[ATH12K_HTT_NUM_AC_WMM];
+	__le32 dl_cand_list_dropped_high_ul_qos_weight[ATH12K_HTT_NUM_AC_WMM];
+	__le32 ax_dlofdma_disabled_due_to_pipelining[ATH12K_HTT_NUM_AC_WMM];
+	__le32 dlofdma_disabled_su_only_eligible[ATH12K_HTT_NUM_AC_WMM];
+	__le32 dlofdma_disabled_consec_no_mpdus_tried[ATH12K_HTT_NUM_AC_WMM];
+	__le32 dlofdma_disabled_consec_no_mpdus_success[ATH12K_HTT_NUM_AC_WMM];
+} __packed;
+
 #endif
-- 
2.25.1


