Return-Path: <linux-wireless+bounces-27064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A607EB479E1
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72A854E02C9
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD701F460B;
	Sun,  7 Sep 2025 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRSUyA8i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD21B4224
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235137; cv=none; b=ur2Yit8wOvqw9En0lQMWvBN0rsfFeErt1jpTdu1isDgzomVoF5JYBMEaPJjh7huWsrdgec/3+MFHi59yp0qgMGuEx7zY7il2ogF/i9kLTg2c9d7kBZ0DUjKbPpHzlxWbXw4mvbSENVrRzjvrCBLufUOoywMAl96qwPoV2Ein/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235137; c=relaxed/simple;
	bh=afesCfebxOH727wqOHkbOkIRhUD3Ih5DzLrwYtw+7bA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFwOYQvyeePjvLVgVo0klj5pIerQTtrGS7jmGQlYuWhrV1ysuiTQOY7+yxKEkdEatySfb4jdYxIzcr/fZBZU7Bwy1UwXOzGzdglideDtkB00eLP3xG0nAvzHt5iFnxft/LRBGjscmt5Oj+JP0SnsUMkmS/zWXhAWwwKKsDQltvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRSUyA8i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757235135; x=1788771135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=afesCfebxOH727wqOHkbOkIRhUD3Ih5DzLrwYtw+7bA=;
  b=KRSUyA8ie8NszXzauHw/C0OI3QiTjxDJemQMmLRKgFTg1wVU5yXDT6EO
   lkyP9Dn63vzndFc9GCcLgw2fJKsZ9ifvs0tP8YxQARjJL8N1Oi7Lt13Ua
   CtJuuWXNJd0a8hqy19wxSoufIW8OHWTpfFYn9TnFlTt3NwJAKYDc+gmEL
   QtHqOO9YxpBeGBRxN6PAPApWMdwvU3UYjQrl9iuh8JkZSaMEYRH2IRfwz
   Kc/Md/jHR+WQ32KQRr6RtF0WgnKAn83s4rs/+LUKJNtu+P1gxOtq7uY3S
   yrsYcSjB+Nm3JMNvxIkvrqRGbDwTsd/0pgPOnUJSxe/IO0gYeRqAncXga
   Q==;
X-CSE-ConnectionGUID: W5dciv/HRZq4VCVOhb+LIw==
X-CSE-MsgGUID: CFOkX0AwStmtkZq5GNCwCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="59665006"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="59665006"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:52:13 -0700
X-CSE-ConnectionGUID: o4VY7PvURTeIqu1NhtLCHg==
X-CSE-MsgGUID: 9k+cXERoQbS7OuludydYiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="209695597"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:52:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: update the time stamps in hidden ssid
Date: Sun,  7 Sep 2025 11:51:43 +0300
Message-Id: <20250907115135.712745e498c0.I38186abf5d20dec6f6f2d42d2e1cdb50c6bfea25@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In hidden SSID we have separate BSS entries for the beacon and for the
probe response(s).
The BSS entry time stamps represent the age of the BSS;
when was the last time we heard the BSS.
When we receive a beacon of a hidden SSID it means that we heard that
BSS, so it makes sense to indicate that in the probe response entries.
Do that.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a8339ed52404..52a3d32c16fe 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1816,6 +1816,9 @@ static void cfg80211_update_hidden_bsses(struct cfg80211_internal_bss *known,
 		WARN_ON(ies != old_ies);
 
 		rcu_assign_pointer(bss->pub.beacon_ies, new_ies);
+
+		bss->ts = known->ts;
+		bss->pub.ts_boottime = known->pub.ts_boottime;
 	}
 }
 
@@ -1882,6 +1885,10 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 {
 	lockdep_assert_held(&rdev->bss_lock);
 
+	/* Update time stamps */
+	known->ts = new->ts;
+	known->pub.ts_boottime = new->pub.ts_boottime;
+
 	/* Update IEs */
 	if (rcu_access_pointer(new->pub.proberesp_ies)) {
 		const struct cfg80211_bss_ies *old;
@@ -1944,8 +1951,6 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 	if (signal_valid)
 		known->pub.signal = new->pub.signal;
 	known->pub.capability = new->pub.capability;
-	known->ts = new->ts;
-	known->pub.ts_boottime = new->pub.ts_boottime;
 	known->parent_tsf = new->parent_tsf;
 	known->pub.chains = new->pub.chains;
 	memcpy(known->pub.chain_signal, new->pub.chain_signal,
-- 
2.34.1


