Return-Path: <linux-wireless+bounces-20459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B200A65EAC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 21:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0534C3AB02F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF91DE8A7;
	Mon, 17 Mar 2025 20:04:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D5158A09
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241870; cv=none; b=YOk9GUajaXNGybjqWuO/VR1aQcfqNhEqAA0jVIs+ic2Tn0ZvEqKedw75d2BQR8dFwcEzXSSc6L2Yy81AovrDlbrvzDuRPYkJh6ymfCOoh55lIhxO7+n/TphJsqwuI8YGcCI3OQrEG2f4whg/Q1MyzY9CqzW0atheEfhQrsOo/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241870; c=relaxed/simple;
	bh=zDiqGRosoV+/3ssgCGb2SGIWovWyXkTfd75EIs4R0Yo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NPawLPMMGcqQaerwOTtFpjFjO6fjh265ERMsptgR6phy77ujp62nxEa1Dyhxqnwtm2Eb8wcsUrx1qJMCrAd/EDrs6yUSdIlUjhTFke+Rd7SR0ivgAwkUgnIgzn0xBeQF1/x+Qq6ahIuC9MmB3Sdodoqe3FteBij6ZyqkObrEqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85db4460f5dso889095639f.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 13:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742241868; x=1742846668;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StTuGp4t5HsXJ4jfpO7DyuaszrNM9Zr0lwk+MnOE5aA=;
        b=b087NmJ6zEyQfQxeIiYt90ELW6VJ5fDHrVfotIX4NJAkm6XllsgyYIu94CRrQ7C6nK
         OBuom+/aC48abpkez3eL7hQ5WHmADrS/81wLFZUA2BvaD4RevvKlPvD1A6BuU2upfcoc
         2h/GJUFr0hDliMip3Wl2yx8ONQBe8DHAUDit+aWmCnLou3C9+qBvI8jEalhLYQ+xVHzP
         LWPNGdgG2Mqj7tt4vaXJzAkHawQOz73voANQjTdfl0IWLwfxNSci0SAURUwZYIDNitN7
         knvcwYwjtAXD1POZXoy47kpo8fwB4vy573zPZPHzjDGr+VuliAYbwevYf+vrithjaPN1
         wA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzGXE5l4EPjSDbyr0lSb0MxyN420FzTR5bCx3gD5FqMPKegubSfLC4JveOpR4AGt4MBsRLZNSB5DwOZV4Qdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEGxVWgG3ReXmtbqYEiSKAbLKSBOUiW1xbBurywICX2qM1S/g
	dhSqVX3FiaYCxtZGZ/7SuJtEu9shYNdHQ49cxIZiTjKB/ial9wK5P3mL2cyUihbgLuVWX6tDL0C
	EQ9+5kFGryvfGPfpvMwTDzLKjKLIJhAFVEt1MkackoS6nNBVXNVpoYrE=
X-Google-Smtp-Source: AGHT+IGeF15yKLNNo1r8a8INaqF6xkYgfxfTQUNCS6v3ZgwGxHAJepaofrIpUvF9xjWF8HtBe5dVBrxfEzvhODoYQitLfeZnQdYv
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8e:b0:3cf:bb6e:3065 with SMTP id
 e9e14a558f8ab-3d48397f585mr130592785ab.0.1742241867792; Mon, 17 Mar 2025
 13:04:27 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:04:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d8804b.050a0220.2ca2c6.006b.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: trying to register non-static key in cfg80211_dev_free
From: syzbot <syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4003c9e78778 Merge tag 'net-6.14-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1763e04c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=317038cbd53153e8
dashboard link: https://syzkaller.appspot.com/bug?extid=aaf0488c83d1d5f4f029
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c5ddb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d2b03f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4003c9e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce870bfb8bac/vmlinux-4003c9e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/195015b7ce43/bzImage-4003c9e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com

RBP: 0000000000000001 R08: 00007ffc330c8967 R09: 000055557c17e4c0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000004
R13: 00007fb851c063fc R14: 00007fb851bd6334 R15: 00007fb851c063e4
 </TASK>
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 5935 Comm: syz-executor550 Not tainted 6.14.0-rc6-syzkaller-00103-g4003c9e78778 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 assign_lock_key kernel/locking/lockdep.c:983 [inline]
 register_lock_class+0xc39/0x1240 kernel/locking/lockdep.c:1297
 __lock_acquire+0x135/0x3c40 kernel/locking/lockdep.c:5103
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 cfg80211_dev_free+0x30/0x3d0 net/wireless/core.c:1196
 device_release+0xa1/0x240 drivers/base/core.c:2568
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3774
 wiphy_free net/wireless/core.c:1224 [inline]
 wiphy_new_nm+0x1c1f/0x2160 net/wireless/core.c:562
 ieee80211_alloc_hw_nm+0x1b7a/0x2260 net/mac80211/main.c:835
 mac80211_hwsim_new_radio+0x1d6/0x54e0 drivers/net/wireless/virtual/mac80211_hwsim.c:5185
 hwsim_new_radio_nl+0xb42/0x12b0 drivers/net/wireless/virtual/mac80211_hwsim.c:6242
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2533
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
 __sys_sendmsg+0x16e/0x220 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb851b909e9
Code: 48 83 c4 28 c3 e8 c7 1b 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc330c8bc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffc330c8c20 RCX: 00007fb851b909e9
RDX: 0000000020000000 RSI: 0000400000000140 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffc330c8967 R09: 000055557c17e4c0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000004
R13: 00007fb851c063fc R14: 00007fb851bd6334 R15: 00007fb851c063e4
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5935 at net/wireless/core.c:1197 cfg80211_dev_free+0x2e7/0x3d0 net/wireless/core.c:1197
Modules linked in:
CPU: 0 UID: 0 PID: 5935 Comm: syz-executor550 Not tainted 6.14.0-rc6-syzkaller-00103-g4003c9e78778 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:cfg80211_dev_free+0x2e7/0x3d0 net/wireless/core.c:1197
Code: 00 00 49 8b bd e0 08 00 00 e8 85 7a 69 f7 4c 89 ef 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 6f 7a 69 f7 e8 8a 0c 11 f7 90 <0f> 0b 90 e9 6f fd ff ff 4c 89 f7 e8 b9 2b 74 f7 e9 aa fe ff ff 4c
RSP: 0018:ffffc90003e371b8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000293 RCX: ffffffff81972d2d
RDX: ffff88802721c880 RSI: ffffffff8aa8e456 RDI: ffffc90003e37128
RBP: ffff8880121b06a8 R08: 0000000000000001 R09: fffff520007c6e25
R10: 0000000000000003 R11: 0000000000000001 R12: ffff8880121b06b8
R13: ffff8880121b0000 R14: ffff8881050d1b80 R15: 0000000000000000
FS:  000055557c17d380(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000001ac0 CR3: 00000000122c0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 device_release+0xa1/0x240 drivers/base/core.c:2568
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3774
 wiphy_free net/wireless/core.c:1224 [inline]
 wiphy_new_nm+0x1c1f/0x2160 net/wireless/core.c:562
 ieee80211_alloc_hw_nm+0x1b7a/0x2260 net/mac80211/main.c:835
 mac80211_hwsim_new_radio+0x1d6/0x54e0 drivers/net/wireless/virtual/mac80211_hwsim.c:5185
 hwsim_new_radio_nl+0xb42/0x12b0 drivers/net/wireless/virtual/mac80211_hwsim.c:6242
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2533
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
 __sys_sendmsg+0x16e/0x220 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb851b909e9
Code: 48 83 c4 28 c3 e8 c7 1b 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc330c8bc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffc330c8c20 RCX: 00007fb851b909e9
RDX: 0000000020000000 RSI: 0000400000000140 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffc330c8967 R09: 000055557c17e4c0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000004
R13: 00007fb851c063fc R14: 00007fb851bd6334 R15: 00007fb851c063e4
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

