Return-Path: <linux-wireless+bounces-14124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450419A192D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 05:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D2B1C20A24
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 03:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063E242040;
	Thu, 17 Oct 2024 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g8zkiCFP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C461369B6
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134699; cv=none; b=KTuDwO4kDFxgfLhsR8RHYaH5TxqZRyRbh3kfWk6E3wB4uFOOr1xLNM3QO61Tuc+h4H/bwY/F4O4rwwTSyj9u7uycsRQPCDyqlBtYPuNIHnxDakKCihYk4igJXRqZofSfsARQdfHq9mtUthQrbAiD2HIfrxHeN4j2pxOURTY5V4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134699; c=relaxed/simple;
	bh=cEGioahY18EnS5cuBujQ3ugzimiD1Ne8Gkgg7tmhxx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEv1Kly7CVrkIgE1esnzUe/SVMrec6cquW1FQtJCF+xJLuqr+I4jIF1lMrQ50mCLS4PwCMK0FvAjXOfxH4ZUSNMQagHrGhWKHwigMirV7wOIqfuilUEnzzv4LsK0R/zFht0Va+eEFnMn+NzBMX1TdUE6zH8deIXuZzZQlf5oiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g8zkiCFP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H0N3XE010214;
	Thu, 17 Oct 2024 03:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+bg4DQm+o1iu3+6gh9EP74GfIJYafrQpfWXfGTw9kWc=; b=g8zkiCFPXTrrTU46
	zRIzKKsblBRZUdiZfTKvszAzVex4nVcpP9MbVPwYsaVtuxikfADsWC3BL+1Ja7eH
	pafMl+3iRMBQtdILMSc4aregPAKg2uQ60ez4AFKRiGgNXdZSQQWwxN5rVw0r7nhY
	qB+bztjMwUuHsqCkNRXHe6UvZtK5UwBfji0aJZ4thELYpa0B+hFOrb0JW1cQkG9O
	a0m99H+mzj8+2D/Q3jZZeHBa8rIecQtqH/LaCxXy9qbqE+7IEti+3Yie5Mvl/QOU
	uJXOuo5uw5K9Tc9R5MvP08ZDogrLiGDNhXXQ/7G3c3XuNWpWbWoeZSl/uMIAxN7Y
	tBwiQg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ar050bnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:11:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H3BT5x030626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:11:29 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 20:11:27 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 04/11] wifi: ath12k: fix struct hal_rx_ppdu_start
Date: Thu, 17 Oct 2024 11:10:49 +0800
Message-ID: <20241017031056.1714-5-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241017031056.1714-1-quic_kangyang@quicinc.com>
References: <20241017031056.1714-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: av_JuG7__kkrl1v7Um2ezJE0lxiLylCq
X-Proofpoint-ORIG-GUID: av_JuG7__kkrl1v7Um2ezJE0lxiLylCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=543
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 adultscore=1
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170022

Current struct hal_rx_ppdu_start in hal_rx.h is not matched with
hardware descriptor definition.

So update this structure and related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 16 ++++++++++++----
 drivers/net/wireless/ath/ath12k/hal_rx.h | 11 ++++++++---
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 8aef25c0d98b..86796efe5acd 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -593,12 +593,20 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		struct hal_rx_ppdu_start *ppdu_start =
 			(struct hal_rx_ppdu_start *)tlv_data;
 
+		u64 ppdu_ts = __le32_to_cpu(ppdu_start->ppdu_start_ts_31_0) |
+			(u64)(__le32_to_cpu(ppdu_start->ppdu_start_ts_63_32)) << 32;
+
 		info[0] = __le32_to_cpu(ppdu_start->info0);
 
-		ppdu_info->ppdu_id =
-			u32_get_bits(info[0], HAL_RX_PPDU_START_INFO0_PPDU_ID);
-		ppdu_info->chan_num = __le32_to_cpu(ppdu_start->chan_num);
-		ppdu_info->ppdu_ts = __le32_to_cpu(ppdu_start->ppdu_start_ts);
+		ppdu_info->ppdu_id = u32_get_bits(info[0],
+						  HAL_RX_PPDU_START_INFO0_PPDU_ID);
+
+		info[1] = __le32_to_cpu(ppdu_start->info1);
+		ppdu_info->chan_num = u32_get_bits(info[1],
+						   HAL_RX_PPDU_START_INFO1_CHAN_NUM);
+		ppdu_info->freq = u32_get_bits(info[1],
+					       HAL_RX_PPDU_START_INFO1_CHAN_FREQ);
+		ppdu_info->ppdu_ts = ppdu_ts;
 
 		if (ppdu_info->ppdu_id != ppdu_info->last_ppdu_id) {
 			ppdu_info->last_ppdu_id = ppdu_info->ppdu_id;
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 837ba4adba88..6ab33d5f1b2a 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -156,6 +156,7 @@ struct hal_rx_mon_ppdu_info {
 	u32 preamble_type;
 	u32 mpdu_len;
 	u16 chan_num;
+	u16 freq;
 	u16 tcp_msdu_count;
 	u16 tcp_ack_msdu_count;
 	u16 udp_msdu_count;
@@ -232,12 +233,16 @@ struct hal_rx_mon_ppdu_info {
 	u8 medium_prot_type;
 };
 
-#define HAL_RX_PPDU_START_INFO0_PPDU_ID		GENMASK(15, 0)
+#define HAL_RX_PPDU_START_INFO0_PPDU_ID			GENMASK(15, 0)
+#define HAL_RX_PPDU_START_INFO1_CHAN_NUM		GENMASK(15, 0)
+#define HAL_RX_PPDU_START_INFO1_CHAN_FREQ		GENMASK(31, 16)
 
 struct hal_rx_ppdu_start {
 	__le32 info0;
-	__le32 chan_num;
-	__le32 ppdu_start_ts;
+	__le32 info1;
+	__le32 ppdu_start_ts_31_0;
+	__le32 ppdu_start_ts_63_32;
+	__le32 rsvd[2];
 } __packed;
 
 #define HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR	GENMASK(26, 16)
-- 
2.34.1


