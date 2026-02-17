Return-Path: <linux-wireless+bounces-31934-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCU4In5XlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31934-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB8C14BA55
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 816053030D33
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188771C8634;
	Tue, 17 Feb 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pwf6bIyD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB53324B31
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329396; cv=none; b=XQIYJPtJWi9OWe1d9kXGZPKCV1UK8KAhsgmZHcRFhxrEP6NbhE876fJ8AZ7cbFQDN/v4rCD2ITNr7XehMoUNDsWeD24zAddd3wSL3QyR0+4RE13zkLENxGmy6e8FFJMy5hvDsRCh/jh9cuk9HgpNmabW0U+WJhf9W15bYLcHsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329396; c=relaxed/simple;
	bh=HCcEgZbUZAYJdLBiqZun542rW5HaZpbwzc1IEPxjSLk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2YiSfjFZIsuufoVpCN/irkHgyfDCjutE4b4l9aZCNpFs4dbDHa0YCG6h/P9L2daaaY8QI/rOROT/xMxc/xBWRW2vzvdic7xxPKMPypRG3oG+w0NABHzJBwd9GeFAelLDO26EFtNreQ19MSua//zwh+ZJeHvLSqIlY3OK8sE0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pwf6bIyD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329395; x=1802865395;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HCcEgZbUZAYJdLBiqZun542rW5HaZpbwzc1IEPxjSLk=;
  b=Pwf6bIyDQnlQvjMPYKR5tlQOSt4Wm4iEAtgu8sWWHCkQm3kWN/N/TkSe
   smlhuvGDA5q8bQzPx8GORA1dJNT/cSQStWrokrM1k7V7dOs7acRbafHzt
   VLExTl/YQsTivT/+hM//iao0wGFBz5OIQ5wheEKJqmF2XKZhraeEVcYUL
   OCENlFQ2YX3wKvaIAjuZdkQBze4SMqwoZ0WIGhj/H/NlrGi0d/9duWZFB
   S64jnkxSIpaLVCMnl7vMNPTkLXSNUtdWztFKAbundep+pesamKsIojJgI
   UjJe3L/AC60sMD1Tm82rDIqT2cPGoHrTr0r1xZg+hvwCOENz43mJca9N9
   Q==;
X-CSE-ConnectionGUID: W9wffeXnQi6FaKj9I9pcQQ==
X-CSE-MsgGUID: lpgx4wTJTwOVVXNf5KU1Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495866"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495866"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:34 -0800
X-CSE-ConnectionGUID: gnNW29m+SiqTcq3qEdFpDw==
X-CSE-MsgGUID: w+qYxl3sTSS0AAPEH3JUdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547121"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:33 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v3 wireless-next 04/15] wifi: cfg80211: refactor wiphy_suspend
Date: Tue, 17 Feb 2026 13:56:07 +0200
Message-Id: <20260217115618.2066972-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
References: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31934-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 0DB8C14BA55
X-Rspamd-Action: no action

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
Link: https://patch.msgid.link/20260108102921.00336669ac32.Id76f272662e1315cd93a628808cc2d1625036b00@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/sysfs.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 2e0ea69b9604..3385a27468f7 100644
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


