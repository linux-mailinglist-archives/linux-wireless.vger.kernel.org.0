Return-Path: <linux-wireless+bounces-13346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC798B2A6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 05:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125BEB21FDA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 03:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEF626CB;
	Tue,  1 Oct 2024 03:13:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F25EE8D
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 03:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727752415; cv=none; b=l7Nxke08oV4ChvThIdyzk3WcnuyTir/tknimKJm3KEuvkLH5fl04hw2dQBoqLtXqLdUbeeTY6Dc1kUxy3jZLyJ3PHtgXM04Hvv/dyypoVHMCH0cn+39OUNRSrkSEsRyRS3Nq+IVwK3PCrPaS7lT3co8JSSLSjY3RCw8QphazUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727752415; c=relaxed/simple;
	bh=bvz8z2PiJqgGFzqNIDBqV0PV7K+X34FY74K1pGb88UE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gq/uy/sAAIq/U253tZLP/fgK3U3yFr+lO+OY+vqCv9jlA3AsFF3QFuryQ9Kt1FMl080hRa2kzIuXRM1Ibd9Ewm9usZpOVGkATQIZ8z50zs9cVVvnWVovc4rJhPGdlxoolWYei9FrBiafa2/op1fkPvjPgbCw0r0XO0UFZbK6Udg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so671680439f.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 20:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727752413; x=1728357213;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h38yLC5paz4Y4qT0OC9bp8k14g90QxCOsql6LhWfwSE=;
        b=mDzqOtFL31qHHXVujIGJAez4MDl/IuG1uS03nvw+u8SmcgB+WXIiIrUgg5U2tVKhNN
         1uxPId9t06hQuvpeIcOrniPQUdqgx+kpGvJxV5MrEoKmjJOPPfHRFNdqidfmfPGkJiA1
         lpBwOT3QyV4B45jTYXPNa0HPpc21Bwx0iBWvjY0pQLC5gR/qT8cSjULUxFmbg68jESCo
         tgkJiaZv7g5hnAiYdmUuqDycPyn16z/QTzUw7gUqugUofdTvY8HOmTg5HrQgtYF8wxEp
         +9uTssvlFLxfABNIMVWYf/ThBauTvTqy2FfzkjnZEEryb/2U3pIY1r1fjNNey3ZMChxc
         GUkw==
X-Forwarded-Encrypted: i=1; AJvYcCXj4S3g+QDEH5n4WB6dUkx17IdqSbE/5CsCYNU1QzB+mDt+YIF+GuDzEC5+k4l0jwxzlUO3HNb4MtYnbWEmTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYi4i0+ijBsO4uEgx11okTggl63BAuibjyM/CslcXaDqPLk4nI
	M0rfUTW0kiS54PIK7JIkFLEg+exyh36dIvfLLjuTKSB3R6dofzBYZGRQSDVcrrz91lMCrH+WxVC
	OsbG1SQBFXqGuD38t/ho7vkr+pQYSz/vcLOjukNVE0qLGIoT1vTES+Ms=
X-Google-Smtp-Source: AGHT+IEAnBjq+RGbWFNfU40Ezad60NjhnHx6h1dNYFfGbEklww1oGc/5rHXvqqUXuqce1rSJ6xVHSynGlCOcNSxMzJA/ohaMUmJ7
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:b0:3a0:98ab:793e with SMTP id
 e9e14a558f8ab-3a3451c3a50mr123826685ab.23.1727752413042; Mon, 30 Sep 2024
 20:13:33 -0700 (PDT)
Date: Mon, 30 Sep 2024 20:13:33 -0700
In-Reply-To: <66f1293a.050a0220.3eed3.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb68dd.050a0220.aab67.003e.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in reg_check_chans_work (7)
From: syzbot <syzbot+a2de4763f84f61499210@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9852d85ec9d4 Linux 6.12-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1516ddd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14271980580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1358439f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da91d5641713/disk-9852d85e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fc1f1ed3252/vmlinux-9852d85e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5affad2001eb/bzImage-9852d85e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2de4763f84f61499210@syzkaller.appspotmail.com

INFO: task kworker/0:0:8 blocked for more than 149 seconds.
      Not tainted 6.12.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:21392 pid:8     tgid:8     ppid:2      flags:0x00004000
Workqueue: events_power_efficient reg_check_chans_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 wiphy_lock include/net/cfg80211.h:6014 [inline]
 reg_leave_invalid_chans net/wireless/reg.c:2468 [inline]
 reg_check_chans_work+0x164/0xfd0 net/wireless/reg.c:2483
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by kthreadd/2:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:3/52:
5 locks held by kworker/0:2/937:
3 locks held by kworker/u8:5/1067:
 #0: ffff8880b863ea98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
 #1: ffff8880b8728948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:989
 #2: ffff8880b872a718 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
5 locks held by kworker/u8:7/3017:
2 locks held by syslogd/4667:
1 lock held by klogd/4674:
4 locks held by dhcpcd/4899:
2 locks held by getty/4991:
 #0: ffff888031d9a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
5 locks held by syz-executor223/5245:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller #0
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
CPU: 1 UID: 0 PID: 5245 Comm: syz-executor223 Not tainted 6.12.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__update_freelist_fast mm/slub.c:660 [inline]
RIP: 0010:slab_update_freelist mm/slub.c:730 [inline]
RIP: 0010:__slab_free+0x196/0x3d0 mm/slub.c:4432
Code: ea 48 8b 4c 24 20 4d 89 f8 e8 f6 dc ff ff 89 c3 eb 43 48 8b 5c 24 20 4c 89 f9 48 89 ea 4c 89 e0 48 8b 34 24 f0 48 0f c7 4e 20 <0f> 84 c3 00 00 00 eb 4e e8 5d 7d a9 ff 48 8b 3c 24 4c 89 e6 48 89
RSP: 0018:ffffc90003c370d0 EFLAGS: 00000242
RAX: ffff8880352399c0 RBX: ffff888035239a80 RCX: 0000000000400007
RDX: 0000000000400008 RSI: ffffea0000d48e40 RDI: ffff88801ac41780
RBP: 0000000000400008 R08: 0000000000000001 R09: ffffffff81fe9dcf
R10: dffffc0000000000 R11: fffffbfff2858b07 R12: ffff8880352399c0
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000400007
FS:  000055555f9ef480(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d74c089050 CR3: 0000000078b74000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4142
 ptlock_alloc mm/memory.c:6902 [inline]
 ptlock_init include/linux/mm.h:2958 [inline]
 pmd_ptlock_init include/linux/mm.h:3062 [inline]
 pagetable_pmd_ctor include/linux/mm.h:3100 [inline]
 pmd_alloc_one_noprof include/asm-generic/pgalloc.h:141 [inline]
 __pmd_alloc+0x110/0x620 mm/memory.c:6315
 pmd_alloc include/linux/mm.h:2849 [inline]
 copy_pmd_range+0x8135/0x85f0 mm/memory.c:1235
 copy_pud_range mm/memory.c:1292 [inline]
 copy_p4d_range mm/memory.c:1316 [inline]
 copy_page_range+0x99f/0xe90 mm/memory.c:1414
 dup_mmap kernel/fork.c:750 [inline]
 dup_mm kernel/fork.c:1674 [inline]
 copy_mm+0x11fb/0x1f40 kernel/fork.c:1723
 copy_process+0x1845/0x3d50 kernel/fork.c:2375
 kernel_clone+0x226/0x8f0 kernel/fork.c:2787
 __do_sys_clone kernel/fork.c:2930 [inline]
 __se_sys_clone kernel/fork.c:2914 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2914
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efde123ccf3
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffda41bff68 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efde123ccf3
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffda41bfe07
R10: 000055555f9ef750 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffda41c00a0 R14: 00007ffda41c00e0 R15: 0000000000000002
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.825 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

