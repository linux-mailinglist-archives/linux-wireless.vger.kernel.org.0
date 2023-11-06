Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C4F7E2FAD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Nov 2023 23:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjKFWR3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Nov 2023 17:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjKFWR3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Nov 2023 17:17:29 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D667D73
        for <linux-wireless@vger.kernel.org>; Mon,  6 Nov 2023 14:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=xrCmiEwh59q5iF2khtEqmNhqiQOtKHREoAp6ADnpnCE=; t=1699309046; x=1700518646; 
        b=dURkzZ31viu5LQuWaxnNoXM/11fy9m8runMSVLBJ4gstQp1KGYP6pdJhxoQ0fnd2xd9W1ZoUXm+
        psiZV0t/crhXHsV/a5FStAhNyn+EsYhDCQmpBQcGTv37VLVqzCEvyBmcn8oAzsxBUB1bR/bc077hy
        rxOuRocoRsGMWZ4GSRC8vQAOD22uYSskDLnaKfZjvOvJY6QyEQrkaFY/+uDDxcw9t2XZJP0PFxuLH
        1yGjLUfVzTP2cPPU0lSnUWmOUHdGq4Fv6YP9Ja8AT+mnRp0dcldn6EEucSc51dm1+yV1HZxOdYmQr
        YuHy86iWFi1c4xryr6mTlS3qgpQF4ZigoMNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r07uM-0000000FvtR-3tGv;
        Mon, 06 Nov 2023 23:17:23 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Max Schulze <max.schulze@online.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
Date:   Mon,  6 Nov 2023 23:17:16 +0100
Message-ID: <20231106231715.3a506ac2dadb.Ie774b85b9d4ff934a1236e77096cb9c6c9fe6561@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

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
index 4c692c7faf30..cb61d33d4f1e 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -293,6 +293,7 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	enum nl80211_cqm_rssi_threshold_event last_rssi_event_type;
+	bool use_range_api;
 	int n_rssi_thresholds;
 	s32 rssi_thresholds[] __counted_by(n_rssi_thresholds);
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 569234bc2be6..dbfed5a2d7b6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12787,10 +12787,6 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int i, n, low_index;
 	int err;
 
-	/* RSSI reporting disabled? */
-	if (!cqm_config)
-		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
-
 	/*
 	 * Obtain current RSSI value if possible, if not and no RSSI threshold
 	 * event has been received yet, we should receive an event after a
@@ -12865,23 +12861,25 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
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
 
 	old = wiphy_dereference(wdev->wiphy, wdev->cqm_config);
 
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
@@ -12894,13 +12892,26 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
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
@@ -19009,10 +19020,11 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy, struct wiphy_work *work)
 	s32 rssi_level;
 
 	cqm_config = wiphy_dereference(wdev->wiphy, wdev->cqm_config);
-	if (!wdev->cqm_config)
+	if (!cqm_config)
 		return;
 
-	cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
+	if (cqm_config->use_range_api)
+		cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
 
 	rssi_level = cqm_config->last_rssi_event_value;
 	rssi_event = cqm_config->last_rssi_event_type;
-- 
2.41.0

