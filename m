Return-Path: <linux-wireless+bounces-19856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BF9A5478F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F893A8E01
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03121A08A6;
	Thu,  6 Mar 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZA0qPaR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488141FECAD
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256328; cv=none; b=Ub4rjMNg5fWsAM5RNpxgGSOQk7QRsFPsWbR38vJ2kRZIWEcgajXoeDt9le9zcGa2RP5N30yAfZ64RTDi9cD0fxJn/wwKGm/rYjSOQlIhSb4cfWG2KOcLfveZVOtJgg4UeETSU8q0pgwiqbLuN7ZoF++d87BoS7tRJPaEar5pEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256328; c=relaxed/simple;
	bh=BwWAWBnCM2qE7bC0penKeu0dyy/89DAB4sKhllmbuvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkkyZ09o03NRCHTfUQQQuaMC11JVJI0S11DWkWghjbqg5Z7Pfkv9wKONrFSDmLmtSPROWMakfm+hcPhnieQH+2fg5/ms2J99oNV2cBYcCPLc9IzMi5xRVZUi8TFsqmotAeyIJQAkpvdEFTwJdAu3vmV41W5HX+1MSX7J/9bgfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZA0qPaR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256328; x=1772792328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BwWAWBnCM2qE7bC0penKeu0dyy/89DAB4sKhllmbuvQ=;
  b=MZA0qPaRJfNc77svgVZ+jCro9HqvrTI9dnd+9+/tkkB9zzE96+0HMCvq
   pjsv2I4p4dTw1BaDvUvToTqch4Rmk6jKH2NsfkQfwJmjM+ksjWvOqxPha
   PAKDhack1qzj8EmZoYdrKBUyWq9Bs1PmeF7tpNsLM4/FL6JC6Ub9aJnPu
   ARMCfVjlPFM2HrMxnqmCRmzP/vILqZl5Hqn5soB72gK2F/AFsAWhY1KuD
   kVVaVVuIJpLH+hPzil8W9RN5e27iPiBQBByhszMYlxT2VHERmpQa3UxAh
   4ZRyvLnk2bzVN6AZjmVdiJ9vvDqtwSPKASmN85zYwsoazkR3g0N3RUYsr
   w==;
X-CSE-ConnectionGUID: e+GxszPgQneV3FJAGy+9YQ==
X-CSE-MsgGUID: jLmRbJh7S7STWdX104ZBhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46181366"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46181366"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:48 -0800
X-CSE-ConnectionGUID: Y8pXxOilT7qhkGK4iwXbjg==
X-CSE-MsgGUID: Pk44ga9wSDGtbW0drpZYZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118705708"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/5] wifi: mac80211: don't queue sdata::work for a non-running sdata
Date: Thu,  6 Mar 2025 12:18:28 +0200
Message-Id: <20250306121409.1e02caf82640.I4949e71ed56e7186ed4968fa9ddff477473fa2f4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
References: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
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


