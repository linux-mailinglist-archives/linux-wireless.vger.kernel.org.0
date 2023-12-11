Return-Path: <linux-wireless+bounces-596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5927380BACB
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20631F20FA5
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC94CC2C4;
	Sun, 10 Dec 2023 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU7X3ZvN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD49D
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213500; x=1733749500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tEtf6mMdYY+fCL50KyoAWsR7Fcmj2PmcQH5Jv/O6Y8=;
  b=kU7X3ZvNK79YBB/1Ei/6bUwiNuRhbs8MHP+G5wbjgJOU8Ou4RPnmJa5W
   zDQfWwnbPWjv9E/urNx6mW9Lnzdn3W+JxhMLma2Yzzzrteg3RHjzrZiBf
   Oah0VgIruZPKllp+prTH/pKOJ2OMUlr+JYFKVncYB+/V2jwAarqaI0RDj
   R6pDQdkcxaENna7nG5GAGRfHl80DXeQZEwY4KYcm8uclLHW10HgUIWyU2
   D5cDdxDVKTGsKlMe1FsXrqWh42hwBqvQ6HCttyZntrJtd41zT3NVuYO44
   mSYxzKdHQ39/O47V8WqaZLEC6sFJk6m1/+k8OSUH0B//tqK0oz+IBIS2v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480745636"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480745636"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748925436"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748925436"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:04:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>, Berg@web.codeaurora.org,
	Benjamin <benjamin.berg@intel.com>
Subject: [PATCH 01/14] wifi: mac80211: don't re-add debugfs during reconfig
Date: Mon, 11 Dec 2023 09:05:19 +0200
Message-Id: <20231211085121.88a950f43e16.Id71181780994649219685887c0fcad33d387cc78@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If we're doing reconfig, then we cannot add the debugfs
files that are already there from before the reconfig.
Skip that in drv_change_sta_links() during reconfig.

Fixes: d2caad527c19 ("wifi: mac80211: add API to show the link STAs in debugfs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Reviewed-by: Berg, Benjamin <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/driver-ops.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 7938ec87ef25..d3820333cd59 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2015 Intel Deutschland GmbH
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022-2023 Intel Corporation
  */
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
@@ -589,6 +589,10 @@ int drv_change_sta_links(struct ieee80211_local *local,
 	if (ret)
 		return ret;
 
+	/* during reconfig don't add it to debugfs again */
+	if (local->in_reconfig)
+		return 0;
+
 	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		link_sta = rcu_dereference_protected(info->link[link_id],
 						     lockdep_is_held(&local->hw.wiphy->mtx));
-- 
2.34.1


