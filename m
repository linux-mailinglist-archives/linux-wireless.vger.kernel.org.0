Return-Path: <linux-wireless+bounces-13537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F285991238
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 00:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34E81F242CA
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC51B4F23;
	Fri,  4 Oct 2024 22:17:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD21474B9
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080251; cv=none; b=cS3KBUPph0+Qu3xKjSVtXa3SwAfhj2xsgZrFvRwP1ZuPZac1WbUU4YizXBzYdmB2CGVO7KIUQwE28S3+0YbZV1lpnbTRDPx4J6uOJ3KeRJ82ZEUfGKCr/bFGnsrCd4sjzO669lbJLteZ1MEbGTlUV1OERZykdE0X9dvQ5Cw1Uco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080251; c=relaxed/simple;
	bh=mB08JW8CtwRRimzPN2c98tu6MkpDrjmSKm/jZToE8NI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uD5MtQS6ivWEMbhzJrK/Mjfemxj4tPLuXckoX4sdmlz6r/20kKKbbiuBDi5iL+lfTvpev7RwqoEUPbzRTdswte5QHFC2fyzgBz1rzMLLbqx9vkcVdErEd9g5tmkHgDbNBO1gBnzhSECz1GYCiF9IJVLH0pYKQKLHh3L88uT+4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cd6a028bso25390825ab.0
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2024 15:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728080249; x=1728685049;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcSY+QZzVzCFKCT4MUcMzkE2WCiNDzAFlpsTg6520QA=;
        b=PnnGCau0fCsSCmdQ70bRtJfNh4t+MxDENoPTWQEboZYaNHRO1461cPuLBy6UVGw0jL
         ndq/pZ+o4oqsXVTA8+Exwz8Idhj7NHpUqKkpc3K6pt4Ra7edvFdJiNGJy7FCD18NWJr5
         ihGMBO5sQaOgKOAbuqo3zbOwMS9VFMtPIsrLG9xdHO+qaVIwu9hYYDFKq/OqHPmBJI/B
         4dg5uNQWOkunYgNWzKMdOcDjxcSJHpy3LCRx9n0SORmQnz24E0rnFHFMpzZCDvSy3PC4
         9CzkNBt4x3UQ0jL0UrsoxXvMg9XvjuLH1aeklXfLl5cfqJZWki+2xffnZ+pMAYJCG5Tb
         ltFg==
X-Forwarded-Encrypted: i=1; AJvYcCW1PJI4mGYQVDjRkox9B5qZmxWY+ou28BbIbXN5UjIMZoe7UleLUIxuHFLEVSezW89ASAF7G2NvoeID3U+PIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRyQjO4djg6m7qaKpi59Yr/GIxQosydcSfpmNwgTKR0oAXCi+
	fSmq7b6p75HuIcN63ihvXun+a0hPVpnMNbS+tbPEM7KHhyyFGwlEc9qWuUgfEjAyN+1K9RAHL1d
	d1GwK8Rx23YbVjFFxTwVPX8lI4lGDxwWze+AV81o/jNZ1+DbkQvfqOfs=
X-Google-Smtp-Source: AGHT+IGcBCsMAU7c3afeDumz0t8uJQspjFlWDWE5j13W4R9V69z8N84JSf+WswCFQNfwQcH0VaFRwcm590TN6CpRDG5pAohTQ7bx
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178a:b0:3a1:f549:7272 with SMTP id
 e9e14a558f8ab-3a375bd5278mr35980655ab.23.1728080248933; Fri, 04 Oct 2024
 15:17:28 -0700 (PDT)
Date: Fri, 04 Oct 2024 15:17:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67006978.050a0220.49194.04a5.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in ieee80211_unregister_hw (2)
From: syzbot <syzbot+9376ed0d09c5cb65483b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0c559323bbaa Merge tag 'rust-fixes-6.12' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131a0d80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=9376ed0d09c5cb65483b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f047d65a1c98/disk-0c559323.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9422453b274/vmlinux-0c559323.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cbd997d77332/bzImage-0c559323.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9376ed0d09c5cb65483b@syzkaller.appspotmail.com

INFO: task kworker/u8:10:2973 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00125-g0c559323bbaa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:10   state:D stack:22600 pid:2973  tgid:2973  ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 ieee80211_unregister_hw+0x55/0x2c0 net/mac80211/main.c:1662
 mac80211_hwsim_del_radio+0x2c4/0x4c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5625
 hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c:6505
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x804/0xcc0 net/core/net_namespace.c:626
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:6:5346 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00125-g0c559323bbaa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:22392 pid:5346  tgid:5346  ppid:2      flags:0x00004000
Workqueue: events_power_efficient crda_timeout_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor:5690 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00125-g0c559323bbaa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21728 pid:5690  tgid:5690  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 kernfs_fop_write_iter+0x3a2/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6f/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feaf077cadf
RSP: 002b:00007ffdda11be30 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007feaf077cadf
RDX: 0000000000000001 RSI: 00007ffdda11be80 RDI: 0000000000000005
RBP: 00007feaf07f13ae R08: 0000000000000000 R09: 00007ffdda11bc87
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 00007ffdda11be80 R14: 00007feaf1464620 R15: 0000000000000003
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
3 locks held by kworker/1:1/78:
 #0: ffff88801ac79948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac79948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900015f7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900015f7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
3 locks held by kworker/u8:6/1107:
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003f17d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003f17d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
3 locks held by kworker/u8:7/2556:
 #0: ffff88802dd52948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88802dd52948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900091b7d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900091b7d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4736
4 locks held by kworker/u8:10/2973:
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90009b17d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90009b17d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc4c50 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_unregister_hw+0x55/0x2c0 net/mac80211/main.c:1662
2 locks held by getty/4987:
 #0: ffff888031af20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
5 locks held by kworker/0:7/5299:
3 locks held by kworker/1:6/5346:
 #0: ffff88801ac79948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac79948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900031ffd00 ((crda_timeout).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900031ffd00 ((crda_timeout).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
3 locks held by kworker/0:8/5377:
7 locks held by syz-executor/5683:
 #0: ffff88807ca88420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff88807ca88420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff88805fb5fc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff888143f1a788 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f56f848 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff88807d6490e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807d6490e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88807d6490e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff88807d64a250 (&devlink->lock_key){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
4 locks held by syz-executor/5690:
 #0: ffff88807ca88420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff88807ca88420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff8880363e3888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff888143f1a788 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f56f848 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
2 locks held by syz.3.129/5746:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 #1: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: flush_all_backlogs net/core/dev.c:6025 [inline]
 #1: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: unregister_netdevice_many_notify+0x5ea/0x1da0 net/core/dev.c:11384
1 lock held by syz-executor/5762:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
1 lock held by syz-executor/5770:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
1 lock held by syz-executor/5804:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5808:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5811:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5817:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5820:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5826:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5832:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5836:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5845:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5850:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5853:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5859:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5866:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5868:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00125-g0c559323bbaa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5299 Comm: kworker/0:7 Not tainted 6.12.0-rc1-syzkaller-00125-g0c559323bbaa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:__kernel_text_address+0xf/0x40 kernel/extable.c:79
Code: cd 9e 00 eb b5 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 53 48 89 fb e8 43 00 00 00 85 c0 <0f> 95 c0 48 c7 c1 00 90 7b 91 48 39 cb 0f 93 c1 48 c7 c2 3f 66 96
RSP: 0018:ffffc90000006b50 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffffff8bc542c6 RCX: 0000000080000101
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffffffff8bc542c6
RBP: ffffc90000006c10 R08: ffffc90000006bdf R09: ffffc90000006bd0
R10: dffffc0000000000 R11: fffff52000000d7c R12: ffff88801d385a00
R13: ffffffff81809710 R14: dffffc0000000000 R15: 1ffff92000000d79
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c27a25b CR3: 000000000e734000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xfd/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 refdst_drop include/net/dst.h:263 [inline]
 skb_dst_drop include/net/dst.h:275 [inline]
 skb_release_head_state+0x73/0x250 net/core/skbuff.c:1174
 skb_release_all net/core/skbuff.c:1188 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 consume_skb+0x60/0xf0 net/core/skbuff.c:1436
 nft_synproxy_eval_v4+0x3d2/0x610 net/netfilter/nft_synproxy.c:60
 nft_synproxy_do_eval+0x362/0xa60 net/netfilter/nft_synproxy.c:141
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x4af/0x1da0 net/netfilter/nf_tables_core.c:288
 nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 NF_HOOK+0x3a6/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5779
 process_backlog+0x662/0x15b0 net/core/dev.c:6111
 __napi_poll+0xcd/0x490 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6966
 handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:skb_zcopy include/linux/skbuff.h:1732 [inline]
RIP: 0010:skb_release_data+0x1ba/0x8a0 net/core/skbuff.c:1110
Code: 48 8b 2b 48 8b 44 24 20 42 0f b6 04 38 84 c0 0f 85 f5 05 00 00 48 8b 04 24 8b 00 48 01 c5 48 89 e8 48 c1 e8 03 42 0f b6 04 38 <84> c0 0f 85 f8 05 00 00 0f b6 5d 00 89 de 83 e6 01 31 ff e8 9e 8a
RSP: 0018:ffffc90003b07a38 EFLAGS: 00000216
RAX: 0000000000000000 RBX: ffff888065da90d0 RCX: ffff88801d385a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88802ed4eec0 R08: ffffffff898a5ab9 R09: 1ffffffff2039cf5
R10: dffffc0000000000 R11: fffffbfff2039cf6 R12: ffff888065da907e
R13: ffff88802ed4eec0 R14: ffff888065da9000 R15: dffffc0000000000
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 consume_skb+0x9f/0xf0 net/core/skbuff.c:1436
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x765/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

