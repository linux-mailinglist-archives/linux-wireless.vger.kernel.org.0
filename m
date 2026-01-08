Return-Path: <linux-wireless+bounces-30527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D7D03E8F
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31D19300F19D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BC936BCD2;
	Thu,  8 Jan 2026 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIeLYmxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B07DA66
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861375; cv=none; b=MrKLUN3RXStuClAPDuQO+5J9sND/EfjtS3qK0gM/2rxKuc6EMP3HmZXXZNWfgr4pENm+TXzp8hnRjDu6oAlbheLtWoLRRALHLorq66qDhdTPyNhnAUu9IqC0cgYbi3giDXUtwmpuazDhrE3Y/SEz9zMGwRyD8bToLQAxz+24/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861375; c=relaxed/simple;
	bh=O20smBY6toT43f5FIowgR6pQq+vFJzt+b3rma7Ez5SE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H69g6AOD+ONZZ8X2mOmAjuoXC8++eYNlu4mdsLHW1hjRkotKi82AkTr9ch6hD6Rp31TQtrBTiR4xb/dI+je+0Yt1Ei7SYNrdlVbJKdBKOKKqv/UI11nN/vvmD5Xbjk7lMuB5csRLW8YXHBPCTEBRdLJqDXarDmRLvNKxeJrVymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIeLYmxt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861366; x=1799397366;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=O20smBY6toT43f5FIowgR6pQq+vFJzt+b3rma7Ez5SE=;
  b=gIeLYmxtIRiCAOwBbtzkymg1AzWQa1OLikN+8WT3N5UoAOZ3A3uTpcuc
   CvRLvaJq9XJ8j+FC7LCQJVay05/QXrR2CGASr01iw/u9A6OwbdTqAolYt
   3XvVVNF1/EkIBTDV8/rgXuOJCRPYCbC700ti2rTAaJfxdBvErCuXn162O
   MW0wa+hQMd9xn5cJjNSK1IP2SPSzbygraH2yp9L8yxM8pviFpTkSCNxrL
   lCKKav+n/yeZ3isdPr4+xGX+MEbuvV4WKCEZuhOBpgw9IIkJ8yWiXrTaD
   QKy3s1g1kgZQpBpn0pHurbhdOktBxLY7lgWbzWh0i/gvKxScPzpq410Di
   A==;
X-CSE-ConnectionGUID: gxFCeo9/Qzmu0Q3i6N9cCg==
X-CSE-MsgGUID: hwAo9heHRL6MNoAkZ/6mwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084786"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:56 -0800
X-CSE-ConnectionGUID: vHPdYNToQ0CUJITnsA8i2A==
X-CSE-MsgGUID: thga9ICeT42dfZd3nhKL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847459"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next v2 04/14] wifi: cfg80211: refactor wiphy_suspend
Date: Thu,  8 Jan 2026 10:35:30 +0200
Message-Id: <20260108102921.00336669ac32.Id76f272662e1315cd93a628808cc2d1625036b00@changeid>
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


