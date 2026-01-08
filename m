Return-Path: <linux-wireless+bounces-30518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3325D0168A
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 08:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E02E8300A9A0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C67318EF1;
	Thu,  8 Jan 2026 07:35:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337031B81C
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767857759; cv=none; b=OUQ+AxNqz8lKyaBellsOhOMS+T29Zi8m4BfvElhdUMKhxPhqomQ2Te0W7R/bJ16Cc4WV9MKwk43/nVOi4RYBTdV3l8XZIXf1WZyDFl2FeO3VL5ihupvT7YGGS8KweTLdmxNIIjyq6xzou8IzL4ErjLoefz2mdEps+Y/pHIayJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767857759; c=relaxed/simple;
	bh=DAUXvUTl2cPOHv+5VsYC6sBQzoCO/auAZ3uaklAgoF0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OOXqZ5L5awy3iwJGuflfiZBrE72n09urykIcI6Ps4AAp1zaMm4Y9eX9PGM2plEdC88kHFPUKHKbfNw/6By8Cz+O1Nu61qI0VCZWw1yFbY6OYwelsDYX+ffDLY8382KvIv/mIi59LD7BaYjfOWogPte7or83H7gRU9d/5hAEI4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65f0fe5372aso4135265eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 23:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767857756; x=1768462556;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMY8b+FLXF2bIQ1s69KWFvtBYKUqbRD9eqKqFADp9fs=;
        b=IAMqkvoL/OBl85qIXIayKqaD/6OnvvW3prybzB1Qz5/Lx9MQTuegwu2fkRLcCu06Z1
         yy8r4PJSlSI/YY7Mwp73otZGw47SgwH/H21qhQPvfQ6nhW+Ra34SNsJ0opouecBub1sl
         QPhBkmuapOxSBV4m2nhXNBt3ZwvzdpxZscL/aiS3mnEgTV6iefNlH9Yrgfzi8xBksu7P
         5R0CrEfCGu3TNWajgM1HQJW6G6qHOoGHexrUxNfvu6wfIoktod1mH4SGXUufvPwojh/V
         KsvoXALTiv1EeBWtLWn+JXqoufmcybIIxIOgwhySwAsK0/V3UHMCIK74boCoqbdnA+yx
         vHDg==
X-Forwarded-Encrypted: i=1; AJvYcCWNiRn6A/G/+ixX9UiuPxGWRvoLUgpVX+jgEdXJLnV/sjuSJdKHlcziON7m10hDq4YM21oNCYhdUmZFZm6Rwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwLeI5btbATmVyP5/aLEHO6M+CzYBmrj/+6IILKhAdy1zk5D4
	iSh0s6a9kdnCDQvuw9/tdQai4kneshiSGbJcKZ0hqvpreVKtC5qDtMOIYWh5dqpSgMYhDBcQ3BJ
	b7fmwP3S4rBv2H82Ld1zG35zzqMFMpvTLeaA4sWcvbM1NviVCrcGnX52dBWE=
X-Google-Smtp-Source: AGHT+IGXCguhbKytUq6HKF+AtjURXUOprlcQ8WgE/CV6dBtLwGyhoqVGvGHE4uQ555KQvGVGysd2xT5YqJIErSfrq1mw0nSAYnfz
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6005:b0:65f:6038:e84b with SMTP id
 006d021491bc7-65f6038ee11mr210087eaf.26.1767857756162; Wed, 07 Jan 2026
 23:35:56 -0800 (PST)
Date: Wed, 07 Jan 2026 23:35:56 -0800
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695f5e5c.050a0220.1c677c.038b.GAE@google.com>
Subject: [syzbot ci] Re: wifi: cfg80211/nl80211: Add NAN Data Path support
From: syzbot ci <syzbot+cib67e7c99902d09fe@syzkaller.appspotmail.com>
To: avraham.stern@intel.com, daniel.gabay@intel.com, johannes.berg@intel.com, 
	linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] wifi: cfg80211/nl80211: Add NAN Data Path support
https://lore.kernel.org/all/20260107132003.2291979-1-miriam.rachel.korenblit@intel.com
* [PATCH wireless-next 01/15] wifi: nl80211: refactor nl80211_parse_chandef
* [PATCH wireless-next 02/15] wifi: nl80211/cfg80211: support stations of non-netdev interfaces
* [PATCH wireless-next 03/15] wifi: cfg80211: refactor wiphy_suspend
* [PATCH wireless-next 04/15] wifi: nl80211: don't allow DFS channels for NAN
* [PATCH wireless-next 05/15] wifi: cfg80211: Add an API to configure local NAN schedule
* [PATCH wireless-next 06/15] wifi: cfg80211: store the chandefs used for NAN
* [PATCH wireless-next 07/15] wifi: cfg80211: make sure NAN chandefs are valid
* [PATCH wireless-next 08/15] wifi: cfg80211: add support for NAN data interface
* [PATCH wireless-next 09/15] wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
* [PATCH wireless-next 10/15] wifi: nl80211: add support for NAN stations
* [PATCH wireless-next 11/15] wifi: nl80211: define an API for configuring the NAN peer's schedule
* [PATCH wireless-next 12/15] wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data interfaces
* [PATCH wireless-next 13/15] wifi: nl80211: allow reporting spurious NAN Data frames
* [PATCH wireless-next 14/15] wifi: cfg80211: support key installation on non-netdev wdevs
* [PATCH wireless-next 15/15] wifi: cfg80211: allow protected action frame TX for NAN

and found the following issue:
possible deadlock in cfg80211_leave

Full report is available here:
https://ci.syzbot.org/series/233ae6b9-f1a6-42ee-a9ad-23778617ac45

***

possible deadlock in cfg80211_leave

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      805f9a061372164d43ddef771d7cd63e3ba6d845
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251202083448+f68f64eb8130-1~exp1~20251202083504.46), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/ef828e0d-7b43-4e85-a3b3-c8a39bcbb3c9/config
C repro:   https://ci.syzbot.org/findings/f7def9d9-24af-4952-b991-2e6c88f8fb50/c_repro
syz repro: https://ci.syzbot.org/findings/f7def9d9-24af-4952-b991-2e6c88f8fb50/syz_repro

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
kworker/1:3/1286 is trying to acquire lock:
ffff888113640788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6552 [inline]
ffff888113640788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_leave+0x17e/0x240 net/wireless/core.c:1507

but task is already holding lock:
ffff888113640788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6552 [inline]
ffff888113640788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_destroy_ifaces+0x128/0x1e0 net/wireless/core.c:394

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&rdev->wiphy.mtx);
  lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by kworker/1:3/1286:
 #0: ffff888100075948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff888100075948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9d4/0x17a0 kernel/workqueue.c:3340
 #1: ffffc90008c3fbc0 ((work_completion)(&rdev->destroy_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
 #1: ffffc90008c3fbc0 ((work_completion)(&rdev->destroy_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa0f/0x17a0 kernel/workqueue.c:3340
 #2: ffffffff8f714e88 (rtnl_mutex){+.+.}-{4:4}, at: cfg80211_destroy_iface_wk+0x19/0x30 net/wireless/core.c:424
 #3: ffff888113640788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6552 [inline]
 #3: ffff888113640788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_destroy_ifaces+0x128/0x1e0 net/wireless/core.c:394

stack backtrace:
CPU: 1 UID: 0 PID: 1286 Comm: kworker/1:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events cfg80211_destroy_iface_wk
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x19f/0x1340 kernel/locking/mutex.c:776
 class_wiphy_constructor include/net/cfg80211.h:6552 [inline]
 cfg80211_leave+0x17e/0x240 net/wireless/core.c:1507
 cfg80211_destroy_ifaces+0x137/0x1e0 net/wireless/core.c:396
 cfg80211_destroy_iface_wk+0x21/0x30 net/wireless/core.c:425
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
 worker_thread+0x89f/0xd90 kernel/workqueue.c:3421
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

