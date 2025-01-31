Return-Path: <linux-wireless+bounces-18258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04315A2455E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 23:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693021889856
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 22:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FC71A8F9E;
	Fri, 31 Jan 2025 22:50:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606911A4F22
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363822; cv=none; b=Ts5dbV6Gl9C2baAFRN1j7K2UsE27FeE6TZ43QjiHHsg2Fb3OLn08Zg0SeeY4sm0iKRQeinS6AMl4MQ33TyjtPURN3TSF1xeZ1kXsv7jNIRCEReAMSnaQp8WgAJ0XwINPSavctTqpYaIYp4DWsBZvgnKTLCmtdCHHpgZ2HLHeF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363822; c=relaxed/simple;
	bh=aeAIsLBBZ8s5g2/D072rZCgg2rjpiehI/S1+NknrUS4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PMQy7S2uAE44O4jDyTLaDypL+QecedA2c4j+Z89iD84/OHdfj332zfl5+pcddrEDH4KYFt4ykbyc1vi/pq1Zd9DkqBa5Wt8WMglT16MwuqSi6itpzNIqE+q1ku/MBij1ZVeg1QmZl1LS8AxoegD8cf2XjO/gpT4PjmV924YjqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so19215465ab.0
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 14:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738363819; x=1738968619;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsqHjDjVi6C1YGxz/YdXtxrZCgAyQICEPHDU7pf+lds=;
        b=IMXMF2uzI0DvocQV+Iwdf2fBx56yD8ZcXIEckScb1AcO4luO69mL7SEpgI4r5u34Qp
         jlsyE2APi1y6Wp1/lSRedHum0Q6Bwb50bTgRtnzjE0JxSdV5vzm7GYyIyyO9DWrBvDcp
         caIkqdVK22zs9fiGndTSUEE6LmK1hhiT6d9UnAW8Dsjyf27Rl1L1VyA1RLsfpAyyeu5W
         C5gAW1moI5iqQv3SHvnSM6ASCM378G3nyyS6z5Lq0tLTNQgirNWNg25a6JHmuvak+uSR
         meLNN0ieQO+3OSUoE0spNfpVwUjTgpzrA19GSjhU45Ll/lwl0wBvsqkAIhQM/8ollk0e
         CF5A==
X-Forwarded-Encrypted: i=1; AJvYcCUTiPhRsIhW0BU5HoaLXl49B0An864hXGU6y+YFpSXsvu3rbYTFHmgC35GYl0SCWWDJpm+CFNS0gLswVlf0Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbRMTIqF1GicqGnOqk+5h7pXiepy4rApMcIEKb8Of7y0ijpyKX
	l3uhYmJL4pf08j1ZFbAM9DKHK8EegvcUI3Y62k2xV7V5gFTBO+k7X74NPgU8VQKzMHJGy4YqS37
	u+1pCgrSWTd/qiAkdX32i8Azcz8JbvpF8mwwykFkJpgKt/JXukO1k/b8=
X-Google-Smtp-Source: AGHT+IHKEkpHD4WJFMxu/E9qd/wERDt9ZnPEBM88yjdbiJ2W4dXkvf/4/gvgBidOoam+irlu/FdZ007ELWBno5V5mZ/khOWYg0LF
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338a:b0:3cf:fbe8:aa1a with SMTP id
 e9e14a558f8ab-3cffe3a6878mr121573425ab.7.1738363819424; Fri, 31 Jan 2025
 14:50:19 -0800 (PST)
Date: Fri, 31 Jan 2025 14:50:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679d53ab.050a0220.163cdc.0012.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ADDR
From: syzbot <syzbot+652bceddc8ff90c594ad@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    805ba04cb7cc Merge tag 'mips_6.14' of git://git.kernel.org.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D102805f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2ae8afe424ee551=
e
dashboard link: https://syzkaller.appspot.com/bug?extid=3D652bceddc8ff90c59=
4ad
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7fe=
b34a89c2a/non_bootable_disk-805ba04c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9b9a1354470/vmlinux-=
805ba04c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c77f51f864a/bzI=
mage-805ba04c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+652bceddc8ff90c594ad@syzkaller.appspotmail.com

Jan 27 22:47:14 syzkaller kern.notice kernel: [   71.133063][   T39] audit:=
 type=3D1400 audit(1738018034.313:3483): avc:  denied  { read } for  pid=3D=
5336 comm=3D"syslogd" name=3D"log" dev=3D"sda1" ino=3D1915 scontext=3Dsyste=
m_u:system_r:syslogd_t tcontext=3Dsystem_u:object_r:var_t tclas[   71.51912=
8][    C2] ------------[ cut here ]------------
s=3D[   71.521211][    C2] WARNING: CPU: 2 PID: 1418 at net/mac80211/tx.c:5=
040 __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5040 [inline]
s=3D[   71.521211][    C2] WARNING: CPU: 2 PID: 1418 at net/mac80211/tx.c:5=
040 __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5035 [inline]
s=3D[   71.521211][    C2] WARNING: CPU: 2 PID: 1418 at net/mac80211/tx.c:5=
040 __ieee80211_beacon_get+0x14ac/0x16b0 net/mac80211/tx.c:5469

Jan 27 22:47:14 [   71.555288][    C2] FS:  0000000000000000(0000) GS:ffff8=
8806a800000(0000) knlGS:0000000000000000
syzkaller kern.n[   71.558416][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033
otice kernel: [ [   71.560778][    C2] CR2: 00007f188c918f98 CR3: 000000000=
df80000 CR4: 0000000000352ef0
  71.183083][   [   71.563537][    C2] DR0: 0000000000000000 DR1: 000000000=
0000000 DR2: 0000000000000000
T39] audit: type[   71.566318][    C2] DR3: 0000000000000000 DR6: 00000000f=
ffe0ff0 DR7: 0000000000000400
=3D1400 audit(1738[   71.569117][    C2] Call Trace:
018034.323:3484)[   71.570531][    C2]  <IRQ>
: avc:  denied  [   71.571844][    C2]  ? __warn+0xea/0x3c0 kernel/panic.c:=
746
{ create } for  [   71.573494][    C2]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5040 [inline]
{ create } for  [   71.573494][    C2]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5035 [inline]
{ create } for  [   71.573494][    C2]  ? __ieee80211_beacon_get+0x14ac/0x1=
6b0 net/mac80211/tx.c:5469
pid=3D7155 comm=3D"s[   71.575627][    C2]  ? __report_bug lib/bug.c:199 [i=
nline]
pid=3D7155 comm=3D"s[   71.575627][    C2]  ? report_bug+0x3c0/0x580 lib/bu=
g.c:219
yz.0.427" sconte[   71.577454][    C2]  ? handle_bug+0x54/0xa0 arch/x86/ker=
nel/traps.c:285
xt=3Droot:sysadm_r[   71.579210][    C2]  ? exc_invalid_op+0x17/0x50 arch/x=
86/kernel/traps.c:309
:sysadm_t tconte[   71.581290][    C2]  ? asm_exc_invalid_op+0x1a/0x20 arch=
/x86/include/asm/idtentry.h:621
xt=3Droot:sysadm_r[   71.583223][    C2]  ? __ieee80211_beacon_update_cntdw=
n net/mac80211/tx.c:5040 [inline]
xt=3Droot:sysadm_r[   71.583223][    C2]  ? __ieee80211_beacon_get+0xb32/0x=
16b0 net/mac80211/tx.c:5469
:sysadm_t tclass[   71.585319][    C2]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5040 [inline]
:sysadm_t tclass[   71.585319][    C2]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5035 [inline]
:sysadm_t tclass[   71.585319][    C2]  ? __ieee80211_beacon_get+0x14ab/0x1=
6b0 net/mac80211/tx.c:5469
=3Dnetlink_netfilt[   71.587451][    C2]  ? __ieee80211_beacon_update_cntdw=
n net/mac80211/tx.c:5040 [inline]
=3Dnetlink_netfilt[   71.587451][    C2]  ? __ieee80211_beacon_update_cntdw=
n net/mac80211/tx.c:5035 [inline]
=3Dnetlink_netfilt[   71.587451][    C2]  ? __ieee80211_beacon_get+0x14ac/0=
x16b0 net/mac80211/tx.c:5469
er_socket permis[   71.589588][    C2]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5040 [inline]
er_socket permis[   71.589588][    C2]  ? __ieee80211_beacon_update_cntdwn =
net/mac80211/tx.c:5035 [inline]
er_socket permis[   71.589588][    C2]  ? __ieee80211_beacon_get+0x14ab/0x1=
6b0 net/mac80211/tx.c:5469
si[   71.591735][    C2]  ieee80211_beacon_get_tim+0xa7/0x280 net/mac80211/=
tx.c:5596

Jan 27 22:47:14 [   71.614223][    C2]  ? __pfx___hrtimer_run_queues+0x10/0=
x10 include/trace/events/timer.h:222
syzkaller kern.n[   71.619260][    C2]  handle_softirqs+0x213/0x8f0 kernel/=
softirq.c:561
otice kernel: [ [   71.621158][    C2]  ? __pfx_handle_softirqs+0x10/0x10 i=
nclude/trace/events/irq.h:156
  71.206999][   [   71.623160][    C2]  ? rcu_lock_release include/linux/rc=
update.h:347 [inline]
  71.206999][   [   71.623160][    C2]  ? rcu_read_unlock_bh include/linux/=
rcupdate.h:917 [inline]
  71.206999][   [   71.623160][    C2]  ? __dev_queue_xmit+0x89b/0x43e0 net=
/core/dev.c:4611
T39] audit: type[   71.625157][    C2]  do_softirq kernel/softirq.c:462 [in=
line]
T39] audit: type[   71.625157][    C2]  do_softirq+0xb2/0xf0 kernel/softirq=
.c:449
=3D1400 audit(1738[   71.626849][    C2]  </IRQ>
018034.323:3485)[   71.628241][    C2]  <TASK>
: avc:  denied  [   71.629591][    C2]  __local_bh_enable_ip+0x100/0x120 ke=
rnel/softirq.c:389
{ read } for  pi[   71.631612][    C2]  ? rcu_lock_release include/linux/rc=
update.h:347 [inline]
{ read } for  pi[   71.631612][    C2]  ? rcu_read_unlock_bh include/linux/=
rcupdate.h:917 [inline]
{ read } for  pi[   71.631612][    C2]  ? __dev_queue_xmit+0x89b/0x43e0 net=
/core/dev.c:4611
d=3D5336 comm=3D"sys[   71.633591][    C2]  local_bh_enable include/linux/b=
ottom_half.h:33 [inline]
d=3D5336 comm=3D"sys[   71.633591][    C2]  rcu_read_unlock_bh include/linu=
x/rcupdate.h:919 [inline]
d=3D5336 comm=3D"sys[   71.633591][    C2]  __dev_queue_xmit+0x8b0/0x43e0 n=
et/core/dev.c:4611
logd" name=3D"log"[   71.635522][    C2]  ? __pfx___dev_queue_xmit+0x10/0x1=
0 include/linux/netdevice.h:3825
 dev=3D"sda1" ino=3D[   71.637626][    C2]  ? __pfx___lock_acquire+0x10/0x1=
0 kernel/locking/lockdep.c:4389
1915 scontext=3Dsy[   71.639638][    C2]  ? __pfx___lock_acquire+0x10/0x10 =
kernel/locking/lockdep.c:4389
stem_u:system_r:[   71.641634][    C2]  ? lock_acquire.part.0+0x11b/0x380 k=
ernel/locking/lockdep.c:5851
syslogd_t tconte[   71.643650][    C2]  ? find_held_lock+0x2d/0x110 kernel/=
locking/lockdep.c:5341
xt=3Dsystem_u:obje[   71.645540][    C2]  ? find_held_lock+0x2d/0x110 kerne=
l/locking/lockdep.c:5341
ct_r:var_t tclas[   71.647398][    C2]  ? spin_unlock_irq include/linux/spi=
nlock.h:401 [inline]
ct_r:var_t tclas[   71.647398][    C2]  ? tx+0xa8/0x190 drivers/block/aoe/a=
oenet.c:60
s=3D
Jan 27 22:47:14 [   71.658874][    C2]  ? __pfx_kthread+0x10/0x10 arch/x86/=
include/asm/bitops.h:206
syzkaller kern.n[   71.669505][    C2]  ? __pfx_kthread+0x10/0x10 arch/x86/=
include/asm/bitops.h:206
otice kernel: [ [   71.671354][    C2]  ret_from_fork_asm+0x1a/0x30 arch/x8=
6/entry/entry_64.S:244
  71.238225][   [   71.673261][    C2]  </TASK>


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

