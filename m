Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3360725FF0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbjFGMro (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 08:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbjFGMr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04DE1FE9
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 05:47:14 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3579tOKe025124;
        Wed, 7 Jun 2023 12:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=hjl93FyYsrxHo2Q8SJ+Kksrjvu+qUD1t1slqkWFLyRE=;
 b=S0Od132gGPZnCXOFcgcorkcyTQMcCwiaXIRYHv0Jy3nzoqM90CWZtoJUfoyNS94G5leu
 eENWYY5OPLJzCp76fhXKbn75/FzifrI0lxv72ZsFYOIyfKFXeIDAZKrMka4EhePEyUoI
 a9G0k88u4jqLN7Cz/N2uSoKd46qX9b+E5ly50BK65t0QTJ+2HLwbGxayoejr3fwpBCni
 7GstR4icNFl64CrBg2RNk/1uxLqRfM3u2+7VZpLO95OLgO0PF9soGdYhnfY9CY6cBg5i
 BKBZAlaUMCbo/yEpU3xOr2k2/M6Gfk5q3FgHy3v0MQD+ejMNN7giDxhkdhV2oIf1DF8R FA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a7g1uax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 12:47:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357Cl5ji022438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 12:47:05 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 05:47:03 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Aditya Kumar Singh" <quic_adisi@quicinc.com>
Subject: [PATCH 1/3] wifi: cfg80211: export DFS CAC time and usable state helper functions
Date:   Wed, 7 Jun 2023 18:16:45 +0530
Message-ID: <20230607124647.27682-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607124647.27682-1-quic_adisi@quicinc.com>
References: <20230607124647.27682-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MmcXlxVmtjIFT9hZ8cR7_WqQYxlthUpA
X-Proofpoint-ORIG-GUID: MmcXlxVmtjIFT9hZ8cR7_WqQYxlthUpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cfg80211 has cfg80211_chandef_dfs_usable() function to know whether
at least one channel in the chandef is in usable state or not. Also,
cfg80211_chandef_dfs_cac_time() function is there which tells the CAC
time required for the given chandef.

Make these two functions visible to drivers by exporting their symbol
to global list of kernel symbols.

Lower level drivers can make use of these two functions to be aware
if CAC is required on the given chandef and for how long. For example
drivers which maintains the CAC state internally can make use of these.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h | 24 ++++++++++++++++++++++++
 net/wireless/chan.c    |  2 ++
 net/wireless/core.h    | 17 -----------------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..e99e83a7308e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -950,6 +950,30 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 				  const struct cfg80211_chan_def *chandef,
 				  enum nl80211_iftype iftype);
 
+/**
+ * cfg80211_chandef_dfs_usable - checks if chandef is DFS usable and we
+ *				 can/need start CAC on such channel
+ * @wiphy: the wiphy to validate against
+ * @chandef: the channel definition to check
+ *
+ * Return: true if all channels available and at least
+ *	   one channel requires CAC (NL80211_DFS_USABLE)
+ */
+bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
+				 const struct cfg80211_chan_def *chandef);
+
+/**
+ * cfg80211_chandef_dfs_cac_time - get the DFS CAC time (in ms) for given
+ *				   channel definition
+ * @wiphy: the wiphy to validate against
+ * @chandef: the channel definition to check
+ *
+ * Returns: DFS CAC time (in ms) which applies for this channel definition
+ */
+unsigned int
+cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
+			      const struct cfg80211_chan_def *chandef);
+
 /**
  * nl80211_send_chandef - sends the channel definition.
  * @msg: the msg to send channel definition
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 0b7e81db383d..a78a6183d11e 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -666,6 +666,7 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
 
 	return (r1 + r2 > 0);
 }
+EXPORT_SYMBOL(cfg80211_chandef_dfs_usable);
 
 /*
  * Checks if center frequency of chan falls with in the bandwidth
@@ -965,6 +966,7 @@ cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
 
 	return max(t1, t2);
 }
+EXPORT_SYMBOL(cfg80211_chandef_dfs_cac_time);
 
 static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 					u32 center_freq, u32 bandwidth,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 7c61752f6d83..c0eaa4d4f42e 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -462,29 +462,12 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev);
 
 extern struct work_struct cfg80211_disconnect_work;
 
-/**
- * cfg80211_chandef_dfs_usable - checks if chandef is DFS usable
- * @wiphy: the wiphy to validate against
- * @chandef: the channel definition to check
- *
- * Checks if chandef is usable and we can/need start CAC on such channel.
- *
- * Return: true if all channels available and at least
- *	   one channel requires CAC (NL80211_DFS_USABLE)
- */
-bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
-				 const struct cfg80211_chan_def *chandef);
-
 void cfg80211_set_dfs_state(struct wiphy *wiphy,
 			    const struct cfg80211_chan_def *chandef,
 			    enum nl80211_dfs_state dfs_state);
 
 void cfg80211_dfs_channels_update_work(struct work_struct *work);
 
-unsigned int
-cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
-			      const struct cfg80211_chan_def *chandef);
-
 void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev);
 
 int
-- 
2.17.1

