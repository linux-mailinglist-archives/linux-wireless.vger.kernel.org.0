Return-Path: <linux-wireless+bounces-10506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70593C156
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 14:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEFAB21F83
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFD71993A5;
	Thu, 25 Jul 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BV/Cnhaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036913BC11
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908872; cv=none; b=dcMw+MYOOukd8EO6PMPYJ2ofols7eOGHyYXmdf4p4hknzgxilWwjMXlNHdiMlVTeaPWhXU+E+x0Bi8zmx9W6Cn4FHgCZYJgofH9KQoTIC031CM6+huSrjdkw9Hiifv+hGp4BbSF3qqxOa7heUJB8kOZeQwH3HUxLVwxPsjzbDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908872; c=relaxed/simple;
	bh=YkHtGiPDhYcWB+UcpQVGK+fpW6gw93G5x7GwpUq/5hQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uc3OAOms0U4gIt1fdQ7IZG47ITxUE1mtdljM2oyOpDJK5WdX9scnOwCSpyYND60u7KcfrUenOc/Djnyzk1z0KKFCZ0DhH6SP+E5BVbG5U/MCsiREeiEqTqcm8704FHUyxKJZwtrihFgxoy0sOUh362CCV2ijHLNOigP5/WLglqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BV/Cnhaj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P96G47014508;
	Thu, 25 Jul 2024 12:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UQ9V0XQ4cYFE+KNXsC500ZCFyDanBpzIxtT2+f+ZqrU=; b=BV/CnhajE8Ral934
	kheGNUQunzujs0HSaHWTRrCCdp2WgvX/FfanaAzf5PFJ7Zuew3MuIZQcpXwni+Io
	pfHt3gIG9QaOJQG7WMa5LVHf7O0PS6o3qTEbNyBSc3oj62vFMMZXWfTiCLJdLUNw
	0KS9M2mOnfNSPKmMmFdxfb7Uv9YmdWHV/yYMOTJfvEbsLGcS9iok/SzW0WJbXmo4
	9suRUZIqnkezanGYwullK2/hnt1zP8RJnj0jsdZ5eZNuWXnBrrAg5YPEArelEvEZ
	SyQ+YZ0hqYVgNLz9tdpKABKwm08nk4WgrP8tLFoHrzpvLvKL0LVFgQrJhPOOnled
	OkHSTA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40gurtuqyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PC1497005148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:04 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 05:01:02 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 03/11] wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
Date: Thu, 25 Jul 2024 20:00:27 +0800
Message-ID: <20240725120035.493-4-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240725120035.493-1-quic_kangyang@quicinc.com>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: AyFoMDIujtuX3oumPIND_hiFom-DCpVt
X-Proofpoint-ORIG-GUID: AyFoMDIujtuX3oumPIND_hiFom-DCpVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=887
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250082

From: Kang Yang <quic_kangyang@quicinc.com>

Current struct hal_rx_ppdu_end_user_stats in hal_rx.h is not matched
with hardware descriptor definition.

So update this structure and related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 11 ++++-------
 drivers/net/wireless/ath/ath12k/hal_rx.h | 22 +++++++++++-----------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 5c6749bc4039..516089bd3562 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -26,15 +26,12 @@ ath12k_dp_mon_rx_populate_byte_count(const struct hal_rx_ppdu_end_user_stats *st
 				     void *ppduinfo,
 				     struct hal_rx_user_status *rx_user_status)
 {
-	u32 mpdu_ok_byte_count = __le32_to_cpu(stats->mpdu_ok_cnt);
-	u32 mpdu_err_byte_count = __le32_to_cpu(stats->mpdu_err_cnt);
-
 	rx_user_status->mpdu_ok_byte_count =
-		u32_get_bits(mpdu_ok_byte_count,
-			     HAL_RX_PPDU_END_USER_STATS_MPDU_DELIM_OK_BYTE_COUNT);
+		le32_get_bits(stats->info7,
+			      HAL_RX_PPDU_END_USER_STATS_INFO7_MPDU_OK_BYTE_COUNT);
 	rx_user_status->mpdu_err_byte_count =
-		u32_get_bits(mpdu_err_byte_count,
-			     HAL_RX_PPDU_END_USER_STATS_MPDU_DELIM_ERR_BYTE_COUNT);
+		le32_get_bits(stats->info8,
+			      HAL_RX_PPDU_END_USER_STATS_INFO8_MPDU_ERR_BYTE_COUNT);
 }
 
 static void
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 095216eabc01..837ba4adba88 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HAL_RX_H
@@ -240,13 +240,13 @@ struct hal_rx_ppdu_start {
 	__le32 ppdu_start_ts;
 } __packed;
 
-#define HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR	GENMASK(25, 16)
+#define HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR	GENMASK(26, 16)
 
-#define HAL_RX_PPDU_END_USER_STATS_INFO1_MPDU_CNT_FCS_OK	GENMASK(8, 0)
-#define HAL_RX_PPDU_END_USER_STATS_INFO1_FC_VALID		BIT(9)
-#define HAL_RX_PPDU_END_USER_STATS_INFO1_QOS_CTRL_VALID		BIT(10)
-#define HAL_RX_PPDU_END_USER_STATS_INFO1_HT_CTRL_VALID		BIT(11)
-#define HAL_RX_PPDU_END_USER_STATS_INFO1_PKT_TYPE		GENMASK(23, 20)
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_MPDU_CNT_FCS_OK	GENMASK(10, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_FC_VALID		BIT(11)
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_QOS_CTRL_VALID		BIT(12)
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_HT_CTRL_VALID		BIT(13)
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_PKT_TYPE              GENMASK(24, 21)
 
 #define HAL_RX_PPDU_END_USER_STATS_INFO2_AST_INDEX		GENMASK(15, 0)
 #define HAL_RX_PPDU_END_USER_STATS_INFO2_FRAME_CTRL		GENMASK(31, 16)
@@ -262,8 +262,8 @@ struct hal_rx_ppdu_start {
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP		GENMASK(15, 0)
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_EOSP_BITMAP	GENMASK(31, 16)
 
-#define HAL_RX_PPDU_END_USER_STATS_MPDU_DELIM_OK_BYTE_COUNT	GENMASK(24, 0)
-#define HAL_RX_PPDU_END_USER_STATS_MPDU_DELIM_ERR_BYTE_COUNT	GENMASK(24, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO7_MPDU_OK_BYTE_COUNT    GENMASK(24, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO8_MPDU_ERR_BYTE_COUNT   GENMASK(24, 0)
 
 struct hal_rx_ppdu_end_user_stats {
 	__le32 rsvd0[2];
@@ -278,9 +278,9 @@ struct hal_rx_ppdu_end_user_stats {
 	__le32 usr_resp_ref;
 	__le32 info6;
 	__le32 rsvd3[4];
-	__le32 mpdu_ok_cnt;
+	__le32 info7;
 	__le32 rsvd4;
-	__le32 mpdu_err_cnt;
+	__le32 info8;
 	__le32 rsvd5[2];
 	__le32 usr_resp_ref_ext;
 	__le32 rsvd6;
-- 
2.34.1


