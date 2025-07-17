Return-Path: <linux-wireless+bounces-25614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD37EB091F4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 18:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FC916C64F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75262FCE2B;
	Thu, 17 Jul 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="FdW3Kql3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB211E5207
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770119; cv=none; b=PeOYT+NYlS32na5Bam0U71IuIvG9LAWX1xKUizycsAtaFglemFOMGfoRrx3nDPW/WMMKai+JApMvYAib8GulZTvJuDiEgz1ispCUT6D+8+Xl9xwqgRGd3SjkAPxDnlA13SbwspTCPXesZusM/MjUvmZ0Mz4w8QuaWyqgiSuVpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770119; c=relaxed/simple;
	bh=0NFLL3me1XRe/ez3VDPXWm4Yf/vrm+BIForIRp/9Yo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRVrq4xUPzvmjhZ6V61aA+LR4JPdagNIrFEuXgIdUyV0o16/XIIL8ABk2ixVhwtwasAtyZPhDFk2B+22zUHjFBhREfwPEyTzxRLgSVXs6hvb7d8YZQ7IHBwKaKWE9HVwyf9/8rzx683j1XsehVfuK7smbS2fp922D277Wc1MlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=FdW3Kql3; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1752769689;
	bh=0NFLL3me1XRe/ez3VDPXWm4Yf/vrm+BIForIRp/9Yo0=;
	h=From:To:Cc:Subject:Date;
	b=FdW3Kql3DqkNH7zAm/XHtyb2EFrV+MydNCb4zW8KkS/hzMwfOEa5S9LVLxAWOJ8CU
	 3GF80BO24Lnkar9FN3VhS/LIQMj8Ab4yxDl6Ci75IWBrUsCEFnJabaXTrHKPYhMVZB
	 QGq1Dwlz61fM6YRueSQqNEgy8h4ogvRoLAkLqhEI=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH wireless] wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()
Date: Thu, 17 Jul 2025 18:25:45 +0200
Message-ID: <20250717162547.94582-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of wdev_chandef() must hold the wiphy mutex.

But the worker cfg80211_propagate_cac_done_wk() never takes the lock.
Which triggers the warning below with the mesh_peer_connected_dfs
test from hostapd and not (yet) released mac80211 code changes:

WARNING: CPU: 0 PID: 495 at net/wireless/chan.c:1552 wdev_chandef+0x60/0x165
Modules linked in:
CPU: 0 UID: 0 PID: 495 Comm: kworker/u4:2 Not tainted 6.14.0-rc5-wt-g03960e6f9d47 #33 13c287eeabfe1efea01c0bcc863723ab082e17cf
Workqueue: cfg80211 cfg80211_propagate_cac_done_wk
Stack:
 00000000 00000001 ffffff00 6093267c
 00000000 6002ec30 6d577c50 60037608
 00000000 67e8d108 6063717b 00000000
Call Trace:
 [<6002ec30>] ? _printk+0x0/0x98
 [<6003c2b3>] show_stack+0x10e/0x11a
 [<6002ec30>] ? _printk+0x0/0x98
 [<60037608>] dump_stack_lvl+0x71/0xb8
 [<6063717b>] ? wdev_chandef+0x60/0x165
 [<6003766d>] dump_stack+0x1e/0x20
 [<6005d1b7>] __warn+0x101/0x20f
 [<6005d3a8>] warn_slowpath_fmt+0xe3/0x15d
 [<600b0c5c>] ? mark_lock.part.0+0x0/0x4ec
 [<60751191>] ? __this_cpu_preempt_check+0x0/0x16
 [<600b11a2>] ? mark_held_locks+0x5a/0x6e
 [<6005d2c5>] ? warn_slowpath_fmt+0x0/0x15d
 [<60052e53>] ? unblock_signals+0x3a/0xe7
 [<60052f2d>] ? um_set_signals+0x2d/0x43
 [<60751191>] ? __this_cpu_preempt_check+0x0/0x16
 [<607508b2>] ? lock_is_held_type+0x207/0x21f
 [<6063717b>] wdev_chandef+0x60/0x165
 [<605f89b4>] regulatory_propagate_dfs_state+0x247/0x43f
 [<60052f00>] ? um_set_signals+0x0/0x43
 [<605e6bfd>] cfg80211_propagate_cac_done_wk+0x3a/0x4a
 [<6007e460>] process_scheduled_works+0x3bc/0x60e
 [<6007d0ec>] ? move_linked_works+0x4d/0x81
 [<6007d120>] ? assign_work+0x0/0xaa
 [<6007f81f>] worker_thread+0x220/0x2dc
 [<600786ef>] ? set_pf_worker+0x0/0x57
 [<60087c96>] ? to_kthread+0x0/0x43
 [<6008ab3c>] kthread+0x2d3/0x2e2
 [<6007f5ff>] ? worker_thread+0x0/0x2dc
 [<6006c05b>] ? calculate_sigpending+0x0/0x56
 [<6003b37d>] new_thread_handler+0x4a/0x64
irq event stamp: 614611
hardirqs last  enabled at (614621): [<00000000600bc96b>] __up_console_sem+0x82/0xaf
hardirqs last disabled at (614630): [<00000000600bc92c>] __up_console_sem+0x43/0xaf
softirqs last  enabled at (614268): [<00000000606c55c6>] __ieee80211_wake_queue+0x933/0x985
softirqs last disabled at (614266): [<00000000606c52d6>] __ieee80211_wake_queue+0x643/0x985

Fixes: 26ec17a1dc5e ("cfg80211: Fix radar event during another phy CAC")
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---

The issue addressed here is also in older kernels, without
f42d22d3f7963 ("wifi: cfg80211: define and use wiphy guard ").
Porting to kernel 6.13 or lower require us to use wiphy_lock() an
wiphy_unlock() instead of guard().
---
 net/wireless/reg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index c1752b31734f..92e04370fa63 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4229,6 +4229,8 @@ static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 	struct wireless_dev *wdev;
 	unsigned int link_id;
 
+	guard(wiphy)(&rdev->wiphy);
+
 	/* If we finished CAC or received radar, we should end any
 	 * CAC running on the same channels.
 	 * the check !cfg80211_chandef_dfs_usable contain 2 options:
-- 
2.50.0


