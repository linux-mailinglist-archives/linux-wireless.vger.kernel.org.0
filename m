Return-Path: <linux-wireless+bounces-30442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9A0CFDB06
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 13:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AAC130829BB
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B83314A70;
	Wed,  7 Jan 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8FvWuHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E54322DC2
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788590; cv=none; b=kfK7q6oeL0wI0QS53iaBrciGAXuqFgeLnBU7Ti2wHvbFEOCMsSJNKjwY3thAbjBJJNPG+mPiW7+UVkBh9KLG6MA/SxhmT7zcIxsyxArnkHeyDES9kIQr7Eqb/0uGxEQWSGdkH2Yh/31kvbbBzAbTHfDCvr7huTs+O7BbikeNn3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788590; c=relaxed/simple;
	bh=cZZYbpNgRhDA/67ex+B2sYGfm05QnOotIQFq2D0JspQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imezLXIixCfRht1zgitlYQY/ZCjNyBdAmjIE+6K1xgh6X1i41kf/fk0vjYGOXCGhNhyu1QYkPII9cPqXEWsrMD6K7m6lk5vw4tvHDKsQRHwRQ4EEwDFOGd1O2yRZjUatw9ULT8knHluTYXJlmcl9asm7SDXSNTNR7Xay3A+HPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8FvWuHd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767788588; x=1799324588;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cZZYbpNgRhDA/67ex+B2sYGfm05QnOotIQFq2D0JspQ=;
  b=b8FvWuHdaQF2+RXPjj6RaUhyEiF7+kj+oQhR7WAKyS3LDviWn7tKA9Og
   bxQj9+FtxCwV03gIskbwyN5fKESWfGktIhpNcGYMJK31PzpWecIIpBYV0
   p0jvFgZXAkoFSu8gkjCi1Ck27cdaDTKcQA65fIKZOfKTSsSSoiM//Cc+m
   7DMGsH4jHjKpGo9zpkxxdBOSJaZd/YvNMzANRBn5jtLRyTcRUnacnepxG
   QFd5nrAhh1Yi6OTgnSzk/aJb2/JnXO3q3pajNK6gV3lRFjWVOyUL8ZYl5
   5XJpnK7v5G6hXHzdQYWar0TK9lLqb9lwqAiDm6pTMvjKBECWdNTwu+d25
   Q==;
X-CSE-ConnectionGUID: iU2aWgCuRGih6hiO02EOwA==
X-CSE-MsgGUID: s9241akKT0KH4qt+wkweDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69055644"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="69055644"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:23:05 -0800
X-CSE-ConnectionGUID: w4N4MxCjRD6TEuHXvcH5rQ==
X-CSE-MsgGUID: Ou5DrE/JQGyFZ9EGpesg+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203363367"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:23:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 2/2] wifi: nl80211: ignore cluster id after NAN started
Date: Wed,  7 Jan 2026 14:22:54 +0200
Message-Id: <20260107142229.fb55e5853269.I10d18c8f69d98b28916596d6da4207c15ea4abb5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107142229.9ccb700797ec.I890ac852be6ca0093995655d987ca5c28a26ce3d@changeid>
References: <20260107142229.9ccb700797ec.I890ac852be6ca0093995655d987ca5c28a26ce3d@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

After NAN was started, cluster id updates from the user space should not
happen, since the device already started a cluster with the
previousely provided id.

Since NL80211_CMD_CHANGE_NAN_CONFIG requires to set the full NAN
configuration, we can't require that NL80211_NAN_CONF_CLUSTER_ID won't
be included in this command, and keeping the last confgiured value just
to be able to compare it against the new one seems a bit overkill.

Therefore, just ignore cluster id in this command and clarify the
documentation.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/uapi/linux/nl80211.h |  4 +++-
 net/wireless/nl80211.c       | 11 ++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..40d8f02a9928 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -11,7 +11,7 @@
  * Copyright 2008 Jouni Malinen <jouni.malinen@atheros.com>
  * Copyright 2008 Colin McCabe <colin@cozybit.com>
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -7432,6 +7432,8 @@ enum nl80211_nan_band_conf_attributes {
  *	address that can take values from 50-6F-9A-01-00-00 to
  *	50-6F-9A-01-FF-FF. This attribute is optional. If not present,
  *	a random Cluster ID will be chosen.
+ *	This attribute will be ignored in NL80211_CMD_CHANGE_NAN_CONFIG
+ *	since after NAN was started, the cluster ID can no longer change.
  * @NL80211_NAN_CONF_EXTRA_ATTRS: Additional NAN attributes to be
  *	published in the beacons. This is an optional byte array.
  * @NL80211_NAN_CONF_VENDOR_ELEMS: Vendor-specific elements that will
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..39840e78a526 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <linux/if.h>
@@ -15563,7 +15563,8 @@ static int nl80211_parse_nan_band_config(struct wiphy *wiphy,
 static int nl80211_parse_nan_conf(struct wiphy *wiphy,
 				  struct genl_info *info,
 				  struct cfg80211_nan_conf *conf,
-				  u32 *changed_flags)
+				  u32 *changed_flags,
+				  bool start)
 {
 	struct nlattr *attrs[NL80211_NAN_CONF_ATTR_MAX + 1];
 	int err, rem;
@@ -15610,7 +15611,7 @@ static int nl80211_parse_nan_conf(struct wiphy *wiphy,
 		return err;
 
 	changed |= CFG80211_NAN_CONF_CHANGED_CONFIG;
-	if (attrs[NL80211_NAN_CONF_CLUSTER_ID])
+	if (attrs[NL80211_NAN_CONF_CLUSTER_ID] && start)
 		conf->cluster_id =
 			nla_data(attrs[NL80211_NAN_CONF_CLUSTER_ID]);
 
@@ -15721,7 +15722,7 @@ static int nl80211_start_nan(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL80211_ATTR_NAN_MASTER_PREF])
 		return -EINVAL;
 
-	err = nl80211_parse_nan_conf(&rdev->wiphy, info, &conf, NULL);
+	err = nl80211_parse_nan_conf(&rdev->wiphy, info, &conf, NULL, true);
 	if (err)
 		return err;
 
@@ -16087,7 +16088,7 @@ static int nl80211_nan_change_config(struct sk_buff *skb,
 	if (!wdev_running(wdev))
 		return -ENOTCONN;
 
-	err = nl80211_parse_nan_conf(&rdev->wiphy, info, &conf, &changed);
+	err = nl80211_parse_nan_conf(&rdev->wiphy, info, &conf, &changed, false);
 	if (err)
 		return err;
 
-- 
2.34.1


