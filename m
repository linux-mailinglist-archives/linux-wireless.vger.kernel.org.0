Return-Path: <linux-wireless+bounces-9519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC841915D92
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 06:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEACA1C211C7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 04:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B3413848A;
	Tue, 25 Jun 2024 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YkagzV+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29113A253
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289376; cv=none; b=hblVSSsLWxZwrkj880J2JRvunQTiRyn8C5n/kVzBWWVddNOTf9LxMXRI3PsynooXPRbv5db6aMWdT0F2wVa8c2h9vcBi95POam09JzEP7B6+uHbVJAhppjsXx53DP5dmw12fbknULXhXLwpMzn2XjJ+2NbOsu2CsaA5L0sIxHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289376; c=relaxed/simple;
	bh=YUFZ1EWbSnU6l3bvx8u4TtEYnjay23FuZaYfebvxo/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxVEdgM0f3LYhjLuskyk2Q3U4cIdicFrnsRwK/OumpYiCYZYqANW/43diorcSYvXlwR4UKB/z9fX8zmU6Xa11b1ZVgLN/bXSrWVUCW5PXRjWyJsKGKPxGtWvWxxfqpX79CfN5u183+Z2rV+a54vWIBrupVS0vzURW72LC2U2UZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YkagzV+3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OJWQj5031603;
	Tue, 25 Jun 2024 04:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h6gUVKx8laP8ZLH4sMEr9neZJ4SJCi707zb0pRjuQb0=; b=YkagzV+3uqetFxqj
	0vLLorKo7IuMC6SuU/h8GwgHPFr0uO44Qu8/GEGnwsX7EDWKNlNr+2A/Ui2aehTv
	Q9GX/AyR5guMWtSEKLg4u4djUR1e90diBMbEEqCeCqPdMwUbFzbpJcPe/nXwpPb7
	dy53mkQXgD4lAhka+GyxOZGibO/EVdR2XT1/DQ0JSE6PA/2XiP6BQmNhDthlwypQ
	J02OTbXjqKjj2/RFgIqshHXJzPgqgWsN6J6wyiI3EJMonl4xv4xfn0NiDm9YKCLf
	CklsA5b0PmAC9FM3JqSWDbCm/qIKjftLgJI3T8OtX9mOuptahI0h4NBq0fiNtOmy
	CC6PCA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv59x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:22:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45P4Mncw027570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:22:49 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 21:22:47 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 1/3] wifi: ath12k: Support Transmit Scheduler stats
Date: Tue, 25 Jun 2024 09:52:15 +0530
Message-ID: <20240625042217.1303332-2-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: WdMtQoakhF5EHCQ_YUtzjQEybJrSPb39
X-Proofpoint-ORIG-GUID: WdMtQoakhF5EHCQ_YUtzjQEybJrSPb39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_01,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406250031

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request transmission scheduler stats from firmware through
HTT stats type 4. This stat gives information such as pdev stats
scheduled per transmission queue, transmission queue command posted and
reaped, scheduler order, scheduler ineligibility and supercycle triggers.

Sample output:
-------------
echo 4 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_STATS_TX_SCHED_CMN_TLV:
mac_id = 0
current_timestamp = 952546828

HTT_TX_PDEV_STATS_SCHED_PER_TXQ_TLV:
mac_id = 0
txq_id = 14
sched_policy = 2
.....

HTT_SCHED_TXQ_CMD_POSTED_TLV:
sched_cmd_posted =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
10:0, 11:0, 12:0

HTT_SCHED_TXQ_CMD_REAPED_TLV:
sched_cmd_reaped =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
10:0, 11:0, 12:0

HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV:
sched_order_su =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0,
11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0

HTT_SCHED_TXQ_SCHED_INELIGIBILITY:
sched_ineligibility =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0,
22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0,
34:0, 35:0

HTT_SCHED_TXQ_SUPERCYCLE_TRIGGER:
supercycle_triggers =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 233 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  81 ++++++
 2 files changed, 314 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 301d620050c8..f3268e6459d5 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -382,6 +382,216 @@ htt_print_pdev_ctrl_path_tx_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_stats_tx_sched_cmn_tlv(const void *tag_buf,
+					u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_stats_tx_sched_cmn_tlv *htt_stats_buf = tag_buf;
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
+	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_TX_SCHED_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "current_timestamp = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->current_timestamp));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_pdev_stats_sched_per_txq_tlv(const void *tag_buf,
+						 u16 tag_len,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_stats_sched_per_txq_tlv *htt_stats_buf = tag_buf;
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
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_STATS_SCHED_PER_TXQ_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			u32_get_bits(mac_id_word,
+				     ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "txq_id = %u\n",
+			 u32_get_bits(mac_id_word,
+				      ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_ID));
+	len += scnprintf(buf + len, buf_len - len, "sched_policy = %u\n",
+			 le32_to_cpu(htt_stats_buf->sched_policy));
+	len += scnprintf(buf + len, buf_len - len,
+			 "last_sched_cmd_posted_timestamp = %u\n",
+			 le32_to_cpu(htt_stats_buf->last_sched_cmd_posted_timestamp));
+	len += scnprintf(buf + len, buf_len - len,
+			 "last_sched_cmd_compl_timestamp = %u\n",
+			 le32_to_cpu(htt_stats_buf->last_sched_cmd_compl_timestamp));
+	len += scnprintf(buf + len, buf_len - len, "sched_2_tac_lwm_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->sched_2_tac_lwm_count));
+	len += scnprintf(buf + len, buf_len - len, "sched_2_tac_ring_full = %u\n",
+			 le32_to_cpu(htt_stats_buf->sched_2_tac_ring_full));
+	len += scnprintf(buf + len, buf_len - len, "sched_cmd_post_failure = %u\n",
+			 le32_to_cpu(htt_stats_buf->sched_cmd_post_failure));
+	len += scnprintf(buf + len, buf_len - len, "num_active_tids = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_active_tids));
+	len += scnprintf(buf + len, buf_len - len, "num_ps_schedules = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_ps_schedules));
+	len += scnprintf(buf + len, buf_len - len, "sched_cmds_pending = %u\n",
+			 le32_to_cpu(htt_stats_buf->sched_cmds_pending));
+	len += scnprintf(buf + len, buf_len - len, "num_tid_register = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_tid_register));
+	len += scnprintf(buf + len, buf_len - len, "num_tid_unregister = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_tid_unregister));
+	len += scnprintf(buf + len, buf_len - len, "num_qstats_queried = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_qstats_queried));
+	len += scnprintf(buf + len, buf_len - len, "qstats_update_pending = %u\n",
+			 le32_to_cpu(htt_stats_buf->qstats_update_pending));
+	len += scnprintf(buf + len, buf_len - len, "last_qstats_query_timestamp = %u\n",
+			 le32_to_cpu(htt_stats_buf->last_qstats_query_timestamp));
+	len += scnprintf(buf + len, buf_len - len, "num_tqm_cmdq_full = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_tqm_cmdq_full));
+	len += scnprintf(buf + len, buf_len - len, "num_de_sched_algo_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_de_sched_algo_trigger));
+	len += scnprintf(buf + len, buf_len - len, "num_rt_sched_algo_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_rt_sched_algo_trigger));
+	len += scnprintf(buf + len, buf_len - len, "num_tqm_sched_algo_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_tqm_sched_algo_trigger));
+	len += scnprintf(buf + len, buf_len - len, "notify_sched = %u\n",
+			 le32_to_cpu(htt_stats_buf->notify_sched));
+	len += scnprintf(buf + len, buf_len - len, "dur_based_sendn_term = %u\n",
+			 le32_to_cpu(htt_stats_buf->dur_based_sendn_term));
+	len += scnprintf(buf + len, buf_len - len, "su_notify2_sched = %u\n",
+			 le32_to_cpu(htt_stats_buf->su_notify2_sched));
+	len += scnprintf(buf + len, buf_len - len, "su_optimal_queued_msdus_sched = %u\n",
+			 le32_to_cpu(htt_stats_buf->su_optimal_queued_msdus_sched));
+	len += scnprintf(buf + len, buf_len - len, "su_delay_timeout_sched = %u\n",
+			 le32_to_cpu(htt_stats_buf->su_delay_timeout_sched));
+	len += scnprintf(buf + len, buf_len - len, "su_min_txtime_sched_delay = %u\n",
+			 le32_to_cpu(htt_stats_buf->su_min_txtime_sched_delay));
+	len += scnprintf(buf + len, buf_len - len, "su_no_delay = %u\n",
+			 le32_to_cpu(htt_stats_buf->su_no_delay));
+	len += scnprintf(buf + len, buf_len - len, "num_supercycles = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_supercycles));
+	len += scnprintf(buf + len, buf_len - len, "num_subcycles_with_sort = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_subcycles_with_sort));
+	len += scnprintf(buf + len, buf_len - len, "num_subcycles_no_sort = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->num_subcycles_no_sort));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_sched_txq_cmd_posted_tlv(const void *tag_buf,
+					  u16 tag_len,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_sched_txq_cmd_posted_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elements = tag_len >> 2;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_POSTED_TLV:\n");
+	len += print_array_to_buf(buf, len, "sched_cmd_posted",
+				  htt_stats_buf->sched_cmd_posted, num_elements, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_sched_txq_cmd_reaped_tlv(const void *tag_buf,
+					  u16 tag_len,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_sched_txq_cmd_reaped_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elements = tag_len >> 2;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_REAPED_TLV:\n");
+	len += print_array_to_buf(buf, len, "sched_cmd_reaped",
+				  htt_stats_buf->sched_cmd_reaped, num_elements, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_sched_txq_sched_order_su_tlv(const void *tag_buf,
+					      u16 tag_len,
+					      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_sched_txq_sched_order_su_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 sched_order_su_num_entries = min_t(u32, (tag_len >> 2),
+					       ATH12K_HTT_TX_PDEV_NUM_SCHED_ORDER_LOG);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV:\n");
+	len += print_array_to_buf(buf, len, "sched_order_su",
+				  htt_stats_buf->sched_order_su,
+				  sched_order_su_num_entries, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_sched_txq_sched_ineligibility_tlv(const void *tag_buf,
+						   u16 tag_len,
+						   struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_sched_txq_sched_ineligibility_tlv *htt_stats_buf =
+		     tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 sched_ineligibility_num_entries = tag_len >> 2;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_SCHED_TXQ_SCHED_INELIGIBILITY:\n");
+	len += print_array_to_buf(buf, len, "sched_ineligibility",
+				  htt_stats_buf->sched_ineligibility,
+				  sched_ineligibility_num_entries, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_sched_txq_supercycle_trigger_tlv(const void *tag_buf,
+						  u16 tag_len,
+						  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_sched_txq_supercycle_triggers_tlv *htt_stats_buf =
+		     tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_SCHED_SUPERCYCLE_TRIGGER_MAX);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_SCHED_TXQ_SUPERCYCLE_TRIGGER:\n");
+	len += print_array_to_buf(buf, len, "supercycle_triggers",
+				  htt_stats_buf->supercycle_triggers, num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -410,6 +620,29 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_MU_PPDU_DIST_TAG:
 		htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_SCHED_CMN_TAG:
+		ath12k_htt_print_stats_tx_sched_cmn_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG:
+		ath12k_htt_print_tx_pdev_stats_sched_per_txq_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG:
+		ath12k_htt_print_sched_txq_cmd_posted_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG:
+		ath12k_htt_print_sched_txq_cmd_reaped_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG:
+		ath12k_htt_print_sched_txq_sched_order_su_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG:
+		ath12k_htt_print_sched_txq_sched_ineligibility_tlv(tag_buf, len,
+								   stats_req);
+		break;
+	case HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG:
+		ath12k_htt_print_sched_txq_supercycle_trigger_tlv(tag_buf, len,
+								  stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index acddcf55b5d8..755830501050 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -125,6 +125,7 @@ struct ath12k_htt_extd_stats_msg {
 enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_RESET		= 0,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX	= 1,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED	= 4,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -135,7 +136,14 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_UNDERRUN_TAG			= 1,
 	HTT_STATS_TX_PDEV_SIFS_TAG			= 2,
 	HTT_STATS_TX_PDEV_FLUSH_TAG			= 3,
+	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
+	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
+	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,
+	HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG		= 44,
 	HTT_STATS_TX_PDEV_SIFS_HIST_TAG			= 67,
+	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG		= 86,
+	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
+	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
 
@@ -297,4 +305,77 @@ struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv {
 	__le32 num_ppdu_posted_per_burst[ATH12K_HTT_STATS_MU_PPDU_PER_BURST_WORDS];
 } __packed;
 
+#define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_MAC_ID	GENMASK(7, 0)
+#define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_ID	GENMASK(15, 8)
+
+#define ATH12K_HTT_TX_PDEV_NUM_SCHED_ORDER_LOG	20
+
+struct ath12k_htt_stats_tx_sched_cmn_tlv {
+	__le32 mac_id__word;
+	__le32 current_timestamp;
+} __packed;
+
+struct ath12k_htt_tx_pdev_stats_sched_per_txq_tlv {
+	__le32 mac_id__word;
+	__le32 sched_policy;
+	__le32 last_sched_cmd_posted_timestamp;
+	__le32 last_sched_cmd_compl_timestamp;
+	__le32 sched_2_tac_lwm_count;
+	__le32 sched_2_tac_ring_full;
+	__le32 sched_cmd_post_failure;
+	__le32 num_active_tids;
+	__le32 num_ps_schedules;
+	__le32 sched_cmds_pending;
+	__le32 num_tid_register;
+	__le32 num_tid_unregister;
+	__le32 num_qstats_queried;
+	__le32 qstats_update_pending;
+	__le32 last_qstats_query_timestamp;
+	__le32 num_tqm_cmdq_full;
+	__le32 num_de_sched_algo_trigger;
+	__le32 num_rt_sched_algo_trigger;
+	__le32 num_tqm_sched_algo_trigger;
+	__le32 notify_sched;
+	__le32 dur_based_sendn_term;
+	__le32 su_notify2_sched;
+	__le32 su_optimal_queued_msdus_sched;
+	__le32 su_delay_timeout_sched;
+	__le32 su_min_txtime_sched_delay;
+	__le32 su_no_delay;
+	__le32 num_supercycles;
+	__le32 num_subcycles_with_sort;
+	__le32 num_subcycles_no_sort;
+} __packed;
+
+struct ath12k_htt_sched_txq_cmd_posted_tlv {
+	DECLARE_FLEX_ARRAY(__le32, sched_cmd_posted);
+} __packed;
+
+struct ath12k_htt_sched_txq_cmd_reaped_tlv {
+	DECLARE_FLEX_ARRAY(__le32, sched_cmd_reaped);
+} __packed;
+
+struct ath12k_htt_sched_txq_sched_order_su_tlv {
+	DECLARE_FLEX_ARRAY(__le32, sched_order_su);
+} __packed;
+
+struct ath12k_htt_sched_txq_sched_ineligibility_tlv {
+	DECLARE_FLEX_ARRAY(__le32, sched_ineligibility);
+} __packed;
+
+enum ath12k_htt_sched_txq_supercycle_triggers_tlv_enum {
+	ATH12K_HTT_SCHED_SUPERCYCLE_TRIGGER_NONE = 0,
+	ATH12K_HTT_SCHED_SUPERCYCLE_TRIGGER_FORCED,
+	ATH12K_HTT_SCHED_SUPERCYCLE_TRIGGER_LESS_NUM_TIDQ_ENTRIES,
+	ATH12K_HTT_SCHED_SUPERCYCLE_TRIGGER_LESS_NUM_ACTIVE_TIDS,
+	ATH12K_HTT_SCHED_SUPERCYCLE_TRIGGER_MAX_ITR_REACHED,
+	ATH12K_HTT_SCHED_SUPERCYCLE_TRIGGER_DUR_THRESHOLD_REACHED,
+	ATH12K_HTT_SCHED_SUPERCYCLE_TRIGGER_TWT_TRIGGER,
+	ATH12K_HTT_SCHED_SUPERCYCLE_TRIGGER_MAX,
+};
+
+struct ath12k_htt_sched_txq_supercycle_triggers_tlv {
+	DECLARE_FLEX_ARRAY(__le32, supercycle_triggers);
+} __packed;
+
 #endif
-- 
2.34.1


