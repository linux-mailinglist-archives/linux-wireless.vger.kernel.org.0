Return-Path: <linux-wireless+bounces-10189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADFD92ECC7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 18:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DC1F219C1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8FC16CD2C;
	Thu, 11 Jul 2024 16:32:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1416C858
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715543; cv=none; b=uRWurNhlJ7fsBoSBWR2/jTunLTvrttXc8BAnzJd4UQrG63Zg2FAQ+tVEC45fSEyfnIbu7D6+W5QEkmOXEpwqVjZRmRzvzk4O1BAh5Bl0woeDY5PanrnLOOsfhmw1BsUtM9HCPe72D2ae/8bSlB6hrItdDUjjAlXdrOdbmLeY6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715543; c=relaxed/simple;
	bh=c2d3iyUQdVBWidO9otp/SphbHXyDfvdcDXhrLan7KMw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O6am9GLHzxf3F0El//SnN3nEcFjTrGCnnvnGzpu4Ff/dn6PPvBTFizsD7432HKzJmOt0ntkoCfe0lfnOs3l4ZCpMrTQrqg8gQKS6ryEZAMZBwbDIWUetKq7qFGslmx/zUCTcmtDyI7XxApG9CT8GBA3J3aHobsY1cx+Glf6Y+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-802d5953345so112022539f.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 09:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720715541; x=1721320341;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Ys8pPyGnkUAIktEMj8o83PLn9BquZuJ6dCWf5ksSyI=;
        b=BtPgLsHACQUXs3CIUjPftsl1FsNBurYrpnaOAQ6vzSrt8srQPD/hmOpgCkJutd0jtB
         EpC3sZWZXYVjneymkWm/VTxndhpUKH6AgxWybP1JY7XvCyBfRF5I/r9hAWm7meMdG8e7
         QYbsQX+IduC80wrk57u/CNeibwVDub8P8nDbI4gIEmbzNC9EFGjjWSPwKf6Za5MWr6Mj
         4yCTk6SCMqq9twuj6a6rgIa8+PP//drtAxGp7D7Y5V0rPDr+kB2YkKHT5JdzUgZ1HO78
         nlPtIO2aykOdy6DEfmq2T7J5WbqZJ91DenpdYgLAfCKxrPbJBz7wsKhteCY7eB42l1y5
         xYxg==
X-Forwarded-Encrypted: i=1; AJvYcCVbX/qfFrAJGL3X58/k+iyEB1G+yQFc/P6htsdWG2dIJM5qZ1gsc1G6ErYkbZtPNDrYnRE8pSQb1xezONnWxlX7aitG478L1o1yGSiaP0Y=
X-Gm-Message-State: AOJu0YzAOHymh/VUMJ23VqjJY8mrZstvV09vgnzfFb+QlLfbOHjuPPV8
	wH4Ep9ltLeRRY9Lgp7SjYv8qGXKznBvLNms7VQ/3LwK6jQkC6m4/6ZOdZpwgKbGOemQY7TmPkcA
	gwvOSim0QEg24OyDgoQjXq1AqJxIaM+ZBSeTdIxSTIQe5pCyOzYMUPuo=
X-Google-Smtp-Source: AGHT+IFbpfIXNnqTL7NYWHHMAFG/YWOGVCCsFGHwH6sAxF5seh9VrLw2I0yQVtVUZ1unpbpIRoZE3r3yyxI1FmRkQOKBVfBGkubd
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4124:b0:4c0:95c9:f77 with SMTP id
 8926c6da1cb9f-4c0b2ba3f26mr528011173.6.1720715539407; Thu, 11 Jul 2024
 09:32:19 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:32:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c77b5061cfb4ec6@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_do_stop (2)
From: syzbot <syzbot+d7aa450b9ba2a184513b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f5e6395714d Merge branch 'net-pse-pd-add-new-pse-c33-feat..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f48376980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d7aa450b9ba2a184513b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44296878e8d6/disk-2f5e6395.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3f8523e4843/vmlinux-2f5e6395.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c40a60a2869f/bzImage-2f5e6395.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7aa450b9ba2a184513b@syzkaller.appspotmail.com

netdevsim netdevsim1 netdevsim2: entered allmulticast mode
netdevsim netdevsim1 netdevsim3: entered promiscuous mode
netdevsim netdevsim1 netdevsim3: entered allmulticast mode
mac80211_hwsim hwsim10 wlan0: entered promiscuous mode
mac80211_hwsim hwsim10 wlan0: entered allmulticast mode
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7335 at net/mac80211/iface.c:515 ieee80211_do_stop+0x18ee/0x1ee0 net/mac80211/iface.c:515
Modules linked in:
CPU: 0 PID: 7335 Comm: syz.1.716 Not tainted 6.10.0-rc6-syzkaller-01258-g2f5e6395714d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:ieee80211_do_stop+0x18ee/0x1ee0 net/mac80211/iface.c:515
Code: ff e8 a6 32 9c f6 4c 89 ef 31 f6 e8 1c 4c 0c 00 48 8b 5c 24 60 e9 9d fd ff ff e8 8d 32 9c f6 e9 93 fd ff ff e8 83 32 9c f6 90 <0f> 0b 90 e9 cd ea ff ff e8 75 32 9c f6 90 43 0f b6 04 27 84 c0 0f
RSP: 0018:ffffc9000d726800 EFLAGS: 00010246
RAX: ffffffff8af9f4dd RBX: 0000000000000002 RCX: 0000000000040000
RDX: ffffc900093ec000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffc9000d726968 R08: ffffffff8af9dfa0 R09: 1ffffffff1f5b9ad
R10: dffffc0000000000 R11: fffffbfff1f5b9ae R12: dffffc0000000000
R13: ffff88807a598e20 R14: 0000000000000001 R15: ffff88807a8a2800
FS:  00007f0f44fb46c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f53c3a15fa3 CR3: 0000000069780000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_stop+0x436/0x4a0 net/mac80211/iface.c:761
 __dev_close_many+0x219/0x300 net/core/dev.c:1558
 __dev_close net/core/dev.c:1570 [inline]
 __dev_change_flags+0x30e/0x6f0 net/core/dev.c:8835
 dev_change_flags+0x8b/0x1a0 net/core/dev.c:8909
 do_setlink+0xccd/0x41f0 net/core/rtnetlink.c:2900
 rtnl_group_changelink net/core/rtnetlink.c:3447 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3706 [inline]
 rtnl_newlink+0x1119/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6641
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0f44175bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f44fb4048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0f44303f60 RCX: 00007f0f44175bd9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000005
RBP: 00007f0f441e4aa1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0f44303f60 R15: 00007ffe2ab3ef88
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

