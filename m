Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380678AF82
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjH1MFo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjH1MFZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC81B120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2NOf0p6xta3MLRqleh3XRXfhhJ3BuN8o+XPiuNjvX1o=;
        t=1693224322; x=1694433922; b=o7xx3NojIfF37FfI0BNP4mR3BPJWw9ou8MKX3ehJUL5UsCH
        Y9RtQjqtKYf8pNJJ7m8QMhfzHhi5I5YZpNP22xvvjxJnHn1Yx3N3yzJ2/cVaJxe51Yx0ksvUVKNuA
        Yx692JUW2u6Q6GNTUGWCpDJlRO+8vSGCnmOTjnYoCiAbWy5/k1lNuenjpKKtr81WsNHqjQ9PL0j4E
        kne1f/cEziUx+n3xNY91UiGKEJ7Bvfrhbi6hnWj7AiXojWo2QBDq/vUDmMyiULJNzwWMiWZkaCHlM
        R7OUKyhAzvL44QLsu07pYuynTuNcUuseJTulAoXzYP9fsx1oVzkrINrG4ISzNITQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazg-00Gjgt-2Y;
        Mon, 28 Aug 2023 14:05:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/40] wifi: cfg80211: add flush functions for wiphy work
Date:   Mon, 28 Aug 2023 13:59:33 +0200
Message-ID: <20230828135927.16f4b838a4dd.I93b2697ae20e7ff04b96d624664b21b5084703ca@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There may be sometimes reasons to actually run the work
if it's pending, add flush functions for both regular and
delayed wiphy work that will do this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 21 +++++++++++++++++++++
 net/wireless/core.c    | 34 ++++++++++++++++++++++++++++++++--
 net/wireless/core.h    |  3 ++-
 net/wireless/sysfs.c   |  4 ++--
 4 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3a4b684f89bf..d1964a6d0b35 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5826,6 +5826,16 @@ void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work);
  */
 void wiphy_work_cancel(struct wiphy *wiphy, struct wiphy_work *work);
 
+/**
+ * wiphy_work_flush - flush previously queued work
+ * @wiphy: the wiphy, for debug purposes
+ * @work: the work to flush, this can be %NULL to flush all work
+ *
+ * Flush the work (i.e. run it if pending). This must be called
+ * under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_work_flush(struct wiphy *wiphy, struct wiphy_work *work);
+
 struct wiphy_delayed_work {
 	struct wiphy_work work;
 	struct wiphy *wiphy;
@@ -5869,6 +5879,17 @@ void wiphy_delayed_work_queue(struct wiphy *wiphy,
 void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 			       struct wiphy_delayed_work *dwork);
 
+/**
+ * wiphy_delayed work_flush - flush previously queued delayed work
+ * @wiphy: the wiphy, for debug purposes
+ * @work: the work to flush
+ *
+ * Flush the work (i.e. run it if pending). This must be called
+ * under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_delayed_work_flush(struct wiphy *wiphy,
+			      struct wiphy_delayed_work *dwork);
+
 /**
  * struct wireless_dev - wireless device state
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index fdb9d736a2e8..88042a647aaa 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1049,7 +1049,8 @@ void wiphy_rfkill_start_polling(struct wiphy *wiphy)
 }
 EXPORT_SYMBOL(wiphy_rfkill_start_polling);
 
-void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev)
+void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev,
+				  struct wiphy_work *end)
 {
 	unsigned int runaway_limit = 100;
 	unsigned long flags;
@@ -1068,6 +1069,10 @@ void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev)
 		wk->func(&rdev->wiphy, wk);
 
 		spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+
+		if (wk == end)
+			break;
+
 		if (WARN_ON(--runaway_limit == 0))
 			INIT_LIST_HEAD(&rdev->wiphy_work_list);
 	}
@@ -1118,7 +1123,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 #endif
 
 	/* surely nothing is reachable now, clean up work */
-	cfg80211_process_wiphy_works(rdev);
+	cfg80211_process_wiphy_works(rdev, NULL);
 	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
 
@@ -1640,6 +1645,21 @@ void wiphy_work_cancel(struct wiphy *wiphy, struct wiphy_work *work)
 }
 EXPORT_SYMBOL_GPL(wiphy_work_cancel);
 
+void wiphy_work_flush(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	unsigned long flags;
+	bool run;
+
+	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+	run = !work || !list_empty(&work->entry);
+	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+
+	if (run)
+		cfg80211_process_wiphy_works(rdev, work);
+}
+EXPORT_SYMBOL_GPL(wiphy_work_flush);
+
 void wiphy_delayed_work_timer(struct timer_list *t)
 {
 	struct wiphy_delayed_work *dwork = from_timer(dwork, t, timer);
@@ -1672,6 +1692,16 @@ void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL_GPL(wiphy_delayed_work_cancel);
 
+void wiphy_delayed_work_flush(struct wiphy *wiphy,
+			      struct wiphy_delayed_work *dwork)
+{
+	lockdep_assert_held(&wiphy->mtx);
+
+	del_timer_sync(&dwork->timer);
+	wiphy_work_flush(wiphy, &dwork->work);
+}
+EXPORT_SYMBOL_GPL(wiphy_delayed_work_flush);
+
 static int __init cfg80211_init(void)
 {
 	int err;
diff --git a/net/wireless/core.h b/net/wireless/core.h
index d4976550e7f6..b9876b444e1b 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -469,7 +469,8 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 			  struct net_device *dev, enum nl80211_iftype ntype,
 			  struct vif_params *params);
 void cfg80211_process_rdev_events(struct cfg80211_registered_device *rdev);
-void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev);
+void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev,
+				  struct wiphy_work *end);
 void cfg80211_process_wdev_events(struct wireless_dev *wdev);
 
 bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index c629bac3f298..565511a3f461 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -105,14 +105,14 @@ static int wiphy_suspend(struct device *dev)
 			cfg80211_leave_all(rdev);
 			cfg80211_process_rdev_events(rdev);
 		}
-		cfg80211_process_wiphy_works(rdev);
+		cfg80211_process_wiphy_works(rdev, NULL);
 		if (rdev->ops->suspend)
 			ret = rdev_suspend(rdev, rdev->wiphy.wowlan_config);
 		if (ret == 1) {
 			/* Driver refuse to configure wowlan */
 			cfg80211_leave_all(rdev);
 			cfg80211_process_rdev_events(rdev);
-			cfg80211_process_wiphy_works(rdev);
+			cfg80211_process_wiphy_works(rdev, NULL);
 			ret = rdev_suspend(rdev, NULL);
 		}
 		if (ret == 0)
-- 
2.41.0

