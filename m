Return-Path: <linux-wireless+bounces-30439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5823CFD965
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 13:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B50DD3046F9C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE1F30F545;
	Wed,  7 Jan 2026 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBOYVXZ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524282E9ED6
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787985; cv=none; b=Haa3eTi6wo6P4Tu82w3f3YdKziTK2HAJC5YR76VwJ2pvMXcdGnsNObqAcB3ilfsGPwg961jeUM2XsnmqWm7+4JaRJxZcvhfsxglNgNttRlSdgjAWiqDAIlvF6+pBbC1HloSw+hK4NQ/xUbVVU1umWf0ppR7AjORBX6VnwYIfJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787985; c=relaxed/simple;
	bh=O20smBY6toT43f5FIowgR6pQq+vFJzt+b3rma7Ez5SE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EX3Il6zoCLFAHE7cz7jJ8lKXt0+OKRk7kiNb4XR46bMD1psJ0z1zySx6ykBB1NKxN/cQ4jH0soB8gP+e7p0mtmkYiCokraMqt/Hxkj2CEDlST6ptyZKwZ7F5HaN9fGCGNWGCxaTu0sVRmiaMfnsMrUgGlzyMAzRIGaB+OhbCB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBOYVXZ7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767787984; x=1799323984;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O20smBY6toT43f5FIowgR6pQq+vFJzt+b3rma7Ez5SE=;
  b=BBOYVXZ7XeEpNKbCQRZKS1re0usBE7o+CRLR1bo7dy6Udq/B3ejdyhGQ
   gWInQv4nBeKNmmPogD6Go0pvvyPjE0i80M+g/gtTr9pns+BnImKekO+Wr
   IZxn6WsMuNEwDDwpo60DjQGEb+lRCucB0QZvkL174VbBd8NtefPYXH/OB
   sfivFfO0WG1LS9Lu8MKqmPz9ldaS3SuxnJImUVNUXsGJjvNQZtP4p8Bp6
   EzLxitOhow4xaGlx+DkFO2cxvCBVrr4JWsk//4EwJJAan+GxklEhJYhtb
   lkpgy9e0wZuFcUR9N/83ZHZkrv2p2A4RsF+YIikUtSuuOLpheMuaRCZ+z
   g==;
X-CSE-ConnectionGUID: DalqUVSuSSaHi93w0R9wZA==
X-CSE-MsgGUID: eUGHnyiUT4qFMcGI4k9NGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73003596"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="73003596"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:13:04 -0800
X-CSE-ConnectionGUID: +Q+b6guiTjGLaFviqrTsgQ==
X-CSE-MsgGUID: pB1pcAg6Qciav1gc3Gv6Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="207387821"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:13:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next] wifi: cfg80211: refactor wiphy_suspend
Date: Wed,  7 Jan 2026 14:12:54 +0200
Message-Id: <20260107141131.061651212ea5.Id76f272662e1315cd93a628808cc2d1625036b00@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The sequence of operations that needs to be done in wiphy_suspend is
identical for the case where there is no wowlan configured, and for the
case that it is but the driver refused to do wowlan (by returning 1 from
rdev_suspend).

The current code duplicates this set of operations for each one of the
cases.

In particular, next patch will change the locking of cfg80211_leave_all to
not hold the wiphy lock, which will be easier to do if it is not called
twice.

Change the code to handle first the case that wowlan is configured, and
then handle both cases (driver refused to do wowlan and no wowlan
configured) in one place.

Note that this changes the behaviour to set suspended=true also when
we were not registered yet, but that makes sense anyway, as wiphy works
can be queued also before registration.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/sysfs.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 8d142856e385..77762938edb8 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -99,26 +99,31 @@ static int wiphy_suspend(struct device *dev)
 	rdev->suspend_at = ktime_get_boottime_seconds();
 
 	rtnl_lock();
+	if (!rdev->wiphy.registered)
+		goto out_unlock_rtnl;
+
 	wiphy_lock(&rdev->wiphy);
-	if (rdev->wiphy.registered) {
-		if (!rdev->wiphy.wowlan_config) {
-			cfg80211_leave_all(rdev);
-			cfg80211_process_rdev_events(rdev);
-		}
+	if (rdev->wiphy.wowlan_config) {
 		cfg80211_process_wiphy_works(rdev, NULL);
 		if (rdev->ops->suspend)
 			ret = rdev_suspend(rdev, rdev->wiphy.wowlan_config);
-		if (ret == 1) {
-			/* Driver refuse to configure wowlan */
-			cfg80211_leave_all(rdev);
-			cfg80211_process_rdev_events(rdev);
-			cfg80211_process_wiphy_works(rdev, NULL);
-			ret = rdev_suspend(rdev, NULL);
-		}
-		if (ret == 0)
-			rdev->suspended = true;
+		if (ret <= 0)
+			goto out_unlock_wiphy;
 	}
+
+	/* Driver refused to configure wowlan (ret = 1) or no wowlan */
+
+	cfg80211_leave_all(rdev);
+	cfg80211_process_rdev_events(rdev);
+	cfg80211_process_wiphy_works(rdev, NULL);
+	if (rdev->ops->suspend)
+		ret = rdev_suspend(rdev, NULL);
+
+out_unlock_wiphy:
 	wiphy_unlock(&rdev->wiphy);
+out_unlock_rtnl:
+	if (ret == 0)
+		rdev->suspended = true;
 	rtnl_unlock();
 
 	return ret;
-- 
2.34.1


