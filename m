Return-Path: <linux-wireless+bounces-14187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA79A3473
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 07:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCDC2851A2
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 05:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CD017DFE8;
	Fri, 18 Oct 2024 05:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qq74tPac"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72717B50A
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230417; cv=none; b=tEy7Udwrzec8ZabxMiXKo9ZPBUKjxgS69waxFWX2801Yio3DX4rGqSWHV2BdR+cd0NxVe6qfQu9N9EKJuzDmTsbUuUU/2hr3Nfl/vilm+WJ2U1iPK3Ly+QuMLQawvr1n7iBlMsw2Goj+L/2sE1lecwSYq11gpU5qYsEj3MUVW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230417; c=relaxed/simple;
	bh=uz74VTpHEFmnkpY8l6yjOY26MylYcFGzA0qy8tI4djc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0jTyMwQTmJbzwFq1PaqM3l7bJnov4rPDQiOHIqktxpGqHhpWcNc1HHS5LIttoCKxdFCj+bduR1kocdzdy5IfTp9cEVuRAI6/S8UeD9ijucNNmAsMkSVTFi6gc9bw8l+0q16uKNqKUy8HL7uc+k+KPzoCi8WK0VO3tFnV0khmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qq74tPac; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJjLvT027138;
	Fri, 18 Oct 2024 05:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJEn4r5GPs/o23DpmP8yG0gTbw4JKLdP7cf2Ql1BpkU=; b=Qq74tPacFEEHhSrr
	HkgeFA2BCcgK9y4KJdN+GDjJMsLFHuqKmSotjx0+ubKLM9jlq7uhNy5Z0GjDUymX
	MnyXCQHvOcpGmnagRha1RfW/cnf6+s+aK9/xUHplOv+YhtDa0RGgDMx58IYdt7n6
	3u3PgkITuHOjKgdhZOOmPiOVoNBazDaQQWTRxXVJMdVgdOmNXIqy+/3BB5ygsmVz
	xEPk63S9O8aK/9hygw8f6a2IJr6/v7bvsjaZTW3U/CW/HhK1ceibGbJyPmZquLGz
	juYMjWve6n5MTkOTmvHqHPYmcJSvZ5aOkxMjJobHwV+fLeUKK0vk6iRfhztYbKxx
	Q5fLHA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ay8jb1sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 05:46:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49I5kntS002119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 05:46:49 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Oct 2024 22:46:47 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 5/8] wifi: ath12k: fix struct hal_rx_mpdu_start
Date: Fri, 18 Oct 2024 13:46:17 +0800
Message-ID: <20241018054620.2080-6-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241018054620.2080-1-quic_kangyang@quicinc.com>
References: <20241018054620.2080-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: EnSaKQB5RJSRcc3E9Z1Htx-4YZB7OhJw
X-Proofpoint-ORIG-GUID: EnSaKQB5RJSRcc3E9Z1Htx-4YZB7OhJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=636 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180033

Current struct hal_rx_mpdu_start in hal_rx.h is not matched with
hardware descriptor definition.

So update this structure and related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal_rx.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index c69df852ae69..2de7b0eba9f2 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -452,15 +452,16 @@ struct hal_rx_phyrx_rssi_legacy_info {
 	__le32 rsvd1;
 } __packed;
 
-#define HAL_RX_MPDU_START_INFO0_PPDU_ID	GENMASK(31, 16)
-#define HAL_RX_MPDU_START_INFO1_PEERID	GENMASK(31, 16)
-#define HAL_RX_MPDU_START_INFO2_MPDU_LEN GENMASK(13, 0)
+#define HAL_RX_MPDU_START_INFO0_PPDU_ID			GENMASK(31, 16)
+#define HAL_RX_MPDU_START_INFO1_PEERID			GENMASK(31, 16)
+#define HAL_RX_MPDU_START_INFO2_MPDU_LEN		GENMASK(13, 0)
 struct hal_rx_mpdu_start {
+	__le32 rsvd0[9];
 	__le32 info0;
 	__le32 info1;
-	__le32 rsvd1[11];
+	__le32 rsvd1[2];
 	__le32 info2;
-	__le32 rsvd2[9];
+	__le32 rsvd2[16];
 } __packed;
 
 #define HAL_RX_PPDU_END_DURATION	GENMASK(23, 0)
-- 
2.34.1


