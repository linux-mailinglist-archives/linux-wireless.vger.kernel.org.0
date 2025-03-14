Return-Path: <linux-wireless+bounces-20394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5D5A61757
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 18:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0534F7AE413
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626C204681;
	Fri, 14 Mar 2025 17:19:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA62045B0
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972769; cv=none; b=am9kgbBQ7kt+s6TQgAcYHjdjFO+WdbsmECbCquY1Itc4dUaHsNzGpmy1jt63fEG+gJrlqvM12/wIcMDVI3YlkdJnfTLldis3Lv65WMrpnnm8wSscFQwex2HNauBe9NZI/I41w1+SZBrlNanFdId2IBGCkYmapYMYlm0qBiXhEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972769; c=relaxed/simple;
	bh=Du9RJGbb9psIVNeI+yAeDVtzDtNrzqDrEl0W/9ZCin0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BFTyVmWP3RQ4dB1MG5o9FrT9ff9wYz+B0gHBPLTOFYAKR9kD3m4IQ4pnWmm+G+dzWyfnayUkNdsBfsUWvlEBFUBfCwQxEA2jI5Rw/nY/m6yUkX+NQzoBL6WilBHE8Tdb0rt3iUX/5E0aAsKeZtjIcn0xRSsS4x9vVyUMW6Em5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3cf64584097so28855845ab.2
        for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 10:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741972767; x=1742577567;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ppgVzZRvU97l1+hVwJtVxXfVprkA8dzBpDh9Oges2c=;
        b=N7GTeu6RTjn5oM8D2Q0IRw+ecCb4mlIy+d8xN0QHC5NxJeL/zQkAnoBo9Rp+LrBvPf
         S/SQyGcJBvdE88O0eabjqtLsu18DnAgxTUM3McuvGAttSDmjGJ1K6q+XDQHLGAP7UstR
         XpNBgSRSEOqEGfEOLFqkKTs0fBNFiR4h2pBdX6lZ/gKeVKo5ZZlchZTDN1YIb5dTDUS3
         guFgLDFcRT/z7ex8k0mYigtn2RNCI64do+150iHOtv7c6PFlVzwrQlAN35wlEFWPHM5D
         8RBhoRSxXmLHnieLA2HJnOO9yFi4PTiehQTpomUfPEJsxwh+XcxgjzuDSs6IQGp96qYd
         2Y5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUe5OrAEO7RZafHspWCyo48FBbs2stc8j1Nb5MbrBSk+hXCCU/oE0l7XRZWzQNeNknjnR3ZHexeQEEo7NKvzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxfJTtUIwpwzqpNMbluGuu8BUVyPPyuXlG7ySGn0R79lbUOEB
	jpJpkW/IEsKouxC6jHislVj2T+I/7tM6vokLckgFFB0r4Bd+wz629IdSqz0C/i4FNr7bnf4xpf7
	kEFMPoAGb58+ri3/G/WPy91VPi29h9E8zsLUdidafzNPWo099hsyreH0=
X-Google-Smtp-Source: AGHT+IFOiPs3MtkoF63Pl0vbvLWOrvLIX9jwZ+pNkZJVYt+DpVfRZbpCPjjffCobhQyUoQInPy5oY30N4bYc6VDIIZS4SXAkhb90
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a0d:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d4839f442amr32566345ab.2.1741972766860; Fri, 14 Mar 2025
 10:19:26 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:19:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d4651e.050a0220.14e108.0048.GAE@google.com>
Subject: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (3)
From: syzbot <syzbot+30de9d963fdd95d745f8@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89d75c4c67ac Merge branch 'mlx5-next' of git://git.kernel...
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15941698580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca99d9d1f4a8ecfa
dashboard link: https://syzkaller.appspot.com/bug?extid=30de9d963fdd95d745f8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ebddb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115beff8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42d0e44c785b/disk-89d75c4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a15a82bda0f1/vmlinux-89d75c4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51341d6e7b24/bzImage-89d75c4c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30de9d963fdd95d745f8@syzkaller.appspotmail.com

netlink: 'syz-executor330': attribute type 10 has an invalid length.
======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc5-syzkaller-01215-g89d75c4c67ac #0 Not tainted
------------------------------------------------------
syz-executor330/5838 is trying to acquire lock:
ffff888021b08768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6063 [inline]
ffff888021b08768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_change_mac+0xc6/0x1160 net/mac80211/iface.c:307

but task is already holding lock:
ffff88807a458d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
ffff88807a458d28 (&dev->lock){+.+.}-{4:4}, at: dev_set_mac_address+0x2a/0x50 net/core/dev_api.c:302

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&dev->lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
       netdev_lock include/linux/netdevice.h:2731 [inline]
       register_netdevice+0x12d8/0x1b70 net/core/dev.c:10991
       cfg80211_register_netdevice+0x149/0x2f0 net/wireless/core.c:1482
       ieee80211_if_add+0x119d/0x1780 net/mac80211/iface.c:2225
       ieee80211_register_hw+0x3708/0x42e0 net/mac80211/main.c:1604
       mac80211_hwsim_new_radio+0x2a89/0x49f0 drivers/net/wireless/virtual/mac80211_hwsim.c:5559
       init_mac80211_hwsim+0x87a/0xb00 drivers/net/wireless/virtual/mac80211_hwsim.c:6911
       do_one_initcall+0x248/0x930 init/main.c:1257
       do_initcall_level+0x157/0x210 init/main.c:1319
       do_initcalls+0x71/0xd0 init/main.c:1335
       kernel_init_freeable+0x435/0x5d0 init/main.c:1568
       kernel_init+0x1d/0x2b0 init/main.c:1457
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
       class_wiphy_constructor include/net/cfg80211.h:6063 [inline]
       ieee80211_change_mac+0xc6/0x1160 net/mac80211/iface.c:307
       netif_set_mac_address+0x327/0x510 net/core/dev.c:9587
       dev_set_mac_address+0x38/0x50 net/core/dev_api.c:303
       bond_enslave+0xff3/0x3910 drivers/net/bonding/bond_main.c:2123
       do_set_master+0x579/0x730 net/core/rtnetlink.c:2943
       do_setlink+0xfee/0x40f0 net/core/rtnetlink.c:3149
       rtnl_changelink net/core/rtnetlink.c:3759 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
       rtnl_newlink+0x15a6/0x1d90 net/core/rtnetlink.c:4055
       rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
       netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:709 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:724
       ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
       ___sys_sendmsg net/socket.c:2618 [inline]
       __sys_sendmsg+0x269/0x350 net/socket.c:2650
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&dev->lock);
                               lock(&rdev->wiphy.mtx);
                               lock(&dev->lock);
  lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

2 locks held by syz-executor330/5838:
 #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc4c/0x1d90 net/core/rtnetlink.c:4054
 #1: ffff88807a458d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
 #1: ffff88807a458d28 (&dev->lock){+.+.}-{4:4}, at: dev_set_mac_address+0x2a/0x50 net/core/dev_api.c:302

stack backtrace:
CPU: 1 UID: 0 PID: 5838 Comm: syz-executor330 Not tainted 6.14.0-rc5-syzkaller-01215-g89d75c4c67ac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
 class_wiphy_constructor include/net/cfg80211.h:6063 [inline]
 ieee80211_change_mac+0xc6/0x1160 net/mac80211/iface.c:307
 netif_set_mac_address+0x327/0x510 net/core/dev.c:9587
 dev_set_mac_address+0x38/0x50 net/core/dev_api.c:303
 bond_enslave+0xff3/0x3910 drivers/net/bonding/bond_main.c:2123
 do_set_master+0x579/0x730 net/core/rtnetlink.c:2943
 do_setlink+0xfee/0x40f0 net/core/rtnetlink.c:3149
 rtnl_changelink net/core/rtnetlink.c:3759 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
 rtnl_newlink+0x15a6/0x1d90 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f76fec11329
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4bb2f358 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f76fec5e513 RCX: 00007f76fec11329
RDX: 0000000000000000 RSI: 0000400000000600 RDI: 0000000000000003
RBP: 00007f76fec5e4e3 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f76fec5e44b
R13: 0000000000000048 R14: 0000000000050012 R15: 0000000000000003
 </TASK>
bond0: (slave wlan1): Enslaving as an active interface with an up link


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

