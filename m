Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A876357E29E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiGVNx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVNxV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 09:53:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA799669
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 06:53:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MDEhob019065;
        Fri, 22 Jul 2022 13:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=tjB4iQEkhBBqLzSqiv3yj1Fdo+3Ub3Ginm5un8RuVJ0=;
 b=E5Baayv1nfLUtf+GUBCYuZnusHM1xIpXC8MiCVQe7iYoKI0BU1YAp4GzWStX35CCWSpu
 FVZRY6aULFT1G+4cXtjKPsXYi80yEroXyHJrWuc17jb8bOMrS3VGObCEwjihquB4yqeH
 P4uFgZFrabkLXay7icv41rkBT1LtTx26gOgH0qiN+BiMlNVYJoa140uchuY0pcVUMnQE
 GhzxM9bVC2TON5Tp1l/y1Q8WPIlquRS6oELZFkV+2lFpFYbwwxZ+qQiUkBW6eNdzCHgj
 FlNFMtebFL3a14rM3t12t5Ifas7hku+7LYAc0GxFcQthRNlhOZdXlDaG50tyCD+t1ukX Og== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hfm47s8dk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 13:53:17 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26MDBuOF027190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 13:11:56 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 06:11:56 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 06:11:54 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] cfg80211: Add link_id to cfg80211_ch_switch_started_notify()
Date:   Fri, 22 Jul 2022 18:41:42 +0530
Message-ID: <20220722131143.3438042-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2kZznEus_ltXbC-te6Vyn0_INnWVhbN0
X-Proofpoint-ORIG-GUID: 2kZznEus_ltXbC-te6Vyn0_INnWVhbN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_04,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add link_id parameter to cfg80211_ch_switch_started_notify() to allow
driver to indicate on which link channel switch started on MLD.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h |  4 +++-
 net/mac80211/cfg.c     |  2 +-
 net/mac80211/mlme.c    |  2 +-
 net/wireless/nl80211.c |  8 ++++++--
 net/wireless/trace.h   | 11 +++++++----
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d5af3a7fc2b4..7b74aa0de04b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8158,6 +8158,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
  * cfg80211_ch_switch_started_notify - notify channel switch start
  * @dev: the device on which the channel switch started
  * @chandef: the future channel definition
+ * @link_id: the link ID for MLO, must be 0 for non-MLO
  * @count: the number of TBTTs until the channel switch happens
  * @quiet: whether or not immediate quiet was requested by the AP
  *
@@ -8167,7 +8168,8 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
  */
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
-				       u8 count, bool quiet);
+				       unsigned int link_id, u8 count,
+				       bool quiet);
 
 /**
  * ieee80211_operating_class_to_band - convert operating class to band
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index fe6500b36953..3d8b7107e8cb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3733,7 +3733,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
-					  &sdata->deflink.csa_chandef,
+					  &sdata->deflink.csa_chandef, 0,
 					  params->count, params->block_tx);
 
 	if (changed) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 912095e4e256..5c15c37d65ff 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1905,7 +1905,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 	mutex_unlock(&local->mtx);
 
-	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chandef,
+	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chandef, 0,
 					  csa_ie.count, csa_ie.mode);
 
 	if (local->ops->channel_switch) {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3580fe2f2f31..42430749913f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18896,13 +18896,17 @@ EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
-				       u8 count, bool quiet)
+				       unsigned int link_id, u8 count,
+				       bool quiet)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	trace_cfg80211_ch_switch_started_notify(dev, chandef);
+	ASSERT_WDEV_LOCK(wdev);
+	WARN_INVALID_LINK_ID(wdev, link_id);
+
+	trace_cfg80211_ch_switch_started_notify(dev, chandef, link_id);
 
 	nl80211_ch_switch_notify(rdev, dev, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 592b9e9e821a..1faf52c19084 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3245,18 +3245,21 @@ TRACE_EVENT(cfg80211_ch_switch_notify,
 
 TRACE_EVENT(cfg80211_ch_switch_started_notify,
 	TP_PROTO(struct net_device *netdev,
-		 struct cfg80211_chan_def *chandef),
-	TP_ARGS(netdev, chandef),
+		 struct cfg80211_chan_def *chandef,
+		 unsigned int link_id),
+	TP_ARGS(netdev, chandef, link_id),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
+		__field(unsigned int, link_id)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
+		__entry->link_id = link_id;
 	),
-	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT,
-		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG)
+	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d",
+		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id)
 );
 
 TRACE_EVENT(cfg80211_radar_event,
-- 
2.25.1

