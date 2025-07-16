Return-Path: <linux-wireless+bounces-25548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B179CB07BB7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28753188A81A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7AB236A73;
	Wed, 16 Jul 2025 17:01:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95C186294
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685300; cv=none; b=kWHbv/9puFTp/kC1N/5JL/ZJ4688S50wFibqMVaRD4MFBMDrdCHSE2obuLVTFEzlbYS2t+5t5D/iicz5O8SOqXphcLTrml+sEWKzGHfopwAkucClPtqqTzzj+GgLyvimbS8xjNBmtgvDjxYT56zDeGoCs9UjzDkPDQLEldO4Gb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685300; c=relaxed/simple;
	bh=e0yD3duGWfrYlQrpRQ5Eo7EbZCP52YDpCQ9BN8+ZzRA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hwchuri9r7yaT73pyPzX3fre0DWxEl5zu6lWz9bxh0IhAKtBZ94ix7PNgSnztUh22FHbqWlg1fPDs2q5LJbQ+PUT7AVebL1KNy8nlMfXZUTWpuUaR6e5kbKDaQefj/zGbxkq/Oe7l1e5S4gWySsKwI21JaM+mwsCTAnc4OLwMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df2d0b7c7eso222265ab.2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 10:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752685294; x=1753290094;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBmetddKLkjuJQ98nhwMXAQpQ48VqF4cEgqzN1+zBjs=;
        b=dq7+GpOqJNoYp2uXptEvgslwsU9AMUEIV08UbqdEcVvRJXBq1nkKer02/ondBdFSSL
         PVhASFBWTQf+YCP8yfS7RZtZYjGAy4ZTJVEIrVhOIhBWJdUyNjJ4d2nWlddkAzBkayEj
         1RZdirO/h4uI9i+ElvutqRqRZ1M4gddUffQjN/tAVtCKzUUXXc595ubxqYra/vBh4ygt
         /GV73pwv9ChxnJbEhf13192heE9P0NSzq3lengHfcM7BuEFaTnIEOxDErzfPz7yPEcag
         5X8LSO1/0S9uafQOfLnDzWpknUKj+1k7Alzdl8gmCLT9OGwCBNgLQLKokmor5/TdTzgT
         rAGg==
X-Forwarded-Encrypted: i=1; AJvYcCUAQ90EPfz7btbIZF4wrVsZ7isD4h8bOfn5qrp6BkhlVywHUJuGfZ6bUjBFJviM6JSSJ/vfXvxkdJdRU4NWpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlcttRHc+7RUehkvAuebodEOjKETAPOW0dAhU2JrjrONX6qSwA
	Pgqccbf4tL/CIKcCEHGd73YWx4YsgItlajnou80Wl8Tvp3rQZY+MIUajS1yNVhjWE2NJQlihF0X
	nlrWTHoXkc1ZDQlWVfsWdiiM+XbOd7bFc7FcZygOicsekVoRs9oJVgcdMF18=
X-Google-Smtp-Source: AGHT+IE+24eO6q3p4Mj9R1gSkyzP3EXdEW8uoZpqJYRJ6dWbgB29GJiWHDLeF1dRE39CyLgtV3NqYhCRbeciDZXhLWSAmHz842uL
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:741:b0:3e1:63a5:5aaa with SMTP id
 e9e14a558f8ab-3e282dc60a8mr34517555ab.6.1752685294134; Wed, 16 Jul 2025
 10:01:34 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:01:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6877daee.a70a0220.693ce.002d.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: rcu detected stall in sock_close (5)
From: syzbot <syzbot+9a29e1dba699b6f46a03@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    379f604cc3dc Merge tag 'pci-v6.16-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1690fe8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=9a29e1dba699b6f46a03
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1190fe8c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-379f604c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/355475904f2c/vmlinux-379f604c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c247a5b19c2d/bzImage-379f604c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a29e1dba699b6f46a03@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 123s! [syz.0.2011:11811]
Modules linked in:
irq event stamp: 337922703
hardirqs last  enabled at (337922702): [<ffffffff8185b0dd>] __local_bh_enable_ip+0x12d/0x1c0 kernel/softirq.c:412
hardirqs last disabled at (337922703): [<ffffffff8b6f3f4e>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1050
softirqs last  enabled at (584): [<ffffffff8b0f4de9>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (584): [<ffffffff8b0f4de9>] tipc_skb_peek_port net/tipc/msg.h:1235 [inline]
softirqs last  enabled at (584): [<ffffffff8b0f4de9>] tipc_sk_rcv+0x3e9/0x2ba0 net/tipc/socket.c:2489
softirqs last disabled at (586): [<ffffffff8b0f4e21>] spin_trylock_bh include/linux/spinlock.h:411 [inline]
softirqs last disabled at (586): [<ffffffff8b0f4e21>] tipc_sk_rcv+0x421/0x2ba0 net/tipc/socket.c:2494
CPU: 0 UID: 0 PID: 11811 Comm: syz.0.2011 Not tainted 6.16.0-rc5-syzkaller-00224-g379f604cc3dc #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:should_resched arch/x86/include/asm/preempt.h:104 [inline]
RIP: 0010:__local_bh_enable_ip+0x135/0x1c0 kernel/softirq.c:414
Code: 8b e8 6f b2 e9 09 65 66 8b 05 6f 9f 1a 11 66 85 c0 75 5a bf 01 00 00 00 e8 a8 32 0b 00 e8 b3 11 42 00 fb 65 8b 05 4b 9f 1a 11 <85> c0 75 05 e8 82 f5 ad ff 48 c7 04 24 0e 36 e0 45 4b c7 04 37 00
RSP: 0018:ffffc9000e456540 EFLAGS: 00000286
RAX: 0000000000000201 RBX: 0000000000000201 RCX: 1216cf3644652a00
RDX: 0000000000000002 RSI: ffffffff8d998e51 RDI: ffffffff8be29e00
RBP: ffffc9000e4565d0 R08: ffffffff8fa1f5f7 R09: 1ffffffff1f43ebe
R10: dffffc0000000000 R11: fffffbfff1f43ebf R12: ffffffff8b0f4de9
R13: dffffc0000000000 R14: dffffc0000000000 R15: 1ffff92001c8aca8
FS:  00007fa71c0906c0(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000009000 CR3: 0000000043757000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 tipc_skb_peek_port net/tipc/msg.h:1235 [inline]
 tipc_sk_rcv+0x3e9/0x2ba0 net/tipc/socket.c:2489
 tipc_node_xmit+0x1c9/0xe90 net/tipc/node.c:1701
 tipc_node_xmit_skb+0xf4/0x150 net/tipc/node.c:1766
 tipc_sk_rcv+0x29c4/0x2ba0 net/tipc/socket.c:2520
 tipc_node_xmit+0x1c9/0xe90 net/tipc/node.c:1701
 tipc_sk_push_backlog net/tipc/socket.c:1312 [inline]
 tipc_sk_filter_connect net/tipc/socket.c:2253 [inline]
 tipc_sk_filter_rcv+0x12a0/0x30b0 net/tipc/socket.c:2362
 tipc_sk_enqueue net/tipc/socket.c:2443 [inline]
 tipc_sk_rcv+0x8a5/0x2ba0 net/tipc/socket.c:2495
 tipc_node_xmit+0x1c9/0xe90 net/tipc/node.c:1701
 tipc_node_xmit_skb net/tipc/node.c:1766 [inline]
 tipc_node_distr_xmit+0x2a0/0x3b0 net/tipc/node.c:1781
 tipc_sk_backlog_rcv+0x1a1/0x230 net/tipc/socket.c:2410
 sk_backlog_rcv include/net/sock.h:1148 [inline]
 __release_sock+0x249/0x350 net/core/sock.c:3213
 release_sock+0x5f/0x1f0 net/core/sock.c:3767
 tipc_release+0x16e2/0x2160 net/tipc/socket.c:650
 __sock_release net/socket.c:647 [inline]
 sock_close+0xc3/0x240 net/socket.c:1391
 __fput+0x449/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:114
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa71b18e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa71c090038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 00000000000203a0 RBX: 00007fa71b3b5fa0 RCX: 00007fa71b18e929
RDX: 0000000000000000 RSI: 00002000000003c0 RDI: 0000000000000003
RBP: 00007fa71b210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa71b3b5fa0 R15: 00007fffdf037f88
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

