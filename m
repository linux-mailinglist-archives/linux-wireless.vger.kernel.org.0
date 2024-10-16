Return-Path: <linux-wireless+bounces-14048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4609A01E4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1300E1F25FFD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98741C07E2;
	Wed, 16 Oct 2024 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a/QQas+n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE91B3923
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061858; cv=none; b=IA2Q9IqauyG/bIge91ytloksuNn2rsV/bP8WQBwLQg+L7+wnTQ7wUFhzVpfVjXQ9MForoBUX717Z/B1mfcWk9/qhIWJFQCnHziY5q2c8GTyjFqvuBe0waCwsNGW0k+5agy0GtZN4M/HWu6rCPU/bIN6BlrEQ2DXUBSdvmIbA4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061858; c=relaxed/simple;
	bh=uz74VTpHEFmnkpY8l6yjOY26MylYcFGzA0qy8tI4djc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScWZm/jTxOXmNw0K/PCNuKrM/yWPCcu+wXgpfQFg4XjZka8RLw9jgnFp3wAOPZpCrezZmP/pYlWnoCbggN7mFFOmFkqBcfV1IC/auqiW+LF7kblYW4qe25zXSqEXI/TLv4KncrQww5oMmnNdLGhKHhYgyPspNy3w4ANJfb53Wp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a/QQas+n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G6Xr46003782;
	Wed, 16 Oct 2024 06:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJEn4r5GPs/o23DpmP8yG0gTbw4JKLdP7cf2Ql1BpkU=; b=a/QQas+nLRSlnO4P
	uL09ujBHRpHOJm0UKkpZRQPRNSReW+DbT16NPUThjows3CAe/QUlOLGNn7lBsfaG
	8XhBMQIqwdjNVifsI08ntRyC/vKkj7h2Lf+VlkF6Wyuy7cXxr4SZBsmayXxZfs4E
	2n7T7UGlHJHfz/gdn4AUom6IuCniHFPVmMkDECy2LFZ1wb3vuddFpqWJVqvEh6OG
	Lmx72+R24mTyH8qRe+5G4283y9zOIYoQMJLuuD++g7plMnjAXziirmazo9D+hEh1
	Svu84kyXqv272gYlhvv3rSvaNtlepTpDY7S3mIiMMDOqK6g1qXpWCHytT6F61L46
	Io5QGA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429xdb9mrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6vYrG006912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:34 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:57:32 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 06/11] wifi: ath12k: fix struct hal_rx_mpdu_start
Date: Wed, 16 Oct 2024 14:56:55 +0800
Message-ID: <20241016065700.1090-7-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241016065700.1090-1-quic_kangyang@quicinc.com>
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VXSsoEQ6p9NusWAo12cPDyJbW5G5KnWy
X-Proofpoint-GUID: VXSsoEQ6p9NusWAo12cPDyJbW5G5KnWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=643 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160044

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


