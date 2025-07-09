Return-Path: <linux-wireless+bounces-25128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 133BFAFF318
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666117A2F1B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4C224227;
	Wed,  9 Jul 2025 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDrbtssb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB747202F8F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093319; cv=none; b=CaBzlH2Z4rCKtJE11gFFFlMdyhyANIehBRc19hkEtXDj/baKze5yl0tMzqW9T7w83V+7QgcTEA1I4aKl+/Eo1WOevO/vdMJHZuGM42Zejdgftpyp0EnB4igiLAu5kWDiA5M1N24iHJc/uzLvfNEuE9jsL6/eNitABeEds7RTdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093319; c=relaxed/simple;
	bh=nbuzzFx4tke59zOj1Ivx+NPdfpI4UvaeNA05hvg4Opk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=maIxMcz/zE13G7kViM9OTCz1v9h6uUeXfHIt1rgJ3y1dMXsHZAjaS3wGtV0WBx25Zb9Tvk3eYrGwZl9+fX5VNE8Zk0yZusFaawLLotySU0j8gBeYas5WBQnqHuCvqtqbMhNVHhUERwSmgZPQGJsEiaXYzBtjToh81PQtoj1y7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDrbtssb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093318; x=1783629318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nbuzzFx4tke59zOj1Ivx+NPdfpI4UvaeNA05hvg4Opk=;
  b=VDrbtssb7WdhiqyT/TnaEsMdtvPBrEI4iJmSo6pbQsqxk4hg8P11qSOZ
   MqVPS0/7/+/AUUWUb3jhxawUAHG7QXKnqK6B27Z3DF8Cum9e2V1Zj5qGQ
   Q7I3udPmT4A+w67ZSwx8XPiIe90n29/SIntpW8EZjYidr9VTK+c6L99BV
   jDkhmvaIF24YfnybeDESnHJAjkQColCY5zELSCn/EotKhBuyTADt8aGsg
   YKLXrd6c8+E0PZdjqOTHWWHedzRfjy1qeLOGkaGrfP84TPmEB2Q3pRpBT
   rl5LONiC/5jwaFhQme8inWlQ5j91By6FNxAkFfonucsMJx+xhfa1jZr52
   Q==;
X-CSE-ConnectionGUID: Mr9EOC+QTjKHIgO5jNB8tg==
X-CSE-MsgGUID: FCLMRe9EQU+y7uO1m+qhyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="53581031"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="53581031"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:35:17 -0700
X-CSE-ConnectionGUID: cW+opADtSc6Wo1ESFnV4FA==
X-CSE-MsgGUID: 0IyBPdctRhW3Tuwft1qBBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="156357598"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:35:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: add the virtual monitor after reconfig complete
Date: Wed,  9 Jul 2025 23:34:56 +0300
Message-Id: <20250709233451.648d39b041e8.I2e37b68375278987e303d6c00cc5f3d8334d2f96@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In reconfig we add the virtual monitor in 2 cases:
1. If we are resuming (it was deleted on suspend)
2. If it was added after an error but before the reconfig
   (due to the last non-monitor interface removal).

In the second case, the removal of the non-monitor interface will succeed
but the addition of the virtual monitor will fail, so we add it in the
reconfig.

The problem is that we mislead the driver to think that this is an existing
interface that is getting re-added - while it is actually a completely new
interface from the drivers' point of view.

Some drivers act differently when a interface is re-added. For example, it
might not initialize things because they were already initialized.
Such drivers will - in this case - be left with a partialy initialized vif.

To fix it, add the virtual monitor after reconfig_complete, so the
driver will know that this is a completely new interface.

Fixes: 3c3e21e7443b ("mac80211: destroy virtual monitor interface across suspend")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/util.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a125995ed252..e66da651678a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2144,11 +2144,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		cfg80211_sched_scan_stopped_locked(local->hw.wiphy, 0);
 
  wake_up:
-
-	if (local->virt_monitors > 0 &&
-	    local->virt_monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
-
 	/*
 	 * Clear the WLAN_STA_BLOCK_BA flag so new aggregation
 	 * sessions can be established after a resume.
@@ -2202,6 +2197,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		}
 	}
 
+	if (local->virt_monitors > 0 &&
+	    local->virt_monitors == local->open_count)
+		ieee80211_add_virtual_monitor(local);
+
 	if (!suspended)
 		return 0;
 
-- 
2.34.1


