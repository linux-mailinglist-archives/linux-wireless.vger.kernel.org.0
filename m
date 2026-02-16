Return-Path: <linux-wireless+bounces-31902-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOaSH0uSk2lu6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31902-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B492D147D15
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15A72300603A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A6229E11D;
	Mon, 16 Feb 2026 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DliCVnfB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1802D641C
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278910; cv=none; b=Ux/sbBXsxqf6zoo1Oa2qiXJm5/nOsrQtyZvTz7m/jQThExy4I+vsE3mGjJ8mVuNhWLkXRTOJffvq/O++UA9PMYdbR9uwlYc+HLN6vV7+qPC2CuxRS4IAyV5qV/KKAKlDPrCUaAOnXWz1KLgX48vGDSraoHyeF2u05hiXA25rjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278910; c=relaxed/simple;
	bh=HCcEgZbUZAYJdLBiqZun542rW5HaZpbwzc1IEPxjSLk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JlVfsu5Bn8fTx8Toi5Dr80GVJ1kfBjDo+L63vrss1hARnsenffIR+2C6D5Wfk7VsedO19aAfzBR17sOvfYtBiOpey9/AXPJsixf1uVP0sqOUcxrxqlSCD6wV9OlQxNpIrBWD4aANhboLoeR0DXjpypZV3fauI+8AJ0b1w9L61pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DliCVnfB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771278910; x=1802814910;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HCcEgZbUZAYJdLBiqZun542rW5HaZpbwzc1IEPxjSLk=;
  b=DliCVnfB/VTQXt0bNbFlDZonu2IRCQERiKlZGuxcELg07B9jLcYcfvmv
   9A8dzqkHsZ1KS/JfYCmL88meWq9UDRWykfqzcH8KVF7F2V2FmpegUSmbX
   WOWDSlouyY/U9VeyWSuIscT5vbPLDrdSV0AxhyxobDl3FXhjkTMtG/nHR
   1BIi73/I5ROo0DAdREmhsw9SXzewObXGZYTUHaOq+9fOgECRIzHpKqxMM
   19zSmlrAhn9Mw75DPq3lWWCGWsGrxbkfA+I+5sbGqaz1AgaETZqUV8iQe
   rK+hiZfx4qWB3pRFLJtYEnwtRZG16r1AJXHjowIRqYclzZwIXXbaHyg3B
   w==;
X-CSE-ConnectionGUID: xrLXZZwlSXmXQh2Na7GQkQ==
X-CSE-MsgGUID: 41q9PX3MQ9mVEJ0VNxZQOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="75980286"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="75980286"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:09 -0800
X-CSE-ConnectionGUID: QMaYi+iURqa0+fy5QxxOUw==
X-CSE-MsgGUID: +lVFePGfQpi4vmryQYowHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213547303"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 04/15] wifi: cfg80211: refactor wiphy_suspend
Date: Mon, 16 Feb 2026 23:54:41 +0200
Message-Id: <20260216215452.1538316-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
References: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31902-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: B492D147D15
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


