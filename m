Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4733686006
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 07:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjBAG5e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 01:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBAG5c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 01:57:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9847E93F4
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 22:57:31 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3116t4mU032320;
        Wed, 1 Feb 2023 06:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kMp2iDdEPIDlOrLi2rUM/K6vE+/A5EEzk+yp83bhZSo=;
 b=aizOQmfwtElw4Y99OLXIyLzChVNyD+QkwkMAL13tfh5B/1nf6TZYEBCbwKQY3PJhdBqH
 icyXPu74OFOcjJZuJlYPXWks/sT5cVROvVHba8AUP9fDS/hDp3zQynWYG/u8aiimJEdR
 Z5N3r/+Mq23zT4UnvkBAmv98/d36Pvaa3z2bJTWakQ/Yrplq9vjGUPzsQIzBqd1UlPaZ
 wBf3lV1xWiW8PUF3Sw5b34q0SOVNUyjbIg8w0HfSmareSXTdHx4dgYyXpDy9Nzrp758q
 VB/y/WCR2VBpehCWJPpwf3Gj6Wk7EK+hVfxU239SkNlleFpFs3JLvYbzbqLa+Q1fox6f pA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3new3ub72u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:57:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3116vMNs021360
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 06:57:22 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 22:57:19 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v3 2/3] wifi: mac80211: Avoid BSS color collision detection if its disabled
Date:   Wed, 1 Feb 2023 12:26:37 +0530
Message-ID: <20230201065638.25990-3-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230201065638.25990-1-quic_ramess@quicinc.com>
References: <20230201065638.25990-1-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TwwdMYMKr0X38IregJirGq7qkbSvviBx
X-Proofpoint-ORIG-GUID: TwwdMYMKr0X38IregJirGq7qkbSvviBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 mlxscore=0 mlxlogscore=946
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Don't detect BSS color collision and send collision events
to userspace if it is disabled.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 net/mac80211/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e284897ba5e9..5588067b2af2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3195,7 +3195,8 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 	if (ieee80211_hw_check(&rx->local->hw, DETECTS_COLOR_COLLISION))
 		return;
 
-	if (rx->sdata->vif.bss_conf.csa_active)
+	if (rx->sdata->vif.bss_conf.csa_active ||
+	    rx->sdata->vif.bss_conf.he_bss_color.collision_detection_enabled)
 		return;
 
 	baselen = mgmt->u.beacon.variable - rx->skb->data;
-- 
2.17.1

