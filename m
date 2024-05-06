Return-Path: <linux-wireless+bounces-7233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A78BD510
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3F21C21976
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A02158DC9;
	Mon,  6 May 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A921KPvg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E39158D96
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022011; cv=none; b=mS33fqJpLnY7ojOVgOEGw9nHlvbkOYZ+0pvEPwyAjayNb8RuXr/YUnLLJ9dAu2u/cwPKY+1jKuZmG7WMSvrlcgTMO9ndIOpF4LQwJkqs2PTBechZHUSprvqbCgRPrp81AB55yb8ZGWdBxiCt0ZCvki+0Synijfqzyk25KtDKSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022011; c=relaxed/simple;
	bh=1TGk6rZZUvRjEK5RdFixJZVm2++6gzR7mVRaWq54rMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a74VbEhA+f5dOC3xnwjBMQq55nNNeNH5WuxrDBATR0l2Wyr1pAa5I6g65m+0Z+LOOV50IYR9s8GkiNkqq9qOGfvj4EgoCmZwy+IQyjd1Vy6ewP/TSk21WUv/TWM7IVS3lR8Jya9VEydFwAHuX8hfdaxBpS4oL18dQHOoOvw2QjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A921KPvg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=t1YnA/Zsc4cP/hbhAnETxlNoXYIzyDi5A3TW6+oTvWk=;
	t=1715022009; x=1716231609; b=A921KPvgf5XZ+WacIRCoW3jpGTzo+di5vWO2YtUqBVmuNdC
	Xg9CFQVaKLEqLJw56c6Ao3RuK3CKs/iT9DCMh9P/6iBWmxpx9nAoSOBxe5srF5DNpyNJi6tzzv8yh
	a3XSQZBNExNx0hWjBhRER1HY7sr1WLzsBnCi5Yf06DUTGrVXya/pxNu1TN38ShtZiDIC6JyRlD2YL
	1hK0SoL9SI9LBirLtmozObQBzsZbbItsFkDU/KkvY9m585wzgO/Z6hmNIVEc5/WumROrjHONrnfl1
	QFWkUeMKXAyn6KBHSjClXu72PIXAFETJEPeH8nO9PhuHzwUrkHVAU5z5m7FiiLJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43ZF-0000000899m-3BGT;
	Mon, 06 May 2024 21:00:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/2] wifi: cfg80211: add tracing for wiphy work
Date: Mon,  6 May 2024 21:00:03 +0200
Message-ID: <20240506210002.bf1840a1d22d.I4abba048c1c4017345640219cf1384a0b2288dd3@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506210002.0b3a86a5d8d7.I5591c03223bdb95597e181de63a2eded424de34c@changeid>
References: <20240506210002.0b3a86a5d8d7.I5591c03223bdb95597e181de63a2eded424de34c@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add trace events to trace when wiphy works are queued (or
delayed ones scheduled), and other APIs are called. Also
add an event when the worker starts, before acquiring the
mutex, to be able to see potential delays due to locking.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c  | 12 +++++++
 net/wireless/trace.h | 74 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4b1f45e3070e..820c0ae610e3 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -421,6 +421,8 @@ static void cfg80211_wiphy_work(struct work_struct *work)
 
 	rdev = container_of(work, struct cfg80211_registered_device, wiphy_work);
 
+	trace_wiphy_work_worker_start(&rdev->wiphy);
+
 	wiphy_lock(&rdev->wiphy);
 	if (rdev->suspended)
 		goto out;
@@ -434,6 +436,7 @@ static void cfg80211_wiphy_work(struct work_struct *work)
 			queue_work(system_unbound_wq, work);
 		spin_unlock_irq(&rdev->wiphy_work_lock);
 
+		trace_wiphy_work_run(&rdev->wiphy, wk);
 		wk->func(&rdev->wiphy, wk);
 	} else {
 		spin_unlock_irq(&rdev->wiphy_work_lock);
@@ -1066,6 +1069,7 @@ void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev,
 		list_del_init(&wk->entry);
 		spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 
+		trace_wiphy_work_run(&rdev->wiphy, wk);
 		wk->func(&rdev->wiphy, wk);
 
 		spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
@@ -1610,6 +1614,8 @@ void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work)
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	unsigned long flags;
 
+	trace_wiphy_work_queue(wiphy, work);
+
 	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
 	if (list_empty(&work->entry))
 		list_add_tail(&work->entry, &rdev->wiphy_work_list);
@@ -1626,6 +1632,8 @@ void wiphy_work_cancel(struct wiphy *wiphy, struct wiphy_work *work)
 
 	lockdep_assert_held(&wiphy->mtx);
 
+	trace_wiphy_work_cancel(wiphy, work);
+
 	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
 	if (!list_empty(&work->entry))
 		list_del_init(&work->entry);
@@ -1639,6 +1647,8 @@ void wiphy_work_flush(struct wiphy *wiphy, struct wiphy_work *work)
 	unsigned long flags;
 	bool run;
 
+	trace_wiphy_work_flush(wiphy, work);
+
 	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
 	run = !work || !list_empty(&work->entry);
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
@@ -1660,6 +1670,8 @@ void wiphy_delayed_work_queue(struct wiphy *wiphy,
 			      struct wiphy_delayed_work *dwork,
 			      unsigned long delay)
 {
+	trace_wiphy_delayed_work_queue(wiphy, &dwork->work, delay);
+
 	if (!delay) {
 		del_timer(&dwork->timer);
 		wiphy_work_queue(wiphy, &dwork->work);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index b76e3b21051a..14cfa0aba93a 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -242,6 +242,80 @@
 		}						\
 	} while (0)
 
+/*************************************************************
+ *			wiphy work traces		     *
+ *************************************************************/
+
+DECLARE_EVENT_CLASS(wiphy_work_event,
+	TP_PROTO(struct wiphy *wiphy, struct wiphy_work *work),
+	TP_ARGS(wiphy, work),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		__field(void *, instance)
+		__field(void *, func)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		__entry->instance = work;
+		__entry->func = work ? work->func : NULL;
+	),
+	TP_printk(WIPHY_PR_FMT " instance=%p func=%pS",
+		  WIPHY_PR_ARG, __entry->instance, __entry->func)
+);
+
+DEFINE_EVENT(wiphy_work_event, wiphy_work_queue,
+	TP_PROTO(struct wiphy *wiphy, struct wiphy_work *work),
+	TP_ARGS(wiphy, work)
+);
+
+DEFINE_EVENT(wiphy_work_event, wiphy_work_run,
+	TP_PROTO(struct wiphy *wiphy, struct wiphy_work *work),
+	TP_ARGS(wiphy, work)
+);
+
+DEFINE_EVENT(wiphy_work_event, wiphy_work_cancel,
+	TP_PROTO(struct wiphy *wiphy, struct wiphy_work *work),
+	TP_ARGS(wiphy, work)
+);
+
+DEFINE_EVENT(wiphy_work_event, wiphy_work_flush,
+	TP_PROTO(struct wiphy *wiphy, struct wiphy_work *work),
+	TP_ARGS(wiphy, work)
+);
+
+TRACE_EVENT(wiphy_delayed_work_queue,
+	TP_PROTO(struct wiphy *wiphy, struct wiphy_work *work,
+		 unsigned long delay),
+	TP_ARGS(wiphy, work, delay),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		__field(void *, instance)
+		__field(void *, func)
+		__field(unsigned long, delay)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		__entry->instance = work;
+		__entry->func = work->func;
+		__entry->delay = delay;
+	),
+	TP_printk(WIPHY_PR_FMT " instance=%p func=%pS delay=%ld",
+		  WIPHY_PR_ARG, __entry->instance, __entry->func,
+		  __entry->delay)
+);
+
+TRACE_EVENT(wiphy_work_worker_start,
+	TP_PROTO(struct wiphy *wiphy),
+	TP_ARGS(wiphy),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+	),
+	TP_printk(WIPHY_PR_FMT, WIPHY_PR_ARG)
+);
+
 /*************************************************************
  *			rdev->ops traces		     *
  *************************************************************/
-- 
2.44.0


