Return-Path: <linux-wireless+bounces-13538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A754F99123A
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 00:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D528B20F9C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7F1B4F27;
	Fri,  4 Oct 2024 22:17:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA01AE017
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080251; cv=none; b=eXiZfRms8bkn4znj3go0hEYgcTwX+yFRBVRycsN/sodyTs8pavJpm7uE4BD1Aj/xXScNGTJVX8lucXDEDxpeLB9P4jB9wmzSmm+qJbfB02FzNEK4ZYEr2mFWifdpaavxyg1t1RDXdWMH1QU1TohYqYvICz7NQqcAAKi8tYOBdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080251; c=relaxed/simple;
	bh=U1uH9QDY6vx2UeDHTM+aph2Y6O4NZD7mfBYJnpGLzno=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jCUrweqt5k+YrxetF028sEb2sxzJbu9AunVn6dhzz3tEzkrcS9ijBt2O3p7RyrvCNUtirv49m2lA8h7N2UWuz0h4HUF+ZcyEqWydT7gQ6CzgqyCQ99ph4QACRtNBH85IAeYpjI43/dSseSpIzSXUT2cicF+z+6Ky/m+GmPIfxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1925177fdso30781695ab.3
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2024 15:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728080249; x=1728685049;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWQv+RxN02exyEKGS47YMJ9DPgmUY2/O6FyiFiv/gNs=;
        b=QZcG2kgZzXVa7BloWTCDgKvgBklYtxjPlqeVSR3NJ/qPdQ5GW/cS0vksfpooCXioTB
         3a/Yl9Sll6QzpT8ofH3nl+8scOUkhlnxpx6kpLOp2nvm1CpgwdmBd02CNouNJekXnFgU
         nA2vCqhd2Tv12WIpUnSLhqW/bgqjX42EzQx3iEJJewY4GtCWYUE53rmfjKCFyIo9vzKF
         TKM+sXrY+j1YhwjZHaZr5sYRisdx2pnuRYJY9NXxd/89gJhrYYQk0XobQsF1QXxe6p2s
         oInSos6XtvdX25d5RPhr7kqBMkVkzsuM7Q1ztOX37qe1XGJgQ+3atD2D6A/RSoS6mzt/
         lWZA==
X-Forwarded-Encrypted: i=1; AJvYcCXWKZ3F2EFx9vDUttsLfn5oDu1v2YbKMK8idlPA4MK+lWEYniBZd0nWmzaBNBiaf8hP96jWpqBgLY49g7vEiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCxmu2xs6VUB7PUakqNx+SYKbUxjnyQy6lUjdcnfU7fBBefIY
	naSIzOq3sdRa4IcMQGIiGqwksFm/pghWi7z2XGM+Hgmp/zqrSLWt1PdwGJsWiEvudIxR2+gj7lt
	Gdk852uf1H0wfxsiRePBPCO6k/67GVt4NjE95HEVFyZesZFsBDunmaFg=
X-Google-Smtp-Source: AGHT+IEOwklpnSaQiUSg3BJl43zr8n178ZIyOoIP7oROCpryNmAyscbAT2CTwRjeBv4SLhhh3YpEl9b2gEcw5MiP7QCKO0ke4mDL
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e2:b0:3a3:4221:b0d3 with SMTP id
 e9e14a558f8ab-3a3757c8506mr49126145ab.0.1728080249200; Fri, 04 Oct 2024
 15:17:29 -0700 (PDT)
Date: Fri, 04 Oct 2024 15:17:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67006979.050a0220.49194.04a6.GAE@google.com>
Subject: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (2)
From: syzbot <syzbot+eb75299195741149e159@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f66ebf37d69c Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15362b9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=eb75299195741149e159
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/50ac18fa9817/disk-f66ebf37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b6a34414ad4b/vmlinux-f66ebf37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b734c77ee7f0/bzImage-f66ebf37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb75299195741149e159@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc1-syzkaller-00131-gf66ebf37d69c #0 Not tainted
------------------------------------------------------
syz.2.718/8035 is trying to acquire lock:
ffff888055530768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
ffff888055530768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_change_mac+0xcc/0x11e0 net/mac80211/iface.c:309

but task is already holding lock:
ffff88807b14cd40 (team->team_lock_key#8){+.+.}-{3:3}, at: team_del_slave+0x32/0x1d0 drivers/net/team/team_core.c:1990

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (team->team_lock_key#8){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       team_port_change_check+0x51/0x1e0 drivers/net/team/team_core.c:2950
       team_device_event+0x161/0x5b0 drivers/net/team/team_core.c:2976
       notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
       call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
       call_netdevice_notifiers net/core/dev.c:2048 [inline]
       dev_close_many+0x33c/0x4c0 net/core/dev.c:1589
       unregister_netdevice_many_notify+0x530/0x1da0 net/core/dev.c:11377
       macvlan_device_event+0x7e0/0x870 drivers/net/macvlan.c:1830
       notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
       call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
       call_netdevice_notifiers net/core/dev.c:2048 [inline]
       unregister_netdevice_many_notify+0xedd/0x1da0 net/core/dev.c:11403
       unregister_netdevice_many net/core/dev.c:11465 [inline]
       unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11339
       unregister_netdevice include/linux/netdevice.h:3118 [inline]
       _cfg80211_unregister_wdev+0x162/0x560 net/wireless/core.c:1211
       ieee80211_if_remove+0x25d/0x3a0 net/mac80211/iface.c:2240
       ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:202
       rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
       cfg80211_remove_virtual_intf+0x23f/0x410 net/wireless/util.c:2875
       genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
       sock_sendmsg_nosec net/socket.c:729 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:744
       ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2602
       ___sys_sendmsg net/socket.c:2656 [inline]
       __sys_sendmsg+0x292/0x380 net/socket.c:2685
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&rdev->wiphy.mtx){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       wiphy_lock include/net/cfg80211.h:6014 [inline]
       ieee80211_change_mac+0xcc/0x11e0 net/mac80211/iface.c:309
       dev_set_mac_address+0x327/0x510 net/core/dev.c:9099
       bond_set_mac_address+0x28e/0x7f0 drivers/net/bonding/bond_main.c:4880
       dev_set_mac_address+0x327/0x510 net/core/dev.c:9099
       __set_port_dev_addr drivers/net/team/team_core.c:57 [inline]
       team_port_set_orig_dev_addr drivers/net/team/team_core.c:62 [inline]
       team_port_del+0xb08/0xcc0 drivers/net/team/team_core.c:1367
       team_del_slave+0x3d/0x1d0 drivers/net/team/team_core.c:1991
       do_set_master net/core/rtnetlink.c:2687 [inline]
       do_setlink+0xeff/0x41f0 net/core/rtnetlink.c:2907
       rtnl_group_changelink net/core/rtnetlink.c:3447 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3706 [inline]
       rtnl_newlink+0x1119/0x20a0 net/core/rtnetlink.c:3743
       rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
       sock_sendmsg_nosec net/socket.c:729 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:744
       ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2602
       ___sys_sendmsg net/socket.c:2656 [inline]
       __sys_sendmsg+0x292/0x380 net/socket.c:2685
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(team->team_lock_key#8);
                               lock(&rdev->wiphy.mtx);
                               lock(team->team_lock_key#8);
  lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

2 locks held by syz.2.718/8035:
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
 #1: ffff88807b14cd40 (team->team_lock_key#8){+.+.}-{3:3}, at: team_del_slave+0x32/0x1d0 drivers/net/team/team_core.c:1990

stack backtrace:
CPU: 0 UID: 0 PID: 8035 Comm: syz.2.718 Not tainted 6.12.0-rc1-syzkaller-00131-gf66ebf37d69c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 wiphy_lock include/net/cfg80211.h:6014 [inline]
 ieee80211_change_mac+0xcc/0x11e0 net/mac80211/iface.c:309
 dev_set_mac_address+0x327/0x510 net/core/dev.c:9099
 bond_set_mac_address+0x28e/0x7f0 drivers/net/bonding/bond_main.c:4880
 dev_set_mac_address+0x327/0x510 net/core/dev.c:9099
 __set_port_dev_addr drivers/net/team/team_core.c:57 [inline]
 team_port_set_orig_dev_addr drivers/net/team/team_core.c:62 [inline]
 team_port_del+0xb08/0xcc0 drivers/net/team/team_core.c:1367
 team_del_slave+0x3d/0x1d0 drivers/net/team/team_core.c:1991
 do_set_master net/core/rtnetlink.c:2687 [inline]
 do_setlink+0xeff/0x41f0 net/core/rtnetlink.c:2907
 rtnl_group_changelink net/core/rtnetlink.c:3447 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3706 [inline]
 rtnl_newlink+0x1119/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2602
 ___sys_sendmsg net/socket.c:2656 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2685
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f9977dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f9a4b4038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2f99936058 RCX: 00007f2f9977dff9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000005
RBP: 00007f2f997f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2f99936058 R15: 00007ffe9593e008
 </TASK>
team0: Port device bond0 removed
bond0: (slave wlan1): Releasing backup interface


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

