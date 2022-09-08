Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4A5B255D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIHSLH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIHSLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 14:11:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F47BD1F5
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 11:11:01 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Da2dm011029;
        Thu, 8 Sep 2022 18:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=RJ9RxUuLdER1oNz/aP1JXYphl6GFoHb21aENQyf5PUs=;
 b=Szpn7/u/hy4NyRSv4Ac1kwP7Lgd4kLpRlwSRmnkyM+5tGN4gsezPLN9yoXFJpGinh1xW
 qBKHsx+jD+3EKoVPSgunsw3bnukY3tNoFmC9EHImIBtyecDr4Fz5G6Cq/amIOTyb+D1F
 K2z2Ze/2gNdnfMTDpy/cLoMhalkqUiiM+iu3nBP5b0e9VVjTpnugWhuZA3OPvS8EREj/
 7UaCpGUl33bNHpXwzXzfM3sECq3dOAf8/WFxoqlpH0YUTiyaDTHQty3npXIRaKtuqdrj
 lNRWso/yE4n9TubjdVZuM12HBimIHVivarPzoEYVM2r74wI7wAZJutXRrgZxHeTbMw0n Qg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jer1x5t78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 18:10:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 288IAvL8003357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 18:10:57 GMT
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 8 Sep 2022 11:10:56 -0700
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH] wifi: cfg80211: Fix MCS divisor value
Date:   Thu, 8 Sep 2022 23:40:34 +0530
Message-ID: <20220908181034.9936-1-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1_R-SVrKIbiY03hHuxFwL8AR_G6R_e8X
X-Proofpoint-GUID: 1_R-SVrKIbiY03hHuxFwL8AR_G6R_e8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=698 spamscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitrate for HE/EHT MCS6 is calculated wrongly due to the incorrect
MCS divisor value for mcs6. Fix it with the proper value.

previous mcs_divisor value = (11769/6144) = 1.915527

fixed mcs_divisor value = (11377/6144) = 1.851725

Fixes 9c97c88d2 ("cfg80211: Add support to calculate and report 4096-QAM HE rates")

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 net/wireless/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 0b28d00ba8f5..01493568a21d 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1361,7 +1361,7 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 		 25599, /*  4.166666... */
 		 17067, /*  2.777777... */
 		 12801, /*  2.083333... */
-		 11769, /*  1.851851... */
+		 11377, /*  1.851725... */
 		 10239, /*  1.666666... */
 		  8532, /*  1.388888... */
 		  7680, /*  1.250000... */
@@ -1444,7 +1444,7 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
 		 25599, /*  4.166666... */
 		 17067, /*  2.777777... */
 		 12801, /*  2.083333... */
-		 11769, /*  1.851851... */
+		 11377, /*  1.851725... */
 		 10239, /*  1.666666... */
 		  8532, /*  1.388888... */
 		  7680, /*  1.250000... */
-- 
2.17.1

