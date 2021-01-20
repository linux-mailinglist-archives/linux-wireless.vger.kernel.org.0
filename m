Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7A2FC627
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 01:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbhATAxg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 19:53:36 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:16929 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbhATAxK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 19:53:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611103971; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=21yPvQ9NukAECl9YIlvTFznQDKr6lj9XLEt6heIk10k=; b=okvoCX5lAti2YicZvlTBydmbCZ9pxYO32Si66pfKxNvSVBBJPPHpahM7QZuhtpBs+NhhqVvB
 j805SDItuZWRK85rpf23ZqBQ7GVrcGnEURkfIoJT79AtDOcBHaxKGtf02cCAAybId+GHJ1K6
 /bqR1lDDSGHggOhzPxMNyCxFomM=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60077ed43b6dceb13242e99b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Jan 2021 00:52:36
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 08A6CC43461; Wed, 20 Jan 2021 00:52:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DC1BC433CA;
        Wed, 20 Jan 2021 00:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DC1BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH 1/2] nl80211: Commands for FILS discovery and unsolicited broadcast probe response
Date:   Tue, 19 Jan 2021 16:52:28 -0800
Message-Id: <20210120005229.32582-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210120005229.32582-1-alokad@codeaurora.org>
References: <20210120005229.32582-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This change moves the FILS discovery and unsolicited probe response
configurations to new netlink commands instead of during beacon set up.
It allows modification of transmission parameters such as time interval
dynamically.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 include/net/cfg80211.h       |  13 +++--
 include/uapi/linux/nl80211.h |  12 +++++
 net/wireless/nl80211.c       | 102 ++++++++++++++++++++---------------
 net/wireless/rdev-ops.h      |  24 +++++++++
 net/wireless/trace.h         |  43 +++++++++++++++
 5 files changed, 147 insertions(+), 47 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9a4bbccddc7f..b88d7e69a1e4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1179,8 +1179,6 @@ enum cfg80211_ap_settings_flags {
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
- * @fils_discovery: FILS discovery transmission parameters
- * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1211,8 +1209,6 @@ struct cfg80211_ap_settings {
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
-	struct cfg80211_fils_discovery fils_discovery;
-	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 };
 
 /**
@@ -3972,6 +3968,9 @@ struct mgmt_frame_regs {
  *	This callback may sleep.
  * @reset_tid_config: Reset TID specific configuration for the peer, for the
  *	given TIDs. This callback may sleep.
+ * @set_fils_discovery: Set FILS discovery transmission parameters.
+ * @set_unsol_bcast_probe_resp: Set unsolicited broadcast probe response
+ *	transmission parameters.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4299,6 +4298,12 @@ struct cfg80211_ops {
 				    const u8 *peer, u8 tids);
 	int	(*set_sar_specs)(struct wiphy *wiphy,
 				 struct cfg80211_sar_specs *sar);
+	int     (*set_fils_discovery)(struct wiphy *wiphy,
+				      struct net_device *dev,
+				      struct cfg80211_fils_discovery *params);
+	int	(*set_unsol_bcast_probe_resp)(struct wiphy *wiphy,
+					      struct net_device *dev,
+					      struct cfg80211_unsol_bcast_probe_resp *params);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 40832d13c2f1..f78ba0e7e9a1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1182,6 +1182,14 @@
  *	passed using %NL80211_ATTR_SAR_SPEC. %NL80211_ATTR_WIPHY is used to
  *	specify the wiphy index to be applied to.
  *
+ * @NL80211_CMD_SET_FILS_DISCOVERY: Set FILS discovery transmission parameters.
+ *	Inputs to the command are provided using the attribute
+ *	%NL80211_ATTR_FILS_DISCOVERY.
+ *
+ * @NL80211_CMD_SET_UNSOL_BCAST_PROBE_RESP: Set unsolicited broadcast
+ *	probe response transmission parameters. Inputs to the command are
+ *	provided using the attribute %NL80211_ATTR_UNSOL_BCAST_PROBE_RESP.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1414,6 +1422,10 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_SAR_SPECS,
 
+	NL80211_CMD_SET_FILS_DISCOVERY,
+
+	NL80211_CMD_SET_UNSOL_BCAST_PROBE_RESP,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 775d0c4d86c3..c2689642e9be 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -387,9 +387,10 @@ static const struct nla_policy
 nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
 	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
 	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
-	NLA_POLICY_RANGE(NLA_BINARY,
-			 NL80211_FILS_DISCOVERY_TMPL_MIN_LEN,
-			 IEEE80211_MAX_DATA_LEN),
+	[NL80211_FILS_DISCOVERY_ATTR_TMPL] =
+			NLA_POLICY_RANGE(NLA_BINARY,
+					 NL80211_FILS_DISCOVERY_TMPL_MIN_LEN,
+					 IEEE80211_MAX_DATA_LEN),
 };
 
 static const struct nla_policy
@@ -5015,19 +5016,24 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 	return 0;
 }
 
-static int nl80211_parse_fils_discovery(struct cfg80211_registered_device *rdev,
-					struct nlattr *attrs,
-					struct cfg80211_ap_settings *params)
+static int nl80211_set_fils_discovery(struct sk_buff *skb,
+				      struct genl_info *info)
 {
 	struct nlattr *tb[NL80211_FILS_DISCOVERY_ATTR_MAX + 1];
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_fils_discovery fd = { 0 };
 	int ret;
-	struct cfg80211_fils_discovery *fd = &params->fils_discovery;
 
-	if (!wiphy_ext_feature_isset(&rdev->wiphy,
-				     NL80211_EXT_FEATURE_FILS_DISCOVERY))
-		return -EINVAL;
+	if (!rdev->ops->set_fils_discovery ||
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_FILS_DISCOVERY)) {
+		return -EOPNOTSUPP;
+	}
 
-	ret = nla_parse_nested(tb, NL80211_FILS_DISCOVERY_ATTR_MAX, attrs,
+	ret = nla_parse_nested(tb, NL80211_FILS_DISCOVERY_ATTR_MAX,
+			       info->attrs[NL80211_ATTR_FILS_DISCOVERY],
 			       NULL, NULL);
 	if (ret)
 		return ret;
@@ -5037,30 +5043,35 @@ static int nl80211_parse_fils_discovery(struct cfg80211_registered_device *rdev,
 	    !tb[NL80211_FILS_DISCOVERY_ATTR_TMPL])
 		return -EINVAL;
 
-	fd->tmpl_len = nla_len(tb[NL80211_FILS_DISCOVERY_ATTR_TMPL]);
-	fd->tmpl = nla_data(tb[NL80211_FILS_DISCOVERY_ATTR_TMPL]);
-	fd->min_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_ATTR_INT_MIN]);
-	fd->max_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_ATTR_INT_MAX]);
+	fd.tmpl_len = nla_len(tb[NL80211_FILS_DISCOVERY_ATTR_TMPL]);
+	fd.tmpl = nla_data(tb[NL80211_FILS_DISCOVERY_ATTR_TMPL]);
+	fd.min_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_ATTR_INT_MIN]);
+	fd.max_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_ATTR_INT_MAX]);
 
-	return 0;
+	wdev_lock(wdev);
+	ret = rdev_set_fils_discovery(rdev, dev, &fd);
+	wdev_unlock(wdev);
+	return ret;
 }
 
 static int
-nl80211_parse_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
-				     struct nlattr *attrs,
-				     struct cfg80211_ap_settings *params)
+nl80211_set_unsol_bcast_probe_resp(struct sk_buff *skb, struct genl_info *info)
 {
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_unsol_bcast_probe_resp params = { 0 };
 	struct nlattr *tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX + 1];
 	int ret;
-	struct cfg80211_unsol_bcast_probe_resp *presp =
-					&params->unsol_bcast_probe_resp;
 
-	if (!wiphy_ext_feature_isset(&rdev->wiphy,
+	if (!rdev->ops->set_unsol_bcast_probe_resp ||
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
 				     NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	ret = nla_parse_nested(tb, NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX,
-			       attrs, NULL, NULL);
+			       info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			       NULL, NULL);
 	if (ret)
 		return ret;
 
@@ -5068,9 +5079,14 @@ nl80211_parse_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
 	    !tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL])
 		return -EINVAL;
 
-	presp->tmpl = nla_data(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL]);
-	presp->tmpl_len = nla_len(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL]);
-	presp->interval = nla_get_u32(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT]);
+	params.tmpl = nla_data(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL]);
+	params.tmpl_len = nla_len(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL]);
+	params.interval = nla_get_u32(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT]);
+
+	wdev_lock(wdev);
+	ret = rdev_set_unsol_bcast_probe_resp(rdev, dev, &params);
+	wdev_unlock(wdev);
+
 	return 0;
 }
 
@@ -5384,22 +5400,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
-	if (info->attrs[NL80211_ATTR_FILS_DISCOVERY]) {
-		err = nl80211_parse_fils_discovery(rdev,
-						   info->attrs[NL80211_ATTR_FILS_DISCOVERY],
-						   &params);
-		if (err)
-			goto out;
-	}
-
-	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
-		err = nl80211_parse_unsol_bcast_probe_resp(
-			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
-			&params);
-		if (err)
-			return err;
-	}
-
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
@@ -15704,6 +15704,22 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = NL80211_FLAG_NEED_WIPHY |
 				  NL80211_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL80211_CMD_SET_FILS_DISCOVERY,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_set_fils_discovery,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_NEED_RTNL,
+	},
+	{
+		.cmd = NL80211_CMD_SET_UNSOL_BCAST_PROBE_RESP,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_set_unsol_bcast_probe_resp,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_NEED_RTNL,
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 8b1358d04ca2..ed9bfbebe695 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1358,4 +1358,28 @@ static inline int rdev_set_sar_specs(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int rdev_set_fils_discovery(struct cfg80211_registered_device *rdev,
+					  struct net_device *dev,
+					  struct cfg80211_fils_discovery *params)
+{
+	int ret;
+
+	trace_rdev_set_fils_discovery(&rdev->wiphy, dev, params);
+	ret = rdev->ops->set_fils_discovery(&rdev->wiphy, dev, params);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
+static inline int rdev_set_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
+						  struct net_device *dev,
+						  struct cfg80211_unsol_bcast_probe_resp *params)
+{
+	int ret;
+
+	trace_rdev_set_unsol_bcast_probe_resp(&rdev->wiphy, dev, params);
+	ret = rdev->ops->set_unsol_bcast_probe_resp(&rdev->wiphy, dev, params);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 76b777d5903f..9640e0d3f81e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3565,6 +3565,49 @@ TRACE_EVENT(rdev_set_sar_specs,
 		  WIPHY_PR_ARG, __entry->type, __entry->num)
 );
 
+TRACE_EVENT(rdev_set_fils_discovery,
+	    TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		     struct cfg80211_fils_discovery *params),
+	    TP_ARGS(wiphy, netdev, params),
+	    TP_STRUCT__entry(WIPHY_ENTRY
+			     NETDEV_ENTRY
+			     __field(u32, min_interval)
+			     __field(u32, max_interval)
+			     __field(size_t, tmpl_len)
+	    ),
+	    TP_fast_assign(WIPHY_ASSIGN;
+			   NETDEV_ASSIGN;
+			   __entry->min_interval = params->min_interval;
+			   __entry->max_interval = params->max_interval;
+			   __entry->tmpl_len = params->tmpl_len;
+	    ),
+	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT
+		      ", minimum interval: %u, maximum interval: %u, template length: %zu",
+		      WIPHY_PR_ARG, NETDEV_PR_ARG,
+		      __entry->min_interval, __entry->max_interval,
+		      __entry->tmpl_len)
+);
+
+TRACE_EVENT(rdev_set_unsol_bcast_probe_resp,
+	    TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		     struct cfg80211_unsol_bcast_probe_resp *params),
+	    TP_ARGS(wiphy, netdev, params),
+	    TP_STRUCT__entry(WIPHY_ENTRY
+			     NETDEV_ENTRY
+			     __field(u32, interval)
+			     __field(size_t, tmpl_len)
+	    ),
+	    TP_fast_assign(WIPHY_ASSIGN;
+			   NETDEV_ASSIGN;
+			   __entry->interval = params->interval;
+			   __entry->tmpl_len = params->tmpl_len;
+	    ),
+	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT
+		      ", interval: %u, template length: %zu",
+		      WIPHY_PR_ARG, NETDEV_PR_ARG,
+		      __entry->interval, __entry->tmpl_len)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.0

