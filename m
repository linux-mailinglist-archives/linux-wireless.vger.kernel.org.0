Return-Path: <linux-wireless+bounces-25133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7AAFF327
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DA817A86F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC25241680;
	Wed,  9 Jul 2025 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrFZ3yav"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400F2459F8
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093511; cv=none; b=PPKppgwolo8u55mAI6tWuk5LaSXGkfwidwUFUjacZI1mZVQSdGn6ZxEItPohKViwNecfWjsRkQiZ05UVw2JZ/GUZ7ZLTIHuhorshBtwme+3OnrFH4XmuB6zFKwSy/BEcqhccW3VFMfoGAujaXs+mVdIgYc3Uf1T6t7sqJsiqGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093511; c=relaxed/simple;
	bh=KVQVsV2DQzE5uC2Yz+9GCut/EaSi+6VOQFfmJ7oJu2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNfplcj0g/tJhYlm6g1jfZedz8fEKnbUdikt+fGkp+ZzRZNELonvE7bvwXwoaLfIhhztOot/TZ3wYR0IERZkyk7mv1Lco8uHufXWCH4P8FlXS7a8/RwvrF4Gj2Jd5CFS1xO1GyVTBT2XJr9vItT2N4I6P7QTS5krVNC53Aib6c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrFZ3yav; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093509; x=1783629509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KVQVsV2DQzE5uC2Yz+9GCut/EaSi+6VOQFfmJ7oJu2M=;
  b=NrFZ3yavotktgXjYStarSREF9qEcNDOaEv3YzHoIa3dNZd6TUHjpwzr+
   BpIqj6viCytY8GUkN2J8d9r2ZdvnyWb1ok67PbyuJHgsis6DWKGEYI+Lh
   N2IGZhG0SEb/56tPj/OWLSmY9gUXUV9qSl08sqJa/qhGgNeHeXU0rvl7i
   6tQp2v4ZU2qNECAPIF49PdCYQh/PubrLbvCtWHK0aorWA6Mo6fCputCqK
   qW5yC+7yvYnj3O6YrLRVuCdCS/POSeJyen8uWLy5r65rgmDoaLhv++zti
   lY1NFM6oypxayX3P1lppjF4NfERKJeSR0O4HzrVuuWGG50CC0IYgU3cLz
   A==;
X-CSE-ConnectionGUID: C7rcv6BPRG2FiEnmDf3rCA==
X-CSE-MsgGUID: tlkgl2r7SLiXqX38Zmz+rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974442"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974442"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:29 -0700
X-CSE-ConnectionGUID: dzH+UAGFThKqcEbXqOA9gg==
X-CSE-MsgGUID: rOWcPSMQQayEkCY9mCrlEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161532862"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 04/11] wifi: mac80211: don't send keys to driver when fips_enabled
Date: Wed,  9 Jul 2025 23:37:56 +0300
Message-Id: <20250709233537.e5eebc2b19d8.I968ef8c9ffb48d464ada78685bd25d22349fb063@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
References: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When fips_enabled is set, don't send any keys to the driver
(including possibly WoWLAN KEK/KCK material), assuming that
no device exists with the necessary certifications. If this
turns out to be false in the future, we can add a HW flag.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/driver-ops.c | 5 ++++-
 net/mac80211/driver-ops.h | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 35349a7f16cb..ba9fba165926 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2015 Intel Deutschland GmbH
- * Copyright (C) 2022-2024 Intel Corporation
+ * Copyright (C) 2022-2025 Intel Corporation
  */
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
@@ -515,6 +515,9 @@ int drv_set_key(struct ieee80211_local *local,
 		    !(sdata->vif.active_links & BIT(key->link_id))))
 		return -ENOLINK;
 
+	if (fips_enabled)
+		return -EOPNOTSUPP;
+
 	trace_drv_set_key(local, cmd, sdata, sta, key);
 	ret = local->ops->set_key(&local->hw, cmd, &sdata->vif, sta, key);
 	trace_drv_return_int(local, ret);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 8baebb5636ec..181bcb34b795 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -8,6 +8,7 @@
 #ifndef __MAC80211_DRIVER_OPS
 #define __MAC80211_DRIVER_OPS
 
+#include <linux/fips.h>
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
 #include "trace.h"
@@ -902,6 +903,9 @@ static inline void drv_set_rekey_data(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
+	if (fips_enabled)
+		return;
+
 	trace_drv_set_rekey_data(local, sdata, data);
 	if (local->ops->set_rekey_data)
 		local->ops->set_rekey_data(&local->hw, &sdata->vif, data);
-- 
2.34.1


