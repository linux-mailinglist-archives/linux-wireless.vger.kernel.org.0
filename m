Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748AB6F8A87
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjEEVFw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 17:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEEVFw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 17:05:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE362736
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=yD5KqW6fleOp1VeyJMpJ5WuchVlGk+M1lU7YCoBSrXQ=; t=1683320749; x=1684530349; 
        b=bRc9Mmpi77a8Q+ga1nTq3+22tsOWGdAqfFOafqltCSMWQ3ZYg/YH+/94rEzCNyEwHuT4rFZV7e7
        M7OkXAq5GLzoaLhBIfcRzyQaA99pfUfrLRhTwOv599fzrzbHsDW01L6yAboQqVHjPGBwcSya/IQGu
        cWq8lXingrVQSSxmVVK0oisBruUM2PbAj8VH8KPnKjx+YiYHkobwC6gykRsF0eivy12eoPKf28oin
        ixCLNZRnMuiGcej/7rT7ChpHuw+OVROfeU1YBA2bX51soYj+Zgwh4bdlOeWyqg5hsVr9jYaUl8fCR
        enRgpC+zh/I46NlEUrBPwlp/y42KcsamvNVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pv2cc-000XRt-1E;
        Fri, 05 May 2023 23:05:46 +0200
Message-ID: <f3471853cd7063a4bd2d783caa14706ee9115748.camel@sipsolutions.net>
Subject: wireless locking simplifications
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Date:   Fri, 05 May 2023 23:05:45 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Recently, partially prompted by the issues we accidentally introduced
with multi-link in mac80211, I've been thinking again about locking
simplifications in wifi again.

I don't entirely remember the last time I looked at this, but I had
approached this as "let's remove a mutex at a time", e.g. removing the
sta_mtx in mac80211. This ends up failing, and a large part of the
reason for this is the complexity in the layers of the stack, combined
with the many work structs we use. See, the thing with work structs is
that you have to make sure to cancel them, and you can't while holding a
lock that the work might also take [1].

Now why is that so much of an issue? It's mostly an issue because of the
layering in the stack - we might need to flush a work struct in mac80211
when told to do something by userspace, i.e. via cfg80211/nl80211, but
we also use cfg80211's locks (sdata_lock() =3D=3D wdev_lock()), and cfg8021=
1
doesn't know about the works that might need to be flushed.

I'll also add a couple of additional observations:

 1) The wdev->mtx is pretty much useless, we almost always hold the
    wiphy->mtx as well, only in a few regulatory and wext cases we
    don't. I actually suspect this saves us in quite a few places, as
    the locking with wdev->mtx is far from consistent.

 2) The locking is extremely difficult to reason about :-)

 3) Drivers tend to have their own big "per-device" lock, similar to
    wiphy->mtx (e.g. iwlwifi's mvm->mutex) which is held for basically
    everything in the control plane, which makes concurrency not really
    exist, similar to (1).

 4) At least in mac80211, most work structs are on the ordered workqueue
    that it allocates, again meaning there's basically no concurrency.
    Even where today we have per-STA locks like sta->ampdu_mlme.mtx.


Looking at all that, we realize that there's effectively no multi-
threading in the cfg80211 code nor in the mac80211 control plane. Which
means all this complexity is for nothing ... and really it just grew out
of making lockdep happy with various different code paths acquiring
different locking order, and particularly because of cfg80211 and
workers.


So I've started to think we actually can radically simplify the locking
in the wifi stack:

 1) We can remove wdev->mtx, and simply make wdev_lock() and
    sdata_lock() be lockdep assertions on holding wiphy->mtx. This seems
    surprisingly easy, only a few places in cfg80211 (reg, wext) seem to
    not have that already, and in mac80211 it's a few more.

 2) If we can have a cfg80211 per-wiphy workqueue with special
    semantics, notably the semantics being that nothing can execute on
    it while you're in a wiphy_lock()ed section. That is, not even a
    worker can run there that's stuck on wiphy_lock() itself, which can
    happen today and leads to all the cancel issues once you start
    reducing locking complexity.

 3) We can effectively remove all other mutexes in mac80211, and just
    always wiphy_lock(). In fact even drivers could eventually do that.


The implementation of (2) is a bit ... awkward, @Tejun, @Lai, there's no
way to "pause" an ordered workqueue, is there? I came up with the below
patch, but it's a bit ugly and requires a lot of context switches. Just
flushing isn't enough since then some work might start and hang on
acquiring the lock.


johannes

[1] which I hope is obvious by now, I remember explaining this to many
people after I added the lockdep annotations 15 years ago in commit
4e6045f13478 ("workqueue: debug flushing deadlocks with lockdep") :)



diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 725c88d28e0d..9016ae853350 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5403,6 +5403,9 @@ struct wiphy_iftype_akm_suites {
  */
 struct wiphy {
 	struct mutex mtx;
+#ifdef CONFIG_LOCKDEP
+	bool mutex_fully_held;
+#endif
=20
 	/* assign these fields before you register the wiphy */
=20
@@ -5722,22 +5725,105 @@ struct cfg80211_internal_bss;
 struct cfg80211_cached_keys;
 struct cfg80211_cqm_config;
=20
+/**
+ * wiphy_lock_from_worker - lock the wiphy from worker on cfg80211 workque=
ue
+ * @wiphy: the wiphy to lock
+ *
+ * If the driver uses the cfg80211 workqueue (see wiphy_queue_work())
+ * and the workers need to lock the wiphy, this version must be used.
+ *
+ * (Note: this is a macro for the _ONCE part of the warning.)
+ */
+#define wiphy_lock_from_worker(wiphy) do {			\
+	__acquire(&(wiphy)->mtx);				\
+	mutex_lock(&(wiphy)->mtx);				\
+	/* FIXME: can this be done better? */			\
+	WARN_ON_ONCE(strncmp(current->comm, "kworker/", 8));	\
+} while (0)
+
 /**
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
-static inline void wiphy_lock(struct wiphy *wiphy)
-	__acquires(&wiphy->mtx)
+void wiphy_lock(struct wiphy *wiphy) __acquires(&wiphy->mtx);
+
+/**
+ * wiphy_queue_work - queue work for the wiphy
+ * @wiphy: the wiphy to queue for
+ * @work: the worker
+ *
+ * This is useful for work that must be done asynchronously, and work
+ * queued here has the special property that it cannot run concurrently
+ * with any wiphy_lock() section, even if it doesn't use
+ * wiphy_lock_from_worker() itself. Therefore, wiphy_cancel_work() can
+ * use just cancel_work() instead of cancel_work_sync(), it requires
+ * being in a section protected by wiphy_lock().
+ */
+void wiphy_queue_work(struct wiphy *wiphy, struct work_struct *work);
+
+/**
+ * wiphy_cancel_work - cancel previously queued work
+ * @wiphy: the wiphy, for debug purposes
+ * @work: the work to cancel
+ *
+ * Cancel the work *without* waiting for it, this assumes being
+ * called under the wiphy mutex acquired by wiphy_lock().
+ */
+static inline void wiphy_cancel_work(struct wiphy *wiphy, struct work_stru=
ct *work)
+{
+#ifdef CONFIG_LOCKDEP
+	lockdep_assert_held(&wiphy->mtx);
+	WARN_ON_ONCE(!wiphy->mutex_fully_held);
+#endif
+	cancel_work(work);
+}
+
+/**
+ * wiphy_queue_delayed_work - queue delayed work for the wiphy
+ * @wiphy: the wiphy to queue for
+ * @dwork: the delayable worker
+ * @delay: number of jiffies to wait before queueing
+ *
+ * This is useful for work that must be done asynchronously, and work
+ * queued here has the special property that it cannot run concurrently
+ * with any wiphy_lock() section, even if it doesn't use
+ * wiphy_lock_from_worker() itself. Therefore,
+ * wiphy_cancel_delayed_work() can use just cancel_delayed_work()
+ * instead of cancel_delayed_work_sync(), it requires being in a
+ * section protected by wiphy_lock().
+ */
+void wiphy_queue_delayed_work(struct wiphy *wiphy,
+			      struct delayed_work *dwork,
+			      unsigned long delay);
+
+/**
+ * wiphy_cancel_delayed_work - cancel previously queued delayed work
+ * @wiphy: the wiphy, for debug purposes
+ * @dwork: the delayed work to cancel
+ *
+ * Cancel the work *without* waiting for it, this assumes being
+ * called under the wiphy mutex acquired by wiphy_lock().
+ */
+static inline void wiphy_cancel_delayed_work(struct wiphy *wiphy,
+					     struct delayed_work *dwork)
 {
-	mutex_lock(&wiphy->mtx);
-	__acquire(&wiphy->mtx);
+#ifdef CONFIG_LOCKDEP
+	lockdep_assert_held(&wiphy->mtx);
+	WARN_ON_ONCE(!wiphy->mutex_fully_held);
+#endif
+	cancel_delayed_work(dwork);
 }
=20
 /**
@@ -5748,6 +5834,9 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
 	__releases(&wiphy->mtx)
 {
 	__release(&wiphy->mtx);
+#ifdef CONFIG_LOCKDEP
+	wiphy->mutex_fully_held =3D false;
+#endif
 	mutex_unlock(&wiphy->mtx);
 }
=20
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 2492242da5c8..c4e4a506d33e 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -408,6 +408,20 @@ static void cfg80211_propagate_cac_done_wk(struct work=
_struct *work)
 	rtnl_unlock();
 }
=20
+static void wiphy_work_sync(struct work_struct *work)
+{
+	struct cfg80211_registered_device *rdev;
+
+	rdev =3D container_of(work, struct cfg80211_registered_device,
+			    wq_sync_work);
+
+	complete(&rdev->wq_sync_started);
+	wait_for_completion(&rdev->wq_sync_continue);
+	/* we'll now hang on the lock until the other side unlocks */
+	wiphy_lock_from_worker(&rdev->wiphy);
+	wiphy_unlock(&rdev->wiphy);
+}
+
 /* exported functions */
=20
 struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv=
,
@@ -500,6 +514,11 @@ use_default_name:
 	}
=20
 	mutex_init(&rdev->wiphy.mtx);
+	INIT_WORK(&rdev->wq_sync_work, wiphy_work_sync);
+	mutex_init(&rdev->wq_sync_mtx);
+	init_completion(&rdev->wq_sync_started);
+	init_completion(&rdev->wq_sync_continue);
+
 	INIT_LIST_HEAD(&rdev->wiphy.wdev_list);
 	INIT_LIST_HEAD(&rdev->beacon_registrations);
 	spin_lock_init(&rdev->beacon_registrations_lock);
@@ -540,6 +559,12 @@ use_default_name:
 		return NULL;
 	}
=20
+	rdev->wq =3D alloc_ordered_workqueue("%s", 0, dev_name(&rdev->wiphy.dev))=
;
+	if (!rdev->wq) {
+		wiphy_free(&rdev->wiphy);
+		return NULL;
+	}
+
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
@@ -1073,6 +1098,13 @@ void wiphy_unregister(struct wiphy *wiphy)
 	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
=20
+	/*
+	 * flush again, even if wiphy_lock() did above, something might
+	 * have been reaching it still while the code above was running,
+	 * e.g. via debugfs.
+	 */
+	flush_workqueue(rdev->wq);
+
 	flush_work(&rdev->scan_done_wk);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
@@ -1098,6 +1130,10 @@ void cfg80211_dev_free(struct cfg80211_registered_de=
vice *rdev)
 {
 	struct cfg80211_internal_bss *scan, *tmp;
 	struct cfg80211_beacon_registration *reg, *treg;
+
+	if (rdev->wq) /* might be NULL in error cases */
+		destroy_workqueue(rdev->wq);
+
 	rfkill_destroy(rdev->wiphy.rfkill);
 	list_for_each_entry_safe(reg, treg, &rdev->beacon_registrations, list) {
 		list_del(&reg->list);
@@ -1573,6 +1609,66 @@ static struct pernet_operations cfg80211_pernet_ops =
=3D {
 	.exit =3D cfg80211_pernet_exit,
 };
=20
+void wiphy_lock(struct wiphy *wiphy)
+{
+	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
+
+	/* lock the sync mutex so we're the only one using the work */
+	mutex_lock(&rdev->wq_sync_mtx);
+	/* flush the work in case it didn't complete yet after lock */
+	flush_work(&rdev->wq_sync_work);
+	/* reinit the completions so we can use them again */
+	reinit_completion(&rdev->wq_sync_started);
+	reinit_completion(&rdev->wq_sync_continue);
+
+	/* queue the work */
+	wiphy_queue_work(wiphy, &rdev->wq_sync_work);
+	/* and wait for it to start */
+	wait_for_completion(&rdev->wq_sync_started);
+
+	/*
+	 * Now that the special work is running (we got the completion
+	 * from it) actually take the wiphy mutex, if anything is now
+	 * on the workqueue it's queued, but not running, and cannot
+	 * be trying to take the lock.
+	 */
+	mutex_lock(&wiphy->mtx);
+
+	/* and tell the worker to also continue and do that */
+	complete(&rdev->wq_sync_continue);
+
+	/*
+	 * No longer need that now, the worker is now stuck waiting for
+	 * the mutex we own and anyone else calling wiphy_lock() can get
+	 * the wq_sync_mtx, but will wait on flushing the worker first,
+	 * then do it all over again...
+	 */
+	mutex_unlock(&rdev->wq_sync_mtx);
+
+#ifdef CONFIG_LOCKDEP
+	wiphy->mutex_fully_held =3D true;
+#endif
+}
+EXPORT_SYMBOL(wiphy_lock);
+
+void wiphy_queue_work(struct wiphy *wiphy, struct work_struct *work)
+{
+	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
+
+	queue_work(rdev->wq, work);
+}
+EXPORT_SYMBOL(wiphy_queue_work);
+
+void wiphy_queue_delayed_work(struct wiphy *wiphy,
+			      struct delayed_work *dwork,
+			      unsigned long delay)
+{
+	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
+
+	queue_delayed_work(rdev->wq, dwork, delay);
+}
+EXPORT_SYMBOL(wiphy_queue_delayed_work);
+
 static int __init cfg80211_init(void)
 {
 	int err;
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 5887b0d30619..b9de20b1b188 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -109,6 +109,12 @@ struct cfg80211_registered_device {
 	/* lock for all wdev lists */
 	spinlock_t mgmt_registrations_lock;
=20
+	struct workqueue_struct *wq;
+	struct mutex wq_sync_mtx;
+	struct completion wq_sync_started;
+	struct completion wq_sync_continue;
+	struct work_struct wq_sync_work;
+
 	/* must be last because of the way we do wiphy_priv(),
 	 * and it should at least be aligned to NETDEV_ALIGN */
 	struct wiphy wiphy __aligned(NETDEV_ALIGN);

