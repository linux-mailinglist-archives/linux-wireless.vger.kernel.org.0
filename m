Return-Path: <linux-wireless+bounces-19871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F56A547FD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FB0173890
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3450420B1EB;
	Thu,  6 Mar 2025 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFDUIS2n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464C209F4E
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257496; cv=none; b=dp8zNzxqwCIshO/JccY79V4OFrV/oaCVliN+6bSWaIzIpl3VafZ5S3nXCKcoEHYryEdSNslAs2jr81KARu6fFmDfctLDU75iVk4Vneg/60Gu/tsPuoVTFigpn8WNibJExW6mCwBoeY0AUACYlsFjdHN3tQLW7WSLEK4HwlSVrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257496; c=relaxed/simple;
	bh=BwWAWBnCM2qE7bC0penKeu0dyy/89DAB4sKhllmbuvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRE4JH0O2UCyT4hvMfVUkgVAO+9Y24Js9kXiQ04HCKMcBiX8TWXsMNfJO59IekhaoyGCDyVR26bAIk5QnBPBrHsx7iwCfP8aoAgGxln+6oY293Ua8MbuRtBHSLRhsOf1F+dJnjLuSfQzsPcuChFdggpt0FcLsQzKHgZ333ppvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFDUIS2n; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257495; x=1772793495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BwWAWBnCM2qE7bC0penKeu0dyy/89DAB4sKhllmbuvQ=;
  b=VFDUIS2n+I0tX3LDqLG4XGH8mOPX2TV0jZPLrwbfWQ5B2cOoGYmLLOL7
   BMiSWccHSUTzYKuZqzyiRqdH4v4iYzvTRkPFsW5V7+PYhJ45DNK1+LoRV
   xHNjBfOahv5Aah2ftuOL8pltD8HxK517hLNioQ7qUW5BnNl6xPvWGMd0U
   Pt4VGPEZ2WRNPKgkk1O83ftZCaZtpmUET+e5aQZlugDC+fEm5avCVGVbL
   ay7mnSdxZuEn91y4IxUkqiwmh5qzDi7qmQZDYwT/3JnfRnwisnBNDIO7y
   Tia+ricyqgxKFp4D64/O9QpK+0FABuZYpodgWSUqL4QKshfILhvZF9FQb
   Q==;
X-CSE-ConnectionGUID: Cbs9GIKbRW+IygKyyVw6pg==
X-CSE-MsgGUID: ORLehEYvTbyxxyGZmC4W/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45915019"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="45915019"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:14 -0800
X-CSE-ConnectionGUID: DbMWilK9SYyDedqpkGpyrQ==
X-CSE-MsgGUID: cXpzWW3NR2S6NLUjcG1YBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123138380"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless 2/5] wifi: mac80211: don't queue sdata::work for a non-running sdata
Date: Thu,  6 Mar 2025 12:37:56 +0200
Message-Id: <20250306123626.1e02caf82640.I4949e71ed56e7186ed4968fa9ddff477473fa2f4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
References: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The worker really shouldn't be queued for a non-running interface.
Also, if ieee80211_setup_sdata is called between queueing and executing
the wk, it will be initialized, which will corrupt wiphy_work_list.

Fixes: f8891461a277 ("mac80211: do not start any work during reconfigure flow")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7f02bd5891eb..fdda14c08e2b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -6,7 +6,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  *
  * utilities for mac80211
  */
@@ -2193,8 +2193,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		ieee80211_reconfig_roc(local);
 
 		/* Requeue all works */
-		list_for_each_entry(sdata, &local->interfaces, list)
-			wiphy_work_queue(local->hw.wiphy, &sdata->work);
+		list_for_each_entry(sdata, &local->interfaces, list) {
+			if (ieee80211_sdata_running(sdata))
+				wiphy_work_queue(local->hw.wiphy, &sdata->work);
+		}
 	}
 
 	ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
-- 
2.34.1


