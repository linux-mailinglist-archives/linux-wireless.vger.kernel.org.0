Return-Path: <linux-wireless+bounces-603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCD880BAD2
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A339280CC2
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4085CC134;
	Sun, 10 Dec 2023 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SU5w1PW7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EFDA6
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213580; x=1733749580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bb5x8+eQJcewH52YJEzXMEkrnaV/wpmrOQuSev97E7Y=;
  b=SU5w1PW7nWX7q0+nVi/jSEr+c4Kov2uEoUfZu0WTG1BGjCYFM3HDjc7Y
   kKV2kLmEUYXPq9KYNM6r9InOyo0GMY2g7RIX/meOzeuUiwOROxTuV7WF1
   8xJlxbzS3qpI4nvHd46zmTdOvxfGpvmbRXibir8EoKw/AA7KcydRwardo
   s/IcZSeYR1tW8C4xAVUhIbuDScfFQzscjp+cF004hCkzTtd8a2Lb84ItT
   BS8cEaOWeJFEg7hia5Yb3//GXnGfgZHdmlIYOsvzveENoeRFBg1fHSnkB
   ALTfyWO8WPsLB8d0LOm6ztnNTj8XQ7GLbTDXtmvTAwxHYSNLgjljf9j4o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480746073"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480746073"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748926239"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748926239"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Berg@web.codeaurora.org, Johannes <johannes.berg@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 08/14] wifi: cfg80211: Replace ENOTSUPP with EOPNOTSUPP
Date: Mon, 11 Dec 2023 09:05:26 +0200
Message-Id: <20231211085121.0214b6c79756.I2536bc8426ae15c8cff7ad199e57f06e2e404f13@changeid>
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

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

ENOTSUPP isn't a standard error code, don't use it.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c  | 4 ++--
 net/wireless/rdev-ops.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2faf02895c01..59a1a235fce9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4853,7 +4853,7 @@ static struct cfg80211_acl_data *parse_acl_data(struct wiphy *wiphy,
 		return ERR_PTR(n_entries);
 
 	if (n_entries > wiphy->max_acl_mac_addrs)
-		return ERR_PTR(-ENOTSUPP);
+		return ERR_PTR(-EOPNOTSUPP);
 
 	acl = kzalloc(struct_size(acl, mac_addrs, n_entries), GFP_KERNEL);
 	if (!acl)
@@ -15867,7 +15867,7 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 
 	if (tid_conf->mask & ~mask) {
 		NL_SET_ERR_MSG(extack, "unsupported TID configuration");
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 2a27a3448759..43897a5269b6 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1046,7 +1046,7 @@ rdev_nan_change_conf(struct cfg80211_registered_device *rdev,
 		ret = rdev->ops->nan_change_conf(&rdev->wiphy, wdev, conf,
 						 changes);
 	else
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
@@ -1200,7 +1200,7 @@ rdev_start_radar_detection(struct cfg80211_registered_device *rdev,
 			   struct cfg80211_chan_def *chandef,
 			   u32 cac_time_ms)
 {
-	int ret = -ENOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_start_radar_detection(&rdev->wiphy, dev, chandef,
 					 cac_time_ms);
@@ -1226,7 +1226,7 @@ rdev_set_mcast_rate(struct cfg80211_registered_device *rdev,
 		    struct net_device *dev,
 		    int mcast_rate[NUM_NL80211_BANDS])
 {
-	int ret = -ENOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_set_mcast_rate(&rdev->wiphy, dev, mcast_rate);
 	if (rdev->ops->set_mcast_rate)
@@ -1239,7 +1239,7 @@ static inline int
 rdev_set_coalesce(struct cfg80211_registered_device *rdev,
 		  struct cfg80211_coalesce *coalesce)
 {
-	int ret = -ENOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	trace_rdev_set_coalesce(&rdev->wiphy, coalesce);
 	if (rdev->ops->set_coalesce)
-- 
2.34.1


