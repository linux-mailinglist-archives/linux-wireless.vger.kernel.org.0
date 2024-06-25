Return-Path: <linux-wireless+bounces-9520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EA6915D93
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 06:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4AB2835E0
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 04:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4270A13A253;
	Tue, 25 Jun 2024 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="obxjMqpX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00613AA3F
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289379; cv=none; b=gLhA9Kzv7h1W4us1Mj++dAQHWWGSHHb2KL3q7xMl/VyhFpr3XvMdmkoDxYKiTMTj9Uf6E0g7QanSh1CUlgJflyzUe4ZkWsxnY5tjO80GTxz1JcYuzUti4v1CLs0WEEHEttO7bl529UOrNkunL0V+7XlXClzYy2wzMzcjrwtvzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289379; c=relaxed/simple;
	bh=3wjl0i87NI/8k38Mxc+w6fT1gXXlhezqVpNr4kBh+bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LO1uUe3IdPRCgCod5D/dj1Ea05uPzKnyNiiFG2knVi+CKzKhm4Q11I7iiogA+4WePtTbvf2JM7J1R5E1TyP/0LNMETJXMPWJb8mmZgpiHpgGTvXTicwpIR/o0Pn6ZZsWLCr1kbp6fnwUqrVGTpafzrweLTLvtPRKiCWJbrtJk5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=obxjMqpX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OJJ3rN031594;
	Tue, 25 Jun 2024 04:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Fz3xg0MN6HanS461PI0h36QhjxKHBlaExxIAZ5xs/c=; b=obxjMqpXEE3ypBNw
	xTpsFCXnF+zcAFlhDub5lUxM3yMyaUd5/kQSFgbhxosljgUbf4zM48QVidzp0sRX
	bpm8KPCmxO6T8cpg5jbgMfb6V7XjBUGUaig2Up7urOcBFqn1HAKXLetf2Nt+pPPF
	2u/e/ukI13dJ2/EUPlqPqkp93a5eOPgLPDUOE/7dosiDfF4W7VJWQhHPHsC6O9rU
	EdlqN7vrQVE0CeE/s43H7Hdb8JxVgzOPrukKf2llkXbxDDtndzoBcjsKnp3ZJIUs
	dwxMPdcTgjSyz0iAat1rCQn4CoDFL//7OsqUAOzW46kaUtc3ULHzmO4KDxV92EGi
	sopl6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv59x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:22:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45P4MqcF031443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:22:52 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 21:22:50 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: Support pdev error stats
Date: Tue, 25 Jun 2024 09:52:16 +0530
Message-ID: <20240625042217.1303332-3-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: 3HyHFGHklNzkr-_OgDkWA-1J2Im5rNKm
X-Proofpoint-ORIG-GUID: 3HyHFGHklNzkr-_OgDkWA-1J2Im5rNKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_01,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406250031

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request pdev error stats from firmware through HTT stats
type 5. This stats type gives information such as list of pdev errors,
reasons for reset, logging information about recovery, drain and war
stats. etc.

Sample output:
-------------
echo 5 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats

HTT_HW_STATS_PDEV_ERRS_TLV:
mac_id = 0
tx_abort = 0
tx_abort_fail_count = 0
rx_abort = 53
.....

PDEV_PHY_WARM_RESET_REASONS:
phy_warm_reset_reason_phy_m3 = 0
phy_warm_reset_reason_tx_hw_stuck = 0
phy_warm_reset_reason_num_cca_rx_frame_stuck = 0
.....

WAL_RX_RECOVERY_STATS:
wal_rx_recovery_rst_mac_hang_count = 0
wal_rx_recovery_rst_known_sig_count = 0
wal_rx_recovery_rst_no_rx_count = 0
.....

HTT_RX_DEST_DRAIN_STATS:
rx_dest_drain_rx_descs_leak_prevention_done = 0
rx_dest_drain_rx_descs_saved_cnt = 0
rx_dest_drain_rxdma2reo_leak_detected = 0
.....

HTT_HW_STATS_INTR_MISC_TLV:
hw_intr_name = AMPI
mask = 0
count = 2

HTT_HW_STATS_WHAL_TX_TLV:
mac_id = 0
last_unpause_ppdu_id = 0
hwsch_unpause_wait_tqm_write = 0
.....

HTT_HW_WAR_STATS_TLV:
mac_id = 0
hw_war 0 = 0
hw_war 1 = 0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 262 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  84 ++++++
 2 files changed, 346 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index f3268e6459d5..0baa0f18a5a0 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -592,6 +592,256 @@ ath12k_htt_print_sched_txq_supercycle_trigger_tlv(const void *tag_buf,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_hw_stats_pdev_errs_tlv(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_hw_stats_pdev_errs_tlv *htt_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word;
+
+	if (tag_len < sizeof(*htt_buf))
+		return;
+
+	mac_id_word = le32_to_cpu(htt_buf->mac_id__word);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_PDEV_ERRS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "tx_abort = %u\n",
+			 le32_to_cpu(htt_buf->tx_abort));
+	len += scnprintf(buf + len, buf_len - len, "tx_abort_fail_count = %u\n",
+			 le32_to_cpu(htt_buf->tx_abort_fail_count));
+	len += scnprintf(buf + len, buf_len - len, "rx_abort = %u\n",
+			 le32_to_cpu(htt_buf->rx_abort));
+	len += scnprintf(buf + len, buf_len - len, "rx_abort_fail_count = %u\n",
+			 le32_to_cpu(htt_buf->rx_abort_fail_count));
+	len += scnprintf(buf + len, buf_len - len, "rx_flush_cnt = %u\n",
+			 le32_to_cpu(htt_buf->rx_flush_cnt));
+	len += scnprintf(buf + len, buf_len - len, "warm_reset = %u\n",
+			 le32_to_cpu(htt_buf->warm_reset));
+	len += scnprintf(buf + len, buf_len - len, "cold_reset = %u\n",
+			 le32_to_cpu(htt_buf->cold_reset));
+	len += scnprintf(buf + len, buf_len - len, "mac_cold_reset_restore_cal = %u\n",
+			 le32_to_cpu(htt_buf->mac_cold_reset_restore_cal));
+	len += scnprintf(buf + len, buf_len - len, "mac_cold_reset = %u\n",
+			 le32_to_cpu(htt_buf->mac_cold_reset));
+	len += scnprintf(buf + len, buf_len - len, "mac_warm_reset = %u\n",
+			 le32_to_cpu(htt_buf->mac_warm_reset));
+	len += scnprintf(buf + len, buf_len - len, "mac_only_reset = %u\n",
+			 le32_to_cpu(htt_buf->mac_only_reset));
+	len += scnprintf(buf + len, buf_len - len, "phy_warm_reset = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset));
+	len += scnprintf(buf + len, buf_len - len, "phy_warm_reset_ucode_trig = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_ucode_trig));
+	len += scnprintf(buf + len, buf_len - len, "mac_warm_reset_restore_cal = %u\n",
+			 le32_to_cpu(htt_buf->mac_warm_reset_restore_cal));
+	len += scnprintf(buf + len, buf_len - len, "mac_sfm_reset = %u\n",
+			 le32_to_cpu(htt_buf->mac_sfm_reset));
+	len += scnprintf(buf + len, buf_len - len, "phy_warm_reset_m3_ssr = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_m3_ssr));
+	len += scnprintf(buf + len, buf_len - len, "fw_rx_rings_reset = %u\n",
+			 le32_to_cpu(htt_buf->fw_rx_rings_reset));
+	len += scnprintf(buf + len, buf_len - len, "tx_flush = %u\n",
+			 le32_to_cpu(htt_buf->tx_flush));
+	len += scnprintf(buf + len, buf_len - len, "tx_glb_reset = %u\n",
+			 le32_to_cpu(htt_buf->tx_glb_reset));
+	len += scnprintf(buf + len, buf_len - len, "tx_txq_reset = %u\n",
+			 le32_to_cpu(htt_buf->tx_txq_reset));
+	len += scnprintf(buf + len, buf_len - len, "rx_timeout_reset = %u\n\n",
+			 le32_to_cpu(htt_buf->rx_timeout_reset));
+
+	len += scnprintf(buf + len, buf_len - len, "PDEV_PHY_WARM_RESET_REASONS:\n");
+	len += scnprintf(buf + len, buf_len - len, "phy_warm_reset_reason_phy_m3 = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_phy_m3));
+	len += scnprintf(buf + len, buf_len - len,
+			 "phy_warm_reset_reason_tx_hw_stuck = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_tx_hw_stuck));
+	len += scnprintf(buf + len, buf_len - len,
+			 "phy_warm_reset_reason_num_cca_rx_frame_stuck = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_num_rx_frame_stuck));
+	len += scnprintf(buf + len, buf_len - len,
+			 "phy_warm_reset_reason_wal_rx_recovery_rst_rx_busy = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_wal_rx_rec_rx_busy));
+	len += scnprintf(buf + len, buf_len - len,
+			 "phy_warm_reset_reason_wal_rx_recovery_rst_mac_hang = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_wal_rx_rec_mac_hng));
+	len += scnprintf(buf + len, buf_len - len,
+			 "phy_warm_reset_reason_mac_reset_converted_phy_reset = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_mac_conv_phy_reset));
+	len += scnprintf(buf + len, buf_len - len,
+			 "phy_warm_reset_reason_tx_lifetime_expiry_cca_stuck = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_tx_exp_cca_stuck));
+	len += scnprintf(buf + len, buf_len - len,
+			 "phy_warm_reset_reason_tx_consecutive_flush9_war = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_tx_consec_flsh_war));
+	len += scnprintf(buf + len, buf_len - len,
+			 "phy_warm_reset_reason_tx_hwsch_reset_war = %u\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_tx_hwsch_reset_war));
+	len += scnprintf(buf + len, buf_len - len,
+			 "phy_warm_reset_reason_hwsch_wdog_or_cca_wdog_war = %u\n\n",
+			 le32_to_cpu(htt_buf->phy_warm_reset_reason_hwsch_cca_wdog_war));
+
+	len += scnprintf(buf + len, buf_len - len, "WAL_RX_RECOVERY_STATS:\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "wal_rx_recovery_rst_mac_hang_count = %u\n",
+			 le32_to_cpu(htt_buf->wal_rx_recovery_rst_mac_hang_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "wal_rx_recovery_rst_known_sig_count = %u\n",
+			 le32_to_cpu(htt_buf->wal_rx_recovery_rst_known_sig_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "wal_rx_recovery_rst_no_rx_count = %u\n",
+			 le32_to_cpu(htt_buf->wal_rx_recovery_rst_no_rx_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "wal_rx_recovery_rst_no_rx_consecutive_count = %u\n",
+			 le32_to_cpu(htt_buf->wal_rx_recovery_rst_no_rx_consec_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "wal_rx_recovery_rst_rx_busy_count = %u\n",
+			 le32_to_cpu(htt_buf->wal_rx_recovery_rst_rx_busy_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "wal_rx_recovery_rst_phy_mac_hang_count = %u\n\n",
+			 le32_to_cpu(htt_buf->wal_rx_recovery_rst_phy_mac_hang_cnt));
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_DEST_DRAIN_STATS:\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_rx_descs_leak_prevention_done = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_rx_descs_leak_prevented));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_rx_descs_saved_cnt = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_rx_descs_saved_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_rxdma2reo_leak_detected = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_rxdma2reo_leak_detected));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_rxdma2fw_leak_detected = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_rxdma2fw_leak_detected));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_rxdma2wbm_leak_detected = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_rxdma2wbm_leak_detected));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_rxdma1_2sw_leak_detected = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_rxdma1_2sw_leak_detected));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_rx_drain_ok_mac_idle = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_rx_drain_ok_mac_idle));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_ok_mac_not_idle = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_ok_mac_not_idle));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_prerequisite_invld = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_prerequisite_invld));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_skip_for_non_lmac_reset = %u\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_skip_non_lmac_reset));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_dest_drain_hw_fifo_not_empty_post_drain_wait = %u\n\n",
+			 le32_to_cpu(htt_buf->rx_dest_drain_hw_fifo_notempty_post_wait));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_hw_stats_intr_misc_tlv(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_hw_stats_intr_misc_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_INTR_MISC_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "hw_intr_name = %s\n",
+			 htt_stats_buf->hw_intr_name);
+	len += scnprintf(buf + len, buf_len - len, "mask = %u\n",
+			 le32_to_cpu(htt_stats_buf->mask));
+	len += scnprintf(buf + len, buf_len - len, "count = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->count));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_hw_stats_whal_tx_tlv(const void *tag_buf, u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_hw_stats_whal_tx_tlv *htt_stats_buf = tag_buf;
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
+	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_WHAL_TX_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "last_unpause_ppdu_id = %u\n",
+			 le32_to_cpu(htt_stats_buf->last_unpause_ppdu_id));
+	len += scnprintf(buf + len, buf_len - len, "hwsch_unpause_wait_tqm_write = %u\n",
+			 le32_to_cpu(htt_stats_buf->hwsch_unpause_wait_tqm_write));
+	len += scnprintf(buf + len, buf_len - len, "hwsch_dummy_tlv_skipped = %u\n",
+			 le32_to_cpu(htt_stats_buf->hwsch_dummy_tlv_skipped));
+	len += scnprintf(buf + len, buf_len - len,
+			 "hwsch_misaligned_offset_received = %u\n",
+			 le32_to_cpu(htt_stats_buf->hwsch_misaligned_offset_received));
+	len += scnprintf(buf + len, buf_len - len, "hwsch_reset_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->hwsch_reset_count));
+	len += scnprintf(buf + len, buf_len - len, "hwsch_dev_reset_war = %u\n",
+			 le32_to_cpu(htt_stats_buf->hwsch_dev_reset_war));
+	len += scnprintf(buf + len, buf_len - len, "hwsch_delayed_pause = %u\n",
+			 le32_to_cpu(htt_stats_buf->hwsch_delayed_pause));
+	len += scnprintf(buf + len, buf_len - len, "hwsch_long_delayed_pause = %u\n",
+			 le32_to_cpu(htt_stats_buf->hwsch_long_delayed_pause));
+	len += scnprintf(buf + len, buf_len - len, "sch_rx_ppdu_no_response = %u\n",
+			 le32_to_cpu(htt_stats_buf->sch_rx_ppdu_no_response));
+	len += scnprintf(buf + len, buf_len - len, "sch_selfgen_response = %u\n",
+			 le32_to_cpu(htt_stats_buf->sch_selfgen_response));
+	len += scnprintf(buf + len, buf_len - len, "sch_rx_sifs_resp_trigger= %u\n\n",
+			 le32_to_cpu(htt_stats_buf->sch_rx_sifs_resp_trigger));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_hw_war_tlv(const void *tag_buf, u16 tag_len,
+			    struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_hw_war_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 fixed_len, array_len;
+	u8 i, array_words;
+	u32 mac_id;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id = __le32_to_cpu(htt_stats_buf->mac_id__word);
+	fixed_len = sizeof(*htt_stats_buf);
+	array_len = tag_len - fixed_len;
+	array_words = array_len >> 2;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_HW_WAR_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id, ATH12K_HTT_STATS_MAC_ID));
+
+	for (i = 0; i < array_words; i++) {
+		len += scnprintf(buf + len, buf_len - len, "hw_war %u = %u\n\n",
+				 i, le32_to_cpu(htt_stats_buf->hw_wars[i]));
+	}
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -643,6 +893,18 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 		ath12k_htt_print_sched_txq_supercycle_trigger_tlv(tag_buf, len,
 								  stats_req);
 		break;
+	case HTT_STATS_HW_PDEV_ERRS_TAG:
+		ath12k_htt_print_hw_stats_pdev_errs_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_HW_INTR_MISC_TAG:
+		ath12k_htt_print_hw_stats_intr_misc_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_WHAL_TX_TAG:
+		ath12k_htt_print_hw_stats_whal_tx_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_HW_WAR_TAG:
+		ath12k_htt_print_hw_war_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 755830501050..f5a0553732a2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -126,6 +126,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_RESET		= 0,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX	= 1,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED	= 4,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR	= 5,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -140,9 +141,13 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
 	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,
 	HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG		= 44,
+	HTT_STATS_HW_INTR_MISC_TAG			= 54,
+	HTT_STATS_HW_PDEV_ERRS_TAG			= 56,
+	HTT_STATS_WHAL_TX_TAG				= 66,
 	HTT_STATS_TX_PDEV_SIFS_HIST_TAG			= 67,
 	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG		= 86,
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
+	HTT_STATS_HW_WAR_TAG				= 89,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
@@ -378,4 +383,83 @@ struct ath12k_htt_sched_txq_supercycle_triggers_tlv {
 	DECLARE_FLEX_ARRAY(__le32, supercycle_triggers);
 } __packed;
 
+struct ath12k_htt_hw_stats_pdev_errs_tlv {
+	__le32 mac_id__word;
+	__le32 tx_abort;
+	__le32 tx_abort_fail_count;
+	__le32 rx_abort;
+	__le32 rx_abort_fail_count;
+	__le32 warm_reset;
+	__le32 cold_reset;
+	__le32 tx_flush;
+	__le32 tx_glb_reset;
+	__le32 tx_txq_reset;
+	__le32 rx_timeout_reset;
+	__le32 mac_cold_reset_restore_cal;
+	__le32 mac_cold_reset;
+	__le32 mac_warm_reset;
+	__le32 mac_only_reset;
+	__le32 phy_warm_reset;
+	__le32 phy_warm_reset_ucode_trig;
+	__le32 mac_warm_reset_restore_cal;
+	__le32 mac_sfm_reset;
+	__le32 phy_warm_reset_m3_ssr;
+	__le32 phy_warm_reset_reason_phy_m3;
+	__le32 phy_warm_reset_reason_tx_hw_stuck;
+	__le32 phy_warm_reset_reason_num_rx_frame_stuck;
+	__le32 phy_warm_reset_reason_wal_rx_rec_rx_busy;
+	__le32 phy_warm_reset_reason_wal_rx_rec_mac_hng;
+	__le32 phy_warm_reset_reason_mac_conv_phy_reset;
+	__le32 wal_rx_recovery_rst_mac_hang_cnt;
+	__le32 wal_rx_recovery_rst_known_sig_cnt;
+	__le32 wal_rx_recovery_rst_no_rx_cnt;
+	__le32 wal_rx_recovery_rst_no_rx_consec_cnt;
+	__le32 wal_rx_recovery_rst_rx_busy_cnt;
+	__le32 wal_rx_recovery_rst_phy_mac_hang_cnt;
+	__le32 rx_flush_cnt;
+	__le32 phy_warm_reset_reason_tx_exp_cca_stuck;
+	__le32 phy_warm_reset_reason_tx_consec_flsh_war;
+	__le32 phy_warm_reset_reason_tx_hwsch_reset_war;
+	__le32 phy_warm_reset_reason_hwsch_cca_wdog_war;
+	__le32 fw_rx_rings_reset;
+	__le32 rx_dest_drain_rx_descs_leak_prevented;
+	__le32 rx_dest_drain_rx_descs_saved_cnt;
+	__le32 rx_dest_drain_rxdma2reo_leak_detected;
+	__le32 rx_dest_drain_rxdma2fw_leak_detected;
+	__le32 rx_dest_drain_rxdma2wbm_leak_detected;
+	__le32 rx_dest_drain_rxdma1_2sw_leak_detected;
+	__le32 rx_dest_drain_rx_drain_ok_mac_idle;
+	__le32 rx_dest_drain_ok_mac_not_idle;
+	__le32 rx_dest_drain_prerequisite_invld;
+	__le32 rx_dest_drain_skip_non_lmac_reset;
+	__le32 rx_dest_drain_hw_fifo_notempty_post_wait;
+} __packed;
+
+#define ATH12K_HTT_STATS_MAX_HW_INTR_NAME_LEN 8
+struct ath12k_htt_hw_stats_intr_misc_tlv {
+	u8 hw_intr_name[ATH12K_HTT_STATS_MAX_HW_INTR_NAME_LEN];
+	__le32 mask;
+	__le32 count;
+} __packed;
+
+struct ath12k_htt_hw_stats_whal_tx_tlv {
+	__le32 mac_id__word;
+	__le32 last_unpause_ppdu_id;
+	__le32 hwsch_unpause_wait_tqm_write;
+	__le32 hwsch_dummy_tlv_skipped;
+	__le32 hwsch_misaligned_offset_received;
+	__le32 hwsch_reset_count;
+	__le32 hwsch_dev_reset_war;
+	__le32 hwsch_delayed_pause;
+	__le32 hwsch_long_delayed_pause;
+	__le32 sch_rx_ppdu_no_response;
+	__le32 sch_selfgen_response;
+	__le32 sch_rx_sifs_resp_trigger;
+} __packed;
+
+struct ath12k_htt_hw_war_stats_tlv {
+	__le32 mac_id__word;
+	DECLARE_FLEX_ARRAY(__le32, hw_wars);
+} __packed;
+
 #endif
-- 
2.34.1


