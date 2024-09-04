Return-Path: <linux-wireless+bounces-12445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5A96AE22
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 03:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1A91F251A0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 01:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618C29A2;
	Wed,  4 Sep 2024 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CakOkbO6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0081EC01C
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414940; cv=none; b=ENgsayVjt+KTYdHUb1sob+s4BlrJIcs4mC9bLQIpbv5y5jTG1stxvTpLC2PCLAOiG8uguAkDRDA80wixp3P51NTCLpTQdJ/xDFHTwa8KzGQ75SZ7yB5+XQo6F258PnjaS0FEuZCX3ARbFDAQWOJTmH7hp9kKDjPhbu3JCWQV05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414940; c=relaxed/simple;
	bh=KBZejMD9Hi8e0bAASqIhP/SUHcSoh71nvHMpzaD111k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dksWg1+R9q/nwvlirXz9iymIPP2oBSUuAtSVkGyr6KoLmpSEROEoemUc/CnrMCnM9dWaxSaQhVFmDiIq2t3w8zqUgA5Att4RE7jAnQntQek1NjzSVnlTW+SaL7AD2N/rjoTLoUnSeQC9sh6ZfHN4q0yiGOBw7kyduGP5mwbhMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CakOkbO6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483L2A2S032229;
	Wed, 4 Sep 2024 01:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ikfGWb2H/xBofpsjKT5v8M
	sP7Tn5nGCUCABJ6lTJ+w0=; b=CakOkbO6C20WCS1YYDvy42T0Sz/aDAksbkc0jc
	44D/aSX1VPVCwHQgBT8/1RgSlkbCIzeQjsf28eQ4QZjripAVz7JC53WciniuzWm6
	FJ0qmmuFmaOF4GQm80AKB2mKnOpBe1krjWC7/OgA20U4BxUIr9PVFSAA3tdHtKF+
	kbx09ijEXGeizUU0sP7bIMWmZpSM9GH9gJhtvIei63BPEosXOWUDFU7KrGZFfkv8
	QYx3GGrE6QBv/iUiy+BvM19VhcouH24kxGssQ5+2wXDIciw66BaoXrhnnUvwG+Eh
	grQjpsYH7SaXPUIhcgu3RvKA0EG2q3lNLaIljL866pLQ8d3A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41drqe3g8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 01:55:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4841tXHa009147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 01:55:33 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Sep 2024 18:55:31 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH] wifi: cfg80211: Avoid RCU debug splat in __cfg80211_bss_update error paths
Date: Wed, 4 Sep 2024 07:25:20 +0530
Message-ID: <20240904015520.3571295-1-quic_vjakkam@quicinc.com>
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
X-Proofpoint-GUID: pCxZ-FSahJep-flad9wnor0I1MarfmZh
X-Proofpoint-ORIG-GUID: pCxZ-FSahJep-flad9wnor0I1MarfmZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_13,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 spamscore=0 mlxlogscore=521 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040012

Add rcu_read_lock() and rcu_read_unlock() to avoid suspicious
rcu_dereference_check warnings in __cfg80211_bss_update error paths.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d99319d82205..18f860ac14a7 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2008,12 +2008,14 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 	return found;
 
 free_ies:
+	rcu_read_lock();
 	ies = (void *)rcu_dereference(tmp->pub.beacon_ies);
 	if (ies)
 		kfree_rcu(ies, rcu_head);
 	ies = (void *)rcu_dereference(tmp->pub.proberesp_ies);
 	if (ies)
 		kfree_rcu(ies, rcu_head);
+	rcu_read_unlock();
 
 	return NULL;
 }
-- 
2.34.1


