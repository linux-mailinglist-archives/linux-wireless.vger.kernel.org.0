Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B605D6745F5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 23:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjASW3E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 17:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjASW2X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 17:28:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89768A1997
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 14:12:38 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKTr1F000664;
        Thu, 19 Jan 2023 22:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=dtOCJlvbqLBBLy8oOFrUe+sKMFxRWGrMLpi6F7qZ0uk=;
 b=FU01WTusEoSE7uYW4mgMVsizWWbPGH1rIryalNllKhObZJYl/sOZhZT4bJYMI/p3jocF
 Em0A2tvrtrYeGbhmQqLAdmPzGRq7imusZ9QgYt71m9XV1Ak5IGfjOV3Zrzo//djCBJyq
 1zupHH4DJJz+QPMA+hwCWFPsziFKAQkxGHGLebnfPzyZvd2aU6zlBefWa51c7FZ6uQ2R
 G0JWPQo4vQd6Dgy2xvJViiJmQUcV9tpKacnpzT4Ek8sg0VYj5bJWXUuWAXo8+XeUCLIF
 ObBVa3jZXrKI1QpbhRczpvtMYU4GVAMZjUWdRsJ6eNWFeDBoWxBobYojYCAC4vi1Cd/V Rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vg02pd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 22:12:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JMCY7m010044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 22:12:34 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 14:12:33 -0800
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v2] wifi: mac80211: update rx nss for the link sta
Date:   Fri, 20 Jan 2023 03:42:01 +0530
Message-ID: <20230119221201.24287-1-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oeFYtOGJfbcdiLgTVI4U9XKBy9RErsLj
X-Proofpoint-GUID: oeFYtOGJfbcdiLgTVI4U9XKBy9RErsLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190187
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update nss info for the non default link stations
which gets added during ML assoc when link stations
gets added. For the default link sta which was added
during auth time, the nss would be updated in the usual
flow during set station post assoc once the capabilities
are available.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
v2: added wifi prefix in commit title
 net/mac80211/cfg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 72df8c708a2d..0fdf92e1428f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1754,6 +1754,15 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 						    params->eht_capa_len,
 						    link_sta);
 
+	/* update nss if not done already for the link sta,
+	 * for the deflink the nss will be updated once the
+	 * assoc flag is set through set station. For the
+	 * non-deflink sta we would reach here only during assoc,
+	 * so we would have all caps to calculate the nss.
+	 */
+	if (&sta->deflink != link_sta)
+		ieee80211_sta_set_rx_nss(link_sta);
+
 	if (params->opmode_notif_used) {
 		/* returned value is only needed for rc update, but the
 		 * rc isn't initialized here yet, so ignore it
-- 
2.17.1

