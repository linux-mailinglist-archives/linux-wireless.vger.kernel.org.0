Return-Path: <linux-wireless+bounces-12634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACAE970813
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 16:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D1B1C2149F
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F3170A19;
	Sun,  8 Sep 2024 14:20:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EBA16EB5A
	for <linux-wireless@vger.kernel.org>; Sun,  8 Sep 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805220; cv=none; b=uihiS2/GKKgtYMpA6U6VvceDMi0jcaSnz96A+oQ/HCCSfOANCedKD1IXGEvHMh3D58K0L2spcSRkgrPkJcM69CNxooMH/228Ft2YbZly7TOpeqOpMEDkwDSokujk5eqZcSmOPUz0D+tpI89tkT76PEycbUJmwsQHqdZRmdO429w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805220; c=relaxed/simple;
	bh=SHm19Kv8e649NgCl/KjIPwVgSEjYloeJ6gFGKLCnltw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EY6n5eFUMZFNlQtatZHHVOStryKPBVcXXZ1LWmPJbCzXmR84K6bp4WbmGj0F+zEnX3kIa0wRJ5Mw8kklIE5ZB9kw7ei3DeKcGeD7xCNHHmOs65e8BGuq5FX+8WzLC+RuMRK2/cewy+c3mG1KJHXB17VSX33GWu1vMEId7LGDi94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a049f9738fso70643575ab.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2024 07:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725805217; x=1726410017;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxX9NIFcgmNH/7hGyZCxnDbi2/LLZlWt1my5jd+I0ls=;
        b=WiPZwcR2TtI9xC00MziK7vk+otnKf+izTnWV69C+VrUhe/SVWhrUyXgwnHNn51GG9+
         QTYoxjcjQmrPje16otvgNYtJxAUa41nmH54WS6V22wPhgkflhsIk8bcDHro6wFn6Uh6p
         vZPl11o+qlrwiceH5pYiKAOPW0lCDw436WxgX6w2kluXjEFo5o2ZtZIBdu/hHJVLpK+Y
         neoXEFQZwIXH53eZaRqfSghZjNrHGzKEUxjSaVVCLpDvm83hB/7c3ia6N5Fb9YkcbWqB
         j4FUZJ+t8WPyYaNQuFLOJEULtJCekbwadN0GSScgyteJf2uL9oij0mpDRtXfD1gZf/ph
         spyA==
X-Forwarded-Encrypted: i=1; AJvYcCWTlUB+0aCBHCotJFY3S1YjPWjOU5Yhtc4uTXcLBKxSRAKLSv9VoFAAlyKFykPgGYKbxI7pjCO5/XTgpUml/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmrUmx0mutSnubuAnV4a/z3vxdlo21ZFajVpWQuqlweilrZfe
	Ko3xDEaaYKVrP9Or7gF6E1VHm3DV+Ml9zSIgUSf+JooJPDG1H32TOgKnDBDrW38aMtxqFxG1PAV
	3A7a6ZgY83dga9nCnRNgZaDwpkDEoZlKFSnKKRPlZ+Axcb8k2hFquzZs=
X-Google-Smtp-Source: AGHT+IGAgS5zMFT2foI3lTAwJP3D4wtbehWehqIh5rdcbwSp6G4krhXcNuyr18Ic9N8U3oxSj0vj57NdNl21xiq1pu9qiKVsgcoI
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d94:b0:375:8b0e:4434 with SMTP id
 e9e14a558f8ab-3a04f0edba0mr100495585ab.16.1725805217327; Sun, 08 Sep 2024
 07:20:17 -0700 (PDT)
Date: Sun, 08 Sep 2024 07:20:17 -0700
In-Reply-To: <00000000000016d7240613635b86@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee3b0206219c56c6@google.com>
Subject: Re: [syzbot] [wireless?] BUG: soft lockup in mac80211_hwsim_beacon (2)
From: syzbot <syzbot+7e51ea277ea81fe6935d@syzkaller.appspotmail.com>
To: eadavis@qq.com, johannes@sipsolutions.net, kvalo@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d1f2d51b711a Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15231f29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=7e51ea277ea81fe6935d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dc6bc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174a8e00580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b52ee4d6014/disk-d1f2d51b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3409402d9dfd/vmlinux-d1f2d51b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7da5cc92617b/bzImage-d1f2d51b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e51ea277ea81fe6935d@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10502 jiffies, g=9341, q=292 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4294972849-4294962347), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10502 jiffies! g9341 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26144 pid:17    tgid:17    ppid:2      flags:0x00004000
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5268 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:244 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x8/0x90 kernel/kcov.c:313
Code: 44 0a 20 e9 35 b0 5c 0a 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 4c 8b 04 24 <65> 48 8b 14 25 00 d7 03 00 65 8b 05 00 46 70 7e 25 00 01 ff 00 74
RSP: 0018:ffffc900000069e0 EFLAGS: 00000046
RAX: 0000000080010104 RBX: 0000000080010103 RCX: 0000000000010104
RDX: 0000000000010100 RSI: 0000000080010103 RDI: 0000000000000000
RBP: ffffc90000006ac0 R08: ffffffff814145c5 R09: ffffffff814140bf
R10: 0000000000000003 R11: ffff888029290000 R12: ffffc900032cff58
R13: dffffc0000000000 R14: ffffc900032c8000 R15: ffffc900032cff60
FS:  00007f0566290c80(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e30c37180 CR3: 0000000024292000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 should_resched arch/x86/include/asm/preempt.h:103 [inline]
 unwind_next_frame+0x1e75/0x2a00 arch/x86/kernel/unwind_orc.c:672
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x149/0x360 mm/slub.c:4598
 dummy_timer+0x7ce/0x45a0 drivers/usb/gadget/udc/dummy_hcd.c:1981
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x59d/0xd50 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x112/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:182 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:245 [inline]
RIP: 0010:__sanitizer_cov_trace_cmp4+0x2d/0x90 kernel/kcov.c:287
Code: fa 4c 8b 04 24 65 48 8b 14 25 00 d7 03 00 65 8b 05 80 48 70 7e 25 00 01 ff 00 74 10 3d 00 01 00 00 75 5b 83 ba 1c 16 00 00 00 <74> 52 8b 82 f8 15 00 00 83 f8 03 75 47 48 8b 8a 00 16 00 00 44 8b
RSP: 0018:ffffc90000007580 EFLAGS: 00000246
RAX: 0000000000000100 RBX: 0000000000000002 RCX: ffff888029290000
RDX: ffff888029290000 RSI: 0000000000000002 RDI: 0000000000000002
RBP: ffffc90000007660 R08: ffffffff814144cb R09: ffffffff814140bf
R10: 0000000000000003 R11: ffff888029290000 R12: ffffc90000007fe8
R13: dffffc0000000000 R14: 0000000000000002 R15: 1ffff92000000ecc
 unwind_next_frame+0x1d7b/0x2a00 arch/x86/kernel/unwind_orc.c:664
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4552
 skb_kfree_head net/core/skbuff.c:1082 [inline]
 skb_free_head net/core/skbuff.c:1096 [inline]
 skb_release_data+0x64d/0x880 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1188 [inline]
 __kfree_skb net/core/skbuff.c:1202 [inline]
 consume_skb+0xb1/0x160 net/core/skbuff.c:1426
 mac80211_hwsim_beacon_tx+0x3bf/0x850 drivers/net/wireless/virtual/mac80211_hwsim.c:2315
 __iterate_interfaces+0x224/0x510 net/mac80211/util.c:772
 ieee80211_iterate_active_interfaces_atomic+0xd8/0x170 net/mac80211/util.c:808
 mac80211_hwsim_beacon+0xd4/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2345
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x59d/0xd50 kernel/time/hrtimer.c:1753
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1770
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
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 ae 0a 37 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> f3 37 9f f5 65 8b 05 c4 0d 40 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc900032cf840 EFLAGS: 00000206
RAX: 099e6b37ca25bc00 RBX: 1ffff92000659f0c RCX: ffffffff81703fea
RDX: dffffc0000000000 RSI: ffffffff8c0ad560 RDI: 0000000000000001
RBP: ffffc900032cf8d0 R08: ffffffff941e4877 R09: 1ffffffff283c90e
R10: dffffc0000000000 R11: fffffbfff283c90f R12: dffffc0000000000
R13: 1ffff92000659f08 R14: ffffc900032cf860 R15: 0000000000000246
 __debug_check_no_obj_freed lib/debugobjects.c:999 [inline]
 debug_check_no_obj_freed+0x561/0x580 lib/debugobjects.c:1020
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x38a/0xea0 mm/page_alloc.c:2619
 discard_slab mm/slub.c:2587 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3055
 put_cpu_partial+0x17c/0x250 mm/slub.c:3130
 __slab_free+0x2ea/0x3d0 mm/slub.c:4347
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3992 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4048
 getname_flags+0xb7/0x540 fs/namei.c:139
 vfs_fstatat+0x12c/0x190 fs/stat.c:340
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0565f165f4
Code: 64 c7 00 09 00 00 00 83 c8 ff c3 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 00 00 00 00 41 89 ca b8 06 01 00 00 0f 05 <45> 31 c0 3d 00 f0 ff ff 76 10 48 8b 15 03 a8 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffd91bb1a68 EFLAGS: 00000206 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 0000556c2c172550 RCX: 00007f0565f165f4
RDX: 00007ffd91bb1a78 RSI: 00007ffd91bb1b08 RDI: 00000000ffffff9c
RBP: 0000556bf1240df3 R08: 0000556bf1240df3 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 0000000000000000
R13: 0000556c2c172640 R14: 00007ffd91bb1b08 R15: 0000556bf1240a04
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 6.769 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

