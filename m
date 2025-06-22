Return-Path: <linux-wireless+bounces-24326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A84CAE32CB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 00:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE9A16ED0C
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0841219E8C;
	Sun, 22 Jun 2025 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arw7bTwV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40F6136
	for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631159; cv=none; b=EQgKpXhq5Zj7PtRpfOdVfYuY2RG1eH7CTlL6Ju0BUpkgxgponzbQg3S4KGYvWrnQ6vcSpurx+lX699XLxETpya0HwnW54VBJkPahFNDfUP8NOWR1qJ3WDAR63D4xPHctAvIy9kvUXR5FhF7N+OIlutzkQfFTn0ADHAy9FV8OYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631159; c=relaxed/simple;
	bh=RYKroEbKBDYYfR/vi82IGpgp+Km/dMJydiCWgG0yr1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhBDiSAoGTn94I9aqF29Ihk7DGKnCPU3r5jXdpJHwy2BRt/S70zCQyJ5n7l7jAth46ECWL8Qz3ykvjhczafX0f8stK+ERP3gKPFsXNmexM6khgqK7u1sy7Os7YVhuwuZOo4Mr7+BUV8v/kxFUhFuL0Z8FWGDr1BQd2Lq9mK1fCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arw7bTwV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750631159; x=1782167159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RYKroEbKBDYYfR/vi82IGpgp+Km/dMJydiCWgG0yr1c=;
  b=arw7bTwVID/5AuLDcfE3+/auY0hVsLotof1u7s+omQAgalitf7KHiLpA
   Cdx0e5ywbihPQnGa+nPwPs2cGC3GaXbJeg1MOgQNgYnZludJqengAQ+UY
   W1cSMJ4PbK+0Bk+SzLG7osUsX4lcpDz/VlaCdOctDCOgidJhQ2qwzPmTY
   Z/wnENbW/Xi6+Ste3SLf97NV7gtBKjuBQZdbGR2oIHQqggHKJGsPMI7yP
   WrmkLl6AvSztgCRPJZEM3XeoxHr4wbmThWOcuhO//sswUBiPQakWH6uCI
   N0aNHPZQV7BpeVry0vyDvOjgL7eQwYau3JmBVuIxsDr6NXMblC4YNI48h
   Q==;
X-CSE-ConnectionGUID: ibvYRu+pRWycUhrFGReDqw==
X-CSE-MsgGUID: VMzfUFsNQEayDFBoPENUNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52916084"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52916084"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:59 -0700
X-CSE-ConnectionGUID: M2L0NBXoTQ2bNDz3ZlWvzw==
X-CSE-MsgGUID: wzTvYG9EQlSiZqqp70JM4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="182295770"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.248.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:56 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC 4/5] wifi: cfg80211: Add cfg80211_next_nan_dw_notif() API
Date: Mon, 23 Jun 2025 01:24:43 +0300
Message-ID: <20250622222444.356435-5-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement and export a new API that will be used by drivers to notify
user space about upcoming NAN Discovery Window (DW).

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 include/net/cfg80211.h | 10 ++++++++++
 net/wireless/nl80211.c | 41 +++++++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h   | 16 ++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b3d3b039c913..27a3b8795d9b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9871,6 +9871,16 @@ void cfg80211_schedule_channels_check(struct wireless_dev *wdev);
  */
 void cfg80211_epcs_changed(struct net_device *netdev, bool enabled);
 
+/**
+ * cfg80211_next_nan_dw_notif - Notify about the next NAN Discovery Window (DW)
+ * @wdev: Pointer to the wireless device structure
+ * @chan: DW channel (6, 44 or 149)
+ * @gfp: Memory allocation flags
+  */
+void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
+				struct ieee80211_channel *chan,
+				gfp_t gfp);
+
 #ifdef CONFIG_CFG80211_DEBUGFS
 /**
  * wiphy_locked_debugfs_read - do a locked read in debugfs
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6727580c0a50..5936ec1557fe 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20823,6 +20823,47 @@ void cfg80211_epcs_changed(struct net_device *netdev, bool enabled)
 }
 EXPORT_SYMBOL(cfg80211_epcs_changed);
 
+void cfg80211_next_nan_dw_notif(struct wireless_dev *wdev,
+				struct ieee80211_channel *chan,
+				gfp_t gfp)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_next_nan_dw_notif(wdev, chan);
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0,
+			     NL80211_CMD_NAN_NEXT_DW_NOTIFICATION);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, chan->center_freq))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	if (!wdev->owner_nlportid)
+		genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy),
+					msg, 0, NL80211_MCGRP_NAN, gfp);
+	else
+		genlmsg_unicast(wiphy_net(&rdev->wiphy), msg,
+				wdev->owner_nlportid);
+
+	return;
+
+ nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_next_nan_dw_notif);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 61a5eca9c513..bf84e6abaf69 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4187,6 +4187,22 @@ TRACE_EVENT(cfg80211_epcs_changed,
 		  WDEV_PR_ARG, __entry->enabled)
 );
 
+TRACE_EVENT(cfg80211_next_nan_dw_notif,
+	TP_PROTO(struct wireless_dev *wdev,
+		 struct ieee80211_channel *chan),
+	TP_ARGS(wdev, chan),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		CHAN_ENTRY
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		CHAN_ASSIGN(chan);
+	),
+	TP_printk(WDEV_PR_FMT " " CHAN_PR_FMT,
+		  WDEV_PR_ARG, CHAN_PR_ARG)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.49.0


