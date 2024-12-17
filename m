Return-Path: <linux-wireless+bounces-16459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92029F480B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C4716F00C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1240F1DED58;
	Tue, 17 Dec 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ecVZTKhE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D601DE3DE
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429176; cv=none; b=TwupyWQUBfMP5ax0qpAlX93lgd4yn0AY9jQgxn4r2Tw9pIOI2+hxtAthRvs4gbJvRQa2KnP47AUv+pjqMpF0L5jYLaYETw+pJKXrXsPytJycHcOUfw0mcwNJDaBZN2LLlq6pfHR9m89CWNhTKnDQJy2r5SXjgeJ9ke0zAhzqJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429176; c=relaxed/simple;
	bh=c5mUICvpFJB8rQl0mRRB9do1j3DRNep0icznl3J3d1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJ5UKaCw5Bq+lJAzKLRtzajoMPWxhVLZwIzCtL+OzCJQbKrlfJvpGQQjO9bAQsULHR9jPAronLCCyT1oSBtrKYw8Kr/tz4gVIwZ60ylK7DfplNIrzWT+nZYpQgGbiDxzICmY5cNX0JN6pgVWAlSaC0HajX2qX9OufGrh2+fbbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ecVZTKhE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMPvFw012765;
	Tue, 17 Dec 2024 09:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AzjhJLUxNbpixp1rzxQV5eg1aOoP3NtDnBtIwKzZZs0=; b=ecVZTKhEVRXCK/qM
	yjyi1zIL8L5D4lfd9KThovXxd3NbihQYciia39KVMMK1TGmFIb7sgKkS6eY32MiY
	q0kpVTZ4/9BENLn1hgoG7ABxpGOxWV+sg0eWlo68yNohs4ABeoaKqQAjV5N1aplb
	Hemo4ocouwLjA1yPLaSrH3zY/hB8MGaRTUqCIdR2pR4grvej8AKGdiXkiKOwvtVC
	65CDyIZ3fgJ9i1dEu8LJF3kEwr/XcZ5wCk78izKqCRm1Ki/osDtk35iJqWw8hvfW
	DY7DIPKStKOH+xYYJn26ebAEf+w7i2W70Cnwr7BCQfpfOKKF6eR/5hxNYvorZipW
	9jfoKg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jw069g8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 09:52:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH9qnJ9006331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 09:52:49 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 01:52:47 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 3/6] wifi: ath12k: Support Uplink OFDMA Trigger Stats
Date: Tue, 17 Dec 2024 15:22:13 +0530
Message-ID: <20241217095216.1543923-4-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
References: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: C9gtjGt_fgsfwllPUHmnXzWEvBPI-D0R
X-Proofpoint-GUID: C9gtjGt_fgsfwllPUHmnXzWEvBPI-D0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170081

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request uplink trigger stats from firmware through
HTT stats type 26. These stats give information about uplink
OFDMA bandwidth, received RSSI, power headroom, QoS, data size,
PPDU info and pass/fail info for each user.

Note: MCC firmware version
WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
does not support tags HTT_STATS_RX_PDEV_UL_TRIG_STATS_TAG(94) and
HTT_STATS_RX_PDEV_UL_OFDMA_USER_STATS_TAG(95), currently.

Sample output:
-------------
echo 26 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_RX_PDEV_UL_TRIGGER_STATS_TLV:
mac_id = 0
rx_11ax_ul_ofdma = 0
ul_ofdma_rx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_gi[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_gi[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_gi[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_gi[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_nss =  1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
ul_ofdma_rx_bw =  0:0, 1:0, 2:0, 3:0
half_ul_ofdma_rx_bw =  0:0, 1:0, 2:0, 3:0
quarter_ul_ofdma_rx_bw =  0:0, 1:0, 2:0, 3:0
.....

HTT_RX_PDEV_UL_OFDMA_USER_STAS_TLV:
rx_ulofdma_non_data_ppdu_0 = 0
rx_ulofdma_data_ppdu_0 = 0
rx_ulofdma_mpdu_ok_0 = 0
rx_ulofdma_mpdu_fail_0 = 0
rx_ulofdma_non_data_nusers_0 = 0
rx_ulofdma_data_nusers_0 = 0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 131 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  63 +++++++--
 2 files changed, 183 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index e86a42ff7bee..4569ff40e9d8 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2923,6 +2923,131 @@ ath12k_htt_print_latency_prof_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_ul_ofdma_trigger_stats(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_pdev_ul_trigger_stats_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u32 mac_id;
+	u8 j;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id = __le32_to_cpu(htt_stats_buf->mac_id__word);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_PDEV_UL_TRIGGER_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_ul_ofdma = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_11ax_ul_ofdma));
+	len += print_array_to_buf(buf, len, "ul_ofdma_rx_mcs",
+				  htt_stats_buf->ul_ofdma_rx_mcs,
+				  ATH12K_HTT_RX_NUM_MCS_CNTRS, "\n");
+	for (j = 0; j < ATH12K_HTT_RX_NUM_GI_CNTRS; j++) {
+		len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_gi[%u]", j);
+		len += print_array_to_buf(buf, len, "",
+					  htt_stats_buf->ul_ofdma_rx_gi[j],
+					  ATH12K_HTT_RX_NUM_MCS_CNTRS, "\n");
+	}
+
+	len += print_array_to_buf_index(buf, len, "ul_ofdma_rx_nss", 1,
+					htt_stats_buf->ul_ofdma_rx_nss,
+					ATH12K_HTT_RX_NUM_SPATIAL_STREAMS, "\n");
+	len += print_array_to_buf(buf, len, "ul_ofdma_rx_bw",
+				  htt_stats_buf->ul_ofdma_rx_bw,
+				  ATH12K_HTT_RX_NUM_BW_CNTRS, "\n");
+
+	for (j = 0; j < ATH12K_HTT_RX_NUM_REDUCED_CHAN_TYPES; j++) {
+		len += scnprintf(buf + len, buf_len - len, j == 0 ?
+				 "half_ul_ofdma_rx_bw" :
+				 "quarter_ul_ofdma_rx_bw");
+		len += print_array_to_buf(buf, len, "", htt_stats_buf->red_bw[j],
+					  ATH12K_HTT_RX_NUM_BW_CNTRS, "\n");
+	}
+	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_stbc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ul_ofdma_rx_stbc));
+	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_ldpc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ul_ofdma_rx_ldpc));
+
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_data_ru_size_ppdu = ");
+	for (j = 0; j < ATH12K_HTT_RX_NUM_RU_SIZE_CNTRS; j++)
+		len += scnprintf(buf + len, buf_len - len, " %s:%u ",
+				 ath12k_htt_ax_tx_rx_ru_size_to_str(j),
+				 le32_to_cpu(htt_stats_buf->data_ru_size_ppdu[j]));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_ulofdma_non_data_ru_size_ppdu = ");
+	for (j = 0; j < ATH12K_HTT_RX_NUM_RU_SIZE_CNTRS; j++)
+		len += scnprintf(buf + len, buf_len - len, " %s:%u ",
+				 ath12k_htt_ax_tx_rx_ru_size_to_str(j),
+				 le32_to_cpu(htt_stats_buf->non_data_ru_size_ppdu[j]));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += print_array_to_buf(buf, len, "rx_rssi_track_sta_aid",
+				  htt_stats_buf->uplink_sta_aid,
+				  ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK, "\n");
+	len += print_array_to_buf(buf, len, "rx_sta_target_rssi",
+				  htt_stats_buf->uplink_sta_target_rssi,
+				  ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK, "\n");
+	len += print_array_to_buf(buf, len, "rx_sta_fd_rssi",
+				  htt_stats_buf->uplink_sta_fd_rssi,
+				  ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK, "\n");
+	len += print_array_to_buf(buf, len, "rx_sta_power_headroom",
+				  htt_stats_buf->uplink_sta_power_headroom,
+				  ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK, "\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "ul_ofdma_basic_trigger_rx_qos_null_only = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->ul_ofdma_bsc_trig_rx_qos_null_only));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_ul_ofdma_user_stats(const void *tag_buf, u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_pdev_ul_ofdma_user_stats_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u32 user_index;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	user_index = __le32_to_cpu(htt_stats_buf->user_index);
+
+	if (!user_index)
+		len += scnprintf(buf + len, buf_len - len,
+				 "HTT_RX_PDEV_UL_OFDMA_USER_STAS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_non_data_ppdu_%u = %u\n",
+			 user_index,
+			 le32_to_cpu(htt_stats_buf->rx_ulofdma_non_data_ppdu));
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_data_ppdu_%u = %u\n",
+			 user_index,
+			 le32_to_cpu(htt_stats_buf->rx_ulofdma_data_ppdu));
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_mpdu_ok_%u = %u\n",
+			 user_index,
+			 le32_to_cpu(htt_stats_buf->rx_ulofdma_mpdu_ok));
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_mpdu_fail_%u = %u\n",
+			 user_index,
+			 le32_to_cpu(htt_stats_buf->rx_ulofdma_mpdu_fail));
+	len += scnprintf(buf + len, buf_len - len,
+			 "rx_ulofdma_non_data_nusers_%u = %u\n", user_index,
+			 le32_to_cpu(htt_stats_buf->rx_ulofdma_non_data_nusers));
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_data_nusers_%u = %u\n\n",
+			 user_index,
+			 le32_to_cpu(htt_stats_buf->rx_ulofdma_data_nusers));
+
+	stats_req->buf_len = len;
+}
+
 static void
 ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(const void *tag_buf, u16 tag_len,
 					     struct debug_htt_stats_req *stats_req)
@@ -4381,6 +4506,12 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_LATENCY_PROF_STATS_TAG:
 		ath12k_htt_print_latency_prof_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_RX_PDEV_UL_TRIG_STATS_TAG:
+		ath12k_htt_print_ul_ofdma_trigger_stats(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_RX_PDEV_UL_OFDMA_USER_STATS_TAG:
+		ath12k_htt_print_ul_ofdma_user_stats(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG:
 		ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 4578c5a6d12d..fdfc407d0bba 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -137,6 +137,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO	= 22,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 	ATH12K_DBG_HTT_EXT_STATS_LATENCY_PROF_STATS	= 25,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_UL_TRIG_STATS	= 26,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF	= 31,
 	ATH12K_DBG_HTT_EXT_STATS_TXBF_OFDMA		= 32,
 	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
@@ -205,6 +206,8 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_LATENCY_PROF_STATS_TAG		= 91,
 	HTT_STATS_LATENCY_CTX_TAG			= 92,
 	HTT_STATS_LATENCY_CNT_TAG			= 93,
+	HTT_STATS_RX_PDEV_UL_TRIG_STATS_TAG		= 94,
+	HTT_STATS_RX_PDEV_UL_OFDMA_USER_STATS_TAG	= 95,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
 	HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG		= 108,
@@ -1192,6 +1195,55 @@ struct ath12k_htt_latency_prof_cnt_tlv {
 	__le32 prof_enable_cnt;
 } __packed;
 
+#define ATH12K_HTT_RX_NUM_MCS_CNTRS		12
+#define ATH12K_HTT_RX_NUM_GI_CNTRS		4
+#define ATH12K_HTT_RX_NUM_SPATIAL_STREAMS	8
+#define ATH12K_HTT_RX_NUM_BW_CNTRS		4
+#define ATH12K_HTT_RX_NUM_RU_SIZE_CNTRS		6
+#define ATH12K_HTT_RX_NUM_RU_SIZE_160MHZ_CNTRS	7
+#define ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK	5
+#define ATH12K_HTT_RX_NUM_REDUCED_CHAN_TYPES	2
+
+enum ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE {
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_26,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_52,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_106,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_242,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_484,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996x2,
+	ATH12K_HTT_TX_RX_PDEV_STATS_NUM_AX_RU_SIZE_CNTRS,
+};
+
+struct ath12k_htt_rx_pdev_ul_ofdma_user_stats_tlv {
+	__le32 user_index;
+	__le32 rx_ulofdma_non_data_ppdu;
+	__le32 rx_ulofdma_data_ppdu;
+	__le32 rx_ulofdma_mpdu_ok;
+	__le32 rx_ulofdma_mpdu_fail;
+	__le32 rx_ulofdma_non_data_nusers;
+	__le32 rx_ulofdma_data_nusers;
+} __packed;
+
+struct ath12k_htt_rx_pdev_ul_trigger_stats_tlv {
+	__le32 mac_id__word;
+	__le32 rx_11ax_ul_ofdma;
+	__le32 ul_ofdma_rx_mcs[ATH12K_HTT_RX_NUM_MCS_CNTRS];
+	__le32 ul_ofdma_rx_gi[ATH12K_HTT_RX_NUM_GI_CNTRS][ATH12K_HTT_RX_NUM_MCS_CNTRS];
+	__le32 ul_ofdma_rx_nss[ATH12K_HTT_RX_NUM_SPATIAL_STREAMS];
+	__le32 ul_ofdma_rx_bw[ATH12K_HTT_RX_NUM_BW_CNTRS];
+	__le32 ul_ofdma_rx_stbc;
+	__le32 ul_ofdma_rx_ldpc;
+	__le32 data_ru_size_ppdu[ATH12K_HTT_RX_NUM_RU_SIZE_160MHZ_CNTRS];
+	__le32 non_data_ru_size_ppdu[ATH12K_HTT_RX_NUM_RU_SIZE_160MHZ_CNTRS];
+	__le32 uplink_sta_aid[ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK];
+	__le32 uplink_sta_target_rssi[ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK];
+	__le32 uplink_sta_fd_rssi[ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK];
+	__le32 uplink_sta_power_headroom[ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK];
+	__le32 red_bw[ATH12K_HTT_RX_NUM_REDUCED_CHAN_TYPES][ATH12K_HTT_RX_NUM_BW_CNTRS];
+	__le32 ul_ofdma_bsc_trig_rx_qos_null_only;
+} __packed;
+
 #define ATH12K_HTT_TX_BF_RATE_STATS_NUM_MCS_COUNTERS		14
 #define ATH12K_HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS		8
 #define ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS		8
@@ -1529,17 +1581,6 @@ enum ATH12K_HTT_RC_MODE {
 	ATH12K_HTT_RC_MODE_2D_COUNT
 };
 
-enum ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE {
-	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_26,
-	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_52,
-	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_106,
-	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_242,
-	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_484,
-	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996,
-	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996x2,
-	ATH12K_HTT_TX_RX_PDEV_STATS_NUM_AX_RU_SIZE_CNTRS
-};
-
 enum ath12k_htt_stats_rc_mode {
 	ATH12K_HTT_STATS_RC_MODE_DLSU     = 0,
 	ATH12K_HTT_STATS_RC_MODE_DLMUMIMO = 1,
-- 
2.25.1


