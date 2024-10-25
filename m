Return-Path: <linux-wireless+bounces-14500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380E99AFA7F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 08:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD87C1F225E5
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AA31B0F22;
	Fri, 25 Oct 2024 06:59:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C01A4F2F
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839569; cv=none; b=SBa3nvrWB8SuYSncbwHaj7yNl7I+r/swSSEFAnLh4tJ039CWxGDaSXglv8NQU9cQLTC0OiGJKhDke76ewkIupwuZ35xpIm8bTxZ+BI2x6lpIu4ws+tlUTlpsRh4YmasEmZcfFv/bV0aZBB3yGj9xP5elTMn0n4yQQ39LoZTqTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839569; c=relaxed/simple;
	bh=OKNFA53y304TaBpboHCjUhl5/b+sxzwLf5LK+pbVhdg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oTaAoEvaVhCAcCXOxxoRc+uAb4Y7DIKl4Yd7sOL6VWHBsyUwgTikr66UgkVVxynLzOExob0rlvfsfbXjbWBEsN2kT69SWzpZovMSy3T4yKwOev5FCn19oXUDUcfnSOFzdzav36Djiwm2nHN4cnr6EZ4XcqJjjZ69Fg4rY2UVLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so17102995ab.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 23:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839565; x=1730444365;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eoDNAi6C7qxqug0k80GtULK1opCXJvfRY6gUq2yax/o=;
        b=fi9J7fFpU/1reOSYkew4XzPyzoFM4iLBkKWuhM3n/7CWBwqQXidCpuaDuT19Vp1CgE
         SA1Ce8skO1SJf72y/eOp+pLUn0+iAktUOXJRTYH3UB6G8F3N/IK+2pHEJ5CJym2KgqwQ
         rqVD282HznSwun8vGsZoGpu46BL6zIE39J6JzsC/j5CZLeXbZ+MG9e90hepLWGcX3jJp
         Rvjc2Esk4eBSRtVuqJ8hQpR1pfkfFP5CYPcYXhIWevqs3FH6hD0rludsT3fI6N0zviTt
         mkTkOgQGJWgtHeGpqS4Y9NvHb4uxgKMvLV2C36uK+MgbPU19VO7EFivCwEy3Kl7xv0Tp
         NUhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS5znrsEV7NjO4Trf3zzB0v56KZucQm6YgbVKkrrBlVNpFS5ndP7ty/FcmrZIRG/NmerWoJzMdVpiZRv9ztg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgTFryyMPLtJwEwsHIfhc643pkd5N5/xhqTH6fTFhorR7m3RF
	1EIvP4xudr9gpL/X0A5ounnIUcfANSHNFwmdRcJQ60u1srol/kgH8+jBI2X1Wcuncaxc72HrV0e
	ANp2OdCWzAJO/0ib7CBWHqdPWMceem05bmita3cPCBNQPhwSSeLhQPR0=
X-Google-Smtp-Source: AGHT+IFlos7jlNaIGNjckhz5aGAH+ORi6wJ8NRamYJBVchPshOZ0YfP9fYPsJdRrqMWss/DWpstYVnXUDLrR3P5uFA6BNHgC+cY8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1607:b0:3a0:8f99:5e00 with SMTP id
 e9e14a558f8ab-3a4d592cb2emr100325875ab.4.1729839565560; Thu, 24 Oct 2024
 23:59:25 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:59:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b41cd.050a0220.381c35.0010.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in on
From: syzbot <syzbot+524a32a528b99d65b7fb@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    db87114dcf13 Merge tag 'x86_urgent_for_v6.12_rc4' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160ce0a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32b00a87124c18b7
dashboard link: https://syzkaller.appspot.com/bug?extid=524a32a528b99d65b7fb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-db87114d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a1e6237c364/vmlinux-db87114d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6fc6ee2adb43/bzImage-db87114d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+524a32a528b99d65b7fb@syzkaller.appspotmail.com

Oct 21 06:58:24 syzkaller daemon.err dhcpcd[5056]: libudev: received NULL device
Oct 21 06:58:24 syzkaller daemon.err dhcpcd[5056]: libudev: received NULL device
Oct 21 06:58:24 syzkaller daemon.err dhcpcd[5056]: libudev: received NULOct 21 06:58:24 [   69.594319][    C3] ------------[ cut here ]------------
syzkaller daemon[   69.595934][    C3] WARNING: CPU: 3 PID: 1196 at net/mac80211/tx.c:5038 __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5038 [inline]
syzkaller daemon[   69.595934][    C3] WARNING: CPU: 3 PID: 1196 at net/mac80211/tx.c:5038 __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5033 [inline]
syzkaller daemon[   69.595934][    C3] WARNING: CPU: 3 PID: 1196 at net/mac80211/tx.c:5038 __ieee80211_beacon_get+0x14ac/0x16b0 net/mac80211/tx.c:5467
.err dhcpcd[5056[   69.598652][    C3] Modules linked in:
]: libudev: rece[   69.604315][    C3] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
ived NULL device[   69.607401][    C3] Workqueue: events_unbound toggle_allocation_gate

Oct 21 06:58:2[   69.611283][    C3] Code: 00 89 df 44 89 e6 e8 63 18 f3 f6 44 38 e3 72 a1 e8 39 17 f3 f6 48 89 ef e8 61 db 49 f7 31 ed e9 9c fe ff ff e8 25 17 f3 f6 90 <0f> 0b 90 e9 86 f6 ff ff 48 89 c6 48 c7 c7 60 66 2d 90 48 89 04 24
4 syzkaller daem[   69.611297][    C3] RSP: 0018:ffffc90000908b88 EFLAGS: 00010246
on.err dhcpcd[50[   69.611322][    C3] RBP: ffffc90000908c38 R08: 0000000000000001 R09: 0000000000000000
56]: libudev: re[   69.611329][    C3] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888027b6f400
ceived NULL devi[   69.630354][    C3] FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
ce
Oct 21 06:58[   69.633091][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
:24 syzkaller da[   69.637300][    C3] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
emon.err dhcpcd[[   69.639870][    C3] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
5056]: libudev: [   69.642360][    C3] Call Trace:
received NULL de[   69.642367][    C3]  <IRQ>
vice
Oct 21 06:[   69.642372][    C3]  ? __warn+0xea/0x3d0 kernel/panic.c:746
58:24 syzkaller [   69.642406][    C3]  ? __report_bug lib/bug.c:199 [inline]
58:24 syzkaller [   69.642406][    C3]  ? report_bug+0x3c0/0x580 lib/bug.c:219
daemon.err dhcpc[   69.649312][    C3]  ? handle_bug+0x54/0xa0 arch/x86/kernel/traps.c:285
d[5056]: libudev[   69.650853][    C3]  ? exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:309
: received NULL [   69.650866][    C3]  ? asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
device
Oct 21 0[   69.650882][    C3]  ? __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5038 [inline]
Oct 21 0[   69.650882][    C3]  ? __ieee80211_beacon_get+0xb32/0x16b0 net/mac80211/tx.c:5467
6:58:24 syzkalle[   69.656059][    C3]  ? __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5038 [inline]
6:58:24 syzkalle[   69.656059][    C3]  ? __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5033 [inline]
6:58:24 syzkalle[   69.656059][    C3]  ? __ieee80211_beacon_get+0x14ab/0x16b0 net/mac80211/tx.c:5467
r daemon.err dhc[   69.659451][    C3]  ? __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5038 [inline]
r daemon.err dhc[   69.659451][    C3]  ? __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5033 [inline]
r daemon.err dhc[   69.659451][    C3]  ? __ieee80211_beacon_get+0x14ab/0x16b0 net/mac80211/tx.c:5467
pcd[5056]: libud[   69.659470][    C3]  ieee80211_beacon_get_tim+0xa7/0x280 net/mac80211/tx.c:5594
ev: received NUL[   69.659484][    C3]  ? __pfx_ieee80211_beacon_get_tim+0x10/0x10 net/mac80211/tx.c:5585
L device
Oct 21[   69.665141][    C3]  ieee80211_beacon_get include/net/mac80211.h:5607 [inline]
Oct 21[   69.665141][    C3]  mac80211_hwsim_beacon_tx+0x4ea/0xa00 drivers/net/wireless/virtual/mac80211_hwsim.c:2311
 06:58:24 syzkal[   69.667026][    C3]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 06:58:24 syzkal[   69.667026][    C3]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
ler daemon.err d[   69.667042][    C3]  ? trace_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24
hcpcd[5056]: lib[   69.667058][    C3]  __iterate_interfaces+0x2d0/0x5d0 net/mac80211/util.c:774
udev: received N[   69.672136][    C3]  ? __pfx_mac80211_hwsim_beacon_tx+0x10/0x10 drivers/net/wireless/virtual/mac80211_hwsim.c:2254
ULL device
Oct [   69.674142][    C3]  ? __pfx_mac80211_hwsim_beacon_tx+0x10/0x10 drivers/net/wireless/virtual/mac80211_hwsim.c:2254
21 06:58:24 syzk[   69.679503][    C3]  mac80211_hwsim_beacon+0x105/0x200 drivers/net/wireless/virtual/mac80211_hwsim.c:2345
aller daemon.err[   69.679519][    C3]  __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
aller daemon.err[   69.679519][    C3]  __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 dhcpcd[5056]: l[   69.679534][    C3]  ? __pfx___hrtimer_run_queues+0x10/0x10 kernel/time/hrtimer.c:650
ibudev: received[   69.686553][    C3]  hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 NULL device
Oc[   69.688256][    C3]  handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
t 21 06:58:24 sy[   69.691323][    C3]  __do_softirq kernel/softirq.c:588 [inline]
t 21 06:58:24 sy[   69.691323][    C3]  invoke_softirq kernel/softirq.c:428 [inline]
t 21 06:58:24 sy[   69.691323][    C3]  __irq_exit_rcu kernel/softirq.c:637 [inline]
t 21 06:58:24 sy[   69.691323][    C3]  irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
zkaller daemon.e[   69.691336][    C3]  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
zkaller daemon.e[   69.691336][    C3]  sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
rr dhcpcd[5056]:[   69.691361][    C3]  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
 libudev: receiv[   69.698332][    C3] RIP: 0010:__sanitizer_cov_trace_pc+0x41/0x70 kernel/kcov.c:217
ed NULL device
Oct 21 06:58:24 [   69.709576][    C3] RDX: ffff888027810000 RSI: ffffffff81816396 RDI: 0000000000000005
syzkaller daemon[   69.712049][    C3] RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
.err dhcpcd[5056[   69.714525][    C3] R10: 0000000000000001 R11: 0000000000000000 R12: ffffed100d4c8d49
]: libudev: rece[   69.719057][    C3]  ? csd_lock_wait kernel/smp.c:340 [inline]
]: libudev: rece[   69.719057][    C3]  ? smp_call_function_many_cond+0x47c/0x1300 kernel/smp.c:884
Oct 21 06:58:24 [   69.721031][    C3]  ? rep_nop arch/x86/include/asm/vdso/processor.h:13 [inline]
Oct 21 06:58:24 [   69.721031][    C3]  ? cpu_relax arch/x86/include/asm/vdso/processor.h:18 [inline]
Oct 21 06:58:24 [   69.721031][    C3]  ? csd_lock_wait kernel/smp.c:340 [inline]
Oct 21 06:58:24 [   69.721031][    C3]  ? smp_call_function_many_cond+0x456/0x1300 kernel/smp.c:884
syzkaller daemon[   69.723074][    C3]  rep_nop arch/x86/include/asm/vdso/processor.h:13 [inline]
syzkaller daemon[   69.723074][    C3]  cpu_relax arch/x86/include/asm/vdso/processor.h:18 [inline]
syzkaller daemon[   69.723074][    C3]  csd_lock_wait kernel/smp.c:340 [inline]
syzkaller daemon[   69.723074][    C3]  smp_call_function_many_cond+0x456/0x1300 kernel/smp.c:884
.err dhcpcd[5056[   69.723089][    C3]  ? __pfx_do_sync_core+0x10/0x10 arch/x86/include/asm/pgtable_64.h:67
]: libudev: rece[   69.728248][    C3]  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1051
ived NULL device[   69.731304][    C3]  ? arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
ived NULL device[   69.731304][    C3]  ? kfence_alloc include/linux/kfence.h:121 [inline]
ived NULL device[   69.731304][    C3]  ? slab_alloc_node mm/slub.c:4118 [inline]
ived NULL device[   69.731304][    C3]  ? __do_kmalloc_node mm/slub.c:4263 [inline]
ived NULL device[   69.731304][    C3]  ? __kmalloc_node_track_caller_noprof+0xe5/0x430 mm/slub.c:4283

Oct 21 06:58:2[   69.733405][    C3]  ? __pfx_text_poke_bp_batch+0x10/0x10 arch/x86/include/asm/atomic.h:23
4 syzkaller daem[   69.735201][    C3]  ? __jump_label_patch+0x1db/0x400 arch/x86/kernel/jump_label.c:79
on.err dhcpcd[50[   69.736952][    C3]  ? arch_jump_label_transform_queue+0xc0/0x120 arch/x86/kernel/jump_label.c:140
56]: libudev: re[   69.739139][    C3]  text_poke_flush arch/x86/kernel/alternative.c:2486 [inline]
56]: libudev: re[   69.739139][    C3]  text_poke_flush arch/x86/kernel/alternative.c:2483 [inline]
56]: libudev: re[   69.739139][    C3]  text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2493
ceived NULL devi[   69.739156][    C3]  arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
ce
Oct 21 06:58[   69.739171][    C3]  jump_label_update+0x1d7/0x400 kernel/jump_label.c:920
:24 syzkaller da[   69.744441][    C3]  static_key_disable_cpuslocked+0x158/0x1c0 kernel/jump_label.c:240
emon.err dhcpcd[[   69.747683][    C3]  toggle_allocation_gate mm/kfence/core.c:854 [inline]
emon.err dhcpcd[[   69.747683][    C3]  toggle_allocation_gate+0x147/0x260 mm/kfence/core.c:841
5056]: libudev: [   69.749452][    C3]  ? __pfx_toggle_allocation_gate+0x10/0x10 mm/kfence/core.c:825
received NULL de[   69.751402][    C3]  ? trace_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24
vice
Oct 21 06:[   69.751419][    C3]  ? process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
58:24 syzkaller [   69.757416][    C3]  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
daemon.err dhcpc[   69.759072][    C3]  ? __pfx_nsim_dev_trap_report_work+0x10/0x10 drivers/net/netdevsim/dev.c:1250
d[5056]: libudev[   69.762489][    C3]  ? assign_work+0x1a0/0x250 kernel/workqueue.c:1200
: received NULL [   69.764121][    C3]  process_scheduled_works kernel/workqueue.c:3310 [inline]
: received NULL [   69.764121][    C3]  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
device
Oct 21 0[   69.765757][    C3]  ? __kthread_parkme+0x148/0x220 kernel/kthread.c:293
6:58:24 syzkalle[   69.765783][    C3]  kthread+0x2c1/0x3a0 kernel/kthread.c:389
r daemon.err dhc[   69.770228][    C3]  ? __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
r daemon.err dhc[   69.770228][    C3]  ? _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
pcd[5056]: libud[   69.773274][    C3]  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
ev: received NUL[   69.773299][    C3]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
L device
Oct 21[   69.777769][    C3]  </TASK>


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

