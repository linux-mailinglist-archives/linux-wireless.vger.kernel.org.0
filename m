Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E051C635
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiEERjZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 13:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382756AbiEERio (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 13:38:44 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D051052E64
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651772103; x=1683308103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q4TeWetO6A5HiDm7bTx+57QsMYPZjQqC6QsCa6rdLKc=;
  b=XFGMYgVWOxq28Oyl6vN4nZBX7lu/HefATa3mYrVXxg/e5/YyYIJAzPBH
   l7wcs4Ugd16mZXOKN4JcV7tJPtYb3rO5xVBJkXwRbY03nXBRAAJMYh1Kf
   sPNC3CR7bxQoAOsfKizFgPrd80R9Py69iCTMp2FupoU//n236RUeVCbZP
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 05 May 2022 10:35:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:35:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:35:03 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:35:02 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 1/2] nl80211: process additional attributes in NL80211_CMD_SET_BEACON
Date:   Thu, 5 May 2022 10:34:48 -0700
Message-ID: <20220505173449.4424-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220505173449.4424-1-quic_alokad@quicinc.com>
References: <20220505173449.4424-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FILS discovery and unsolicited broadcast probe response transmissions
are configured as part of NL80211_CMD_START_AP, however both stop
after userspace issues NL80211_CMD_SET_BEACON command as these
attributes are not processed as part of this command.
Add the missing implementation.

Modify the local variable in nl80211_set_beacon() and input parameter
to rdev_change_beacon() from type struct cfg80211_beacon_data to
type struct cfg80211_ap_settings to support the new processing.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v1:
https://patchwork.kernel.org/project/linux-wireless/patch/20210120005229.32582-2-alokad@codeaurora.org/

 include/net/cfg80211.h  |  2 +-
 net/wireless/nl80211.c  | 24 ++++++++++++++++---
 net/wireless/rdev-ops.h |  2 +-
 net/wireless/trace.h    | 52 +++++++++++++++++++++++------------------
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 68713388b617..b388e5c9beb8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4195,7 +4195,7 @@ struct cfg80211_ops {
 	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ap_settings *settings);
 	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
-				 struct cfg80211_beacon_data *info);
+				 struct cfg80211_ap_settings *info);
 	int	(*stop_ap)(struct wiphy *wiphy, struct net_device *dev);
 
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 945ed87d12e0..ee94ad8cd619 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5799,9 +5799,11 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct cfg80211_beacon_data params;
+	struct cfg80211_ap_settings params;
 	int err;
 
+	memset(&params, 0, sizeof(params));
+
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 		return -EOPNOTSUPP;
@@ -5812,16 +5814,32 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (!wdev->beacon_interval)
 		return -EINVAL;
 
-	err = nl80211_parse_beacon(rdev, info->attrs, &params);
+	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
 	if (err)
 		goto out;
 
+	if (info->attrs[NL80211_ATTR_FILS_DISCOVERY]) {
+		err = nl80211_parse_fils_discovery(rdev,
+						   info->attrs[NL80211_ATTR_FILS_DISCOVERY],
+						   &params);
+		if (err)
+			goto out;
+	}
+
+	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+				rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+				&params);
+		if (err)
+			goto out;
+	}
+
 	wdev_lock(wdev);
 	err = rdev_change_beacon(rdev, dev, &params);
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.mbssid_ies);
+	kfree(params.beacon.mbssid_ies);
 	return err;
 }
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 439bcf52369c..131fbe9c3199 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -162,7 +162,7 @@ static inline int rdev_start_ap(struct cfg80211_registered_device *rdev,
 
 static inline int rdev_change_beacon(struct cfg80211_registered_device *rdev,
 				     struct net_device *dev,
-				     struct cfg80211_beacon_data *info)
+				     struct cfg80211_ap_settings *info)
 {
 	int ret;
 	trace_rdev_change_beacon(&rdev->wiphy, dev, info);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 228079d7690a..97ca10cbbfee 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -597,44 +597,50 @@ TRACE_EVENT(rdev_start_ap,
 
 TRACE_EVENT(rdev_change_beacon,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_beacon_data *info),
+		 struct cfg80211_ap_settings *info),
 	TP_ARGS(wiphy, netdev, info),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
-		__dynamic_array(u8, head, info ? info->head_len : 0)
-		__dynamic_array(u8, tail, info ? info->tail_len : 0)
-		__dynamic_array(u8, beacon_ies, info ? info->beacon_ies_len : 0)
+		__dynamic_array(u8, head, info ? info->beacon.head_len : 0)
+		__dynamic_array(u8, tail, info ? info->beacon.tail_len : 0)
+		__dynamic_array(u8, beacon_ies,
+				info ? info->beacon.beacon_ies_len : 0)
 		__dynamic_array(u8, proberesp_ies,
-				info ? info->proberesp_ies_len : 0)
+				info ? info->beacon.proberesp_ies_len : 0)
 		__dynamic_array(u8, assocresp_ies,
-				info ? info->assocresp_ies_len : 0)
-		__dynamic_array(u8, probe_resp, info ? info->probe_resp_len : 0)
+				info ? info->beacon.assocresp_ies_len : 0)
+		__dynamic_array(u8, probe_resp,
+				info ? info->beacon.probe_resp_len : 0)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		if (info) {
-			if (info->head)
-				memcpy(__get_dynamic_array(head), info->head,
-				       info->head_len);
-			if (info->tail)
-				memcpy(__get_dynamic_array(tail), info->tail,
-				       info->tail_len);
-			if (info->beacon_ies)
+			if (info->beacon.head)
+				memcpy(__get_dynamic_array(head),
+				       info->beacon.head,
+				       info->beacon.head_len);
+			if (info->beacon.tail)
+				memcpy(__get_dynamic_array(tail),
+				       info->beacon.tail,
+				       info->beacon.tail_len);
+			if (info->beacon.beacon_ies)
 				memcpy(__get_dynamic_array(beacon_ies),
-				       info->beacon_ies, info->beacon_ies_len);
-			if (info->proberesp_ies)
+				       info->beacon.beacon_ies,
+				       info->beacon.beacon_ies_len);
+			if (info->beacon.proberesp_ies)
 				memcpy(__get_dynamic_array(proberesp_ies),
-				       info->proberesp_ies,
-				       info->proberesp_ies_len);
-			if (info->assocresp_ies)
+				       info->beacon.proberesp_ies,
+				       info->beacon.proberesp_ies_len);
+			if (info->beacon.assocresp_ies)
 				memcpy(__get_dynamic_array(assocresp_ies),
-				       info->assocresp_ies,
-				       info->assocresp_ies_len);
-			if (info->probe_resp)
+				       info->beacon.assocresp_ies,
+				       info->beacon.assocresp_ies_len);
+			if (info->beacon.probe_resp)
 				memcpy(__get_dynamic_array(probe_resp),
-				       info->probe_resp, info->probe_resp_len);
+				       info->beacon.probe_resp,
+				       info->beacon.probe_resp_len);
 		}
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT, WIPHY_PR_ARG, NETDEV_PR_ARG)
-- 
2.31.1

