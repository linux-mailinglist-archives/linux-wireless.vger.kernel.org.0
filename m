Return-Path: <linux-wireless+bounces-30437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A27CFD8DD
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 13:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 704173066302
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB130C62C;
	Wed,  7 Jan 2026 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adWchkGc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1BA30ACE5
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787634; cv=none; b=JkCKinyAtt8ymiHI9eJk2eiBXiy7MkHAteIA0FGiGKye5QCgHZ4dsiZD1djdV9DWUGBm0XG330kpLoIUSrlOdC/R9/uRsZPfI6q3MrYet6RcddqOJ/OYhw101uMVp8Yc7NjPgVftlYcr025usTM56wibvrMHY7Gd3o/vZkju/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787634; c=relaxed/simple;
	bh=vez/n+iZQP8IwqPOvK2OEIHgtEGrAwPNKgHEz7GXqK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uyO0pgb58g7VyhQ5qTnycF0s3NWrIMCL/e2Py41/ugLe+K9XaUApzTE1tN2EoepiNo3q+ADJV9Ih9fcWeVkS7psAqTG49mrF6l+JMp8ordldBI3qpSpCOsVnZ+1gyVLVQN6s5GooeGZHJ2DdOYQMJ+aH6I4oY3Vx5++gcHuqsFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adWchkGc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767787633; x=1799323633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vez/n+iZQP8IwqPOvK2OEIHgtEGrAwPNKgHEz7GXqK8=;
  b=adWchkGc0StwemyECunSnvcJti4Aolb8hwWr8FikebHsksUt0g29BoLo
   nPmj3y3xRWEwBLJhRiAiRTCU06Qrwo/6dNH3BhvPS4D+SnTwAb8BF64Kj
   6X4CoPQJsATNGBgyFlgyEUO/B7tcgXF9decm8SflRCcfNOLvREww1KiMD
   Z8ShrYRx74wnKBL/Y3YJ3jnzh7CE1wniVX00jFh/66GsnvmIHSPNbFmAt
   9wfDvq/ZDMBUtGHlVRQp53YrM9eRPhqTpVMzBkJwOjinucu9k3hhUGxAI
   RU0d8nJLHteHSWMLUdymNKs9DYjjv2XVVrCOTmOGjP3rCWkf/p1iPmHxD
   w==;
X-CSE-ConnectionGUID: vVzzjkH0Qo6kTuvsLSXedw==
X-CSE-MsgGUID: 2q2z/+d6T5O/7E2DMPGkfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69134400"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="69134400"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:07:12 -0800
X-CSE-ConnectionGUID: asESqktdR5iItlfVSC4LgA==
X-CSE-MsgGUID: uwSqrg9vRVqd3WrUA1YxIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="233619493"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:07:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: remove unneeded call to cfg80211_leave
Date: Wed,  7 Jan 2026 14:07:02 +0200
Message-Id: <20260107140630.d8062f337911.I3179a28f237ea3b8ec368af720fbf77455a7763f@changeid>
X-Mailer: git-send-email 2.34.1
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
index 16ccf6fb28b2..da8932a4c72a 100644
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


