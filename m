Return-Path: <linux-wireless+bounces-17393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E38F5A0AFAE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8A91661C8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A9231C88;
	Mon, 13 Jan 2025 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j3UpGGWW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00730231A26
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736752343; cv=none; b=ZFrT9FVzo3p/IcE267sRRKaGT7UsCTa/FDkA47DFsf/1shWbmZPxvsugbxUy4M84g5Sv5a6u967Sm0IeoiSJGLZJsaq1ghKdSPcOWq8vqZGM8lZl6aYjwloE2d7UQrCdd+BcVu567hBdH/WyGYneA6kKe44TL6D+w6hZFNA3oKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736752343; c=relaxed/simple;
	bh=ZaPf5023EItqjLPOPzwNIhW7s8Rrh7ftUHf2xOVgBdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzyg4PIxnJRYfX8lhn0aDUR2Lhl51E0IhIsbi9UirJZzDcjqEUkmDKns9w395w2GeVgHY+0tKCHf6wOP5lrYG6zdEcespjk1YAEYZqQRsfcWAuIqYkzaabyn7XsmMhAh8xEoe1IlJ6oTWomteablyiWUbdh9JvFl1DKFBlhXboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j3UpGGWW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CNieeV026061;
	Mon, 13 Jan 2025 07:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KXLIy7FkwVhf4q0CEaIUxCru69Yz6W7kDoBRmbJe+N8=; b=j3UpGGWW83q+ISXi
	Nt3o6dGiYfLLVr/sgACntVJDIFJLRbXKfKTakOxZQC4yXZC6SMg4t/25cbVH+uY8
	uB6kY3VJb95j02P8LH09nfyCdbKnGoROxMO+iRSlldDJufbmko2+OADc1KVqTf84
	Hxfdrb3hnCMV+hR9arytIGQvjkgJ3Eex89daB8P/Edf5TsojqGTewRoYCb3Ude/l
	W48QQFQIEk03Q57wYdeuwmHWlIY3UPrPCOyBcIJoTRjjBtPVzyaJVAa5YUy6n2Dw
	9rrK6Ucug01jeeB185vaw2MRq06LuHRim22UAGAKIoly8lVb8vykpd2JORt1pzNh
	k3MTBw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444f5bhdm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:12:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D7CJc9008932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:12:19 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 Jan 2025 23:12:17 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v3 5/6] wifi: ath12k: Support Uplink MUMIMO Trigger Stats
Date: Mon, 13 Jan 2025 12:41:43 +0530
Message-ID: <20250113071144.3397293-6-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: nmMLqrvEk5Ek2qZVS0HinY3qGmgBOfqv
X-Proofpoint-ORIG-GUID: nmMLqrvEk5Ek2qZVS0HinY3qGmgBOfqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130060

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request uplink MUMIMO trigger stats from firmware
through HTT stats type 27. These stats give information about
bandwidth, RSSI of signal received, dB mean of pilots received,
etc., of all users.

Note: MCC firmware version WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
does not support tags HTT_STATS_RX_PDEV_UL_TRIG_STATS_TAG(94) and
HTT_STATS_RX_PDEV_UL_OFDMA_USER_STATS_TAG(95), currently.

Sample output:
-------------
echo 27 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_RX_PDEV_UL_MUMIMO_TRIG_STATS_TLV:
mac_id = 0
rx_11ax_ul_mumimo = 0
ul_mumimo_rx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ul_mumimo_rx_gi_0 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ul_mumimo_rx_gi_1 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
.....
ul_mumimo_rx_nss =  1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
ul_mumimo_rx_bw =  0:0, 1:0, 2:0, 3:0
half_ul_mumimo_rx_bw =  0:0, 1:0, 2:0, 3:0
quarter_ul_mumimo_rx_bw =  0:0, 1:0, 2:0, 3:0
ul_mumimo_rx_stbc = 0
ul_mumimo_rx_ldpc = 0
rx_ul_mumimo_rssi_in_dbm: chain0  =  0:6, 1:0, 2:0, 3:0
rx_ul_mumimo_rssi_in_dbm: chain1  =  0:0, 1:0, 2:0, 3:0
.....
rx_ul_mumimo_target_rssi: user_0  =  0:-128, 1:-128, 2:-128, 3:-128
rx_ul_mumimo_target_rssi: user_1  =  0:-128, 1:-128, 2:-128, 3:-128
.....
rx_ul_mumimo_fd_rssi: user_0  =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ul_mumimo_fd_rssi: user_1  =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
.....
rx_ulmumimo_pilot_evm_db_mean: user_0  =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ulmumimo_pilot_evm_db_mean: user_1  =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
.....
ul_mumimo_basic_trigger_rx_qos_null_only = 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 127 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  78 +++++++----
 2 files changed, 178 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 92935134735a..e74245c7ed0e 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -3402,6 +3402,130 @@ ath12k_htt_print_txbf_ofdma_ax_steer_mpdu_stats_tlv(const void *tag_buf, u16 tag
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_ul_mumimo_trig_stats(const void *tag_buf, u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_ul_mumimo_trig_stats_tlv *htt_stats_buf = tag_buf;
+	char str_buf[ATH12K_HTT_MAX_STRING_LEN] = {0};
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u32 mac_id;
+	u16 index;
+	u8 i, j;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id = __le32_to_cpu(htt_stats_buf->mac_id__word);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_PDEV_UL_MUMIMO_TRIG_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_ul_mumimo = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_11ax_ul_mumimo));
+	index = 0;
+	memset(str_buf, 0x0, ATH12K_HTT_MAX_STRING_LEN);
+	for (i = 0; i < ATH12K_HTT_RX_NUM_MCS_CNTRS; i++)
+		index += scnprintf(&str_buf[index], ATH12K_HTT_MAX_STRING_LEN - index,
+				  " %u:%u,", i,
+				  le32_to_cpu(htt_stats_buf->ul_mumimo_rx_mcs[i]));
+
+	for (i = 0; i < ATH12K_HTT_RX_NUM_EXTRA_MCS_CNTRS; i++)
+		index += scnprintf(&str_buf[index], ATH12K_HTT_MAX_STRING_LEN - index,
+				  " %u:%u,", i + ATH12K_HTT_RX_NUM_MCS_CNTRS,
+				  le32_to_cpu(htt_stats_buf->ul_mumimo_rx_mcs_ext[i]));
+	str_buf[--index] = '\0';
+	len += scnprintf(buf + len, buf_len - len, "ul_mumimo_rx_mcs = %s\n", str_buf);
+
+	for (j = 0; j < ATH12K_HTT_RX_NUM_GI_CNTRS; j++) {
+		index = 0;
+		memset(&str_buf[index], 0x0, ATH12K_HTT_MAX_STRING_LEN);
+		for (i = 0; i < ATH12K_HTT_RX_NUM_MCS_CNTRS; i++)
+			index += scnprintf(&str_buf[index],
+					  ATH12K_HTT_MAX_STRING_LEN - index,
+					  " %u:%u,", i,
+					  le32_to_cpu(htt_stats_buf->ul_rx_gi[j][i]));
+
+		for (i = 0; i < ATH12K_HTT_RX_NUM_EXTRA_MCS_CNTRS; i++)
+			index += scnprintf(&str_buf[index],
+					  ATH12K_HTT_MAX_STRING_LEN - index,
+					  " %u:%u,", i + ATH12K_HTT_RX_NUM_MCS_CNTRS,
+					  le32_to_cpu(htt_stats_buf->ul_gi_ext[j][i]));
+		str_buf[--index] = '\0';
+		len += scnprintf(buf + len, buf_len - len,
+				 "ul_mumimo_rx_gi_%u = %s\n", j, str_buf);
+	}
+
+	index = 0;
+	memset(str_buf, 0x0, ATH12K_HTT_MAX_STRING_LEN);
+	len += print_array_to_buf_index(buf, len, "ul_mumimo_rx_nss", 1,
+					htt_stats_buf->ul_mumimo_rx_nss,
+					ATH12K_HTT_RX_NUM_SPATIAL_STREAMS, "\n");
+
+	len += print_array_to_buf(buf, len, "ul_mumimo_rx_bw",
+				  htt_stats_buf->ul_mumimo_rx_bw,
+				  ATH12K_HTT_RX_NUM_BW_CNTRS, "\n");
+	for (i = 0; i < ATH12K_HTT_RX_NUM_REDUCED_CHAN_TYPES; i++) {
+		index = 0;
+		memset(str_buf, 0x0, ATH12K_HTT_MAX_STRING_LEN);
+		for (j = 0; j < ATH12K_HTT_RX_NUM_BW_CNTRS; j++)
+			index += scnprintf(&str_buf[index],
+					  ATH12K_HTT_MAX_STRING_LEN - index,
+					  " %u:%u,", j,
+					  le32_to_cpu(htt_stats_buf->red_bw[i][j]));
+		str_buf[--index] = '\0';
+		len += scnprintf(buf + len, buf_len - len, "%s = %s\n",
+				 i == 0 ? "half_ul_mumimo_rx_bw" :
+				 "quarter_ul_mumimo_rx_bw", str_buf);
+	}
+
+	len += scnprintf(buf + len, buf_len - len, "ul_mumimo_rx_stbc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ul_mumimo_rx_stbc));
+	len += scnprintf(buf + len, buf_len - len, "ul_mumimo_rx_ldpc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ul_mumimo_rx_ldpc));
+
+	for (j = 0; j < ATH12K_HTT_RX_NUM_SPATIAL_STREAMS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_ul_mumimo_rssi_in_dbm: chain%u ", j);
+		len += print_array_to_buf_s8(buf, len, "", 0,
+					     htt_stats_buf->ul_rssi[j],
+					     ATH12K_HTT_RX_NUM_BW_CNTRS, "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_TX_UL_MUMIMO_USER_STATS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_ul_mumimo_target_rssi: user_%u ", j);
+		len += print_array_to_buf_s8(buf, len, "", 0,
+					     htt_stats_buf->tgt_rssi[j],
+					     ATH12K_HTT_RX_NUM_BW_CNTRS, "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_TX_UL_MUMIMO_USER_STATS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_ul_mumimo_fd_rssi: user_%u ", j);
+		len += print_array_to_buf_s8(buf, len, "", 0,
+					     htt_stats_buf->fd[j],
+					     ATH12K_HTT_RX_NUM_SPATIAL_STREAMS, "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_TX_UL_MUMIMO_USER_STATS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_ulmumimo_pilot_evm_db_mean: user_%u ", j);
+		len += print_array_to_buf_s8(buf, len, "", 0,
+					     htt_stats_buf->db[j],
+					     ATH12K_HTT_RX_NUM_SPATIAL_STREAMS, "\n");
+	}
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "ul_mumimo_basic_trigger_rx_qos_null_only = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->mumimo_bsc_trig_rx_qos_null_only));
+
+	stats_req->buf_len = len;
+}
+
 static void ath12k_htt_print_dlpager_entry(const struct ath12k_htt_pgs_info *pg_info,
 					   int idx, char *str_buf)
 {
@@ -4522,6 +4646,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 		ath12k_htt_print_txbf_ofdma_ax_steer_mpdu_stats_tlv(tag_buf, len,
 								    stats_req);
 		break;
+	case HTT_STATS_RX_PDEV_UL_MUMIMO_TRIG_STATS_TAG:
+		ath12k_htt_print_ul_mumimo_trig_stats(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_DLPAGER_STATS_TAG:
 		ath12k_htt_print_dlpager_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index fdfc407d0bba..588211605e80 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -123,33 +123,34 @@ struct ath12k_htt_extd_stats_msg {
 
 /* htt_dbg_ext_stats_type */
 enum ath12k_dbg_htt_ext_stats_type {
-	ATH12K_DBG_HTT_EXT_STATS_RESET			= 0,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX		= 1,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED		= 4,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR		= 5,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM		= 6,
-	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO		= 8,
-	ATH12K_DBG_HTT_EXT_STATS_TX_SELFGEN_INFO	= 12,
-	ATH12K_DBG_HTT_EXT_STATS_SRNG_INFO		= 15,
-	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO		= 16,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
-	ATH12K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO	= 22,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
-	ATH12K_DBG_HTT_EXT_STATS_LATENCY_PROF_STATS	= 25,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_UL_TRIG_STATS	= 26,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF	= 31,
-	ATH12K_DBG_HTT_EXT_STATS_TXBF_OFDMA		= 32,
-	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
-	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	= 37,
-	ATH12K_DBG_HTT_EXT_VDEVS_TXRX_STATS		= 38,
-	ATH12K_DBG_HTT_EXT_PDEV_PER_STATS		= 40,
-	ATH12K_DBG_HTT_EXT_AST_ENTRIES			= 41,
-	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
-	ATH12K_DBG_HTT_DBG_PDEV_PUNCTURE_STATS		= 46,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
-	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
-	ATH12K_DGB_HTT_EXT_STATS_PDEV_MBSSID_CTRL_FRAME	= 54,
+	ATH12K_DBG_HTT_EXT_STATS_RESET				= 0,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX			= 1,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED			= 4,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR			= 5,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM			= 6,
+	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO			= 8,
+	ATH12K_DBG_HTT_EXT_STATS_TX_SELFGEN_INFO		= 12,
+	ATH12K_DBG_HTT_EXT_STATS_SRNG_INFO			= 15,
+	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO			= 16,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU			= 17,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS			= 19,
+	ATH12K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO		= 22,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS		= 23,
+	ATH12K_DBG_HTT_EXT_STATS_LATENCY_PROF_STATS		= 25,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_UL_TRIG_STATS		= 26,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_UL_MUMIMO_TRIG_STATS	= 27,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF		= 31,
+	ATH12K_DBG_HTT_EXT_STATS_TXBF_OFDMA			= 32,
+	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS			= 36,
+	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS		= 37,
+	ATH12K_DBG_HTT_EXT_VDEVS_TXRX_STATS			= 38,
+	ATH12K_DBG_HTT_EXT_PDEV_PER_STATS			= 40,
+	ATH12K_DBG_HTT_EXT_AST_ENTRIES				= 41,
+	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR			= 45,
+	ATH12K_DBG_HTT_DBG_PDEV_PUNCTURE_STATS			= 46,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO		= 49,
+	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA		= 51,
+	ATH12K_DGB_HTT_EXT_STATS_PDEV_MBSSID_CTRL_FRAME		= 54,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -208,6 +209,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_LATENCY_CNT_TAG			= 93,
 	HTT_STATS_RX_PDEV_UL_TRIG_STATS_TAG		= 94,
 	HTT_STATS_RX_PDEV_UL_OFDMA_USER_STATS_TAG	= 95,
+	HTT_STATS_RX_PDEV_UL_MUMIMO_TRIG_STATS_TAG	= 97,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
 	HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG		= 108,
@@ -1203,6 +1205,7 @@ struct ath12k_htt_latency_prof_cnt_tlv {
 #define ATH12K_HTT_RX_NUM_RU_SIZE_160MHZ_CNTRS	7
 #define ATH12K_HTT_RX_UL_MAX_UPLINK_RSSI_TRACK	5
 #define ATH12K_HTT_RX_NUM_REDUCED_CHAN_TYPES	2
+#define ATH12K_HTT_RX_NUM_EXTRA_MCS_CNTRS	2
 
 enum ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE {
 	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_26,
@@ -1335,6 +1338,27 @@ struct ath12k_htt_txbf_ofdma_ax_steer_mpdu_stats_tlv {
 	__le32 ax_ofdma_sifs_steer_mpdus_failed;
 } __packed;
 
+#define ATH12K_HTT_TX_UL_MUMIMO_USER_STATS	8
+
+struct ath12k_htt_rx_ul_mumimo_trig_stats_tlv {
+	__le32 mac_id__word;
+	__le32 rx_11ax_ul_mumimo;
+	__le32 ul_mumimo_rx_mcs[ATH12K_HTT_RX_NUM_MCS_CNTRS];
+	__le32 ul_rx_gi[ATH12K_HTT_RX_NUM_GI_CNTRS][ATH12K_HTT_RX_NUM_MCS_CNTRS];
+	__le32 ul_mumimo_rx_nss[ATH12K_HTT_RX_NUM_SPATIAL_STREAMS];
+	__le32 ul_mumimo_rx_bw[ATH12K_HTT_RX_NUM_BW_CNTRS];
+	__le32 ul_mumimo_rx_stbc;
+	__le32 ul_mumimo_rx_ldpc;
+	__le32 ul_mumimo_rx_mcs_ext[ATH12K_HTT_RX_NUM_EXTRA_MCS_CNTRS];
+	__le32 ul_gi_ext[ATH12K_HTT_RX_NUM_GI_CNTRS][ATH12K_HTT_RX_NUM_EXTRA_MCS_CNTRS];
+	s8 ul_rssi[ATH12K_HTT_RX_NUM_SPATIAL_STREAMS][ATH12K_HTT_RX_NUM_BW_CNTRS];
+	s8 tgt_rssi[ATH12K_HTT_TX_UL_MUMIMO_USER_STATS][ATH12K_HTT_RX_NUM_BW_CNTRS];
+	s8 fd[ATH12K_HTT_TX_UL_MUMIMO_USER_STATS][ATH12K_HTT_RX_NUM_SPATIAL_STREAMS];
+	s8 db[ATH12K_HTT_TX_UL_MUMIMO_USER_STATS][ATH12K_HTT_RX_NUM_SPATIAL_STREAMS];
+	__le32 red_bw[ATH12K_HTT_RX_NUM_REDUCED_CHAN_TYPES][ATH12K_HTT_RX_NUM_BW_CNTRS];
+	__le32 mumimo_bsc_trig_rx_qos_null_only;
+} __packed;
+
 enum ath12k_htt_stats_page_lock_state {
 	ATH12K_HTT_STATS_PAGE_LOCKED	= 0,
 	ATH12K_HTT_STATS_PAGE_UNLOCKED	= 1,
-- 
2.25.1


