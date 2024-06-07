Return-Path: <linux-wireless+bounces-8697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B778D900720
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BBD28A836
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBAB19D09F;
	Fri,  7 Jun 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="otdJJ2oW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899E19CD13;
	Fri,  7 Jun 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771250; cv=none; b=klpA1AiBsskUNcgd7vOFiif1t6c2MfUMxALd+4uKOkzdJmm8TcXoD5gfVpruMIN8uINmaI4C86GFscjUtv/Nu3fB/noAa3y9CfCZNRsV9NNVYuhRp6vf/Nxe1efGJrlGeY78tTbexDk/b3X6meeIcaRaoTiMLwALE07HuHHdv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771250; c=relaxed/simple;
	bh=z7motuO/xV2ePFvwqk4C0YMsvJQ3jt9+be8vjhJjRHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKx8w2NXxWl/VKqMAYjRH5V6KOZeCInIVLngGELgE4xri5gWYqH94ejtpC3+QFudNVCgzpQRTT3Cc2gj36GIZaq19kwNPT58rghAkAaPvenTljo+I7LG9mohula1niOiXGMRX8vawOAfeE00YPsZEUI+gvit5X4xcIKEVXEQd3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=otdJJ2oW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457C6rTg020987;
	Fri, 7 Jun 2024 14:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6RI6aD1aRcRnRr23fMfwPOE6
	rq2EmxPFWYovc/OqDYY=; b=otdJJ2oWlb11pMI2okqFeQgoxX/d0L81MOWYhGMy
	y5b+oLZiahqUilD1EQaJIpjRPp66El92BvigXe5uUM/RxNR0wud4lyDPg5DaihIf
	DpYdBscLrE9s6fuI8pizAcDj7GuIkZ/bMg+AmPUsXca7mN6Oy4AFtgeJfSL2TBkr
	dZ8CvBUBx9uJWTa0Dxbdpig0eyjPkvzcRCPHrlEMjuXqODtnHe3RVsYnEzG+eGWm
	roarQidaY4toP1v+Je4Hkd6BKWNqE0HuDpdppPpEN75q2DFe4eNC7kXMJlW+l4Q1
	A48nHuZy6/CXZPNg7DEh8mg1dxjdA+RvS8Ponqyl+Q5KvA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk3h2vepc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 14:40:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457EebD7003199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 14:40:37 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Jun 2024 07:40:35 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <emmanuel.grumbach@intel.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: [PATCH v1 1/2] net: rfkill: Fix a wrongly handling error case
Date: Fri, 7 Jun 2024 22:40:11 +0800
Message-ID: <1717771212-30723-2-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: GZVKt2PTqVYl5BdnnRWTLMs1XgcBJ75P
X-Proofpoint-ORIG-GUID: GZVKt2PTqVYl5BdnnRWTLMs1XgcBJ75P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070108

Kernel API rfkill_set_hw_state_reason() does not return current combined
block state when its parameter @reason is invalid, that is wrong according
to its comments.

Fixed by returning API required value, also use pr_err() instead of WARN()
for this error case handling.

Fixes: 14486c82612a ("rfkill: add a reason to the HW rfkill state")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/rfkill/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index c3feb4f49d09..0dc982b4fce6 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -543,13 +543,15 @@ bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
 {
 	unsigned long flags;
 	bool ret, prev;
+	const unsigned long reason_mask = RFKILL_HARD_BLOCK_SIGNAL |
+		RFKILL_HARD_BLOCK_NOT_OWNER;
 
 	BUG_ON(!rfkill);
 
-	if (WARN(reason &
-	    ~(RFKILL_HARD_BLOCK_SIGNAL | RFKILL_HARD_BLOCK_NOT_OWNER),
-	    "hw_state reason not supported: 0x%lx", reason))
-		return blocked;
+	if (reason & ~reason_mask) {
+		pr_err("hw_state reason not supported: 0x%lx\n", reason);
+		return rfkill_blocked(rfkill);
+	}
 
 	spin_lock_irqsave(&rfkill->lock, flags);
 	prev = !!(rfkill->hard_block_reasons & reason);
-- 
2.7.4


