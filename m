Return-Path: <linux-wireless+bounces-12483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60496C033
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D051F269D9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA681DB55A;
	Wed,  4 Sep 2024 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hJNF5FA/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3401D172F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459648; cv=none; b=YKKt0QMUpHHg7NssQQkbHddVqBCJFuTqu0BUmwFA52E02+boXpLqmD8tLiN9nLswFxbImfu+boU4Df/FKQl4YosXLpCS7vP5gw3i4KfZ2netRHyA4XhGv562rFA25xIj5vWbw/U+neT9FOmc9ir29TLYr0TU+zNCnUoOZ7DL+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459648; c=relaxed/simple;
	bh=ejxAN/k2PUuldMauWkJuFUue7gcfjra89SBfH4zsoGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SSp4XI4i4DDm1vHIU7MNRWM849E1N8hzGp/zwKPPwlAZD/ZOZpmiSVM4iZMkSZPomw75I88jrjUYZd5VA8gpgBa6ljTjwAHJg6O7CZCaHzbb7Zokd29M3IVq8rVVWtD+UNSTUM2vt4jypAL38RiKDehbIZ6n9iLtP+xKRilQjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hJNF5FA/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849hvt6031157;
	Wed, 4 Sep 2024 14:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9uFv6YavId08mwKXvbbMJj
	cYwM6qAbREz0oZdK9h2kA=; b=hJNF5FA/rJMyhhRBlYr5RVOpOa1WfOIS8EYiQJ
	1i0HD/nwQlMKqqZi7ONgb48wYEbW96uAm8c7bSdL5Mle8GG/OM5kg3UyqgFCB90a
	/BEUR7Er+XeQoPBjdHusGl0v1DvuKTjNiwKX8BoYe5/4QG6hD4nN1ml9Su70Itic
	bVJDeqLkhbbI1YIFWz7OjV/zQf1L/d7pvBWURJVdhNr6MLCDaJrTAXliegwD4E2j
	CPWIPcp+1DPSAAVLv5emApAjMqm/noJsYJ1BgxXTGS8rPP/xmiFmEX/1Pr46WCjF
	Cxe7fxDno+F4rwRjBEwGcjzSMAkUHb9Hv5Yq4tgi2OJ+CaBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bvbkjukp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 14:20:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484EKg3a022956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 14:20:42 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 07:20:40 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2] wifi: cfg80211: Avoid RCU debug splat in __cfg80211_bss_update error paths
Date: Wed, 4 Sep 2024 19:50:21 +0530
Message-ID: <20240904142021.3887360-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: 9KnWFep8_pwOqmD6qOP47HfOxuQbIOPN
X-Proofpoint-GUID: 9KnWFep8_pwOqmD6qOP47HfOxuQbIOPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_11,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=586 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040108

Replace rcu_dereference() with rcu_access_pointer() since we already
hold the lock and own the 'tmp' at this point. This is needed to avoid
suspicious rcu_dereference_check warnings in__cfg80211_bss_update error
paths.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v2: * Replace rcu_dereference() with rcu_access_pointer() instead of
      holding RCU read lock.
---
 net/wireless/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d99319d82205..e9bba230434a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2008,10 +2008,10 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 	return found;
 
 free_ies:
-	ies = (void *)rcu_dereference(tmp->pub.beacon_ies);
+	ies = (void *)rcu_access_pointer(tmp->pub.beacon_ies);
 	if (ies)
 		kfree_rcu(ies, rcu_head);
-	ies = (void *)rcu_dereference(tmp->pub.proberesp_ies);
+	ies = (void *)rcu_access_pointer(tmp->pub.proberesp_ies);
 	if (ies)
 		kfree_rcu(ies, rcu_head);
 
-- 
2.34.1


