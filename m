Return-Path: <linux-wireless+bounces-28762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062CC46888
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9683B77C8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2FF31062C;
	Mon, 10 Nov 2025 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iX6I03Hr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D330C36F
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776643; cv=none; b=t0baVT/sXua4q11NMyydc2Uli/IPGITkJYkUECzEbNh+QPmlEflJEOtv9iPTPGzme5OT4R7X0oEQ2ue6ZZ5QKyTTppI3DijH8JpfP5l2T0U2iQTK16+BpP+cl81GJvT405agCejUxlaGvauHBFoLBRdCk0MML/NWz8rar6cGR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776643; c=relaxed/simple;
	bh=zZjXnPG1vp7nFrSh/ITd9Yml4vT/GUuit8TQLZC0LXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2iHgP6rR0lGAAj7b/SXfkiBC6fhAtNSQWxHZ+1gxkvH5/7HI0T6qQL7FBiJwoeXtmXQpK7iLDu6gC0Jkfetqz7GQ2fnb/5WMbG+BlVJwB2k7rip3p7Ae7JkrKCX54fiDP9mpYTKi8xcdEojZuOEqKuuf1JgnHI+l8S3Sac6AyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iX6I03Hr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776641; x=1794312641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZjXnPG1vp7nFrSh/ITd9Yml4vT/GUuit8TQLZC0LXI=;
  b=iX6I03HrMc2RXL8+5Gkv6aqmd59aQ7xOaO6zF4L6LQIxCD7h4EZJtVlf
   LZVqW2VREHuTdH1qneAx6xpfBXaFWWjcm27p1OB9Aty+idokyr+3IBmLu
   ZBs2HOf8em5yqFSA5EbzIyKMBT+yAI5YQlwp8ysjRIQyUONdKFBW6FPQZ
   xgalwPjnd+pOSJ5c0Y4hihqbmzTrHKy4iQS5umZu2xUwU8n7Yi3hSubRG
   /XQyLIldaWQMFBR7+T9yabfzPQ3Dgaee+Tz2PP452D3JaX+I0CrKU6PyH
   VAlkhhYJD7hgyZecroxDQPfVQrPbLgHPzLfQDds8JiNHDCiBaO25H5uBh
   A==;
X-CSE-ConnectionGUID: R9Bnn129SdKp6r9GUcw96w==
X-CSE-MsgGUID: 3CV4DkIrTEGSl6Pvjz1VmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64865010"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64865010"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:10:41 -0800
X-CSE-ConnectionGUID: ZS8o9VH6SWyca+NT4BjXlw==
X-CSE-MsgGUID: 7kBaVcMgQ/OAL5Tj8VPQuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192918071"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:10:39 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/2] wifi: cfg80211/mac80211: Add fallback mechanism for INDOOR_SP connection
Date: Mon, 10 Nov 2025 14:10:30 +0200
Message-Id: <20251110140806.8b43201a34ae.I37fc7bb5892eb9d044d619802e8f2095fde6b296@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110121030.61765-1-miriam.rachel.korenblit@intel.com>
References: <20251110121030.61765-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Implement fallback to LPI mode when SP mode is not permitted
by regulatory constraints for INDOOR_SP connections.
Limit fallback mechanism to client mode.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 9 +++++++--
 net/mac80211/mlme.c    | 3 ++-
 net/wireless/core.h    | 3 ++-
 net/wireless/nl80211.c | 4 ++--
 net/wireless/scan.c    | 7 ++++---
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 17f65a1e22ff..e05d05a87990 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10138,22 +10138,27 @@ static inline int cfg80211_color_change_notify(struct net_device *dev,
 /**
  * cfg80211_6ghz_power_type - determine AP regulatory power type
  * @control: control flags
+ * @client_flags: &enum ieee80211_channel_flags for station mode to enable
+ *	SP to LPI fallback, zero otherwise.
  *
  * Return: regulatory power type from &enum ieee80211_ap_reg_power
  */
 static inline enum ieee80211_ap_reg_power
-cfg80211_6ghz_power_type(u8 control)
+cfg80211_6ghz_power_type(u8 control, u32 client_flags)
 {
 	switch (u8_get_bits(control, IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
 	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
 	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
 		return IEEE80211_REG_LPI_AP;
 	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
 	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
 		return IEEE80211_REG_SP_AP;
 	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
 		return IEEE80211_REG_VLP_AP;
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
+		if (client_flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT)
+			return IEEE80211_REG_LPI_AP;
+		return IEEE80211_REG_SP_AP;
 	default:
 		return IEEE80211_REG_UNSET_AP;
 	}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0859a22e8197..e95484d6e144 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6073,7 +6073,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		he_6ghz_oper = ieee80211_he_6ghz_oper(elems->he_operation);
 		if (he_6ghz_oper)
 			link->conf->power_type =
-				cfg80211_6ghz_power_type(he_6ghz_oper->control);
+				cfg80211_6ghz_power_type(he_6ghz_oper->control,
+							 cbss->channel->flags);
 		else
 			link_info(link,
 				  "HE 6 GHz operation missing (on %d MHz), expect issues\n",
diff --git a/net/wireless/core.h b/net/wireless/core.h
index b6bd7f4d6385..82f343663e8f 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -550,7 +550,8 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 		    bool signal_valid, unsigned long ts);
 
 enum ieee80211_ap_reg_power
-cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len);
+cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len,
+			     u32 client_flags);
 
 #ifdef CONFIG_CFG80211_DEVELOPER_WARNINGS
 #define CFG80211_DEV_WARN_ON(cond)	WARN_ON(cond)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 61d5cc6622b4..a8f5beda32a7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6748,7 +6748,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	beacon_check.relax = true;
 	beacon_check.reg_power =
 		cfg80211_get_6ghz_power_type(params->beacon.tail,
-					     params->beacon.tail_len);
+					     params->beacon.tail_len, 0);
 	if (!cfg80211_reg_check_beaconing(&rdev->wiphy, &params->chandef,
 					  &beacon_check)) {
 		err = -EINVAL;
@@ -6927,7 +6927,7 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	beacon_check.relax = true;
 	beacon_check.reg_power =
 		cfg80211_get_6ghz_power_type(params->beacon.tail,
-					     params->beacon.tail_len);
+					     params->beacon.tail_len, 0);
 	if (!cfg80211_reg_check_beaconing(&rdev->wiphy,
 					  &wdev->links[link_id].ap.chandef,
 					  &beacon_check)) {
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 68c4130d602f..7546647752fd 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2212,7 +2212,8 @@ struct cfg80211_inform_single_bss_data {
 };
 
 enum ieee80211_ap_reg_power
-cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len)
+cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len,
+			     u32 client_flags)
 {
 	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
 	struct ieee80211_he_operation *he_oper;
@@ -2230,13 +2231,13 @@ cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len)
 	if (!he_6ghz_oper)
 		return IEEE80211_REG_UNSET_AP;
 
-	return cfg80211_6ghz_power_type(he_6ghz_oper->control);
+	return cfg80211_6ghz_power_type(he_6ghz_oper->control, client_flags);
 }
 
 static bool cfg80211_6ghz_power_type_valid(const u8 *elems, size_t elems_len,
 					   const u32 flags)
 {
-	switch (cfg80211_get_6ghz_power_type(elems, elems_len)) {
+	switch (cfg80211_get_6ghz_power_type(elems, elems_len, flags)) {
 	case IEEE80211_REG_LPI_AP:
 		return true;
 	case IEEE80211_REG_SP_AP:
-- 
2.34.1


