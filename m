Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3572673AC2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 14:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjASNw4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 08:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjASNwu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 08:52:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4E9D8
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 05:52:44 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JCqd49014218;
        Thu, 19 Jan 2023 13:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=wcDz6yVzhFKLQdL1FVVnBwCM6lZ/cjl9ZHrRttmDV/Y=;
 b=CZmp7mLM7MfTLX+rPY8gm1KM+6l8yR4/8/HmDPfii1xChGvz1wJel8XPDtXrF/Og6LuB
 oBn4bAC36MpfAuP1z8L1B8FirnBmqsf58Vcp/SkyN7O16109L1HNU0GL+cn/eari1A4V
 JzQ+OdnYtHrPg8zl6goZGAod7nWMazsTRHNzRqtsZuwnotr2KT1CHgJ/sh71VgLrKbul
 FY1JeATHN03hw3umLUaRK47BuM3iw330+InWpQip9+OksQUAEU5QusQtosLvgCcSZ7KE
 Qhu6L9UlMiqo+WJ2BlSZasSwFnWBYLIJFB94H+4RABKyiLwOKP07taa0zvCFU0hQOlq8 bw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n70eyh5ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 13:52:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JDqev0010129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 13:52:40 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 05:52:39 -0800
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH] mac80211: update rx nss for the link sta
Date:   Thu, 19 Jan 2023 19:22:23 +0530
Message-ID: <20230119135223.18224-1-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8ei72dLGWdcBkyJBm5H1RbLbogwFHz9H
X-Proofpoint-GUID: 8ei72dLGWdcBkyJBm5H1RbLbogwFHz9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190111
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

