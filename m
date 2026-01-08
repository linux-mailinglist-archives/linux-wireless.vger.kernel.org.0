Return-Path: <linux-wireless+bounces-30528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C9D03BCF
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0390D3275766
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEA734B68F;
	Thu,  8 Jan 2026 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CepCeiu7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080534CFBD
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861381; cv=none; b=A+jgIf5fhiwwHg1X/aV9bKaGct0xCbU8RXCNp9WBZLDSnXa7exOStK/+BHUY8GAXTouw9h16QMPWCoSHS6vZyrz/ktWUhxxTI9DIwHk43fxAPuN8eZUXiFc3bK/zkhIAAGdRY2knjxtCXq15WLkXeDMmjS6UhAVU3yMsf2DcT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861381; c=relaxed/simple;
	bh=17/mUDHFRYPvkcWp9zw3ZX+ZmVREm0Ldg+DvAzUIiyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sx10GxmdOpWn0c1WswgUiFmZQxD0wAyhsrYagB3Bnh77lYS58YLHb8wL4+Yj5ObZahQA35j1B/ignoQ+zCmhAOFrgT+dR0uXmqeEj/UOCIDy1iOOrHPc6rrK03kvL5ORK+wPZRcDW0wzBaVJmndfet2dlNUhgyjgRT2l1XMnPok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CepCeiu7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861375; x=1799397375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=17/mUDHFRYPvkcWp9zw3ZX+ZmVREm0Ldg+DvAzUIiyg=;
  b=CepCeiu7/0Svph/bdDwcyz+ZZGQEXrCUqnTRg8a3jGNGvqOXQJU0GNAE
   uvgQ/s1EigcdPfi4RGpMRVTTH28TuTkH1cyoA7sc4VDJHPtPBiLzKJYyD
   iyb0x+xtvnyfna9Ax22yWz+lwCxNqtIJkLBin1IGQk9QB8/hS0u32PjVp
   wjdn2h1s6EQPhpbtxzlNVQMg6hAdRRXwEdxQ5ypm0+4Mnpiy1LhOlcq8M
   utBR+uivg2lZimW3l+/30/BqTzx7Iu3eiGPZqhVwiKDJe7wEUuONCt//R
   VNo1zD1Hg9sAtltA8Lx7tpfSG0tnP7EPgPHwlNz2KwnCqCOFoutBNQPSc
   Q==;
X-CSE-ConnectionGUID: jcS6YXj8TUeojhHX0njBmA==
X-CSE-MsgGUID: wNhlaVjYRq+5nI/RcD4Mlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084792"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084792"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:00 -0800
X-CSE-ConnectionGUID: r4qWq3ezSYGieijDr30g7Q==
X-CSE-MsgGUID: hfkdm/ipT4a0hiHQNdoESw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847480"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v2 07/14] wifi: cfg80211: store the chandefs used for NAN
Date: Thu,  8 Jan 2026 10:35:33 +0200
Message-Id: <20260108102921.ec1292e021b0.Ia465649c0e95be277422ada1a6034e761c1265a5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
References: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When the local NAN schedule is configured, store its chandefs,
it will be used later.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h |  2 ++
 net/wireless/core.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 net/wireless/core.h    |  4 ++++
 net/wireless/nl80211.c |  2 +-
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 640a63395e84..7b8e408528a4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6822,6 +6822,8 @@ struct wireless_dev {
 		} ocb;
 		struct {
 			u8 cluster_id[ETH_ALEN] __aligned(2);
+			u8 n_channels;
+			struct cfg80211_chan_def *chandefs;
 		} nan;
 	} u;
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index e53e486b1449..0429ee8237e1 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -254,6 +254,8 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev)
 {
+	struct cfg80211_nan_local_sched empty_sched = {};
+
 	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_NAN))
@@ -262,12 +264,51 @@ void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 	if (!wdev_running(wdev))
 		return;
 
+	/* Unschedule all */
+	cfg80211_nan_set_local_schedule(rdev, wdev, &empty_sched);
+
 	rdev_stop_nan(rdev, wdev);
 	wdev->is_running = false;
 
 	rdev->opencount--;
 }
 
+int cfg80211_nan_set_local_schedule(struct cfg80211_registered_device *rdev,
+				    struct wireless_dev *wdev,
+				    struct cfg80211_nan_local_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	if (wdev->iftype != NL80211_IFTYPE_NAN || !wdev_running(wdev))
+		return -EINVAL;
+
+	ret = rdev_nan_set_local_sched(rdev, wdev, sched);
+	if (ret)
+		return ret;
+
+	kfree(wdev->u.nan.chandefs);
+	wdev->u.nan.chandefs = NULL;
+	wdev->u.nan.n_channels = 0;
+
+	if (!sched->n_channels)
+		return 0;
+
+	wdev->u.nan.chandefs = kcalloc(sched->n_channels,
+				       sizeof(*wdev->u.nan.chandefs),
+				       GFP_KERNEL);
+	if (!wdev->u.nan.chandefs)
+		return -ENOMEM;
+
+	for (int i = 0; i < sched->n_channels; i++)
+		wdev->u.nan.chandefs[i] = sched->nan_channels[i].chandef;
+
+	wdev->u.nan.n_channels = sched->n_channels;
+
+	return 0;
+}
+
 void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 63dcf315dba7..463fbcefca49 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -545,6 +545,10 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev);
 
+int cfg80211_nan_set_local_schedule(struct cfg80211_registered_device *rdev,
+				    struct wireless_dev *wdev,
+				    struct cfg80211_nan_local_sched *sched);
+
 struct cfg80211_internal_bss *
 cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 		    struct cfg80211_internal_bss *tmp,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0f9e0e931b5f..5831a9b7a2c8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16393,7 +16393,7 @@ static int nl80211_nan_set_local_sched(struct sk_buff *skb,
 		}
 	}
 
-	return rdev_nan_set_local_sched(rdev, wdev, sched);
+	return cfg80211_nan_set_local_schedule(rdev, wdev, sched);
 }
 
 static int nl80211_get_protocol_features(struct sk_buff *skb,
-- 
2.34.1


