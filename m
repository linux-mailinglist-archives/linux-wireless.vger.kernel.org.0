Return-Path: <linux-wireless+bounces-14851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7549BA746
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 18:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67ACC2819B3
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813091422DD;
	Sun,  3 Nov 2024 17:45:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D870817
	for <linux-wireless@vger.kernel.org>; Sun,  3 Nov 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730655932; cv=none; b=pQTSid3zPNo5zfS15q2rEXa7oeWc1pBbspZqj2px4huxSF2ao/3QI8u4JMXv+LZn0XzfZTTMKNpV/3QfAY+cvpyA5KZ1s+0+iFsPdAERm7Qa+47NlFZifKYxvZvMC+lswO+9xENzIAqTsLBUctivPbD412mwCI+txUC0Qv4yzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730655932; c=relaxed/simple;
	bh=bNHjq4hqEeUwpZW6WB2K4s4lAHIZ2hdxg/z5487B9po=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bR+JRCwfQL0n1UesO1j1m6soZfsrT3SqcmHXNBqjZwcCnyVp9Kw7jX01pp6faFl7MPBs/pQ7WXaqOQZmI81ihnXMKLa7qfgdcE+w/k3xoHW5P0a1yI7l6RfI+UC/llF4avjyp6aGr6unhwQBGvOiJUC+tDeBgtWHOuI2jWhE260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83acaa1f819so364726339f.3
        for <linux-wireless@vger.kernel.org>; Sun, 03 Nov 2024 09:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730655930; x=1731260730;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggPpEWZ5w7hyjg6y386Je0Mz/Rmt1xeaQKikWb+y5Cg=;
        b=k7UA9aJd0BccMTgXVbvnUBgeI23yi9HYccCE5PK1uqK5dssgPUGYof2HIlzhdNk/J+
         Wv9TFXps4kwkUltvLWb9kKnGUdRKsjk34+9jnCKDviTqoUFHZh4aO4PtzLXPMMvbXkDf
         Va5SUlBOByHLpHWeUVpTXXdHqjdK1oXGI1LcU96TExEtWBCv2kIiFbyi+VzMuJ1DlGzp
         FUX7aY5jBd4bhXrhT8s6mU+JJDfIDpok7bpy73tKybH7Z7GNzRwgHDLVHzHBMYlJpx5g
         fj4X7jZ5uBaYOG1NcxSq2s5gwnBnpj888qEdclu8A0ToDAehIqXUGG+/1zpKeotF+b64
         7xEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6ik3xMlvW0cyyzKk9Q7EaJtInoO4pbrx6JQV7qUjNR8Q+zXRlsrFI8ttaz26afu29dJfnrKIjX0sTkEf3Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmig1ZHXFXR5uTrimAtqrdL4VLulj6EMZG6QylhU6QDXWS44N
	kZ4TS1UnEpAfTmh0Ve+T8drgY0okSk05OaoWe/x3hbeNzXQeVvSPdS4oWhCU5NrER3rwdsp7c4e
	AVj7g5G/ZS8jpVMIEfgeWpYbOkmE4ZsL3pAt3ILyr/sCao67nLfW+2Jc=
X-Google-Smtp-Source: AGHT+IHFsmLZ4dyVXuYuMYTNkysQAQk1WYpJXMQsqqmy+vFQygvQCZb+Tb5mjlmfmmcS/+1pLEfE9NYSobPczvb9iySW8b2kRuKG
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4e:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a4ed2aff10mr280972875ab.12.1730655929918; Sun, 03 Nov 2024
 09:45:29 -0800 (PST)
Date: Sun, 03 Nov 2024 09:45:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727b6b9.050a0220.3c8d68.0a7c.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in default_idle
From: syzbot <syzbot+36755e283802b29119ba@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1e939a21eb1 Merge tag 'cgroup-for-6.12-rc5-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e7e540580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=36755e283802b29119ba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c1e939a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f1b9c52b9e0/vmlinux-c1e939a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f31f28c172e/bzImage-c1e939a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+36755e283802b29119ba@syzkaller.appspotmail.com

Oct 30 17:43:36 syzkaller daemon.err dhcpcd[5660]: libudev: received NULL device
Oct 30 17:43:36 syzkaller daemon.err dhcpcd[5660]: libudev: received NULL device
Oct 30 17:43:36 syzkaller daemon.err dhcpcd[5660]: libudev: received NULL device
Oct 30 17:43:3[  261.176510][    C3] ------------[ cut here ]------------
6 syzkaller daem[  261.180206][    C3] WARNING: CPU: 3 PID: 0 at net/mac80211/tx.c:5038 __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5038 [inline]
6 syzkaller daem[  261.180206][    C3] WARNING: CPU: 3 PID: 0 at net/mac80211/tx.c:5038 __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5033 [inline]
6 syzkaller daem[  261.180206][    C3] WARNING: CPU: 3 PID: 0 at net/mac80211/tx.c:5038 __ieee80211_beacon_get+0x14ac/0x16b0 net/mac80211/tx.c:5467
on.err dhcpcd[5660]: libudev: re[  261.183587][    C3] Modules linked in:
ceived NULL devi[  261.183630][    C3] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
ce
Oct 30 17:43[  261.183675][    C3] Code: 00 89 df 44 89 e6 e8 43 79 f2 f6 44 38 e3 72 a1 e8 19 78 f2 f6 48 89 ef e8 d1 42 49 f7 31 ed e9 9c fe ff ff e8 05 78 f2 f6 90 <0f> 0b 90 e9 86 f6 ff ff 48 89 c6 48 c7 c7 20 6d 2d 90 48 89 04 24
:36 syzkaller da[  261.183695][    C3] RSP: 0018:ffffc90000908b88 EFLAGS: 00010246
emon.err dhcpcd[[  261.207866][    C3] RDX: ffff88801dab2440 RSI: ffffffff8a9b047b RDI: 0000000000000001
5660]: libudev: [  261.210356][    C3] RBP: ffffc90000908c38 R08: 0000000000000001 R09: 0000000000000000
Oct 30 17:43:36 [  261.213020][    C3] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888027df4c00
syzkaller daemon[  261.217781][    C3] FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
.err dhcpcd[5660[  261.221066][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
]: libudev: rece[  261.223464][    C3] CR2: 000055792776b028 CR3: 0000000032186000 CR4: 0000000000352ef0
ived NULL device[  261.223475][    C3] DR0: 0000000000000000 DR1: 000000000000000a DR2: 0000000000000000

Oct 30 17:43:3[  261.223490][    C3] Call Trace:
6 syzkaller daem[  261.223495][    C3]  <IRQ>
on.err dhcpcd[56[  261.223536][    C3]  ? __report_bug lib/bug.c:199 [inline]
on.err dhcpcd[56[  261.223536][    C3]  ? report_bug+0x3c0/0x580 lib/bug.c:219
60]: libudev: re[  261.223564][    C3]  ? exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:309
ceived NULL devi[  261.223574][    C3]  ? asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
ce
Oct 30 17:43[  261.223606][    C3]  ? __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5038 [inline]
Oct 30 17:43[  261.223606][    C3]  ? __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5033 [inline]
Oct 30 17:43[  261.223606][    C3]  ? __ieee80211_beacon_get+0x14ab/0x16b0 net/mac80211/tx.c:5467
:36 syzkaller da[  261.248479][    C3]  ? __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5038 [inline]
:36 syzkaller da[  261.248479][    C3]  ? __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5033 [inline]
:36 syzkaller da[  261.248479][    C3]  ? __ieee80211_beacon_get+0x14ac/0x16b0 net/mac80211/tx.c:5467
emon.err dhcpcd[[  261.248552][    C3]  ieee80211_beacon_get_tim+0xa7/0x280 net/mac80211/tx.c:5594
5660]: libudev: [  261.257020][    C3]  ieee80211_beacon_get include/net/mac80211.h:5607 [inline]
5660]: libudev: [  261.257020][    C3]  mac80211_hwsim_beacon_tx+0x4ea/0xa00 drivers/net/wireless/virtual/mac80211_hwsim.c:2311
received NULL de[  261.259403][    C3]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
received NULL de[  261.259403][    C3]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
vice
Oct 30 17:[  261.261143][    C3]  ? trace_lock_acquire+0x14a/0x1d0 include/trace/events/lock.h:24
43:36 syzkaller [  261.261177][    C3]  ? __pfx_mac80211_hwsim_beacon_tx+0x10/0x10 drivers/net/wireless/virtual/mac80211_hwsim.c:2254
daemon.err dhcpc[  261.268131][    C3]  ? __pfx_mac80211_hwsim_beacon+0x10/0x10 drivers/net/wireless/virtual/mac80211_hwsim.c:3161
d[5660]: libudev[  261.270390][    C3]  ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 net/mac80211/util.c:810
: received NULL [  261.273431][    C3]  mac80211_hwsim_beacon+0x105/0x200 drivers/net/wireless/virtual/mac80211_hwsim.c:2345
device
Oct 30 1[  261.273508][    C3]  ? __pfx___hrtimer_run_queues+0x10/0x10 kernel/time/hrtimer.c:650
7:43:36 syzkaller daemon.err dhc[  261.279142][    C3]  ? ktime_get_update_offsets_now+0x201/0x310 kernel/time/timekeeping.c:2465
pcd[5660]: libud[  261.281860][    C3]  hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
ev: received NUL[  261.281907][    C3]  ? __pfx_handle_softirqs+0x10/0x10 include/trace/events/irq.h:142
L device
Oct 30[  261.288599][    C3]  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
Oct 30[  261.288599][    C3]  sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 17:43:36 syzkal[  261.291551][    C3]  <TASK>
ler daemon.err d[  261.292990][    C3]  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
hcpcd[5660]: lib[  261.295430][    C3] RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
hcpcd[5660]: lib[  261.295430][    C3] RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
hcpcd[5660]: lib[  261.295430][    C3] RIP: 0010:default_idle+0xf/0x20 arch/x86/kernel/process.c:743
udev: received N[  261.302680][    C3] RSP: 0018:ffffc900001a7e08 EFLAGS: 00000202
ULL device
Oct [  261.308915][    C3] RBP: ffffed1003b56488 R08: 0000000000000001 R09: ffffed100d527025
30 17:43:36 syzk[  261.311500][    C3] R10: ffff88806a93812b R11: 0000000000000000 R12: 0000000000000003
aller daemon.err[  261.314814][    C3] R13: ffff88801dab2440 R14: ffffffff905f5208 R15: 0000000000000000
 dhcpcd[5660]: l[  261.314855][    C3]  default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
ibudev: received[  261.314883][    C3]  ? __pfx_do_idle+0x10/0x10 kernel/sched/idle.c:82
 NULL device
Oc[  261.314915][    C3]  start_secondary+0x222/0x2b0 arch/x86/kernel/smpboot.c:314
t 30 17:43:36 sy[  261.326571][    C3]  ? __pfx_start_secondary+0x10/0x10 arch/x86/include/asm/smp.h:147
zkall[e r  2d6ae1m.o3n2.8e441][    C3]  common_startup_64+0x13e/0x148


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

