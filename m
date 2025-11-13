Return-Path: <linux-wireless+bounces-28901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144BC56A55
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 10:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623013BCDB5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829C2C327A;
	Thu, 13 Nov 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJAyto2i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42166330301
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026390; cv=none; b=MMc7xF8rKyae3LU7TA+IvImLB+twqWFYGI4VFMj3xNR4sgbvQVLYSxXbhTFZfGCVoXdhnhWxI4tHtWwh5jWIhoLhDLlF3cONrv1yyTjQMqQ2hPgsYBkf39Pcbk/S0oKpvT3ieq6Il3GQuuvXvn9e/Wfz663tOZPUGTaFdOr7Ty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026390; c=relaxed/simple;
	bh=Drahf6M2g9aJj4P4yc8L1cZ+phSqh09LdFf4laqtZcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJb1V0H9esbNWpckJXEkfLoIIDAc33ynECit/Smo1JZ27YqY+Z2TagWiTlNDuc+/AHBn4KNMn7Z+sJQKEi4v3ziqnESvXMBYYwWSuZwK6YQ/TX4bZMy0hLGNScYPCyzluV0jQdZm4PADhoFJu4+l7MAsvjHWg7aQ7Ms2NzBtNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJAyto2i; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763026389; x=1794562389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Drahf6M2g9aJj4P4yc8L1cZ+phSqh09LdFf4laqtZcQ=;
  b=QJAyto2ipeOVUaRh8pNOEZGTG9MY0apBcVPwQbPZ5dpznOjS9xXYVXN5
   eOZ15CjE5zplKSm45MD6WiO9vU3y2Rq+PqxnJW2H8zraKTFOtUSjjxewh
   Sxry/vYhP3ksR3DhpcFQJ3sqTyVtwd2wImpaXhUtYQVzJcr7RwnFtNJH6
   hA0tdpSN3cqfTh/ct2KtoH91zCHwckoS1CTppaqg+UJMgbXSYF2FsomHP
   KT7tJcX8aRtSaN4op4BKxB2wkq08Lig1v2MrYturwjVZKQhrE11fDaLWX
   GFpvlUjS5oKvN6KPdgNbv+Ta0I2BAzL3umiAP5hxLUiT+dcW1csP9gpci
   A==;
X-CSE-ConnectionGUID: sC3NqBO3SPW4dxmFvUPiyQ==
X-CSE-MsgGUID: ViomVckSRzadCkW+Jy/JEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65028272"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65028272"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 01:33:08 -0800
X-CSE-ConnectionGUID: PKrUwNLQRt2WkSLwiQyTmA==
X-CSE-MsgGUID: ElQc0HeBTlSTX9txgO1/gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="188737143"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 01:33:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/3] wifi: nl80211: refactor nl80211_parse_chandef
Date: Thu, 13 Nov 2025 11:32:57 +0200
Message-Id: <20251113112845.9f5ad1e5e9f5.I6c2b6f4c7e2e09f4c47285ca4ac8a37b20700e19@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113093259.3576302-1-miriam.rachel.korenblit@intel.com>
References: <20251113093259.3576302-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

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
index 29c92bc8291b..c95e64813d35 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3511,11 +3511,10 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
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
@@ -3525,10 +3524,10 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
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
@@ -3599,40 +3598,43 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
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
 
@@ -3647,10 +3649,11 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
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
@@ -3677,7 +3680,7 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 		link_id = 0;
 	}
 
-	result = _nl80211_parse_chandef(rdev, info,
+	result = _nl80211_parse_chandef(rdev, info->extack, info->attrs,
 					iftype == NL80211_IFTYPE_MONITOR,
 					&chandef);
 	if (result)
@@ -6730,7 +6733,8 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &params->chandef);
+		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+					    &params->chandef);
 		if (err)
 			goto out;
 	} else if (wdev->valid_links) {
@@ -11162,7 +11166,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (dfs_region == NL80211_DFS_UNSET)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
 	if (err)
 		return err;
 
@@ -11250,7 +11254,7 @@ static int nl80211_notify_radar_detection(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
 	if (err) {
 		GENL_SET_ERR_MSG(info, "Unable to extract chandef info");
 		return err;
@@ -11436,7 +11440,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		goto free;
 
 skip_beacons:
-	err = nl80211_parse_chandef(rdev, info, &params.chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+				    &params.chandef);
 	if (err)
 		goto free;
 
@@ -12662,7 +12667,8 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 		ibss.ie_len = nla_len(info->attrs[NL80211_ATTR_IE]);
 	}
 
-	err = nl80211_parse_chandef(rdev, info, &ibss.chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+				    &ibss.chandef);
 	if (err)
 		return err;
 
@@ -13658,7 +13664,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	    duration > rdev->wiphy.max_remain_on_channel_duration)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
 	if (err)
 		return err;
 
@@ -13874,7 +13880,8 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	 */
 	chandef.chan = NULL;
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &chandef);
+		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+					    &chandef);
 		if (err)
 			return err;
 	}
@@ -14277,7 +14284,8 @@ static int nl80211_join_ocb(struct sk_buff *skb, struct genl_info *info)
 	struct ocb_setup setup = {};
 	int err;
 
-	err = nl80211_parse_chandef(rdev, info, &setup.chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+				    &setup.chandef);
 	if (err)
 		return err;
 
@@ -14352,7 +14360,8 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 		cfg.auto_open_plinks = false;
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &setup.chandef);
+		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+					    &setup.chandef);
 		if (err)
 			return err;
 	} else {
@@ -16824,7 +16833,7 @@ static int nl80211_tdls_channel_switch(struct sk_buff *skb,
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
index a117f5093ca2..0ebbb26e9aa9 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2018 - 2021, 2023 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2021, 2023 - 2025 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include "core.h"
@@ -221,7 +221,8 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 	if (err)
 		return err;
 
-	err = nl80211_parse_chandef(rdev, info, &out->chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
+				    &out->chandef);
 	if (err)
 		return err;
 
-- 
2.34.1


