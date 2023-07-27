Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F6765AA1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjG0Rl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjG0Rl1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:41:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134D430F4
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:41:22 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RHSlYo013221;
        Thu, 27 Jul 2023 17:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=KPhyRYNAQ1FH9hefXG1lxujlkbm3N96O2JFNt4kE2mc=;
 b=Rj335MYT3/QsE2WIXxa3K0C5+OVaNbecCj01CMID+akIZzTyDnZtZVaEOQYdhrX5pu15
 IPd+qLGISYkYdrVniC0n3LGz44fO4emz5DyJt8UN7C3l9bD2IAXMkpSuUN7SMaMlFFxM
 TYOUaWBchJ4hP4RxTVF/kKo9xzs8jwQ2fLxdSO8/andxWIK36rAqvf8PF7q+3PXu1HsC
 3PE6hvsxXGxiP4aPBHQc0ysF4/S0BDfpQPhmUKhlmZ5Tp1T6CGwRkY/DBSPppByC7uwe
 wBus9H0HTif7enGUYfQaUn6uUeBpRTiSpnHIZ06rGfaX6P3mKvPcv4e1MNxj/vvlXnmg AA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3f5821vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RHfGgd018390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:16 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 10:41:16 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v8 4/5] wifi: nl80211: additions to NL80211_CMD_SET_BEACON
Date:   Thu, 27 Jul 2023 10:40:59 -0700
Message-ID: <20230727174100.11721-5-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: S8QJDpuqCYY3SbjsFu_QcexyrK7JaMq_
X-Proofpoint-ORIG-GUID: S8QJDpuqCYY3SbjsFu_QcexyrK7JaMq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270160
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FILS discovery and unsolicited broadcast probe response templates
need to be updated along with beacon templates in some cases such as
the channel switch operation. Add the missing implementation.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v8: No changes.

 net/wireless/nl80211.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5e087534a12e..bb1ab78d3f27 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6239,6 +6239,7 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_ap_settings *params;
+	struct nlattr *attrs;
 	int err;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
@@ -6260,6 +6261,20 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
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
2.39.0

