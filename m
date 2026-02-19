Return-Path: <linux-wireless+bounces-32013-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJq0AITclmlJpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32013-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:48:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90515D836
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D266330480EF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B52EC0BF;
	Thu, 19 Feb 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlpteQrS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60921ADB7
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494462; cv=none; b=cIJvKZcQpN+DsO6yjDdSy7KcQm8MINa/tsUT68TMj6s75dHa1w3pBTHvhUP7KHTC9YA6WwHhEooH/ChF/ghV7i6hpw3/6q7l6zSfdioiLSljQplkN64A7xdqgdhnqqf2gCneEMvtaglRgsTvbDEh9PjYbsLSAdsl07zdu83Np5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494462; c=relaxed/simple;
	bh=HCcEgZbUZAYJdLBiqZun542rW5HaZpbwzc1IEPxjSLk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNdF39lS+S1IlE1a31rppis+3kMdY8WQTEpO9f73TPHBY+zWTfBRqwB8/K8Dquvr0RO3kPA4RCt3hF1Us/nCvCAugY6ISimvOzIgRqENEH/rlpi28kUtCkH2cPfllbblRsEFqJyjp38T2ATdT4ffwiuFXiQo26IINsqGl4zl7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlpteQrS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771494462; x=1803030462;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HCcEgZbUZAYJdLBiqZun542rW5HaZpbwzc1IEPxjSLk=;
  b=HlpteQrSND8DaU1YY2pNgZa6fsTLdOwOlfQGT9UX903/wx3x44N5Mqft
   CzKHTJy13E8xO5uoOPWRPx6kyw6gh8ngUF3tpkY4hueho1EwxzMhUuCbi
   XI+z83+NSlfCrZ8uownKdi88tiODe74F24rQnt6wgVEf0Gk9NUzL3rVOk
   Z5Fx0M4Q4JmrRYp18+XOy2RXWIRQ+vKqger5OGqH8jrKztCl8LEiHKCi+
   Ugy4XhesHFQY3dFzJNtpBEie0DwdpoQpN+arUsm7oxpa6JFPmRXhXHwCK
   tELcwVvAWIorE52ruVKsFXY8hzEkXDrP6xahSsViaUiQ+mXLYrAwm0Ybx
   g==;
X-CSE-ConnectionGUID: cAGLRz03RGylxrqHpc/EKA==
X-CSE-MsgGUID: BS8woxJvR0+234Zj+7pRMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83680081"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83680081"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:42 -0800
X-CSE-ConnectionGUID: RfKzMgi6SkWt1hYZ9R/Yaw==
X-CSE-MsgGUID: CR5NXA9AQJm6waB9gezKKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218989001"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v4 wireless-next 04/15] wifi: cfg80211: refactor wiphy_suspend
Date: Thu, 19 Feb 2026 11:47:14 +0200
Message-Id: <20260219094725.3846371-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32013-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 5A90515D836
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


