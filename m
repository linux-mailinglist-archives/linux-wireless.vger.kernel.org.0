Return-Path: <linux-wireless+bounces-29082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C8C68723
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7D76F2A5CA
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960AE30FC03;
	Tue, 18 Nov 2025 09:12:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB730F551
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457148; cv=none; b=uQGODKtdkQfAQj0URkcaibb4HYdpUkjMdOOLfrKzOLE96sXl10wsStNNo3epHMikJaNjpN9LFCRRFWZI/N2O3np4Kq67ORKHszpD3UU3EAmleGib4IseFghgyX95veTdBtJOXmzhDRLqkjp9GuADN1sPuuMKHHOPZOMiqAUf/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457148; c=relaxed/simple;
	bh=RMHiKfDDZRF4XKtK3FvegO8GyEZ0WcrzD9nGISsyTbI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QgklhtOuKEb/b0MiFwGJazKPUnAtvWdp6jiJIOrhnUOra+bFKJH4497O/GUcrB857xIEZ1/Pb2a2BpEUmgOf8Z2g9/9jRqx3oD0YI/j2qMcKMhGO1IfJ58gyALF3Q8aQ4pX/4h/BA9fzdLPHZMkCy7DDZSPVkDrgLQVBvl+oMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-432f8352633so99962775ab.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 01:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763457144; x=1764061944;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCPCBiDseJTYHAymJetqpym/2ftXtJI5iOpKOSwwOu8=;
        b=JbE1xeQeOQNRiJR7OTMZh3ErdYS5pRDCjg6GVKJcUnhQSmjWok/04nCdFCxR/5Tw6I
         GiW18qt9fGO3QNfor8dlrHHeG6AgdHAExLUqMdLErAqE10Mvh2dVwQu9PvX2IYGTSBBp
         Q3FqYAoaq0a1VTWzXyDW2w5IY4AAv9EFLVLMiNs6WBqz2u+HYNO+mVQXcej8II8w1Ge/
         lwdFpeYjEvkmNmVZM3xbkYEJmFq53RSwtrqmO0F8emG1FjOlBRheMVEMYZ/lZ/UV5cN0
         g/GtHv91shWrK13hsTqgkA4fHp5uoSewcKqPsiY++tlJ3FDvXL6pLZbbSPn4YJMyyldF
         htFg==
X-Forwarded-Encrypted: i=1; AJvYcCUo50+btJZHR9ZWhwfiuDGXRTMRwi7vXM0pxP0zY5k4B467b2yoDnKJhelqZZxgFi54Kyn4hH8x8Q92VKQ7hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPn+yol8s+ezWLGvAb7Y7F2Q8UeOYEtUVBT30x6XUvEE5vO9c6
	yJkw0iw/Wc/5VZ6oeMC0HvDQmLWTmFt0jw8cc9Ki5NdV96X3xKxkMHuW79SSfqXrpiTUdfQmqqS
	SCR4k0QxBwqzG2vCCo5Kk1pyjJT13bZdEs4Pn5pMcNmcTFRdYqaiRXUtJJVg=
X-Google-Smtp-Source: AGHT+IHbXwBOmPJLm6wPLuoglDX5/xd6oe773wnP4kFD6s8nnbvi1P7vk4tk6PUBU6UeysoSGSqlg9jn7cKoVjP7wvVISevaja92
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b44:b0:433:79a7:8158 with SMTP id
 e9e14a558f8ab-4348c9334c1mr166286595ab.27.1763457144310; Tue, 18 Nov 2025
 01:12:24 -0800 (PST)
Date: Tue, 18 Nov 2025 01:12:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691c3878.a70a0220.3124cb.00b9.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING: suspicious RCU usage in
 ieee80211_mesh_csa_beacon (2)
From: syzbot <syzbot+b59873f5699e941717ca@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a0892d2836e Merge tag 'pci-v6.18-fixes-5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1100a212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=b59873f5699e941717ca
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12656884580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15519212580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-7a0892d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a78c5c2efd8d/vmlinux-7a0892d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a51cc5df960/bzImage-7a0892d2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b59873f5699e941717ca@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f4e229e5fa0 R14: 00007f4e229e5fa0 R15: 0000000000000003
 </TASK>
=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
net/mac80211/mesh.c:1571 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz.0.17/5477:
 #0: ffffffff8f333750 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffff888059ba0788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: wiphy_lock include/net/cfg80211.h:6343 [inline]
 #1: ffff888059ba0788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: nl80211_pre_doit+0x281/0x930 net/wireless/nl80211.c:17999

stack backtrace:
CPU: 0 UID: 0 PID: 5477 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6876
 ieee80211_mesh_csa_beacon+0x280/0x2c0 net/mac80211/mesh.c:1571
 ieee80211_set_csa_beacon+0x3cc/0x9a0 net/mac80211/cfg.c:4288
 __ieee80211_channel_switch net/mac80211/cfg.c:4406 [inline]
 ieee80211_channel_switch+0x8ef/0xcb0 net/mac80211/cfg.c:4442
 rdev_channel_switch+0x108/0x290 net/wireless/rdev-ops.h:1116
 nl80211_channel_switch+0xac9/0xd70 net/wireless/nl80211.c:11475
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
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e2278f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe9e0535c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4e229e5fa0 RCX: 00007f4e2278f6c9
RDX: 0000000000000000 RSI: 0000200000004180 RDI: 0000000000000003
RBP: 00007ffe9e053620 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f4e229e5fa0 R14: 00007f4e229e5fa0 R15: 0000000000000003
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

