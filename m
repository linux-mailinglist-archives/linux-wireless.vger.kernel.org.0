Return-Path: <linux-wireless+bounces-18510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D8A286D5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BC21884AC3
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED02822AE7E;
	Wed,  5 Feb 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxT5Gs65"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895B22ACD3
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748417; cv=none; b=ukPmK7FeepgRGCCWYfyStylUcLvRuVA2aW5Cq0sekhV6OOfUCb3RZIjksmOKZnXMtvD9X9AYPKRAURyDTww7KGZx7wd5OZCsqGT4lcmj1FlaraD5HvgJ66uVnV+Rr1qINNC4QdygwzWjESsOMpMiI5mj8i2DJ3p12NjNGyGNccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748417; c=relaxed/simple;
	bh=erd7G2XY3j3Bv7e6tWorf0W/YkCwIdR9O3U8NYzel6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lt3Wg/5c0mUEY4gvh9Qf4esp8VuXfVa7FAcVs3WYY//bcM/qRmgh4FC0IzUfHfWYu/SZE8U3b5ljOxvptRaiKeflASPmrfGxgnUmqVqQt4cNXigmAa4P1VdPig8mCAYMrzexNWVr/lGBh8D4VaLthBdg5tg0VvSb+d21UZOf7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxT5Gs65; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748416; x=1770284416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=erd7G2XY3j3Bv7e6tWorf0W/YkCwIdR9O3U8NYzel6w=;
  b=IxT5Gs65Thu91G1ruVgBZv5TUA35rDsFOwXx1o/oPwNJ6oChTzeHp51V
   08WWJ/6Z6xYJnmyytAegOIrf1MjQGLssGGn1OV7Du0AIqcQCEEeJgQf/y
   Qu9IfOZlzLoeb3Wi4xYnDk+iuSVJgQvVDKsd72Rr68lnvz44AMiJFmzEH
   vWChTooS2UCFUnRxkf7jLIG72WM9KNc1+VsAIKjtLckIIHWRs6/b2e8P3
   1k8kkrI4aU5MKpMJN0vN6U3zCEEj4Ned+4Sc9mFZ4Ui72dkJGAF9ZlhKv
   iz69+vlAp8LF1nbXaZ4FFXvPvkxB7okJ+BcXiX24jemh0bb4Ou4UcI/PD
   w==;
X-CSE-ConnectionGUID: 8QigzTpkTT+TWNk9Qq/I3A==
X-CSE-MsgGUID: DMnX6qtoRimI+ipoiNa/xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225266"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225266"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:11 -0800
X-CSE-ConnectionGUID: IYEit/ugSHC4s6EsbxSwHQ==
X-CSE-MsgGUID: 9F+yC9IMQgqmQBitL35fZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845348"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/17] wifi: mac80211: ensure sdata->work is canceled before initialized.
Date: Wed,  5 Feb 2025 11:39:26 +0200
Message-Id: <20250205110958.99204c767c10.I84ce27a239059f6009cee197b252549a11426046@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This wiphy work is canceled when the iface is stopped,
and shouldn't be queued for a non-running iface.
If it happens to be queued for a non-running iface (due to a bug)
it can cause a corruption of wiphy_work_list when ieee80211_setup_sdata
is called. Make sure to cancel it in this case and warn on.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f8aaa2db52ce..6bea6342d3b7 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -807,6 +807,9 @@ static void ieee80211_set_multicast_list(struct net_device *dev)
  */
 static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
 {
+	if (WARN_ON(!list_empty(&sdata->work.entry)))
+		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
+
 	/* free extra data */
 	ieee80211_free_keys(sdata, false);
 
-- 
2.34.1


