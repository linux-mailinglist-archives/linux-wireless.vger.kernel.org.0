Return-Path: <linux-wireless+bounces-15234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135009C693C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 07:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8697BB20E36
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF6F1779B8;
	Wed, 13 Nov 2024 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pyhw1Bsj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD11714BC;
	Wed, 13 Nov 2024 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479266; cv=none; b=HCpqmrYIwVSZzziT+Z9NtTM4AkVvzoByR+aEH/OV8nTdhsZTPfpvVJyODhRQLBrgeFQ5xjaXMWUmWJyfr4zanFdDL8u68qj3RFIFPXMdxkyBxAmb9mO9dW8mS1+riZtTh2imy2wVB4amCUJymq+7l2ogvV/78KmbPyC2867cXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479266; c=relaxed/simple;
	bh=L1G2yn4gF1pJOpNTKrs1pgT9a32+gaBncCA/Gwkj/fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=a8bENEYhsGWP9mHE9FK1Hnckr8lo2Vj1dtyUL52JO6fv96d+3l0OL0+C8uGoOKI9UtvMGAufkl2R0TyvXGM2VQ2fN7pw7aKrqqvrWLSiWWZrjAF4JGeIsseQHYKsrOkNIyRuKXEV9YnFUh4yXuzbymC+fszbuypSgen1XFZG4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pyhw1Bsj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRqWm015276;
	Wed, 13 Nov 2024 06:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FxMiUHPzzHhWXE1RsEIt3Z
	YZOlYRuj/Tq+0Roj8Wh7s=; b=Pyhw1BsjTj3d1SwFnDzah1f8uSIR8rPgT5XZ9N
	6M/cdGdJh/N/BdBOZBKz2jcrjYlnXlfIm+6aV2PldmmsiJC1Mu/OrKIsRTZFJVOy
	ohEx6pE1Y0Xge8ZgWSG3hj8c3o92J9H4rqMgPqCo/4e1D6qPPE46/GW7lQJ3sk+O
	+5g7i+bYUIRmgX/GjlWxZktnRDB2imcfPNNMeRKOXqSpsQT01JRQkQ6LTfs21hG3
	DFm9mt6iH5jV0CL5pG1YmscBdNTbC9KVhjihYzTj4iTlbnKW+0cPjfQd8Ow2JzRP
	5GL01+tNaSlWlczFamxaFhKwC3oYL8p8cZmv/Zqh3CZucR2A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v1vfufy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 06:27:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD6Rc1Y015609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 06:27:38 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 22:27:37 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Wed, 13 Nov 2024 11:57:13 +0530
Subject: [PATCH] wifi: cfg80211: fix WARN_ON during CAC cancelling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20241113-mlo_dfs_fix-v1-1-e4326736347b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMBGNGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Nj3dyc/PiUtOL4tMwKXUNDI2MDMwNDA8ukZCWgjoKiVKAw2LTo2Np
 aAA8AnuZdAAAA
X-Change-ID: 20241113-mlo_dfs_fix-1123060109bc
To: Johannes Berg <johannes@sipsolutions.net>
CC: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MxyW7xzQCVQpw0AD5vul0LaZB2rWdiw1
X-Proofpoint-ORIG-GUID: MxyW7xzQCVQpw0AD5vul0LaZB2rWdiw1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 mlxlogscore=513 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130056

In cfg80211_cac_event(), there’s a check to ensure that for MLO, the
link_id argument passed must be a valid link_id in the wdev. The various
callers of this function (during MLO) are -
 * ieee80211_stop_ap()
 * ieee80211_link_stop()
 * ieee80211_dfs_cac_timer_work()
 * ieee80211_dfs_cac_cancel()

Now, in ieee80211_stop_ap() the wdev->valid_links is still having the link
ID which is being stopped. ieee80211_dfs_cac_timer_work() is triggered
after CAC time and the link ID is still valid in wdev->valid_links.
Similarly in ieee80211_dfs_cac_cancel() as well, the link ID is valid in
wdev->valid_links.

However, during the link stop via ieee80211_link_stop() flow, when this
function is called, the link_id is removed from the bitmap, triggering the
WARN_ON. The flow during the stop link is -

nl80211_remove_link
  > cfg80211_remove_link
    > ieee80211_del_intf_link
      > ieee80211_vif_set_links
        > ieee80211_vif_update_links
          > ieee80211_link_stop
            > cfg80211_cac_event

In cfg80211_remove_link(), the link_id is removed from the valid_links
bitmap before ieee80211_del_intf_link() is called. Consequently, in
cfg80211_cac_event(), the WARN_ON is triggered.

Since having link_id set in valid_links is not a necessary condition now,
remove the check.

Fixes: 81f67d60ebf2 ("wifi: cfg80211: handle DFS per link")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/wireless/mlme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index a5eb92d93074e6ce1e08fcc2790b80cf04ff08f8..2a932a036225a3e0587cf5c18a4e80e91552313b 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1112,10 +1112,6 @@ void cfg80211_cac_event(struct net_device *netdev,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	unsigned long timeout;
 
-	if (WARN_ON(wdev->valid_links &&
-		    !(wdev->valid_links & BIT(link_id))))
-		return;
-
 	trace_cfg80211_cac_event(netdev, event, link_id);
 
 	if (WARN_ON(!wdev->links[link_id].cac_started &&

---
base-commit: 11597043d74809daf5d14256b96d6781749b3f82
change-id: 20241113-mlo_dfs_fix-1123060109bc


