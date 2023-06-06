Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83126724306
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbjFFMuQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbjFFMuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B851719
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xO4zHhc2wDSuJK9bddkQbFb1BCmNxZ2aKeUBvUa21SY=;
        t=1686055784; x=1687265384; b=QRdFlRTogD4lQ0SK43JUbu5elE7vEZNCyAKs2/ZY8rUA7OE
        zAy2GocV1CfoSBGIcPjFZHAvPm5FG4BT/rO5c1XZp+QkUsanfu05SMJUA8X9HE6s2dbmj7R8caXvn
        6fm852EtENGt9X8IfvJhy5SOy64obKD54AYwF+EG+GSw0N2s7dJaOHcXkr+1k3FphVOPATsdxIoo2
        ppupS0S1GU9BK2EBooLDhf8NgMLPECx44XctrMJi+DjdtxIpyVhVceaiSfmmcV4s04t8I78tyjElG
        Y4SYLZWeU31BhXMDtAh5MhL2ox2AFgnKEXEZffFPfiAiHHq+HBZXjOFzfeFS1X4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W83-00FZDP-0I;
        Tue, 06 Jun 2023 14:49:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/14] wifi: cfg80211: add a work abstraction with special semantics
Date:   Tue,  6 Jun 2023 14:49:25 +0200
Message-Id: <20230606144753.3c9a1a90db92.I28a06f59bf647db6dea519e6fca1894f94227d73@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606124933.181107-1-johannes@sipsolutions.net>
References: <20230606124933.181107-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a work abstraction at the cfg80211 level that will always
hold the wiphy_lock() for any work executed and therefore also
can be canceled safely (without waiting) while holding that.
This improves on what we do now as with the new wiphy works we
don't have to worry about locking while cancelling them safely.

Also, don't let such works run while the device is suspended,
since they'll likely need to interact with the device. Flush
them before suspend though.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  95 ++++++++++++++++++++++++++++++--
 net/wireless/core.c    | 122 +++++++++++++++++++++++++++++++++++++++++
 net/wireless/core.h    |   7 +++
 net/wireless/sysfs.c   |   8 ++-
 4 files changed, 227 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..1b8619685bf6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5724,12 +5724,17 @@ struct cfg80211_cqm_config;
  * wiphy_lock - lock the wiphy
  * @wiphy: the wiphy to lock
  *
- * This is mostly exposed so it can be done around registering and
- * unregistering netdevs that aren't created through cfg80211 calls,
- * since that requires locking in cfg80211 when the notifiers is
- * called, but that cannot differentiate which way it's called.
+ * This is needed around registering and unregistering netdevs that
+ * aren't created through cfg80211 calls, since that requires locking
+ * in cfg80211 when the notifiers is called, but that cannot
+ * differentiate which way it's called.
+ *
+ * It can also be used by drivers for their own purposes.
  *
  * When cfg80211 ops are called, the wiphy is already locked.
+ *
+ * Note that this makes sure that no workers that have been queued
+ * with wiphy_queue_work() are running.
  */
 static inline void wiphy_lock(struct wiphy *wiphy)
 	__acquires(&wiphy->mtx)
@@ -5749,6 +5754,88 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
 	mutex_unlock(&wiphy->mtx);
 }
 
+struct wiphy_work;
+typedef void (*wiphy_work_func_t)(struct wiphy *, struct wiphy_work *);
+
+struct wiphy_work {
+	struct list_head entry;
+	wiphy_work_func_t func;
+};
+
+static inline void wiphy_work_init(struct wiphy_work *work,
+				   wiphy_work_func_t func)
+{
+	INIT_LIST_HEAD(&work->entry);
+	work->func = func;
+}
+
+/**
+ * wiphy_work_queue - queue work for the wiphy
+ * @wiphy: the wiphy to queue for
+ * @work: the work item
+ *
+ * This is useful for work that must be done asynchronously, and work
+ * queued here has the special property that the wiphy mutex will be
+ * held as if wiphy_lock() was called, and that it cannot be running
+ * after wiphy_lock() was called. Therefore, wiphy_cancel_work() can
+ * use just cancel_work() instead of cancel_work_sync(), it requires
+ * being in a section protected by wiphy_lock().
+ */
+void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work);
+
+/**
+ * wiphy_work_cancel - cancel previously queued work
+ * @wiphy: the wiphy, for debug purposes
+ * @work: the work to cancel
+ *
+ * Cancel the work *without* waiting for it, this assumes being
+ * called under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_work_cancel(struct wiphy *wiphy, struct wiphy_work *work);
+
+struct wiphy_delayed_work {
+	struct wiphy_work work;
+	struct wiphy *wiphy;
+	struct timer_list timer;
+};
+
+void wiphy_delayed_work_timer(struct timer_list *t);
+
+static inline void wiphy_delayed_work_init(struct wiphy_delayed_work *dwork,
+					   wiphy_work_func_t func)
+{
+	timer_setup(&dwork->timer, wiphy_delayed_work_timer, 0);
+	wiphy_work_init(&dwork->work, func);
+}
+
+/**
+ * wiphy_delayed_work_queue - queue delayed work for the wiphy
+ * @wiphy: the wiphy to queue for
+ * @dwork: the delayable worker
+ * @delay: number of jiffies to wait before queueing
+ *
+ * This is useful for work that must be done asynchronously, and work
+ * queued here has the special property that the wiphy mutex will be
+ * held as if wiphy_lock() was called, and that it cannot be running
+ * after wiphy_lock() was called. Therefore, wiphy_cancel_work() can
+ * use just cancel_work() instead of cancel_work_sync(), it requires
+ * being in a section protected by wiphy_lock().
+ */
+void wiphy_delayed_work_queue(struct wiphy *wiphy,
+			      struct wiphy_delayed_work *dwork,
+			      unsigned long delay);
+
+/**
+ * wiphy_delayed_work_cancel - cancel previously queued delayed work
+ * @wiphy: the wiphy, for debug purposes
+ * @dwork: the delayed work to cancel
+ *
+ * Cancel the work *without* waiting for it, this assumes being
+ * called under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_delayed_work_cancel(struct wiphy *wiphy,
+			       struct wiphy_delayed_work *dwork);
+
 /**
  * struct wireless_dev - wireless device state
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 97f01b94c3e2..3b37bbc4e8d2 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -413,6 +413,34 @@ static void cfg80211_propagate_cac_done_wk(struct work_struct *work)
 	rtnl_unlock();
 }
 
+static void cfg80211_wiphy_work(struct work_struct *work)
+{
+	struct cfg80211_registered_device *rdev;
+	struct wiphy_work *wk;
+
+	rdev = container_of(work, struct cfg80211_registered_device, wiphy_work);
+
+	wiphy_lock(&rdev->wiphy);
+	if (rdev->suspended)
+		goto out;
+
+	spin_lock_irq(&rdev->wiphy_work_lock);
+	wk = list_first_entry_or_null(&rdev->wiphy_work_list,
+				      struct wiphy_work, entry);
+	if (wk) {
+		list_del_init(&wk->entry);
+		if (!list_empty(&rdev->wiphy_work_list))
+			schedule_work(work);
+		spin_unlock_irq(&rdev->wiphy_work_lock);
+
+		wk->func(&rdev->wiphy, wk);
+	} else {
+		spin_unlock_irq(&rdev->wiphy_work_lock);
+	}
+out:
+	wiphy_unlock(&rdev->wiphy);
+}
+
 /* exported functions */
 
 struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
@@ -538,6 +566,9 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		return NULL;
 	}
 
+	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
+	INIT_LIST_HEAD(&rdev->wiphy_work_list);
+	spin_lock_init(&rdev->wiphy_work_lock);
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
@@ -1035,6 +1066,31 @@ void wiphy_rfkill_start_polling(struct wiphy *wiphy)
 }
 EXPORT_SYMBOL(wiphy_rfkill_start_polling);
 
+void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev)
+{
+	unsigned int runaway_limit = 100;
+	unsigned long flags;
+
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+	while (!list_empty(&rdev->wiphy_work_list)) {
+		struct wiphy_work *wk;
+
+		wk = list_first_entry(&rdev->wiphy_work_list,
+				      struct wiphy_work, entry);
+		list_del_init(&wk->entry);
+		spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+
+		wk->func(&rdev->wiphy, wk);
+
+		spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+		if (WARN_ON(--runaway_limit == 0))
+			INIT_LIST_HEAD(&rdev->wiphy_work_list);
+	}
+	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+}
+
 void wiphy_unregister(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -1077,9 +1133,15 @@ void wiphy_unregister(struct wiphy *wiphy)
 	if (rdev->wiphy.wowlan_config && rdev->ops->set_wakeup)
 		rdev_set_wakeup(rdev, false);
 #endif
+
+	/* surely nothing is reachable now, clean up work */
+	cfg80211_process_wiphy_works(rdev);
 	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
 
+	/* this has nothing to do now but make sure it's gone */
+	cancel_work_sync(&rdev->wiphy_work);
+
 	flush_work(&rdev->scan_done_wk);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
@@ -1569,6 +1631,66 @@ static struct pernet_operations cfg80211_pernet_ops = {
 	.exit = cfg80211_pernet_exit,
 };
 
+void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	unsigned long flags;
+
+	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+	if (list_empty(&work->entry))
+		list_add_tail(&work->entry, &rdev->wiphy_work_list);
+	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+
+	schedule_work(&rdev->wiphy_work);
+}
+EXPORT_SYMBOL_GPL(wiphy_work_queue);
+
+void wiphy_work_cancel(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	unsigned long flags;
+
+	lockdep_assert_held(&wiphy->mtx);
+
+	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+	if (!list_empty(&work->entry))
+		list_del_init(&work->entry);
+	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+}
+EXPORT_SYMBOL_GPL(wiphy_work_cancel);
+
+void wiphy_delayed_work_timer(struct timer_list *t)
+{
+	struct wiphy_delayed_work *dwork = from_timer(dwork, t, timer);
+
+	wiphy_work_queue(dwork->wiphy, &dwork->work);
+}
+EXPORT_SYMBOL(wiphy_delayed_work_timer);
+
+void wiphy_delayed_work_queue(struct wiphy *wiphy,
+			      struct wiphy_delayed_work *dwork,
+			      unsigned long delay)
+{
+	if (!delay) {
+		wiphy_work_queue(wiphy, &dwork->work);
+		return;
+	}
+
+	dwork->wiphy = wiphy;
+	mod_timer(&dwork->timer, jiffies + delay);
+}
+EXPORT_SYMBOL_GPL(wiphy_delayed_work_queue);
+
+void wiphy_delayed_work_cancel(struct wiphy *wiphy,
+			       struct wiphy_delayed_work *dwork)
+{
+	lockdep_assert_held(&wiphy->mtx);
+
+	del_timer_sync(&dwork->timer);
+	wiphy_work_cancel(wiphy, &dwork->work);
+}
+EXPORT_SYMBOL_GPL(wiphy_delayed_work_cancel);
+
 static int __init cfg80211_init(void)
 {
 	int err;
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 7c61752f6d83..435060dad81e 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -108,6 +108,12 @@ struct cfg80211_registered_device {
 	/* lock for all wdev lists */
 	spinlock_t mgmt_registrations_lock;
 
+	struct work_struct wiphy_work;
+	struct list_head wiphy_work_list;
+	/* protects the list above */
+	spinlock_t wiphy_work_lock;
+	bool suspended;
+
 	/* must be last because of the way we do wiphy_priv(),
 	 * and it should at least be aligned to NETDEV_ALIGN */
 	struct wiphy wiphy __aligned(NETDEV_ALIGN);
@@ -453,6 +459,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 			  struct net_device *dev, enum nl80211_iftype ntype,
 			  struct vif_params *params);
 void cfg80211_process_rdev_events(struct cfg80211_registered_device *rdev);
+void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev);
 void cfg80211_process_wdev_events(struct wireless_dev *wdev);
 
 bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 268f670835e9..c629bac3f298 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -5,7 +5,7 @@
  *
  * Copyright 2005-2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2006	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2020-2021 Intel Corporation
+ * Copyright (C) 2020-2021, 2023 Intel Corporation
  */
 
 #include <linux/device.h>
@@ -105,14 +105,18 @@ static int wiphy_suspend(struct device *dev)
 			cfg80211_leave_all(rdev);
 			cfg80211_process_rdev_events(rdev);
 		}
+		cfg80211_process_wiphy_works(rdev);
 		if (rdev->ops->suspend)
 			ret = rdev_suspend(rdev, rdev->wiphy.wowlan_config);
 		if (ret == 1) {
 			/* Driver refuse to configure wowlan */
 			cfg80211_leave_all(rdev);
 			cfg80211_process_rdev_events(rdev);
+			cfg80211_process_wiphy_works(rdev);
 			ret = rdev_suspend(rdev, NULL);
 		}
+		if (ret == 0)
+			rdev->suspended = true;
 	}
 	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
@@ -132,6 +136,8 @@ static int wiphy_resume(struct device *dev)
 	wiphy_lock(&rdev->wiphy);
 	if (rdev->wiphy.registered && rdev->ops->resume)
 		ret = rdev_resume(rdev);
+	rdev->suspended = false;
+	schedule_work(&rdev->wiphy_work);
 	wiphy_unlock(&rdev->wiphy);
 
 	if (ret)
-- 
2.40.1

