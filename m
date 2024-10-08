Return-Path: <linux-wireless+bounces-13720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69C99436E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE801F2116E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 09:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9761D4141;
	Tue,  8 Oct 2024 09:00:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B81D2B1B
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378030; cv=none; b=tbJ1NzdSIfzHuphZrFhNhraBXmGLMSezStojuJqIK/1Lolkc0FAAOMgbrrxW8DKUZkT/GPLSc6qE40UGBj4hDJDHyc6ifgMWlzut77jLFdbi/LD8lZm8SefWQ+5ULC+wSFwyqCCydNnURpBcz3m9+7ASwC0iLRh7eWeyDm/xXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378030; c=relaxed/simple;
	bh=uHR1R80Adv/3OX5IIqsonPHDhsdT1S7T6yIqAFdBMl8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d9Pjh15JaXeqLQv1sRkiJuxzJMoM2Wlrn8LUxfJOZUwVhDJm8V+Xs+tX9E6L9/FeXljgrMRrAXXLMpRf3w6400hnBxQtLHFqh2Cep5QJJV0c1gS451tc0BjbUlAYZRi2eevsYxu3M9wLeC40+S5V1V/Nloo1M4NsU1M2Nk/TqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1a969fabfso66100275ab.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2024 02:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378027; x=1728982827;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j94wRKw6nS2yrDFlGU+jZw1Tw/r3v8/FcnZfF7tvw/A=;
        b=uhbYXuL0jlCOxqhuEKYAN7NaXNBBwhWp9GMbcTG/H1uH61g4rnhdWi8gEkLDTmgX7P
         MkWaCYGKhYNsExHsYjKVnbEeQCf6i0LZ+4MV6QRksWtSjNy1X/4j9zCoO+6Y1AfR/cUJ
         Rcd+KsMjM5IDaBpIvLW7KybHVVi3+AJ7tUOdO+y9hmEC+LgoYMYpkbgjbdd5A+GG1XkF
         kHFoVyL5915Po/sAjHGQeeeSVXTYqIPO4pvhectUn0/mfz4/bGmeUDnn/eTZTaEFMFEa
         BoANU4Tv3fbZpcUgXWHIG8sIwWB3TWMHkk2gM3FasfdZnGIS2hvsbGK3BOAKLsZiIH/8
         Griw==
X-Forwarded-Encrypted: i=1; AJvYcCUQMj59IlK8yVP8yISjEX/JyN3auMggTd4CW1a9laO7vpLopMYb8099HQlTFNxpIUedru9L94ta82vZoUz0Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGGBwheyx+gGDUodv89IHPbA1X7ePkeHTAoXnqs+ufE/NcKJd
	8Ux7iggg+CK5xYvAKQS6H+fr8laL9/nQpHapTBbAvqvUM3usPRjvnc2HPNAbn1F1OckntWOHtsW
	5adbvsXQvbVZqSwDo176zFsVTAkoio4l6t2OKxQSPNOegtxpXhCea69Y=
X-Google-Smtp-Source: AGHT+IEMi3ia6FJ6/yZhkhWx5b/zE0neag648rPPZpWk7fdw+owYWsZZSCv8yj75cuLjdGzrri77lTm1veH2N1XWoVEycsXMxy4u
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2189:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a375bd2324mr137101675ab.21.1728378027047; Tue, 08 Oct 2024
 02:00:27 -0700 (PDT)
Date: Tue, 08 Oct 2024 02:00:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704f4ab.050a0220.1e4d62.0089.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in restore_regulatory_settings (3)
From: syzbot <syzbot+e10709ac3c44f3d4e800@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    3840cbe24cf0 sched: psi: fix bogus pressure spikes from ag.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D169ff527980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df95955e3f7b5790=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3De10709ac3c44f3d4e=
800
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14310d8058000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D119ff527980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7fe=
b34a89c2a/non_bootable_disk-3840cbe2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/55888d19e055/vmlinux-=
3840cbe2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6b8ca10a019/bzI=
mage-3840cbe2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+e10709ac3c44f3d4e800@syzkaller.appspotmail.com

------------[ cut here ]------------
Unexpected user alpha2: =EF=BF=BD=EF=BF=BD
WARNING: CPU: 0 PID: 1338 at net/wireless/reg.c:442 is_user_regdom_saved ne=
t/wireless/reg.c:440 [inline]
WARNING: CPU: 0 PID: 1338 at net/wireless/reg.c:442 restore_alpha2 net/wire=
less/reg.c:3424 [inline]
WARNING: CPU: 0 PID: 1338 at net/wireless/reg.c:442 restore_regulatory_sett=
ings+0x3c0/0x1e50 net/wireless/reg.c:3516
Modules linked in:
CPU: 0 UID: 0 PID: 1338 Comm: kworker/0:3 Not tainted 6.12.0-rc1-syzkaller-=
00114-g3840cbe24cf0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
Workqueue: events_power_efficient crda_timeout_work
RIP: 0010:is_user_regdom_saved net/wireless/reg.c:440 [inline]
RIP: 0010:restore_alpha2 net/wireless/reg.c:3424 [inline]
RIP: 0010:restore_regulatory_settings+0x3c0/0x1e50 net/wireless/reg.c:3516
Code: 88 44 24 1c e9 95 01 00 00 e8 ac 4f 84 f6 90 0f b6 35 34 5c 6e 0f 0f =
b6 15 4d 5c 6e 0f 48 c7 c7 00 e6 28 8d e8 31 44 45 f6 90 <0f> 0b 90 90 4c 8=
b 35 d5 e0 df 04 4d 85 f6 0f 84 85 00 00 00 4c 89
RSP: 0000:ffffc90002cdfaa0 EFLAGS: 00010246
RAX: 75bf7dfc993e6800 RBX: 0000000000000000 RCX: ffff8880003c4880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002cdfba8 R08: ffffffff8155daa2 R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: ffffffff8ff07980
R13: ffffffff815e9c86 R14: ffffc90002cdfb40 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd4b8ff8760 CR3: 0000000011d4a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 crda_timeout_work+0x27/0x50 net/wireless/reg.c:542
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

