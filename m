Return-Path: <linux-wireless+bounces-37926-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rRCsMgFuNWqowAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37926-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 18:27:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 578336A70D2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 18:27:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ceQ6HtXg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37926-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37926-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 189063006B78
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6753BFE20;
	Fri, 19 Jun 2026 16:25:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7293BFAF0
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 16:25:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886353; cv=none; b=eTd/bV0xkGYihMwOzIA4g1CbUKpuCNRGjLZWGCKm4i1544iFY9FvGGQY5IKQ6CQMxtfuNeWkSpl5bqQDFxOU0zV+e727U8xFJZPeKodoY3ODhQGjuccxxGIyM0vBcOTSef7iHE+OXLcQXBq+YApY8Qr5i3V2cQ+VUramFwYut4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886353; c=relaxed/simple;
	bh=MhCq5bUczPMwBowFxwT6rYJ3hO0NnuNFD7T7JakP60c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=akxS6Bm0GYae92Q5mGavRfVJEZsqbzFXXu5dx5xI5Q72JNTL8Jh7wS2v9pqekg48ouC+iT0LCYCn2D5WtyxBgST/TiYPIUn7YG8xGuPfhjYLZn3HGnymhY5VoWjRwO+yNDx3qBxq6AjXwL1UyGXr/4X5tzCgqk9nfbRr9DghH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceQ6HtXg; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8456005a6c4so148007b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781886349; x=1782491149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=muBeirQow0/kMxmtCBCufAVChsk2yWO9FqV2NLrBd/s=;
        b=ceQ6HtXgFTI+SgKEIQtmhjOaWU7m68qtfSYyaKjCqq3+17t0+vLFm6pMztA2GbwMR6
         PqGRhZc6ysRhB7A7gPW7HpzKi6fGlwjgf/xHTxOMH7iWhuuRfUSyWVpWhXOkMQ9//HU+
         LCtjFgbIA8kHZT8dLFEoVlar4PIyO5xh+/Pa1ifGRd2SrcO41YlqXNZ5yXUx8v/Omdx2
         cNWuPPzd1nLh8IbOweTu1+k1INCfkYmzhwu0GACtfKa918Km9yKyZLQZH3trCwbOnJkK
         ciFSjR/CjQfr0flF1nrtgnp3r0QZ2nWkCGm62/y2fh3C3ZF97VfTqldY/bk8HXBTHN1G
         Ku4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781886349; x=1782491149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muBeirQow0/kMxmtCBCufAVChsk2yWO9FqV2NLrBd/s=;
        b=snc7T7ZiUGZ+RBpRZJD65JDoWGS40bah59DnIc/nbEqdvCNeZN2qwWFQstoz75PS/L
         F1OaaYgo2wlq2pjJzkYmK7J4TtvZ9IEdy/NgrVi0PnKkmU9noI4EKXuRzYfVyo2w0dmh
         iCPjXamZY96se/m47SPR3aWT1nYBGDXg9gePkEFZZIKOpiE47iHC2Htb9CIvBeUyGE5s
         OIOti7XEzj0JPzTsnvWZGLB2rBkcA33QteSJfuNse1VAcn4lzBlwT1dYmGXq6npFQz/T
         Y+O4yYDeuH/OSZNGGXmLCo9SYaXuc0pnnC9R4pjBgiUdVcZQ/GB04iV1jy2e0ijxkvMR
         Sz1w==
X-Gm-Message-State: AOJu0YxinCbsb592WaRJ/Bk0LrLDMa1zLVLL74RLpvmKoPGNTzxVfemo
	cgeVc4KGnamSSNZPSDh9YwR7uTxFo0pyONwidRZH8Zpoj7KiHKFvYSsO
X-Gm-Gg: AfdE7cmIE7Mau2/6Xw1fDVmKJ1zHxQumLBTkCBu6r3GmAWujIU48PoB6FJNlWO+M+S0
	Ka8K1QO+PjFLRnKWHlSDYU0aUISK+HKnMnNu6D1ZNzISw2G49FX6mRXfxNZcdv/13K3WM/4Irx8
	uo/ZN1jPNL5oWTDi1WbFXrbYWA+u9/b7WVvejv139Gdf7euZhcXD1IJ+iZXQWFFIZNVYFvg+G3Z
	mcCPn05rMGdPvZuuhdkfWF2ECY0veRVo9W19pLDM+aRl+31kW9+XJDyXETyWP8rdRBRrss5YrwQ
	XXmsEVfT9F+haK0AVI2DP5wa8Zi8zgEa/e4fuiYl+E/SiEDmVhEhXZ5zv9iiFVpJT/9okQahHN6
	S81HAJrMfLTDjRTxp+qJkfKR6tJTR9zkWQuVqCddavNI4QhQrMuOVvjiXio85e2zUzYVPE/YPxA
	9QLK+GtSc=
X-Received: by 2002:a05:6a00:3d04:b0:836:5c3c:2054 with SMTP id d2e1a72fcca58-845508a0f2emr4613647b3a.37.1781886348649;
        Fri, 19 Jun 2026 09:25:48 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84553854347sm2962140b3a.54.2026.06.19.09.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 09:25:48 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] wifi: cfg80211: cancel sched scan results work on unregister
Date: Sat, 20 Jun 2026 00:25:42 +0800
Message-Id: <20260619162542.3878296-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-37926-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 578336A70D2

cfg80211_sched_scan_results() can queue rdev->sched_scan_res_wk from a
driver result notification while a scheduled scan request is present. The
work callback recovers the containing cfg80211_registered_device and then
locks the wiphy and walks the scheduled-scan request list.

wiphy_unregister() already makes the wiphy unreachable and drains rdev work
items before cfg80211_dev_free() can release the object, but it does not
drain sched_scan_res_wk. A queued or running result work item can therefore
cross the unregister/free boundary and access freed rdev state.

The buggy scenario involves two paths, with each column showing the order
within that path:

scheduled-scan result path:        unregister/free path:
1. cfg80211_sched_scan_results()   1. interface teardown stops and
   queues rdev->sched_scan_res_wk.    removes the scheduled scan request.
2. cfg80211_wq starts the work     2. wiphy_unregister() drains other
   item and recovers rdev.            rdev work items.
3. The worker locks rdev->wiphy    3. cfg80211_dev_free() destroys and
   and walks rdev state.              frees rdev.

Cancel sched_scan_res_wk in wiphy_unregister() alongside the other rdev
work items. cancel_work_sync() removes a pending result notification and
waits for an already running callback, so cfg80211_dev_free() cannot free
rdev while this work item is still active.

Validation reproduced this kernel report:
BUG: KASAN: use-after-free in cfg80211_sched_scan_results_wk+0x4a6/0x530
Workqueue: cfg80211 cfg80211_sched_scan_results_wk [cfg80211]
Read of size 8
Call trace:
  dump_stack_lvl+0x66/0xa0
  print_report+0xce/0x630
  cfg80211_sched_scan_results_wk+0x4a6/0x530
  srso_alias_return_thunk+0x5/0xfbef5
  __virt_addr_valid+0x224/0x430
  kasan_report+0xac/0xe0
  lockdep_hardirqs_on_prepare+0xea/0x1a0
  process_one_work+0x8d0/0x18f0 (kernel/workqueue.c:3212)
  lock_is_held_type+0x8f/0x100
  worker_thread+0x5ad/0xfd0
  __kthread_parkme+0xc6/0x200
  kthread+0x31e/0x410
  trace_hardirqs_on+0x1a/0x170
  ret_from_fork+0x576/0x810
  __switch_to+0x57e/0xe20
  __switch_to_asm+0x33/0x70
  ret_from_fork_asm+0x1a/0x30

Fixes: 807f8a8c3004 ("cfg80211/nl80211: add support for scheduled scans")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/wireless/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3dcf63b04c41..2c729a7aca12 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1335,6 +1335,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	/* this has nothing to do now but make sure it's gone */
 	cancel_work_sync(&rdev->wiphy_work);
 
+	cancel_work_sync(&rdev->sched_scan_res_wk);
 	cancel_work_sync(&rdev->rfkill_block);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
-- 
2.43.0


