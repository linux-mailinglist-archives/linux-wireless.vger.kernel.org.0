Return-Path: <linux-wireless+bounces-15777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C99DB649
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526F8281138
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C174192D82;
	Thu, 28 Nov 2024 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZIUGpLAU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9D15E5CA
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792216; cv=none; b=M/A08keCVxSQLw/X7GDsP22c65TbNpDmj8ptWv05iuOcMsBwYWdTOFzV8TRy7xI8s59x4sp7vhnD20XVHWgUo3GKcwjduWuJNNQciikUxdtyAJiejKBraNbHYIhOYKpzy2fZrv0SotdbtB5Yd8V0NhHeY7qNmgUzFehuPQVdMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792216; c=relaxed/simple;
	bh=ZlJbP5PEKm9Gvr6JxIIZcNgqj41xhLDBT0VelOe/U5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5rPCGt+BRIkpIg1IKHT/ezVFeu1wW8iFinVXlYHd8jWwdNFLMB4nWBBLDSYQN9Uajdam1P1Iw1aR3GXuuqeho1YDh8BiT2aIHwDCdMr1cSHJf+nF+ZLYlExb8qc76v3+HiTedIGEApFlRDiIV+AC5x7i7iUkXoEpa0uB9/Y92U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZIUGpLAU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS8nm2L027087;
	Thu, 28 Nov 2024 11:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K6a/nSDyUPxxdYsx8Hmq6h7PrjFE4OAYqACwMdz0YNU=; b=ZIUGpLAUTaLbyiNE
	jZuCPkb6HgcSroT+7m12BmUZCkL25o9EQQ7Ret9m7lpYRp2lt6NsSC8uzb54EG2S
	ABDvXCvxc8EGy/FnIHHxX2AULxXvhbs+Mm3Yujp3a15fnSii8QlcQxee5DYpFqDN
	sswz0IpY6jeueISR/tc/N63dGNG0HWR6gNXDEQ2i1K8tSJevyqaKX6wP042EkPj5
	kYFXpQG94kSoXM5cwyy1AsoYKOHTgIjXL9GjGP8e6pqeVfw8ZtfJjkjriK9qH8FF
	NtzVrIGbgwRABcSlULCYD8TRjGfs1ln61G8vzWKNIOcZWulVIGT27w7BjFmko/qw
	bvaFuw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43673jacg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 11:10:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASBAAsL013039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 11:10:10 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 03:10:08 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: Support Transmit Rate Buffer Stats
Date: Thu, 28 Nov 2024 16:39:48 +0530
Message-ID: <20241128110949.3672364-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
References: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: krWqvtAAh2uL2DO0PfCQRaiY8mbQQ7NB
X-Proofpoint-ORIG-GUID: krWqvtAAh2uL2DO0PfCQRaiY8mbQQ7NB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411280088

From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

Add support to request transmit rate buffer stats from firmware through
HTT stats type 31. These stats give information such as MCS, NSS and
bandwidth of transmit and input buffer.

Sample output:
-------------
echo 31 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_STATS_PDEV_TX_RATE_TXBF_STATS:
Legacy OFDM Rates: 6 Mbps: 0, 9 Mbps: 0, 12 Mbps: 0, 18 Mbps: 0
24 Mbps: 0, 36 Mbps: 0, 48 Mbps: 0, 54 Mbps: 0
tx_ol_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
tx_ibf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
tx_txbf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
tx_ol_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
tx_ibf_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
tx_txbf_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
tx_ol_bw =  0:0, 1:0, 2:0, 3:0, 4:0
half_tx_ol_bw =  0:0, 1:0, 2:0, 3:0, 4:0
quarter_tx_ol_bw =  0:0, 1:0, 2:0, 3:0, 4:0
tx_ibf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
half_tx_ibf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
quarter_tx_ibf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
tx_txbf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
half_tx_txbf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
quarter_tx_txbf_bw =  0:0, 1:0, 2:0, 3:0, 4:0

HTT_STATS_PDEV_TXBF_FLAG_RETURN_STATS:
TXBF_reason_code_stats: 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 95 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 32 +++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index d8f137bfba7b..d72eb22a719b 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2576,6 +2576,98 @@ ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(const void *tag_buf, u16 tag_len,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_txrate_txbf_stats_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u8 i;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_STATS_PDEV_TX_RATE_TXBF_STATS:\n");
+	len += scnprintf(buf + len, buf_len - len, "Legacy OFDM Rates: 6 Mbps: %u, ",
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[0]));
+	len += scnprintf(buf + len, buf_len - len, "9 Mbps: %u, 12 Mbps: %u, ",
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[1]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[2]));
+	len += scnprintf(buf + len, buf_len - len, "18 Mbps: %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[3]));
+	len += scnprintf(buf + len, buf_len - len, "24 Mbps: %u, 36 Mbps: %u, ",
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[4]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[5]));
+	len += scnprintf(buf + len, buf_len - len, "48 Mbps: %u, 54 Mbps: %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[6]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[7]));
+
+	len += print_array_to_buf(buf, len, "tx_ol_mcs", htt_stats_buf->tx_su_ol_mcs,
+				  ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "tx_ibf_mcs", htt_stats_buf->tx_su_ibf_mcs,
+				  ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "tx_txbf_mcs", htt_stats_buf->tx_su_txbf_mcs,
+				  ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf_index(buf, len, "tx_ol_nss", 1,
+					htt_stats_buf->tx_su_ol_nss,
+					ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS,
+					"\n");
+	len += print_array_to_buf_index(buf, len, "tx_ibf_nss", 1,
+					htt_stats_buf->tx_su_ibf_nss,
+					ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS,
+					"\n");
+	len += print_array_to_buf_index(buf, len, "tx_txbf_nss", 1,
+					htt_stats_buf->tx_su_txbf_nss,
+					ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS,
+					"\n");
+	len += print_array_to_buf(buf, len, "tx_ol_bw", htt_stats_buf->tx_su_ol_bw,
+				  ATH12K_HTT_TXBF_NUM_BW_CNTRS, "\n");
+	for (i = 0; i < ATH12K_HTT_TXBF_NUM_REDUCED_CHAN_TYPES; i++)
+		len += print_array_to_buf(buf, len, i ? "quarter_tx_ol_bw" :
+					  "half_tx_ol_bw",
+					  htt_stats_buf->ol[i],
+					  ATH12K_HTT_TXBF_NUM_BW_CNTRS,
+					  "\n");
+
+	len += print_array_to_buf(buf, len, "tx_ibf_bw", htt_stats_buf->tx_su_ibf_bw,
+				  ATH12K_HTT_TXBF_NUM_BW_CNTRS, "\n");
+	for (i = 0; i < ATH12K_HTT_TXBF_NUM_REDUCED_CHAN_TYPES; i++)
+		len += print_array_to_buf(buf, len, i ? "quarter_tx_ibf_bw" :
+					  "half_tx_ibf_bw",
+					  htt_stats_buf->ibf[i],
+					  ATH12K_HTT_TXBF_NUM_BW_CNTRS,
+					  "\n");
+
+	len += print_array_to_buf(buf, len, "tx_txbf_bw", htt_stats_buf->tx_su_txbf_bw,
+				  ATH12K_HTT_TXBF_NUM_BW_CNTRS, "\n");
+	for (i = 0; i < ATH12K_HTT_TXBF_NUM_REDUCED_CHAN_TYPES; i++)
+		len += print_array_to_buf(buf, len, i ? "quarter_tx_txbf_bw" :
+					  "half_tx_txbf_bw",
+					  htt_stats_buf->txbf[i],
+					  ATH12K_HTT_TXBF_NUM_BW_CNTRS,
+					  "\n");
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_STATS_PDEV_TXBF_FLAG_RETURN_STATS:\n");
+	len += scnprintf(buf + len, buf_len - len, "TXBF_reason_code_stats: 0:%u, 1:%u,",
+			 le32_to_cpu(htt_stats_buf->txbf_flag_set_mu_mode),
+			 le32_to_cpu(htt_stats_buf->txbf_flag_set_final_status));
+	len += scnprintf(buf + len, buf_len - len, " 2:%u, 3:%u, 4:%u, 5:%u, ",
+			 le32_to_cpu(htt_stats_buf->txbf_flag_not_set_verified_txbf_mode),
+			 le32_to_cpu(htt_stats_buf->txbf_flag_not_set_disable_p2p_access),
+			 le32_to_cpu(htt_stats_buf->txbf_flag_not_set_max_nss_in_he160),
+			 le32_to_cpu(htt_stats_buf->txbf_flag_not_set_disable_uldlofdma));
+	len += scnprintf(buf + len, buf_len - len, "6:%u, 7:%u\n\n",
+			 le32_to_cpu(htt_stats_buf->txbf_flag_not_set_mcs_threshold_val),
+			 le32_to_cpu(htt_stats_buf->txbf_flag_not_set_final_status));
+
+	stats_req->buf_len = len;
+}
+
 static void ath12k_htt_print_dlpager_entry(const struct ath12k_htt_pgs_info *pg_info,
 					   int idx, char *str_buf)
 {
@@ -3508,6 +3600,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_OBSS_PD_TAG:
 		ath12k_htt_print_pdev_obss_pd_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG:
+		ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_DLPAGER_STATS_TAG:
 		ath12k_htt_print_dlpager_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index cf3c88f8d1b2..859f5c846016 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -135,6 +135,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF	= 31,
 	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
 	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	= 37,
 	ATH12K_DBG_HTT_EXT_VDEVS_TXRX_STATS		= 38,
@@ -197,6 +198,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_HW_WAR_TAG				= 89,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
+	HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG		= 108,
 	HTT_STATS_TX_SELFGEN_AC_SCHED_STATUS_STATS_TAG	= 111,
 	HTT_STATS_TX_SELFGEN_AX_SCHED_STATUS_STATS_TAG	= 112,
 	HTT_STATS_DLPAGER_STATS_TAG			= 120,
@@ -1068,6 +1070,36 @@ struct ath12k_htt_pdev_obss_pd_stats_tlv {
 	__le32 num_sr_ppdu_abort_flush_cnt;
 } __packed;
 
+#define ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS		14
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS		8
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS		8
+#define ATH12K_HTT_TXBF_NUM_BW_CNTRS				5
+#define ATH12K_HTT_TXBF_NUM_REDUCED_CHAN_TYPES			2
+
+struct ath12k_htt_pdev_txrate_txbf_stats_tlv {
+	__le32 tx_su_txbf_mcs[ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS];
+	__le32 tx_su_ibf_mcs[ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS];
+	__le32 tx_su_ol_mcs[ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS];
+	__le32 tx_su_txbf_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 tx_su_ibf_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 tx_su_ol_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 tx_su_txbf_bw[ATH12K_HTT_TXBF_NUM_BW_CNTRS];
+	__le32 tx_su_ibf_bw[ATH12K_HTT_TXBF_NUM_BW_CNTRS];
+	__le32 tx_su_ol_bw[ATH12K_HTT_TXBF_NUM_BW_CNTRS];
+	__le32 tx_legacy_ofdm_rate[ATH12K_HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS];
+	__le32 txbf[ATH12K_HTT_TXBF_NUM_REDUCED_CHAN_TYPES][ATH12K_HTT_TXBF_NUM_BW_CNTRS];
+	__le32 ibf[ATH12K_HTT_TXBF_NUM_REDUCED_CHAN_TYPES][ATH12K_HTT_TXBF_NUM_BW_CNTRS];
+	__le32 ol[ATH12K_HTT_TXBF_NUM_REDUCED_CHAN_TYPES][ATH12K_HTT_TXBF_NUM_BW_CNTRS];
+	__le32 txbf_flag_set_mu_mode;
+	__le32 txbf_flag_set_final_status;
+	__le32 txbf_flag_not_set_verified_txbf_mode;
+	__le32 txbf_flag_not_set_disable_p2p_access;
+	__le32 txbf_flag_not_set_max_nss_in_he160;
+	__le32 txbf_flag_not_set_disable_uldlofdma;
+	__le32 txbf_flag_not_set_mcs_threshold_val;
+	__le32 txbf_flag_not_set_final_status;
+} __packed;
+
 enum ath12k_htt_stats_page_lock_state {
 	ATH12K_HTT_STATS_PAGE_LOCKED	= 0,
 	ATH12K_HTT_STATS_PAGE_UNLOCKED	= 1,
-- 
2.25.1


