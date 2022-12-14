Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FB64C626
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 10:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiLNJki (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 04:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiLNJkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 04:40:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7588C1EAC7
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 01:40:05 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BE9R793004237;
        Wed, 14 Dec 2022 09:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=89ZQ6jkpZxUnRtX/ZZVOfblWawR1yYrS+8jEyYqsKIc=;
 b=nx+dW6EI1IfVjKPumz0NzCjK1m3uTCktvSIdioxfmDU1Juc5sWGFE3Mea80Oz01KjEu4
 uzHIFuxxIdLJg2vNssdH3/qH8949khxf2Q+0xD7OadhBMR0V1sTbq3jfotPSwJUl3DIo
 +hUBZycaXMOC9r83anX230kTcTg+ltEmHEbvVs0A6mbZHLspKEqVTKA7PRGma/JdZw++
 hvw7ZSfh+x0zhroAb8EJmCP/6VLyoBYpbmhfR5/ZaoK5L9KL+/09hYZBPgtYb9O2cLS8
 pO6HozScDEPSMoJ6uQszV1XQhPn5myiH7T1/TC0G3sva+HSz3uznPIjJG+lMesJN8DZf Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rvrk2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 09:39:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BE9drLh021902
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 09:39:53 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 14 Dec 2022 01:39:52 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: cfg80211: call reg_notifier for self managed wiphy from driver hint
Date:   Wed, 14 Dec 2022 04:39:37 -0500
Message-ID: <20221214093937.14987-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ropPHB8IANkwUPI808U-jB35xs3zp7gV
X-Proofpoint-ORIG-GUID: ropPHB8IANkwUPI808U-jB35xs3zp7gV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently the regulatory driver does not call the regulatory callback
reg_notifier for self managed wiphys. Sometimes driver needs cfg80211
to calculate the info of ieee80211_channel such as flags and power,
and driver needs to get the info of ieee80211_channel after hint of
driver, but driver does not know when calculation of the info of
ieee80211_channel become finished, so add notify to driver after
reg_process_self_managed_hint() from cfg80211 is a good way, then
driver could get the correct info in callback of reg_notifier.

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 net/wireless/reg.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4f3f31244e8b..e3f500832427 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3085,6 +3085,18 @@ static void reg_process_hint(struct regulatory_request *reg_request)
 	reg_free_request(reg_request);
 }
 
+static void queue_regulatory_request(struct regulatory_request *request)
+{
+	request->alpha2[0] = toupper(request->alpha2[0]);
+	request->alpha2[1] = toupper(request->alpha2[1]);
+
+	spin_lock(&reg_requests_lock);
+	list_add_tail(&request->list, &reg_requests_list);
+	spin_unlock(&reg_requests_lock);
+
+	schedule_work(&reg_work);
+}
+
 static void notify_self_managed_wiphys(struct regulatory_request *request)
 {
 	struct cfg80211_registered_device *rdev;
@@ -3095,6 +3107,13 @@ static void notify_self_managed_wiphys(struct regulatory_request *request)
 		if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED &&
 		    request->initiator == NL80211_REGDOM_SET_BY_USER)
 			reg_call_notifier(wiphy, request);
+
+		if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED &&
+		    request->initiator == NL80211_REGDOM_SET_BY_DRIVER &&
+		    request->wiphy_idx == get_wiphy_idx(wiphy)) {
+			reg_call_notifier(wiphy, request);
+			request->wiphy_idx = WIPHY_IDX_INVALID;
+		}
 	}
 }
 
@@ -3172,6 +3191,7 @@ static void reg_process_self_managed_hint(struct wiphy *wiphy)
 	const struct ieee80211_regdomain *regd;
 	enum nl80211_band band;
 	struct regulatory_request request = {};
+	struct regulatory_request *driver_request;
 
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(wiphy);
@@ -3199,6 +3219,13 @@ static void reg_process_self_managed_hint(struct wiphy *wiphy)
 	request.initiator = NL80211_REGDOM_SET_BY_DRIVER;
 
 	nl80211_send_wiphy_reg_change_event(&request);
+
+	driver_request = kzalloc(sizeof(struct regulatory_request), GFP_KERNEL);
+	if (!driver_request)
+		return;
+
+	memcpy(driver_request, &request, sizeof(*driver_request));
+	queue_regulatory_request(driver_request);
 }
 
 static void reg_process_self_managed_hints(void)
@@ -3225,18 +3252,6 @@ static void reg_todo(struct work_struct *work)
 	rtnl_unlock();
 }
 
-static void queue_regulatory_request(struct regulatory_request *request)
-{
-	request->alpha2[0] = toupper(request->alpha2[0]);
-	request->alpha2[1] = toupper(request->alpha2[1]);
-
-	spin_lock(&reg_requests_lock);
-	list_add_tail(&request->list, &reg_requests_list);
-	spin_unlock(&reg_requests_lock);
-
-	schedule_work(&reg_work);
-}
-
 /*
  * Core regulatory hint -- happens during cfg80211_init()
  * and when we restore regulatory settings.

base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
-- 
2.31.1

