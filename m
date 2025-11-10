Return-Path: <linux-wireless+bounces-28761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7817C46882
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473D63B5B62
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5A13128C0;
	Mon, 10 Nov 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClobGom/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B33101DC
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776641; cv=none; b=gYUsDHPrYuw7oBS3tnvqPtB/gP3htPwMU5ivdWNl/obzu4+bl2P6V+dIlGWHGGQf40dz+JSl0QOvyd5wQA36SN5AXxo2hAYEYhMBT1DqBghFq0ilEzVtXY2w14nvZLXV8cM2NdxGWApnEPOcoLgFJv4AIDXEolgbptiFIlOGosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776641; c=relaxed/simple;
	bh=oQphPQ094nK+RvRdy5ZRePdiPPtsUX4vQGGpbTF9qRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oneQBuV61QY4y0aT/Cr7az06ORuWIWeLpzwKe4RWRylTd1Hu54h8L7q3Z64PtX6hAuQT7NE/jD1McHy+xPyImmybyG5c2uwxhVuNDha6+9DmrQEJYE2jo1gyv4ue20TixHb1Mb6lRKZfdKn7bVvZGyU3Tf8bnbK643l2brCzEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClobGom/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776640; x=1794312640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oQphPQ094nK+RvRdy5ZRePdiPPtsUX4vQGGpbTF9qRY=;
  b=ClobGom/dlsf0rlr8VDkniCrE5ytnYHaNoGO73hTFPnp0H7kdV1uNj/m
   HS1k7wLQsTW6GPqwswykYajdngG6PCshswsxFc1SmLqXY2MKxMfncd9Gj
   9qKuqfTYu9EwICOwZcoS8lLmRyww61s/g1FRDXL1rfo9PXE3pHzUUBxZT
   l3RW+iIyp4TAz+f67kgGWCSY54igurBJZeZxe+9IGDTdZPzdkqU+A6y3C
   uAw2FUuiAMXxv06D6YIQTkuUfs0Qee9nqwfdi8qjCsdkbPa5zHS8ATVZX
   1wuN6Xs4CH+miy35X4R9ALr0z2uW/wA2Mpm1Mgu+ZRcKjZ+Gn6YURrPa1
   A==;
X-CSE-ConnectionGUID: 71Aqtbr9RPmJkTaUNxTKnA==
X-CSE-MsgGUID: mO7ep37tS9yfi7/o793Wkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64865008"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64865008"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:10:39 -0800
X-CSE-ConnectionGUID: EqJVfnWMRSmFoc8Ld8iohA==
X-CSE-MsgGUID: ci6TWtH6RE2jH9IEVwuJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192918065"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:10:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: cfg80211/mac80211: clean up duplicate ap_power handling
Date: Mon, 10 Nov 2025 14:10:29 +0200
Message-Id: <20251110140806.959948da1cb5.I893b5168329fb3232f249c182a35c99804112da6@changeid>
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

Move duplicated ap_power type handling code to an inline
function in cfg80211.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 24 ++++++++++++++++++++++++
 net/mac80211/mlme.c    | 20 +-------------------
 net/wireless/scan.c    | 15 +--------------
 3 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f2e8963cfaac..17f65a1e22ff 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10135,6 +10135,30 @@ static inline int cfg80211_color_change_notify(struct net_device *dev,
 					 0, 0, link_id);
 }
 
+/**
+ * cfg80211_6ghz_power_type - determine AP regulatory power type
+ * @control: control flags
+ *
+ * Return: regulatory power type from &enum ieee80211_ap_reg_power
+ */
+static inline enum ieee80211_ap_reg_power
+cfg80211_6ghz_power_type(u8 control)
+{
+	switch (u8_get_bits(control, IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
+	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
+		return IEEE80211_REG_LPI_AP;
+	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
+		return IEEE80211_REG_SP_AP;
+	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
+		return IEEE80211_REG_VLP_AP;
+	default:
+		return IEEE80211_REG_UNSET_AP;
+	}
+}
+
 /**
  * cfg80211_links_removed - Notify about removed STA MLD setup links.
  * @dev: network device.
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 767804e41a34..0859a22e8197 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6031,24 +6031,6 @@ ieee80211_determine_our_sta_mode_assoc(struct ieee80211_sub_if_data *sdata,
 			       conn->bw_limit, tmp.bw_limit);
 }
 
-static enum ieee80211_ap_reg_power
-ieee80211_ap_power_type(u8 control)
-{
-	switch (u8_get_bits(control, IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
-	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
-		return IEEE80211_REG_LPI_AP;
-	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
-		return IEEE80211_REG_SP_AP;
-	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
-		return IEEE80211_REG_VLP_AP;
-	default:
-		return IEEE80211_REG_UNSET_AP;
-	}
-}
-
 static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_link_data *link,
 				  int link_id,
@@ -6091,7 +6073,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		he_6ghz_oper = ieee80211_he_6ghz_oper(elems->he_operation);
 		if (he_6ghz_oper)
 			link->conf->power_type =
-				ieee80211_ap_power_type(he_6ghz_oper->control);
+				cfg80211_6ghz_power_type(he_6ghz_oper->control);
 		else
 			link_info(link,
 				  "HE 6 GHz operation missing (on %d MHz), expect issues\n",
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 90a9187a6b13..68c4130d602f 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2230,20 +2230,7 @@ cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len)
 	if (!he_6ghz_oper)
 		return IEEE80211_REG_UNSET_AP;
 
-	switch (u8_get_bits(he_6ghz_oper->control,
-			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
-	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
-		return IEEE80211_REG_LPI_AP;
-	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
-		return IEEE80211_REG_SP_AP;
-	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
-		return IEEE80211_REG_VLP_AP;
-	default:
-		return IEEE80211_REG_UNSET_AP;
-	}
+	return cfg80211_6ghz_power_type(he_6ghz_oper->control);
 }
 
 static bool cfg80211_6ghz_power_type_valid(const u8 *elems, size_t elems_len,
-- 
2.34.1


