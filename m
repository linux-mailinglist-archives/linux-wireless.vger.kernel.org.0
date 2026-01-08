Return-Path: <linux-wireless+bounces-30530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDBFD02B01
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 13:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B09153036DD6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95556378D6C;
	Thu,  8 Jan 2026 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoewsFyy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C9344044
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861387; cv=none; b=Mp1xbwDfDn2I/WSaoeLjS07hBIA4ij92zgHXBl5bRm9PLtVFKwb5I6Yfa+PRwUmndmYbZH9hu+gUrtM2SlnElm7griR0nNcAWopoqmdUoctz9GyxUH5E6F61aIelAmwqfe78+9Em0ETvOYYh/cxxcaxZkCeT5izfC4YLEhqeEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861387; c=relaxed/simple;
	bh=oFjjC8XoJFkHJmU+TkNWWyMmTXMSN6LEtdLbikzjFLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lpobww2ESwkLoMC1gAjLe0RLOe6YxI9Ty7kjpcXd0N0LiV146RRoTzRFsrUq9LYqSA6zbgzmrtkIX1jIAZ5MhnGvvDdXT39b0sIYn3xREwvdd93tiW/6vs8claT5uf0taXrrqfdVabDaYxxwoLPzwnh4KvdVxRetubg6x9aDzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoewsFyy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861379; x=1799397379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFjjC8XoJFkHJmU+TkNWWyMmTXMSN6LEtdLbikzjFLY=;
  b=PoewsFyyIav8t0soG9pceFG0+Gjt3Ev/PpsYXTn9XS770w8/JofYrUbp
   iuPumyqQMrC0i4UT12OHz1mb0I37HLZsrhCPf4TjDtJFlyjdkgwU9wsoF
   vkNQyG3q2Z/kCXuNzvqX/XQfUhshWJ5oEDXwkyA9G366D9CJ5iCN36LhI
   oOVUzA15a02JGt7mos0cW67TGZN5ntZ8oUw+xn0o6GF4bDj1B5J3j58Wg
   cKKSG8Bj64lxxq6IoUltVi+haNcnLOHLy61QmCOEGxvJcBg7T092+zM8X
   CyO+DHI6suArwDv2i4XbmNPsy678zjGJkaAo+WwG0uwpja30P/TdHf/Mf
   Q==;
X-CSE-ConnectionGUID: PjGbL+4PQhKACxnJE3r4AQ==
X-CSE-MsgGUID: cpHsuH87SqG/NlTJYgtDKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084793"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084793"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:02 -0800
X-CSE-ConnectionGUID: G1MLD7BaQ3CZTDkhWfJCqA==
X-CSE-MsgGUID: DwIUzWiuRba+FdkQkQYFwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847496"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v2 08/14] wifi: cfg80211: make sure NAN chandefs are valid
Date: Thu,  8 Jan 2026 10:35:34 +0200
Message-Id: <20260108102921.51b42ffc9a42.Iacb030fc17027afb55707ca1d6dc146631d55767@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
References: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Until now there was not handling for NAN in reg_wdev_chan_valid.
Now as this wdev might use chandefs, check the validity of those.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/reg.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 73cab51f6379..029499595bdf 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2350,6 +2350,18 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	if (!wdev->netdev || !netif_running(wdev->netdev))
 		return true;
 
+	/* NAN doesn't have links, handle it separately */
+	if (iftype == NL80211_IFTYPE_NAN) {
+		for (int i = 0; i < wdev->u.nan.n_channels; i++) {
+			ret = cfg80211_reg_can_beacon(wiphy,
+						      &wdev->u.nan.chandefs[i],
+						      NL80211_IFTYPE_NAN);
+			if (!ret)
+				return false;
+		}
+		return true;
+	}
+
 	for (link = 0; link < ARRAY_SIZE(wdev->links); link++) {
 		struct ieee80211_channel *chan;
 
@@ -2399,9 +2411,6 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 				continue;
 			chandef = wdev->u.ocb.chandef;
 			break;
-		case NL80211_IFTYPE_NAN:
-			/* we have no info, but NAN is also pretty universal */
-			continue;
 		default:
 			/* others not implemented for now */
 			WARN_ON_ONCE(1);
-- 
2.34.1


