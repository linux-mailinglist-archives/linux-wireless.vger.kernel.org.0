Return-Path: <linux-wireless+bounces-15765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5A9DACCF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 19:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EC8281A0B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616A1FBEBE;
	Wed, 27 Nov 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F43MEWZq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9313BC35
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732730619; cv=none; b=QR0fxn5vsorqNKOd/Yg7rAR0RyQ8dMkqdR51hKTyTBu+/ZPl00oXzL4Ubyt8lezA/9cWfxvvdPRjOQcguuqj54QRVKecZEMZMezjmo3kA9UBn0w5upqmFFjV9BY3fhFrimT74t4rzX9l4kKnX+KTSUxO9nmE2yBL3C36RH+wpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732730619; c=relaxed/simple;
	bh=Moht/FVm3XLNQVa2DCbxneLe5NqR0B+jIBBkLnUCMjw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uKyTrmlWkgBlQnATQxGfeK+nyTuzdqXQXXpHMXJwfLUcnqVzJRWjJf+C34f87S1XPa1Q2C0XXJG1cuLYwVEPh/kZ0hFkvg/HADIvU8MLPWc/2v32xDfeOkJBVdtzb+N/JIf4Fs36ehKHlGmEjKonpXr9G9PtUS0TS8zQU1S6ngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F43MEWZq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARGQrrH025522;
	Wed, 27 Nov 2024 18:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Lpya7y6mPNgvohXD6hthlm
	MtoRSZSsa7fBau4Pp4E/k=; b=F43MEWZqpLJsL53CPpo2rVjT3W4VFsfPMiqQ7/
	IL6hBAyzRdsDcYM2Ftu6uyELBl8eAE453WTL/8m7wKOdbvaXlXac8J7gGQ0b1Alq
	bSO024hRgpuP+vdPZrG+F5hMI6j77uueeaT6O6CHuB1IM8Lr1G1pOKQLQY79UMpP
	A/DEvjW8YMTd5zxgmaA2KZTBtd/XHt1g/GdCsQFy0DQNzFyL70N0oPaLQ5lYXdfS
	A+HepTw2MyvmnU20cvm8A9zZr0Jm764ccE4A5/Yrqgq8Xb2QEnASXFZr7A/xtLIw
	cbCOyDqsx0igModaHvHpW8RqhLi+SpQKiZi1Omcfb9ko/SgQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xxr70h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 18:03:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ARI3Qx2015639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 18:03:26 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 27 Nov 2024 10:03:26 -0800
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH] wifi: mac80211: fix variable used in for_each_sdata_link()
Date: Wed, 27 Nov 2024 10:02:55 -0800
Message-ID: <20241127180255.1460553-1-quic_alokad@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xir_ICM59yBlRrGayDdBBXQyl-fgg--e
X-Proofpoint-ORIG-GUID: Xir_ICM59yBlRrGayDdBBXQyl-fgg--e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=600 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411270141

Macro for_each_sdata_link() accepts input '_local' but uses 'local'
in its processing. This currently works because all the functions
calling this macro have declared 'local' as a variable themselves.
But this results in compilation error when a new caller uses
'sdata->local' instead of declaring 'local' variable.
Use '_local' instead of 'local' in for_each_sdata_link().

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 net/mac80211/ieee80211_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a00096dd787b..534a20054151 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1206,7 +1206,7 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 	for (int ___link_id = 0;					\
 	     ___link_id < ARRAY_SIZE(___sdata->link);			\
 	     ___link_id++)						\
-	if ((_link = wiphy_dereference((local)->hw.wiphy,		\
+	if ((_link = wiphy_dereference((_local)->hw.wiphy,		\
 				       ___sdata->link[___link_id])))
 
 static inline int

base-commit: dfc14664794a4706e0c2186a0c082386e6b14c4d
-- 
2.34.1


