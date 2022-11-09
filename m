Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45AA623607
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 22:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKIVrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 16:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKIVrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 16:47:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449A2FFD6
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 13:47:34 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9KpQwd032656;
        Wed, 9 Nov 2022 21:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=GVSzhcud1BHq+qG6ompyfVaphw6KgRq1mDtzR0nUvQM=;
 b=oTR34nkFOZW9I+9dh/vynQPUnqSeHiCs+G5AL7ne0IGlbMuzc2BZxN8hHTlcZm4zzqG0
 l8jnTfHqb0/FQMLPgQKgLbrh+goKKMYW7Kv47hsTxPIizWlES4T8562hxIiyW0/5A17k
 P+K+kbH/hf9NI3ANFcMC3crjz41iM2pem3tXn7u2IMEITVFwt4isEufoYSpEzWGTq/qp
 2t+3t5Xid/ynYO8yVYvzDEFssC46WdHjGluAksSdUVbPKYRzSkevSPXJLqmuZ+Yd5YoW
 wpTaA+CZQ8l8HR0haGrtYtpU3lMSqi61KMClDNrjqlVKE6vXS1tcBSFGblN7ns53Oi5k 9Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3krgbr0r1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 21:47:31 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A9LlUZA018258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 21:47:30 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 9 Nov 2022 13:47:30 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v7 2/3] nl80211: additional processing in NL80211_CMD_SET_BEACON
Date:   Wed, 9 Nov 2022 13:47:19 -0800
Message-ID: <20221109214720.6097-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109214720.6097-1-quic_alokad@quicinc.com>
References: <20221109214720.6097-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VbDBboDVoW2W9O64pHqO_yI6erkokF7-
X-Proofpoint-ORIG-GUID: VbDBboDVoW2W9O64pHqO_yI6erkokF7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211090164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FILS discovery and unsolicited broadcast probe response transmissions
are configured as part of NL80211_CMD_START_AP, however both stop
after userspace uses the NL80211_CMD_SET_BEACON command as these
attributes are not processed in that command.
Add the missing implementation.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 net/wireless/nl80211.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4b0b02fc822c..95de9e006444 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6069,6 +6069,7 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_ap_settings *params;
+	struct nlattr *attrs;
 	int err;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
@@ -6089,6 +6090,20 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out;
 
+	attrs = info->attrs[NL80211_ATTR_FILS_DISCOVERY];
+	if (attrs) {
+		err = nl80211_parse_fils_discovery(rdev, attrs, params);
+		if (err)
+			goto out;
+	}
+
+	attrs = info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP];
+	if (attrs) {
+		err = nl80211_parse_unsol_bcast_probe_resp(rdev, attrs, params);
+		if (err)
+			goto out;
+	}
+
 	wdev_lock(wdev);
 	err = rdev_change_beacon(rdev, dev, params);
 	wdev_unlock(wdev);
-- 
2.17.1

