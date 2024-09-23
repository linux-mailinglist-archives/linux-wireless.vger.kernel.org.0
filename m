Return-Path: <linux-wireless+bounces-13084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA35897E7B7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 10:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA921C20967
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E519343D;
	Mon, 23 Sep 2024 08:39:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E90919408D
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080764; cv=none; b=Lz7UHnniV0yXSg4Fq/kavgBX/WXDbrX39ggmQ+bQtNQNzARWHT4z1svRKnv1b5blkOi5WUP5w/ALjbRuUrVKsPD/7XVlAMw4jfS+kjSfEMeXpHppnMcEu1WJjUV8JE9A8erIqmdYcnSDWcXfLVs3NvPTyF60pn3DmJUBUrOC9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080764; c=relaxed/simple;
	bh=1rEb+/okWnZhPTUxOv3hmdUptOMTLerpmXjCngdmqHg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HAMwyjdbCwvcgzHhgLpZRu3nPyyQYItcJ+6F45FFW/71YteUHMY6ZjPDqnt9B9aGYeQEeat2K33BESrqDTSWERYai65jduFRMzzF7Ohdmmw7VMuSO0JBFLrGdmO33jcetHf6IPLf68AGRqGDs3PIS/IDN5/5JP03NQhBn5PFa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cedb7a183so564567239f.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 01:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727080762; x=1727685562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3A8TCqgbDirH1XsU4D75cxNJM3X3oVXPt80n1RVHiNY=;
        b=GSbLiTUFXcj6dg4/NaxxwPfmMLewipKuQTgM/yGOEMNhbsQGMsqOawLa4V/AdLSLuV
         1BhBGSrmlKEDGEGgAwKuyMzowwcbfICbXbrA3xMdCEDlL2R+zLn1Li6pJyUHXIF/Fasz
         d6B6WT4/6N8Qrrnj6ijU8cBgjppRf8yizo629x3vq4yYJvN8Z+aV21/o1jFYA7EyqQ7m
         pM8t4tbzYpUQ2gvGxF+lV1DzAXaysshwcrAn6Aig7B0i4jOc/zoT7Ixc6BL3PC7n/vJL
         pFJXjMbd7kY46IO+knmsJs+7LNdCoSJ3I6/8kIKRLVVLNGNoPI/cdkgJXI8R5WdNVqAg
         e+6g==
X-Forwarded-Encrypted: i=1; AJvYcCUgxBkaHlobxEG5CwrtWhrNvoeIBR8mHTpZCzhLO7a5/6lyWdUV9ZMnbcFVJEalwdXpcsxOglEd31H322AbZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Ez9m0xqY/DU/y0Zkk9Y0bRFa0vZtqToCIOkIi0AiijJEwOb6
	ZXGuEZ6+dl0JLAkMSh+m8ISFM4vPcnOYx4icy6KnANM34v/wAvXefaIXfYhTHFQSPYlTdK1SuNt
	ja0n7O+OzjQ3FwhYFAYelRYR4IiHA4iEgPAzZ7q8pjr+0YpAVvUwNBqQ=
X-Google-Smtp-Source: AGHT+IHy3JIwIU8I/2c6mp+WtBMVg/0xxNZcdu3RXMS1JHqwyZUp9K3V+lUNnv+ocjyIoCffS6f8Ib5pvx0R5h/xpbUOKscE3S+z
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:3a0:9ea3:8d79 with SMTP id
 e9e14a558f8ab-3a0c8d12eebmr85287945ab.16.1727080762285; Mon, 23 Sep 2024
 01:39:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 01:39:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f1293a.050a0220.3eed3.0007.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in reg_check_chans_work (7)
From: syzbot <syzbot+a2de4763f84f61499210@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f27fce67173 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148344a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cb2f9a0593f5374
dashboard link: https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f7469f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d6076059ff93/disk-2f27fce6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d583d2c31e4/vmlinux-2f27fce6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f649fe6f6f24/bzImage-2f27fce6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2de4763f84f61499210@syzkaller.appspotmail.com

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-04557-g2f27fce67173 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:24400 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue: events_power_efficient reg_check_chans_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:8:2510 blocked for more than 145 seconds.
      Not tainted 6.11.0-syzkaller-04557-g2f27fce67173 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:8    state:D stack:22672 pid:2510  tgid:2510  ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:5:5316 blocked for more than 147 seconds.
      Not tainted 6.11.0-syzkaller-04557-g2f27fce67173 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:25840 pid:5316  tgid:5316  ppid:2      flags:0x00004000
Workqueue: events reg_todo
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 reg_todo+0x1c/0x8d0 net/wireless/reg.c:3218
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e938a60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938a60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938a60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
5 locks held by kworker/u8:4/61:
3 locks held by kworker/u8:6/1056:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000418fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000418fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fcc2948 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
3 locks held by kworker/u8:8/2510:
 #0: ffff88802fdc9148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802fdc9148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900095ffd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900095ffd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fcc2948 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
4 locks held by kworker/u8:9/2517:
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900097bfd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900097bfd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fcb5e50 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcc2948 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
3 locks held by syslogd/4664:
1 lock held by klogd/4671:
4 locks held by udevd/4682:
3 locks held by dhcpcd/4895:
5 locks held by dhcpcd/4896:
2 locks held by getty/4980:
 #0: ffff88803043e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000311b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/5225:
3 locks held by kworker/0:3/5261:
1 lock held by syz-executor/5328:
 #0: ffffffff8fcc2948 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcc2948 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5329:
 #0: ffffffff8fcc2948 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcc2948 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
1 lock held by syz-executor/5330:
 #0: ffffffff8fcc2948 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcc2948 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
3 locks held by syz-executor/5333:
4 locks held by kworker/1:5/5392:
2 locks held by syz-executor/5406:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-syzkaller-04557-g2f27fce67173 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
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
CPU: 1 UID: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.11.0-syzkaller-04557-g2f27fce67173 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bat_events batadv_nc_worker
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:26 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:87 [inline]
RIP: 0010:check_preemption_disabled+0x5d/0x120 lib/smp_processor_id.c:19
Code: 28 00 00 00 48 3b 44 24 08 0f 85 ce 00 00 00 89 d8 48 83 c4 10 5b 41 5c 41 5e 41 5f c3 cc cc cc cc 48 c7 04 24 00 00 00 00 9c <8f> 04 24 f7 04 24 00 02 00 00 74 c5 49 89 f6 49 89 ff 65 4c 8b 24
RSP: 0018:ffffc90000ab79e0 EFLAGS: 00000046
RAX: 0000000080000000 RBX: 0000000000000001 RCX: ffffffff816ff9b0
RDX: 0000000000000000 RSI: ffffffff8c0ae5c0 RDI: ffffffff8c60ac40
RBP: ffffc90000ab7b48 R08: ffffffff901bdd2f R09: 1ffffffff2037ba5
R10: dffffc0000000000 R11: fffffbfff2037ba6 R12: 1ffff92000156f50
R13: ffffffff8b8762cb R14: ffffc90000ab7ad0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6d1d868740 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lockdep_recursion_inc kernel/locking/lockdep.c:462 [inline]
 lock_release+0x1bc/0xa30 kernel/locking/lockdep.c:5842
 rcu_lock_release include/linux/rcupdate.h:336 [inline]
 rcu_read_unlock include/linux/rcupdate.h:869 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
 batadv_nc_worker+0x28b/0x610 net/batman-adv/network-coding.c:719
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

