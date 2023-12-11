Return-Path: <linux-wireless+bounces-599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F84680BACE
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB951C2097B
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A611700;
	Sun, 10 Dec 2023 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrCSJH9z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5B2106
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213513; x=1733749513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vR+Q3Z5IxYKAiSrH/1AUosBQIQH95qeDi0lhHIqk5xk=;
  b=FrCSJH9zf5PsCzET/Xbadtc+MuuoIpG7q6Xoz2+Fl5+dI8nFA6ut1J7G
   bQkn7H77Z1/kAQ1q5u1aknsPbzPcD6FV0Rl44505FjHJmE3bIOZl5QCP4
   qrlDH6zYfa9koxNp/ENa4kkGEEwfzOU8uGuAxuZsFiMyAbc11KQueGA8w
   NUsmgzWySYN+otb1kdU6bsQ3gb2kvPpoDuY6InNZiYDTxyYHKaYTD2B81
   4QokieoKpzTJa/VUdTMt/7VM6ReemX1IJPTdDjtlUej8McWB9PCeaWGsz
   9IV5d0XrBLFB3U4mtA0wvYkL9LjdgxIIXo2lL44qwPOInJ0m4OCHdDX4w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480745684"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480745684"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748925531"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748925531"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
	Berg@web.codeaurora.org, Johannes <johannes.berg@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 04/14] wifi: cfg80211: Add support for setting TID to link mapping
Date: Mon, 11 Dec 2023 09:05:22 +0200
Message-Id: <20231211085121.da4d56a5f3ff.Iacf88e943326bf9c169c49b728c4a3445fdedc97@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for setting the TID to link mapping for a non-AP MLD
station.

This is useful in cases user space needs to restrict the possible
set of active links, e.g., since it got a BSS Transition Management
request forcing to use only a subset of the valid links etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 18 ++++++++++++++++++
 include/uapi/linux/nl80211.h | 19 ++++++++++++++++++
 net/wireless/nl80211.c       | 37 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 18 ++++++++++++++++++
 net/wireless/trace.h         | 20 +++++++++++++++++++
 5 files changed, 112 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c0d16fbf4aba..bb03e83f873c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1664,6 +1664,21 @@ struct link_station_del_parameters {
 	u32 link_id;
 };
 
+/**
+ * struct cfg80211_ttlm_params: TID to link mapping parameters
+ *
+ * Used for setting a TID to link mapping.
+ *
+ * @dlink: Downlink TID to link mapping, as defined in section 9.4.2.314
+ *     (TID-To-Link Mapping element) in Draft P802.11be_D4.0.
+ * @ulink: Uplink TID to link mapping, as defined in section 9.4.2.314
+ *     (TID-To-Link Mapping element) in Draft P802.11be_D4.0.
+ */
+struct cfg80211_ttlm_params {
+	u16 dlink[8];
+	u16 ulink[8];
+};
+
 /**
  * struct station_parameters - station parameters
  *
@@ -4514,6 +4529,7 @@ struct mgmt_frame_regs {
  * @del_link_station: Remove a link of a station.
  *
  * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
+ * @set_ttlm: set the TID to link mapping.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4873,6 +4889,8 @@ struct cfg80211_ops {
 				    struct link_station_del_parameters *params);
 	int	(*set_hw_timestamp)(struct wiphy *wiphy, struct net_device *dev,
 				    struct cfg80211_set_hw_timestamp *hwts);
+	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
+			    struct cfg80211_ttlm_params *params);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 7d774f6b3454..a31a81911a2d 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1327,6 +1327,11 @@
  *	Multi-Link reconfiguration. %NL80211_ATTR_MLO_LINKS is used to provide
  *	information about the removed STA MLD setup links.
  *
+ * @NL80211_CMD_SET_TID_TO_LINK_MAPPING: Set the TID to Link Mapping for a
+ *      non-AP MLD station. The %NL80211_ATTR_MLO_TTLM_DLINK and
+ *      %NL80211_ATTR_MLO_TTLM_ULINK attributes are used to specify the
+ *      TID to Link mapping for downlink/uplink traffic.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1582,6 +1587,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_LINKS_REMOVED,
 
+	NL80211_CMD_SET_TID_TO_LINK_MAPPING,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2834,6 +2841,15 @@ enum nl80211_commands {
  *	include BSSes that can only be used in restricted scenarios and/or
  *	cannot be used at all.
  *
+ * @NL80211_ATTR_MLO_TTLM_DLINK: Binary attribute specifying the downlink TID to
+ *      link mapping. The length is 8 * sizeof(u16). For each TID the link
+ *      mapping is as defined in section 9.4.2.314 (TID-To-Link Mapping element)
+ *      in Draft P802.11be_D4.0.
+ * @NL80211_ATTR_MLO_TTLM_ULINK: Binary attribute specifying the uplink TID to
+ *      link mapping. The length is 8 * sizeof(u16). For each TID the link
+ *      mapping is as defined in section 9.4.2.314 (TID-To-Link Mapping element)
+ *      in Draft P802.11be_D4.0.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3374,6 +3390,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_BSS_DUMP_INCLUDE_USE_DATA,
 
+	NL80211_ATTR_MLO_TTLM_DLINK,
+	NL80211_ATTR_MLO_TTLM_ULINK,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7dec0027daaa..2faf02895c01 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -819,6 +819,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_MLO_LINK_DISABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_BSS_DUMP_INCLUDE_USE_DATA] = { .type = NLA_FLAG },
+	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
+	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 };
 
 /* policy for the key attributes */
@@ -16258,6 +16260,35 @@ static int nl80211_set_hw_timestamp(struct sk_buff *skb,
 	return rdev_set_hw_timestamp(rdev, dev, &hwts);
 }
 
+static int
+nl80211_set_ttlm(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_ttlm_params params = {};
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+
+	if (wdev->iftype != NL80211_IFTYPE_STATION &&
+	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
+		return -EOPNOTSUPP;
+
+	if (!wdev->connected)
+		return -ENOLINK;
+
+	if (!info->attrs[NL80211_ATTR_MLO_TTLM_DLINK] ||
+	    !info->attrs[NL80211_ATTR_MLO_TTLM_ULINK])
+		return -EINVAL;
+
+	nla_memcpy(params.dlink,
+		   info->attrs[NL80211_ATTR_MLO_TTLM_DLINK],
+		   sizeof(params.dlink));
+	nla_memcpy(params.ulink,
+		   info->attrs[NL80211_ATTR_MLO_TTLM_ULINK],
+		   sizeof(params.ulink));
+
+	return rdev_set_ttlm(rdev, dev, &params);
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -17439,6 +17470,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_SET_TID_TO_LINK_MAPPING,
+		.doit = nl80211_set_ttlm,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 2214a90cf101..2a27a3448759 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1524,4 +1524,22 @@ rdev_set_hw_timestamp(struct cfg80211_registered_device *rdev,
 
 	return ret;
 }
+
+static inline int
+rdev_set_ttlm(struct cfg80211_registered_device *rdev,
+	      struct net_device *dev,
+	      struct cfg80211_ttlm_params *params)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	int ret;
+
+	if (!rdev->ops->set_ttlm)
+		return -EOPNOTSUPP;
+
+	trace_rdev_set_ttlm(wiphy, dev, params);
+	ret = rdev->ops->set_ttlm(wiphy, dev, params);
+	trace_rdev_return_int(wiphy, ret);
+
+	return ret;
+}
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4de710efa47e..1f374c8a17a5 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3979,6 +3979,26 @@ TRACE_EVENT(cfg80211_links_removed,
 		  __entry->link_mask)
 );
 
+TRACE_EVENT(rdev_set_ttlm,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct cfg80211_ttlm_params *params),
+	TP_ARGS(wiphy, netdev, params),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__array(u8, dlink, sizeof(u16) * 8)
+		__array(u8, ulink, sizeof(u16) * 8)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		memcpy(__entry->dlink, params->dlink, sizeof(params->dlink));
+		memcpy(__entry->ulink, params->ulink, sizeof(params->ulink));
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


