Return-Path: <linux-wireless+bounces-8975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2422C907490
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 16:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB64D1F216FB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5958144D0B;
	Thu, 13 Jun 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P7EAkGre"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EC9476;
	Thu, 13 Jun 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287496; cv=none; b=Q75EcCHIycquvIMfIIxk5L1DQdM3XCxo0p3OrPM9znnOW/gz+mbunWsryJgE0F0OdZ+8z/YZccd/9ZJHKvjwkrkl+NKY4YG7bxcAkZEXKMn1veA1yBX5laT41Tg7XTHy5YDs8P+KNFnc/zznDMVA0AyeM/Io7huOPVI8446c8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287496; c=relaxed/simple;
	bh=aTwXz6cd+7O5ns/VoXjB2wvZF89KQ+cESZglgSOTSog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fr1NlLIkGq2e0TIE/FuPq+ZTL6bJgexvkpPU9LYv//kmdzjuNY6NuqJkXXIE7Fjd99NTLVHQ/4iggljot2DglxSW5hs5eIKEMc2ukY7xuxxyPu2amhgs3+d8sA8LcB1dxeg4V9Sefi/k5aFIhJCFUW8lTpsxrJ/yUrA8yearK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P7EAkGre; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D9WHve013814;
	Thu, 13 Jun 2024 14:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=YuoXR8+jBUjy6aij2PyZEfjZb9KTyQz84PKl9zDk6L0=; b=P7
	EAkGrecHdEk0LUqVwnTAFHOZFjdsb8sUt/4e+q8QAiJKEVn2Sj4eLsKjjov4xlCJ
	Sl4+1TCGWJwgEtOfyJpdHLCYzscpp7JP+zvSJrLWL0K0w82n2Ctp1DMY+fhWUPw+
	r7SxX0vaLdZuBsqBJ0ITNSV4Ls4SwL/mmMLPQ5nQpx8+ikKN5AIAcTM1WLrBXu3M
	Ds555pvzpjXAo5fwO54E0ju3H66MYm9Xw0tWa/DJB8eIWNvFO6wy4mqxSJeReKTZ
	e9i0Lf+oG0Bt9/CE6jlrVQ9OEGG1KfMsAXwQ8aF+Ki/aYxLSQl3UpCOqFFY4U4bU
	krBb7G8lTNsUJ2zbJFeg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqx7k0s24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 14:04:43 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DE4gPm027796
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 14:04:42 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Jun 2024 07:04:40 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] net: rfkill: Correct value returned for invalid parameter
Date: Thu, 13 Jun 2024 22:04:36 +0800
Message-ID: <1718287476-28227-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
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
X-Proofpoint-ORIG-GUID: 2Pefc01LrsNixgR4SifjjoAmaZjaWG3T
X-Proofpoint-GUID: 2Pefc01LrsNixgR4SifjjoAmaZjaWG3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_07,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=925 mlxscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130101

Kernel API rfkill_set_hw_state_reason() does not return current combined
block state when its parameter @reason is invalid, that is wrong according
to its comments, fixed by correcting value returned.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
previous discussion link:
https://lore.kernel.org/all/1717771212-30723-2-git-send-email-quic_zijuhu@quicinc.com/

 net/rfkill/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index c3feb4f49d09..1f3082526658 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -543,13 +543,14 @@ bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
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
+	if (WARN(reason & ~reason_mask,
+		 "hw_state reason not supported: 0x%lx", reason))
+		return rfkill_blocked(rfkill);
 
 	spin_lock_irqsave(&rfkill->lock, flags);
 	prev = !!(rfkill->hard_block_reasons & reason);
-- 
2.7.4


