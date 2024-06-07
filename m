Return-Path: <linux-wireless+bounces-8698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247DE900737
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F9F282DF6
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C5119FA7D;
	Fri,  7 Jun 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WC/45YTZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C519EEC6;
	Fri,  7 Jun 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771258; cv=none; b=DYIyd17AOhCdC3Idb2zIqDpR6w51k9lQGeqW4wWETTbj/BVTUAE1bx26X8FvOWF2fBvU6v8nLUhs3QnsCWlYqHxf323kgl4SyX5jJ8+AwzznufJJlwU9z0SfnQ9h3cLlGH9l6kAOJ9qA1lvaKjCGciCXtU1OBNjqU8BlU/ALqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771258; c=relaxed/simple;
	bh=/zjDu8rh/wUgt/DmxGtCncSizfiJTRqPGmLT5HLi8t0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WppradvpVLvVSOdjJhS6KTFoqqct8Em6Cv/OCRawiHy28dSDbDyd6ntSV0uPLHMMyARfVgqTOIrH3X8DoKXJ4Noia8MUt6FY5Pp/BsK1JKJtihKqWeHvPRBJdJDUfBISzIjaeA1359mBDiw2YSn8/Ss8kuLKBEW41eP9jeSU0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WC/45YTZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457Bc749026749;
	Fri, 7 Jun 2024 14:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ivghVXAN1Xab5TCyYe4iSL0z
	XE99C1iS2kFiCNJgTKU=; b=WC/45YTZitkd1utK+kddp9b6cKdJnoR4H1w8xyRr
	2UdTGJB/MAEavsZbpoPktuplewGBEmaNLZUZFWIJSOs2IRWwMJ5OpMbFnEneK5zt
	VIxefxSsfg1PM2HxXkGnRebiupAzh+rvqFp3SZkOOdq85uq6XYjiR9PqL4xWizR0
	oSovtGxKCU8EvCNswbQnXl/uKdAgHRAktXn0dENgW2ykaWDGD5013g5MFmWWMtje
	VoZROcfOi/p0RhXssUoq20xZqMaQxuc635eezXSpXUdH8w0IvgR3uCw37U50axWp
	sBD4gfN4p5tKDUUIXcjPtknUAHtAEFMyyr+H48rec7+41Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjq2tp5s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 14:40:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457EejLK003259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 14:40:45 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Jun 2024 07:40:42 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <emmanuel.grumbach@intel.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: [PATCH v1 2/2] net: rfkill: Fix a logic error within rfkill_set_hw_state_reason()
Date: Fri, 7 Jun 2024 22:40:12 +0800
Message-ID: <1717771212-30723-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2FHTj_MMi_T46cufvKidzxstmrlKQo6r
X-Proofpoint-ORIG-GUID: 2FHTj_MMi_T46cufvKidzxstmrlKQo6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070108

Kernel API rfkill_set_hw_state_reason() wrongly gets previous block state
by using its parameter @reason as reason mask.

Fixed by using @reason_mask as reason mask.

Fixes: 14486c82612a ("rfkill: add a reason to the HW rfkill state")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/rfkill/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 0dc982b4fce6..ee7a751b6c5a 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -554,7 +554,7 @@ bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
 	}
 
 	spin_lock_irqsave(&rfkill->lock, flags);
-	prev = !!(rfkill->hard_block_reasons & reason);
+	prev = !!(rfkill->hard_block_reasons & reason_mask);
 	if (blocked) {
 		rfkill->state |= RFKILL_BLOCK_HW;
 		rfkill->hard_block_reasons |= reason;
-- 
2.7.4


