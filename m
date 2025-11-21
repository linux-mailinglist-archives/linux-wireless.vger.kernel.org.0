Return-Path: <linux-wireless+bounces-29246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF2CC7BA21
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 21:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 139874E1456
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 20:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD7529AAFD;
	Fri, 21 Nov 2025 20:26:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67C1C84A6
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763756789; cv=none; b=B4EppxWIpFYbQm0wdwECUZYAU99bF6xyfASSIpfQRk6T28yzSA/Gio1zNUrJBL0hAORo1JwKf/kkdFSsrqY/V7jtRld/N1cXimyZbbjPq98YGRh7hJQJ76HcHnGDJGcdBUMQRK1kzVmEP5htK48IppPxIbJcmzwFPfaXJE9tOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763756789; c=relaxed/simple;
	bh=CVbCQXjcXqmsI8PvgmNhYZ4hJ3PAVBKnVbnfJxC/mGk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TIzNdGgm6Qz14i83HPJFp8+/JNQ2JEPQuqVDFngH0lbu8Kc8AkAbVNkzMYj0GQkNoExcFDXq4Xu6lbdXfj0Z+NJOYSv/4kRDMbi7B+Jm0CVOt5Okp7lKYHtes/NnvRwcYEzUIluBkbb0AFJAYsMJTDJn+mxrk9FZUffDnhdeuHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-948f6c90813so179929639f.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 12:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763756787; x=1764361587;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SN7QW5iP4HoHv7vHf/H+25kYWn7ovoYWMwTlKmZ7fkg=;
        b=TtDi/F9khbpGeui5Ils34EbuL6qL49HWNEaRpNgXChzKcqPDWLVcBVU7HKlrqqgaKU
         6OhCkllvwAmdrvPnk1mX1MB69MtocHO/sqkY8/Qp7rMZCxSDZvLkBgg9kHR5XlPi4LDW
         efv8Sxj/0TFTC/SeA67bMS9ME5egJJi5SiGHXQWqVFJdv6gWjLb9vDpTL92wnH3iD8dm
         SxT3htee5WXIT/MoNnGHoBT2K+0QOzPeu25E8K7bcLR3SeydGuPMu9Z8xU1V+wb46zq2
         uUNNRVznsAQ8kCyoCkU7l1VAPcPXNkeHWLuIOoku4QZ/OUseUADq0DeOqz0Bzdexawpl
         ZbDA==
X-Forwarded-Encrypted: i=1; AJvYcCXtTSq9HoPFIH0OwCagMk/z+kgX93Pb2EjExYONTi0XU9+LfCkZoqWspBGdKtehkyxuN3anwCXqF0MpNnxI6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9P2XCqUaMQvmbZuyCh6LVEPNMxfNO2ftY8GKm65lpukYAcc/4
	OqZShLr3lYi2vaLP7H3rDD0I/BfWCIZy/ko/fTuorvAIb8XVF3ofym/7B59R0OTUagAYIbiGIsT
	Equ3Gz/MbiBobbhuUFF+6g2RQGYyPuSMVaPVrd6abAcrLfHg+6y6Lnw3X1lY=
X-Google-Smtp-Source: AGHT+IH45HYkobNWM41IaAbsfvUqRvxiVrEN5uCZcQeNjiTEKU4mWuVsc2smGZ3XADFijpVGTUbWTdXlx8r7f4ncFpJWSmGo71a1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3499:b0:433:2a9b:165c with SMTP id
 e9e14a558f8ab-435b8e51411mr30073355ab.27.1763756787052; Fri, 21 Nov 2025
 12:26:27 -0800 (PST)
Date: Fri, 21 Nov 2025 12:26:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6920caf3.a70a0220.d98e3.004a.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_teardown_sdata (2)
From: syzbot <syzbot+9b98dcd91414ddae4a56@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a23ae0a96a6 Linux 6.18-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104e6692580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14b6a9313e132a6b
dashboard link: https://syzkaller.appspot.com/bug?extid=9b98dcd91414ddae4a56
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/464c2673a9ca/disk-6a23ae0a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2986bef024f/vmlinux-6a23ae0a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4077bdc25422/bzImage-6a23ae0a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b98dcd91414ddae4a56@syzkaller.appspotmail.com

bond0: (slave wlan1): Releasing backup interface
------------[ cut here ]------------
WARNING: CPU: 0 PID: 10842 at net/mac80211/iface.c:861 ieee80211_teardown_sdata+0xd2/0x140 net/mac80211/iface.c:861
Modules linked in:
CPU: 0 UID: 0 PID: 10842 Comm: syz.0.1271 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:ieee80211_teardown_sdata+0xd2/0x140 net/mac80211/iface.c:861
Code: f7 48 89 df 31 f6 31 d2 e8 0b 9b 00 00 48 81 c3 10 18 00 00 48 89 df 5b 41 5c 41 5e 41 5f 5d e9 94 bb 00 00 e8 3f a5 03 f7 90 <0f> 0b 90 4c 8d bb 30 0a 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 20 00
RSP: 0018:ffffc9001b87f050 EFLAGS: 00010287
RAX: ffffffff8abc5ed1 RBX: ffff888059190d80 RCX: 0000000000080000
RDX: ffffc9000b8c2000 RSI: 000000000001e9e7 RDI: 000000000001e9e8
RBP: ffffc9001b87f1f0 R08: ffffffff8f7ceb77 R09: 1ffffffff1ef9d6e
R10: dffffc0000000000 R11: ffffffff8abcbe10 R12: dffffc0000000000
R13: ffff888059190c18 R14: ffff888059191a08 R15: ffff888059190000
FS:  0000000000000000(0000) GS:ffff88812613b000(0063) knlGS:00000000f53f6b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000008057f000 CR3: 00000000591a8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 unregister_netdevice_many_notify+0x1cde/0x2390 net/core/dev.c:12305
 unregister_netdevice_many net/core/dev.c:12347 [inline]
 unregister_netdevice_queue+0x33c/0x380 net/core/dev.c:12161
 unregister_netdevice include/linux/netdevice.h:3389 [inline]
 _cfg80211_unregister_wdev+0x165/0x590 net/wireless/core.c:1284
 ieee80211_if_remove+0x256/0x310 net/mac80211/iface.c:2334
 ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:237
 rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
 cfg80211_remove_virtual_intf+0x231/0x3f0 net/wireless/util.c:2928
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg+0x164/0x220 net/socket.c:2716
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f02539
Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f53f655c EFLAGS: 00000206 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000080000200
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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

