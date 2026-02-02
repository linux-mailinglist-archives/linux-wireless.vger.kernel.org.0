Return-Path: <linux-wireless+bounces-31470-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA7RHfLVgGmFBwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31470-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:50:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E7CF2A7
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EAB43015B99
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B033803EF;
	Mon,  2 Feb 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzoa80T/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748537FF45
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051056; cv=none; b=axo6/0GxTglLYE+upJXUjhX+ceXeq04eyCVFex8hgiw/JdGbiStmuebl9nRI3E9j3xPq+UtQLkc66H+28zeS69xJ8AIKS9QGPIsjxOpPv4PvlSEp6g42sAuC8VLqi1EgkpR4k/UWUKPca2BoUVpyBDMPGdqQq2heHVDhicETLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051056; c=relaxed/simple;
	bh=Wv3MvDpyvzDt3/3Z75YAxGSAnQsl9aY8TXDmoC+5Vws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n6NnnEisb0xf6v0eQtqRUK+3UmBsoV/e4GNbnlS4BR1T61txFB6CwIhySX/ILe+yc6SSdAveHAkQPK3X+qu8GTdUh3n3i4pogZMJjGSoY3p9MLpn5449at9jdOOPe/aifCAPyklgu4aoOfLQJ4/86oXdwMont55TMz6NOq/gfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzoa80T/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38320cd563aso50914731fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770051052; x=1770655852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXStMOcOs3qq9dYQVN931NMsz+LlJsLLOYss+bFtNnM=;
        b=Bzoa80T/4j9rdTP7c7hnG2t9Q2Erhuyn4AP49yWIcdJ0iwL4ORD6t51v85ak9UZerT
         7j5Qhq78d4qTGc7FNGA3M1tXXCYx6kqYRT2yiLpt9xzAQvNPCA+tI5jVwn5O1DUOt7Jk
         v1N2Nw/AM0CBBr5aPC5ZwKQrWVs7QMc2K9Kv927tPXAPdvrUejl2iM0hhNVfLpHXfKtn
         oEWqdL3dOKeqxTnoMChyk0jO5Mh5pWEfqqj/HvWKMtYJZouxnsJI5rRikI2hqpzZTmLe
         aoxjjxcwOgzqpYQissh6fPdQMEEEcE7N8NgXvWCC32FK/ZWL7/L56YgYepW2KHn6oZmi
         8fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770051052; x=1770655852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXStMOcOs3qq9dYQVN931NMsz+LlJsLLOYss+bFtNnM=;
        b=KAfGXSeASqoXghU/2FTSgUZ8FT++qvMTy8vGEh45LN4D1aTT9IYmg42d1zbinIqCO5
         7Nvbrdx6HOzdBhyEQHkwj977DWKN4+MshOyV+F/YpXgSxtJKIWEgJvoj8aeNlxCsjtMx
         /R4uL27MzrbI4DNCTOrIlklA4vrYNT23htjMeu1agh6mE0wJ6+UBFBYFBXsn/Y1Ym3MV
         XQANZmpT3eF6oYHxOsgML7KOjKVn/w9wDdvg64TzAGc1/kefksprgOr/hkwXW/Sqm5AK
         5I0/epaE7SnXypyYZDq01EtQ3ydLgf5/int8nuIh2mXqjb33ccbM3S7DAb8jN+TQ6upz
         9xMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBZMFzyGgh6YHHjsStsFGxCAEXWEtr5KfinZS6sEkhj91new6dpTFmVfLRtna5wnamsDDjZB6DhRzi60F96g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyE2CYTQRCpwWjPXnOzVHPImeYI4gd0N5xdfdGjoQe4ab0nJLL
	8C43DwCrI5eEC6+bnJU9FBBC5dqQcZBquYudp+LBR8aQSdiaMAiq3837
X-Gm-Gg: AZuq6aIy+/As0zNxmxwXo6xhkIc2ddTU4y0wYxapF+qzfWTkskeCR89XBR5ZpfR9D0L
	Yt8wgQTpI8UuHUnCK3jkk2Y4DOuydGCQ86UOrdEmTdvo1h+i/HnBT12EcJD0zOGpKgOq1IM4Ak9
	r4VhM8S6XMMLlE54ZEuJ4QWf/S8YmuYZJGf7XqwKVW2NFdminLuf/V3CdxiRVzO6osNzU3XBev9
	PQJ8eqZw4eMEtNvFHpYtBagM0GSqb6OUuys/1ODJVtzF0vHoMEp5mKjVn1UNmC/bljE+IJsNcgm
	Rkalxt73z1F7GwWqzycfzawWcRtSlg7KuCnf12snsiOG393/ltv6xmYhG6l3wbLTTvTGeB+d83H
	vFrhXNuX6o63LyKJbo+ll48FiqanumC2iCMYoLFpXUvkW/B5/esruMwMm0Rv/FEaYat7rFexIkX
	JyldCktg2u8WZQBW/s2xVSIFvrWzkeySJj4Xkhm3WrQ/wmIg/irvpmnCGq3uf8VCqLuL4DloSv0
	+Mpu5ZURw==
X-Received: by 2002:a05:651c:f10:b0:385:d744:c8d7 with SMTP id 38308e7fff4ca-3864660148bmr35034311fa.22.1770051052010;
        Mon, 02 Feb 2026 08:50:52 -0800 (PST)
Received: from uuba.fritz.box (2001-14ba-6e-3100-2ef5-59d5-c9b3-566.rev.dnainternet.fi. [2001:14ba:6e:3100:2ef5:59d5:c9b3:566])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625ad8ae0sm31718571fa.0.2026.02.02.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:50:51 -0800 (PST)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 5.15.y 1/3] wifi: cfg80211: add a work abstraction with special semantics
Date: Mon,  2 Feb 2026 18:50:36 +0200
Message-ID: <20260202165038.215693-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.2.g2258446484
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.33 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.83)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31470-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hannelotta@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 199E7CF2A7
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a3ee4dc84c4e9d14cb34dad095fd678127aca5b6 ]

Add a work abstraction at the cfg80211 level that will always
hold the wiphy_lock() for any work executed and therefore also
can be canceled safely (without waiting) while holding that.
This improves on what we do now as with the new wiphy works we
don't have to worry about locking while cancelling them safely.

Also, don't let such works run while the device is suspended,
since they'll likely need to interact with the device. Flush
them before suspend though.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 include/net/cfg80211.h |  95 ++++++++++++++++++++++++++++++--
 net/wireless/core.c    | 121 +++++++++++++++++++++++++++++++++++++++++
 net/wireless/core.h    |   7 +++
 net/wireless/sysfs.c   |   8 ++-
 4 files changed, 226 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 66a75723f559..392576342661 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5301,12 +5301,17 @@ struct cfg80211_cqm_config;
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
@@ -5326,6 +5331,88 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
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
index d51d27ff3729..788ca1055d6a 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -410,6 +410,34 @@ static void cfg80211_propagate_cac_done_wk(struct work_struct *work)
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
@@ -535,6 +563,9 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		return NULL;
 	}
 
+	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
+	INIT_LIST_HEAD(&rdev->wiphy_work_list);
+	spin_lock_init(&rdev->wiphy_work_lock);
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
@@ -1002,6 +1033,31 @@ void wiphy_rfkill_start_polling(struct wiphy *wiphy)
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
@@ -1040,9 +1096,14 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cfg80211_rdev_list_generation++;
 	device_del(&rdev->wiphy.dev);
 
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
@@ -1522,6 +1583,66 @@ static struct pernet_operations cfg80211_pernet_ops = {
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
index 1720abf36f92..18d30f6fa7ca 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -103,6 +103,12 @@ struct cfg80211_registered_device {
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
@@ -457,6 +463,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 			  struct net_device *dev, enum nl80211_iftype ntype,
 			  struct vif_params *params);
 void cfg80211_process_rdev_events(struct cfg80211_registered_device *rdev);
+void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev);
 void cfg80211_process_wdev_events(struct wireless_dev *wdev);
 
 bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 0c3f05c9be27..4d3b65803010 100644
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
2.53.0.rc2.2.g2258446484


