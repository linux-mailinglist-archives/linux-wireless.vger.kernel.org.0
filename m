Return-Path: <linux-wireless+bounces-18488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A51A2836E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 05:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C803A618F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 04:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC56217F23;
	Wed,  5 Feb 2025 04:44:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0421517A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738730661; cv=none; b=ZBRqymTghCEmqGUg2E9zPTYvaQWi+oJH/XKGndZLfn1y8uNfOXy6YU2aiDMJ2fCWAh+zb16Eg5Vc0/YawIhkJqqacCxXLWV3GesIHiaxZVjh/roPQaQuKx0XKe2Ctxq9oK/y4RRzBE9djmxpD6AyTYEf8qMzTPl+4PaufHNZLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738730661; c=relaxed/simple;
	bh=Cg2HJkW1sbdNE4V4wL0IA4U0MsnkB9eB3MdOcj6t6xQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hymsyc6RZQ/49jZ4b0zDaD5NMxLsY7Z0H9NMyTNyop+H9p6AveNerLII5b8thwEvLhLhn/56M5UjP1nCCKZPnSxbXGvMPBPFxOF9vxKj4OTkevdVtgrt2C96OCJge3mJp3itDRFMPC/XEqs8I9tJvpSLodR82P/V1XiNtJ0LPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d04d797364so6800445ab.3
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 20:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738730659; x=1739335459;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyTkqxJ0hYin2KvGLn5CxFCjefqNei6FhBUKAWLZm94=;
        b=c1teW3dM9hAv27+3+eO7l7gFGnDzVbEPEgc4pzWq0ZCxjbh1CbCx4dd5NuFwr0shl3
         tNTW2QXk7YcTlaruSzv4WdBOodK3oZpGe78CTzXGnKkMO7w4LdAB7qO6obIDO/P0E71i
         bX5+FN6CVYW34J8WLbWqcSt1NoraE8UWuvsanqOh3Nzrh2fRaTTAr2JFMFdDIyrSc+Af
         +ZKiSbxLy12GmmFome4jRW3VWeDXxn/JP6FA1KShheuSHIt7wcNSzPE1dGMAAZwOPwrO
         9xI9WnZEjsVPGvA1AviEHqH/NDVJqREbwh05wNnOgWyq0Vy9vOvoUQyBsd9c8sZZzOv8
         +kjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcia7Ju9ZR4RwjNI+j92vGA0zYJkMQeNkFYezUC6uHCPcMsFPvdlF1ZDGoorC8XniNtz/UWVtY6T1NwEtdMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yydme19U4YZGTMITxnexHITnZInfSFVYWM9HXYrzfUdUutSkuUy
	eEnNed5ADO9leiLgSOJXTwy8HAk9vkt76zdwehmaUIBEYbkcWUSq24LuWFKT4Fbun2wqPCbGELG
	iwTE0GqT/RLuVUnXit4XeuOCk7uhVcLrp5SU0uFwyI4jlhZe6dSGHhAI=
X-Google-Smtp-Source: AGHT+IHpVTjHoHFSbnYYmPZa5aKzqUHV21hikpKjD1QENEqP4qLMXjSsmQpp4tb5yFZx7IDKjBxE5T5eW/PULDsnq0LylSGPxAfN
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:3d0:4e57:bbe2 with SMTP id
 e9e14a558f8ab-3d04f93aea7mr15638025ab.20.1738730658829; Tue, 04 Feb 2025
 20:44:18 -0800 (PST)
Date: Tue, 04 Feb 2025 20:44:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a2eca2.050a0220.50516.000a.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in on (2)
From: syzbot <syzbot+1940948c36d6e4d83406@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D14abc518580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D36c931489897af8=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1940948c36d6e4d83=
406
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7fe=
b34a89c2a/non_bootable_disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c6679b95774/vmlinux-=
69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1e328257cca/bzI=
mage-69e858e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+1940948c36d6e4d83406@syzkaller.appspotmail.com

Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: reFeb  1 04:41:=
22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: re[   80.565140=
][    C3] ------------[ cut here ]------------
ceived NULL devi[   80.566857][    C3] WARNING: CPU: 3 PID: 215 at net/mac8=
0211/tx.c:5040 __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5040 [inl=
ine]
ceived NULL devi[   80.566857][    C3] WARNING: CPU: 3 PID: 215 at net/mac8=
0211/tx.c:5040 __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5035 [inl=
ine]
ceived NULL devi[   80.566857][    C3] WARNING: CPU: 3 PID: 215 at net/mac8=
0211/tx.c:5040 __ieee80211_beacon_get+0x14ac/0x16b0 net/mac80211/tx.c:5469
Feb  1 04:41:22 [   80.570111][    C3] Modules linked in:
syzkaller daemon[   80.575975][    C3] Hardware name: QEMU Standard PC (Q35=
 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
.err dhcpcd[5656[   80.579416][    C3] Workqueue: events_unbound toggle_all=
ocation_gate
Feb  1 04:41:22 [   80.583612][    C3] Code: 00 89 df 44 89 e6 e8 73 27 e2 =
f6 44 38 e3 72 a1 e8 89 2d e2 f6 48 89 ef e8 11 94 3a f7 31 ed e9 9c fe ff =
ff e8 75 2d e2 f6 90 <0f> 0b 90 e9 86 f6 ff ff 48 89 c6 48 c7 c7 e0 9c 2f 9=
0 48 89 04 24
syzkaller daemon[   80.589526][    C3] RSP: 0018:ffffc90000708b70 EFLAGS: 0=
0010246
.err dhcpcd[5656[   80.594053][    C3] RDX: ffff888023d5a440 RSI: ffffffff8=
ad7812b RDI: 0000000000000001
]: libudev: rece[   80.598999][    C3] R10: 0000000000000000 R11: 000000000=
0000006 R12: ffff88802522b800
Feb  1 04:41:22 syzkaller daemon[   80.604776][    C3] FS:  000000000000000=
0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
Feb  1 04:41:22 [   80.607457][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
syzkaller daemon[   80.609759][    C3] CR2: 000055555dc9d5c8 CR3: 000000000=
df80000 CR4: 0000000000352ef0
.err dhcpcd[5656[   80.612525][    C3] DR0: 0000000000000000 DR1: 000000000=
0000000 DR2: 0000000000000000
Feb  1 04:41:22 [   80.617384][    C3] Call Trace:
syzkaller daemon[   80.619665][    C3]  ? __warn+0xea/0x3c0 kernel/panic.c:=
746
Feb  1 04:41:22 [   80.621268][    C3]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5040 [inline]
Feb  1 04:41:22 [   80.621268][    C3]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5035 [inline]
Feb  1 04:41:22 [   80.621268][    C3]  ? __ieee80211_beacon_get+0x14ac/0x1=
6b0 net/mac80211/tx.c:5469
syzkaller daemon[   80.623422][    C3]  ? __report_bug lib/bug.c:199 [inlin=
e]
syzkaller daemon[   80.623422][    C3]  ? report_bug+0x3c0/0x580 lib/bug.c:=
219
.err dhcpcd[5656[   80.623443][    C3]  ? handle_bug+0x54/0xa0 arch/x86/ker=
nel/traps.c:285
]: libudev: rece[   80.623454][    C3]  ? exc_invalid_op+0x17/0x50 arch/x86=
/kernel/traps.c:309
ived NULL device[   80.623465][    C3]  ? asm_exc_invalid_op+0x1a/0x20 arch=
/x86/include/asm/idtentry.h:621

Feb  1 04:41:2[   80.623491][    C3]  ? __ieee80211_beacon_update_cntdwn ne=
t/mac80211/tx.c:5040 [inline]
Feb  1 04:41:2[   80.623491][    C3]  ? __ieee80211_beacon_update_cntdwn ne=
t/mac80211/tx.c:5035 [inline]
Feb  1 04:41:2[   80.623491][    C3]  ? __ieee80211_beacon_get+0x14ab/0x16b=
0 net/mac80211/tx.c:5469
2 syzkaller daem[   80.623502][    C3]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5040 [inline]
2 syzkaller daem[   80.623502][    C3]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5035 [inline]
2 syzkaller daem[   80.623502][    C3]  ? __ieee80211_beacon_get+0x14ac/0x1=
6b0 net/mac80211/tx.c:5469
on.err dhcpcd[56[   80.639836][    C3]  ? trace_raw_output_contention_begin=
+0x90/0x100 include/trace/events/lock.h:95
56]: libudev: re[   80.642110][    C3]  ieee80211_beacon_get include/net/ma=
c80211.h:5641 [inline]
56]: libudev: re[   80.642110][    C3]  mac80211_hwsim_beacon_tx+0x4ea/0xa1=
0 drivers/net/wireless/virtual/mac80211_hwsim.c:2311
ceived NULL devi[   80.644117][    C3]  ? __pfx_lock_acquire.part.0+0x10/0x=
10 kernel/locking/lockdep.c:122
ce
Feb  1 04:41[   80.646194][    C3]  ? rcu_is_watching_curr_cpu include/linu=
x/context_tracking.h:128 [inline]
Feb  1 04:41[   80.646194][    C3]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/=
tree.c:716
:22 syzkaller da[   80.646224][    C3]  ? __pfx_mac80211_hwsim_beacon_tx+0x=
10/0x10 drivers/net/wireless/virtual/mac80211_hwsim.c:2254
emon.err dhcpcd[[   80.651709][    C3]  ? __pfx_mac80211_hwsim_beacon_tx+0x=
10/0x10 drivers/net/wireless/virtual/mac80211_hwsim.c:2254
5656]: libudev: [   80.653917][    C3]  ? __pfx_mac80211_hwsim_beacon+0x10/=
0x10 drivers/net/wireless/virtual/mac80211_hwsim.c:3161
received NULL de[   80.655986][    C3]  ieee80211_iterate_active_interfaces=
_atomic+0x71/0x1b0 net/mac80211/util.c:796
vice
Feb  1 04:[   80.660032][    C3]  __run_hrtimer kernel/time/hrtimer.c:1738 =
[inline]
Feb  1 04:[   80.660032][    C3]  __hrtimer_run_queues+0x20a/0xae0 kernel/t=
ime/hrtimer.c:1802
41:22 syzkaller [   80.661949][    C3]  ? __pfx___hrtimer_run_queues+0x10/0=
x10 include/trace/events/timer.h:222
daemon.err dhcpc[   80.664061][    C3]  ? rdtsc_ordered arch/x86/include/as=
m/msr.h:217 [inline]
daemon.err dhcpc[   80.664061][    C3]  ? read_tsc+0x9/0x20 arch/x86/kernel=
/tsc.c:1133
Feb  1 04:41:22 [   80.665708][    C3]  hrtimer_run_softirq+0x17d/0x350 ker=
nel/time/hrtimer.c:1819
syzkaller daemon[   80.667629][    C3]  handle_softirqs+0x213/0x8f0 kernel/=
softirq.c:561
.err dhcpcd[5656[   80.667648][    C3]  ? __pfx_handle_softirqs+0x10/0x10 i=
nclude/trace/events/irq.h:156
Feb  1 04:41:22 [   80.672792][    C3]  irq_exit_rcu+0x9/0x30 kernel/softir=
q.c:678
syzkaller daemon[   80.674405][    C3]  instr_sysvec_apic_timer_interrupt a=
rch/x86/kernel/apic/apic.c:1049 [inline]
syzkaller daemon[   80.674405][    C3]  sysvec_apic_timer_interrupt+0xa4/0x=
c0 arch/x86/kernel/apic/apic.c:1049
.err dhcpcd[5656[   80.677355][    C3]  <TASK>
]: libudev: rece[   80.678641][    C3]  asm_sysvec_apic_timer_interrupt+0x1=
a/0x20 arch/x86/include/asm/idtentry.h:702
ived NULL device[   80.682818][    C3] Code: 0c 00 85 ed 74 4d 48 b8 00 00 =
00 00 00 fc ff df 4d 89 fc 4c 89 fd 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 =
e8 fc 04 0c 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 e8 0b 00 0=
0 8b 43 08 31
Feb  1 04:41:22 [   80.688696][    C3] RSP: 0018:ffffc900032c7928 EFLAGS: 0=
0000293
syzkaller daemon[   80.690906][    C3] RAX: 0000000000000000 RBX: ffff88806=
a646880 RCX: ffffffff81ada9ca
.err dhcpcd[5656[   80.690915][    C3] RDX: ffff888023d5a440 RSI: ffffffff8=
1ada9a4 RDI: 0000000000000005
]: libudev: rece[   80.690934][    C3] R13: 0000000000000001 R14: ffff88806=
a93fe40 R15: ffff88806a646888
ived NULL device[   80.690945][    C3]  ? csd_lock_wait kernel/smp.c:340 [i=
nline]
ived NULL device[   80.690945][    C3]  ? smp_call_function_many_cond+0x4ea=
/0x12c0 kernel/smp.c:885

Feb  1 04:41:2[   80.705792][    C3]  ? rep_nop arch/x86/include/asm/vdso/p=
rocessor.h:13 [inline]
Feb  1 04:41:2[   80.705792][    C3]  ? cpu_relax arch/x86/include/asm/vdso=
/processor.h:18 [inline]
Feb  1 04:41:2[   80.705792][    C3]  ? csd_lock_wait kernel/smp.c:340 [inl=
ine]
Feb  1 04:41:2[   80.705792][    C3]  ? smp_call_function_many_cond+0x4c4/0=
x12c0 kernel/smp.c:885
2 syzkaller daem[   80.707978][    C3]  ? rep_nop arch/x86/include/asm/vdso=
/processor.h:13 [inline]
2 syzkaller daem[   80.707978][    C3]  ? cpu_relax arch/x86/include/asm/vd=
so/processor.h:18 [inline]
2 syzkaller daem[   80.707978][    C3]  ? csd_lock_wait kernel/smp.c:340 [i=
nline]
2 syzkaller daem[   80.707978][    C3]  ? smp_call_function_many_cond+0x4c4=
/0x12c0 kernel/smp.c:885
on.err dhcpcd[56[   80.708005][    C3]  on_each_cpu_cond_mask+0x40/0x90 ker=
nel/smp.c:1052
56]: libudev: re[   80.708016][    C3]  on_each_cpu include/linux/smp.h:71 =
[inline]
56]: libudev: re[   80.708016][    C3]  text_poke_sync arch/x86/kernel/alte=
rnative.c:2114 [inline]
56]: libudev: re[   80.708016][    C3]  text_poke_bp_batch+0x561/0x760 arch=
/x86/kernel/alternative.c:2407
Feb  1 04:41:22 [   80.718892][    C3]  ? text_poke_queue+0xef/0x180 arch/x=
86/kernel/alternative.c:2531
syzkaller daemon[   80.720733][    C3]  ? arch_jump_label_transform_queue+0=
xc0/0x120 arch/x86/kernel/jump_label.c:140
.err dhcpcd[5656[   80.723037][    C3]  text_poke_flush arch/x86/kernel/alt=
ernative.c:2515 [inline]
.err dhcpcd[5656[   80.723037][    C3]  text_poke_flush arch/x86/kernel/alt=
ernative.c:2512 [inline]
.err dhcpcd[5656[   80.723037][    C3]  text_poke_finish+0x30/0x40 arch/x86=
/kernel/alternative.c:2522
]: libudev: rece[   80.724834][    C3]  arch_jump_label_transform_apply+0x1=
c/0x30 arch/x86/kernel/jump_label.c:146
ived NULL device[   80.727004][    C3]  jump_label_update+0x1d7/0x400 kerne=
l/jump_label.c:920
Feb  1 04:41:22 [   80.727033][    C3]  static_key_enable+0x1a/0x20 kernel/=
jump_label.c:223
syzkaller daemon[   80.732398][    C3]  toggle_allocation_gate mm/kfence/co=
re.c:849 [inline]
syzkaller daemon[   80.732398][    C3]  toggle_allocation_gate+0xfc/0x260 m=
m/kfence/core.c:841
.err dhcpcd[5656[   80.734265][    C3]  ? __pfx_toggle_allocation_gate+0x10=
/0x10 mm/kfence/core.c:825
]: libudev: rece[   80.736346][    C3]  ? trace_lock_acquire+0x14e/0x1f0 in=
clude/trace/events/lock.h:24
ived NULL device[   80.736374][    C3]  ? lock_acquire+0x2f/0xb0 kernel/loc=
king/lockdep.c:5822

Feb  1 04:41:2[   80.741332][    C3]  ? process_one_work+0x921/0x1ba0 kerne=
l/workqueue.c:3212
2 syzkaller daem[   80.743209][    C3]  process_one_work+0x9c5/0x1ba0 kerne=
l/workqueue.c:3236
on.err dhcpcd[56[   80.745000][    C3]  ? __pfx_lock_acquire.part.0+0x10/0x=
10 kernel/locking/lockdep.c:122
56]: libudev: re[   80.747053][    C3]  ? __pfx_process_one_work+0x10/0x10 =
include/linux/list.h:153
ceived NULL devi[   80.747072][    C3]  ? assign_work+0x1a0/0x250 kernel/wo=
rkqueue.c:1200
Feb  1 04:41:22 [   80.752240][    C3]  ? __kthread_parkme+0x148/0x220 kern=
el/kthread.c:304
syzkaller daemon[   80.754055][    C3]  ? __pfx_worker_thread+0x10/0x10 inc=
lude/linux/list.h:183
.err dhcpcd[5656[   80.757148][    C3]  ? __pfx_kthread+0x10/0x10 arch/x86/=
include/asm/bitops.h:206
]: libudev: rece[   80.758861][    C3]  ? lock_acquire+0x2f/0xb0 kernel/loc=
king/lockdep.c:5822
Feb  1 04:41:22 [   80.761903][    C3]  ret_from_fork+0x45/0x80 arch/x86/ke=
rnel/process.c:148
syzkaller daemon[   80.763643][    C3]  ? __pfx_kthread+0x10/0x10 arch/x86/=
include/asm/bitops.h:206
.err dhcpcd[5656[   80.765412][    C3]  ret_from_fork_asm+0x1a/0x30 arch/x8=
6/entry/entry_64.S:244
]: l[i bu d e8v0:. 7r6e7c2e52][    C3]  </TASK>
ived NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
eviFeb  1 04:41:22 syzkaller daemon.err dhcpcd[5656Feb  1 04:41:22 syzkalle=
r daemon.err dhcpcd[5656Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: =
libudev: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: Feb  1 04:41:22=
 syzkaller daemonFeb  1 04:41:22 syzkaller daemonFeb  1 04:41:22 syzkaller =
daemon.err dhcpcd[5656]: libudev: received NULL deviceFeb  1 04:41:22 syzka=
ller daemonFeb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: rece=
ived NULL deviceFeb  1 04:41:22 syzkaller daemonFeb  1 04:41:22 syzkaller d=
aemon.err dhcpcd[5656]: libudev: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: Feb  1 04:41:22=
 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[56Feb  1 04:41:22 syzkaller dae=
mon.err dhcpcd[5656]: libudev: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[56Feb  1 04:41:22 syzkaller dae=
monFeb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NUL=
L deviceFeb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: receive=
d NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[56Feb  1 04:41:22 syzkaller dae=
mon.err dhcpcd[5656]: libudev: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[56Feb  1 04:41:22 syzkaller dae=
monFeb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NUL=
L device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[Feb  1 04:41:22 syzkaller daemo=
n.err dhcpcd[5656Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev=
: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: reFeb  1 04:41:=
22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL deviceFeb  1 0=
4:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[56Feb  1 04:41:22 syzkaller dae=
mon.err dhcpcd[5656Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libud=
ev: receFeb  1 04:41:22 syzkaller daemon.err dhcpcd[5656Feb  1 04:41:22 syz=
kaller daemon.err dhcpcd[5656]: libudev: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: reFeb  1 04:41:=
22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL deviceFeb  1 0=
4:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: receFeb  1 04:41:22 syz=
kaller daemonFeb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: re=
ceived NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[Feb  1 04:41:22 syzkaller daemo=
n.err dhcpcd[5656]: libudev: received NULL device
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice
Feb  1 04:41:22 syzkaller daemon.err dhcpcd[5656]: libudev: received NULL d=
evice


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

