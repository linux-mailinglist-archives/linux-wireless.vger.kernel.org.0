Return-Path: <linux-wireless+bounces-19879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABD2A5482E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E723ACBC6
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D2204C28;
	Thu,  6 Mar 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBXSccsB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A020551E
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257826; cv=none; b=TK8dlr7lD2SuIkQF3wHG3YsB/4NgJSP8D2texD/AVXA2rX49Fs5axtiVLybieMDlSJChSFljVFzihhF6tCdQY4OvLPGteof2BVpbW3edVNoLj7E748tsLWXzqluVFLLZgX3Pwd6NPN2NABmT2ZKAF6WkmO1o7/b0OgYv96EcPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257826; c=relaxed/simple;
	bh=3pPY+UCmsD0lXw/itTAdWe36yJau6QzEUgGLGb30UaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANtSweMknmHquO1AfrmAJC7lTuj4DY7Mp05ifNDBe6ujLQuGSL0q8hI/Tt7yesQPEQ1+JP9NNyfSLQ3MXdoVh3NJyCIn8xe+fSC6aBKsq9cmjGBoS39IoyOuwFxM4gOJowqFonJOhdD4KKAcsDM5liMdwKAb52izveylet8Mf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBXSccsB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257825; x=1772793825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3pPY+UCmsD0lXw/itTAdWe36yJau6QzEUgGLGb30UaY=;
  b=CBXSccsB3d/rHUuZsdTi2NXSQB/rOgBxpVq8g1tIEH8nqYGsmPeFPaaC
   oGtex2bzaKLPdDRtTLifxynVvCt12Lj++cddTi3WyPs9q2c9SSz35dd+r
   4oJyKhV+7I7iE0V+IPtheWRg7Q1W4XnexePaLikrfwu7V9x9e+jUI+uXR
   KGYa833pfmnLfTcuL7TR/7yquy395p4UfdFV3AILaXtLEALE8uNTiUOrX
   hGrnKXFu3L3L3UXCWwnwgoji1TVZi801dNIxoJxT5sFtIMpZ2Y00UlIl6
   k12k1GScBUkHsg9BzDnTHZWqZ8XAmM5fFKoWX0j2DKYDWdRLpMjPcUYiB
   Q==;
X-CSE-ConnectionGUID: srB42do4S2uzEzMnNp8I2Q==
X-CSE-MsgGUID: cUOF5NC0Q1WrjsqECT1FDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844478"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844478"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:45 -0800
X-CSE-ConnectionGUID: b2rRILJzRIGHHdBBLRLeGA==
X-CSE-MsgGUID: 7/Di5g94RpyKVjCtf5KXlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797724"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:43 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: cfg80211: allow AP operations in 20 MHz configuration
Date: Thu,  6 Mar 2025 12:43:15 +0200
Message-Id: <20250306124057.a7b909d23df2.I8a8f79e1c9eb74936929463960ee2a324712fe51@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Implemented configuration option for channel properties to allow
soft AP/active scan operations exclusively to 20 MHz bandwidth.
While on it, fixed indentation and kernel doc for
enum nl80211_reg_rule_flags.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  4 +++
 include/uapi/linux/nl80211.h | 52 ++++++++++++++++++++----------------
 net/wireless/chan.c          |  8 +++++-
 net/wireless/nl80211.c       |  4 +++
 net/wireless/reg.c           |  4 ++-
 5 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 29b9cf0fe6c8..9a4a5c20b568 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -127,6 +127,9 @@ struct wiphy;
  *	even if it is otherwise disabled.
  * @IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP: Allow using this channel for AP operation
  *	with very low power (VLP), even if otherwise set to NO_IR.
+ * @IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY: Allow using this channel for
+ *	soft AP operations and active scan in 20 MHz bandwidth,
+ *	even if otherwise set to NO_IR.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED			= BIT(0),
@@ -155,6 +158,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT	= BIT(23),
 	IEEE80211_CHAN_CAN_MONITOR		= BIT(24),
 	IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP	= BIT(25),
+	IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY     = BIT(26),
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c59075acdb10..1cf52bc17ef3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4335,6 +4335,8 @@ enum nl80211_wmm_rule {
  *	otherwise completely disabled.
  * @NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP: This channel can be used for a
  *	very low power (VLP) AP, despite being NO_IR.
+ * @NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY: This channel can be used for
+ *	soft AP operations in 20MHz bandwidth, despite being NO_IR.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4379,6 +4381,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT,
 	NL80211_FREQUENCY_ATTR_CAN_MONITOR,
 	NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP,
+	NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4590,31 +4593,34 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_6GHZ_AFC_CLIENT: Client connection to AFC AP not allowed
  * @NL80211_RRF_ALLOW_6GHZ_VLP_AP: Very low power (VLP) AP can be permitted
  *	despite NO_IR configuration.
+ * @NL80211_RRF_ALLOW_20MHZ_ACTIVITY: Allow soft AP operations in
+ *	20MHz bandwidth, despite NO_IR configuration.
  */
 enum nl80211_reg_rule_flags {
-	NL80211_RRF_NO_OFDM		= 1<<0,
-	NL80211_RRF_NO_CCK		= 1<<1,
-	NL80211_RRF_NO_INDOOR		= 1<<2,
-	NL80211_RRF_NO_OUTDOOR		= 1<<3,
-	NL80211_RRF_DFS			= 1<<4,
-	NL80211_RRF_PTP_ONLY		= 1<<5,
-	NL80211_RRF_PTMP_ONLY		= 1<<6,
-	NL80211_RRF_NO_IR		= 1<<7,
-	__NL80211_RRF_NO_IBSS		= 1<<8,
-	NL80211_RRF_AUTO_BW		= 1<<11,
-	NL80211_RRF_IR_CONCURRENT	= 1<<12,
-	NL80211_RRF_NO_HT40MINUS	= 1<<13,
-	NL80211_RRF_NO_HT40PLUS		= 1<<14,
-	NL80211_RRF_NO_80MHZ		= 1<<15,
-	NL80211_RRF_NO_160MHZ		= 1<<16,
-	NL80211_RRF_NO_HE		= 1<<17,
-	NL80211_RRF_NO_320MHZ		= 1<<18,
-	NL80211_RRF_NO_EHT		= 1<<19,
-	NL80211_RRF_PSD			= 1<<20,
-	NL80211_RRF_DFS_CONCURRENT	= 1<<21,
-	NL80211_RRF_NO_6GHZ_VLP_CLIENT	= 1<<22,
-	NL80211_RRF_NO_6GHZ_AFC_CLIENT	= 1<<23,
-	NL80211_RRF_ALLOW_6GHZ_VLP_AP	= 1<<24,
+	NL80211_RRF_NO_OFDM                 = 1 << 0,
+	NL80211_RRF_NO_CCK                  = 1 << 1,
+	NL80211_RRF_NO_INDOOR               = 1 << 2,
+	NL80211_RRF_NO_OUTDOOR              = 1 << 3,
+	NL80211_RRF_DFS                     = 1 << 4,
+	NL80211_RRF_PTP_ONLY                = 1 << 5,
+	NL80211_RRF_PTMP_ONLY               = 1 << 6,
+	NL80211_RRF_NO_IR                   = 1 << 7,
+	__NL80211_RRF_NO_IBSS               = 1 << 8,
+	NL80211_RRF_AUTO_BW                 = 1 << 11,
+	NL80211_RRF_IR_CONCURRENT           = 1 << 12,
+	NL80211_RRF_NO_HT40MINUS            = 1 << 13,
+	NL80211_RRF_NO_HT40PLUS             = 1 << 14,
+	NL80211_RRF_NO_80MHZ                = 1 << 15,
+	NL80211_RRF_NO_160MHZ               = 1 << 16,
+	NL80211_RRF_NO_HE                   = 1 << 17,
+	NL80211_RRF_NO_320MHZ               = 1 << 18,
+	NL80211_RRF_NO_EHT                  = 1 << 19,
+	NL80211_RRF_PSD                     = 1 << 20,
+	NL80211_RRF_DFS_CONCURRENT          = 1 << 21,
+	NL80211_RRF_NO_6GHZ_VLP_CLIENT      = 1 << 22,
+	NL80211_RRF_NO_6GHZ_AFC_CLIENT      = 1 << 23,
+	NL80211_RRF_ALLOW_6GHZ_VLP_AP       = 1 << 24,
+	NL80211_RRF_ALLOW_20MHZ_ACTIVITY    = 1 << 25,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 9f918b77b40e..4cdb74a3f38c 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -6,7 +6,7 @@
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2018-2024	Intel Corporation
+ * Copyright 2018-2025	Intel Corporation
  */
 
 #include <linux/export.h>
@@ -1497,6 +1497,12 @@ bool cfg80211_reg_check_beaconing(struct wiphy *wiphy,
 	if (cfg->reg_power == IEEE80211_REG_VLP_AP)
 		permitting_flags |= IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP;
 
+	if ((cfg->iftype == NL80211_IFTYPE_P2P_GO ||
+	     cfg->iftype == NL80211_IFTYPE_AP) &&
+	    (chandef->width == NL80211_CHAN_WIDTH_20_NOHT ||
+	     chandef->width == NL80211_CHAN_WIDTH_20))
+		permitting_flags |= IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY;
+
 	return _cfg80211_reg_can_beacon(wiphy, chandef, cfg->iftype,
 					check_no_ir ? IEEE80211_CHAN_NO_IR : 0,
 					permitting_flags);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e2e8c368fbbf..aee49d43cf86 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1235,6 +1235,10 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY) &&
+		    nla_put_flag(msg,
+				 NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 2dd0533e7660..9314f7fcd54b 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -5,7 +5,7 @@
  * Copyright 2008-2011	Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright      2017  Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -1602,6 +1602,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_PSD;
 	if (rd_flags & NL80211_RRF_ALLOW_6GHZ_VLP_AP)
 		channel_flags |= IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP;
+	if (rd_flags & NL80211_RRF_ALLOW_20MHZ_ACTIVITY)
+		channel_flags |= IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY;
 	return channel_flags;
 }
 
-- 
2.34.1


