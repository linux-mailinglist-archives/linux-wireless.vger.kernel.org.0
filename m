Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3362D765AA4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjG0Rl5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0Rly (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:41:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C863830E2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:41:47 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RCb1xJ015224;
        Thu, 27 Jul 2023 17:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=mvau2ilA6fjOlqWT3XXgMNSPVwZsbDa4eaurXf+BBUc=;
 b=LAlG61rRZR1s5N9RqX6ky5P1A/tdMyhPq+NQ+slIFDeUvriB0eigyq5WEDELxcOajWjp
 ibZVvBjoArQmkrR3kTV8zWB8533MnhvSBRgYAemgqkka5aF0CXKea1JcmVjIdS+u6lWw
 +6L5X2nVWQkGDctcWpstY7CXh395Q3deGM9iuDYJWJQPWZXOzXFFb/hDQfhbQ2hpGL+r
 m0gxsiWcUn8RBoT3Mycb/sg6A0RzKOZS5PNku53P4Uy65xd1WcjzgvW14ElMcSfaaOLX
 c7XZMMpiM4pYK8rT1FXYVefJsbg8CqMphxblDwsn5xSFI8hOSJhbvN020VO/CqTAAnvN cA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3n2k9c6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:44 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RHfHAk025608
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:17 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 10:41:16 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v8 5/5] wifi: mac80211: additions to change_beacon()
Date:   Thu, 27 Jul 2023 10:41:00 -0700
Message-ID: <20230727174100.11721-6-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727174100.11721-1-quic_alokad@quicinc.com>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8jKAEAvdEII4r4zr-v8bIL-d5Q44TvFb
X-Proofpoint-ORIG-GUID: 8jKAEAvdEII4r4zr-v8bIL-d5Q44TvFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=917 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Process FILS discovery and unsolicited broadcast probe response
transmission configurations in ieee80211_change_beacon().

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v8: Do not check for a non-zero interval value to decide
whether to process the configuration.

 net/mac80211/cfg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 3fe424992893..12e6c782a3c2 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1543,6 +1543,19 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (err < 0)
 		return err;
 
+	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery,
+					   link, link_conf);
+	if (err < 0)
+		return err;
+	changed |= err;
+
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+						   &params->unsol_bcast_probe_resp,
+						   link, link_conf);
+	if (err < 0)
+		return err;
+	changed |= err;
+
 	if (beacon->he_bss_color_valid &&
 	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
 		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
-- 
2.39.0

