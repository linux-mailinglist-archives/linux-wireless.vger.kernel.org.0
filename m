Return-Path: <linux-wireless+bounces-30255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59018CECBBD
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 02:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51A013007229
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720742765ED;
	Thu,  1 Jan 2026 01:20:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98260271469
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767230425; cv=none; b=YKbZSK5V1yYsZ/qSSqBnLp6TQJCiX3ubcRt3qAYIa5by4LyGfVVOYhCS9F6+usuK4atGNeJ1V4Pq45epz5X+xEnzEhNgsjigZgXmq68ELnS9C3P6YOpDJqjqJB6y43mwxnLXA2mCn7rbzM1H+lAGPBLSEQAG01Fq1lOCcIz8xcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767230425; c=relaxed/simple;
	bh=FHzOIjJhJMdPw+wxvAcFflmhHzTK3yk7O1FIiZ1ii0U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UtXIYR+2FKV1SiOvP4cXJ4wSE8g4P+U/H67e1uk18Wv3b1gyvpKpJRtTRz/Pq9N67TeJv7PjXdcPMoQhvsl+VGhj9sTogZkKQMzFWJ0a1i/rkOKSt4b6vTrk5W2eZcEkZSwME8wPTTjn4T/7cbkBkQQgr5qIq7gn0AgrjdmvFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-65b2cd67cceso19705917eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767230421; x=1767835221;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l96xM7j24Yuz+mKcTl2sjAtipIWuU27H/Z/cgCLkeLs=;
        b=ul5V2mC6tGRea5l7BO/PNShruxmCxi9V4/+DGCjYsoGkOuoijDgMFiTq2Myp/Nh6+V
         ClCXpJbB4EF2EsLjCSLOYB3QWcZgfwKYXDXSuXIRFY76PFilqZmw0I+eWreQmuq1eJFn
         Ya8qmsAbYl7UQMv4Tg6qqYAwxnJ6OhS7RH8usEBxTJDcHfzTSgETfMS/HwRsk7ilEK6b
         Ep0wVvzats2HuZE6n4Ij2NpoqhEjv95XRwSve05tav+4/kO9l0GwnWjx7LbTaQK3QJ/8
         Ca9cNsKkWz83HZFNWz7pliZ1j8Y22LeBxD9uZH7VwEb/BGwEZHp/ah4hK+JOt/1k/YW6
         mqmw==
X-Forwarded-Encrypted: i=1; AJvYcCU1tL7t/EGQr3jAc6Czip75qRgePYMf2yWevxhkskyvQBL5JgR7Wp4e087amvaQVdp/nlH6kqEmxVBJ7wr89Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3iMMpUAm9PmeR/m/lIZe0Jwv+vEt1Wt8/TCz7rV0vbV8UyLq
	uNIeThFPmQi7JbcnOwetZjdY9IP22cLF7jqTXooKQ6mcu/HogBuB1tksRvAw4xwH5ahbFzi85mV
	40Uvq4KftgA6bG4tslXYRRv9mUJ02Dr7bC1t3/iu1LgzrZsT6NNDwvRWy9DY=
X-Google-Smtp-Source: AGHT+IGo81+4AP49Jo7fSsmAkXk8EECnZ2jAXv+OHIEB+7FOktV+1w2xZAkqOawB7STHXZwGgL3MoFO8rCkKaVIZk0RBE60cf1FD
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a4:b0:65c:fd25:f43d with SMTP id
 006d021491bc7-65d0eaa182dmr17326666eaf.59.1767230421479; Wed, 31 Dec 2025
 17:20:21 -0800 (PST)
Date: Wed, 31 Dec 2025 17:20:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6955cbd5.050a0220.a1b6.032d.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in rfkill_unregister
From: syzbot <syzbot+16210d09509730207241@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c53f467229a7 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e65b92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f2b6fe1fdf1a00b
dashboard link: https://syzkaller.appspot.com/bug?extid=16210d09509730207241
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d09cbe6bb078/disk-c53f4672.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83e2a6822b1d/vmlinux-c53f4672.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9eff6dd4ff63/bzImage-c53f4672.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16210d09509730207241@syzkaller.appspotmail.com

------------[ cut here ]------------
rtmutex deadlock detected
WARNING: kernel/locking/rtmutex.c:1674 at rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1674, CPU#0: syz.7.2908/15923
Modules linked in:
CPU: 0 UID: 0 PID: 15923 Comm: syz.7.2908 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1674
Code: 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 86 00 00 00 48 89 f7 e8 a6 39 01 00 48 8d 3d af 7c 0a 04 <67> 48 0f b9 3a 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 10 b3 91 4c
RSP: 0018:ffffc90004617710 EFLAGS: 00010286
RAX: 0000000080000000 RBX: ffffc900046177a0 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8ce0bbf9 RDI: ffffffff8ede5760
RBP: ffffc900046178c0 R08: ffffffff8edb3477 R09: 1ffffffff1db668e
R10: dffffc0000000000 R11: fffffbfff1db668f R12: 1ffff920008c2ef0
R13: ffffffff8ad3d599 R14: ffffffff8eb910e0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888126cef000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056422df5abe0 CR3: 000000005929c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x666/0x6b0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:534 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:552
 rfkill_unregister+0xd1/0x230 net/rfkill/core.c:1145
 nfc_unregister_device+0x96/0x300 net/nfc/core.c:1167
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:172
 __fput+0x45b/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x694/0x22f0 kernel/exit.c:971
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1112
 get_signal+0x125d/0x1310 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x87/0x4e0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2b7/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2e7f9af749
Code: Unable to access opcode bytes at 0x7f2e7f9af71f.
RSP: 002b:00007f2e7dc0e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: 0000000000000008 RBX: 00007f2e7fc05fa0 RCX: 00007f2e7f9af749
RDX: 0000000000000002 RSI: 0000200000000500 RDI: ffffffffffffff9c
RBP: 00007f2e7fa33f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2e7fc06038 R14: 00007f2e7fc05fa0 R15: 00007fff5a2e50f8
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	41 57                	push   %r15
   b:	41 56                	push   %r14
   d:	41 55                	push   %r13
   f:	41 54                	push   %r12
  11:	53                   	push   %rbx
  12:	83 ff dd             	cmp    $0xffffffdd,%edi
  15:	0f 85 86 00 00 00    	jne    0xa1
  1b:	48 89 f7             	mov    %rsi,%rdi
  1e:	e8 a6 39 01 00       	call   0x139c9
  23:	48 8d 3d af 7c 0a 04 	lea    0x40a7caf(%rip),%rdi        # 0x40a7cd9
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4c 8d 3d 00 00 00 00 	lea    0x0(%rip),%r15        # 0x36
  36:	65 48 8b 1c 25 08 10 	mov    %gs:0xffffffff91b31008,%rbx
  3d:	b3 91
  3f:	4c                   	rex.WR


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

