Return-Path: <linux-wireless+bounces-14859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2219BB18E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895511F2312E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D037E1B3944;
	Mon,  4 Nov 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGOLnNjq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F61B393A;
	Mon,  4 Nov 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717452; cv=none; b=QH95I/qK091S/s/F/Bv+o34OkTKHZijtXHbrI+kNbsD3h7NHq0glDKSZ4ofbhnM9dSeZwsh6YAQdAk9F1a+YPSK6ZnunF7nUbDpPJaHMTQwA8dYxyed84oeioztK0TZnjhCO+B4seO/N0QM6NFJatNzjiXArGiZDLUpbG9DTIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717452; c=relaxed/simple;
	bh=BEhUphVLncoOW1jNPnqbSpuNCfbWjD2QF5RjAi2vTlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZrfrDruvLRPv/bVd9aed0aOoiqllJQO+tKSL1X9efBu7UmREjEbq+7GrcuukODeZVhOfkxcnLLdx0Go1hWSM6OnRVoNoZpeabd/t1SgN9l1zXRel0faGV2Xl7NF5Yx+NeMJa+EdZluidoZMdDQCI30hGSM6xLsu4qoPFOCSl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGOLnNjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E091C4CED1;
	Mon,  4 Nov 2024 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717452;
	bh=BEhUphVLncoOW1jNPnqbSpuNCfbWjD2QF5RjAi2vTlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGOLnNjqTzAYj2MkAChingNNvn5m6D7XckjT76d3qLPYxEXJO7ZExfBGQH8AWEXRU
	 x1xjnkNfS78HhchGlnXenROsdha73/b6MHlZ2z86yYlpXryUZ1VCNZ2ZxnMl5Ky9l4
	 adV9cMiIGoKdf3y2DVQ2HSdWm4jzG/14+lo0v0VKU/PtrkSzTRSIgGbHRUn5pHS8Z6
	 xicV+/q3iegRHrZuhMyjJG3tx5no1CUadKwO2Lvu/ToHAgl6DEjPlRMc+L8QjsQy/Y
	 XykV+6aui3JWIqZswMYCSPdnLZCPdVBRZyJNgcBw1kvbvMgPXxIq1yPBAuM4Zaa670
	 xI0Cec9zSCxBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Remi Pommarel <repk@triplefau.lt>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 02/21] wifi: cfg80211: Add wiphy_delayed_work_pending()
Date: Mon,  4 Nov 2024 05:49:38 -0500
Message-ID: <20241104105048.96444-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Remi Pommarel <repk@triplefau.lt>

[ Upstream commit 68d0021fe7231eec0fb84cd110cf62a6e782b72d ]

Add wiphy_delayed_work_pending() to check if any delayed work timer is
pending, that can be used to be sure that wiphy_delayed_work_queue()
won't postpone an already pending delayed work.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Link: https://patch.msgid.link/20240924192805.13859-2-repk@triplefau.lt
[fix return value kernel-doc]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h | 44 ++++++++++++++++++++++++++++++++++++++++++
 net/wireless/core.c    |  7 +++++++
 2 files changed, 51 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 192d72c8b4654..702653448d2fc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6129,6 +6129,50 @@ void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 void wiphy_delayed_work_flush(struct wiphy *wiphy,
 			      struct wiphy_delayed_work *dwork);
 
+/**
+ * wiphy_delayed_work_pending - Find out whether a wiphy delayable
+ * work item is currently pending.
+ *
+ * @wiphy: the wiphy, for debug purposes
+ * @dwork: the delayed work in question
+ *
+ * Return: true if timer is pending, false otherwise
+ *
+ * How wiphy_delayed_work_queue() works is by setting a timer which
+ * when it expires calls wiphy_work_queue() to queue the wiphy work.
+ * Because wiphy_delayed_work_queue() uses mod_timer(), if it is
+ * called twice and the second call happens before the first call
+ * deadline, the work will rescheduled for the second deadline and
+ * won't run before that.
+ *
+ * wiphy_delayed_work_pending() can be used to detect if calling
+ * wiphy_work_delayed_work_queue() would start a new work schedule
+ * or delayed a previous one. As seen below it cannot be used to
+ * detect precisely if the work has finished to execute nor if it
+ * is currently executing.
+ *
+ *      CPU0                                CPU1
+ * wiphy_delayed_work_queue(wk)
+ *  mod_timer(wk->timer)
+ *                                     wiphy_delayed_work_pending(wk) -> true
+ *
+ * [...]
+ * expire_timers(wk->timer)
+ *  detach_timer(wk->timer)
+ *                                     wiphy_delayed_work_pending(wk) -> false
+ *  wk->timer->function()                          |
+ *   wiphy_work_queue(wk)                          | delayed work pending
+ *    list_add_tail()                              | returns false but
+ *    queue_work(cfg80211_wiphy_work)              | wk->func() has not
+ *                                                 | been run yet
+ * [...]                                           |
+ *  cfg80211_wiphy_work()                          |
+ *   wk->func()                                    V
+ *
+ */
+bool wiphy_delayed_work_pending(struct wiphy *wiphy,
+				struct wiphy_delayed_work *dwork);
+
 /**
  * enum ieee80211_ap_reg_power - regulatory power for an Access Point
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4d5d351bd0b51..c9a1158dbdd11 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1704,6 +1704,13 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL_GPL(wiphy_delayed_work_flush);
 
+bool wiphy_delayed_work_pending(struct wiphy *wiphy,
+				struct wiphy_delayed_work *dwork)
+{
+	return timer_pending(&dwork->timer);
+}
+EXPORT_SYMBOL_GPL(wiphy_delayed_work_pending);
+
 static int __init cfg80211_init(void)
 {
 	int err;
-- 
2.43.0


