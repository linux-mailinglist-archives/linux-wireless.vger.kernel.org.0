Return-Path: <linux-wireless+bounces-10244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B9931EF4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 04:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18B9281877
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 02:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427BFB653;
	Tue, 16 Jul 2024 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ODGvBD9z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683826FB8
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097965; cv=none; b=pcLz6XfHOSnf/DMf4l839ALxKUtFp0n9rWbbDoWPw/Op0Uf9XUBQSq/IoNW52gU6ahXyzpACKQ1sXYE+ExoOw5lCbGJxwJZmcpKDVT4wWalYVMNIv1VAZl0PUqctKBn9AViI5KIGYMkRDutrobRw4krdy1T7VwyrCRZtpbdEu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097965; c=relaxed/simple;
	bh=JCJnj1L9O8NNiFZ+7/1XzhaYsxfB0GxvOXznjXu6kpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJT43WhEKJqbfoBHNaTP7MnrEnFIbzLh5UQd0wZWRvW8g4pLDulyBcnyaHiB6TKgs1HBTVbmY8TNnb+3zYWUjOCc1SCcUmjVya3YVlGf2g4aFR8lMXP43j4x/GxlNmkLxiO411TSrHyy+aAyyBeadzWJGG453Lu/hlbNK1l0/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ODGvBD9z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FNBHLb012478;
	Tue, 16 Jul 2024 02:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gRo+QwVTimkZeoZ+xMO6s1/yPrahl/IzetNRnlWRdEc=; b=ODGvBD9zHkAzdEs4
	zChGWNpJz5fAbj8miMCnJpbyopgFGuWLVsDQT+z2CtC19x1eol+w19Fgldg07oV7
	f8hgqJGVyjBoJiypagwpn5sP93YizCMf7mSKDx2wNex4ZR/nWhhOTFbwCbtcJb4d
	7CWfjvEJRQEynI0J8CmhB98ngOSsaXpv76u/+m71mZcYUebv/2Z+irlO4iAV7AVE
	b1WPL2f4pVOsFycuWB0cv8AjQfQc6B7quJV3wZNt0y3yAZosd2Fz97NovB3qTqdx
	sajFNsoiwqkCKhtzvuKBgduKIbVTRK/hVEv+7imTyTuX0h4Gnaw9KWXan8FmgG4u
	KW+OhA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bhy6ww45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 02:46:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G2jw6S024573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 02:45:58 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 19:45:57 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: Dump additional PDEV receive rate HTT stats
Date: Tue, 16 Jul 2024 10:45:42 +0800
Message-ID: <20240716024542.30339-4-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716024542.30339-1-quic_lingbok@quicinc.com>
References: <20240716024542.30339-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t9odFNHd_5UGb75LvruHm-gbspCjU4j2
X-Proofpoint-ORIG-GUID: t9odFNHd_5UGb75LvruHm-gbspCjU4j2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=919
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160021

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
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 74 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 32 ++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 3b1cedc9de60..c379f8a51519 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1867,6 +1867,77 @@ ath12k_htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf, u16 tag_len,
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
@@ -1978,6 +2049,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
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
index 9272a9e82749..56aa1383de8f 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -131,6 +131,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO	= 8,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE   = 9,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE   = 10,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE_EXT       =       30,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -170,6 +171,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_HW_WAR_TAG				= 89,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
+	HTT_STATS_RX_PDEV_RATE_EXT_STATS_TAG            = 103,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
 
 	HTT_STATS_MAX_TAG,
@@ -476,6 +478,36 @@ struct ath12k_htt_rx_pdev_rate_stats_tlv {
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


