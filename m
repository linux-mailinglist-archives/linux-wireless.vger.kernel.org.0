Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22A4792530
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 18:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjIEQBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 12:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353588AbjIEGtW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 02:49:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8321B4
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 23:49:19 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3855uKbl030567;
        Tue, 5 Sep 2023 06:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=fS9ZJ3WL/YRDUoJpohAuHboVSPppS5sFzM54T5A7wdo=;
 b=MskrhDvD3wb3U1U8PL1lhLRWpmF6uVeS88M2yLqYIdYa68GxcKPAltJXGAw4QVbGxXl+
 aL+Vh3oj9gnP0UIffrpZTKA/F/W3xqKkBOcGEI1wqgIAuIXq/SXTEeydJx2a5I1BMSCK
 N+Uco5HYmhfJFsbneR8ERLLo+syFbiXPTruHAIulAEuuKOjkWm4T09PZlCV7QZs97p/o
 yL30gTjzW8uBrBVQ83jyuqyXx/Yk05Gt79uPKlsYuhAABBgvqNjxVvYzZqx74F79pOkh
 h8g7hgA8qBBARDpBz2MPSXqR7bYfaBSQxw6ZXwsPegBoX7mm2pKtqgiIf/ywa5ZIgC6F hQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvcrcx1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 06:49:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3856nFP5001728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 06:49:15 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 4 Sep 2023 23:49:13 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: cfg80211: validate AP phy operation before starting it
Date:   Tue, 5 Sep 2023 12:18:57 +0530
Message-ID: <20230905064857.1503-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WTEQJ1YrvNgAP7nplT4rrDXR7OIq6P4Q
X-Proofpoint-ORIG-GUID: WTEQJ1YrvNgAP7nplT4rrDXR7OIq6P4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_05,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Many regulatories can have HE/EHT Operation as not permitted. In such
cases, AP should not be allowed to start if it is using a channel
having the no operation flag set. However, currently there is no such
check in place.

Fix this issue by validating such IEs sent during start AP against the
channel flags.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/wireless/nl80211.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index de47838aca4f..0c989a839e56 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5909,6 +5909,21 @@ static void nl80211_send_ap_started(struct wireless_dev *wdev,
 	nlmsg_free(msg);
 }
 
+static int nl80211_validate_ap_phy_operation(struct cfg80211_ap_settings *params)
+{
+	struct ieee80211_channel *channel = params->chandef.chan;
+
+	if ((params->he_cap ||  params->he_oper) &&
+	    (channel->flags & IEEE80211_CHAN_NO_HE))
+		return -EOPNOTSUPP;
+
+	if ((params->eht_cap || params->eht_oper) &&
+	    (channel->flags & IEEE80211_CHAN_NO_EHT))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -6178,6 +6193,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out_unlock;
 
+	err = nl80211_validate_ap_phy_operation(params);
+	if (err)
+		goto out_unlock;
+
 	if (info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS])
 		params->flags = nla_get_u32(
 			info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS]);

base-commit: dae4464939025d38940a6bc6b80734adad0ff944
-- 
2.17.1

