Return-Path: <linux-wireless+bounces-18819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B5A31EAB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 07:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F99165D87
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18AB1FBEB6;
	Wed, 12 Feb 2025 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvLEmSXz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CC1FBC9B
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341392; cv=none; b=ZPg1AxH0xKU1S1qfWLnD7add8V5DL+0vVQW/wtysilliUhn4nCy2B7sQ89pazK+I6CnZqQoKQizrXlDuBLRz0fiuWVXXtC2Npn6k+s+jKCc/YhvahhMe9HLzgFpiv7bSIuPyhjv3kzMl+mjWI+dHNq3//McL6AcvIMINRlNcjDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341392; c=relaxed/simple;
	bh=9NWtWCKZrnxiaeRZnae9w0HJ3+CfGtNtv7+Fy2mxsR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9DME4ZDiZLanoG22AgopBlP9/AmKGXpJGi7mTGBLNpmXboVI7AQ+LBUWf75RKIGuk6t3PZYKmilZN7LYYnTgy0pHro3lDCxux6Ako262ueQPTShCo2ppAKx0HGDtU3VQ3B3bDuTsOzEAASf7WRqYsM/TeRPHGXaVUU01JVak5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvLEmSXz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341391; x=1770877391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NWtWCKZrnxiaeRZnae9w0HJ3+CfGtNtv7+Fy2mxsR4=;
  b=FvLEmSXzhVT4u9OjF1HoLE4cjC8eMR29aDm4WIi3GkKgpPEYbVuC1Kdr
   K466Vwolovwn6uj8tq1wHHXgJnfORkz14+MqAvSMLcLKG2AZKAZme+E6q
   HnEVQQVO6mH4BY7CrdKNNk7h+9tz5u4Z9VtGzzFpUVyNPyKwfYlamI7sa
   it8Tx6iucj1+AFi6LJEM9LmaZx0DF9h/KgZTHeyozqlNSrS6ozz46iv3H
   kjbI3rGNrazXQWdk1YfwmkZ/CVKUQhyFzSFOytFjjsv9BwLGn5rWXsSUZ
   y0bhD+hP0Uz2LJyxaYW3a4Y4CtwE27g2ExCmQvYo88PBCxdYvt82hykkb
   Q==;
X-CSE-ConnectionGUID: Vb+batPmQrq2DxNOaC2/QA==
X-CSE-MsgGUID: z2W4+nSeQWycZCzH4AjfOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43637627"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="43637627"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:23:10 -0800
X-CSE-ConnectionGUID: oPxxxnuLQYy4z5Tz6RXn+w==
X-CSE-MsgGUID: R4AhXtQGR8maeNNUIUvc2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112944135"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:23:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: add ieee80211_iter_chan_contexts_mtx
Date: Wed, 12 Feb 2025 08:22:57 +0200
Message-Id: <20250212082137.d85eef3024de.Icda0616416c5fd4b2cbf892bdab2476f26e644ec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212062258.454981-1-miriam.rachel.korenblit@intel.com>
References: <20250212062258.454981-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add a chanctx iterator that can be called from a wiphy-locked context.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 25 +++++++++++++++++++++++++
 net/mac80211/chan.c    | 20 +++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 22d32419e8a0..64e666fc5adc 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6671,6 +6671,31 @@ void ieee80211_iter_chan_contexts_atomic(
 		     void *data),
 	void *iter_data);
 
+/**
+ * ieee80211_iter_chan_contexts_atomic - iterate channel contexts
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @iter: iterator function
+ * @iter_data: data passed to iterator function
+ *
+ * Iterate all active channel contexts. This function can only be used while
+ * holding the wiphy mutex.
+ *
+ * The iterator will not find a context that's being added (during
+ * the driver callback to add it) but will find it while it's being
+ * removed.
+ *
+ * Note that during hardware restart, all contexts that existed
+ * before the restart are considered already present so will be
+ * found while iterating, whether they've been re-added already
+ * or not.
+ */
+void ieee80211_iter_chan_contexts_mtx(
+	struct ieee80211_hw *hw,
+	void (*iter)(struct ieee80211_hw *hw,
+		     struct ieee80211_chanctx_conf *chanctx_conf,
+		     void *data),
+	void *iter_data);
+
 /**
  * ieee80211_ap_probereq_get - retrieve a Probe Request template
  * @hw: pointer obtained from ieee80211_alloc_hw().
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index dc28f2b0957a..c3bfac58151f 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * mac80211 - channel management
- * Copyright 2020 - 2024 Intel Corporation
+ * Copyright 2020 - 2025 Intel Corporation
  */
 
 #include <linux/nl80211.h>
@@ -2178,3 +2178,21 @@ void ieee80211_iter_chan_contexts_atomic(
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(ieee80211_iter_chan_contexts_atomic);
+
+void ieee80211_iter_chan_contexts_mtx(
+	struct ieee80211_hw *hw,
+	void (*iter)(struct ieee80211_hw *hw,
+		     struct ieee80211_chanctx_conf *chanctx_conf,
+		     void *data),
+	void *iter_data)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_chanctx *ctx;
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	list_for_each_entry(ctx, &local->chanctx_list, list)
+		if (ctx->driver_present)
+			iter(hw, &ctx->conf, iter_data);
+}
+EXPORT_SYMBOL_GPL(ieee80211_iter_chan_contexts_mtx);
-- 
2.34.1


