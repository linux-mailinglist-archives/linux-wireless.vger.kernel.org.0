Return-Path: <linux-wireless+bounces-17309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7EA08E4B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 11:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECEC188B640
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F520B21E;
	Fri, 10 Jan 2025 10:44:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7820B7F9
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505886; cv=none; b=nJBGP3SCwTSVGfA+dgco8ihKjvnZm4BGhNWfaa5vs5vhIQ6xIVzBVbhmp2ySOEYa0mkkFa09uknfHIT7f+4a93D1lNGjd7joyS+yFSSSuZv+e9EmJTI8sMX1aSmzDvDvoh9zb0Jb0Qm/S1Dvm43MOBegV5mnuevil9wTKAGKxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505886; c=relaxed/simple;
	bh=fAywN9JR9RkB3Q9gsJRGBB5Y2HD63KK3rAC+MQR+eWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz3Td2YAKmULXf267kGvtB065eJY93Tpld3hHOTsPY9P/5MQWOCshBcgmjsY8idi2MFoINoNOqx2gQQTyMeWOS1+fCG/f8zyTbBtFW1aokj+J9TXq9sjlxFNb5CmRVNemiWMnQj8YKTfZ1mP4PMzp6elW+PkP1IHm9sVbatBqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.175])
	by sina.com (10.185.250.24) with ESMTP
	id 6780FA0F00006E07; Fri, 10 Jan 2025 18:44:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 30181110748239
X-SMAIL-UIID: AEB5F3D408274DA4B252A861A95123D5-20250110-184434-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+46333818c68be52ea582@syzkaller.appspotmail.com>
Cc: johannes@sipsolutions.net,
	Boqun Feng <boqun.feng@gmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_open (2)
Date: Fri, 10 Jan 2025 18:44:20 +0800
Message-ID: <20250110104421.1573-1-hdanton@sina.com>
In-Reply-To: <6780271b.050a0220.25a300.01cc.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 09 Jan 2025 11:44:27 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7bf1659bad4e Merge branch 'intel-wired-lan-driver-updates-..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ce01df980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=289acde585746aad
> dashboard link: https://syzkaller.appspot.com/bug?extid=46333818c68be52ea582
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/693d5bc84a0c/disk-7bf1659b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c4b933843740/vmlinux-7bf1659b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/16516f68ca10/bzImage-7bf1659b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+46333818c68be52ea582@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.13.0-rc5-syzkaller-00872-g7bf1659bad4e #0 Not tainted
> ------------------------------------------------------
> syz.2.799/9769 is trying to acquire lock:
> ffff888027368768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6034 [inline]
> ffff888027368768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_open+0xe9/0x1e0 net/mac80211/iface.c:445
> 
> but task is already holding lock:
> ffff88805d318e00 (team->team_lock_key#4){+.+.}-{4:4}, at: team_add_slave+0xb0/0x2730 drivers/net/team/team_core.c:1987
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (team->team_lock_key#4){+.+.}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
>        team_port_change_check+0x51/0x1e0 drivers/net/team/team_core.c:2961
>        team_device_event+0x161/0x5b0 drivers/net/team/team_core.c:2987
>        notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>        call_netdevice_notifiers_extack net/core/dev.c:2051 [inline]
>        call_netdevice_notifiers net/core/dev.c:2065 [inline]
>        dev_close_many+0x33c/0x4c0 net/core/dev.c:1589
>        unregister_netdevice_many_notify+0x530/0x1da0 net/core/dev.c:11523
>        vlan_device_event+0x1da7/0x1de0 net/8021q/vlan.c:489
>        notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>        call_netdevice_notifiers_extack net/core/dev.c:2051 [inline]
>        call_netdevice_notifiers net/core/dev.c:2065 [inline]
>        unregister_netdevice_many_notify+0xedd/0x1da0 net/core/dev.c:11549
>        unregister_netdevice_many net/core/dev.c:11613 [inline]
>        unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11485
>        unregister_netdevice include/linux/netdevice.h:3236 [inline]
>        _cfg80211_unregister_wdev+0x163/0x590 net/wireless/core.c:1251
>        ieee80211_if_remove+0x25d/0x3a0 net/mac80211/iface.c:2241

Given ASSERT_RTNL() [1], this report is false positive.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/mac80211/iface.c?id=7bf1659bad4e#n2229

And there are similar reports.

[2] Subject: [syzbot] [net?] possible deadlock in team_del_slave (3)
https://yhbt.net/lore/lkml/000000000000ffc5d80616fea23d@google.com/

[3] Subject: [syzbot] [wireless?] possible deadlock in cfg80211_netdev_notifier_call (3)
https://yhbt.net/lore/lkml/0000000000004ec486061b057b6a@google.com/

[4] Subject: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (2)
https://yhbt.net/lore/lkml/67006979.050a0220.49194.04a6.GAE@google.com/

>        ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:225
>        rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
>        cfg80211_remove_virtual_intf+0x23f/0x410 net/wireless/util.c:2871
>        genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>        genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>        genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
>        netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>        netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>        netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
>        netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
>        sock_sendmsg_nosec net/socket.c:711 [inline]
>        __sock_sendmsg+0x221/0x270 net/socket.c:726
>        ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2594
>        ___sys_sendmsg net/socket.c:2648 [inline]
>        __sys_sendmsg+0x269/0x350 net/socket.c:2680
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
>        class_wiphy_constructor include/net/cfg80211.h:6034 [inline]
>        ieee80211_open+0xe9/0x1e0 net/mac80211/iface.c:445
>        __dev_open+0x2d3/0x450 net/core/dev.c:1476
>        dev_open+0xae/0x1b0 net/core/dev.c:1512
>        team_port_add drivers/net/team/team_core.c:1229 [inline]
>        team_add_slave+0x9af/0x2730 drivers/net/team/team_core.c:1988
>        do_set_master net/core/rtnetlink.c:2926 [inline]
>        do_setlink+0xe40/0x4210 net/core/rtnetlink.c:3125
>        rtnl_changelink net/core/rtnetlink.c:3732 [inline]
>        __rtnl_newlink net/core/rtnetlink.c:3884 [inline]
>        rtnl_newlink+0x1bb6/0x2210 net/core/rtnetlink.c:4021
>        rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6911
>        netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
>        netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>        netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
>        netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
>        sock_sendmsg_nosec net/socket.c:711 [inline]
>        __sock_sendmsg+0x221/0x270 net/socket.c:726
>        ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2594
>        ___sys_sendmsg net/socket.c:2648 [inline]
>        __sys_sendmsg+0x269/0x350 net/socket.c:2680
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(team->team_lock_key#4);
>                                lock(&rdev->wiphy.mtx);
>                                lock(team->team_lock_key#4);
>   lock(&rdev->wiphy.mtx);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz.2.799/9769:
>  #0: ffffffff8fcb3d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>  #0: ffffffff8fcb3d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:335 [inline]
>  #0: ffffffff8fcb3d08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xce2/0x2210 net/core/rtnetlink.c:4020
>  #1: ffff88805d318e00 (team->team_lock_key#4){+.+.}-{4:4}, at: team_add_slave+0xb0/0x2730 drivers/net/team/team_core.c:1987
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 9769 Comm: syz.2.799 Not tainted 6.13.0-rc5-syzkaller-00872-g7bf1659bad4e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
>  check_prev_add kernel/locking/lockdep.c:3161 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
>  class_wiphy_constructor include/net/cfg80211.h:6034 [inline]
>  ieee80211_open+0xe9/0x1e0 net/mac80211/iface.c:445
>  __dev_open+0x2d3/0x450 net/core/dev.c:1476
>  dev_open+0xae/0x1b0 net/core/dev.c:1512
>  team_port_add drivers/net/team/team_core.c:1229 [inline]
>  team_add_slave+0x9af/0x2730 drivers/net/team/team_core.c:1988
>  do_set_master net/core/rtnetlink.c:2926 [inline]
>  do_setlink+0xe40/0x4210 net/core/rtnetlink.c:3125
>  rtnl_changelink net/core/rtnetlink.c:3732 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3884 [inline]
>  rtnl_newlink+0x1bb6/0x2210 net/core/rtnetlink.c:4021
>  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6911
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
>  netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:726
>  ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2594
>  ___sys_sendmsg net/socket.c:2648 [inline]
>  __sys_sendmsg+0x269/0x350 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa6a0385d29
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fa6a110b038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fa6a0575fa0 RCX: 00007fa6a0385d29
> RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 00007fa6a0401b08 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fa6a0575fa0 R15: 00007ffd96cc09f8
>  </TASK>
> team0: Port device wlan1 added
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

