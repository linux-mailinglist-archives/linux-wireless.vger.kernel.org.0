Return-Path: <linux-wireless+bounces-1405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F535822229
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A652B1C22A6C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41D1640A;
	Tue,  2 Jan 2024 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fk2GYce4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F81642D
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224195; x=1735760195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hJxKPqT34mb+nloSGv4tupzORhnFLRpSU1aBQxc0FdI=;
  b=fk2GYce4patl4nQYhvWwTnYkVgtHKoFGtKgsSix48TogMttA1X1linl5
   L5FyT5C50XcgZwEikPNJptQ612Zkg1UGFJlTc3SqqUnwL+DZTZL1fSWVb
   imjnkFyR4uFF6F28H/JR54BwUn8E1P54qSnq25cHFJLnwEFSJCDxtdYzY
   l+QaBkh0HrMhEE56OP2AXeWpI/ebKM2DnBlar4UazbL7o1x+3RLhJo/33
   AcbWu/Gb7CV7HREUelfwo529bmHOTpYD8hgTEWa5p3ofWcea3Cga9cop0
   aLCpjXlLgYyt8a7jnA3rTZohE3lrulsF6V1hn1GoDfOmMsK+jeubhR6Cu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314332"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314332"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624577"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624577"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:33 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: cfg80211: add support for SPP A-MSDUs
Date: Tue,  2 Jan 2024 21:35:39 +0200
Message-Id: <20240102213313.fadac8df7030.I9240aebcba1be49636a73c647ed0af862713fc6f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add SPP (signaling and payload protected) AMSDU support.

Since userspace has to build the RSNX element, add an extended
feature flag to indicate that this is supported.

In order to avoid downgrade/mismatch attacks, add a flag to the assoc
command on the station side, so that we can be sure that the value of
the flag comes from the same RSNX element that will be validated by
the supplicant against the 4-way-handshake. If we just pulled the
data out of a beacon/probe response, we could theoretically look an
RSNX element from a different frame, with a different value for this
flag, than the supplicant is using to validate in the
4-way-handshake.

Note that this patch is only geared towards software crypto
implementations or hardware ones that can perfectly implement SPP
A-MSDUs, i.e. are able to switch the AAD construction on the fly for
each TX/RX frame.

For more limited hardware implementations, more capability
advertisement  would be required, e.g. if the hardware has no way
to switch this on the fly but has only a global configuration that
must apply to all stations.

The driver could of course *reject* mismatches, but the supplicant
must know so it can do things like not negotiating SPP A-MSDUs on
a T-DLS link when connected to an AP that doesn't support it, or
similar.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h | 14 ++++++++++++++
 net/wireless/nl80211.c       | 24 +++++++++++++++++++++---
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 119eec283d2f..523bc69ba8b6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3059,6 +3059,7 @@ struct cfg80211_assoc_link {
  * @CONNECT_REQ_MLO_SUPPORT: Userspace indicates support for handling MLD links.
  *	Drivers shall disable MLO features for the current association if this
  *	flag is not set.
+ * @ASSOC_REQ_SPP_AMSDU: SPP A-MSDUs will be used on this connection (if any)
  */
 enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_HT			= BIT(0),
@@ -3068,6 +3069,7 @@ enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_HE			= BIT(4),
 	ASSOC_REQ_DISABLE_EHT			= BIT(5),
 	CONNECT_REQ_MLO_SUPPORT			= BIT(6),
+	ASSOC_REQ_SPP_AMSDU			= BIT(7),
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1ccdcae24372..3e239df3528f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2851,6 +2851,10 @@ enum nl80211_commands {
  *      mapping is as defined in section 9.4.2.314 (TID-To-Link Mapping element)
  *      in Draft P802.11be_D4.0.
  *
+ * @NL80211_ATTR_ASSOC_SPP_AMSDU: flag attribute used with
+ *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
+ *	are used on this connection
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3394,6 +3398,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_MLO_TTLM_DLINK,
 	NL80211_ATTR_MLO_TTLM_ULINK,
 
+	NL80211_ATTR_ASSOC_SPP_AMSDU,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3534,6 +3540,7 @@ enum nl80211_iftype {
  * @NL80211_STA_FLAG_ASSOCIATED: station is associated; used with drivers
  *	that support %NL80211_FEATURE_FULL_AP_CLIENT_STATE to transition a
  *	previously added station into associated state
+ * @NL80211_STA_FLAG_SPP_AMSDU: station supports SPP A-MSDUs
  * @NL80211_STA_FLAG_MAX: highest station flag number currently defined
  * @__NL80211_STA_FLAG_AFTER_LAST: internal use
  */
@@ -3546,6 +3553,7 @@ enum nl80211_sta_flags {
 	NL80211_STA_FLAG_AUTHENTICATED,
 	NL80211_STA_FLAG_TDLS_PEER,
 	NL80211_STA_FLAG_ASSOCIATED,
+	NL80211_STA_FLAG_SPP_AMSDU,
 
 	/* keep last */
 	__NL80211_STA_FLAG_AFTER_LAST,
@@ -6520,6 +6528,11 @@ enum nl80211_feature_flags {
  *	DFS master on the same channel as described in FCC-594280 D01
  *	(Section B.3). This, for example, allows P2P GO and P2P clients to
  *	operate on DFS channels as long as there's a concurrent BSS connection.
+ *
+ * @NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT: The driver has support for SPP
+ *	(signaling and payload protected) A-MSDUs and this shall be advertised
+ *	in the RSNXE.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6594,6 +6607,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_OWE_OFFLOAD,
 	NL80211_EXT_FEATURE_OWE_OFFLOAD_AP,
 	NL80211_EXT_FEATURE_DFS_CONCURRENT,
+	NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 60877b532993..5640ac8c72ad 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -821,6 +821,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_BSS_DUMP_INCLUDE_USE_DATA] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
+	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -6873,7 +6874,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
-	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 7);
+	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 8);
 
 	switch (statype) {
 	case CFG80211_STA_MESH_PEER_KERNEL:
@@ -6933,6 +6934,8 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		    params->link_sta_params.he_capa ||
 		    params->link_sta_params.eht_capa)
 			return -EINVAL;
+		if (params->sta_flags_mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
+			return -EINVAL;
 	}
 
 	if (statype != CFG80211_STA_AP_CLIENT &&
@@ -6956,7 +6959,8 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 				  BIT(NL80211_STA_FLAG_ASSOCIATED) |
 				  BIT(NL80211_STA_FLAG_SHORT_PREAMBLE) |
 				  BIT(NL80211_STA_FLAG_WME) |
-				  BIT(NL80211_STA_FLAG_MFP)))
+				  BIT(NL80211_STA_FLAG_MFP) |
+				  BIT(NL80211_STA_FLAG_SPP_AMSDU)))
 			return -EINVAL;
 
 		/* but authenticated/associated only if driver handles it */
@@ -7515,7 +7519,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
-	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 7);
+	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 8);
 
 	switch (dev->ieee80211_ptr->iftype) {
 	case NL80211_IFTYPE_AP:
@@ -7539,6 +7543,11 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		    params.sta_flags_mask & auth_assoc)
 			return -EINVAL;
 
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT) &&
+		    params.sta_flags_mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
+			return -EINVAL;
+
 		/* Older userspace, or userspace wanting to be compatible with
 		 * !NL80211_FEATURE_FULL_AP_CLIENT_STATE, will not set the auth
 		 * and assoc flags in the mask, but assumes the station will be
@@ -11101,6 +11110,15 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		       sizeof(req.s1g_capa));
 	}
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_ASSOC_SPP_AMSDU])) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT)) {
+			GENL_SET_ERR_MSG(info, "SPP A-MSDUs not supported");
+			return -EINVAL;
+		}
+		req.flags |= ASSOC_REQ_SPP_AMSDU;
+	}
+
 	req.link_id = nl80211_link_id_or_invalid(info->attrs);
 
 	if (info->attrs[NL80211_ATTR_MLO_LINKS]) {
-- 
2.34.1


