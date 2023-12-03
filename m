Return-Path: <linux-wireless+bounces-341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2276802689
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 20:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E751280DC6
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DC1799F;
	Sun,  3 Dec 2023 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FR1O4y24"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF4AD9;
	Sun,  3 Dec 2023 11:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=cioFoySinJ5xB1a4o/XjAjtZDDSreClLISRnn8ZJbRc=; t=1701630527; x=1702840127; 
	b=FR1O4y24myZReIeMIePdP7gv1A9tI+M0BmiQ74cDjAnaSS2mCBZ7tat+zBfIFKl07GArTP6tuYJ
	WBRyaJQYtXUzWZZEm1H+uI+nF1XaAZRBgDwdNxzhlq9/nztTPgshYkeuftpcb9OnG8E03+q8e2lhd
	tAw/G4IVCNcQMTZPIx0/3iXkyvk6g60ljGDDU2KltiiFzUnWWrbgstEV7lzQmQiaZCzDIrFbwjt65
	MSs4R8vN76FnHSqIa1iWP/1gT/C+PfPS8NUHuaEluxosNZAH63/0MngiGT5N5pka0tf7wDzJL6KST
	DzBA9nfXPdBAiHfC+PoI0TDisj4QFjLszJqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r9rpc-0000000Dml8-3AOW;
	Sun, 03 Dec 2023 20:08:45 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1,6.6] wifi: cfg80211: fix CQM for non-range use
Date: Sun,  3 Dec 2023 20:08:41 +0100
Message-ID: <20231203190842.25478-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Commit 7e7efdda6adb385fbdfd6f819d76bc68c923c394 upstream.

My prior race fix here broke CQM when ranges aren't used, as
the reporting worker now requires the cqm_config to be set in
the wdev, but isn't set when there's no range configured.

Rather than continuing to special-case the range version, set
the cqm_config always and configure accordingly, also tracking
if range was used or not to be able to clear the configuration
appropriately with the same API, which was actually not right
if both were implemented by a driver for some reason, as is
the case with mac80211 (though there the implementations are
equivalent so it doesn't matter.)

Also, the original multiple-RSSI commit lost checking for the
callback, so might have potentially crashed if a driver had
neither implementation, and userspace tried to use it despite
not being advertised as supported.

Cc: stable@vger.kernel.org
Fixes: 4a4b8169501b ("cfg80211: Accept multiple RSSI thresholds for CQM")
Fixes: 37c20b2effe9 ("wifi: cfg80211: fix cqm_config access race")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.h    |  1 +
 net/wireless/nl80211.c | 50 ++++++++++++++++++++++++++----------------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index e1accacc6f23..ee980965a7cf 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -297,6 +297,7 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	enum nl80211_cqm_rssi_threshold_event last_rssi_event_type;
+	bool use_range_api;
 	int n_rssi_thresholds;
 	s32 rssi_thresholds[];
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b19b5acfaf3a..42c858219b34 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12574,10 +12574,6 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int i, n, low_index;
 	int err;
 
-	/* RSSI reporting disabled? */
-	if (!cqm_config)
-		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
-
 	/*
 	 * Obtain current RSSI value if possible, if not and no RSSI threshold
 	 * event has been received yet, we should receive an event after a
@@ -12652,18 +12648,6 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
-	if (n_thresholds <= 1 && rdev->ops->set_cqm_rssi_config) {
-		if (n_thresholds == 0 || thresholds[0] == 0) /* Disabling */
-			return rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
-
-		return rdev_set_cqm_rssi_config(rdev, dev,
-						thresholds[0], hysteresis);
-	}
-
-	if (!wiphy_ext_feature_isset(&rdev->wiphy,
-				     NL80211_EXT_FEATURE_CQM_RSSI_LIST))
-		return -EOPNOTSUPP;
-
 	if (n_thresholds == 1 && thresholds[0] == 0) /* Disabling */
 		n_thresholds = 0;
 
@@ -12671,6 +12655,20 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	old = rcu_dereference_protected(wdev->cqm_config,
 					lockdep_is_held(&wdev->mtx));
 
+	/* if already disabled just succeed */
+	if (!n_thresholds && !old)
+		return 0;
+
+	if (n_thresholds > 1) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_CQM_RSSI_LIST) ||
+		    !rdev->ops->set_cqm_rssi_range_config)
+			return -EOPNOTSUPP;
+	} else {
+		if (!rdev->ops->set_cqm_rssi_config)
+			return -EOPNOTSUPP;
+	}
+
 	if (n_thresholds) {
 		cqm_config = kzalloc(struct_size(cqm_config, rssi_thresholds,
 						 n_thresholds),
@@ -12685,13 +12683,26 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		memcpy(cqm_config->rssi_thresholds, thresholds,
 		       flex_array_size(cqm_config, rssi_thresholds,
 				       n_thresholds));
+		cqm_config->use_range_api = n_thresholds > 1 ||
+					    !rdev->ops->set_cqm_rssi_config;
 
 		rcu_assign_pointer(wdev->cqm_config, cqm_config);
+
+		if (cqm_config->use_range_api)
+			err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
+		else
+			err = rdev_set_cqm_rssi_config(rdev, dev,
+						       thresholds[0],
+						       hysteresis);
 	} else {
 		RCU_INIT_POINTER(wdev->cqm_config, NULL);
+		/* if enabled as range also disable via range */
+		if (old->use_range_api)
+			err = rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
+		else
+			err = rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
 	}
 
-	err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
 	if (err) {
 		rcu_assign_pointer(wdev->cqm_config, old);
 		kfree_rcu(cqm_config, rcu_head);
@@ -18758,10 +18769,11 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy, struct wiphy_work *work)
 	wdev_lock(wdev);
 	cqm_config = rcu_dereference_protected(wdev->cqm_config,
 					       lockdep_is_held(&wdev->mtx));
-	if (!wdev->cqm_config)
+	if (!cqm_config)
 		goto unlock;
 
-	cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
+	if (cqm_config->use_range_api)
+		cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
 
 	rssi_level = cqm_config->last_rssi_event_value;
 	rssi_event = cqm_config->last_rssi_event_type;
-- 
2.43.0


