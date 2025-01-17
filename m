Return-Path: <linux-wireless+bounces-17661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC80EA157CA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 20:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181997A31DC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0BF1A7AF7;
	Fri, 17 Jan 2025 19:07:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80321A239F
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140847; cv=none; b=eUQhYr8/ftwUo+j2w236ZUnZ3IIAEL4G3p7jvX5sH0jFJv3uo8yudiwwJG/R9DtIMRsmIGPytfhDwf7r3CykOHyW0lnd5QzItL2SNWDgxptkf2MAdODFo+HlMq1G1GtjO9TczS7lJ6mJu6QC9TLSAzKMbBmdoWueguN1JrrbTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140847; c=relaxed/simple;
	bh=TbQmr/1OztZPtDKwaNZmO4WV7BtsoBE7+NeWE6PBBP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eqlCZHbA8BomqJOlVSjlUYX0fwIj7un6ViSyoGL2ZnBnHIiYZjJwIAJxoui0d8JCXlzcrDAde3Kn2cq3VDb4KZ3usBY29MmnSZzNTcvkz42Bzx6eGanT+BQFqPl3XVTrQ7ZqPWuCpI4LuI4PjGfhde9fV0iR76EuppLq3/mV9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so21147235ab.0
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 11:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737140845; x=1737745645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foEm29ElNZ3IDnPcnMCTNWZ5X6VwrTcrZwniEtgTnA4=;
        b=uZiv22Z1+y06hbz9U/ibI7O87ug7iSgC8l2MgKQ7CkoXVa6a5KZOJ2y4hAU5wVdGsA
         F14qz6YDLp/b6ZvDNA7q6PcYT5c+Nr+var23v2C9qK7BVKoG5J8ODnHSEf9sxlwuFNbI
         qtIMcwZ2s+a+FkFfSPYwxxXscmkoFBVin1ZmwAikFiFuF2evRQGtFJxpwAoNGROcGodD
         IW01oJONQERl5kHEBnzfo6/9B+uJt2C5dYnr0VJ7RuerbH9mFzKlFA3kvwORsAJqNoNW
         Lt1GuOAv2On7bEjk2JH9YpGCTDXdHWjE/pwAmw2WFcgguUc4TVrLHtMDr8qOjHxZDCHz
         n0cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX60brnU2SzbT0S3G7P4JUiJjQ0k11hK+f6VHpsbQGuj2Px065x9z9TwTRRbbrESUnTl6FNy6X20iuI1Wbsjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTkGHo8cKJ/mlAebVjwqUEDmU2PBnZEkiuhW8Tt6jhkVmlYgr
	a7A1OJ38gx+Gl2xrtgalUSgIq7XgL6ia/GU1jXWO2WSWJCXhXnD1HiSNnfHEhyJEkb+vmofORTS
	l1F3h6YfbsOhpRH05Rjpw41Si5OZKzIwoEuNSwV6iBcssJl55Xo7hc1c=
X-Google-Smtp-Source: AGHT+IHV9Xzy4r2uwFMH+eLbVpnYqqtcmfdDnLMcCnOioqug4bFYIzORSykVyXtpDuDG8oCWMotMYTlEpa9WUPv93omqGSgY1ad/
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:b0:3cf:6c5a:5615 with SMTP id
 e9e14a558f8ab-3cf74490703mr29899195ab.20.1737140845028; Fri, 17 Jan 2025
 11:07:25 -0800 (PST)
Date: Fri, 17 Jan 2025 11:07:25 -0800
In-Reply-To: <000000000000c1ae9e062164e101@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678aaa6d.050a0220.303755.0013.GAE@google.com>
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_remove_interfaces
From: syzbot <syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8d20dcda404d selftests: drv-net-hw: inject pp_alloc_fail e..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13ff9fc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c30f048a4f12891
dashboard link: https://syzkaller.appspot.com/bug?extid=5b9196ecf74447172a9a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ff9fc4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ca3a18580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ce07c743ced/disk-8d20dcda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/66f2a9a35d5e/vmlinux-8d20dcda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c790c086a46/bzImage-8d20dcda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com

bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc7-syzkaller-01131-g8d20dcda404d #0 Not tainted
------------------------------------------------------
kworker/u8:6/1143 is trying to acquire lock:
ffffffff8fcb4a08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_acquire_if_cleanup_net net/core/dev.c:10281 [inline]
ffffffff8fcb4a08 (rtnl_mutex){+.+.}-{4:4}, at: unregister_netdevice_many_notify+0xac2/0x2030 net/core/dev.c:11783

but task is already holding lock:
ffff888027260768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6034 [inline]
ffff888027260768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_remove_interfaces+0x129/0x700 net/mac80211/iface.c:2276

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&rdev->wiphy.mtx){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       wiphy_lock include/net/cfg80211.h:6019 [inline]
       wiphy_register+0x1a49/0x27b0 net/wireless/core.c:1006
       ieee80211_register_hw+0x30fb/0x3e10 net/mac80211/main.c:1582
       mac80211_hwsim_new_radio+0x2a9f/0x4a90 drivers/net/wireless/virtual/mac80211_hwsim.c:5558
       init_mac80211_hwsim+0x87a/0xb00 drivers/net/wireless/virtual/mac80211_hwsim.c:6910
       do_one_initcall+0x248/0x870 init/main.c:1266
       do_initcall_level+0x157/0x210 init/main.c:1328
       do_initcalls+0x3f/0x80 init/main.c:1344
       kernel_init_freeable+0x435/0x5d0 init/main.c:1577
       kernel_init+0x1d/0x2b0 init/main.c:1466
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (rtnl_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       rtnl_acquire_if_cleanup_net net/core/dev.c:10281 [inline]
       unregister_netdevice_many_notify+0xac2/0x2030 net/core/dev.c:11783
       unregister_netdevice_many net/core/dev.c:11866 [inline]
       unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11732
       unregister_netdevice include/linux/netdevice.h:3320 [inline]
       _cfg80211_unregister_wdev+0x163/0x590 net/wireless/core.c:1251
       ieee80211_remove_interfaces+0x4ef/0x700 net/mac80211/iface.c:2301
       ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1676
       mac80211_hwsim_del_radio+0x2c4/0x4c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5664
       hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c:6544
       ops_exit_list net/core/net_namespace.c:172 [inline]
       cleanup_net+0x812/0xd60 net/core/net_namespace.c:652
       process_one_work kernel/workqueue.c:3236 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
       worker_thread+0x870/0xd30 kernel/workqueue.c:3398
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rdev->wiphy.mtx);
                               lock(rtnl_mutex);
                               lock(&rdev->wiphy.mtx);
  lock(rtnl_mutex);

 *** DEADLOCK ***

4 locks held by kworker/u8:6/1143:
 #0: ffff88801baf5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801baf5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
 #1: ffffc900041ffd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc900041ffd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3317
 #2: ffffffff8fca8290 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x17a/0xd60 net/core/net_namespace.c:606
 #3: ffff888027260768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6034 [inline]
 #3: ffff888027260768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_remove_interfaces+0x129/0x700 net/mac80211/iface.c:2276

stack backtrace:
CPU: 0 UID: 0 PID: 1143 Comm: kworker/u8:6 Not tainted 6.13.0-rc7-syzkaller-01131-g8d20dcda404d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 rtnl_acquire_if_cleanup_net net/core/dev.c:10281 [inline]
 unregister_netdevice_many_notify+0xac2/0x2030 net/core/dev.c:11783
 unregister_netdevice_many net/core/dev.c:11866 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11732
 unregister_netdevice include/linux/netdevice.h:3320 [inline]
 _cfg80211_unregister_wdev+0x163/0x590 net/wireless/core.c:1251
 ieee80211_remove_interfaces+0x4ef/0x700 net/mac80211/iface.c:2301
 ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1676
 mac80211_hwsim_del_radio+0x2c4/0x4c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5664
 hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c:6544
 ops_exit_list net/core/net_namespace.c:172 [inline]
 cleanup_net+0x812/0xd60 net/core/net_namespace.c:652
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

