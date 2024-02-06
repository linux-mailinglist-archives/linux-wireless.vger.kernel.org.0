Return-Path: <linux-wireless+bounces-3224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7687584B88C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 15:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0721C2423F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4AA133985;
	Tue,  6 Feb 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uzltr2QI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD812FF7C
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231271; cv=none; b=PlpON+EYovonjb7YGzDA1TDc0yJtI0usg1T+4fo7LD3B5228yDNq5yL40QBEeqlZ7EeTeOcVeib/w6LmsCXe5xPOddWaxHJJ6QU7kyMLx3XFFWQ+F5iDun0T1u41JKd48ubcRLKig+E2TWYtxyB3EoprvCzFHSJvqoShGwZYH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231271; c=relaxed/simple;
	bh=nBl41JxENQJfGp9n30Fw1Axl5NlHvCX5DRAMj+8gtD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DhVzDhILKGhM+rrXblPIWBP7E6ARcXBiNq61X7jzGJNFxmAtgCvJFHch3B5G+ZoBCLekLOYbcQD6N64Cs52NmGbOlCewHRjsv0rtJABqKIlxys+XobCMJ2913kSWoPupsU8P4bypiUgb3M4F6SnzUR1vdW5nK8cU9KOAJd7PYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uzltr2QI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707231270; x=1738767270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nBl41JxENQJfGp9n30Fw1Axl5NlHvCX5DRAMj+8gtD8=;
  b=Uzltr2QIX8Q0vpSNOvEOpvRckhBo+QbBYtCHbheMlxdf5s5Jagpl1VLq
   uRxPmtkqQG3E5EwHCZE9Ol9lIqIr/S3PBzGUQiRlCSpDhFU7PK8QzTakc
   hiiCo4dbJsOSmWN0z9UB7DQ5NZOOJ5cQtkFk4mI/4mT55ZZYJsziqnVXV
   /MB3o4Nztj1pIq6AItAES4sPa1FtSkEWJxrI/hntUVtFBcuQ1XJe8F7YR
   HYRKkU1E3cwbHHtqzUkGyAggx4mWJ+25i/y7YpoF2s2HDqT/8S2jBXQFM
   SSNHDCOhfJhFc+iC+VgDwqys5AoYkmRSYIV1Iqo6teeN5W818X2EzLlfU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="917791"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="917791"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824197914"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824197914"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Amosi <amosi.daniel@intel.com>
Subject: [PATCH 2/8] wifi: mac80211: remove unnecessary chanreq compat check
Date: Tue,  6 Feb 2024 16:54:05 +0200
Message-Id: <20240206164849.388898af2e66.I5b0c802f5164e94bff661900177956d6954f9a2d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Amosi <amosi.daniel@intel.com>

This conditions can never be true, because if it was true
(either before or inside the loop) the code is already checking
this.

Signed-off-by: Daniel Amosi <amosi.daniel@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index ef4c2cebc080..f7ddfa329258 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -829,9 +829,6 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 	}
 	rcu_read_unlock();
 
-	if (!compat)
-		return;
-
 	ieee80211_change_chanctx(local, ctx, ctx, compat);
 }
 
-- 
2.34.1


