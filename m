Return-Path: <linux-wireless+bounces-8594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE368FDC86
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 04:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737731F24715
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 02:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F5E17579;
	Thu,  6 Jun 2024 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cxmqmXRy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB1179A7
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639637; cv=none; b=XmQvgS5AZiVbxWShrfGKV5v+RFBCu8XL16qVufiHDHhLYTyMJQXjL6vZ6MPy8AXbjzkpkK98JexE70esaVW4RD8vA3ElwZXkGJlhOCpJV/mJ/GMfAbWjAy/Wb+I/fspzxesFfDUsMOTZj9ZYCqMSg5DPiz/Oki2l8yN38DN1uck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639637; c=relaxed/simple;
	bh=wtop/svkHAOqSyb9x299dxZoGfajjhCt7cPnX58xIdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oqbb8m7lmzBeyYYCvz2OcAtD8cvjxEVhjzTh2p6Jw5OvMfKOYwaEAvnxCjZ1kKtK3U2Kit2iojKgDxmQu020JRRWzyQVi0hpyhZPiC21sluh3QcoTlWUa1DIHIfAdUbZ0FF7vumAOq1CU3CUy+BB1I/baobHHuY7QfwhECTeHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cxmqmXRy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455N4OOG031684;
	Thu, 6 Jun 2024 02:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zH0uKiaGW806wCwPPVxuGbIBTHAKbpN6OkHN0Y0aCY4=; b=cxmqmXRyCpzHW7Jf
	FOGG4DllYyr1eCn0z2eOYoAr7lnh7AA1J2/9/s3kt4MM33GyzyKevhPgTOA9xzon
	KaBgc8xCEfcmLBY5Sgi6BRh5rwjWQzYk2+PU85TVBYEyX82E7iBXx5QB6Q4Rx5YN
	Vhr11a6qSSJVMfrZ9svL+lZeJGfsbbOr4YqI4SFn/3vaYE6w8oL/wfsjaeFEA2QT
	AAbRt7tVTDfnQ5YKdw6iUgGvq91WcOub1BhzNIj/sIo96TTMrcjIJxdpTQ9VNuRW
	ycyDSh1LdXMiC9Yi6tzYJwvwb16WehL9ej2ZtOL5HfBao+IS1peAR1ikhXV7d8b/
	WnhbFg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjh3tth09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 02:07:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 456278Od021618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 02:07:08 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Jun 2024 19:07:06 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_bqiang@quicinc.com>
Subject: [PATCH 2/2] wifi: cfg80211: handle 2x996 RU allocation in cfg80211_calculate_bitrate_he()
Date: Thu, 6 Jun 2024 10:06:53 +0800
Message-ID: <20240606020653.33205-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606020653.33205-1-quic_bqiang@quicinc.com>
References: <20240606020653.33205-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: QoXWvV9oqkiOn5rstOZ8LP2At03LWFv5
X-Proofpoint-ORIG-GUID: QoXWvV9oqkiOn5rstOZ8LP2At03LWFv5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_08,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=812
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060014

Currently NL80211_RATE_INFO_HE_RU_ALLOC_2x996 is not handled in
cfg80211_calculate_bitrate_he(), leading to below warning:

kernel: invalid HE MCS: bw:6, ru:6
kernel: WARNING: CPU: 0 PID: 2312 at net/wireless/util.c:1501 cfg80211_calculate_bitrate_he+0x22b/0x270 [cfg80211]

Fix it by handling 2x996 RU allocation in the same way as 160 MHz bandwidth.

Fixes: c4cbaf7973a7 ("cfg80211: Add support for HE")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 net/wireless/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 39e19e2386b7..7fa186fb7fed 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1524,7 +1524,9 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	if (WARN_ON_ONCE(rate->nss < 1 || rate->nss > 8))
 		return 0;
 
-	if (rate->bw == RATE_INFO_BW_160)
+	if (rate->bw == RATE_INFO_BW_160 ||
+	    (rate->bw == RATE_INFO_BW_HE_RU &&
+	     rate->he_ru_alloc == NL80211_RATE_INFO_HE_RU_ALLOC_2x996))
 		result = rates_160M[rate->he_gi];
 	else if (rate->bw == RATE_INFO_BW_80 ||
 		 (rate->bw == RATE_INFO_BW_HE_RU &&
-- 
2.25.1


