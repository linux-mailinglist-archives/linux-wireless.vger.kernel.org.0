Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33B6EA390
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 08:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDUGOA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 02:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDUGN6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 02:13:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04A1BFE
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 23:13:55 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33L5Ald0005019;
        Fri, 21 Apr 2023 06:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=8EMZQIqwZIdP0AjhCHcfFK/Llbb+vQHSXA8i55cD3R8=;
 b=OfXwqQYkMlbTtHTbexmf9jr9l6fSHiKKGYailZP2svWre23EdrKlQg69P27OtgCfjveJ
 F2BERH2XZ9uar0mYPbucMYc3H3ZJfvybESIZZrT1TKZZMcqOiDaSnJO9Ygoo+brBSQtY
 ISRTKKRSnmgKcpQwyjxBdZr5zq+z6dcXcuc6H8xIwpnRJINTZvCpXBCA1mqk26rcxJzo
 10s8znpZszsAIpLluIG5U1BJinX72EZZiNDRX4E02JAM7gcYzaSMp9CBSEeUIlwYNKf4
 VhwUweXMtcC3/coG5CZqbIgmGRXmYb7VGBriIYfpkLaNrC13+nfcrCPCd9NaRw3ISCrr uQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q37qfsnbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 06:13:44 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33L6DhYJ000678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 06:13:43 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 20 Apr 2023 23:13:42 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH] wifi: cfg80211: allow reg update by driver even if wiphy->regd is set
Date:   Fri, 21 Apr 2023 11:43:12 +0530
Message-ID: <20230421061312.13722-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: klh2bScpfJZ-6DTqOiLX2tDWSl9szgFa
X-Proofpoint-ORIG-GUID: klh2bScpfJZ-6DTqOiLX2tDWSl9szgFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_17,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 clxscore=1011 phishscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304210052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently regulatory update by driver is not allowed when the
wiphy->regd is already set and drivers_request->intersect is false.

During wiphy registration, some drivers (ath10k does this currently)
first register the world regulatory to cfg80211 using
wiphy_apply_custom_regulatory(). The driver then obtain the current
operating country and tries to update the correct regulatory to
cfg80211 using regulatory_hint().

But at this point, wiphy->regd is already set to world regulatory.
Also, since this is the first request from driver after the world
regulatory is set this will result in drivers_request->intersect
set to false. In this condition the driver request regulatory is not
allowed to update to cfg80211 in reg_set_rd_driver(). This restricts
the device operation to the world regulatory.

This driver request to update the requlatory with current operating
country is valid and should be updated to cfg80211. Hence allow
regulatory update by driver even if the wiphy->regd is already set
and driver_request->intersect is false.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 net/wireless/reg.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0d40d6af7e10..6cf0bc386f94 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3833,7 +3833,7 @@ static int reg_set_rd_driver(const struct ieee80211_regdomain *rd,
 {
 	const struct ieee80211_regdomain *regd;
 	const struct ieee80211_regdomain *intersected_rd = NULL;
-	const struct ieee80211_regdomain *tmp;
+	const struct ieee80211_regdomain *tmp = NULL;
 	struct wiphy *request_wiphy;
 
 	if (is_world_regdom(rd->alpha2))
@@ -3856,10 +3856,8 @@ static int reg_set_rd_driver(const struct ieee80211_regdomain *rd,
 	if (!driver_request->intersect) {
 		ASSERT_RTNL();
 		wiphy_lock(request_wiphy);
-		if (request_wiphy->regd) {
-			wiphy_unlock(request_wiphy);
-			return -EALREADY;
-		}
+		if (request_wiphy->regd)
+			tmp = get_wiphy_regdom(request_wiphy);
 
 		regd = reg_copy_regd(rd);
 		if (IS_ERR(regd)) {
@@ -3868,6 +3866,7 @@ static int reg_set_rd_driver(const struct ieee80211_regdomain *rd,
 		}
 
 		rcu_assign_pointer(request_wiphy->regd, regd);
+		rcu_free_regdom(tmp);
 		wiphy_unlock(request_wiphy);
 		reset_regdomains(false, rd);
 		return 0;
-- 
2.17.1

