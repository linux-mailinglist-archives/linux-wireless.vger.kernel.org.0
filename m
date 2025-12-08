Return-Path: <linux-wireless+bounces-29584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DC7CAC4D7
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 08:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 809773007602
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 07:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B3331690D;
	Mon,  8 Dec 2025 07:19:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19426316902
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178368; cv=none; b=oH2791Afy29xlRqwYKGmZi8EGBLgLw2QmIx8hvZWGw/db9Sx1IBismN2sL7HcZVnAmVhF2wVLbkR+1QQDlnVkAyDvZEeZ27d0NpNLi9NBrW6EhYpCWqTdhoYOg3RgxdnhCMsQkQie6JbzX0uq6PXRlXg+/qJtVWMCOClsv/e7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178368; c=relaxed/simple;
	bh=jUiCi6vpMh4NMvjftik+kb4DDW/ExSQe6dnXuHXfifA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xb/0GePP2sUlOnOe3rmpZnWgWM3WKDQNtzr6vKorAi75CQKcNssqshb11+clyVYqY2h2XDEQZzQJCDdq8Xr7lbqrlc/x8k7YaPPxCjPfhWcuLzn+yQ+oXHCEC16Glk+H82AOSE8oH9oDKsjp5Gk7dzYP3RFE4xXzGqjqsekZxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7c673f5f4b6so10610819a34.1
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 23:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765178366; x=1765783166;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/X4uy5cCt6EvB7PbaeeAWQi2Cx3kHuGZ5vabxtqo5S0=;
        b=wYI2c9z99RLKCvRxMJ9Pob2cFe/6x07DxRkKSavceC3urBagduJhkIfJtcjthE6Y+S
         Jna02a8dgLDknxNvrO4A7FCJY5zcKEY4HTZ5Am+XK6+zJ2a/gn1Hz2ffGrJ7ed6pseZZ
         vdGrrblmQMQ7NmGZZn0IPLVYfxdjACaMpNFi3ImvOnRcrjRCI6KEqSvRC76/PqlgVp7R
         urSlQVyoyxKB5zLK+3we0lxXzWuuiEeP3zVm2TqVymL82IlBbUlAE0xkGOBRvItgQrP2
         mj3c65CF1JemBcH1+aLIZuMxerU8rSUHhEbAiJDsoWWsJsjKjjpTn9XCI2MOoIkJ56un
         kEpw==
X-Forwarded-Encrypted: i=1; AJvYcCVhkoNnQ6SxTCmu8hsTO2WPtf4Sb/CbQQl7b/PbAMP0wYHkfvSRUU1R0j7G9CeQ0nlZGP9whjnzd9DP5bVfTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95YZQt1kd7ReyKegbHUfI4vaRbL/qyATlCi0U9vx5AY5Z2D2c
	fTBRLNzwIInCKS9G+vjOZRcJpj7bsRv+f4gfYkw5uljBPxG1ToypoVcclGSq0F/FeS3gBLp/tH2
	PHV+I+n3HYCwugSkSgGN8jqN56RxwKamb66WbWA0bvdobOuKjf2T8uXrnDCg=
X-Google-Smtp-Source: AGHT+IGPivsQZT7CodMUGdcsXTj0cIwIzEeAz8yULlTPsyn2Nw8Var2gRHrbvHBqcRo1w+mYSwFFm+4lOujz0UXEsoRwIA5FpNWR
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:829:b0:659:9a49:8ec9 with SMTP id
 006d021491bc7-6599a97b0fcmr2683176eaf.77.1765178366254; Sun, 07 Dec 2025
 23:19:26 -0800 (PST)
Date: Sun, 07 Dec 2025 23:19:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69367bfe.a70a0220.38f243.008d.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in rfkill_global_led_trigger_worker
From: syzbot <syzbot+3746f1566ec44b3eef97@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a619fe35ab41 Merge tag 'v6.19-p1' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15436ab4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbe15908ba3bc627
dashboard link: https://syzkaller.appspot.com/bug?extid=3746f1566ec44b3eef97
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a17853f8cb2f/disk-a619fe35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6be5ad373796/vmlinux-a619fe35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb35e3d02a3b/bzImage-a619fe35.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3746f1566ec44b3eef97@syzkaller.appspotmail.com

------------[ cut here ]------------
rtmutex deadlock detected
WARNING: kernel/locking/rtmutex.c:1674 at 0x0, CPU#1: kworker/1:0/31
Modules linked in:
CPU: 1 UID: 0 PID: 31 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: events rfkill_global_led_trigger_worker
RIP: 0010:rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1674
Code: 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 86 00 00 00 48 89 f7 e8 a6 3b 01 00 48 8d 3d ef c2 19 04 <67> 48 0f b9 3a 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 f0 a9 91 4c
RSP: 0018:ffffc90000a5f810 EFLAGS: 00010286
RAX: 0000000080000000 RBX: ffffc90000a5f8a0 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8cde6eea RDI: ffffffff8edc7190
RBP: ffffc90000a5f9b8 R08: ffffffff8ed95177 R09: 1ffffffff1db2a2e
R10: dffffc0000000000 R11: fffffbfff1db2a2f R12: 1ffff9200014bf10
R13: ffffffff8ac2a989 R14: ffffffff8eb737a0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888126e81000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e00bff8 CR3: 000000007d9a6000 CR4: 00000000003526f0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000083
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x666/0x6b0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:534 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:552
 rfkill_global_led_trigger_worker+0x27/0xd0 net/rfkill/core.c:182
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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
  1e:	e8 a6 3b 01 00       	call   0x13bc9
  23:	48 8d 3d ef c2 19 04 	lea    0x419c2ef(%rip),%rdi        # 0x419c319
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4c 8d 3d 00 00 00 00 	lea    0x0(%rip),%r15        # 0x36
  36:	65 48 8b 1c 25 08 f0 	mov    %gs:0xffffffff91a9f008,%rbx
  3d:	a9 91
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

