Return-Path: <linux-wireless+bounces-13815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9042997100
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DB91F22654
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40F433B6;
	Wed,  9 Oct 2024 16:00:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5E2D7BF
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489636; cv=none; b=ujjRGXGbBRbKYlV38yHzQuJBBKlKrArzaTnTt7a9tC9S+jebgOjkO2BNLTD46pifhjXdAsjeElgl3JLuni5a31M6PKBZ7CddtX9b0Ps0dwZRUDWVrZ/0U43FCRpDHKKJ6U5ScRqjKCvGV3qHFb4u9kpxPCFKbLPrQiopyXPELeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489636; c=relaxed/simple;
	bh=tLFq2rYbKr3kWtMGKuRZlFFNNbSbzktVTTz9OPKLxDM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t5Qok/UfavQZ1URCcD0x8zd9J9e19slqLK42F/JzuHTVqElVgjU2B2LEw+JexHvoPF61q8vVpZm/ebVRLSLInQBqFgtGdng8CXuOKaPJcKjdua9a3qtZzUyvwPEQmnGGcz7zH3JfvqzZLiNk0Yp954x5UIdkfFB/TJBBpUaV/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso159775ab.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2024 09:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489633; x=1729094433;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wUGfyWYG+Mv+ZbCwuJkV8NkgcbRhZCqqHtFvIBA2I8=;
        b=A4tfYZJomeWoI1V/sXOQvHFRQ1wVRXcLhEC5oxNPJt1Y9wAIPmlc2u2hYW6ACvQh2G
         +yoV59xazEkbyaYdQDVulDZu2qu4AN114RdbzQmqBPa0rdf5uCM+NVDy1eq3GQlXF4mL
         criBTLqySbUyoWAZcq3T7EVeKyRyFmPiwwRN6VFVDmWS+563sz0AkIGMuAhYvVFR/E/z
         gaVXkWoRtI6vFV55PDVtv/T6qY8/cJ20hEZaS1zq8xgbPZ0A//a760F9Qgy7Yp+tqaR0
         RZsKag1zS9o5nd6gWW/w6tMVPv2/n9lCfhsnw9nMcmejWdYcUQV9H/gfCHiHJOEig+nU
         g6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVul5q0pAMciwYGIxvvNet/NvQA1b6p0xU8eseapftkPH21NaA2d/shIPJMICerUSa7iJAeYKeYIJ+s8hnYFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5XjWSjmf172R4KBmFMZWAe6DPd41+z5fJFLay3SZyZAYUkwc
	CBIzJwmhqr+ZVCJrErHoYLASdO6EoC7vybSxyti3RSpsyOIrz/PlT0ChYWAaHgkxgwiO6mww40+
	qKsoK8LSPbwbTb0qEAcxD6xxTLS2ffwzDQXTaqfJ9PLBvX5M/r9dCP9k=
X-Google-Smtp-Source: AGHT+IFEqWpHFoJcS79AQvenubV5/CRTKUu1MZBacWLM2r3WzfV/oYAZ84FPkMXDVjzusAutf/+OWMUk8DQC5WvCFT9LOMKyMglK
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:3a3:3e1f:1168 with SMTP id
 e9e14a558f8ab-3a397d10fccmr26673695ab.17.1728489633457; Wed, 09 Oct 2024
 09:00:33 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:00:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706a8a1.050a0220.67064.004b.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in cfg80211_dfs_channels_update_work
 (8)
From: syzbot <syzbot+0e0f5ef531ead9783803@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1648d7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=0e0f5ef531ead9783803
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/508d25adbdbb/disk-5b7c893e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecd795cf996e/vmlinux-5b7c893e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5433a3025f3/bzImage-5b7c893e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e0f5ef531ead9783803@syzkaller.appspotmail.com

INFO: task kworker/u8:1:12 blocked for more than 156 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:1    state:D stack:20944 pid:12    tgid:12    ppid:2      flags:0x00004000
Workqueue: cfg80211 cfg80211_dfs_channels_update_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 cfg80211_dfs_channels_update_work+0xbf/0x610 net/wireless/mlme.c:1021
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:6:2870 blocked for more than 157 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:6    state:D stack:21264 pid:2870  tgid:2870  ppid:2      flags:0x00004000
Workqueue: events_unbound linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task dhcpcd:4898 blocked for more than 158 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:19736 pid:4898  tgid:4898  ppid:4897   flags:0x00000002
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
 rtnl_dumpit+0x99/0x200 net/core/rtnetlink.c:6505
 netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
 __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2440
 netlink_dump_start include/linux/netlink.h:339 [inline]
 rtnetlink_dump_start net/core/rtnetlink.c:6535 [inline]
 rtnetlink_rcv_msg+0xb3d/0xcf0 net/core/rtnetlink.c:6602
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
RIP: 0033:0x7fc13d7fdad7
RSP: 002b:00007ffe7cb63fc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007ffe7cb650f0 RCX: 00007fc13d7fdad7
RDX: 0000000000000014 RSI: 00007ffe7cb65010 RDI: 0000000000000018
RBP: 00007ffe7cb65080 R08: 00007ffe7cb64ff4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000012
R13: 00007ffe7cb64ff4 R14: 00007ffe7cb65010 R15: 0000000000000105
 </TASK>
INFO: task kworker/0:7:5304 blocked for more than 160 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:19184 pid:5304  tgid:5304  ppid:2      flags:0x00004000
Workqueue: events rfkill_global_led_trigger_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 rfkill_global_led_trigger_worker+0x27/0xd0 net/rfkill/core.c:182
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.3.1434:13868 blocked for more than 160 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.1434      state:D stack:22000 pid:13868 tgid:13864 ppid:12830  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 cfg80211_rfkill_set_block+0x1e/0x50 net/wireless/core.c:311
 rfkill_set_block+0x1f1/0x440 net/rfkill/core.c:346
 rfkill_fop_write+0x5b8/0x790 net/rfkill/core.c:1301
 vfs_write+0x29c/0xc90 fs/read_write.c:681
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f28e037dff9
RSP: 002b:00007f28dfd58038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f28e0536130 RCX: 00007f28e037dff9
RDX: 0000000000000008 RSI: 0000000020000080 RDI: 000000000000000b
RBP: 00007f28e03f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f28e0536130 R15: 00007f28e065fa28
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/8:
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900000d7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900000d7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
3 locks held by kworker/u8:1/12:
 #0: ffff888145ae5148 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888145ae5148 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000117d00 ((work_completion)(&(&rdev->dfs_update_channels_wk)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000117d00 ((work_completion)(&(&rdev->dfs_update_channels_wk)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: cfg80211_dfs_channels_update_work+0xbf/0x610 net/wireless/mlme.c:1021
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:6/2870:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90009947d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90009947d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
1 lock held by syslogd/4666:
 #0: ffff8880b863ea98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
2 locks held by dhcpcd/4898:
 #0: ffff88807d8846c8 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x119/0x790 net/netlink/af_netlink.c:2404
 #1: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x99/0x200 net/core/rtnetlink.c:6505
2 locks held by getty/4991:
 #0: ffff88802ef9e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:4/5281:
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90004177d00 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004177d00 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
3 locks held by kworker/0:7/5304:
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90004287d00 ((work_completion)(&rfkill_global_led_trigger_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004287d00 ((work_completion)(&rfkill_global_led_trigger_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8ffa9168 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_global_led_trigger_worker+0x27/0xd0 net/rfkill/core.c:182
2 locks held by kworker/u8:8/5450:
5 locks held by kworker/u8:12/9626:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90002e5fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90002e5fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc52d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: cleanup_net+0x6af/0xcc0 net/core/net_namespace.c:616
 #4: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:297 [inline]
 #4: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:976
3 locks held by kworker/u8:13/9628:
 #0: ffff88814b3ef148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814b3ef148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000324fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000324fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
1 lock held by syz-executor/12440:
 #0: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #0: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
1 lock held by syz-executor/13657:
 #0: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/13702:
 #0: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
7 locks held by syz-executor/13787:
 #0: ffff8880323a8420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff8880323a8420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff888059ab7488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff888027eb9e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f56fea8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff88805865b0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88805865b0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88805865b0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff888058659250 (&devlink->lock_key#65){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
2 locks held by syz.3.1434/13868:
 #0: ffffffff8ffa9168 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x1a6/0x790 net/rfkill/core.c:1293
 #1: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: cfg80211_rfkill_set_block+0x1e/0x50 net/wireless/core.c:311
2 locks held by syz-executor/13914:
 #0: ffff88806cd64118 (&data->open_mutex){+.+.}-{3:3}, at: vhci_create_device+0x34/0x6a0 drivers/bluetooth/hci_vhci.c:469
 #1: ffffffff8ffa9168 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_register+0x34/0x8c0 net/rfkill/core.c:1071
2 locks held by syz-executor/13920:
 #0: ffff8881c2079118 (&data->open_mutex){+.+.}-{3:3}, at: vhci_create_device+0x34/0x6a0 drivers/bluetooth/hci_vhci.c:469
 #1: ffffffff8ffa9168 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_register+0x34/0x8c0 net/rfkill/core.c:1071

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 13921 Comm: syz-executor Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:979 [inline]
RIP: 0010:debug_check_no_obj_freed+0x24e/0x580 lib/debugobjects.c:1019
Code: bc c0 a8 50 59 9a 48 89 7c 24 20 e8 dc ae 0c 07 48 89 44 24 18 4c 89 fb 48 c1 eb 03 48 b8 00 00 00 00 00 fc ff df 80 3c 03 00 <74> 08 4c 89 ff e8 58 06 3c fd 49 8b 07 48 85 c0 0f 84 eb 02 00 00
RSP: 0018:ffffc900044df720 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 1ffffffff34ca93f RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffc900044df600
RBP: ffffc900044df868 R08: 0000000000000003 R09: fffff5200089bec0
R10: dffffc0000000000 R11: fffff5200089bec0 R12: ffff88805e5b3000
R13: ffff88805e5b2000 R14: 0000000000000000 R15: ffffffff9a6549f8
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005568deb02f20 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 free_pages_prepare mm/page_alloc.c:1115 [inline]
 free_unref_page+0x41b/0xf20 mm/page_alloc.c:2638
 vfree+0x186/0x2e0 mm/vmalloc.c:3361
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc04337dbfb
Code: Unable to access opcode bytes at 0x7fc04337dbd1.
RSP: 002b:00007ffdb51fe900 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffff4 RBX: 0000000000040000 RCX: 00007fc04337dbfb
RDX: 0000000000040000 RSI: ffffffff80086301 RDI: 00000000000000df
RBP: 00007fc043536600 R08: 00000000000000da R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
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

