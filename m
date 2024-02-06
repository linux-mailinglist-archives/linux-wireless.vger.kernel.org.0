Return-Path: <linux-wireless+bounces-3226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F38B84B88F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 15:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BB61F256DA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196581339A0;
	Tue,  6 Feb 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hflc+Ate"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4CD13398A
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231277; cv=none; b=oTt3pQDqLHmkIwp93/AHKsUe+Tluwpp4TdkT0x3W5bVXAKbE+ET5+vGphp/O6hkF1f2vEy5hhElyVeAWR3B1ESZivrB7ELbQaIZlRzaCih8unPFO+1cDBmetynxfbonoLfb5AdBBy869U9j6+ssVseoXwnyWCRSR6Jiyem/Y7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231277; c=relaxed/simple;
	bh=zJWBTDzaEx8JJySRXW5+9wEbode44+aZ8DUhyjcktQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSqxWZRp1CuZPSLJ8YgaPZTxBV2zZ8QwNYGf1ClIjIAK4/RfCjjQVx1K8yXA2miMy2T+Jn+ThMNar9+DRbjrC5AXUEh9Q4yp6sq1Q2iBo1Y01l2eeILTeucew2CstRJNvCBhlF8nB1kMfx5Za0nD9r/UpjU/e1yDJ6As9irik+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hflc+Ate; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707231275; x=1738767275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zJWBTDzaEx8JJySRXW5+9wEbode44+aZ8DUhyjcktQ4=;
  b=hflc+Aten/6WXD/KIYooIzbWthn5MefroJBN4n3h+ubGGIbtnVwVCrHe
   n1B3krGv+0eKCeguTPNMMOGHoaY5nsnXOo7tOii/4bUGCbHucsFw3ZBZ2
   LPA69xs49fkN0AsVrTuZEQmGWaA44exR4pbd0cnhzIDG8xiCSAxIqqew4
   L0nzh29ofLscDdwn7SIk4xRtfDVt50SYMnnBfsDGKiw6QOT38wqySnUXD
   3Wh4aUlEq9F62IYCs1eX8J+ZhMfEL85weOvPhUfaBWboIQoBz3V2HBS+a
   G/GNwdePgb2N8Aep2NHekoiWA+CxUw7TPtwz5ITwVjNYN0ZaYb5G4mYjv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="917811"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="917811"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824197930"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824197930"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/8] wifi: cfg80211: rename UHB to 6 GHz
Date: Tue,  6 Feb 2024 16:54:07 +0200
Message-Id: <20240206164849.c9cfb9400839.I153db3b951934a1d84409c17fbe1f1d1782543fa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

UHB stands for "Ultra High Band", but this term doesn't really
exist in the spec. Rename all occurrences to "6 GHz", but keep
a few defines for userspace API compatibility.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       | 10 +++++-----
 include/uapi/linux/nl80211.h | 31 ++++++++++++++++++++-----------
 net/wireless/nl80211.c       |  8 ++++----
 net/wireless/reg.c           | 10 +++++-----
 net/wireless/scan.c          |  8 ++++----
 5 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 51b9e6fa12f8..bac3d75ccded 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -118,9 +118,9 @@ struct wiphy;
  *	restrictions.
  * @IEEE80211_CHAN_NO_EHT: EHT operation is not permitted on this channel.
  * @IEEE80211_CHAN_DFS_CONCURRENT: See %NL80211_RRF_DFS_CONCURRENT
- * @IEEE80211_CHAN_NO_UHB_VLP_CLIENT: Client connection with VLP AP
+ * @IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT: Client connection with VLP AP
  *	not permitted using this channel
- * @IEEE80211_CHAN_NO_UHB_AFC_CLIENT: Client connection with AFC AP
+ * @IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT: Client connection with AFC AP
  *	not permitted using this channel
  */
 enum ieee80211_channel_flags {
@@ -146,8 +146,8 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_320MHZ	= 1<<19,
 	IEEE80211_CHAN_NO_EHT		= 1<<20,
 	IEEE80211_CHAN_DFS_CONCURRENT	= 1<<21,
-	IEEE80211_CHAN_NO_UHB_VLP_CLIENT= 1<<22,
-	IEEE80211_CHAN_NO_UHB_AFC_CLIENT= 1<<23,
+	IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT = 1<<22,
+	IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT = 1<<23,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
@@ -4913,7 +4913,7 @@ struct cfg80211_ops {
  * enum wiphy_flags - wiphy capability flags
  *
  * @WIPHY_FLAG_SPLIT_SCAN_6GHZ: if set to true, the scan request will be split
- *	 into two, first for legacy bands and second for UHB.
+ *	 into two, first for legacy bands and second for 6 GHz.
  * @WIPHY_FLAG_NETNS_OK: if not set, do not allow changing the netns of this
  *	wiphy at all
  * @WIPHY_FLAG_PS_ON_BY_DEFAULT: if set to true, powersave will be enabled
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 853ac538a686..2af018dfef39 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -11,7 +11,7 @@
  * Copyright 2008 Jouni Malinen <jouni.malinen@atheros.com>
  * Copyright 2008 Colin McCabe <colin@cozybit.com>
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -4268,9 +4268,9 @@ enum nl80211_wmm_rule {
  *	allowed for peer-to-peer or adhoc communication under the control
  *	of a DFS master which operates on the same channel (FCC-594280 D01
  *	Section B.3). Should be used together with %NL80211_RRF_DFS only.
- * @NL80211_FREQUENCY_ATTR_NO_UHB_VLP_CLIENT: Client connection to VLP AP
+ * @NL80211_FREQUENCY_ATTR_NO_6GHZ_VLP_CLIENT: Client connection to VLP AP
  *	not allowed using this channel
- * @NL80211_FREQUENCY_ATTR_NO_UHB_AFC_CLIENT: Client connection to AFC AP
+ * @NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT: Client connection to AFC AP
  *	not allowed using this channel
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
@@ -4312,8 +4312,8 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_EHT,
 	NL80211_FREQUENCY_ATTR_PSD,
 	NL80211_FREQUENCY_ATTR_DFS_CONCURRENT,
-	NL80211_FREQUENCY_ATTR_NO_UHB_VLP_CLIENT,
-	NL80211_FREQUENCY_ATTR_NO_UHB_AFC_CLIENT,
+	NL80211_FREQUENCY_ATTR_NO_6GHZ_VLP_CLIENT,
+	NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4326,6 +4326,10 @@ enum nl80211_frequency_attr {
 #define NL80211_FREQUENCY_ATTR_NO_IR		NL80211_FREQUENCY_ATTR_NO_IR
 #define NL80211_FREQUENCY_ATTR_GO_CONCURRENT \
 					NL80211_FREQUENCY_ATTR_IR_CONCURRENT
+#define NL80211_FREQUENCY_ATTR_NO_UHB_VLP_CLIENT \
+	NL80211_FREQUENCY_ATTR_NO_6GHZ_VLP_CLIENT
+#define NL80211_FREQUENCY_ATTR_NO_UHB_AFC_CLIENT \
+	NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT
 
 /**
  * enum nl80211_bitrate_attr - bitrate attributes
@@ -4516,8 +4520,8 @@ enum nl80211_sched_scan_match_attr {
 	peer-to-peer or adhoc communication under the control of a DFS master
 	which operates on the same channel (FCC-594280 D01 Section B.3).
 	Should be used together with %NL80211_RRF_DFS only.
- * @NL80211_RRF_NO_UHB_VLP_CLIENT: Client connection to VLP AP not allowed
- * @NL80211_RRF_NO_UHB_AFC_CLIENT: Client connection to AFC AP not allowed
+ * @NL80211_RRF_NO_6GHZ_VLP_CLIENT: Client connection to VLP AP not allowed
+ * @NL80211_RRF_NO_6GHZ_AFC_CLIENT: Client connection to AFC AP not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4540,8 +4544,8 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_EHT		= 1<<19,
 	NL80211_RRF_PSD			= 1<<20,
 	NL80211_RRF_DFS_CONCURRENT	= 1<<21,
-	NL80211_RRF_NO_UHB_VLP_CLIENT	= 1<<22,
-	NL80211_RRF_NO_UHB_AFC_CLIENT	= 1<<23,
+	NL80211_RRF_NO_6GHZ_VLP_CLIENT	= 1<<22,
+	NL80211_RRF_NO_6GHZ_AFC_CLIENT	= 1<<23,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
@@ -4550,6 +4554,8 @@ enum nl80211_reg_rule_flags {
 #define NL80211_RRF_NO_HT40		(NL80211_RRF_NO_HT40MINUS |\
 					 NL80211_RRF_NO_HT40PLUS)
 #define NL80211_RRF_GO_CONCURRENT	NL80211_RRF_IR_CONCURRENT
+#define NL80211_RRF_NO_UHB_VLP_CLIENT	NL80211_RRF_NO_6GHZ_VLP_CLIENT
+#define NL80211_RRF_NO_UHB_AFC_CLIENT	NL80211_RRF_NO_6GHZ_AFC_CLIENT
 
 /* For backport compatibility with older userspace */
 #define NL80211_RRF_NO_IR_ALL		(NL80211_RRF_NO_IR | __NL80211_RRF_NO_IBSS)
@@ -5097,14 +5103,17 @@ enum nl80211_bss_use_for {
  *	BSS isn't possible
  * @NL80211_BSS_CANNOT_USE_NSTR_NONPRIMARY: NSTR nonprimary links aren't
  *	supported by the device, and this BSS entry represents one.
- * @NL80211_BSS_CANNOT_USE_UHB_PWR_MISMATCH: STA is not supporting
+ * @NL80211_BSS_CANNOT_USE_6GHZ_PWR_MISMATCH: STA is not supporting
  *	the AP power type (SP, VLP, AP) that the AP uses.
  */
 enum nl80211_bss_cannot_use_reasons {
 	NL80211_BSS_CANNOT_USE_NSTR_NONPRIMARY	= 1 << 0,
-	NL80211_BSS_CANNOT_USE_UHB_PWR_MISMATCH	= 1 << 1,
+	NL80211_BSS_CANNOT_USE_6GHZ_PWR_MISMATCH	= 1 << 1,
 };
 
+#define NL80211_BSS_CANNOT_USE_UHB_PWR_MISMATCH \
+	NL80211_BSS_CANNOT_USE_6GHZ_PWR_MISMATCH
+
 /**
  * enum nl80211_bss - netlink attributes for a BSS
  *
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 68c20409eca6..24d3b01cd000 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1198,11 +1198,11 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_DFS_CONCURRENT) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_DFS_CONCURRENT))
 			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_NO_UHB_VLP_CLIENT) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_UHB_VLP_CLIENT))
+		if ((chan->flags & IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_6GHZ_VLP_CLIENT))
 			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_NO_UHB_AFC_CLIENT) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_UHB_AFC_CLIENT))
+		if ((chan->flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT))
 			goto nla_put_failure;
 	}
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 2741b626919a..50cadbad485f 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -5,7 +5,7 @@
  * Copyright 2008-2011	Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright      2017  Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -1595,10 +1595,10 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_EHT;
 	if (rd_flags & NL80211_RRF_DFS_CONCURRENT)
 		channel_flags |= IEEE80211_CHAN_DFS_CONCURRENT;
-	if (rd_flags & NL80211_RRF_NO_UHB_VLP_CLIENT)
-		channel_flags |= IEEE80211_CHAN_NO_UHB_VLP_CLIENT;
-	if (rd_flags & NL80211_RRF_NO_UHB_AFC_CLIENT)
-		channel_flags |= IEEE80211_CHAN_NO_UHB_AFC_CLIENT;
+	if (rd_flags & NL80211_RRF_NO_6GHZ_VLP_CLIENT)
+		channel_flags |= IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT;
+	if (rd_flags & NL80211_RRF_NO_6GHZ_AFC_CLIENT)
+		channel_flags |= IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT;
 	if (rd_flags & NL80211_RRF_PSD)
 		channel_flags |= IEEE80211_CHAN_PSD;
 	return channel_flags;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 6dd9df347771..663e19678d93 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -5,7 +5,7 @@
  * Copyright 2008 Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2016	Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -2984,9 +2984,9 @@ static bool cfg80211_uhb_power_type_valid(const u8 *ie,
 		case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
 			return true;
 		case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-			return !(flags & IEEE80211_CHAN_NO_UHB_AFC_CLIENT);
+			return !(flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT);
 		case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
-			return !(flags & IEEE80211_CHAN_NO_UHB_VLP_CLIENT);
+			return !(flags & IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT);
 		}
 	}
 	return false;
@@ -3055,7 +3055,7 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 		data->restrict_use = 1;
 		data->use_for = 0;
 		data->cannot_use_reasons =
-			NL80211_BSS_CANNOT_USE_UHB_PWR_MISMATCH;
+			NL80211_BSS_CANNOT_USE_6GHZ_PWR_MISMATCH;
 	}
 
 	if (ext) {
-- 
2.34.1


