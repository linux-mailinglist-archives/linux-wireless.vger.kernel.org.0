Return-Path: <linux-wireless+bounces-9027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1AD909EE2
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 19:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B8B1C21FED
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6562B3BB59;
	Sun, 16 Jun 2024 17:50:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA829CE1
	for <linux-wireless@vger.kernel.org>; Sun, 16 Jun 2024 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718560220; cv=none; b=O2qrbJfyJstIv3OmjAs0LNI7Ii8nJzQ2LCElLIPK+E/29TVdZlmUOOJm5kFYsQHmBZyDhi7vUIHUvMyN7baq9+xlcnPaCMvZya+HE3nUQJ7ucwtl6fyETEw3pAS+P7C+B1Hz4kxDSDtPu9vT6ffPzEGtEqLaPuXYCywgmWd3w+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718560220; c=relaxed/simple;
	bh=mDFcIigDqb8DaS/nDVhERQSJRcViPXmh8SQPYgHCsdg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iINI78y1nVcSyb2LLZaB3tzZHBYElVew3YdwjJDCwCRRLR/f7XYGmkH3YghAiw0nqX5FH1Lv6HmqKDOH+KXaMxVYWN2mGC5yZEaxk74kC24Na42dOGTeG5F3N8bWX3pwzBcBfMSLnG4TpvmJHsSf4Dfp2P4Fh3ZhcVnA1txpqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-375cbe701a7so42371305ab.1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jun 2024 10:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718560218; x=1719165018;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5l6Gk/U6nBX/WXMiUyz63MwqInMsTWLMNNrPIc9rQA=;
        b=rNewPO6Dvu/eLLxTgoeFHlG2qQHNabyX6ZQnPwK/mxhZN0qO9Oio7xRxM702sYddmX
         JkfICybYOkgAiEyuP1XRQagsaBsoC+si9ZKCxTIiNUyRJOXhiUkzVxn3Vygr6Nrimgjx
         +HxD4edA52z4elmJP7CfI9dEVwgBamXxxu3aDS87h6tvQJ0zEJ5l1zjemjE8D2LgKeFG
         hCGi2hbAf/gIQGaBraFaEe129MWutf8SMw5BQw+m5kaiANiDKG8Pr6wUtqyg6nwrOa+4
         rxnuxzs5xUK9U1iHl7J7uX0KQ5aaIN9MPQFFV/ROLqyH6IIwqQzKhZcFCBBPzxWlQv1G
         EZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCVAwe4tBt2r+Y+vLpmzWd5sWo0akBl9ghRY5oYf0h/OMS/AN+TK5TvXdIWFbXKPyQbb1cGd8yoYLairI3ClbZ0Ur/qw3N7G6cNsFaCU/Tg=
X-Gm-Message-State: AOJu0YyEEhlkITQnVOZxtXtb/STP4qApwkjuyvASRfVrTmU/5uUj07zs
	Yo34tfqzWXecSkZtmgFwroM05MuyLUMzKuZJth/JVz64Lp7fPlU4q0Y1JfRMgbYJsJRje2aHUkS
	qVFeGYiJ7JO7CzJ3j6ufjc0QQnioB5XMrpVSnBJw8AiznqwJ3BUtpwQQ=
X-Google-Smtp-Source: AGHT+IGSJcCXVT39JtBxfUI9OzJjtZ8mAOCqVyrF5IlzWq6B1RxXereFl8lhTcl/RQeBEuDRWN/8atjFgq+OM+T5s5jQmMEA5rVy
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-375e10b26a4mr3654025ab.6.1718560217805; Sun, 16 Jun 2024
 10:50:17 -0700 (PDT)
Date: Sun, 16 Jun 2024 10:50:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ec486061b057b6a@google.com>
Subject: [syzbot] [wireless?] possible deadlock in cfg80211_netdev_notifier_call
 (3)
From: syzbot <syzbot+61f0f147bbf185cfa088@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    45403b12c29c ip_tunnel: Move stats allocation to core
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d7ab6a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce6b8d38d53fa4e
dashboard link: https://syzkaller.appspot.com/bug?extid=61f0f147bbf185cfa088
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08e0ccb0d0c7/disk-45403b12.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8c2fb69ea08/vmlinux-45403b12.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f665a6962ffc/bzImage-45403b12.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61f0f147bbf185cfa088@syzkaller.appspotmail.com

netlink: 'syz-executor.4': attribute type 10 has an invalid length.
netlink: 55 bytes leftover after parsing attributes in process `syz-executor.4'.
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc2-syzkaller-00724-g45403b12c29c #0 Not tainted
------------------------------------------------------
syz-executor.4/22580 is trying to acquire lock:
ffff888022b62768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5966 [inline]
ffff888022b62768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_netdev_notifier_call+0x308/0x1490 net/wireless/core.c:1529

but task is already holding lock:
ffff88805dedcd20 (team->team_lock_key#10){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team_core.c:1975

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (team->team_lock_key#10){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       team_port_change_check+0x51/0x1e0 drivers/net/team/team_core.c:2950
       team_device_event+0x161/0x5b0 drivers/net/team/team_core.c:2976
       notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
       call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
       call_netdevice_notifiers net/core/dev.c:2044 [inline]
       dev_close_many+0x33c/0x4c0 net/core/dev.c:1585
       unregister_netdevice_many_notify+0x544/0x16b0 net/core/dev.c:11194
       macvlan_device_event+0x7e0/0x870 drivers/net/macvlan.c:1828
       notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
       call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
       call_netdevice_notifiers net/core/dev.c:2044 [inline]
       unregister_netdevice_many_notify+0xd75/0x16b0 net/core/dev.c:11219
       unregister_netdevice_many net/core/dev.c:11277 [inline]
       unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11156
       unregister_netdevice include/linux/netdevice.h:3119 [inline]
       _cfg80211_unregister_wdev+0x162/0x560 net/wireless/core.c:1211
       ieee80211_if_remove+0x25d/0x3a0 net/mac80211/iface.c:2249
       ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:202
       rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
       cfg80211_remove_virtual_intf+0x23f/0x410 net/wireless/util.c:2852
       genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1901
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
       ___sys_sendmsg net/socket.c:2639 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&rdev->wiphy.mtx){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       wiphy_lock include/net/cfg80211.h:5966 [inline]
       cfg80211_netdev_notifier_call+0x308/0x1490 net/wireless/core.c:1529
       notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
       call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
       call_netdevice_notifiers net/core/dev.c:2044 [inline]
       dev_open+0x13a/0x1b0 net/core/dev.c:1513
       team_port_add drivers/net/team/team_core.c:1216 [inline]
       team_add_slave+0x9b3/0x2750 drivers/net/team/team_core.c:1976
       do_set_master net/core/rtnetlink.c:2701 [inline]
       do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2907
       __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
       rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743
       rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6641
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1901
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
       ___sys_sendmsg net/socket.c:2639 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(team->team_lock_key#10);
                               lock(&rdev->wiphy.mtx);
                               lock(team->team_lock_key#10);
  lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

2 locks held by syz-executor.4/22580:
 #0: ffffffff8f5e74c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f5e74c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6638
 #1: ffff88805dedcd20 (team->team_lock_key#10){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team_core.c:1975

stack backtrace:
CPU: 0 PID: 22580 Comm: syz-executor.4 Not tainted 6.10.0-rc2-syzkaller-00724-g45403b12c29c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 wiphy_lock include/net/cfg80211.h:5966 [inline]
 cfg80211_netdev_notifier_call+0x308/0x1490 net/wireless/core.c:1529
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 dev_open+0x13a/0x1b0 net/core/dev.c:1513
 team_port_add drivers/net/team/team_core.c:1216 [inline]
 team_add_slave+0x9b3/0x2750 drivers/net/team/team_core.c:1976
 do_set_master net/core/rtnetlink.c:2701 [inline]
 do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2907
 __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
 rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6641
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7bb4c7cea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7bb5a0e0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7bb4db3f80 RCX: 00007f7bb4c7cea9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00007f7bb4cebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000004d R14: 00007f7bb4db3f80 R15: 00007ffec3e770f8
 </TASK>
team0: Port device virt_wifi0 added


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

