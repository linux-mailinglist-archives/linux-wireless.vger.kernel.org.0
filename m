Return-Path: <linux-wireless+bounces-7369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070808C0A21
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 05:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB59B20B7F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 03:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7313C3CC;
	Thu,  9 May 2024 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EdWzuf2i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15301D517
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715225180; cv=none; b=elvf1OCioYKOR7TW8YOboRXoZtTyouZkL84yrKudnI3xDGLkVb3BE/Xy+lV+Sf644U91+UxTsMgpcVtY1hcl11Dy7M9xqiHoVJEHvC1ehsa62J37aZFwKHZ/A3XGbc+zfSXdr7MRC9hsFPx1TOFx24rcxuGntSvRVQGZw4fKSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715225180; c=relaxed/simple;
	bh=jKTOhPP6b5Ck+3mH/n0VMKp8wQ5oiHkg6PkehbiclOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aX6hlVUDMEhnO4JnxyJFCNHTP+kAZFiK6vvEITnxp8dFGZWRQuYV7I2Y25AAFFz9YGqoAQnYLz1c3Jpbd3hDMHKmSBCMnDovBZLQ6n6fDMt5ykp4sE32GEj4Wl3wSivQQG5YyiF6ONP47plVGVfTrAEXfPlpM50/n2CqLM4YicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EdWzuf2i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4493EBbI019996;
	Thu, 9 May 2024 03:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=2A4Acau
	x+InIT2i7filZkPJggrulB0AG9EJ3jKfZ+JA=; b=EdWzuf2iXA3T9E8sgzdhcMC
	HvdDrdVCcfVABTwKljivq4rr/rTIkdrvbb84mirNfTbt1MNTydbmqko+yCKS9djK
	0bA44lfKpJveOnROsJKG5Hs4BhI2KEDZBzxhJMpOmbcBdVzDcXrXBiMO8wiP4yNF
	3zg44SXwyddnaqF9HM/BursJPWfW7fyLA1hGurF94aKbCH/j/ohMDLWT/74KvKFV
	Bejbs9kxDlwFDFEDr0v3NFt/vDT9bdpDW53FmHSJXIM8IRPPe/OooZPlbUSKCFIt
	UM6MzOheJNL7iOHStXevUmniBLnaW5Nu9EBJoHpzglCvUlqujUnbZBfrasarOgg=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09g5hmpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 03:26:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4493QCSp023867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 03:26:12 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 20:26:11 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH] wifi: mac80211: pass proper link id for channel switch started notification
Date: Thu, 9 May 2024 08:55:55 +0530
Message-ID: <20240509032555.263933-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tomZHFZvn3KidhXOVs8zhnhlBk9lsUSm
X-Proofpoint-GUID: tomZHFZvn3KidhXOVs8zhnhlBk9lsUSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_10,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090022

Original changes[1] posted is having proper changes. However, at the same
time, there was chandef puncturing changes which had a conflict with this.
While applying, two errors crept in -
   a) Whitespace error.
   b) Link ID being passed to channel switch started notifier function is
      0. However proper link ID is present in the function.

Fix these now.

[1] https://lore.kernel.org/all/20240130140918.1172387-5-quic_adisi@quicinc.com/

Fixes: 1a96bb4e8a79 ("wifi: mac80211: start and finalize channel switch on link basis")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b08e5d7687e3..1d427f1915ca 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4016,7 +4016,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
-	link_data->csa_chanreq = chanreq; 
+	link_data->csa_chanreq = chanreq;
 	link_conf->csa_active = true;
 
 	if (params->block_tx &&
@@ -4027,7 +4027,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
-					  &link_data->csa_chanreq.oper, 0,
+					  &link_data->csa_chanreq.oper, link_id,
 					  params->count, params->block_tx);
 
 	if (changed) {

base-commit: 1d60eabb82694e58543e2b6366dae3e7465892a5
-- 
2.34.1


