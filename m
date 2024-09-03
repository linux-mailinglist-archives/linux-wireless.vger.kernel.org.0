Return-Path: <linux-wireless+bounces-12364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0F8969500
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347511F26278
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294D1D6C72;
	Tue,  3 Sep 2024 07:16:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFD1D6C56
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347785; cv=none; b=M5tT+JGsxfq1Ol+7Pb/quoYOHi+1zdCkil8kfCry4XfuINzkDijxiQxgGtvMw7tDB3LkiSzXmFuZGx0RXaldDQ6KXHuni5eJXhLnBAjoHfWWr+kOdS5Z8J+ulF2kEjJ9+WcQjJS/zBAaZqSQLPadRLJOeOPDJ6Jgp32+ggYSHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347785; c=relaxed/simple;
	bh=7PCDqKcuZwW17CmNoJghAyP+vtXSQiXuL8UzueSvrv0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F1RFJ6aK9vrvCE77wERgTNDV4++NqB3dEzB0Hixjd1G4zObzBhIkWUYxkZ7ww2dNtXBaearAdczLXBkIbY9bJ1NwQO5Qfh2xyFN1Es4oC8Fk9cFD80T8RkzTUZlsbx7o/cn/FOUiCx4mwZrsxMYNMlZcySHqscgi2mhJKaVXkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d4b5b9fa0so62369745ab.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2024 00:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347782; x=1725952582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/6Rgnk6qBQhmvJSJiVwCn2NVc+RiS3SrdiTtR05Eag=;
        b=NLhLCp4p4poBi3FREJjJxPMBIAGNndiFDs1JdyAE3gguxN8C38TVc19ntSV47iDX2E
         kqvEd9I3WEbmTP0GAsOBtT2XVSTu3fSW/RHfEfOCjnSrkuhSKic8iQf+mh0sJVEwqINq
         LIXfn4KLaDVzMvssMgUNlvQokFSjWNKoF53+jkfVd3RQymx/N/7kmyTQEnd7ZG8xCnbj
         aENUREQAbEs9Cca/WSmbN+r1yRnU8PE51PU9SnH5bWdqlhhNpXTnGpzmaOc4dJzJWPNB
         dRtpq2r87S9ue4tG+WnnxrC36SQ7nUvKNNG+zkahtxfAlcBLul+QG1+cIElws5BMZD8d
         4c8g==
X-Forwarded-Encrypted: i=1; AJvYcCVU6VnO/zqrok+Dr2vz4mELrb0NIq/cMpCJqWIsvMOftBuqcQnE7MjKk3taLx+60tpmPdLyg4nGf8d+UX6feQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUyIXVX/EwQpXnAKca273uLs6ZrhpUugvKDHu/VDkTQaZ+QYRD
	Vq758RUf/LexaMemw3rRx8VU/UpEQL+QxokQkUvwm50klPSE4FBUcwubYpxaiLh4YLFrHs7wzZi
	2a1OvyX4M5ZfQa2mmND86wEp3Nc+9eTABdluNMDSLAz4Di712c39MMJ8=
X-Google-Smtp-Source: AGHT+IF5EhBbs1Ga5vJirbzbjsMHJarzmN0NW0Gl70vFMAt9UeGMsBVn3/COPZSGX2itWYH82cIOSBdjA2T+SEQ4SZ7PivYHJIaw
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca4:b0:382:56bd:dfbc with SMTP id
 e9e14a558f8ab-39f40f00469mr8913615ab.2.1725347782510; Tue, 03 Sep 2024
 00:16:22 -0700 (PDT)
Date: Tue, 03 Sep 2024 00:16:22 -0700
In-Reply-To: <00000000000007103b061af41e81@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0daf1062131d5d0@google.com>
Subject: Re: [syzbot] [wireless?] INFO: rcu detected stall in ieee80211_handle_queued_frames
From: syzbot <syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    67784a74e258 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176dcb1f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159b2b0b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171543db980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25fcdd13a90b/disk-67784a74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b22a50aa945b/vmlinux-67784a74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b2809c4f6f3/bzImage-67784a74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5329/1:b..l P25/1:b..l P4668/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=9045, q=1541 ncpus=2)
task:klogd           state:R  running task     stack:23536 pid:4668  tgid:4668  ppid:1      flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6708
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6732
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 unwind_next_frame+0x2124/0x2a00 arch/x86/kernel/unwind_orc.c:672
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 discard_slab mm/slub.c:2583 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3051
 put_cpu_partial+0x17c/0x250 mm/slub.c:3126
 __slab_free+0x2ea/0x3d0 mm/slub.c:4343
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4080
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:664
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6526
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
 unix_dgram_sendmsg+0x6d3/0x1f80 net/unix/af_unix.c:2030
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5333f549b5
RSP: 002b:00007ffe06625c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f5333f549b5
RDX: 0000000000000054 RSI: 000055c0464932a0 RDI: 0000000000000003
RBP: 000055c04648e910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007f53340e2212 R14: 00007ffe06625d78 R15: 0000000000000000
 </TASK>
task:kworker/1:0     state:R  running task     stack:24952 pid:25    tgid:25    ppid:2      flags:0x00004000
Workqueue: events nsim_fib_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6708
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6732
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 unwind_next_frame+0x2124/0x2a00 arch/x86/kernel/unwind_orc.c:672
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 discard_slab mm/slub.c:2583 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3051
 put_cpu_partial+0x17c/0x250 mm/slub.c:3126
 __slab_free+0x2ea/0x3d0 mm/slub.c:4343
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __kmalloc_cache_noprof+0x132/0x2c0 mm/slub.c:4184
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:547 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x19c5/0x4130 drivers/net/netdevsim/fib.c:1492
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:syz-executor189 state:R  running task     stack:26576 pid:5329  tgid:5329  ppid:5251   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6708
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6732
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 zap_pte_range mm/memory.c:1688 [inline]
 zap_pmd_range mm/memory.c:1736 [inline]
 zap_pud_range mm/memory.c:1765 [inline]
 zap_p4d_range mm/memory.c:1786 [inline]
 unmap_page_range+0x3818/0x42c0 mm/memory.c:1807
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1897
 exit_mmap+0x264/0xc80 mm/mmap.c:3412
 __mmput+0x115/0x390 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 get_signal+0x16a1/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3bd4e63d0b
RSP: 002b:00007ffeff8d8b30 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffffc RBX: 00007ffeff8d9c20 RCX: 00007f3bd4e63d0b
RDX: 00007ffeff8d9c20 RSI: 0000000080085502 RDI: 0000000000000003
RBP: 0000000080085502 R08: 00007f3bd4ed93ec R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000800000000
R13: 00007ffeff8d8c18 R14: 00007f3bd4e248a0 R15: 0000000000000003
 </TASK>
rcu: rcu_preempt kthread starved for 8177 jiffies! g9045 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25656 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2034
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2236
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 23 Comm: migration/1 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Stopper: 0x0 <- 0x0
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:102 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
RIP: 0010:unwind_next_frame+0x514/0x2a00 arch/x86/kernel/unwind_orc.c:494
Code: c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 34 48 63 2b 48 01 dd 48 89 ef 4c 89 f6 e8 b0 62 52 00 48 8d 43 04 <4c> 39 f5 4c 0f 46 e8 48 8d 43 fc 4c 0f 47 e0 4c 0f 46 fb 4d 39 e5
RSP: 0018:ffffc90000a16c28 EFLAGS: 00000006
RAX: ffffffff908e41cc RBX: ffffffff908e41c8 RCX: ffff88801d2f5a00
RDX: ffff88801d2f5a00 RSI: ffffffff8b254ba6 RDI: ffffffff8b254308
RBP: ffffffff8b254308 R08: ffffffff81412c60 R09: ffffc90000a16df0
R10: 0000000000000003 R11: ffffffff817f2f80 R12: ffffffff908e41c8
R13: ffffffff908e41c8 R14: ffffffff8b254ba6 R15: ffffffff908e41c8
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055df59201010 CR3: 000000002e69e000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4189
 kmalloc_noprof include/linux/slab.h:681 [inline]
 dummy_urb_enqueue+0x7d/0x760 drivers/usb/gadget/udc/dummy_hcd.c:1271
 usb_hcd_submit_urb+0x36e/0x1e80 drivers/usb/core/hcd.c:1533
 ath9k_hif_usb_reg_in_cb+0x472/0x650 drivers/net/wireless/ath/ath9k/hif_usb.c:792
 __usb_hcd_giveback_urb+0x42e/0x6e0 drivers/usb/core/hcd.c:1650
 dummy_timer+0x830/0x45a0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x59d/0xd50 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x112/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:unwind_get_return_address+0x7/0xc0 arch/x86/kernel/unwind_orc.c:365
Code: 8b 74 24 14 e9 dd fe ff ff e8 25 74 78 0a 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 57 <41> 56 53 48 89 fb 49 be 00 00 00 00 00 fc ff df e8 04 67 52 00 48
RSP: 0018:ffffc90000a17ac8 EFLAGS: 00000246
RAX: ffffffff8137868f RBX: ffffffff8b2f87b2 RCX: ffff88801d2f5a00
RDX: 0000000000000100 RSI: 0000000080000302 RDI: ffffc90000a17ae0
RBP: ffffc90000a17b70 R08: ffffffff814145c5 R09: ffffffff814140bf
R10: 0000000000000003 R11: ffff88801d2f5a00 R12: ffff88801d2f5a00
R13: ffffffff817f2f80 R14: ffffc90000a17bc0 R15: ffffc90000a17ae0
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 ieee80211_inform_bss+0xbb2/0x1080 net/mac80211/scan.c:160
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0xe95/0x2030 net/wireless/scan.c:2335
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3159
 cfg80211_inform_bss_frame_data+0x3b8/0x720 net/wireless/scan.c:3254
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5225 [inline]
 ieee80211_rx_list+0x2b02/0x3780 net/mac80211/rx.c:5462
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5485
 ieee80211_rx include/net/mac80211.h:5124 [inline]
 ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:439
 tasklet_action_common+0x323/0x4d0 kernel/softirq.c:785
 handle_softirqs+0x2c6/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5062
Code: c9 50 e8 d9 b6 0b 00 48 83 c4 08 4c 89 f7 e8 7d 38 00 00 0f 1f 44 00 00 4c 89 f7 e8 a0 a3 5f 0a e8 ab db 36 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc900001d7ba8 EFLAGS: 00000286
RAX: c4c3a66fc77b1d00 RBX: ffff88801d2f5a00 RCX: ffffffff9a33b903
RDX: dffffc0000000000 RSI: ffffffff8c0ad560 RDI: ffffffff8c608d40
RBP: ffffc900001d7bf0 R08: ffffffff90186f2f R09: 1ffffffff2030de5
R10: dffffc0000000000 R11: fffffbfff2030de6 R12: 1ffff11017127eeb
R13: dffffc0000000000 R14: ffff8880b893e9c0 R15: ffff8880b893f758
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0x1808/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

