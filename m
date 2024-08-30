Return-Path: <linux-wireless+bounces-12242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC89658AB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 09:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C8E1F24648
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 07:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C8414A616;
	Fri, 30 Aug 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="alP3wnrL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822714C5A4
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003276; cv=none; b=a9K2TERjpLDkVhDa5N9gFtjIyrqAKNpYkux6bmvxtNF0cxQep88fbio3C3n7v1Jy5jMr6QkwqYwPcuqbdkdbGr22RJKFXwV5dBrSZQSIcY020ZaaKBzR/jwqqHVhQfXB0Hhaoi1cXB7HCrTb4RKDi7R0+tAl7t4F9kupH3xmyhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003276; c=relaxed/simple;
	bh=Wj29OrRnJjK3SeqSzVAETvvdepk1YL0lSaXncGxrwZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqDjZkBEOlxxGC+d2PWXWPgiTWmke5PBgaVApvGrzacblRLXNBcFr3Qva4gpu6tg4GLaWQA32rsyCL3PaCaVsSafWiXI1v1I2xwlouvccooQcHsqmHiLWsWv8hvNcIYLAZDd29Qv8GQ0YN8XhvmmVSaITQgqd2ghPs8ibp6FfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=alP3wnrL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7TtlR005860;
	Fri, 30 Aug 2024 07:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dXr9x9Q8Bfb9PPp7A3lgrzakq6u7YQBmpPgVurJexIQ=; b=alP3wnrLVyMBl07o
	0kIpS8OI6rR7K6LpHAoHV812hKAlU9Smf9dN2zgsiNWEZxGwiuYd7zh1bDP7ajE5
	oi8FeE0rw4sMzPEWeeMqU2i5tml1/89Oc8Vp9KPSYQz1KttNT5YNQGiqpXB6ZnvJ
	4SQlUQ3KR8QezUmsFzMIQR0MSf5ccQLjmt6HtHcKqKfDiNLDl84CAzcFs1qpH1Yi
	+FfgOmByiMsUSizLJxkA48mJyoTCZ0E+n1DXHzrFllsd0qt5QmoIo/DoLwG6uSW3
	42KiagECivdQub0SO8tviinb9cvhc3oIEFC+WRvWxRi/tZlfvsdOsBKQwmTcWetl
	bZS31A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419putyvkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 07:34:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U7YWaX011660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 07:34:32 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 Aug 2024 00:34:31 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH ath-current 1/2] Revert "wifi: ath11k: restore country code during resume"
Date: Fri, 30 Aug 2024 15:34:19 +0800
Message-ID: <20240830073420.5790-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830073420.5790-1-quic_bqiang@quicinc.com>
References: <20240830073420.5790-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: yDwLeWh1Hj0FNz0aeUVYP3753MXqTbwS
X-Proofpoint-GUID: yDwLeWh1Hj0FNz0aeUVYP3753MXqTbwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=914 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300055

This reverts commit 7f0343b7b8710436c1e6355c71782d32ada47e0c.

We are going to revert commit 166a490f59ac ("wifi: ath11k: support hibernation"), on
which this commit depends. With that commit reverted, this one is not needed any
more, so revert this commit first.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 03187df26000..325b930aaf06 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1009,16 +1009,6 @@ int ath11k_core_resume(struct ath11k_base *ab)
 		return -ETIMEDOUT;
 	}
 
-	if (ab->hw_params.current_cc_support &&
-	    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
-		ret = ath11k_reg_set_cc(ar);
-		if (ret) {
-			ath11k_warn(ab, "failed to set country code during resume: %d\n",
-				    ret);
-			return ret;
-		}
-	}
-
 	ret = ath11k_dp_rx_pktlog_start(ab);
 	if (ret)
 		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
-- 
2.25.1


