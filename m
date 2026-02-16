Return-Path: <linux-wireless+bounces-31899-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG5GHT6Sk2lu6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31899-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD4147CFD
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB63C300678D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227929C325;
	Mon, 16 Feb 2026 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAWxROeU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C9299923
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278906; cv=none; b=VYEdf8L3ZA4EgwOMVhWAglJpdNn7w9pBHRT69Nyqm07mnui7uE+xqN62B3xYMNMdrBSG57qtEbQf6z9vE39gp/sSETw7pPU92xnQDS/KSCgTn1VJr1ivWj39gPCAWi1xS+p0HtieY1N9cl8sCvmiKB542z3ncOH7MkJKmTlyZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278906; c=relaxed/simple;
	bh=cOn8MnPitilbm9RqWvdVtH2x36d2TQrkvmhT2FnKhJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbPlQ1pAZ6SUkWw6M7zmaSzZgVGLMpVn1JqeRF9wGh5I9RSEQxYX0aiUYxfka+96hSqfgi/vtefVzir7VgloMByj7I3J4+98tcZ3FiBtfHjWut5iSlC0dGdJNcRt7Z8BTk3cAThxTzwYjbRqnRjtG6lMOSEFmwR56AAqhN2jdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAWxROeU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771278905; x=1802814905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cOn8MnPitilbm9RqWvdVtH2x36d2TQrkvmhT2FnKhJo=;
  b=EAWxROeUBq/DTC7ZIebfjN9nTQUffs08lz4qBcvbMZ6IGtrR70i8Km2S
   CfH729yO3ZJM1+SOMVnAH14Ctg1OF7daFfk6btbH+CManSDE3fnyclW4U
   Nb6v7LCoor6PRnTT6QjxYOO3iVm18lG9v3w3fbfZ0oWABozulZFd+yWnv
   +Owe53Qaqer/x7Vl3Kbl/LqePLFM35rxUycom5nbdavBmGX5oIp4Y9DDV
   j6sLK2BWHjArtJaiy/Wv7HWOJWPcbSUg3rrMDD+zDJUmJv35z8IW6GgtH
   PWU6tTRVI8srk7SYL87QOqMVaDVrAV6Nx6pIsvF0TvlQ4m18hh/cRNdLp
   A==;
X-CSE-ConnectionGUID: vprOuRNAR06Nlkr5Zvo1tw==
X-CSE-MsgGUID: uWEvrMAuTzqLc1fXUpQhmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="75980282"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="75980282"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:05 -0800
X-CSE-ConnectionGUID: BgPHmQr4SUa9GDKzbt8aOQ==
X-CSE-MsgGUID: iKnTx1XsRuqR0GcuLp0cOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213547279"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: nl80211: refactor nl80211_parse_chandef
Date: Mon, 16 Feb 2026 23:54:38 +0200
Message-Id: <20260216234830.2b994566a63b.I6c2b6f4c7e2e09f4c47285ca4ac8a37b20700e19@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
References: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31899-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03AD4147CFD
X-Rspamd-Action: no action

In order to be able to use this function also for nested attributes,
change this function to receive a pointer to extack and to the
attributes array, instead of receiving the info and extracting them out
of it.
While at it, use NL_SET_ERR_MSG_ATTR with the frequency of the chandef.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c | 67 ++++++++++++++++++++++++------------------
 net/wireless/nl80211.h |  5 ++--
 net/wireless/pmsr.c    |  5 ++--
 3 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6e58b238a1f8..f638c04aa51e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3568,11 +3568,10 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
 }
 
 static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
-				  struct genl_info *info, bool monitor,
+				  struct netlink_ext_ack *extack,
+				  struct nlattr **attrs, bool monitor,
 				  struct cfg80211_chan_def *chandef)
 {
-	struct netlink_ext_ack *extack = info->extack;
-	struct nlattr **attrs = info->attrs;
 	u32 control_freq;
 
 	if (!attrs[NL80211_ATTR_WIPHY_FREQ]) {
@@ -3582,10 +3581,10 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 	}
 
 	control_freq = MHZ_TO_KHZ(
-			nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ]));
-	if (info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET])
+			nla_get_u32(attrs[NL80211_ATTR_WIPHY_FREQ]));
+	if (attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET])
 		control_freq +=
-		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
+		    nla_get_u32(attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
 
 	memset(chandef, 0, sizeof(*chandef));
 	chandef->chan = ieee80211_get_channel_khz(&rdev->wiphy, control_freq);
@@ -3656,40 +3655,43 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			attrs[NL80211_ATTR_S1G_PRIMARY_2MHZ]);
 	}
 
-	if (info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]) {
+	if (attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]) {
 		chandef->edmg.channels =
-		      nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]);
+		      nla_get_u8(attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]);
 
-		if (info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG])
+		if (attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG])
 			chandef->edmg.bw_config =
-		     nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG]);
+		     nla_get_u8(attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG]);
 	} else {
 		chandef->edmg.bw_config = 0;
 		chandef->edmg.channels = 0;
 	}
 
-	if (info->attrs[NL80211_ATTR_PUNCT_BITMAP]) {
+	if (attrs[NL80211_ATTR_PUNCT_BITMAP]) {
 		chandef->punctured =
-			nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]);
+			nla_get_u32(attrs[NL80211_ATTR_PUNCT_BITMAP]);
 
 		if (chandef->punctured &&
 		    !wiphy_ext_feature_isset(&rdev->wiphy,
 					     NL80211_EXT_FEATURE_PUNCT)) {
-			NL_SET_ERR_MSG(extack,
-				       "driver doesn't support puncturing");
+			NL_SET_ERR_MSG_ATTR(extack,
+					    attrs[NL80211_ATTR_WIPHY_FREQ],
+					    "driver doesn't support puncturing");
 			return -EINVAL;
 		}
 	}
 
 	if (!cfg80211_chandef_valid(chandef)) {
-		NL_SET_ERR_MSG(extack, "invalid channel definition");
+		NL_SET_ERR_MSG_ATTR(extack, attrs[NL80211_ATTR_WIPHY_FREQ],
+				    "invalid channel definition");
 		return -EINVAL;
 	}
 
 	if (!_cfg80211_chandef_usable(&rdev->wiphy, chandef,
 				      IEEE80211_CHAN_DISABLED,
 				      monitor ? IEEE80211_CHAN_CAN_MONITOR : 0)) {
-		NL_SET_ERR_MSG(extack, "(extension) channel is disabled");
+		NL_SET_ERR_MSG_ATTR(extack, attrs[NL80211_ATTR_WIPHY_FREQ],
+				    "(extension) channel is disabled");
 		return -EINVAL;
 	}
 
@@ -3704,10 +3706,11 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 }
 
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
-			  struct genl_info *info,
+			  struct netlink_ext_ack *extack,
+			  struct nlattr **attrs,
 			  struct cfg80211_chan_def *chandef)
 {
-	return _nl80211_parse_chandef(rdev, info, false, chandef);
+	return _nl80211_parse_chandef(rdev, extack, attrs, false, chandef);
 }
 
 static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
@@ -3734,7 +3737,7 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 		link_id = 0;
 	}
 
-	result = _nl80211_parse_chandef(rdev, info,
+	result = _nl80211_parse_chandef(rdev, info->extack, info->attrs,
 					iftype == NL80211_IFTYPE_MONITOR,
 					&chandef);
 	if (result)
@@ -6812,7 +6815,8 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &params->chandef);
+		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+					    &params->chandef);
 		if (err)
 			goto out;
 	} else if (wdev->valid_links) {
@@ -11288,7 +11292,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (dfs_region == NL80211_DFS_UNSET)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
 	if (err)
 		return err;
 
@@ -11376,7 +11380,7 @@ static int nl80211_notify_radar_detection(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
 	if (err) {
 		GENL_SET_ERR_MSG(info, "Unable to extract chandef info");
 		return err;
@@ -11562,7 +11566,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		goto free;
 
 skip_beacons:
-	err = nl80211_parse_chandef(rdev, info, &params.chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+				    &params.chandef);
 	if (err)
 		goto free;
 
@@ -12783,7 +12788,8 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 		ibss.ie_len = nla_len(info->attrs[NL80211_ATTR_IE]);
 	}
 
-	err = nl80211_parse_chandef(rdev, info, &ibss.chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+				    &ibss.chandef);
 	if (err)
 		return err;
 
@@ -13782,7 +13788,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	    duration > rdev->wiphy.max_remain_on_channel_duration)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
 	if (err)
 		return err;
 
@@ -13998,7 +14004,8 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	 */
 	chandef.chan = NULL;
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &chandef);
+		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+					    &chandef);
 		if (err)
 			return err;
 	}
@@ -14401,7 +14408,8 @@ static int nl80211_join_ocb(struct sk_buff *skb, struct genl_info *info)
 	struct ocb_setup setup = {};
 	int err;
 
-	err = nl80211_parse_chandef(rdev, info, &setup.chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+				    &setup.chandef);
 	if (err)
 		return err;
 
@@ -14476,7 +14484,8 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 		cfg.auto_open_plinks = false;
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &setup.chandef);
+		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+					    &setup.chandef);
 		if (err)
 			return err;
 	} else {
@@ -16955,7 +16964,7 @@ static int nl80211_tdls_channel_switch(struct sk_buff *skb,
 	    !info->attrs[NL80211_ATTR_OPER_CLASS])
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
 	if (err)
 		return err;
 
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index 5e25782af1e0..048ba92c3e42 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Portions of this file
- * Copyright (C) 2018, 2020-2024 Intel Corporation
+ * Copyright (C) 2018, 2020-2025 Intel Corporation
  */
 #ifndef __NET_WIRELESS_NL80211_H
 #define __NET_WIRELESS_NL80211_H
@@ -23,7 +23,8 @@ static inline u64 wdev_id(struct wireless_dev *wdev)
 }
 
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
-			  struct genl_info *info,
+			  struct netlink_ext_ack *extack,
+			  struct nlattr **attrs,
 			  struct cfg80211_chan_def *chandef);
 int nl80211_parse_random_mac(struct nlattr **attrs,
 			     u8 *mac_addr, u8 *mac_addr_mask);
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 60e1e31c2185..7c154f94e78a 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2018 - 2021, 2023 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2021, 2023 - 2026 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include "core.h"
@@ -237,7 +237,8 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 	if (err)
 		return err;
 
-	err = nl80211_parse_chandef(rdev, info, &out->chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+				    &out->chandef);
 	if (err)
 		return err;
 
-- 
2.34.1


