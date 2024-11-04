Return-Path: <linux-wireless+bounces-14900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1AF9BC000
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 22:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4331C20E9F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1D81FCC69;
	Mon,  4 Nov 2024 21:25:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0D1AC43E
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755528; cv=none; b=Wj2k5lWVxUPMUkZpYBRdVqfabpcL00ycnLmdL5YW1hNSmWYgn9naofI+2FA8NHTeKScfyOs5w4ZX+TYyC0IehMABUmqYZbQcMr4LrR7YhC/1tMhzf91GaOajSLSrT67NIRGfTDJKCXw3qcV/LHOvOo0KdHcgo8Tcg/3JCsQZ13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755528; c=relaxed/simple;
	bh=Rre4DbdsOxeLgoI5LSbnhb9diCbHE4TntsWN6o3Ahq4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BkQH/MCZE+J1G+R4fFXlZSVxyw2vcLsJgMs/UrC5XRqC0x+x2UIuKpYFvNb7P8jk0b5+BDAyCHkhpbyIagUqCpyt6aIht8w/NCcAB9A1kiALcNDWlfR57UqezSq0+dicALclLQ3KvESIhMY3/jRU7QkCY7uW4jpS2iU3YWkuLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c48f1312so25283645ab.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2024 13:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755526; x=1731360326;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAsKvAp8Sst3NYJtT1LShmmNbzN8YlFhKi+LB2P10Gs=;
        b=d85TfEB4b4PAqFxcUZzLFNCDhy0Ny/VRGpxrgzQGm7UAxP7JmaiRzc8w+FdedG3M1V
         RsyA9G/gXOvZsCdd8NTTOOd3b6CYwzHaVvPi2OE/XYUo7dZqeZWnSoTma85xm+xcB1KC
         ZqtDKiW+juMTdSwpF7Qe9Rd+5tzAjm+53KyMK1wZ5JJgagEWXZgz/6YXwedHDDdKwvMg
         zUrEGgt8zi4zsHD/agI5mO3ro9dp3Z+B6H0Q1+bARNbcUww41AYreJx64aStkJiwOqko
         TFzRA8zPkT/nWGCYP7eCJ3snXEXbERVTuI/+kW/Sl5KYifQidIby8udA6rX+J09V09ZT
         SIkA==
X-Forwarded-Encrypted: i=1; AJvYcCXrx+xBVldHhO1RVQqEmk/zps2G1SY46GXZUGRTtIOY1MGVPA0rGg9SDoQwNQfgLzpTLkaaN6bRddBExsPGZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHi9R+4Bd96U23IddkUpEi8wu00qFtDYYumFQTUw3nj+H1AcHP
	iC6ZZJ3ekPiLd3OQgk1MxeaT+q1bt8HFBiHSzsXJrTIdW+WXGMNg6/d16DvVullMhTXKH8dju3E
	fDTSJmr44rdjVaHqhM5zQ8pRaMEFkj6HqnLTEh+Z0urhv42UBwUVYi30=
X-Google-Smtp-Source: AGHT+IHthQkVIqK9FjtxcEWleyaboaWzlDMUbs0UcaxRBaxZT6t2Tla3mP4Y2/hhLaOfFQ8UdxWHvCZczEKkhNOrCtEZlNAraFYZ
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d06:b0:3a6:c122:508c with SMTP id
 e9e14a558f8ab-3a6c1225323mr89295815ab.19.1730755526457; Mon, 04 Nov 2024
 13:25:26 -0800 (PST)
Date: Mon, 04 Nov 2024 13:25:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67293bc6.050a0220.2edce.14fb.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in kcov_remote_start (6)
From: syzbot <syzbot+3f51ad7ac3ae57a6fdcc@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e5e6c9900c3 Merge tag 'nfsd-6.12-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11406b40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f527353e21e067e8
dashboard link: https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c9dd6858e45/disk-3e5e6c99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d49c920af4f/vmlinux-3e5e6c99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9905ad94dc22/bzImage-3e5e6c99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f51ad7ac3ae57a6fdcc@syzkaller.appspotmail.com

netdevsim netdevsim4 netdevsim1: unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim4 netdevsim2: unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim4 netdevsim3: unset [1, 0] type 2 family 0 port 6081 - 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 16141 at kernel/kcov.c:872 kcov_remote_start+0x542/0x7d0 kernel/kcov.c:872
Modules linked in:
CPU: 0 UID: 0 PID: 16141 Comm: syz.4.2741 Not tainted 6.12.0-rc5-syzkaller-00308-g3e5e6c9900c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:kcov_remote_start+0x542/0x7d0 kernel/kcov.c:872
Code: 4c 89 ff be 03 00 00 00 e8 9b df 1f 03 e9 04 fb ff ff e8 d1 af 29 0a 41 f7 c6 00 02 00 00 0f 84 f2 fa ff ff e9 7f fc ff ff 90 <0f> 0b 90 e8 06 cd 29 0a 89 c0 48 c7 c7 c0 d4 02 00 48 03 3c c5 50
RSP: 0018:ffffc9000d826610 EFLAGS: 00010002
RAX: 0000000080000200 RBX: ffff888033771e00 RCX: 0000000000000002
RDX: dffffc0000000000 RSI: ffffffff8c0adc40 RDI: ffffffff8c603460
RBP: 0000000000000000 R08: ffffffff9429786f R09: 1ffffffff2852f0d
R10: dffffc0000000000 R11: fffffbfff2852f0e R12: ffffffff8194e367
R13: ffff888025389780 R14: 0000000000000246 R15: ffff8880b862d4c0
FS:  00007ff44c8056c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdf652656c0 CR3: 000000001fed8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kcov_remote_start_common include/linux/kcov.h:50 [inline]
 ieee80211_rx_list+0x799/0x3780 net/mac80211/rx.c:5444
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5485
 ieee80211_rx include/net/mac80211.h:5138 [inline]
 ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:441
 ieee80211_stop_device+0x3f/0xf0 net/mac80211/util.c:1587
 ieee80211_do_stop+0x1cb5/0x2300 net/mac80211/iface.c:721
 ieee80211_stop+0x436/0x4a0 net/mac80211/iface.c:780
 __dev_close_many+0x219/0x300 net/core/dev.c:1560
 __dev_close net/core/dev.c:1572 [inline]
 __dev_change_flags+0x30e/0x6f0 net/core/dev.c:8843
 dev_change_flags+0x8b/0x1a0 net/core/dev.c:8917
 do_setlink+0xcd0/0x41f0 net/core/rtnetlink.c:2929
 rtnl_group_changelink net/core/rtnetlink.c:3476 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x1119/0x20a0 net/core/rtnetlink.c:3772
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff44b97e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff44c805038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff44bb35f80 RCX: 00007ff44b97e719
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007ff44b9f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff44bb35f80 R15: 00007fffdca94ea8
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

