Return-Path: <linux-wireless+bounces-8408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6798D7D3E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 10:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9AA1F20FC3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A999058AC4;
	Mon,  3 Jun 2024 08:24:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBB5674B
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403062; cv=none; b=nC2nnKitNbkEgsBsEv93ZC0Y19ba2XUYz9VVeAEJRsj+MbVkz0sXzUePyreyyK1GhSl2D6WNIBBbBfkZvmXtTZCkE/ODTpb0+W761QM13qVTq1H7IJxf2wdE/38J5K1l9Mxdy0Yy9SJvNMxBT5L8I4sd2plHpn+CaKGoGS/iojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403062; c=relaxed/simple;
	bh=qK6rxoEddSCHKyAlVgq5ydLuvDt9pzcVXeKuLyWigxw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CLsPOQO2dpTzQ7nvvUmRZhIkLy6cwERZWrp9dhawMkwl38pxxmc1EVDeUfmuvQlyEsecxvF9uetojvuWiQTyaugr8tMOT83rPYB2WZuT2H5+DLSOXoQwGJsJW0grz/xG3E+ztTpOlSB5gtAVYDi4sVpOKq8qjYT7PmTFwiil6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3747f77bafcso35868875ab.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2024 01:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717403058; x=1718007858;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCHKKjpfLOgUsiooWRcaIIkG1Jg7F4449CYURQRfINw=;
        b=IoFZpR0bjTJpxRjmxdlt2CZU3RJpskcEvv8eEC73SuFHc4ySTxsbXTjmiPf1xVILCf
         SaBVFfmcAo9jQDpi3lHXLkhHJz8ujsZvkw9UvAsfGaCQsWjJj/iiyVBV1fvvUGhM3/3Y
         d+gLmr/reOOmirswAF8L6yix52m3xJkrw9WFG//8Z3eXVT2nqc/KlXBaDVw9zeZ3BifU
         9oYQVi+qgmY7aWrNGdRg9WzB2R2xiHPQAuTUx19BaopHVWJ9KcH0Sw/OY9HLhWdss3ee
         iSB+7UCbz/+/jlKc1r3/ZLD0E/TPfa41qU54LBuSMWzYv537pMwgZstWmHZIGk7Hhy6T
         AiqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1kuDyP2ToriFXe2m1duq6y3EYwgACnkCHVi3ACEtnubZ767tiw9iJti9nKWblp778PoI00M9ECHmj2piBUec8+L5ZgK0yvgSP7cRZnpk=
X-Gm-Message-State: AOJu0YzXrViUXPug+8qerz8cVaz2JPewWoR/PBwO5BOcRmNBuTGAsjbv
	0qZPi/pDOWnvMArEv9E+53yycrdbCMzifNbuQ9Bw4ihcMDL4T9/Hdb/tAVBc0Ijqzjr0CBzPeT9
	7e4GxvBpHFBmmPLbEBTvc8FblP8hEVARMsUF0c8+T42B4NK5of3ksIjg=
X-Google-Smtp-Source: AGHT+IHmjlC/dx6MnxO+OSPMK10FshPAMwv8ojZR+WOPUNXVsJNLO+WpaaCZJdIIkz38e0lOB7UutIM9JS8DwMqPjJGKJ4HFBHo8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:36d:b5df:f478 with SMTP id
 e9e14a558f8ab-3748b9d5c4dmr9355715ab.4.1717403058105; Mon, 03 Jun 2024
 01:24:18 -0700 (PDT)
Date: Mon, 03 Jun 2024 01:24:18 -0700
In-Reply-To: <000000000000b302650619d465cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036feff0619f80ffe@google.com>
Subject: Re: [syzbot] [netfilter?] [mm?] [usb?] INFO: rcu detected stall in
 addrconf_rs_timer (6)
From: syzbot <syzbot+fecf8bd19c1f78edb255@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c3f38fa61af7 Linux 6.10-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165f7364980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0e2e3f7ede77526
dashboard link: https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b38f9a980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c32369f4e04d/disk-c3f38fa6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a0b84bdd5733/vmlinux-c3f38fa6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4957daba4d78/bzImage-c3f38fa6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fecf8bd19c1f78edb255@syzkaller.appspotmail.com

yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10503 jiffies, g=9581, q=694 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10501 (4294964726-4294954225), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10501 jiffies! g9581 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task    
 stack:25168 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2000
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2202
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
yealink 2-1:36.0: urb_irq_callback - urb status -71
NMI backtrace for cpu 0
CPU: 0 PID: 5109 Comm: syz-execprog Not tainted 6.10.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x26/0x90 kernel/kcov.c:304
Code: 90 90 90 90 f3 0f 1e fa 4c 8b 04 24 65 48 8b 14 25 00 d5 03 00 65 8b 05 30 ba 6d 7e a9 00 01 ff 00 74 10 a9 00 01 00 00 74 5b <83> ba 1c 16 00 00 00 74 52 8b 82 f8 15 00 00 83 f8 03 75 47 48 8b
RSP: 0018:ffffc90000006358 EFLAGS: 00000006
RAX: 0000000080010102 RBX: ffffc900000065a1 RCX: ffffffff000000ff
RDX: ffff8880263b0000 RSI: 00000000fffffffd RDI: 0000000000000000
RBP: ffffc90000006450 R08: ffffffff8b7f8085 R09: ffffffff8b7f6df4
R10: 0000000000000012 R11: ffff8880263b0000 R12: ffffffff8bcb7f82
R13: dffffc0000000000 R14: ffffc900000065a0 R15: 00000000fffffffd
FS:  000000c000058490(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0feae530e8 CR3: 00000000223b0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 vsnprintf+0x1415/0x1da0 lib/vsprintf.c:2815
 snprintf+0xda/0x120 lib/vsprintf.c:2959
 print_caller kernel/printk/printk.c:1336 [inline]
 info_print_prefix+0x1f0/0x310 kernel/printk/printk.c:1355
 record_print_text kernel/printk/printk.c:1402 [inline]
 printk_get_next_message+0x6da/0xbe0 kernel/printk/printk.c:2855
 console_emit_next_record kernel/printk/printk.c:2895 [inline]
 console_flush_all+0x410/0xfd0 kernel/printk/printk.c:2994
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
 vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4951
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4962
 _dev_err+0x122/0x170 drivers/base/core.c:5017
 urb_irq_callback+0x37e/0x5b0 drivers/input/misc/yealink.c:416
 __usb_hcd_giveback_urb+0x373/0x530 drivers/usb/core/hcd.c:1648
 dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:nf_ct_frag6_gather+0xd95/0x2050 net/ipv6/netfilter/nf_conntrack_reasm.c:490
Code: 4c 89 e7 e8 6d df bf ff eb 16 31 ff 89 de e8 e2 7e 53 f7 85 db 0f 8e 59 09 00 00 e8 95 7a 53 f7 48 bb 00 00 00 00 00 fc ff df <48> c7 84 24 e0 00 00 00 0e 36 e0 45 42 c7 04 33 00 00 00 00 4a c7
RSP: 0018:ffffc90000007680 EFLAGS: 00000246
RAX: ffffffff8a429347 RBX: dffffc0000000000 RCX: ffff8880263b0000
RDX: 0000000080000101 RSI: ffffffff8f7153d0 RDI: 000000000000003a
RBP: ffffc90000007858 R08: 0000000000000001 R09: ffffffff8a48a3da
R10: 0000000000000006 R11: ffff8880263b0000 R12: ffff88804f6b7280
R13: 000000000000003a R14: 1ffff92000000eec R15: 0000000000000000
 ipv6_defrag+0x2c8/0x3c0 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c:67
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ndisc_send_skb+0x122d/0x1380 net/ipv6/ndisc.c:509
 addrconf_rs_timer+0x36e/0x660 net/ipv6/addrconf.c:4039
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
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
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 fe b2 6a f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 33 67 d4 f5 65 8b 05 64 b1 72 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc90002dff9a0 EFLAGS: 00000206
RAX: d2e81ee974493d00 RBX: 1ffff920005bff38 RCX: ffffffff947a0603
RDX: dffffc0000000000 RSI: ffffffff8bcaba60 RDI: 0000000000000001
RBP: ffffc90002dffa28 R08: ffffffff8fad462f R09: 1ffffffff1f5a8c5
R10: dffffc0000000000 R11: fffffbfff1f5a8c6 R12: dffffc0000000000
R13: 1ffff920005bff34 R14: ffffc90002dff9c0 R15: 0000000000000246
 futex_wait_queue+0xb0/0x1d0 kernel/futex/waitwake.c:357
 __futex_wait+0x17f/0x320 kernel/futex/waitwake.c:669
 futex_wait+0x101/0x360 kernel/futex/waitwake.c:697
 do_futex+0x33b/0x560 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x470343
Code: 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14 4c 8b 54 24 18 4c 8b 44 24 20 44 8b 4c 24 28 b8 ca 00 00 00 0f 05 <89> 44 24 30 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
RSP: 002b:000000c000065e90 EFLAGS: 00000206 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000470343
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000002517b90
RBP: 000000c000065ed8 R08: 0000000000000000 R09: 0000000000000000
R10: 000000c000065ec8 R11: 0000000000000206 R12: 000000c000065ec8
R13: ffffffffffffffff R14: 000000c000006820 R15: 0000000000000000
 </TASK>
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 2-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 2-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 2-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback 

---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

