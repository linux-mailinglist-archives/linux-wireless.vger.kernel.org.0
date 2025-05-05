Return-Path: <linux-wireless+bounces-22505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE0EAAA29D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C0B7A500C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67D2DDCF6;
	Mon,  5 May 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0zqI6Mp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284F2DDCEA;
	Mon,  5 May 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483710; cv=none; b=JS/4KNEjurmCYatpqDkGRkH5PNo/SL+N3tWiRGCsqNlgEImJfGBwj4lwUey4YHlHUXgQklNne5cpbp2Ehw6IbDM0RuuvBHKm6UqaMVWwRk2WovCXDX1oU/qW/OPthCnjKlqfHqQJ0FGta80PByHF+VqAirfFmmBFLXXfBTTyst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483710; c=relaxed/simple;
	bh=wgakAvaOmjyw4aFk1osJl9XNEosqUr7C3pc66bxL+LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cK7IDBPj5aT43uRXHmgLn6lEFcYqF9xVTjhf9VEN7B0urB2fPXsSo+c6SmY3Sv6wTvc32Aoc4/U5C77EbYzo9vFWokg1PLdNG2o3hRZJHAfUZ8ntEm/4BoCITUKYAI5WFTPKow0XjUBZ+1hwV1FVTRLBkI+5T8sFSQt7j5I5DrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0zqI6Mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FBEC4CEED;
	Mon,  5 May 2025 22:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483709;
	bh=wgakAvaOmjyw4aFk1osJl9XNEosqUr7C3pc66bxL+LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0zqI6MpKq9crGxstqeZrROaG4hbTQPnPBt+FRNaUvUyBgB4bp89K2b0au82M3qL2
	 2c4JK9CbUgUmSEu8CtgJDrwsPu9XO86YE5UQP4r4eW2Bzw4qm4S9r+luSlipKb/pOT
	 dl1TwfM69/vV+frj5J3hSycmkIG9pxyG68t4ghw2xwzV2MS2V84k2T2upZG2vhs4Hg
	 6RFLVaLsVWz3G8+WQvID/yRL/lw1rerqsI2u37mZTDjbabyGB1xc3mqCppwfhYfy3l
	 ScQGbd9PXr8etOMTvnOP1fghTH+4jVXIyu+kC+UlQbt2xa5FIOV8ZpXnvZTSWskcLc
	 NEau7TncpejMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 191/642] wifi: cfg80211: allow IR in 20 MHz configurations
Date: Mon,  5 May 2025 18:06:47 -0400
Message-Id: <20250505221419.2672473-191-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

[ Upstream commit cf4bd1608882792d4742e27a819493312904a680 ]

Some regulatory bodies doesn't allow IR (initiate radioation) on a
specific subband, but allows it for channels with a bandwidth of 20 MHz.
Add a channel flag that indicates that, and consider it in
cfg80211_reg_check_beaconing.

While on it, fix the kernel doc of enum nl80211_reg_rule_flags and
change it to use BIT().

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Co-developed-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308225541.d3ab352a73ff.I8a8f79e1c9eb74936929463960ee2a324712fe51@changeid
[fix typo]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h | 52 ++++++++++++++++++++----------------
 net/wireless/chan.c          |  8 +++++-
 net/wireless/nl80211.c       |  4 +++
 net/wireless/reg.c           |  4 ++-
 5 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c168b0e89b79d..b000f6a59a030 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -127,6 +127,8 @@ struct wiphy;
  *	even if it is otherwise disabled.
  * @IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP: Allow using this channel for AP operation
  *	with very low power (VLP), even if otherwise set to NO_IR.
+ * @IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY: Allow activity on a 20 MHz channel,
+ *	even if otherwise set to NO_IR.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED			= BIT(0),
@@ -155,6 +157,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT	= BIT(23),
 	IEEE80211_CHAN_CAN_MONITOR		= BIT(24),
 	IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP	= BIT(25),
+	IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY     = BIT(26),
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f6c1b181c886d..ea30fa455a098 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4327,6 +4327,8 @@ enum nl80211_wmm_rule {
  *	otherwise completely disabled.
  * @NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP: This channel can be used for a
  *	very low power (VLP) AP, despite being NO_IR.
+ * @NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY: This channel can be active in
+ *	20 MHz bandwidth, despite being NO_IR.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4371,6 +4373,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT,
 	NL80211_FREQUENCY_ATTR_CAN_MONITOR,
 	NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP,
+	NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4582,31 +4585,34 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_6GHZ_AFC_CLIENT: Client connection to AFC AP not allowed
  * @NL80211_RRF_ALLOW_6GHZ_VLP_AP: Very low power (VLP) AP can be permitted
  *	despite NO_IR configuration.
+ * @NL80211_RRF_ALLOW_20MHZ_ACTIVITY: Allow activity in 20 MHz bandwidth,
+ *	despite NO_IR configuration.
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
index 9f918b77b40e2..4cdb74a3f38c6 100644
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
index b457fe78672b7..370b668678da0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1234,6 +1234,10 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
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
index 212e9561aae77..c1752b31734fa 100644
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
@@ -1603,6 +1603,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_PSD;
 	if (rd_flags & NL80211_RRF_ALLOW_6GHZ_VLP_AP)
 		channel_flags |= IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP;
+	if (rd_flags & NL80211_RRF_ALLOW_20MHZ_ACTIVITY)
+		channel_flags |= IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY;
 	return channel_flags;
 }
 
-- 
2.39.5


