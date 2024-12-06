Return-Path: <linux-wireless+bounces-15976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98F9E6F58
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 14:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183F9286716
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFCB2066FA;
	Fri,  6 Dec 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QEY2dAGK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA01FCCFB
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492054; cv=none; b=qQK37hXZ50390VBFtm9trUlxog0v9N70ATVcm587K1fInI97yxbScX8wLTzJOyJ8DsAPYxQgmcgyJq97SjX764sThGcjPMvGoLl1ZLeNB1JLuxLP8epM314QCjQ7waGkM2mW9UsiSqc3YWrn6aUUg0InDFHBDV7ybQcdgSx3o3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492054; c=relaxed/simple;
	bh=oRb1Gh4uv29tWGEIxb88ZfEv1nNgne+DoZXrzaxhMdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dL52X+RVFsH58qP5SxxwAVvYBEzCC+jcBJq/HqWndOrjx/gHFohli47mySQG9D1/ydFh4HmNNUAJhaKNAsVjyt7/7Gj41A8qTOOAS4jwmUo5SxQ/vBAJnD1ie8GKK0/nyO2rgZxiKgsxRBFsXdN5V07RL6FHt+7vZifDW1/AZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QEY2dAGK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B64aa1n003153;
	Fri, 6 Dec 2024 13:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/5nUbCIvp6JdvvJAk4zKnxa4kYkPtXTqLMxXXLAh2WA=; b=QEY2dAGKnqJ368B1
	9Wjp+i7L00WNLsp/JF5ZeqDu5rV4h+V5XqsrboSm/VP+JFAU+fDbgwV19eSXR21D
	GywVpk9s0d8TDEBb+B4q4I7JoG48EzL46gigby2baOVmtKeBxEt2AjacM5v0bY2e
	SGXFBluYxKYC9NqtE9Vtd53jG/7zj8VzoZRsOhqa7zEbw7gM+6vuMuOvESNslHkF
	0SMrEhLQeYfSFMax/jC78mY3UDX00YX5xsSrIkhCpMt9wKFfUfNbZJI7z0+lbdd0
	Bk/QeizB5kUCTjgmPfJKkSWFZ9oF6lwiKB2c6MXqKN3UE+b6apwtBep74oemgrKF
	RfHXow==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43btd31dw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 13:34:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6DYAJg005628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 13:34:10 GMT
Received: from lingbok.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 6 Dec 2024 05:34:08 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 3/3] wifi: ath12k: Dump additional PDEV receive rate HTT stats
Date: Fri, 6 Dec 2024 21:33:55 +0800
Message-ID: <20241206133355.1990-4-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20241206133355.1990-1-quic_lingbok@quicinc.com>
References: <20241206133355.1990-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OwpZvNTj3YU9WEMIQVvxqNunLe_6aeFz
X-Proofpoint-ORIG-GUID: OwpZvNTj3YU9WEMIQVvxqNunLe_6aeFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=860 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060101

Support to dump additional PDEV receive rate stats through HTT debugfs
stats type 30.

Sample output:
------------------
echo 30 > /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats
HTT_RX_PDEV_RATE_EXT_STATS_TLV:
rssi_mgmt_in_dbm = -48
rx_stbc_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ul_ofdma_rx_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
rx_11ax_su_txbf_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:9, 6:72, 7:41, 8:1, 9:0, 10:0, 11:0, 12:0, 13:0
rx_11ax_mu_txbf_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
rx_11ax_dl_ofdma_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
rx_bw_ext =  0:1395, 1:0, 2:0, 3:0, 4:0
rx_su_punctured_mode =  0:0, 1:0, 2:0, 3:0, 4:0
rx_mcs_ext =  0:0, 1:0, 2:0, 3:0, 4:0, 5:14, 6:149, 7:44, 8:1, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
rx_gi_ext[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:14, 6:149, 7:44, 8:1, 9:0, 10:0, 11:0, 12:0, 13:0
rx_gi_ext[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
rx_gi_ext[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
rx_gi_ext[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ul_ofdma_rx_gi_ext[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ul_ofdma_rx_gi_ext[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ul_ofdma_rx_gi_ext[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ul_ofdma_rx_gi_ext[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
v3:
1.no change

v2:
1.use TAB to be consistent with existing code

.../wireless/ath/ath12k/debugfs_htt_stats.c   | 74 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 32 ++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 62ace0bcd8e7..3caa91930d0e 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -3755,6 +3755,77 @@ ath12k_htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static inline void
+ath12k_htt_print_rx_pdev_rate_ext_stats_tlv(const void *tag_buf, u16 tag_len,
+					    struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_pdev_rate_ext_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u8 j;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_RATE_EXT_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "rssi_mgmt_in_dbm = %d\n",
+			 le32_to_cpu(htt_stats_buf->rssi_mgmt_in_dbm));
+
+	len += print_array_to_buf(buf, len, "rx_stbc_ext",
+				  htt_stats_buf->rx_stbc_ext,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+	len += print_array_to_buf(buf, len, "ul_ofdma_rx_mcs_ext",
+				  htt_stats_buf->ul_ofdma_rx_mcs_ext,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+	len += print_array_to_buf(buf, len, "rx_11ax_su_txbf_mcs_ext",
+				  htt_stats_buf->rx_11ax_su_txbf_mcs_ext,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+	len += print_array_to_buf(buf, len, "rx_11ax_mu_txbf_mcs_ext",
+				  htt_stats_buf->rx_11ax_mu_txbf_mcs_ext,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+	len += print_array_to_buf(buf, len, "rx_11ax_dl_ofdma_mcs_ext",
+				  htt_stats_buf->rx_11ax_dl_ofdma_mcs_ext,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+	len += print_array_to_buf(buf, len, "rx_bw_ext",
+				  htt_stats_buf->rx_bw_ext,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_BW_EXT2_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "rx_su_punctured_mode",
+				  htt_stats_buf->rx_su_punctured_mode,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_PUNCTURED_MODE_COUNTERS,
+				  "\n");
+
+	len += print_array_to_buf(buf, len, "rx_mcs_ext",
+				  htt_stats_buf->rx_mcs_ext,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT,
+				  NULL);
+	for (j = 0; j < ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS; j++)
+		len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+				 j + ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT,
+				 le32_to_cpu(htt_stats_buf->rx_mcs_ext_2[j]));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	for (j = 0; j < ATH12K_HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_gi_ext[%u] = ", j);
+		len += print_array_to_buf(buf, len, NULL,
+					  htt_stats_buf->rx_gi_ext[j],
+					  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT,
+					  "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "ul_ofdma_rx_gi_ext[%u] = ", j);
+		len += print_array_to_buf(buf, len, NULL,
+					  htt_stats_buf->ul_ofdma_rx_gi_ext[j],
+					  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT,
+					  "\n");
+	}
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -3971,6 +4042,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_RX_PDEV_RATE_STATS_TAG:
 		ath12k_htt_print_rx_pdev_rate_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_RX_PDEV_RATE_EXT_STATS_TAG:
+		ath12k_htt_print_rx_pdev_rate_ext_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 65e95d1e04e5..57376307959f 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -137,6 +137,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE_EXT   = 30,
 	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
 	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	= 37,
 	ATH12K_DBG_HTT_EXT_VDEVS_TXRX_STATS		= 38,
@@ -201,6 +202,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_HW_WAR_TAG				= 89,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
+	HTT_STATS_RX_PDEV_RATE_EXT_STATS_TAG        = 103,
 	HTT_STATS_TX_SELFGEN_AC_SCHED_STATUS_STATS_TAG	= 111,
 	HTT_STATS_TX_SELFGEN_AX_SCHED_STATUS_STATS_TAG	= 112,
 	HTT_STATS_DLPAGER_STATS_TAG			= 120,
@@ -525,6 +527,36 @@ struct ath12k_htt_rx_pdev_rate_stats_tlv {
 	__le32 rx_mcs_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
 };
 
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_BW_EXT_COUNTERS		4
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT		14
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS	2
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_BW_EXT2_COUNTERS		5
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_PUNCTURED_MODE_COUNTERS	5
+
+struct ath12k_htt_rx_pdev_rate_ext_stats_tlv {
+	u8 rssi_chain_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+			 [ATH12K_HTT_RX_PDEV_STATS_NUM_BW_EXT_COUNTERS];
+	s8 rx_per_chain_rssi_ext_in_dbm[ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+				       [ATH12K_HTT_RX_PDEV_STATS_NUM_BW_EXT_COUNTERS];
+	__le32 rssi_mcast_in_dbm;
+	__le32 rssi_mgmt_in_dbm;
+	__le32 rx_mcs_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	__le32 rx_stbc_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	__le32 rx_gi_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_GI_COUNTERS]
+		     [ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	__le32 ul_ofdma_rx_mcs_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	__le32 ul_ofdma_rx_gi_ext[ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+			      [ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	__le32 rx_11ax_su_txbf_mcs_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	__le32 rx_11ax_mu_txbf_mcs_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	__le32 rx_11ax_dl_ofdma_mcs_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	__le32 rx_mcs_ext_2[ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS];
+	__le32 rx_bw_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_BW_EXT2_COUNTERS];
+	__le32 rx_gi_ext_2[ATH12K_HTT_RX_PDEV_STATS_NUM_GI_COUNTERS]
+		[ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS];
+	__le32 rx_su_punctured_mode[ATH12K_HTT_RX_PDEV_STATS_NUM_PUNCTURED_MODE_COUNTERS];
+};
+
 #define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_MAC_ID	GENMASK(7, 0)
 #define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_ID	GENMASK(15, 8)
 
-- 
2.34.1


