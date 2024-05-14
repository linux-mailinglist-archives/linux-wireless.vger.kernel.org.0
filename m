Return-Path: <linux-wireless+bounces-7629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C6C8C4C5A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 08:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2421E281288
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 06:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37556193;
	Tue, 14 May 2024 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h2eOcNEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C561097B
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668485; cv=none; b=NTNQAkQrvbA+zIZDbB1lo67wiy+RLtq6lHXDcH4j8DdTbyhWM/iw5h+4jcIurbD1jvx4EKkZ3HSWDzrqnkp5IvqqaSWm7urjxZ/y7Q9/ikvKaCQlDrBECY8WBKUzT3v/mRKOgoLf2eFxMhx6PGf4geAzijNWZJm+ybAYvrGzDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668485; c=relaxed/simple;
	bh=1NGi9fU2RnPchb8JsyqUHeN+z/iWFvE5RnbDjzVnfGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsREMuq9Sp1xV8uaUg2VkkY3pfCuuqO+Ke5A161xr9IJecujZ5BqKMmb8lGDLcPKLy0Cj2pP0vTc0zcWIiOhN5kkH40IUF8jnz+cj8h10/Xk/P3nLEOXXhJ5Mnd46Xt75A1lLORAPBZWM1WEaIB4+4DyFksTPtxH2rFWnaFL4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h2eOcNEH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8sEh024231;
	Tue, 14 May 2024 06:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=dVpNVjXqpwn0X2HzK171L0SVxNtg5Qd71JWHZCkbs6A=; b=h2
	eOcNEHibM5y2/19/OVAULRHMhoN/b8z1k5LJ+N9BJzkeR8xqrvx1APjM40gKQ/rn
	Qd1yax2JCvCFiToSv2UB5vwvJDHli81SA2we7FyS23V2ZgXMlZUstLc1l/5tx54w
	HTSJWsMS9v5uh1EMfzFnJebo1ZzH9cxYxCUdo+QWXIQiBZ8qAbZy026N/KC3bxuS
	dQpTXSh72Sa9VzeDcOw24GxIsi5dlXLLIyQwYPu+J19p6h7Anz/w35GOShZZ1AAn
	aVut7giI+Mtc2+oemYndY4s79wmwW3iOl0vMEVzrlSMW0dwACuUiKneXaEa4auN1
	j+Buui8jMox1i59USe5g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1ymq5hd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 06:34:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44E6YbA5004395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 06:34:37 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 13 May 2024 23:34:35 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 1/2] wifi: ath12k: remove duplicate definition of MAX_RADIOS
Date: Tue, 14 May 2024 12:04:11 +0530
Message-ID: <20240514063412.3483723-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514063412.3483723-1-quic_periyasa@quicinc.com>
References: <20240514063412.3483723-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: ofWoWTgZhBWNpVusjs7V0AAiTsnoY0GT
X-Proofpoint-ORIG-GUID: ofWoWTgZhBWNpVusjs7V0AAiTsnoY0GT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_02,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 mlxlogscore=867 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405140044

Remove the duplicate definition of MAX_RADIOS from the core header file.

No functional changes, compile tested only.

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index c6b7524ce3a0..9e3f9537087d 100644
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


