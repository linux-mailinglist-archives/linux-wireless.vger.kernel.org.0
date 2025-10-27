Return-Path: <linux-wireless+bounces-28312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E123C0D97E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 13:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC0D19A1862
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1364301498;
	Mon, 27 Oct 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXtj9opc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F632F6909;
	Mon, 27 Oct 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568447; cv=none; b=lcUAamJcTpjq3ZDVvZS26YO5SDqs0Lan1AinnoAaskuMBLmn3tcFQ0hVorhRCa/wFvzRdiirqTA9ZNjgnJC/P1/aAzTxjSuTCHHVchGNIkane0wdplJYP3AB8MqPwKLe/3iZDLySDG2WMCGiTmiujGCBCmrH2QnDRIpdheeXM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568447; c=relaxed/simple;
	bh=WXaciFZ1d3yz0EpJ42U+2cIBdp81rq3lXvRPicy2Nq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2XnmVtiX1aBzFfKDwGOPlQddjAPcZmYtT9n9w6onaSSrnS16RUtNg4L+s+XVV9t/aejFnmIMl4I1N2TeC7bLe58iEJztTBLxkG470yTpMvXkbV8DD5FkUXZjcabnDyg6+j0DBvntX6gW09U8eNa+sLZP+H4tCOn235fzt2FIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXtj9opc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761568445; x=1793104445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WXaciFZ1d3yz0EpJ42U+2cIBdp81rq3lXvRPicy2Nq4=;
  b=kXtj9opcZIyWakaRiYTM6Rrl3Tck96YEMmGLGTClx0EFj5elwtqtoyks
   KIVKVQ1EHaDNmv9FwMZg95QGDIHDVjdvhwDlrPu1gr6yk/hLnkfTg1mpR
   SG334+WtOL7qWiUDjlWYbu05Lx8zGXl1uaMDmNxA3EQLWtgLCrTCYAlmm
   F6WuO7ydRy7Ll11XfVN0v5l9uUn5/RrtnFAh0Vz24fIf2/R+sVxN4qIoe
   J6fUXRFDd5rPqn2Pnwa3vR1JlLdczJgDFvvRYQREk18gZgLyCSX0LgeWa
   4QtxqDc7uUE0d2twVaaSCrlOV87KpOCfujhuBG+m5EirW+wE0MXNYDgRh
   Q==;
X-CSE-ConnectionGUID: udvpYNFZTyy+WGMKBBAHIw==
X-CSE-MsgGUID: Qe+Aj+3iQeqqIynvQEhSkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66258574"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66258574"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:05 -0700
X-CSE-ConnectionGUID: k2tJxcPnRPavLC5zq2+Jpg==
X-CSE-MsgGUID: VPTLGqM2ShOAURwph9Idhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="190162811"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v3 1/4] wifi: cfg80211: add an hrtimer based delayed work item
Date: Mon, 27 Oct 2025 14:33:54 +0200
Message-Id: <20251027143011.3aac3ace8c61.I01b5af0363869864b0580d9c2a1770bafab69566@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027123357.2221947-1-miriam.rachel.korenblit@intel.com>
References: <20251027123357.2221947-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The normal timer mechanism assume that timeout further in the future
need a lower accuracy. As an example, the granularity for a timer
scheduled 4096 ms in the future on a 1000 Hz system is already 512 ms.
This granularity is perfectly sufficient for e.g. timeouts, but there
are other types of events that will happen at a future point in time and
require a higher accuracy.

Add a new wiphy_hrtimer_work type that uses an hrtimer internally. The
API is almost identical to the existing wiphy_delayed_work and it can be
used as a drop-in replacement after minor adjustments. The work will be
scheduled relative to the current time with a slack of 1 millisecond.

CC: stable@vger.kernel.org # 6.4+
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 78 ++++++++++++++++++++++++++++++++++++++++++
 net/wireless/core.c    | 56 ++++++++++++++++++++++++++++++
 net/wireless/trace.h   | 21 ++++++++++++
 3 files changed, 155 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 53490eb04e87..f2e8963cfaac 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6440,6 +6440,11 @@ static inline void wiphy_delayed_work_init(struct wiphy_delayed_work *dwork,
  * after wiphy_lock() was called. Therefore, wiphy_cancel_work() can
  * use just cancel_work() instead of cancel_work_sync(), it requires
  * being in a section protected by wiphy_lock().
+ *
+ * Note that these are scheduled with a timer where the accuracy
+ * becomes less the longer in the future the scheduled timer is. Use
+ * wiphy_hrtimer_work_queue() if the timer must be not be late by more
+ * than approximately 10 percent.
  */
 void wiphy_delayed_work_queue(struct wiphy *wiphy,
 			      struct wiphy_delayed_work *dwork,
@@ -6511,6 +6516,79 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
 bool wiphy_delayed_work_pending(struct wiphy *wiphy,
 				struct wiphy_delayed_work *dwork);
 
+struct wiphy_hrtimer_work {
+	struct wiphy_work work;
+	struct wiphy *wiphy;
+	struct hrtimer timer;
+};
+
+enum hrtimer_restart wiphy_hrtimer_work_timer(struct hrtimer *t);
+
+static inline void wiphy_hrtimer_work_init(struct wiphy_hrtimer_work *hrwork,
+					   wiphy_work_func_t func)
+{
+	hrtimer_setup(&hrwork->timer, wiphy_hrtimer_work_timer,
+		      CLOCK_BOOTTIME, HRTIMER_MODE_REL);
+	wiphy_work_init(&hrwork->work, func);
+}
+
+/**
+ * wiphy_hrtimer_work_queue - queue hrtimer work for the wiphy
+ * @wiphy: the wiphy to queue for
+ * @hrwork: the high resolution timer worker
+ * @delay: the delay given as a ktime_t
+ *
+ * Please refer to wiphy_delayed_work_queue(). The difference is that
+ * the hrtimer work uses a high resolution timer for scheduling. This
+ * may be needed if timeouts might be scheduled further in the future
+ * and the accuracy of the normal timer is not sufficient.
+ *
+ * Expect a delay of a few milliseconds as the timer is scheduled
+ * with some slack and some more time may pass between queueing the
+ * work and its start.
+ */
+void wiphy_hrtimer_work_queue(struct wiphy *wiphy,
+			      struct wiphy_hrtimer_work *hrwork,
+			      ktime_t delay);
+
+/**
+ * wiphy_hrtimer_work_cancel - cancel previously queued hrtimer work
+ * @wiphy: the wiphy, for debug purposes
+ * @hrtimer: the hrtimer work to cancel
+ *
+ * Cancel the work *without* waiting for it, this assumes being
+ * called under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_hrtimer_work_cancel(struct wiphy *wiphy,
+			       struct wiphy_hrtimer_work *hrtimer);
+
+/**
+ * wiphy_hrtimer_work_flush - flush previously queued hrtimer work
+ * @wiphy: the wiphy, for debug purposes
+ * @hrwork: the hrtimer work to flush
+ *
+ * Flush the work (i.e. run it if pending). This must be called
+ * under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_hrtimer_work_flush(struct wiphy *wiphy,
+			      struct wiphy_hrtimer_work *hrwork);
+
+/**
+ * wiphy_hrtimer_work_pending - Find out whether a wiphy hrtimer
+ * work item is currently pending.
+ *
+ * @wiphy: the wiphy, for debug purposes
+ * @hrwork: the hrtimer work in question
+ *
+ * Return: true if timer is pending, false otherwise
+ *
+ * Please refer to the wiphy_delayed_work_pending() documentation as
+ * this is the equivalent function for hrtimer based delayed work
+ * items.
+ */
+bool wiphy_hrtimer_work_pending(struct wiphy *wiphy,
+				struct wiphy_hrtimer_work *hrwork);
+
 /**
  * enum ieee80211_ap_reg_power - regulatory power for an Access Point
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index f3568eb5e592..9f858a83e912 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1802,6 +1802,62 @@ bool wiphy_delayed_work_pending(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL_GPL(wiphy_delayed_work_pending);
 
+enum hrtimer_restart wiphy_hrtimer_work_timer(struct hrtimer *t)
+{
+	struct wiphy_hrtimer_work *hrwork =
+		container_of(t, struct wiphy_hrtimer_work, timer);
+
+	wiphy_work_queue(hrwork->wiphy, &hrwork->work);
+
+	return HRTIMER_NORESTART;
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_timer);
+
+void wiphy_hrtimer_work_queue(struct wiphy *wiphy,
+			      struct wiphy_hrtimer_work *hrwork,
+			      ktime_t delay)
+{
+	trace_wiphy_hrtimer_work_queue(wiphy, &hrwork->work, delay);
+
+	if (!delay) {
+		hrtimer_cancel(&hrwork->timer);
+		wiphy_work_queue(wiphy, &hrwork->work);
+		return;
+	}
+
+	hrwork->wiphy = wiphy;
+	hrtimer_start_range_ns(&hrwork->timer, delay,
+			       1000 * NSEC_PER_USEC, HRTIMER_MODE_REL);
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_queue);
+
+void wiphy_hrtimer_work_cancel(struct wiphy *wiphy,
+			       struct wiphy_hrtimer_work *hrwork)
+{
+	lockdep_assert_held(&wiphy->mtx);
+
+	hrtimer_cancel(&hrwork->timer);
+	wiphy_work_cancel(wiphy, &hrwork->work);
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_cancel);
+
+void wiphy_hrtimer_work_flush(struct wiphy *wiphy,
+			      struct wiphy_hrtimer_work *hrwork)
+{
+	lockdep_assert_held(&wiphy->mtx);
+
+	hrtimer_cancel(&hrwork->timer);
+	wiphy_work_flush(wiphy, &hrwork->work);
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_flush);
+
+bool wiphy_hrtimer_work_pending(struct wiphy *wiphy,
+				struct wiphy_hrtimer_work *hrwork)
+{
+	return hrtimer_is_queued(&hrwork->timer);
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_pending);
+
 static int __init cfg80211_init(void)
 {
 	int err;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 8a4c34112eb5..2b71f1d867a0 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -304,6 +304,27 @@ TRACE_EVENT(wiphy_delayed_work_queue,
 		  __entry->delay)
 );
 
+TRACE_EVENT(wiphy_hrtimer_work_queue,
+	TP_PROTO(struct wiphy *wiphy, struct wiphy_work *work,
+		 ktime_t delay),
+	TP_ARGS(wiphy, work, delay),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		__field(void *, instance)
+		__field(void *, func)
+		__field(ktime_t, delay)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		__entry->instance = work;
+		__entry->func = work->func;
+		__entry->delay = delay;
+	),
+	TP_printk(WIPHY_PR_FMT " instance=%p func=%pS delay=%llu",
+		  WIPHY_PR_ARG, __entry->instance, __entry->func,
+		  __entry->delay)
+);
+
 TRACE_EVENT(wiphy_work_worker_start,
 	TP_PROTO(struct wiphy *wiphy),
 	TP_ARGS(wiphy),
-- 
2.34.1


