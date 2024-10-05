Return-Path: <linux-wireless+bounces-13561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3499166F
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 13:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFECA2815CA
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68D1494AC;
	Sat,  5 Oct 2024 11:25:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5139314A0BC
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127526; cv=none; b=tVQnDYreiPlERV3srTcZ6eeQmFfs+WhwhiX5ITfKK+U/WFgsaFE0giebGlVZDQR/Waqibl+A2yNISZ8HpOtRMdutWgrmV4tCU+zFXOJQ9vggpV2Lf1HE6AbQUvHl1D493z3Y37AwIjP/3mkoxUoOGxYVR5TD+kv2vWtCyj4GL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127526; c=relaxed/simple;
	bh=qKU++iZyvLgGYMb15MhpKrMvNQPqZ4TxgLoGhxMrkHw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JGgzC8jSHXo1JLi8ngRHwOfaO8hOctxTW7baTjzbANUmC9jmV/Ea7qLXZrSnxIWwZsvy7I/KNbMvzaQDcAAo+ML3e73lWexmWP8jGP0fLXQwz95mHjfSSAd5QySaU1KWxguMUeZAUdQzow3xDI5i77ir1TGeUPJoD8OrWkaBnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so49906575ab.2
        for <linux-wireless@vger.kernel.org>; Sat, 05 Oct 2024 04:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728127523; x=1728732323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6dzhWKVs5AfYreUvYmTsCMUmIRINLLJ4AYBSn+UIzE=;
        b=CpFj/lAQhH0cLeU/NMuYQNZHI5VCixRJHibZ5TCYDwXOjJ6UYUwPLA+ogM+Df5IBqP
         yHxFALNO8a8k9A3OtixobT0VYs7fnskSMptK6DnnMe2hw1UDZCOSMdAl4GQmSEEUn5/w
         q4g9PDKfb2PaSiV8A+Kri+I8WJMQHKA89DOqh4pdXf9f4Ygj6qxYUh8jxucnN6rs5Q4V
         kjMbZlucF7egZnh1KJk94pr8AxotKYj4q/r+XzOC42MbqebB/yDZ8s7Wf9cxNBxaAKYd
         82/YxMbjjmTJwzlqD+MrwwAQM57eC1/y4E0pTCUhOHGuAmcxAt2Nz54Eaoqv/OMw+W8U
         BFKA==
X-Forwarded-Encrypted: i=1; AJvYcCW1/jKm/xlLbi1DzF4ko+zmuraLflXZyt/f6V9NMEYG2sBErqEFxsp47b6wNJi3KMPRNG9AYgoZh18xauWEcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmEU1869+kJ8OeOjbe92nXSNx82UL3sft0PpgHKz39FDmY4bW
	HSyx+LSz2l8XxSNIsAeKTccKh2AuE4b5o260Y/RrKwZl9a2I/YeFf7nKmQqITT2HwVk7uMZ999j
	Oul0LYhmS6UqfIoleNDCm6BGOMnvz5U7/Jx6wzKJw0bLSKd6Vunays4g=
X-Google-Smtp-Source: AGHT+IGLICQvgRZ0hvXYBcDGR/lV7RFh6CGa1PGLTrtC17RIEy+HmSld6vlXJsDuuAQkfHkYzqTaec7lOxc1mlGb0U80qOtLMr6Q
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:39d:2939:3076 with SMTP id
 e9e14a558f8ab-3a375bd2038mr54970835ab.25.1728127523544; Sat, 05 Oct 2024
 04:25:23 -0700 (PDT)
Date: Sat, 05 Oct 2024 04:25:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67012223.050a0220.49194.04be.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in regdb_fw_cb (2)
From: syzbot <syzbot+aff8125319e0457b4a25@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15510927980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=aff8125319e0457b4a25
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173c3dd0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15902777980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f7f2dc1bf47b/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/063e4eafb554/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ce38bae7b74/bzImage-e32cde8d.xz

Bisection is inconclusive: the first bad commit could be any of:

abc158c82ae5 sched: Prepare generic code for delayed dequeue
dfa0a574cbc4 sched/uclamg: Handle delayed dequeue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10096580580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aff8125319e0457b4a25@syzkaller.appspotmail.com

INFO: task kworker/1:2:1166 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:25400 pid:1166  tgid:1166  ppid:2      flags:0x00004000
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 regdb_fw_cb+0x82/0x1c0 net/wireless/reg.c:1017
 request_firmware_work_func+0x1a4/0x280 drivers/base/firmware_loader/main.c:1197
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor127:5227 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor127 state:D stack:19376 pid:5227  tgid:5227  ppid:5225   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2209
 __do_sys_sendto net/socket.c:2221 [inline]
 __se_sys_sendto net/socket.c:2217 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2217
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f79ea26dd93
RSP: 002b:00007ffe87ec0fc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f79ea2eb1c0 RCX: 00007f79ea26dd93
RDX: 0000000000000028 RSI: 00007f79ea2eb210 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007ffe87ec0fe4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f79ea2eb210 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/8:
2 locks held by kworker/u8:0/11:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:2/35:
 #0: ffff88814bb46948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814bb46948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000ab7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000ab7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
3 locks held by kworker/u8:4/61:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900015d7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900015d7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
3 locks held by kworker/1:2/1166:
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900042e7d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900042e7d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: regdb_fw_cb+0x82/0x1c0 net/wireless/reg.c:1017
2 locks held by udevd/4686:
2 locks held by getty/4995:
 #0: ffff88814bdc20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor127/5227:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
2 locks held by syz-executor127/5228:
1 lock held by syz-executor127/5232:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor127/5233:
1 lock held by syz-executor127/5234:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
2 locks held by kworker/1:4/5262:
3 locks held by kworker/1:6/5264:
3 locks held by kworker/1:7/5267:
1 lock held by dhcpcd/5279:
1 lock held by dhcpcd/5281:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
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
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:58 [inline]
RIP: 0010:stack_access_ok arch/x86/kernel/unwind_orc.c:393 [inline]
RIP: 0010:deref_stack_reg arch/x86/kernel/unwind_orc.c:403 [inline]
RIP: 0010:unwind_next_frame+0xb9c/0x22d0 arch/x86/kernel/unwind_orc.c:585
Code: 80 3c 27 00 74 08 48 89 df e8 40 2b bd 00 4c 8b 74 24 08 4d 8b 66 10 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 20 0f b6 04 01 <84> c0 0f 85 67 12 00 00 48 8b 04 24 4c 8d 68 f8 41 83 3e 00 74 1c
RSP: 0018:ffffc900001e6270 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc900001e6350 RCX: 1ffff9200003cc68
RDX: ffffffff90ae974c RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc900001e0000 R08: 0000000000000001 R09: ffffc900001e6430
R10: ffffc900001e6390 R11: ffffffff81808f50 R12: ffffc900001e8000
R13: ffffc900001e6340 R14: ffffc900001e6340 R15: 1ffff9200003cc6a
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe87ec043c CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __set_page_owner+0x92/0x800 mm/page_owner.c:320
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_track_caller_noprof+0x281/0x440 mm/slub.c:4284
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 synproxy_send_client_synack+0x1ba/0xf30 net/netfilter/nf_synproxy_core.c:460
 nft_synproxy_eval_v4+0x3ca/0x610 net/netfilter/nft_synproxy.c:59
 nft_synproxy_do_eval+0x362/0xa60 net/netfilter/nft_synproxy.c:141
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
 nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5662 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcb/0x490 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.875 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

