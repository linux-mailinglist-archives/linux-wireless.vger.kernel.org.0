Return-Path: <linux-wireless+bounces-10230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC48931A2E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 20:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0BB22393
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B586F099;
	Mon, 15 Jul 2024 18:18:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3046F068
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067507; cv=none; b=hKL2jNuDl2C4Xeec+cHXFd3Y/odskmr2yfWtyUEYiZGqjJmWE2teLeQEBU5ryvhvhdEfMX+PpQPkeMrEZnvNWk+RzuEpL4/ybG3SN2cX5Ca3BqAHi6OmQVZ2kgYveivBbHZinWabqW7aRqmIWrjJirogb1r9617cL2uNlVkDEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067507; c=relaxed/simple;
	bh=OBznxfoYKy1Zf974n+ASvWJ9uXh8KBeGGa1OHU3//EI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BBGDgpUyDCtq6xKK2gKTm+7NAH0SWho90SH8MuqFplpesmVfNJgYqMd2CO958/sFvTPibAR3st+5cvTK7z8ms0rBCr+Ba+JxBuOYJ2yIEosBo8bapaRTPblXrz7XhsPW5iST39iO5ayqHn71BSyf7JCNvgOab3sQEveqMO6RP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-377150fb943so52425475ab.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 11:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721067505; x=1721672305;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9L7surq7e5cJ+iFDr3RDLEh2S5o7LANGMRFfpgtm4I=;
        b=gOyyYMQMdMg37Z6Ubp1t++ZqahTEbAcHXSrlbcSCGW4hb44OS3n+gFf+CioUCkEmPU
         R7nwsepsXYJLdvDQcbWxE9LHfY0eKcCiTJDDIJAVf5RXNDyuoC2ld/PhxzkUnmv+9d5l
         wBawQp7xPdiua/KPvpBc450yrLCSZrlh8yl5TVwtW6JieNBR/IJDqAe3NdDmxDh1rWhW
         9WQH6Ip/6ARi/ds3jkaFkneOx9ZyqR9NitxkdaCGBkvscE1gPNBvH7p4WIJcIYWfDqWx
         qPv2ispa1vCA3k9pnq52qf77bgozEg6CS+7xM6r3ncSS1SRPauHc4wwl1TGIkLRRo1Gl
         flLw==
X-Forwarded-Encrypted: i=1; AJvYcCWzyRW0JcltM0Hi7/6pjwEyCvyTKzsBNWtzR8CzuVlxx1hBI8vIn6947ZAlsNMxXjgeSjmZnUOPNoTWrHsCGGkMe8PsQndo4EdiR2H7pzA=
X-Gm-Message-State: AOJu0Ywnh3igkcyuOmwKmzdBkTj1YzHhhHp4SmP6MkukRsmJjzxJolkr
	D7DNlSWnMaP1fyuFaAzFqz0k12p9lye0QEJDqHN8JNcXVm9fe+pIJsI+Xe4tB6y0Jymyh49yBwD
	Vkq6az/uySACYm/j3O8FoKJCSOBFK172/tZHNo/ikudqDd26TnC1QYLw=
X-Google-Smtp-Source: AGHT+IGvaAmICzGAjLmKfxj+Tf0nNdpleoxIcGAnXRywkDzcjemvQr9koMk4Qo8p6WOSIkGSpIZhfL9f/b69V1iSna2jGbm4IwCp
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:380:fd76:29e4 with SMTP id
 e9e14a558f8ab-393a0ec10edmr406765ab.4.1721067505542; Mon, 15 Jul 2024
 11:18:25 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:18:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d78dd061d4d4190@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_link_info_changed (2)
From: syzbot <syzbot+91af2efe46a484b223f0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d9a2f29aefd Merge tag 'mm-hotfixes-stable-2024-07-10-13-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11988fb9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63b35269462a0e0
dashboard link: https://syzkaller.appspot.com/bug?extid=91af2efe46a484b223f0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1cad98f467f/disk-9d9a2f29.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4f4b4b7a5f8/vmlinux-9d9a2f29.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed300468d50d/bzImage-9d9a2f29.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91af2efe46a484b223f0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 18830 at net/mac80211/driver-ops.c:465 drv_link_info_changed+0x153/0x8b0 net/mac80211/driver-ops.c:460
Modules linked in:
CPU: 1 PID: 18830 Comm: syz.2.3286 Not tainted 6.10.0-rc7-syzkaller-00076-g9d9a2f29aefd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:drv_link_info_changed+0x153/0x8b0 net/mac80211/driver-ops.c:460
Code: 83 fd 01 75 1f e8 cd 3b a6 f6 eb 32 e8 c6 3b a6 f6 eb 2b 83 fd 03 74 21 83 fd 05 75 07 e8 b5 3b a6 f6 eb 1a e8 ae 3b a6 f6 90 <0f> 0b 90 e9 c3 01 00 00 e8 a0 3b a6 f6 eb 05 e8 99 3b a6 f6 4d 8d
RSP: 0018:ffffc9000e11ece8 EFLAGS: 00010283
RAX: ffffffff8aefec72 RBX: 0000000000000001 RCX: 0000000000040000
RDX: ffffc9000a6de000 RSI: 0000000000000f5a RDI: 0000000000000f5b
RBP: 0000000080000000 R08: 0000000000000005 R09: ffffffff8aefec40
R10: 0000000000000004 R11: ffff88801dc30000 R12: 0000000000000000
R13: 0000000000000200 R14: ffff88806d0c0ca0 R15: ffff88801f218e20
FS:  00007f81b55296c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e311ff8 CR3: 000000002d852000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_offchannel_stop_vifs+0x25c/0x590 net/mac80211/offchannel.c:122
 ieee80211_start_sw_scan net/mac80211/scan.c:559 [inline]
 __ieee80211_start_scan+0x1a7d/0x1e00 net/mac80211/scan.c:849
 rdev_scan net/wireless/rdev-ops.h:466 [inline]
 cfg80211_conn_scan+0x9de/0xe80 net/wireless/sme.c:133
 cfg80211_sme_connect net/wireless/sme.c:630 [inline]
 cfg80211_connect+0x14a4/0x1cf0 net/wireless/sme.c:1524
 nl80211_connect+0x188f/0x1fe0 net/wireless/nl80211.c:12035
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f81b4775bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f81b5529048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f81b4904038 RCX: 00007f81b4775bd9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00007f81b47e4e60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f81b4904038 R15: 00007f81b4a2fa78
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

