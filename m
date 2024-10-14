Return-Path: <linux-wireless+bounces-13934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01E99C0B2
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 09:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10AF1F234CF
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 07:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37917136353;
	Mon, 14 Oct 2024 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dAlx6+/E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A81304AB
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889603; cv=none; b=q5AvwApu1mcebZDzUtWs7rJRicvPs/rGVpgctctL5AeDAQsO8SUDW6kmRO15OVxoKbvKJXTA5M6U46Sw2aJ5zSrmFA1Rdq+QyJwjq3q+Bt9Vn8j1TMhQb92fSIzT0ww1nNZYcdji/QgsLB2UW25voNVCF4Qv6OEAdAnSglylzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889603; c=relaxed/simple;
	bh=YxwKtAcaq7OUrPUKWiCx6jKM2yLLng2F/kLntaDOOBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tghv53RhAv5HBLnXxQcj7CD/SWFsuO61fRc5nUUqHxI73lnvKTVEjDn2FnfAMFq4Y0g2NAD5O5hzGRLLdMula+7VG6sC62V+m4yiiVzY439rqdm4bSbFpEmKXpDpmzTOhOw5Cb/hyrFuO3QMTTCnt9WnuUgG8A4bFIu3BO6yX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dAlx6+/E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DKqamF027318;
	Mon, 14 Oct 2024 07:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ooHQVm/zIMFoR/uqDiqM5oMGmXewellBfIxs4wCQoHw=; b=dAlx6+/EzCXgbt0h
	f6+TcP8l0RA5C9gKw4o4vtQLzd5VvugL+7n557rKXw48IXT9WFOCgVFOrg0nWT/g
	TIpF2tVwu/+ORqZKLMxT8CUpD5S72Di/nRk7WqnjoLzVgk+thbCqMhyKRKq7HGJF
	fflZdGC9rbsE2yjrxc/ZRKqgC5BTVuPnZG6dxKlMVu7dKcPlyIbzrkfNDUrhOSMU
	DX4D9WSOAemh7NPyciCqGoDbLz8PxhUxR8t74EcwO8QIEWaR7RaaSmOyFC3Bmm9Z
	s6o9Dkm451c57WlHXkRSSu9e5jL3HcTQgbRs5loNWTVgdUtHql8SrA8JRl1/WJDs
	2bPKVQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427gpxkjk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:06:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49E76ZVC020750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:06:35 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Oct 2024 00:06:33 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v3 2/2] wifi: ath12k: Support BE OFDMA Pdev Rate Stats
Date: Mon, 14 Oct 2024 12:36:10 +0530
Message-ID: <20241014070610.3982173-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014070610.3982173-1-quic_rdevanat@quicinc.com>
References: <20241014070610.3982173-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: 40YBXkp9pjDdNCNs2IsKbFJ90GhHY49v
X-Proofpoint-ORIG-GUID: 40YBXkp9pjDdNCNs2IsKbFJ90GhHY49v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410140051

From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

Add support to request BE OFDMA pdev rate stats from firmware
through HTT stats type 51. These stats give information such
as number of spatial streams, bandwidth, MCS, etc.

Note: WCN7850 firmware version -
WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
does not support HTT stats type 51.

Sample output:
-------------
echo 51 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_TX_PDEV_RATE_STATS_BE_OFDMA_TLV:
mac_id = 0
be_ofdma_tx_ldpc = 0
be_ofdma_tx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
be_ofdma_eht_sig_mcs =  0:0, 1:0, 2:0, 3:0
be_ofdma_tx_ru_size =  26:0  52:0  52+26:0  106:0  106+26:0  242:0  484:0  484+242:0  996:0  996+484:0  996+484+242:0  996x2:0  996x2+484:0  996x3:0  996x3+484:0  996x4:0
be_ofdma_tx_nss =  =  1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
be_ofdma_tx_bw =  0:0, 1:0, 2:0, 3:0, 4:0
be_ofdma_tx_gi[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
be_ofdma_tx_gi[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
be_ofdma_tx_gi[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
be_ofdma_tx_gi[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 95 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 39 ++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 6d4870ab93d7..799b865b89e5 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -48,6 +48,46 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
 					footer);
 }
 
+static const char *ath12k_htt_be_tx_rx_ru_size_to_str(u8 ru_size)
+{
+	switch (ru_size) {
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_26:
+		return "26";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_52:
+		return "52";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_52_26:
+		return "52+26";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_106:
+		return "106";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_106_26:
+		return "106+26";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_242:
+		return "242";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_484:
+		return "484";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_484_242:
+		return "484+242";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996:
+		return "996";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996_484:
+		return "996+484";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996_484_242:
+		return "996+484+242";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x2:
+		return "996x2";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x2_484:
+		return "996x2+484";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x3:
+		return "996x3";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x3_484:
+		return "996x3+484";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x4:
+		return "996x4";
+	default:
+		return "unknown";
+	}
+}
+
 static void
 htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
 				struct debug_htt_stats_req *stats_req)
@@ -2612,6 +2652,58 @@ ath12k_htt_print_pdev_sched_algo_ofdma_stats_tlv(const void *tag_buf, u16 tag_le
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_tx_pdev_rate_stats_be_ofdma_tlv(const void *tag_buf, u16 tag_len,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_rate_stats_be_ofdma_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word;
+	u8 i;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id_word = le32_to_cpu(htt_stats_buf->mac_id__word);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_RATE_STATS_BE_OFDMA_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "be_ofdma_tx_ldpc = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_ofdma_tx_ldpc));
+	len += print_array_to_buf(buf, len, "be_ofdma_tx_mcs",
+				  htt_stats_buf->be_ofdma_tx_mcs,
+				  ATH12K_HTT_TX_PDEV_NUM_BE_MCS_CNTRS, "\n");
+	len += print_array_to_buf(buf, len, "be_ofdma_eht_sig_mcs",
+				  htt_stats_buf->be_ofdma_eht_sig_mcs,
+				  ATH12K_HTT_TX_PDEV_NUM_EHT_SIG_MCS_CNTRS, "\n");
+	len += scnprintf(buf + len, buf_len - len, "be_ofdma_tx_ru_size = ");
+	for (i = 0; i < ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %s:%u ",
+				 ath12k_htt_be_tx_rx_ru_size_to_str(i),
+				 le32_to_cpu(htt_stats_buf->be_ofdma_tx_ru_size[i]));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+	len += print_array_to_buf_index(buf, len, "be_ofdma_tx_nss = ", 1,
+					htt_stats_buf->be_ofdma_tx_nss,
+					ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS,
+					"\n");
+	len += print_array_to_buf(buf, len, "be_ofdma_tx_bw",
+				  htt_stats_buf->be_ofdma_tx_bw,
+				  ATH12K_HTT_TX_PDEV_NUM_BE_BW_CNTRS, "\n");
+	for (i = 0; i < ATH12K_HTT_TX_PDEV_NUM_GI_CNTRS; i++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "be_ofdma_tx_gi[%u]", i);
+		len += print_array_to_buf(buf, len, "", htt_stats_buf->gi[i],
+					  ATH12K_HTT_TX_PDEV_NUM_BE_MCS_CNTRS, "\n");
+	}
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -2791,6 +2883,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG:
 		ath12k_htt_print_pdev_sched_algo_ofdma_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_PDEV_RATE_STATS_BE_OFDMA_TAG:
+		ath12k_htt_print_tx_pdev_rate_stats_be_ofdma_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index ae738396b10a..ac86cab234ec 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -137,6 +137,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
+	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -195,6 +196,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_AX_SCHED_STATUS_STATS_TAG	= 112,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
 	HTT_STATS_TX_PDEV_MUMIMO_GRP_STATS_TAG		= 130,
+	HTT_STATS_TX_PDEV_RATE_STATS_BE_OFDMA_TAG	= 135,
 	HTT_STATS_TX_SELFGEN_BE_ERR_STATS_TAG		= 137,
 	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
 	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
@@ -1083,4 +1085,41 @@ struct ath12k_htt_pdev_sched_algo_ofdma_stats_tlv {
 	__le32 dlofdma_disabled_consec_no_mpdus_success[ATH12K_HTT_NUM_AC_WMM];
 } __packed;
 
+enum ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE {
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_26,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_52,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_52_26,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_106,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_106_26,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_242,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_484,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_484_242,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996_484,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996_484_242,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x2,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x2_484,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x3,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x3_484,
+	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_996x4,
+	ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS,
+};
+
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS	8
+#define ATH12K_HTT_TX_PDEV_NUM_BE_MCS_CNTRS		16
+#define ATH12K_HTT_TX_PDEV_NUM_BE_BW_CNTRS		5
+#define ATH12K_HTT_TX_PDEV_NUM_EHT_SIG_MCS_CNTRS	4
+#define ATH12K_HTT_TX_PDEV_NUM_GI_CNTRS			4
+
+struct ath12k_htt_tx_pdev_rate_stats_be_ofdma_tlv {
+	__le32 mac_id__word;
+	__le32 be_ofdma_tx_ldpc;
+	__le32 be_ofdma_tx_mcs[ATH12K_HTT_TX_PDEV_NUM_BE_MCS_CNTRS];
+	__le32 be_ofdma_tx_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 be_ofdma_tx_bw[ATH12K_HTT_TX_PDEV_NUM_BE_BW_CNTRS];
+	__le32 gi[ATH12K_HTT_TX_PDEV_NUM_GI_CNTRS][ATH12K_HTT_TX_PDEV_NUM_BE_MCS_CNTRS];
+	__le32 be_ofdma_tx_ru_size[ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS];
+	__le32 be_ofdma_eht_sig_mcs[ATH12K_HTT_TX_PDEV_NUM_EHT_SIG_MCS_CNTRS];
+} __packed;
+
 #endif
-- 
2.25.1


