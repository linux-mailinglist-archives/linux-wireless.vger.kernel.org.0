Return-Path: <linux-wireless+bounces-15476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F399D1C91
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 01:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9176D1F2228C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 00:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6B28E3F;
	Tue, 19 Nov 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RroL0c5N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD020328
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976393; cv=none; b=W0jLjOD1zpv7fBVsVQrlM3Ll28ThkRfa24wlRUYW14eYPDi3HqSyRJA/iFR3HeCk2395xLxBKrVVNDGmqKFHqeMjGPdl5TG12Rvox5CC8E0PKaBaQDhQBl/vwuAwHk2ygtRnZwtHvsKw8Ir5yoQ10E4OUbwWPtEzSmchyNKsTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976393; c=relaxed/simple;
	bh=vXAU66yWrTVm+TYqITASSvp/A75LjJHSE0OLg/jwwg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZBdFOyTidZPmQY5XxugAaWtGn4fl54nlCm7HCa/YX4xwekXicOO6Bmg0IW2dcbdrNRTeu5tYFlNjRculrbmxtNo8e31sAUK5SHzI8S5uRRqhJUdqxVTgH+fi7/R218LjT6TfVUjCCCqldKAv0N/bnxupB67G5YrU9cU69PVng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RroL0c5N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGxsi028395;
	Tue, 19 Nov 2024 00:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SIV0CRPsH/E4MmbgeAgxaC+Dg7S8b/Rck8Lmt/YsE1I=; b=RroL0c5NmDbvi/mc
	Xwk6DAMJRl1mZq+yvzZqOxQOwZ4a/67qaShvYSM2WzJOIIIS5vf1kZc8XIeaI8A1
	FsdHpAXjfiBlBUk1CFNu6K5of8CRCq2KW56tjjwNV15Rsy4ctPK4VLvH7UwevgGJ
	bhYXyhQtLrKFZmZD3nFzHa9Z7wthVslwFIiPSIjTrze1ugmNnqYnLEtP5IkjULeC
	GuRS9yyN3Qp21pbkyWvctLLzItpKiGukQkYei0f+kbPoiy+u3yu3JHXNzQgLlGmv
	HZbr/jUYJPs3TYfFlIpI0a6gGi1qo5NyyTF3lrJEMPa4Kiv4iu3c2A+JFcxOiSnH
	RHdn+Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y6rxxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ0X8bV022820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:08 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 16:33:06 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/8] wifi: ath12k: Refactor monitor status TLV structure
Date: Tue, 19 Nov 2024 06:02:42 +0530
Message-ID: <20241119003248.1579567-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GngSjGXfs_gLNITtEP9qXWRsWohJtHxg
X-Proofpoint-GUID: GngSjGXfs_gLNITtEP9qXWRsWohJtHxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190003

The following TLV structures and bitmask definitions were inherited from
the ath11k but were not updated for the ath12k 802.11be hardware. These
data structure and bitmask will be used to parse the monitor status
TLV data in the Rx path.

1. hal_rx_ppdu_end_user_stats_ext structure
2. hal_rx_ppdu_end_duration structure
3. HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF bitmask
4. HAL_RX_MPDU_START_INFO1_PEERID bitmask
5. HAL_INVALID_PEERID
6. hal_rx_ppdu_end_user_stats bitmask

Currently, there is no issue since the monitor status Rx path is not
enabled. However, in the future, the monitor status Rx path will be
enabled. Therefore, update the above TLV structures and bitmask to align
with the ath12k 802.11be hardware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal_rx.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 2de7b0eba9f2..5cf3c5787ab7 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -19,7 +19,7 @@ struct hal_rx_wbm_rel_info {
 	bool hw_cc_done;
 };
 
-#define HAL_INVALID_PEERID 0xffff
+#define HAL_INVALID_PEERID	0x3fff
 #define VHT_SIG_SU_NSS_MASK 0x7
 
 #define HAL_RX_MAX_MCS 12
@@ -245,6 +245,8 @@ struct hal_rx_ppdu_start {
 	__le32 rsvd[2];
 } __packed;
 
+#define HAL_RX_PPDU_END_USER_STATS_INFO0_PEER_ID		GENMASK(13, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO0_DEVICE_ID		GENMASK(15, 14)
 #define HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR	GENMASK(26, 16)
 
 #define HAL_RX_PPDU_END_USER_STATS_INFO1_MPDU_CNT_FCS_OK	GENMASK(10, 0)
@@ -299,6 +301,7 @@ struct hal_rx_ppdu_end_user_stats_ext {
 	__le32 info4;
 	__le32 info5;
 	__le32 info6;
+	__le32 rsvd;
 } __packed;
 
 #define HAL_RX_HT_SIG_INFO_INFO0_MCS		GENMASK(6, 0)
@@ -425,7 +428,7 @@ struct hal_rx_he_sig_b2_mu_info {
 
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_ID	GENMASK(10, 0)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS	GENMASK(13, 11)
-#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF	BIT(19)
+#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF	BIT(14)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_MCS	GENMASK(18, 15)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_DCM	BIT(19)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_CODING	BIT(20)
@@ -453,7 +456,8 @@ struct hal_rx_phyrx_rssi_legacy_info {
 } __packed;
 
 #define HAL_RX_MPDU_START_INFO0_PPDU_ID			GENMASK(31, 16)
-#define HAL_RX_MPDU_START_INFO1_PEERID			GENMASK(31, 16)
+#define HAL_RX_MPDU_START_INFO1_PEERID			GENMASK(29, 16)
+#define HAL_RX_MPDU_START_INFO1_DEVICE_ID		GENMASK(31, 30)
 #define HAL_RX_MPDU_START_INFO2_MPDU_LEN		GENMASK(13, 0)
 struct hal_rx_mpdu_start {
 	__le32 rsvd0[9];
@@ -468,7 +472,7 @@ struct hal_rx_mpdu_start {
 struct hal_rx_ppdu_end_duration {
 	__le32 rsvd0[9];
 	__le32 info0;
-	__le32 rsvd1[4];
+	__le32 rsvd1[18];
 } __packed;
 
 struct hal_rx_rxpcu_classification_overview {
-- 
2.34.1


