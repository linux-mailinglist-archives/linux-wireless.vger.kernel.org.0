Return-Path: <linux-wireless+bounces-26029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81352B128A6
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Jul 2025 05:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769CCAC824A
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Jul 2025 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAA91E32CF;
	Sat, 26 Jul 2025 03:05:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3511DD9D3
	for <linux-wireless@vger.kernel.org>; Sat, 26 Jul 2025 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753499133; cv=none; b=iXnz6Ngkh9Wt6VnE9a9e9xfvJan58TlrYaJESezxGt8dXxDcHq395NlaTPxjL9niUQh8rAQuDv4C+wlzGv0zA8q1xp16mVtjwv2sn40VOWIjg+xPZV1ZJsdUPede8uhhj0dvQyP3CnZvbSOfULO4na/Rnokrubn9s5yjjbv2lps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753499133; c=relaxed/simple;
	bh=7Ip2gJ/1QCII957+Ytmekrl9rOoVKD2vE5dwro7WSBA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YRddr4wASDIz8JOH/LNPYJRT8AoeD8Gb0IkZb/+gGEomGkuAcYayQQo2UgRLubBbieQDTaGj6VR1UUkPbZUpNvP/3ptfxDk1fkosiUow/UoWJ2/R7cPZ8lgN2iX3GHUTMLjFgpWiMpGYf+IuyqBpK879PRZrPC83lFqBKv6CJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-87c73351935so245901739f.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 20:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753499130; x=1754103930;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCsGowBoyXenxev4sP9dHnLJK0Qr8YoV3MC8PSugV2Q=;
        b=iXFhyH5RQQEayPYD+sRrak0Y+0EqxFzaDG/A+zksaXa+7fvouQ8VSyFj9K6RSk5nrv
         UO1yVUVHXTvXAPQkf6Iu/iHyMDCsVpsshAKBvqmcTEMBWb4FTyfnf1PKeMdmAo729/B8
         aBvVp75PhXMjrYrIZq+04FNFpY1XoJdtuaiyUcdTynHY9r/EpBVmDbM1NPhpnGWwW6cI
         8U27ROoPpd5f+8XrdvYePVKOhm8tZNhpO3EQ+Nq1tGznGsDjWsu05n2oZ9o7hSSet1kk
         X1eM30rOiLtoayDEj8AozaeUsnkYGWUDZuq2ZZsoo7bUYhtw1sg5vpN28PAG1BauS3+m
         UHMw==
X-Forwarded-Encrypted: i=1; AJvYcCWX2tmmY0rq4Ozn6okcg8kcU5Z7dQpc8GDEbxuf+A7GH4I57Rg8xM7BdwHO+8XHlIlhKXYRXqttHLSbNvJ2GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9XhgNoYsCfmk9pc6uQ3Kt0T/YR7rbeIZ6X61sRfr47oD196E9
	S7mzoXFAJ80mNT+Wv5dSdbTev7F71BlGuClR5teIuwRVvwe79KPlTQgfPXmmtFkAV463nYFiN89
	ce+34YFGgv1EFa6H+a/BlODxGhbjrYwCq8uRwZA+7WHQMZ9AOuqbAjAXQJrU=
X-Google-Smtp-Source: AGHT+IH9aRZ2vV+5ze0RMdRGBMLNbVsgkpnQJ/9QedbN+l/VWjf0EAAyaJvVZaJ2SIoB5N2be11e28s1RBDLIqH0p4Bjqpn59t20
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:3dc:7b3d:6a45 with SMTP id
 e9e14a558f8ab-3e3c4479a33mr68693985ab.0.1753499130174; Fri, 25 Jul 2025
 20:05:30 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:05:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688445fa.a00a0220.b12ec.0002.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: rcu detected stall in rfkill_fop_release
From: syzbot <syzbot+baad8fdbfa4129f93db6@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89be9a83ccf1 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122a4fd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=859f36d9ccbeaa3e
dashboard link: https://syzkaller.appspot.com/bug?extid=baad8fdbfa4129f93db6
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107a24f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8308fa908910/disk-89be9a83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d53fd6483ee6/vmlinux-89be9a83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1abd3374f12/bzImage-89be9a83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+baad8fdbfa4129f93db6@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (0 ticks this GP) idle=b004/1/0x4000000000000000 softirq=17148/17148 fqs=0
rcu: 	(detected by 0, t=10502 jiffies, g=8145, q=354 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5951 Comm: syz-executor Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__sanitizer_cov_trace_pc+0x5d/0x70 kernel/kcov.c:235
Code: 18 16 00 00 83 fa 02 75 21 48 8b 91 20 16 00 00 48 8b 32 48 8d 7e 01 8b 89 1c 16 00 00 48 39 cf 73 08 48 89 3a 48 89 44 f2 08 <e9> 0e 2d a9 09 cc 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
RSP: 0018:ffffc90000a08d38 EFLAGS: 00000006
RAX: ffffffff81ae7947 RBX: ffff8880b8727c08 RCX: ffff88803157da00
RDX: 0000000000010000 RSI: 1ffff110170e4f7a RDI: ffff88807cf32340
RBP: ffffc90000a08e90 R08: ffff88807cf32357 R09: 0000000000000000
R10: ffff88807cf32340 R11: ffffed100f9e646b R12: ffff88807cf32340
R13: dffffc0000000000 R14: ffff8880b8727c18 R15: ffff8880b8727bc0
FS:  0000555563813500(0000) GS:ffff888125d57000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f24c1fb5f98 CR3: 0000000075e96000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __hrtimer_run_queues+0x6f7/0xc60 kernel/time/hrtimer.c:1805
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5875
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 7b 55 fe 10 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90003eef7d8 EFLAGS: 00000206
RAX: dc145188442c0a00 RBX: 0000000000000000 RCX: dc145188442c0a00
RDX: 0000000000000001 RSI: ffffffff8db6f792 RDI: ffffffff8be1b9c0
RBP: ffffffff8172aae5 R08: 0000000000000000 R09: ffffffff8172aae5
R10: ffffc90003eef998 R11: ffffffff81acfd30 R12: 0000000000000002
R13: ffffffff8e13f0e0 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0xc2/0x2390 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 rfkill_fop_release+0x167/0x220 net/rfkill/core.c:1333
 __fput+0x44c/0xa70 fs/file_table.c:465
 fput_close_sync+0x119/0x200 fs/file_table.c:570
 __do_sys_close fs/open.c:1589 [inline]
 __se_sys_close fs/open.c:1574 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1574
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f069758d60a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 43 91 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 a3 91 02 00 8b 44 24
RSP: 002b:00007fffc99e5b90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f069758d60a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fffc99e5ca0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fffc99e5ca0
R13: 00007fffc99e5ca8 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10501 jiffies! g8145 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=3711
rcu: rcu_preempt kthread starved for 10502 jiffies! g8145 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27128 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16aa/0x4c90 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2054
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2256
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

