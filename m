Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6068C26D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Feb 2023 17:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjBFQDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Feb 2023 11:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBFQDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Feb 2023 11:03:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1644E5FE1
        for <linux-wireless@vger.kernel.org>; Mon,  6 Feb 2023 08:03:53 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316Ckkxu020307;
        Mon, 6 Feb 2023 16:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=pwVAEj1JnwGjwZxWhvbhmBR7g6POtK9kDVPSjq0vXQM=;
 b=lqi6AyaMm0WmHzifZY9BeqwYgDEhe3NHAwrmTeTPQ7mwMhMvh6OLWm4J2H8bdE8yVsB7
 oTL4sGKkdhNoUWGl25ldBjp1XTA5VJu21HsOjfJO+oeUfTqqzNqh/GoPbPp0MG52Z1t7
 Pwsy0mPG9iHS/iGufHy49WRx+eNIvCCSe30QZQvHIu5eaJ6ECBVFB10/skrOXcxovyLc
 9/YJX2LO4dqZffKPPmYY/86nbck4cat9vXG1JEOtiXjRXWEJWMMUWGppUtTP9KkxDgjA
 BEKk8xM0NmCPUuAoblJ+pMl++J4b7tBP0Z/p3jExt+pVrFXTlqk+4ROsINpJ15i6dyA+ 6g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhg4rkwhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:03:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316G3nWa009621
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 16:03:49 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 08:03:47 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH] wifi: mac80211: fix Non-MLO station association in ML AP
Date:   Mon, 6 Feb 2023 21:33:30 +0530
Message-ID: <20230206160330.1613-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MYBR4wLznBaQ6ZCI9kz3wTCURSP2XJ_0
X-Proofpoint-GUID: MYBR4wLznBaQ6ZCI9kz3wTCURSP2XJ_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060139
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Non-MLO station frames are dropped in Rx path due to the condition
check in ieee80211_rx_is_valid_sta_link_id(). In multi-link AP scenario,
non-MLO stations try to connect in any of the valid links in the ML AP,
where the station valid_links and link_id params are valid in the
ieee80211_sta object. But ieee80211_rx_is_valid_sta_link_id() always
return false for the non-MLO stations by the assumption taken is
valid_links and link_id are not valid in non-MLO stations object
(ieee80211_sta), this assumption is wrong. Due to this assumption,
non-MLO station frames are dropped which leads to failure in association.
Fix it by removing the condition check and allow the link validation
check for the non-MLO stations.

Fixes: e66b7920aa5a ("wifi: mac80211: fix initialization of rx->link and rx->link_sta")

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 net/mac80211/rx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e284897ba5e9..53d98236c78e 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4052,9 +4052,6 @@ static void ieee80211_invoke_rx_handlers(struct ieee80211_rx_data *rx)
 static bool
 ieee80211_rx_is_valid_sta_link_id(struct ieee80211_sta *sta, u8 link_id)
 {
-	if (!sta->mlo)
-		return false;
-
 	return !!(sta->valid_links & BIT(link_id));
 }
 

base-commit: 8065c0e13f9875f597920a2af47e5dc2940a9c4f
-- 
2.37.0

