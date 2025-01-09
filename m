Return-Path: <linux-wireless+bounces-17264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696EA080BA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 20:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BAA7A215D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF881F4E4A;
	Thu,  9 Jan 2025 19:44:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594C84039
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451870; cv=none; b=nLJ0yW4bDi/rUc9lMYmRBALBuOC2kxRnvKptnn5avOu8WvPEEd0/xp1W2UawPJxF+SGlLA/6yXEGFCY2QpuaaqNzuxvXIdVflhEe23cY17JncrLIz24b9/BX3l0b6ivV7UbJZWjblsYaU7+Sta7MCqRqUoHftcxZV4zfn371Jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451870; c=relaxed/simple;
	bh=oJZPDiYalCpb7iwLRHcZmf553T/VxZkzU9f2KUyIbp0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KnUX9eDrJKh6SDQznsJUQ1TZtX2vbjTKMOLc7QvkCYdNBaHIEQT8VC2AC6ygwkTZKS2a+BfVIshn4LySFDMLMgCEKhnWs4nYDNXdtVeJvESk8k5t1OUBJf6hJqVLULzRwOT+/yQb3ZMZfj7Q2D49iqDz3/sLtR+K7hqcM8/Oqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a814406be9so20810795ab.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 11:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736451867; x=1737056667;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQVEfkJkNawjKWX1GCAVZMisWmPHNWruAFr+zCw+Elg=;
        b=bIr8nTd3nYNNtx7nhsr3FjKY+Nr7FSpuDvq6Dvd7+mkAA+s/+LTwxi1/CnUdBV3h7W
         aHRpT0J0AD76J/6gBfvAOCfPEus+ClP2GlYzTwzZwpl2iFTdDBeu+cd3RTNCwXwRcDE8
         xIh4lrUIn+IPWmMAxRnt/6kTFMPiyupOu3QUW+joEDZGSS1I2Rn5XxsebbcwITS7f0u5
         R7IFS8mfyDr/XPgb4mqGipnOz44b+Ho/4u+rjNAY/5B5mz+Um+jSq4/NFaCbyD9wDFka
         CABHwu2Pi5Od4rgDR7qt/gzIj+lx7+kFdWRgVEue+HevwBffDc95byEXjvJL0E8dJMk2
         Uf0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoW6akJ7QH74iDYbLB08xbQCA4uCBagamQ1vOYFwRRIhaTgpNgVqFgFP8gukdQ2NzYaEM2XKeEKbp2CdafmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweeIfxO74irW4s9klgDMyvZBRZuQReWZF9tB5WG9JtxACmXOIu
	OUC6WAyCqUXnZRiR1QIheSRq4dl86A2ejBjQFo8XX2ViH3gb8kxDh2rsdTUDlCcZEawPFj9W1FK
	Tx9WhMdqrTzbdmsUQAV/N448TplWRFxBXmoRYGl1FzFUNbhRsIcoqSPY=
X-Google-Smtp-Source: AGHT+IFgK8tpj/3SvOoZkpRn7/dpIAzhaqYr1957naph3SpbmXv7YaejFquENSGASFp8zDPkVWI+cYemTcWuKIG+bMMtWY9HA39s
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a2:b0:3a7:e732:472a with SMTP id
 e9e14a558f8ab-3ce3a9a4ac6mr63975635ab.2.1736451867525; Thu, 09 Jan 2025
 11:44:27 -0800 (PST)
Date: Thu, 09 Jan 2025 11:44:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6780271b.050a0220.25a300.01cc.GAE@google.com>
Subject: [syzbot] [wireless?] possible deadlock in ieee80211_open (2)
From: syzbot <syzbot+46333818c68be52ea582@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7bf1659bad4e Merge branch 'intel-wired-lan-driver-updates-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ce01df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=289acde585746aad
dashboard link: https://syzkaller.appspot.com/bug?extid=46333818c68be52ea582
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/693d5bc84a0c/disk-7bf1659b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4b933843740/vmlinux-7bf1659b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16516f68ca10/bzImage-7bf1659b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46333818c68be52ea582@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc5-syzkaller-00872-g7bf1659bad4e #0 Not tainted
------------------------------------------------------
syz.2.799/9769 is trying to acquire lock:
ffff888027368768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6034 [inline]
ffff888027368768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_open+0xe9/0x1e0 net/mac80211/iface.c:445

but task is already holding lock:
ffff88805d318e00 (team->team_lock_key#4){+.+.}-{4:4}, at: team_add_slave+0xb0/0x2730 drivers/net/team/team_core.c:1987

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (team->team_lock_key#4){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       team_port_change_check+0x51/0x1e0 drivers/net/team/team_core.c:2961
       team_device_event+0x161/0x5b0 drivers/net/team/team_core.c:2987
       notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2051 [inline]
       call_netdevice_notifiers net/core/dev.c:2065 [inline]
       dev_close_many+0x33c/0x4c0 net/core/dev.c:1589
       unregister_netdevice_many_notify+0x530/0x1da0 net/core/dev.c:11523
       vlan_device_event+0x1da7/0x1de0 net/8021q/vlan.c:489
       notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2051 [inline]
       call_netdevice_notifiers net/core/dev.c:2065 [inline]
       unregister_netdevice_many_notify+0xedd/0x1da0 net/core/dev.c:11549
       unregister_netdevice_many net/core/dev.c:11613 [inline]
       unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11485
       unregister_netdevice include/linux/netdevice.h:3236 [inline]
       _cfg80211_unregister_wdev+0x163/0x590 net/wireless/core.c:1251
       ieee80211_if_remove+0x25d/0x3a0 net/mac80211/iface.c:2241
       ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:225
       rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
       cfg80211_remove_virtual_intf+0x23f/0x410 net/wireless/util.c:2871
       genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
       netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
       netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:726
       ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2594
       ___sys_sendmsg net/socket.c:2648 [inline]
       __sys_sendmsg+0x269/0x350 net/socket.c:2680
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       class_wiphy_constructor include/net/cfg80211.h:6034 [inline]
       ieee80211_open+0xe9/0x1e0 net/mac80211/iface.c:445
       __dev_open+0x2d3/0x450 net/core/dev.c:1476
       dev_open+0xae/0x1b0 net/core/dev.c:1512
       team_port_add drivers/net/team/team_core.c:1229 [inline]
       team_add_slave+0x9af/0x2730 drivers/net/team/team_core.c:1988
       do_set_master net/core/rtnetlink.c:2926 [inline]
       do_setlink+0xe40/0x4210 net/core/rtnetlink.c:3125
       rtnl_changelink net/core/rtnetlink.c:3732 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3884 [inline]
       rtnl_newlink+0x1bb6/0x2210 net/core/rtnetlink.c:4021
       rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6911
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
       netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
       netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
       netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:726
       ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2594
       ___sys_sendmsg net/socket.c:2648 [inline]
       __sys_sendmsg+0x269/0x350 net/socket.c:2680
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(team->team_lock_key#4);
                               lock(&rdev->wiphy.mtx);
                               lock(team->team_lock_key#4);
  lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

2 locks held by syz.2.799/9769:
 #0: ffffffff8fcb3d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcb3d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:335 [inline]
 #0: ffffffff8fcb3d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xce2/0x2210 net/core/rtnetlink.c:4020
 #1: ffff88805d318e00 (team->team_lock_key#4){+.+.}-{4:4}, at: team_add_slave+0xb0/0x2730 drivers/net/team/team_core.c:1987

stack backtrace:
CPU: 0 UID: 0 PID: 9769 Comm: syz.2.799 Not tainted 6.13.0-rc5-syzkaller-00872-g7bf1659bad4e #0
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
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 class_wiphy_constructor include/net/cfg80211.h:6034 [inline]
 ieee80211_open+0xe9/0x1e0 net/mac80211/iface.c:445
 __dev_open+0x2d3/0x450 net/core/dev.c:1476
 dev_open+0xae/0x1b0 net/core/dev.c:1512
 team_port_add drivers/net/team/team_core.c:1229 [inline]
 team_add_slave+0x9af/0x2730 drivers/net/team/team_core.c:1988
 do_set_master net/core/rtnetlink.c:2926 [inline]
 do_setlink+0xe40/0x4210 net/core/rtnetlink.c:3125
 rtnl_changelink net/core/rtnetlink.c:3732 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3884 [inline]
 rtnl_newlink+0x1bb6/0x2210 net/core/rtnetlink.c:4021
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6911
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2594
 ___sys_sendmsg net/socket.c:2648 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa6a0385d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa6a110b038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fa6a0575fa0 RCX: 00007fa6a0385d29
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007fa6a0401b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa6a0575fa0 R15: 00007ffd96cc09f8
 </TASK>
team0: Port device wlan1 added


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

