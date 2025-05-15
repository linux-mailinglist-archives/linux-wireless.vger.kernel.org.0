Return-Path: <linux-wireless+bounces-23014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D2AAB8A47
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E0D4E19B9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8220E6F9;
	Thu, 15 May 2025 15:06:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1121F8691
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321600; cv=none; b=BLlTc5CI8t1GRGfqnQjhn1Ntlj4bI+67qkfd7rBuxoj/rxQL4Tcp1DuZC24Gjz6mXIKStWYm+h3NsBkdxfST1oAG3k34ml0DY0GjDX2saEspgYkEcAG5wnWOnZhZFeXUuIgsV/DRwwNc2C+1YL80rHjLsWZV9hQLCWHrS4cN1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321600; c=relaxed/simple;
	bh=DDEfGDPw064d8TIOtPIrX0kse9ua0SZ/cndNX98QQnY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gFfOzeus0vEPgZSoKAo/vyKpk5/ZRbC/IM4ArPkSetvyiKJNrNnoBNZqT5YNRvz6SNMgVrb+e7P9q/Vzmh0I1Q333MlyXM/IADz+QPngZF4UvevO/HBU8tuWGEGigDbtB9OaKmm09LWTp0TLtf1d/HcBuVueEz1Cvuom7VtUFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d94fe1037cso12667275ab.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 08:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747321598; x=1747926398;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdqUBxPxMGurCy9C3+4NLc4yoL33befp7d4Bh5bR8eo=;
        b=qMMXbFTDVztgNNhVWglPru+hOygj5KcsAqDet9pdNAZSElyraxWPfT2Ty24Lhm6ReH
         CtWVh/P4XBD8+1vBALnJwoUGO+ogN38bWObYn3NUgCHptylxmFSsBm5sFFU1rOtrLzMd
         ea3n0rryWZPXR9f4Y3gt5tWxxYsJE+STI4wuzmtLlZNqQQgzIxv5J5A+af7LAlLkkoud
         ElfdvefMgZbyTDu2jSYcODpFzrXtklkdvc5I/BQohgMQljAPGHuYwDRhE3wJwEtu4Ypu
         Y6RjGk3h2gwS65RUpwyQdvErGcI83TipiqI0ws6wDojUn9c3JV6NP/ebToUxtIes1JyN
         5zjg==
X-Forwarded-Encrypted: i=1; AJvYcCVyz4X9TDuoebGkpm10L0XSYlB6nAvfAjN5n0gygSK7VYQsaByNccZLhRBkefq1rRNxUr0Nxd3CIMhzY5DfKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGujY14eQ+iX0RqSh/VMQ0Dq9M4TSrzBGA4qQVhA5ylriXLqc
	SmwTIHM4bWe2Kw69DsBbEHlTbf4aSP12Qtnz/w76f6BCTCFwPZJe7jwiQKXJiZyRR1fLp1zjRFU
	ExDqNyabNo1ECTle3Ot+DZ/cbnoSanenNopjhzALjcVTOHHC2py/JylQqtIQ=
X-Google-Smtp-Source: AGHT+IGVmkgxM/BHYmds//15NtrEZvxv8aFwrlsMsBe3q4X9HGpSd4L3Vc2qezoaYUvvh3wHgWzqzY4aNdheZSzDelJqt6uivYTN
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3db:7c22:303c with SMTP id
 e9e14a558f8ab-3db842ce2f3mr123805ab.8.1747321597922; Thu, 15 May 2025
 08:06:37 -0700 (PDT)
Date: Thu, 15 May 2025 08:06:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682602fd.a00a0220.a2f23.01d0.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in mac80211_hwsim_sta_rc_update
From: syzbot <syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b466efc6365 dt-bindings: net: renesas-gbeth: Add support ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1582e2f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc0c7bf6a7800c98
dashboard link: https://syzkaller.appspot.com/bug?extid=c0472dd80bb8f668625f
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0dc241e466cd/disk-6b466efc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5df43ce17ae4/vmlinux-6b466efc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7cb3cf08e099/bzImage-6b466efc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com

netlink: 16 bytes leftover after parsing attributes in process `syz.0.682'.
------------[ cut here ]------------
intf 08:02:11:00:00:00 [link=0]: bad STA 08:02:11:00:00:01 bandwidth 20 MHz (0) > channel config 10 MHz (7)
WARNING: CPU: 0 PID: 8246 at drivers/net/wireless/virtual/mac80211_hwsim.c:2653 mac80211_hwsim_sta_rc_update+0x6f5/0x860 drivers/net/wireless/virtual/mac80211_hwsim.c:2650
Modules linked in:
CPU: 0 UID: 0 PID: 8246 Comm: syz.0.682 Not tainted 6.15.0-rc5-syzkaller-01032-g6b466efc6365 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:mac80211_hwsim_sta_rc_update+0x6f5/0x860 drivers/net/wireless/virtual/mac80211_hwsim.c:2650
Code: 71 17 00 00 48 c7 c7 60 f8 0b 8c 48 8b 74 24 28 89 ea 48 8b 4c 24 10 41 89 d8 45 89 f9 41 56 50 e8 90 48 9c fa 48 83 c4 10 90 <0f> 0b 90 90 e9 0c ff ff ff e8 2d ec d7 fa 90 0f 0b 90 e9 fe fe ff
RSP: 0018:ffffc90005156fb0 EFLAGS: 00010282
RAX: bdf3540220fb5200 RBX: 0000000000000014 RCX: 0000000000080000
RDX: ffffc9000d50e000 RSI: 0000000000005821 RDI: 0000000000005822
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bba4b4 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000007 R15: 0000000000000000
FS:  00007f21ea3676c0(0000) GS:ffff8881260c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa1e8181000 CR3: 000000002ff00000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mac80211_hwsim_sta_add+0xa3/0x310 drivers/net/wireless/virtual/mac80211_hwsim.c:2670
 drv_sta_add net/mac80211/driver-ops.h:466 [inline]
 drv_sta_state+0x8be/0x1840 net/mac80211/driver-ops.c:155
 sta_info_insert_drv_state net/mac80211/sta_info.c:775 [inline]
 sta_info_insert_finish net/mac80211/sta_info.c:883 [inline]
 sta_info_insert_rcu+0xd32/0x1940 net/mac80211/sta_info.c:960
 sta_info_insert+0x16/0xc0 net/mac80211/sta_info.c:965
 rdev_add_station+0x105/0x290 net/wireless/rdev-ops.h:201
 nl80211_new_station+0x1723/0x1b40 net/wireless/nl80211.c:7843
 genl_family_rcv_msg_doit+0x212/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f21e958e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f21ea367038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f21e97b6080 RCX: 00007f21e958e969
RDX: 0200000000000000 RSI: 0000200000001080 RDI: 0000000000000009
RBP: 00007f21e9610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f21e97b6080 R15: 00007ffd3178ff18
 </TASK>


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

