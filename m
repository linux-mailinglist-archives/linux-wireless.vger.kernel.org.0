Return-Path: <linux-wireless+bounces-30522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8366D03E50
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7805230BCDF3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E82DB797;
	Thu,  8 Jan 2026 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCChwfTq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28945336EC7
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861362; cv=none; b=tRIPY9IKQmDTSXHZFc/7BgKzRqddZN8KiiPkkTiG+oyXdYz0VmSWWx9CVvixV/HGvPbQvvfSpco+f7SozBT1wWhePXSa3+7saQDsT5BiUedxHpYZVDc4PufOS3XrvjrCP/mgWyLsih+bH71Dq0eA7l8OLx3d7JkU/Dyqfyb5sRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861362; c=relaxed/simple;
	bh=/+NNDGvx3BgebdBA1+spx4n+GB5li5vWepZbreiZ4Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+kXqnBY7f4pK4xUT7WJGI9ehtk8Kgl2w/N+W0oNOiaXVnKX7FYvxURyzaQbvaNhCJjhrHXNSUoPFXuhm5dl2nPAla/VipZMlgO3U3J5hY3sQ7QfnuR5SyJhAt6/n3hTfeoO4iFSQDrUfAe34lhtk6tmr8INtYiz7jJR1N0hxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCChwfTq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861356; x=1799397356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+NNDGvx3BgebdBA1+spx4n+GB5li5vWepZbreiZ4Ro=;
  b=JCChwfTqZc6KGONJyjlX+bT65s0p4TfzlXblbacuaPAbiBkb7E+WTvOG
   uHW2ehEGUvJS3KHDEmcvzJF0S4QxgV3LEu9wEJbGfBHOFQw32KQt/aNlO
   /Ke2AeK6YHOQCyZb+58sURzF5EeY5PvhCz9vkLn6Ez4qT46cK3Sh/5idN
   wRiMk8SrkK/eOJTOUVqXCuXUyN/p18V+rw8T65fH3kXDrkedM+CUGaA6u
   5W0c3g3RX/32X7uSAMmB/ZvsN3tshypnTb9K+XWa8VrIRiSG62vg430in
   qakkp+6tDeo/XFOS3lATNM8FTj5KSotNu+CyCTD/8jcd9u8NobdfycQCV
   g==;
X-CSE-ConnectionGUID: WrN/EooxQjyaZsoKjayqig==
X-CSE-MsgGUID: JnqQf0u0R2W4kmQxdxZF7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084781"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084781"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:53 -0800
X-CSE-ConnectionGUID: e325cB1+R0SiD04WI2JJmQ==
X-CSE-MsgGUID: 8bLmxy7XSUe3LY1KBaLsLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847454"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:51 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v2 02/14] wifi: cfg80211: remove unneeded call to cfg80211_leave
Date: Thu,  8 Jan 2026 10:35:28 +0200
Message-Id: <20260108102921.ef89316bb31f.I3179a28f237ea3b8ec368af720fbf77455a7763f@changeid>
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

In cfg80211_destroy_ifaces, we first close all netdev wdevs, which will
trigger a NETDEV_GOING_DOWN event that will call cfg80211_leave,
and for non-netdev wdevs, we call cfg80211_remove_virtual_intf which
calles cfg80211_unregister_wdev, which handles the "leaving" for those
interfaces (i.e. stop_nan and stop_p2p_device)

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9a420d627d3c..e53e486b1449 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -347,7 +347,6 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 
 			guard(wiphy)(&rdev->wiphy);
 
-			cfg80211_leave(rdev, wdev);
 			cfg80211_remove_virtual_intf(rdev, wdev);
 		}
 	}
-- 
2.34.1


