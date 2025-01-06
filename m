Return-Path: <linux-wireless+bounces-17097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D4DA01EBD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 06:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96583A36D2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 05:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279015886C;
	Mon,  6 Jan 2025 05:12:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A88BE7
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736140329; cv=none; b=gS/dktauHOWdOCNoUUCevqN/rm1lnskhoAIl40WGWXZG67j0IKNgif/UpZHhiYjF5sEuWZeVZR2LRY2nIVUY8cGkEQBERx4R8b+O84IG+cJ1MNkvIb946q5GzixZ+3/zTWctp8T3b75WhwACxi0KaGaCGevMdGrCZosvLlw6Pas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736140329; c=relaxed/simple;
	bh=11s9em1REJIodW0RXX6JhBcMbPL6UbzDhlUoQ6kWEE0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XkEI9W7n2wUZ/WBAdgTI4DvWEYCKbYN1+niWWvTIww0WUQKYOxLpL8D5iXDJH8M+gPIkN47bszOaZ1ccIN1h0D7PKFDg8nbSTFLM0c8V5ALkKkxGq56QkyBR0s3ICkc3W7+9gyR4gLSFAKoZWbP0SxqP9jpL3biAYj6NBOcKDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9cd0b54c1so124363975ab.0
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jan 2025 21:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736140326; x=1736745126;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFfpHfOJ6z5P2UmW/UDSxsJgYlztZmqvRxfQdaO4tz0=;
        b=EjeEoX92tAaPi9OYkhoIUZEtyA3JGbkXe0f/uB6ggWdsd/3UlS/Wr3E13ooNi2+dmh
         ksMHZjCFLD/n7Y9pPzlG+fAM0eecHFAP5QwRsLi/9prYHTp9wspF0YG+OqOpbLBfBsWn
         /lFsT7yXG/HrxZGaEjkF+NOoHPwRX6ySuutEwuH5OP1+uwOgzcpzmI2005jCVAL2zPUD
         Xv3W1RrDSIdch80KlutVHMtmAA41k14snQuVGh7zDB4ZivT2X/+tcv4WCuDjZD4AO+kE
         3q7rT//Swe2WbZYOiiZLN+je85WwFVsqVThJmv33Mv6OXe8NctWH9vkdp0R7z63eKwYU
         6nDg==
X-Forwarded-Encrypted: i=1; AJvYcCVnl1GTrI1gQc46o9hDT1U4lH6mWaocXe4PfZeQCEefc2xipmHLRy3Q33dl+bczIWJC+gZzRtaF15IpPevR6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBufvXS8HjFsaqzlH7QSzaTkx4H0zz0H3/zUI0+6AJL1rP5giY
	OYUWYPHv/A9iFeIXAIUR0A6DDHBn+81XEKN7X1sWaop4fgSpAX5IE1BOBK3tzmz3L9UmEj4jUtw
	NMRovTPR/gJ6p0wDKomLZh0dpShEokGpVrnoef92Qa5KgWJcmeUrHYiA=
X-Google-Smtp-Source: AGHT+IGwBqpjyguvY+NEuhrEiiloCuuWDyLOfwmYM4PRXHtML5yWpqMk/QGlLUyYW0i0CPWCbQlKKJtBsu5N0BRzhuUNONTFcCzr
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:3a7:c5ff:e60b with SMTP id
 e9e14a558f8ab-3c2d1f74a78mr475125105ab.6.1736140326330; Sun, 05 Jan 2025
 21:12:06 -0800 (PST)
Date: Sun, 05 Jan 2025 21:12:06 -0800
In-Reply-To: <87cyh16mab.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677b6626.050a0220.3b3668.0002.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in ath9k_hif_usb_firmware_cb (3)
From: syzbot <syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, nbd@nbd.name, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

s enabled.
[    1.190003][    T0] rcu: 	RCU debug extended QS entry/exit.
[    1.190988][    T0] 	All grace periods are expedited (rcu_expedited).
[    1.191939][    T0] 	Trampoline variant of Tasks RCU enabled.
[    1.192694][    T0] 	Tracing variant of Tasks RCU enabled.
[    1.193396][    T0] rcu: RCU calculated value of scheduler-enlistment de=
lay is 10 jiffies.
[    1.194479][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr=
_cpu_ids=3D2
[    1.195538][    T0] Running RCU synchronous self tests
[    1.196263][    T0] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_=
cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    1.197551][    T0] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu=
_task_cb_adjust=3D1 rcu_task_cpu_ids=3D2.
[    1.275546][    T0] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    1.277185][    T0] rcu: srcu_init: Setting srcu_struct sizes based on c=
ontention.
[    1.278480][    T0] kfence: initialized - using 2097152 bytes for 255 ob=
jects at 0xffff88823be00000-0xffff88823c000000
[    1.280693][    T0] Console: colour VGA+ 80x25
[    1.281394][    T0] printk: legacy console [ttyS0] enabled
[    1.281394][    T0] printk: legacy console [ttyS0] enabled
[    1.282994][    T0] printk: legacy bootconsole [earlyser0] disabled
[    1.282994][    T0] printk: legacy bootconsole [earlyser0] disabled
[    1.284703][    T0] Lock dependency validator: Copyright (c) 2006 Red Ha=
t, Inc., Ingo Molnar
[    1.285830][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    1.286485][    T0] ... MAX_LOCK_DEPTH:          48
[    1.287197][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    1.287919][    T0] ... CLASSHASH_SIZE:          4096
[    1.288630][    T0] ... MAX_LOCKDEP_ENTRIES:     1048576
[    1.289352][    T0] ... MAX_LOCKDEP_CHAINS:      1048576
[    1.290119][    T0] ... CHAINHASH_SIZE:          524288
[    1.290963][    T0]  memory used by lock dependency info: 106625 kB
[    1.291807][    T0]  memory used for stack traces: 8320 kB
[    1.292562][    T0]  per task-struct memory footprint: 1920 bytes
[    1.293542][    T0] mempolicy: Enabling automatic NUMA balancing. Config=
ure with numa_balancing=3D or the kernel.numa_balancing sysctl
[    1.295195][    T0] ACPI: Core revision 20240827
[    1.296401][    T0] APIC: Switch to symmetric I/O mode setup
[    1.297557][    T0] x2apic enabled
[    1.300642][    T0] APIC: Switched APIC routing to: physical x2apic
[    1.305247][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D0 apic2=3D-1=
 pin2=3D-1
[    1.306357][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max=
_cycles: 0x2350b6af5f8, max_idle_ns: 440795252949 ns
[    1.308110][    T0] Calibrating delay loop (skipped) preset value.. 4899=
.99 BogoMIPS (lpj=3D24499980)
[    1.309487][    T0] x86/cpu: User Mode Instruction Prevention (UMIP) act=
ivated
[    1.310835][    T0] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    1.311724][    T0] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 102=
4, 1GB 0
[    1.312765][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers an=
d __user pointer sanitization
[    1.314119][    T0] Spectre V2 : Mitigation: Retpolines
[    1.314831][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Fil=
ling RSB on context switch
[    1.316024][    T0] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB o=
n VMEXIT
[    1.318151][    T0] Spectre V2 : Enabling Restricted Speculation for fir=
mware calls
[    1.319414][    T0] Spectre V2 : mitigation: Enabling conditional Indire=
ct Branch Prediction Barrier
[    1.320674][    T0] Spectre V2 : User space: Mitigation: STIBP via prctl
[    1.321638][    T0] Speculative Store Bypass: Mitigation: Speculative St=
ore Bypass disabled via prctl
[    1.323179][    T0] Speculative Return Stack Overflow: Mitigation: Safe =
RET
[    1.324189][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floati=
ng point registers'
[    1.325303][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regist=
ers'
[    1.326298][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regist=
ers'
[    1.327284][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  2=
56
[    1.328107][    T0] x86/fpu: Enabled xstate features 0x7, context size i=
s 832 bytes, using 'compacted' format.
[    1.604248][    T0] Freeing SMP alternatives memory: 128K
[    1.605166][    T0] pid_max: default: 32768 minimum: 301
[    1.606440][    T0] LSM: initializing lsm=3Dlockdown,capability,landlock=
,yama,safesetid,tomoyo,apparmor,bpf,ima,evm
[    1.608771][    T0] landlock: Up and running.
[    1.609554][    T0] Yama: becoming mindful.
[    1.610776][    T0] TOMOYO Linux initialized
[    1.612635][    T0] AppArmor: AppArmor initialized
[    1.616080][    T0] LSM support for eBPF active
[    1.621951][    T0] Dentry cache hash table entries: 1048576 (order: 11,=
 8388608 bytes, vmalloc hugepage)
[    1.625424][    T0] Inode-cache hash table entries: 524288 (order: 10, 4=
194304 bytes, vmalloc hugepage)
[    1.627339][    T0] Mount-cache hash table entries: 16384 (order: 5, 131=
072 bytes, vmalloc)
[    1.628497][    T0] Mountpoint-cache hash table entries: 16384 (order: 5=
, 131072 bytes, vmalloc)
[    1.634212][    T0] Running RCU synchronous self tests
[    1.635020][    T0] Running RCU synchronous self tests
[    1.757500][    T1] smpboot: CPU0: AMD EPYC 7B13 (family: 0x19, model: 0=
x1, stepping: 0x0)
[    1.758098][    T1] Running RCU Tasks wait API self tests
[    1.858617][    T1] Running RCU Tasks Trace wait API self tests
[    1.859754][    T1] Performance Events: PMU not available due to virtual=
ization, using software events only.
[    1.869763][    T1] signal: max sigframe size: 1776
[    1.871320][    T1] rcu: Hierarchical SRCU implementation.
[    1.872132][    T1] rcu: 	Max phase no-delay instances is 1000.
[    1.874159][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[    1.878328][   T15] Callback from call_rcu_tasks_trace() invoked.
[    1.935530][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
[    1.937523][    T1] smp: Bringing up secondary CPUs ...
[    1.950450][    T1] smpboot: x86: Booting SMP configuration:
[    1.951284][    T1] .... node  #0, CPUs:      #1
[    1.951629][   T22] ------------[ cut here ]------------
[    1.951629][   T22] workqueue: work disable count underflowed
[    1.951629][   T22] WARNING: CPU: 1 PID: 22 at kernel/workqueue.c:4317 e=
nable_work+0x34d/0x360
[    1.951629][   T22] Modules linked in:
[    1.951832][   T22] CPU: 1 UID: 0 PID: 22 Comm: cpuhp/1 Not tainted 6.13=
.0-rc6-syzkaller-g9d89551994a4-dirty #0
[    1.953189][   T22] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[    1.954559][   T22] RIP: 0010:enable_work+0x34d/0x360
[    1.955294][   T22] Code: d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 08 3f 88 0=
a e8 18 82 37 00 c6 05 f9 ac 9b 0e 01 90 48 c7 c7 a0 d7 09 8c e8 d4 25 f8 f=
f 90 <0f> 0b 90 90 e9 56 ff ff ff e8 b5 c7 60 0a 0f 1f 44 00 00 90 90 90
[    1.957894][   T22] RSP: 0018:ffffc900001c7bc0 EFLAGS: 00010046
[    1.958098][   T22] RAX: caa1100063be3a00 RBX: 0000000000000000 RCX: fff=
f88801d2e3c00
[    1.958098][   T22] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    1.958098][   T22] RBP: ffffc900001c7c88 R08: ffffffff81602a82 R09: 1ff=
ffffff1cfa210
[    1.958098][   T22] R10: dffffc0000000000 R11: fffffbfff1cfa211 R12: 1ff=
ff92000038f7c
[    1.958098][   T22] R13: 1ffff92000038f84 R14: 001fffffffc00001 R15: fff=
f8880b8738770
[    1.958098][   T22] FS:  0000000000000000(0000) GS:ffff8880b8700000(0000=
) knlGS:0000000000000000
[    1.958098][   T22] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.958098][   T22] CR2: 0000000000000000 CR3: 000000000e736000 CR4: 000=
0000000350ef0
[    1.958098][   T22] Call Trace:
[    1.958098][   T22]  <TASK>
[    1.958098][   T22]  ? __warn+0x165/0x4d0
[    1.958098][   T22]  ? enable_work+0x34d/0x360
[    1.958098][   T22]  ? report_bug+0x2b3/0x500
[    1.958098][   T22]  ? enable_work+0x34d/0x360
[    1.958098][   T22]  ? handle_bug+0x60/0x90
[    1.958098][   T22]  ? exc_invalid_op+0x1a/0x50
[    1.958098][   T22]  ? asm_exc_invalid_op+0x1a/0x20
[    1.958098][   T22]  ? __warn_printk+0x292/0x360
[    1.958098][   T22]  ? enable_work+0x34d/0x360
[    1.958098][   T22]  ? __pfx_enable_work+0x10/0x10
[    1.958098][   T22]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.958098][   T22]  ? __pfx_vmstat_cpu_online+0x10/0x10
[    1.958098][   T22]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.958098][   T22]  ? rcu_is_watching+0x15/0xb0
[    1.958098][   T22]  vmstat_cpu_online+0xbb/0xe0
[    1.958098][   T22]  ? __pfx_vmstat_cpu_online+0x10/0x10
[    1.958098][   T22]  cpuhp_invoke_callback+0x48f/0x830
[    1.958098][   T22]  ? __pfx_vmstat_cpu_online+0x10/0x10
[    1.958098][   T22]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.958098][   T22]  cpuhp_thread_fun+0x41c/0x810
[    1.958098][   T22]  ? cpuhp_thread_fun+0x130/0x810
[    1.958098][   T22]  ? __pfx_cpuhp_thread_fun+0x10/0x10
[    1.958098][   T22]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.958098][   T22]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[    1.958098][   T22]  ? __pfx_cpuhp_thread_fun+0x10/0x10
[    1.958098][   T22]  smpboot_thread_fn+0x546/0xa30
[    1.958098][   T22]  ? smpboot_thread_fn+0x4e/0xa30
[    1.958098][   T22]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    1.958098][   T22]  kthread+0x2f2/0x390
[    1.958098][   T22]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    1.958098][   T22]  ? __pfx_kthread+0x10/0x10
[    1.958098][   T22]  ret_from_fork+0x4d/0x80
[    1.958098][   T22]  ? __pfx_kthread+0x10/0x10
[    1.958098][   T22]  ret_from_fork_asm+0x1a/0x30
[    1.958098][   T22]  </TASK>
[    1.958098][   T22] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    1.958098][   T22] CPU: 1 UID: 0 PID: 22 Comm: cpuhp/1 Not tainted 6.13=
.0-rc6-syzkaller-g9d89551994a4-dirty #0
[    1.958098][   T22] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[    1.958098][   T22] Call Trace:
[    1.958098][   T22]  <TASK>
[    1.958098][   T22]  dump_stack_lvl+0x241/0x360
[    1.958098][   T22]  ? __pfx_dump_stack_lvl+0x10/0x10
[    1.958098][   T22]  ? __pfx__printk+0x10/0x10
[    1.958098][   T22]  ? _printk+0xd5/0x120
[    1.958098][   T22]  ? __init_begin+0x41000/0x41000
[    1.958098][   T22]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.958098][   T22]  ? vscnprintf+0x5d/0x90
[    1.958098][   T22]  panic+0x349/0x880
[    1.958098][   T22]  ? __warn+0x174/0x4d0
[    1.958098][   T22]  ? __pfx_panic+0x10/0x10
[    1.958098][   T22]  ? ret_from_fork_asm+0x1a/0x30
[    1.958098][   T22]  __warn+0x344/0x4d0
[    1.958098][   T22]  ? enable_work+0x34d/0x360
[    1.958098][   T22]  report_bug+0x2b3/0x500
[    1.958098][   T22]  ? enable_work+0x34d/0x360
[    1.958098][   T22]  handle_bug+0x60/0x90
[    1.958098][   T22]  exc_invalid_op+0x1a/0x50
[    1.958098][   T22]  asm_exc_invalid_op+0x1a/0x20
[    1.958098][   T22] RIP: 0010:enable_work+0x34d/0x360
[    1.958098][   T22] Code: d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 08 3f 88 0=
a e8 18 82 37 00 c6 05 f9 ac 9b 0e 01 90 48 c7 c7 a0 d7 09 8c e8 d4 25 f8 f=
f 90 <0f> 0b 90 90 e9 56 ff ff ff e8 b5 c7 60 0a 0f 1f 44 00 00 90 90 90
[    1.958098][   T22] RSP: 0018:ffffc900001c7bc0 EFLAGS: 00010046
[    1.958098][   T22] RAX: caa1100063be3a00 RBX: 0000000000000000 RCX: fff=
f88801d2e3c00
[    1.958098][   T22] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    1.958098][   T22] RBP: ffffc900001c7c88 R08: ffffffff81602a82 R09: 1ff=
ffffff1cfa210
[    1.958098][   T22] R10: dffffc0000000000 R11: fffffbfff1cfa211 R12: 1ff=
ff92000038f7c
[    1.958098][   T22] R13: 1ffff92000038f84 R14: 001fffffffc00001 R15: fff=
f8880b8738770
[    1.958098][   T22]  ? __warn_printk+0x292/0x360
[    1.958098][   T22]  ? __pfx_enable_work+0x10/0x10
[    1.958098][   T22]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.958098][   T22]  ? __pfx_vmstat_cpu_online+0x10/0x10
[    1.958098][   T22]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.958098][   T22]  ? rcu_is_watching+0x15/0xb0
[    1.958098][   T22]  vmstat_cpu_online+0xbb/0xe0
[    1.958098][   T22]  ? __pfx_vmstat_cpu_online+0x10/0x10
[    1.958098][   T22]  cpuhp_invoke_callback+0x48f/0x830
[    1.958098][   T22]  ? __pfx_vmstat_cpu_online+0x10/0x10
[    1.958098][   T22]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.958098][   T22]  cpuhp_thread_fun+0x41c/0x810
[    1.958098][   T22]  ? cpuhp_thread_fun+0x130/0x810
[    1.958098][   T22]  ? __pfx_cpuhp_thread_fun+0x10/0x10
[    1.958098][   T22]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.958098][   T22]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[    1.958098][   T22]  ? __pfx_cpuhp_thread_fun+0x10/0x10
[    1.958098][   T22]  smpboot_thread_fn+0x546/0xa30
[    1.958098][   T22]  ? smpboot_thread_fn+0x4e/0xa30
[    1.958098][   T22]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    1.958098][   T22]  kthread+0x2f2/0x390
[    1.958098][   T22]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    1.958098][   T22]  ? __pfx_kthread+0x10/0x10
[    1.958098][   T22]  ret_from_fork+0x4d/0x80
[    1.958098][   T22]  ? __pfx_kthread+0x10/0x10
[    1.958098][   T22]  ret_from_fork_asm+0x1a/0x30
[    1.958098][   T22]  </TASK>
[    1.958098][   T22] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.7'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1119513314=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 1432fc845
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D1432fc84530255f6208c5719be796918244fa9d3 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241218-130448'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"1432fc84530255f6208c5719be79691824=
4fa9d3\"
/usr/bin/ld: /tmp/ccsfxsCp.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D139fd6f8580000


Tested on:

commit:         9d895519 Linux 6.13-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4ef22c4fce5135b=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3De9b1ff41aa6a7ebf9=
640
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D12c039c45800=
00


