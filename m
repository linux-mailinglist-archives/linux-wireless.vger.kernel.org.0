Return-Path: <linux-wireless+bounces-14950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647A99BDE0A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 05:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD8E283A1E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 04:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3618F2DD;
	Wed,  6 Nov 2024 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oQEySnmI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7222C13541B
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 04:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868378; cv=none; b=eGRTXTZ95AuGr/cmWaIbrzORE+6jefsnpteKgPCUlLS945JiGoVVl7w0pilDSbX/whTrMARaCiRN4D8jiKuBeLOSwuo8UAWDm8j8CGKnoA2zGdjXh4wcr+tL3l3dCyM0tTE/atFqiTojURifVKCJ4+OlN5gilmUaZk1m660aWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868378; c=relaxed/simple;
	bh=EUPGibQbO+z3SqdvXIBj3uQybIKKiPiXeKcOcd0/goE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed4pXm6w16diHdhlC3Q+udC67Zb0vTMuGDyhMU6llUcLWDC7gYEVwyf1prpUmC5P9VALsHTo8CX1h3sjiOz1N2Aads3vgFHawsUuevL3SVsPPiEsovphp7E36NJQj1WuDOyhBxoXphdggmAtcPq7wIY1359A8ICOOL68MCjhLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oQEySnmI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5FUppH013171;
	Wed, 6 Nov 2024 04:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cUb0NIUX47BaZIdYjGxQSjgqjB4SMmNsp+wTOpY6tKk=; b=oQEySnmIcm6LqcmE
	3WrGph07roWzQLszYS7ZPcGIXGqFj1mT8UacrzR4bZ0VhraCK9E9c3UKz+2mtss7
	w6o8e6FRyrl7QJvLIGdJnSrKHywDPF3a+NQev2jXYv9u5NDj7ofv+eorhCFMS71u
	QPx+Lxjj78jwUhXOT+IpRBY7GW0l3s03kapkUHqRHUSVRBFFdMRWJNVYQmziQldS
	476FdUtWfN7BQaUdHy5zpi/e8x12F1gtJNSj/TEdF2cSeqSVlOGwKHfaoa3XDOaX
	J4LJNLuzU596mNF5zOYkdgfOVvll2rRVfEHfShNbhQ4itZolTLtVBj8v3uIu/jDF
	xnd24w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qp2rsre2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 04:46:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A64kBlE031539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 04:46:11 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 5 Nov 2024 20:46:09 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v4 3/4] wifi: ath12k: Support SoC Common Stats
Date: Wed, 6 Nov 2024 10:15:47 +0530
Message-ID: <20241106044548.3530128-4-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
References: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: zyK8gfRmAZx-9_zdLn54CjAl4YWNr1OV
X-Proofpoint-ORIG-GUID: zyK8gfRmAZx-9_zdLn54CjAl4YWNr1OV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060035

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request SoC stat from firmware through HTT stat
type 38. This stat gives drop count of SoC.

Note: MCC firmware version -
WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
support tag HTT_STATS_SOC_TXRX_STATS_COMMON_TAG(125).

Sample output:
-------------
echo 38 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_SOC_COMMON_STATS_TLV:
soc_drop_count = 0x0000000000000000

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 26 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  7 +++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 912fef503982..7dabf388267c 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2859,6 +2859,29 @@ ath12k_htt_print_phy_tpc_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_soc_txrx_stats_common_tlv(const void *tag_buf, u16 tag_len,
+					   struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_t2h_soc_txrx_stats_common_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u64 drop_count;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	drop_count = ath12k_le32hilo_to_u64(htt_stats_buf->inv_peers_msdu_drop_count_hi,
+					    htt_stats_buf->inv_peers_msdu_drop_count_lo);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_SOC_COMMON_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "soc_drop_count = %llu\n\n",
+			 drop_count);
+
+	stats_req->buf_len = len;
+}
+
 static void
 ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
 				      struct debug_htt_stats_req *stats_req)
@@ -3204,6 +3227,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PHY_TPC_STATS_TAG:
 		ath12k_htt_print_phy_tpc_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_SOC_TXRX_STATS_COMMON_TAG:
+		ath12k_htt_print_soc_txrx_stats_common_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_DMAC_RESET_STATS_TAG:
 		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 10d7ca9c02f4..c07b60636c22 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -137,6 +137,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
 	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	= 37,
+	ATH12K_DBG_HTT_EXT_VDEVS_TXRX_STATS		= 38,
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
 	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
@@ -201,6 +202,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_PHY_STATS_TAG				= 122,
 	HTT_STATS_PHY_RESET_COUNTERS_TAG		= 123,
 	HTT_STATS_PHY_RESET_STATS_TAG			= 124,
+	HTT_STATS_SOC_TXRX_STATS_COMMON_TAG		= 125,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
 	HTT_STATS_TX_PDEV_MUMIMO_GRP_STATS_TAG		= 130,
 	HTT_STATS_TX_PDEV_RATE_STATS_BE_OFDMA_TAG	= 135,
@@ -1183,6 +1185,11 @@ struct ath12k_htt_phy_tpc_stats_tlv {
 	__le32 sub_band_txpower[ATH12K_HTT_MAX_CH_PWR_INFO_SIZE];
 } __packed;
 
+struct ath12k_htt_t2h_soc_txrx_stats_common_tlv {
+	__le32 inv_peers_msdu_drop_count_hi;
+	__le32 inv_peers_msdu_drop_count_lo;
+} __packed;
+
 struct ath12k_htt_dmac_reset_stats_tlv {
 	__le32 reset_count;
 	__le32 reset_time_lo_ms;
-- 
2.25.1


