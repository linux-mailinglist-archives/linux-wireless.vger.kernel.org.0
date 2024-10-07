Return-Path: <linux-wireless+bounces-13588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D496992AED
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750991C22A25
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765B18BB90;
	Mon,  7 Oct 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UR7BuDlb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9B1D2232
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302478; cv=none; b=GoYTs5mU+Bp5U1O2/oy2wFFTuJypkYwBhWy/02k6f/9eQ00++rDP6auj3QZe3k6kp5FkUOMllygcBGav2R4MJ12dgVpsDP9L7lhYQBJgY4WXgBuUZG2Lr6cho/KZIQ63IeSntMNU0OFyspCpmLq66uCiQigb+xbb2ICn9xmaV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302478; c=relaxed/simple;
	bh=8L3VXbNU7J8gryomNFEyhrDMy5cNBvlMYwj6DO+pBDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eAIBMIQ3inojrz/HnjykAWqdaiMmtg6e+wHocHM08iDjljleID4Q8gfgQSt4QAbmAfklAj8LqS19wcRI6mEg288RrPURNPj1YRLBT7YNwZUlQsmASH/b6ryYldd/CxuvykIGHg9IufgKiIhFQenzSpFxjHdyeTQLTRYLoB4PAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UR7BuDlb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302477; x=1759838477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8L3VXbNU7J8gryomNFEyhrDMy5cNBvlMYwj6DO+pBDo=;
  b=UR7BuDlbVOpF9imdQHrUTFE3tmv0CffI3pPpQJaEtJZ/xm7Bk1nhkT9K
   2MbLWYyl27yu4nnOMW4KmhdIiVRB0CySXobnoXuqlxElW1xcGVZOg/7+o
   3De/J00ltuUXXf2R5F5kCxNyRoSxeExJcKtTHoprMwChg79AxNclSWRAA
   1PJ8q7r0meyIfaPcQ0wtyA659m7TdGHmdQXWFf69R7/bFwvMJ61wku2+6
   rzCzrLCExr9yc+hO4MM72/+IyqCCiRN/23YOYmfEjZJReiyByp447UdoQ
   KnSq/dqGXkM6CnLRVqn34LQ0ywUiS9wsV6CEykFhzz4xESQTBDjY20O+z
   A==;
X-CSE-ConnectionGUID: lHO4miVLQb6a4qMm0oOR8w==
X-CSE-MsgGUID: PhLScn/+QUqad0A7tUedoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099375"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099375"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:16 -0700
X-CSE-ConnectionGUID: hCYSrgFhQt62gdgwlRvQDQ==
X-CSE-MsgGUID: fxRZo/VqSu20OhQRRrGk0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019244"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/14] wifi: mac80211: rename IEEE80211_CHANCTX_CHANGE_MIN_WIDTH
Date: Mon,  7 Oct 2024 15:00:47 +0300
Message-Id: <20241007144851.726b5f12ae0c.I3bd9e594c9d2735183ec049a4c7224bd0a9599c9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The name is misleading, this actually indicates that
ieee80211_chanctx_conf::min_def was updated.
Rename it to IEEE80211_CHANCTX_CHANGE_MIN_DEF.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++--
 include/net/mac80211.h                            | 4 ++--
 net/mac80211/chan.c                               | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a327893c6dce..11cd1a8fdd9e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5067,7 +5067,7 @@ void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 		      (changed & ~(IEEE80211_CHANCTX_CHANGE_WIDTH |
 				   IEEE80211_CHANCTX_CHANGE_RX_CHAINS |
 				   IEEE80211_CHANCTX_CHANGE_RADAR |
-				   IEEE80211_CHANCTX_CHANGE_MIN_WIDTH)),
+				   IEEE80211_CHANCTX_CHANGE_MIN_DEF)),
 		      "Cannot change PHY. Ref=%d, changed=0x%X\n",
 		      phy_ctxt->ref, changed))
 		return;
@@ -5075,7 +5075,7 @@ void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 	guard(mvm)(mvm);
 
 	/* we are only changing the min_width, may be a noop */
-	if (changed == IEEE80211_CHANCTX_CHANGE_MIN_WIDTH) {
+	if (changed == IEEE80211_CHANCTX_CHANGE_MIN_DEF) {
 		if (phy_ctxt->width == def->width)
 			return;
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 479b61fdfb96..752c0abd6c83 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -213,7 +213,7 @@ struct ieee80211_low_level_stats {
  * @IEEE80211_CHANCTX_CHANGE_RADAR: radar detection flag changed
  * @IEEE80211_CHANCTX_CHANGE_CHANNEL: switched to another operating channel,
  *	this is used only with channel switching with CSA
- * @IEEE80211_CHANCTX_CHANGE_MIN_WIDTH: The min required channel width changed
+ * @IEEE80211_CHANCTX_CHANGE_MIN_DEF: The min chandef changed
  * @IEEE80211_CHANCTX_CHANGE_AP: The AP channel definition changed, so (wider
  *	bandwidth) OFDMA settings need to be changed
  * @IEEE80211_CHANCTX_CHANGE_PUNCTURING: The punctured channel(s) bitmap
@@ -224,7 +224,7 @@ enum ieee80211_chanctx_change {
 	IEEE80211_CHANCTX_CHANGE_RX_CHAINS	= BIT(1),
 	IEEE80211_CHANCTX_CHANGE_RADAR		= BIT(2),
 	IEEE80211_CHANCTX_CHANGE_CHANNEL	= BIT(3),
-	IEEE80211_CHANCTX_CHANGE_MIN_WIDTH	= BIT(4),
+	IEEE80211_CHANCTX_CHANGE_MIN_DEF	= BIT(4),
 	IEEE80211_CHANCTX_CHANGE_AP		= BIT(5),
 	IEEE80211_CHANCTX_CHANGE_PUNCTURING	= BIT(6),
 };
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index cca6d14084d2..4b07bdfdf658 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -409,7 +409,7 @@ _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	if (!ctx->driver_present)
 		return 0;
 
-	return IEEE80211_CHANCTX_CHANGE_MIN_WIDTH;
+	return IEEE80211_CHANCTX_CHANGE_MIN_DEF;
 }
 
 static void ieee80211_chan_bw_change(struct ieee80211_local *local,
-- 
2.34.1


