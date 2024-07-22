Return-Path: <linux-wireless+bounces-10437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F884939468
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 21:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237F5B21693
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF191BF54;
	Mon, 22 Jul 2024 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j3Ygv4Cf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6C17106F
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677337; cv=none; b=t4TEbkhVrWFdEurMT+ZLtJ7h1FlYIrllJ1KRS8y8mxqI3Euc3OJqR0HD855kWNKftMvsrLYQhM3Xyy/J5PMPtuvTOKU7NYzqmOqQJUkeL/SdCZdbgjo1bGvozR58GAsTMezP52k1BNQwfZ7fNo7WDjuFJR0CPisSCzA6qs0e1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677337; c=relaxed/simple;
	bh=/ljcDmLf0ufEXgq0+mwXxYSADTiFu8Xnna9sQ8D4i+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eFMgke5YWtEoObLIAovZV4Vy7uyJKwThIaNEX7NhxEUEEIuasP+aC6X0JccCIemD7n1VzGk9I6EhPYWlhpwGb8h5jOVK3DYS6e6V+1M9n4tzuO9+p60o7XSyfRr75/OCLUPli7wgEaz/baB2lmk8sHlvFo5wd4brUx/IphzSqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j3Ygv4Cf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MAn5Te024250;
	Mon, 22 Jul 2024 19:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CdgX4+hta/zznwuBKqHuyL
	NWS/SDErqmN1BBkP7QOHc=; b=j3Ygv4CfRw0jy3rnA7+i80CXOPuwx3LeqbzllJ
	hKeWBMIrdm6PJ92hLhAEMrC5vzgFDwZFIS2bGz3YlO+jVI1iNVsCqdU0r62gjDM+
	Rx41agsqvy+h+LH2hbH2ouypA9QPWhX0CWKY3R+Dw3iVGrKHeWOtazUcVRXhCjiy
	5ZyFi6WbqckCr1XFrJiKzMxOc3gjlq3N5OvGlAsMWstzR9LXKYD2k1eBzZP53JsS
	oq8UsYGPDgSs2Qx5mNyFv6mTLRZ52DQkkdZnCbi3mQLR4z/ItwzCpvQc2O1dZ76T
	t/sFhrjMN7ePCvbKJWbLs0ib0sTcE6I49rmdsa8rPdebPRQA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487cr8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 19:42:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46MJgBSl004997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 19:42:11 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Jul 2024 12:42:09 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH] wifi: cfg80211: fix reporting failed MLO links status with cfg80211_connect_done
Date: Tue, 23 Jul 2024 01:11:46 +0530
Message-ID: <20240722194146.1736608-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: C4VOhNnh91dfayzb2sxzsJ2rRq79F1J1
X-Proofpoint-GUID: C4VOhNnh91dfayzb2sxzsJ2rRq79F1J1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_13,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407220146

Individual MLO links connection status not copied to
EVENT_CONNECT_RESULT data while processing the connect response
information in cfg80211_connect_done(). Due to this failed links also
indicated with success status in EVENT_CONNECT_RESULT.

To fix this, copy the individual MLO links status to
EVENT_CONNECT_RESULT data.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/sme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index e419aa8c4a5a..d9d7bf8bb5c1 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1045,6 +1045,7 @@ void cfg80211_connect_done(struct net_device *dev,
 			cfg80211_hold_bss(
 				bss_from_pub(params->links[link].bss));
 		ev->cr.links[link].bss = params->links[link].bss;
+		ev->cr.links[link].status = params->links[link].status;
 
 		if (params->links[link].addr) {
 			ev->cr.links[link].addr = next;
-- 
2.34.1


