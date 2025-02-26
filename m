Return-Path: <linux-wireless+bounces-19484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80037A46079
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 14:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE913A5203
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842021B192;
	Wed, 26 Feb 2025 13:14:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C642A8B
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575695; cv=none; b=XNjgO4P14TKWhsBHaKDF1t47MtA2ZftptswIBOke2IrCKc03U3We1wBIKYQWYND7OpH8VPxwpOzqNzkTIi0GEwoX2lXYgRdEGJ/jDO2VMMHhBF5NZFm29EW/gTx5mn9ct58IuSm5CZKSaorxb387cCc5Cgrbo1PFoOLh+C/9WrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575695; c=relaxed/simple;
	bh=fMO0CmwbwSXaKQfx9Z7VKp4/ohvzolYlycdngoalUOE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=erIhw6iOIGn9fa+GniLvIb+h+yC+xuQYDOEqOOhfOk2L+TfDL7Qw6KKklMuBue6MqkFitXduU/x3G2aZAYc+OTMhfC2pqdwZ63Wou5iigVuiuJRtx0Ey9A+NGJvnihcz1wS9PGAW81/AQPJh//jD241OT5GE+oZZWoREjgIoQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2abf829dfso54168775ab.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 05:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740575693; x=1741180493;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LT44ngzpj2qIg+ByCOKVHveGH744EEw7Xe4FUY3WFJI=;
        b=TOtZudKcUdBQhp2qQ6od4hd8CKYBDGxe1JPcl7mOQMqsWdhNw8my0BJ8SmdbHdFxnt
         k+TgJqQyT9hPxj1fQosxeuS5nzVDWTgJFjHbQZy8kdCNADTEZr/R8gRwPiMmQL3Rs6TO
         jhPu8E7P1gXF0jGS94ynBWHanxMCjTCXr9EZX7pi4D51DCqGkf5qCS3kqYIE08W4xJK0
         jKnYtRk10uAStf8Fa2ecYvWEtXYhHvFeEOTRqdjr8mLNP8WHVOpLrfzN6Yp2CvA7Rmv6
         0RCYUIlTq8Bw9q6vQ5VSAXZkyTcY5lRwH2tO1qiYEcV+mWenEUWUHZt6taPmVWwb3qoG
         gTfg==
X-Forwarded-Encrypted: i=1; AJvYcCVJWVgZZ1eqyECjaRzr57rbkL/kas6TJmIjBUkPu9isoZlumgVXL01p2anpYKsx6PzpgBK4UyvUlOpvitjQqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1v1n9JhG0pBmL+7jg+BbJjVaDVUKMgptnLS5HiFdMvOqThky
	Wj0glyk2k5oH6siEjZ6f0b508Vg3RCiQxfvBqLUPDiPByDcFaes4XAXUtH4CZXAkioAPfJA5YpF
	SrWdPXtVvc62BJ4YXFc7VVnNxVKkNdmdhAzvSKb+oeVvgUf23LY21APA=
X-Google-Smtp-Source: AGHT+IGLok7Q6L17tCWYgePAj9eS//OxU2sD1U8w6kES41eeBugvXlenFJ+vjDOByDVpdyNr5Z0Ml5VylVLPI3spYckU7B7Wktay
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388e:b0:3d3:d132:2cf3 with SMTP id
 e9e14a558f8ab-3d3d1322ee7mr43158565ab.7.1740575693328; Wed, 26 Feb 2025
 05:14:53 -0800 (PST)
Date: Wed, 26 Feb 2025 05:14:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf13cd.050a0220.38b081.0158.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_free_keys
From: syzbot <syzbot+f9bc4ca17b97b000cf78@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f15176b8b6e7 net: dsa: rtl8366rb: Fix compilation problem
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=105abfdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=f9bc4ca17b97b000cf78
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d17d8b815d50/disk-f15176b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a0f3ae436f7/vmlinux-f15176b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea4ed42244ac/bzImage-f15176b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9bc4ca17b97b000cf78@syzkaller.appspotmail.com

netdevsim netdevsim0 eth1: unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 eth2: unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 eth3: unset [1, 0] type 2 family 0 port 6081 - 0
geneve1: entered promiscuous mode
tipc: Resetting bearer <eth:syzkaller0>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 20544 at net/mac80211/key.c:1162 ieee80211_free_keys+0x567/0x680 net/mac80211/key.c:1161
Modules linked in:
CPU: 0 UID: 0 PID: 20544 Comm: syz.0.4199 Not tainted 6.14.0-rc3-syzkaller-00155-gf15176b8b6e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:ieee80211_free_keys+0x567/0x680 net/mac80211/key.c:1161
Code: 01 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 f8 49 3f f6 90 0f 0b 90 e9 17 fc ff ff e8 ea 49 3f f6 90 <0f> 0b 90 4c 8b 64 24 20 e9 77 fe ff ff e8 d7 49 3f f6 e9 2d fe ff
RSP: 0018:ffffc900035764a0 EFLAGS: 00010246
RAX: ffffffff8b8270a6 RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc9000c4a9000 RSI: 000000000007ffff RDI: 0000000000080000
RBP: ffffc90003576570 R08: ffffffff8b826ea7 R09: 1ffff920006aec48
R10: dffffc0000000000 R11: fffff520006aec49 R12: 0000000000000002
R13: ffff888029378d80 R14: 1ffff1100526f53a R15: dffffc0000000000
FS:  00007ff4300856c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000000080 CR3: 0000000012152000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_do_stop+0x1085/0x2380 net/mac80211/iface.c:583
 ieee80211_stop+0x43b/0x490 net/mac80211/iface.c:776
 __dev_close_many+0x216/0x350 net/core/dev.c:1719
 dev_close_many+0x24e/0x4c0 net/core/dev.c:1744
 dev_close+0x1c0/0x2c0 net/core/dev.c:1770
 ieee80211_stop+0xd5/0x490 net/mac80211/iface.c:767
 __dev_close_many+0x216/0x350 net/core/dev.c:1719
 __dev_close net/core/dev.c:1731 [inline]
 __dev_change_flags+0x30e/0x6f0 net/core/dev.c:9258
 dev_change_flags+0x8b/0x1a0 net/core/dev.c:9332
 do_setlink+0xcca/0x4300 net/core/rtnetlink.c:3118
 rtnl_group_changelink net/core/rtnetlink.c:3747 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3894 [inline]
 rtnl_newlink+0x156d/0x1d30 net/core/rtnetlink.c:4022
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6912
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2533
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:733
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2573
 ___sys_sendmsg net/socket.c:2627 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff42f18d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff430085038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff42f3a5fa0 RCX: 00007ff42f18d169
RDX: 0000000000000000 RSI: 0000400000000140 RDI: 0000000000000008
RBP: 00007ff42f20e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff42f3a5fa0 R15: 00007ffc858190c8
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

