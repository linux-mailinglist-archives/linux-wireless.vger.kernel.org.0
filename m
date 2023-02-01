Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448D3686037
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 08:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjBAHER (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 02:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjBAHEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 02:04:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE9583C9
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 23:03:52 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3115FNNZ004227;
        Wed, 1 Feb 2023 07:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=wRqmfD9+40B6tDDrqJWib+TvKyDYFqk6QODOXhPPsG8=;
 b=VI8/BOvWogDUGWB+eZ71+4JXrHkQI055T4LIEE51Hl43QP6kA8iOPvEGznkkohRRYbYR
 lNtT5NEp0uDJDHj556pBHJLPI2itDA4BECMEj9wuEx0+ApwiY2992ww03YOxhkAk0Gz2
 MwJECunEodEanatJh47EAIZxz3Z8tphG8WzFqeNSoMLE12Zlr7N0t6SkNMRtH3roPaed
 CtiKvCf3pAX9N0qhmAvKDs9iGZKhQMxSFZ3ffOC9thrhWh/x7kLkPB+ulrey4rUHxfOd
 cqvXmswE28B6AF7YHVp1Fy2OJBYJPjzojxGl01tixAZPDtQKkdS5jpqQ/978pcFq5xej EQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3neuwcbbvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 07:03:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31173gfp025851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 07:03:42 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 23:03:40 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3] wifi: cfg80211: call reg_notifier for self managed wiphy from driver hint
Date:   Wed, 1 Feb 2023 02:03:27 -0500
Message-ID: <20230201070327.27578-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JmSdLx13mWrbxOoZPrwRBqcQ8b0s7Mye
X-Proofpoint-ORIG-GUID: JmSdLx13mWrbxOoZPrwRBqcQ8b0s7Mye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=871 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010060
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
ieee80211_channel become finished, so add notify to driver in
reg_process_self_managed_hint() from cfg80211 is a good way, then
driver could get the correct info in callback of reg_notifier.

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v3: use hole for BIT(24) which delete by commit 585b6e1304dc ("wifi: cfg80211: remove support for static WEP") 

v2:
   1. add flag WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER
   2. change to use reg_call_notifier()

 include/net/cfg80211.h | 4 ++++
 net/wireless/reg.c     | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1f8f827290a2..ef96fc5b060d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4682,6 +4682,8 @@ struct cfg80211_ops {
  *	in order to not have them reachable in normal drivers, until we have
  *	complete feature/interface combinations/etc. advertisement. No driver
  *	should set this flag for now.
+ * @WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER: The device could handle reg notify for
+ *	NL80211_REGDOM_SET_BY_DRIVER.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -4707,6 +4709,8 @@ enum wiphy_flags {
 	WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL	= BIT(21),
 	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
+	/* use hole at 24 */
+	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(25),
 };
 
 /**
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4f3f31244e8b..cb35c8e9ced7 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3198,6 +3198,9 @@ static void reg_process_self_managed_hint(struct wiphy *wiphy)
 	request.alpha2[1] = regd->alpha2[1];
 	request.initiator = NL80211_REGDOM_SET_BY_DRIVER;
 
+	if (wiphy->flags & WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER)
+		reg_call_notifier(wiphy, &request);
+
 	nl80211_send_wiphy_reg_change_event(&request);
 }
 

base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
prerequisite-patch-id: e365a8f3f2dda71872409315b416797c771a6c51
-- 
2.31.1

