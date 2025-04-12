Return-Path: <linux-wireless+bounces-21473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73169A86F44
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 22:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1592B7ABFCC
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40821CC5A;
	Sat, 12 Apr 2025 20:14:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044B214202
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744488872; cv=none; b=PN3OuatcjKAJNq9khupUEiA71ATjbrQyvHCQ4pdyjxIvZ4tSTVL9WPBdaYBVqWVl1b5FNSggKYoZuSw32omYqnF/Z9GxdlKPm+FtTVkWFo5OVhb0R3WqxQ4FL2JXvclJmT0YKfUyp4SwXol/pNkcsg5bwVvXQYMiFOcA1pK1T8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744488872; c=relaxed/simple;
	bh=JKKbL7VO9rooA4xuIjBoTuxh+OnH+T9gc8bRy3R3EJc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pw4q/UDlaFFC1z/HpIOrjMz+qZxyGa1IDf/80G2JtzhgpoTGxxC+PcHx2meLkdJ4gqHPJJLDXoU4DMNLuNbMYDm4nb8gOdbkLh11mGGvxc+UfAAlmJj1NuUyP0SxaD/mq59BsrF+8VX7MNkoQ7ex4qhMyh96Cq/30hg40tHbwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d44b221f0dso55003525ab.1
        for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 13:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744488870; x=1745093670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MU9IRXuBNYDolQSEGLfbLmlu9fRmpm7bWboFas2Hn70=;
        b=E2W5nw/Chh2wE0fB2oVbBZkYJ7tz8iWOVZ7outiW8VLwJJp+l3qcE+ulWCdgWstepC
         vOp9rKpIkys2QE4SsqCIUiUwUdVaM36G6Sc8ZnpIIA4kiSjSzXYIereC61hNCxQsG103
         mHyelANQTP1Fx8pNTEVzc52kVjIlDRglNlmTCxomor18CFDCmw3BshCOf88+aXC9lPi+
         4nILdZejaLdG9Re42KbreLNELunGjNEM3+OOG7LAAFy+Kr9bryAabz63lYe8+Voc7012
         s8ha64ZuR60Mw1NhlvR4Ig5v3lXDuGeGR4smj4D6zCNE6gd2tn60iV68wBaWNjYlksWM
         VsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBHYWjp7lCWVyc6HX9AnfP7jvKGgLdDKlOU4iNsgdOV8AHGc39q2Pkrzcu4eu6CP3jV26MNPCpjBusSMhofw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyX42bCFkSIxkr31Sf4NP5QrRZ5ZBoVVv/VfEnuQTafpWq7U+
	WjZyd/6AO82YPVaX53wiId4JSc4RtGYjpXGYH/YV+wyZiNi77Q8eAE1BjIy3FH5sqJDRWJV/wQL
	Gjm59Xjf9FGVPP9WMXkZFB0tjJiSGaSMUcmIGkaE5na71b+sUwyUA6OQ=
X-Google-Smtp-Source: AGHT+IEIjW6LLi17Uelz80KpkGy3eAZup6X2C578aCKQ81mOaqfghhvcn0twqxMSPkhABQT6RhHEuM6omaOp/t+7hxVWt6ty2QzY
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:3d0:10a6:99aa with SMTP id
 e9e14a558f8ab-3d7ec1e8ee7mr70530185ab.4.1744488870259; Sat, 12 Apr 2025
 13:14:30 -0700 (PDT)
Date: Sat, 12 Apr 2025 13:14:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fac9a6.050a0220.379d84.0016.GAE@google.com>
Subject: [syzbot] [wireless?] divide error in mac80211_hwsim_set_tsf
From: syzbot <syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1741cc04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d444e5269179368a
dashboard link: https://syzkaller.appspot.com/bug?extid=064815c6cd721082a52a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140f9070580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8909dc8a51ee/disk-0af2f6be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e216afa338a8/vmlinux-0af2f6be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d21115804e3/bzImage-0af2f6be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 1148 Comm: kworker/u8:6 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:mac80211_hwsim_set_tsf+0x139/0x170 drivers/net/wireless/virtual/mac80211_hwsim.c:1239
Code: 48 89 9d 30 3f 00 00 4c 89 b5 28 3f 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 9f cf c4 fa 45 89 ff 4c 89 e8 31 d2 <49> f7 f7 4d 29 ee 48 89 d3 48 f7 db eb a5 e8 54 40 29 fb e9 e7 fe
RSP: 0018:ffffc90003ff7ad8 EFLAGS: 00010246
RAX: 00063249cd8022f2 RBX: 00063249cd8022f3 RCX: ffffffff86f66d11
RDX: 0000000000000000 RSI: ffffffff86f66d71 RDI: 0000000000000006
RBP: ffff8880236830a0 R08: 0000000000000006 R09: 0000000000000001
R10: 00063249cd8022f3 R11: 0000000000000000 R12: 0000000000000001
R13: 00063249cd8022f2 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881249b9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7019ad56c0 CR3: 00000000336ea000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drv_set_tsf+0x223/0x590 net/mac80211/driver-ops.c:277
 ieee80211_if_parse_tsf+0x2c8/0x560 net/mac80211/debugfs_netdev.c:701
 wiphy_locked_debugfs_write_work+0xe3/0x1c0 net/wireless/debugfs.c:215
 cfg80211_wiphy_work+0x3dc/0x550 net/wireless/core.c:435
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mac80211_hwsim_set_tsf+0x139/0x170 drivers/net/wireless/virtual/mac80211_hwsim.c:1239
Code: 48 89 9d 30 3f 00 00 4c 89 b5 28 3f 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 9f cf c4 fa 45 89 ff 4c 89 e8 31 d2 <49> f7 f7 4d 29 ee 48 89 d3 48 f7 db eb a5 e8 54 40 29 fb e9 e7 fe
RSP: 0018:ffffc90003ff7ad8 EFLAGS: 00010246
RAX: 00063249cd8022f2 RBX: 00063249cd8022f3 RCX: ffffffff86f66d11
RDX: 0000000000000000 RSI: ffffffff86f66d71 RDI: 0000000000000006
RBP: ffff8880236830a0 R08: 0000000000000006 R09: 0000000000000001
R10: 00063249cd8022f3 R11: 0000000000000000 R12: 0000000000000001
R13: 00063249cd8022f2 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881249b9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7019ad56c0 CR3: 0000000034a5e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 9d 30 3f 00 00 	mov    %rbx,0x3f30(%rbp)
   7:	4c 89 b5 28 3f 00 00 	mov    %r14,0x3f28(%rbp)
   e:	5b                   	pop    %rbx
   f:	5d                   	pop    %rbp
  10:	41 5c                	pop    %r12
  12:	41 5d                	pop    %r13
  14:	41 5e                	pop    %r14
  16:	41 5f                	pop    %r15
  18:	c3                   	ret
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	e8 9f cf c4 fa       	call   0xfac4cfc1
  22:	45 89 ff             	mov    %r15d,%r15d
  25:	4c 89 e8             	mov    %r13,%rax
  28:	31 d2                	xor    %edx,%edx
* 2a:	49 f7 f7             	div    %r15 <-- trapping instruction
  2d:	4d 29 ee             	sub    %r13,%r14
  30:	48 89 d3             	mov    %rdx,%rbx
  33:	48 f7 db             	neg    %rbx
  36:	eb a5                	jmp    0xffffffdd
  38:	e8 54 40 29 fb       	call   0xfb294091
  3d:	e9                   	.byte 0xe9
  3e:	e7 fe                	out    %eax,$0xfe


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

