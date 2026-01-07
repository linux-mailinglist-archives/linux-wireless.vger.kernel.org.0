Return-Path: <linux-wireless+bounces-30448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E370CFDE50
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A55B3002949
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFEC328B67;
	Wed,  7 Jan 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBeigGpS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8CD329C40
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792022; cv=none; b=TYQn7cQaU8u+c3flcUp5VipnlddAgG+y6/DbVKmcH156lKIuKAB82grbSay//9pVsP6kiVDU4kMBiG221B2MpDmHJgyro9GDd3X/WNW8uv7Fe/WasQ5qXQHYrOSLMGcR5JIZBYR3nbS3rzGvRg6QaZiRhQ4/XVZOMKR5eyCIaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792022; c=relaxed/simple;
	bh=SQzSVhhp0OVWycT2K9bZyA6t0YM3n1u0k8oeFDDRpBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSg8I6eLpwC5qkkKR9LPpnr0wzQuDNTSxCShs87JfEaqUZDDFYhLyIIJkB0ZM6rwBistOpm3GwitEFAml4uJlpFQJ3d1Z68hdPHjaG7WaTbCSVQ3xamfv2eyAhbudqXvT701kC5aNYX3sFX52uW8nPGGSSSPVhxrmgOjjAFSEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBeigGpS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792021; x=1799328021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQzSVhhp0OVWycT2K9bZyA6t0YM3n1u0k8oeFDDRpBE=;
  b=OBeigGpSRRHX6FLLoWCeuy25iQn78OPHLeCwUact0w4rZBdwjksAZJLL
   Mq/vHcmUwiy15YaT1mzi1fNtR1pedyRVXRWcWu+yJtOQiGLTEajLXGic3
   x7p8zo40M0YauoRj4CObf4RrYQYM7dHr8fCRbj9BpcFeoJBUi+r0WjrPV
   ABG7m/7QPDdK6+9ATgxMCgPFXDQNc4BLGWWf5D5I7s+BOS6w63KpE2TJU
   EyVnte6A8VLT89olrrPYQoPGK+QIj9UXJuU/RgCzyhOOsdCCarTIIbY7a
   Rg74Q2Oil3VH+2WnKMsQ4D1OJmRc8L/WB75Yy7BLSlxWWiBLNvYwb8byn
   Q==;
X-CSE-ConnectionGUID: pcSOPcmrQO2azxBFCP0XOA==
X-CSE-MsgGUID: 7RjsIEyNR3WaP0e04DVaRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576862"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576862"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:20 -0800
X-CSE-ConnectionGUID: Aq5DoQM0RjqAIO05h4t/cQ==
X-CSE-MsgGUID: AzGoXqJvQtKUw8AyzmLInw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185751"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: cfg80211: store the chandefs used for NAN
Date: Wed,  7 Jan 2026 15:19:54 +0200
Message-Id: <20260107150057.a579e7573e42.Ia465649c0e95be277422ada1a6034e761c1265a5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
References: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
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
index 9a420d627d3c..2500f86adbe7 100644
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


