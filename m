Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05925291F4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348143AbiEPUtI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348227AbiEPUsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 16:48:07 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824624B1EF
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 13:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652732706; x=1684268706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dLsN9+tMGNSmyxpcHdK1wwe0o/QR5zEeNH6dnF4J+1A=;
  b=eUcgOm4gT0kFh4HU8zSr2DnA6yffiJHi+0fmmJoLUAfZDo7U1BhPDYW2
   Tfy0ZpzYz6qeOX6lkrcfUPstc9t7Pwbl9EiUsMeA3UApQMEQpIT91Ecao
   gRDZQlix/o4Ts77RJYpvlXHM8Y0e0AhJQa3xyueMMqTV4xlcRqcqMXSBL
   A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 May 2022 13:25:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 13:25:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 13:25:05 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 13:25:04 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v5 1/3] cfg80211: additional processing in NL80211_CMD_SET_BEACON
Date:   Mon, 16 May 2022 13:24:52 -0700
Message-ID: <20220516202454.4925-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220516202454.4925-1-quic_alokad@quicinc.com>
References: <20220516202454.4925-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FILS discovery and unsolicited broadcast probe response transmissions
are configured as part of NL80211_CMD_START_AP, however both stop
after userspace uses the NL80211_CMD_SET_BEACON command as these
attributes are not processed in that command.

- Add the missing implementation.
- Modify the local variable in nl80211_set_beacon() and input parameter
to rdev_change_beacon() from type struct cfg80211_beacon_data to
type struct cfg80211_ap_settings to support the new processing.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h  |  2 +-
 net/wireless/nl80211.c  | 28 ++++++++++++++++++----
 net/wireless/rdev-ops.h |  2 +-
 net/wireless/trace.h    | 52 +++++++++++++++++++++++------------------
 4 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 97a5804ccdcf..880ade4a0430 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4200,7 +4200,7 @@ struct cfg80211_ops {
 	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ap_settings *settings);
 	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
-				 struct cfg80211_beacon_data *info);
+				 struct cfg80211_ap_settings *info);
 	int	(*stop_ap)(struct wiphy *wiphy, struct net_device *dev);
 
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 740b29481bc6..e738902a9b99 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5809,7 +5809,8 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct cfg80211_beacon_data params;
+	struct cfg80211_ap_settings *params;
+	struct nlattr *attrs;
 	int err;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
@@ -5822,16 +5823,35 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (!wdev->beacon_interval)
 		return -EINVAL;
 
-	err = nl80211_parse_beacon(rdev, info->attrs, &params);
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	err = nl80211_parse_beacon(rdev, info->attrs, &params->beacon);
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
+		err = nl80211_parse_unsol_bcast_probe_resp(rdev, attrs,	params);
+		if (err)
+			goto out;
+	}
+
 	wdev_lock(wdev);
-	err = rdev_change_beacon(rdev, dev, &params);
+	err = rdev_change_beacon(rdev, dev, params);
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.mbssid_ies);
+	kfree(params->beacon.mbssid_ies);
+	kfree(params);
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

