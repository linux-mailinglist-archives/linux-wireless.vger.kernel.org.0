Return-Path: <linux-wireless+bounces-9521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C42915D94
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 06:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03B51C211AA
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 04:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6FA1849;
	Tue, 25 Jun 2024 04:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DHYRL2XT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE3413C681
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289382; cv=none; b=oKse2qQzvVl3Klsh+rVhOYLPCNZ8nKMuQCXXZsz6BMcwUVIGQlqU/kCYkiQQHY+dORNC9g/Cr++/5LqxILAk+BbQmA++jlBtdczkO6phzvIpPLuhaCiEnwPJnFH6k50JtiG4YxJPNgk1Cwkmu3u6EmBKL3SIc/B8z/PKSuCWxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289382; c=relaxed/simple;
	bh=Qb4+SYuzW5YR0DsltCCIKYy6tf9vwwY9KtWH4OxlYSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSZRpl4sjgobY3IC2wVAQmxyRSm7UNnvnqMFpRfHjDvkpbJhfo13SvfJ1xyyBRjXr3zOoyK7q93kMp0XGJdvhxbJzJlHA2czaJvE/QcmkhO8VHLJLELSml9Nx81XB1i6er2xQ5K3GKTYoJSTCwBkSYFsMHgcqpWEx542BxRdS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DHYRL2XT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OK1GOo014014;
	Tue, 25 Jun 2024 04:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vk/ulMZ+l3j6co3TpvUKo17NKMkaa/fr1j8Q0W5iTpo=; b=DHYRL2XT3Zkg7Bbb
	h4MCqUPKtAQ/q/A3T0rDh0rdvZ+c647h+k9seRfhIXUUMU+vnXeG0hHD0UNUuFPV
	wQAEBBvFV53iv08nQKE6qUeLQFte/UloDTCFOTUCRxEXRoIlhlKaEukFux9flyNI
	vZJzE0bulepbIHawyBqne7sTt/lsQSIQ5tuaaHg7K07vgz3S433ID62awtV1mgCL
	MRZq5T1AYZxjlaNvnUCN+RhrJ+wFA6x24SughZ1szGvyIFYXwJ7GHufG6ATDxAMB
	wEKXEuh0JjyD3xgzk63ynKO8MQ4aD6FvUfprq36U154gAneAuVZ+O0vALWGBNPFB
	ISKJlA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnxgwaaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:22:55 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45P4MsoU031295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:22:54 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 21:22:52 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: Support TQM stats
Date: Tue, 25 Jun 2024 09:52:17 +0530
Message-ID: <20240625042217.1303332-4-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625042217.1303332-1-quic_rdevanat@quicinc.com>
References: <20240625042217.1303332-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: 65jjn30xwxOLo2tJ22Cgu-MyM0KLUmUb
X-Proofpoint-ORIG-GUID: 65jjn30xwxOLo2tJ22Cgu-MyM0KLUmUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_01,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250030

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request pdev TQM stats from firmware through HTT stats
type 6. This stat type gives information such as TQM error, MPDU
related information and TQM pdev stats.

Sample output:
-------------
echo 6 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats

HTT_TX_TQM_ERROR_STATS_TLV:
q_empty_failure = 0
q_not_empty_failure = 0
add_msdu_failure = 0

TQM_ERROR_RESET_STATS:
tqm_cache_ctl_err = 0
tqm_soft_reset = 0
tqm_reset_total_num_in_use_link_descs = 0
.....

HTT_TX_TQM_GEN_MPDU_STATS_TLV:
gen_mpdu_end_reason =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0

HTT_TX_TQM_LIST_MPDU_STATS_TLV:
list_mpdu_end_reason =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
10:0, 11:0, 12:0

HTT_TX_TQM_LIST_MPDU_CNT_TLV_V:
list_mpdu_cnt_hist =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0

HTT_TX_TQM_PDEV_STATS_TLV_V:
msdu_count = 0
mpdu_count = 0
remove_msdu = 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 289 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 102 +++++++
 2 files changed, 391 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 0baa0f18a5a0..2ae97f82f1b5 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -842,6 +842,277 @@ ath12k_htt_print_hw_war_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_tx_tqm_cmn_stats_tlv(const void *tag_buf, u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_tqm_cmn_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id_word = __le32_to_cpu(htt_stats_buf->mac_id__word);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_CMN_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "max_cmdq_id = %u\n",
+			 le32_to_cpu(htt_stats_buf->max_cmdq_id));
+	len += scnprintf(buf + len, buf_len - len, "list_mpdu_cnt_hist_intvl = %u\n",
+			 le32_to_cpu(htt_stats_buf->list_mpdu_cnt_hist_intvl));
+	len += scnprintf(buf + len, buf_len - len, "add_msdu = %u\n",
+			 le32_to_cpu(htt_stats_buf->add_msdu));
+	len += scnprintf(buf + len, buf_len - len, "q_empty = %u\n",
+			 le32_to_cpu(htt_stats_buf->q_empty));
+	len += scnprintf(buf + len, buf_len - len, "q_not_empty = %u\n",
+			 le32_to_cpu(htt_stats_buf->q_not_empty));
+	len += scnprintf(buf + len, buf_len - len, "drop_notification = %u\n",
+			 le32_to_cpu(htt_stats_buf->drop_notification));
+	len += scnprintf(buf + len, buf_len - len, "desc_threshold = %u\n",
+			 le32_to_cpu(htt_stats_buf->desc_threshold));
+	len += scnprintf(buf + len, buf_len - len, "hwsch_tqm_invalid_status = %u\n",
+			 le32_to_cpu(htt_stats_buf->hwsch_tqm_invalid_status));
+	len += scnprintf(buf + len, buf_len - len, "missed_tqm_gen_mpdus = %u\n",
+			 le32_to_cpu(htt_stats_buf->missed_tqm_gen_mpdus));
+	len += scnprintf(buf + len, buf_len - len,
+			 "total_msduq_timestamp_updates = %u\n",
+			 le32_to_cpu(htt_stats_buf->msduq_timestamp_updates));
+	len += scnprintf(buf + len, buf_len - len,
+			 "total_msduq_timestamp_updates_by_get_mpdu_head_info_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->msduq_updates_mpdu_head_info_cmd));
+	len += scnprintf(buf + len, buf_len - len,
+			 "total_msduq_timestamp_updates_by_emp_to_nonemp_status = %u\n",
+			 le32_to_cpu(htt_stats_buf->msduq_updates_emp_to_nonemp_status));
+	len += scnprintf(buf + len, buf_len - len,
+			 "total_get_mpdu_head_info_cmds_by_sched_algo_la_query = %u\n",
+			 le32_to_cpu(htt_stats_buf->get_mpdu_head_info_cmds_by_query));
+	len += scnprintf(buf + len, buf_len - len,
+			 "total_get_mpdu_head_info_cmds_by_tac = %u\n",
+			 le32_to_cpu(htt_stats_buf->get_mpdu_head_info_cmds_by_tac));
+	len += scnprintf(buf + len, buf_len - len,
+			 "total_gen_mpdu_cmds_by_sched_algo_la_query = %u\n",
+			 le32_to_cpu(htt_stats_buf->gen_mpdu_cmds_by_query));
+	len += scnprintf(buf + len, buf_len - len, "active_tqm_tids = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_active_tids));
+	len += scnprintf(buf + len, buf_len - len, "inactive_tqm_tids = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_inactive_tids));
+	len += scnprintf(buf + len, buf_len - len, "tqm_active_msduq_flows = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_active_msduq_flows));
+	len += scnprintf(buf + len, buf_len - len, "hi_prio_q_not_empty = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->high_prio_q_not_empty));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_tqm_error_stats_tlv(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_tqm_error_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_ERROR_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "q_empty_failure = %u\n",
+			 le32_to_cpu(htt_stats_buf->q_empty_failure));
+	len += scnprintf(buf + len, buf_len - len, "q_not_empty_failure = %u\n",
+			 le32_to_cpu(htt_stats_buf->q_not_empty_failure));
+	len += scnprintf(buf + len, buf_len - len, "add_msdu_failure = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->add_msdu_failure));
+
+	len += scnprintf(buf + len, buf_len - len, "TQM_ERROR_RESET_STATS:\n");
+	len += scnprintf(buf + len, buf_len - len, "tqm_cache_ctl_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_cache_ctl_err));
+	len += scnprintf(buf + len, buf_len - len, "tqm_soft_reset = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_soft_reset));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_total_num_in_use_link_descs = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_num_in_use_link_descs));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_worst_case_num_lost_link_descs = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_num_lost_link_descs));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_worst_case_num_lost_host_tx_bufs_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_num_lost_host_tx_buf_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_num_in_use_link_descs_internal_tqm = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_num_in_use_internal_tqm));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_num_in_use_link_descs_wbm_idle_link_ring = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_num_in_use_idle_link_rng));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_time_to_tqm_hang_delta_ms = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_time_to_tqm_hang_delta_ms));
+	len += scnprintf(buf + len, buf_len - len, "tqm_reset_recovery_time_ms = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_recovery_time_ms));
+	len += scnprintf(buf + len, buf_len - len, "tqm_reset_num_peers_hdl = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_num_peers_hdl));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_cumm_dirty_hw_mpduq_proc_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_cumm_dirty_hw_mpduq_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_cumm_dirty_hw_msduq_proc = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_cumm_dirty_hw_msduq_proc));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_flush_cache_cmd_su_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_flush_cache_cmd_su_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_flush_cache_cmd_other_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_flush_cache_cmd_other_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_flush_cache_cmd_trig_type = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_flush_cache_cmd_trig_type));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_flush_cache_cmd_trig_cfg = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_flush_cache_cmd_trig_cfg));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tqm_reset_flush_cache_cmd_skip_cmd_status_null = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->tqm_reset_flush_cmd_skp_status_null));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_tqm_gen_mpdu_stats_tlv(const void *tag_buf, u16 tag_len,
+					   struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_tqm_gen_mpdu_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elements = tag_len >> 2;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_GEN_MPDU_STATS_TLV:\n");
+	len += print_array_to_buf(buf, len, "gen_mpdu_end_reason",
+				  htt_stats_buf->gen_mpdu_end_reason, num_elements,
+				  "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_tqm_list_mpdu_stats_tlv(const void *tag_buf, u16 tag_len,
+					    struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_tqm_list_mpdu_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_TX_TQM_MAX_LIST_MPDU_END_REASON);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_LIST_MPDU_STATS_TLV:\n");
+	len += print_array_to_buf(buf, len, "list_mpdu_end_reason",
+				  htt_stats_buf->list_mpdu_end_reason, num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_tqm_list_mpdu_cnt_tlv(const void *tag_buf, u16 tag_len,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_tqm_list_mpdu_cnt_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_LIST_MPDU_CNT_TLV_V:\n");
+	len += print_array_to_buf(buf, len, "list_mpdu_cnt_hist",
+				  htt_stats_buf->list_mpdu_cnt_hist, num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_tqm_pdev_stats_tlv(const void *tag_buf, u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_tqm_pdev_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_PDEV_STATS_TLV_V:\n");
+	len += scnprintf(buf + len, buf_len - len, "msdu_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->msdu_count));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_count));
+	len += scnprintf(buf + len, buf_len - len, "remove_msdu = %u\n",
+			 le32_to_cpu(htt_stats_buf->remove_msdu));
+	len += scnprintf(buf + len, buf_len - len, "remove_mpdu = %u\n",
+			 le32_to_cpu(htt_stats_buf->remove_mpdu));
+	len += scnprintf(buf + len, buf_len - len, "remove_msdu_ttl = %u\n",
+			 le32_to_cpu(htt_stats_buf->remove_msdu_ttl));
+	len += scnprintf(buf + len, buf_len - len, "send_bar = %u\n",
+			 le32_to_cpu(htt_stats_buf->send_bar));
+	len += scnprintf(buf + len, buf_len - len, "bar_sync = %u\n",
+			 le32_to_cpu(htt_stats_buf->bar_sync));
+	len += scnprintf(buf + len, buf_len - len, "notify_mpdu = %u\n",
+			 le32_to_cpu(htt_stats_buf->notify_mpdu));
+	len += scnprintf(buf + len, buf_len - len, "sync_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->sync_cmd));
+	len += scnprintf(buf + len, buf_len - len, "write_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->write_cmd));
+	len += scnprintf(buf + len, buf_len - len, "hwsch_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->hwsch_trigger));
+	len += scnprintf(buf + len, buf_len - len, "ack_tlv_proc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ack_tlv_proc));
+	len += scnprintf(buf + len, buf_len - len, "gen_mpdu_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->gen_mpdu_cmd));
+	len += scnprintf(buf + len, buf_len - len, "gen_list_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->gen_list_cmd));
+	len += scnprintf(buf + len, buf_len - len, "remove_mpdu_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->remove_mpdu_cmd));
+	len += scnprintf(buf + len, buf_len - len, "remove_mpdu_tried_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->remove_mpdu_tried_cmd));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_queue_stats_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_queue_stats_cmd));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_head_info_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_head_info_cmd));
+	len += scnprintf(buf + len, buf_len - len, "msdu_flow_stats_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->msdu_flow_stats_cmd));
+	len += scnprintf(buf + len, buf_len - len, "remove_msdu_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->remove_msdu_cmd));
+	len += scnprintf(buf + len, buf_len - len, "remove_msdu_ttl_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->remove_msdu_ttl_cmd));
+	len += scnprintf(buf + len, buf_len - len, "flush_cache_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->flush_cache_cmd));
+	len += scnprintf(buf + len, buf_len - len, "update_mpduq_cmd = %u\n",
+			 le32_to_cpu(htt_stats_buf->update_mpduq_cmd));
+	len += scnprintf(buf + len, buf_len - len, "enqueue = %u\n",
+			 le32_to_cpu(htt_stats_buf->enqueue));
+	len += scnprintf(buf + len, buf_len - len, "enqueue_notify = %u\n",
+			 le32_to_cpu(htt_stats_buf->enqueue_notify));
+	len += scnprintf(buf + len, buf_len - len, "notify_mpdu_at_head = %u\n",
+			 le32_to_cpu(htt_stats_buf->notify_mpdu_at_head));
+	len += scnprintf(buf + len, buf_len - len, "notify_mpdu_state_valid = %u\n",
+			 le32_to_cpu(htt_stats_buf->notify_mpdu_state_valid));
+	len += scnprintf(buf + len, buf_len - len, "sched_udp_notify1 = %u\n",
+			 le32_to_cpu(htt_stats_buf->sched_udp_notify1));
+	len += scnprintf(buf + len, buf_len - len, "sched_udp_notify2 = %u\n",
+			 le32_to_cpu(htt_stats_buf->sched_udp_notify2));
+	len += scnprintf(buf + len, buf_len - len, "sched_nonudp_notify1 = %u\n",
+			 le32_to_cpu(htt_stats_buf->sched_nonudp_notify1));
+	len += scnprintf(buf + len, buf_len - len, "sched_nonudp_notify2 = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->sched_nonudp_notify2));
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -905,6 +1176,24 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_HW_WAR_TAG:
 		ath12k_htt_print_hw_war_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_TQM_CMN_TAG:
+		ath12k_htt_print_tx_tqm_cmn_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_TQM_ERROR_STATS_TAG:
+		ath12k_htt_print_tx_tqm_error_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_TQM_GEN_MPDU_TAG:
+		ath12k_htt_print_tx_tqm_gen_mpdu_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_TQM_LIST_MPDU_TAG:
+		ath12k_htt_print_tx_tqm_list_mpdu_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG:
+		ath12k_htt_print_tx_tqm_list_mpdu_cnt_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_TQM_PDEV_TAG:
+		ath12k_htt_print_tx_tqm_pdev_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index f5a0553732a2..26a0c01f8020 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -127,6 +127,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX	= 1,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED	= 4,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR	= 5,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM	= 6,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -137,9 +138,15 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_UNDERRUN_TAG			= 1,
 	HTT_STATS_TX_PDEV_SIFS_TAG			= 2,
 	HTT_STATS_TX_PDEV_FLUSH_TAG			= 3,
+	HTT_STATS_TX_TQM_GEN_MPDU_TAG			= 11,
+	HTT_STATS_TX_TQM_LIST_MPDU_TAG			= 12,
+	HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG		= 13,
+	HTT_STATS_TX_TQM_CMN_TAG			= 14,
+	HTT_STATS_TX_TQM_PDEV_TAG			= 15,
 	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
 	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
 	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,
+	HTT_STATS_TX_TQM_ERROR_STATS_TAG                = 43,
 	HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG		= 44,
 	HTT_STATS_HW_INTR_MISC_TAG			= 54,
 	HTT_STATS_HW_PDEV_ERRS_TAG			= 56,
@@ -462,4 +469,99 @@ struct ath12k_htt_hw_war_stats_tlv {
 	DECLARE_FLEX_ARRAY(__le32, hw_wars);
 } __packed;
 
+struct ath12k_htt_tx_tqm_cmn_stats_tlv {
+	__le32 mac_id__word;
+	__le32 max_cmdq_id;
+	__le32 list_mpdu_cnt_hist_intvl;
+	__le32 add_msdu;
+	__le32 q_empty;
+	__le32 q_not_empty;
+	__le32 drop_notification;
+	__le32 desc_threshold;
+	__le32 hwsch_tqm_invalid_status;
+	__le32 missed_tqm_gen_mpdus;
+	__le32 tqm_active_tids;
+	__le32 tqm_inactive_tids;
+	__le32 tqm_active_msduq_flows;
+	__le32 msduq_timestamp_updates;
+	__le32 msduq_updates_mpdu_head_info_cmd;
+	__le32 msduq_updates_emp_to_nonemp_status;
+	__le32 get_mpdu_head_info_cmds_by_query;
+	__le32 get_mpdu_head_info_cmds_by_tac;
+	__le32 gen_mpdu_cmds_by_query;
+	__le32 high_prio_q_not_empty;
+} __packed;
+
+struct ath12k_htt_tx_tqm_error_stats_tlv {
+	__le32 q_empty_failure;
+	__le32 q_not_empty_failure;
+	__le32 add_msdu_failure;
+	__le32 tqm_cache_ctl_err;
+	__le32 tqm_soft_reset;
+	__le32 tqm_reset_num_in_use_link_descs;
+	__le32 tqm_reset_num_lost_link_descs;
+	__le32 tqm_reset_num_lost_host_tx_buf_cnt;
+	__le32 tqm_reset_num_in_use_internal_tqm;
+	__le32 tqm_reset_num_in_use_idle_link_rng;
+	__le32 tqm_reset_time_to_tqm_hang_delta_ms;
+	__le32 tqm_reset_recovery_time_ms;
+	__le32 tqm_reset_num_peers_hdl;
+	__le32 tqm_reset_cumm_dirty_hw_mpduq_cnt;
+	__le32 tqm_reset_cumm_dirty_hw_msduq_proc;
+	__le32 tqm_reset_flush_cache_cmd_su_cnt;
+	__le32 tqm_reset_flush_cache_cmd_other_cnt;
+	__le32 tqm_reset_flush_cache_cmd_trig_type;
+	__le32 tqm_reset_flush_cache_cmd_trig_cfg;
+	__le32 tqm_reset_flush_cmd_skp_status_null;
+} __packed;
+
+struct ath12k_htt_tx_tqm_gen_mpdu_stats_tlv {
+	DECLARE_FLEX_ARRAY(__le32, gen_mpdu_end_reason);
+} __packed;
+
+#define ATH12K_HTT_TX_TQM_MAX_LIST_MPDU_END_REASON		16
+#define ATH12K_HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS	16
+
+struct ath12k_htt_tx_tqm_list_mpdu_stats_tlv {
+	DECLARE_FLEX_ARRAY(__le32, list_mpdu_end_reason);
+} __packed;
+
+struct ath12k_htt_tx_tqm_list_mpdu_cnt_tlv {
+	DECLARE_FLEX_ARRAY(__le32, list_mpdu_cnt_hist);
+} __packed;
+
+struct ath12k_htt_tx_tqm_pdev_stats_tlv {
+	__le32 msdu_count;
+	__le32 mpdu_count;
+	__le32 remove_msdu;
+	__le32 remove_mpdu;
+	__le32 remove_msdu_ttl;
+	__le32 send_bar;
+	__le32 bar_sync;
+	__le32 notify_mpdu;
+	__le32 sync_cmd;
+	__le32 write_cmd;
+	__le32 hwsch_trigger;
+	__le32 ack_tlv_proc;
+	__le32 gen_mpdu_cmd;
+	__le32 gen_list_cmd;
+	__le32 remove_mpdu_cmd;
+	__le32 remove_mpdu_tried_cmd;
+	__le32 mpdu_queue_stats_cmd;
+	__le32 mpdu_head_info_cmd;
+	__le32 msdu_flow_stats_cmd;
+	__le32 remove_msdu_cmd;
+	__le32 remove_msdu_ttl_cmd;
+	__le32 flush_cache_cmd;
+	__le32 update_mpduq_cmd;
+	__le32 enqueue;
+	__le32 enqueue_notify;
+	__le32 notify_mpdu_at_head;
+	__le32 notify_mpdu_state_valid;
+	__le32 sched_udp_notify1;
+	__le32 sched_udp_notify2;
+	__le32 sched_nonudp_notify1;
+	__le32 sched_nonudp_notify2;
+} __packed;
+
 #endif
-- 
2.34.1


