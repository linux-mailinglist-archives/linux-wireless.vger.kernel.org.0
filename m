Return-Path: <linux-wireless+bounces-30457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B41C7CFE1C6
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1567330CB108
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EC532BF3A;
	Wed,  7 Jan 2026 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VESckjTP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D232A3FD
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792034; cv=none; b=YIIOx4gUqfTC8Z7fhyrMyQXmlEkIlqZh0mXIUgRtyzsDpZJlPbM8DFzcwGV31NOIo2RlDdtcSvNzW4KI+vhamoyKjA3cJDXQwXvgEuAu3ydXXm5Vo/m0T8LuIn5E5YXxJSAvyHqeykSgLS96GBEy29TmwjKnqXAIj5PkjrLV0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792034; c=relaxed/simple;
	bh=4LbP+GXeLoWKM1rVQghHA4GEc1tJvdH7t2bxoAyUoSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aj1yt/BI6l3eab+91RJT4bOlfVaPnWqKOxoAM+qno7cv62EZwZtrNesR73lsQg3r6GCGtIWT7qXbq8XFTAI4fRg30csqBi1pN2Up7RHJpjLRUqAvXoupV9xG3XF0fV/4Av5sMGEPTSES+MsWMeD++rf/hziepckWSVCdGRSIyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VESckjTP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792033; x=1799328033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4LbP+GXeLoWKM1rVQghHA4GEc1tJvdH7t2bxoAyUoSY=;
  b=VESckjTPXPccMwJQVFBtc3N8mUKrPllaGLkI5zbs0IuOCv10btsXdX80
   g5EQFtgopeyKLLtlY7r667AlZkrNJ2NgmftVZ8wR7denscpNW/LUKz+Ty
   avnS5j7VYWo5o1noVbun7Z19dcM+/AY9ffwc0i26A6phSEf9Ro+ESFS/7
   TvCvYtZ2Qku9sHWOvJoH4XC17L1BJoM6IifwjaqZXnJ1qsbhFi1pXWr5X
   fR8tF1REtMG6eGbya/iR+GrjVfbm62BRQU5KsZVgIiuCM5qLRn2oKVfj7
   TNPuNWXg5AmjUMUwH4D+m/dG40Kdbg3iWpDSxBNMNp7o1NKjNuWEhTX2g
   Q==;
X-CSE-ConnectionGUID: RgT8L3RxR+ikdNJMDe7XYw==
X-CSE-MsgGUID: XHLUcB4FQSmjmRWSKVyO0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576875"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576875"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:33 -0800
X-CSE-ConnectionGUID: xxJPAWpsRNGw9aH8/fbnPQ==
X-CSE-MsgGUID: +3aFAmZ1TQyNHP8xB1Zcbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185816"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:31 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 15/15] wifi: cfg80211: allow protected action frame TX for NAN
Date: Wed,  7 Jan 2026 15:20:03 +0200
Message-Id: <20260107150057.f83dc16ac3d1.I16000c3e1e2bbc320457db1ac728d789bb2f36c6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
References: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Allow transmitting protected dual of public action frames on
NAN device and NAN data interfaces, since NAN action frames
may be protected and can be sent on both.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/mlme.c    | 9 +++++++--
 net/wireless/nl80211.c | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 903a3dc59007..5db2caf9f3ab 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2009, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2015		Intel Deutschland GmbH
- * Copyright (C) 2019-2020, 2022-2025 Intel Corporation
+ * Copyright (C) 2019-2020, 2022-2026 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -933,12 +933,17 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			 * cfg80211 doesn't track the stations
 			 */
 			break;
+		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_NAN_DATA:
+			if (mgmt->u.action.category !=
+			    WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION)
+				err = -EOPNOTSUPP;
+			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 			/*
 			 * fall through, P2P device only supports
 			 * public action frames
 			 */
-		case NL80211_IFTYPE_NAN:
 		default:
 			err = -EOPNOTSUPP;
 			break;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9d8738e895c6..b0061b3fd438 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14021,6 +14021,7 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_P2P_DEVICE:
 		break;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		if (!wiphy_ext_feature_isset(wdev->wiphy,
 					     NL80211_EXT_FEATURE_SECURE_NAN) &&
 		    !(wdev->wiphy->nan_capa.flags &
@@ -14084,6 +14085,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_P2P_GO:
 		break;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		if (!wiphy_ext_feature_isset(wdev->wiphy,
 					     NL80211_EXT_FEATURE_SECURE_NAN) &&
 		    !(wdev->wiphy->nan_capa.flags &
-- 
2.34.1


