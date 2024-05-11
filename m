Return-Path: <linux-wireless+bounces-7495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503C8C2E76
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 03:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF04B2204F
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA31095B;
	Sat, 11 May 2024 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DmT+TjbB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA4D2F0
	for <linux-wireless@vger.kernel.org>; Sat, 11 May 2024 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391427; cv=none; b=BBhchucHayibs2udhNvunlbowS7aOHXQ5XhDKywzQBdvQ0wTHsOuPHbRfFsnRpRjP9Albj9gO76KCzlLE4eAvEQvMOEEbwLiApA+o6fMMJDxEfhYDWbUcB1gnwclqMPNmjwZbtT3D6JzryaaK8+W3opi2vAwvE20608JNecFf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391427; c=relaxed/simple;
	bh=IkzAdKtNdgxqU8dpluiukA0kUKubyz7gZ9U+5q+ZLUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsaIu5LHNLUoLbPIto/AIjGtArnl0maOS4VeuByTTsKMOPm9mG9uQlShjqcZm1dBtmAj63aL51QAS9UADNNqlFppRGvpRIAYiyW2Jg5R5inyhcJHCwukjbFvy1To78/Q7lIXBuX86bZ1R4F2ZmtMYrm7gou8ontHRYZLS3m/448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DmT+TjbB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AEEWP1028446;
	Sat, 11 May 2024 01:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tpyLqTpPlHfvZEwBRs8+SAav5nklc3P+DJ1j4q3G2JU=; b=Dm
	T+TjbB1kALgK4lVyQPxsikRIVQIB5ZtF3o8B0aSGyEI2fPs9q6F+KNXS5S3Y0NMB
	YwzpOAt0iNQ5Xg2Yg+1vB4IHOSha3aIqnTITNvNEmFseM0sNvfeAzxbGF+SFYWEK
	sH9QcKGIxNmGuvUuIjIa9L9g1PMBIjckyfA+6fS1jyI4MJsvJNpkI405iF5Frs7I
	D3i4yT5CoRaUIvEpOLN6T0B9teT5CQltzE7FJCEpK0IkGvFurr45+KFGpQXw0VpL
	1RiJ5LFOb5z2bfyjJWGDqlTVNuqBy+t5R8hoHAp/W54tQxd+dLhEci/3Qe4PQtID
	CXkbL91iciegYwCWul8Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w0tuyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 01:37:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44B1b1L6032583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 01:37:01 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 10 May 2024 18:36:59 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: remove duplicate definition of MAX_RADIOS
Date: Sat, 11 May 2024 07:06:43 +0530
Message-ID: <20240511013644.3103905-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511013644.3103905-1-quic_periyasa@quicinc.com>
References: <20240511013644.3103905-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FyAbmyUdXfAvJG0_aCG-q3iGbwx708Fa
X-Proofpoint-ORIG-GUID: FyAbmyUdXfAvJG0_aCG-q3iGbwx708Fa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_18,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=856 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405110010

Remove the duplicate definition of MAX_RADIOS from the core header file.

No functional changes, compile tested only.

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index bb6c1b562baf..345d47fe63ff 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -180,8 +180,6 @@ struct ath12k_he {
 	u32 heop_param;
 };
 
-#define MAX_RADIOS 3
-
 enum {
 	WMI_HOST_TP_SCALE_MAX   = 0,
 	WMI_HOST_TP_SCALE_50    = 1,
-- 
2.34.1


