Return-Path: <linux-wireless+bounces-27652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C32BA0F1A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 19:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEAE07A1508
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E530EF89;
	Thu, 25 Sep 2025 17:50:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648830E0CD
	for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822632; cv=none; b=pZxBFYKUwFLScWZB/QpyPC35/qa4nL2OQt4L2yBnniBG7mbJlpGRB47WttKlhiIiA1V7IVlWaOMEJOUuYM3sbae0xSdsypwvrdjYhezdZ/fzwh1Eafirqb8q/Z+FdqIQP7vnQcJb+1aXna+Q2LbquOcYTa+W2WVIOunyAOn9C/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822632; c=relaxed/simple;
	bh=ylf/4ZPnXwGVo3cG2fEs2Eso7BVd+FvhU1qDHr2/Tnc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CW2OH91Y3fRGYacDDjn0Tqzvo9ZEFAFdGTY9w/w8GZvykfEmDPcxdnLNvmVFpQjS/JW+DYq6+t+nQdM4NxbeIOi+sY2z+V5+P9TDO/Lq3KKzK6FjHMENoXyC7H+j8wE22iI+Mnnc4a+NjmRSCxMx4pAbouQkL74zB5D2DCmkGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-426cbe6a23aso6335155ab.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 10:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758822630; x=1759427430;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZie39W39Ctc/C3R1GNhaN1HRnKwGgYtyoeaL+9tcXI=;
        b=Pn+9pPHFLvLaeWNglB4IPQH78mBpWmLb9B5r76kelvBmCHRdrmljejr7gMRB7ID7Ro
         Q0pCz/gEOMHwjOl62THa4dJW8uGj4pBc/9TcBH3XFprqFVdN/u1djXSALopFFZ2CvJYh
         YAo8iy7Ioelj0yGQBa8Z7tAeudEPEzblRT0kvC0n+s8QgUy7DvXYeAecOY7Em1wvYod5
         6yprbrPCiNH/kf+2L1DcPodcEXbUN0y08EJcIcPMnMcSf43wC35Lw/PlyqC9fdEw+2Ha
         q7OUEhT8YkH1TkxvOoGAmlBI+9G2v3G9C8jy7RTfDZBPlLmjgFmm4tH1Q58WZwXL6BzR
         FD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoFSbDzUsB7dLLv3MJ1gz/3DtBAQsra+FUOiPj8JE0Bodw7uTIgLwy7ioB0YkFRPKjZDjWdPiyARl81alwmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWC2G7s2ctJmqjEfLmme7IzRAyeLOvPUmDTYkfq27tNW5suB4u
	UFo8BRVXCiDm8fXwBlidPQZBwRn9lLZ9E8DAhq13Cgogxd28ruD0rJFDHZe+RX/Odx8fy5KNcEP
	KaOFv+wXobbis/T/rdnUoInRv3+Q5NdQ9IwHvB1WJSThIkvdSfTdLTbHXyQo=
X-Google-Smtp-Source: AGHT+IEWsMCPCAyXck5Q4Ob+BH2+WZgit6Vu+IY53oOMv7RR8QXLFyhAhDoz09zeTXf/B6XSjEKGqaQmrcW2i2Cy2MN2ChyjCKnq
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:425:8857:6e3c with SMTP id
 e9e14a558f8ab-425955f47f9mr60595035ab.11.1758822629764; Thu, 25 Sep 2025
 10:50:29 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:50:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d580e5.a00a0220.303701.001a.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tdls_oper (2)
From: syzbot <syzbot+665dd2d6eb222ac6a6ab@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4ea5af085908 Merge tag 'pm-6.17-rc8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1629ed34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=665dd2d6eb222ac6a6ab
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123634e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1129ed34580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4ea5af08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ad79540e83d/vmlinux-4ea5af08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1e92b3f5e3f3/bzImage-4ea5af08.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+665dd2d6eb222ac6a6ab@syzkaller.appspotmail.com

mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5569 at net/mac80211/tdls.c:1461 ieee80211_tdls_oper+0x38f/0x680 net/mac80211/tdls.c:1460
Modules linked in:
CPU: 0 UID: 0 PID: 5569 Comm: syz.0.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_tdls_oper+0x38f/0x680 net/mac80211/tdls.c:1460
Code: 6f 01 00 00 e8 a2 e0 b1 f6 eb 22 e8 9b e0 b1 f6 4c 89 e2 eb 21 e8 91 e0 b1 f6 b8 bd ff ff ff e9 21 fe ff ff e8 82 e0 b1 f6 90 <0f> 0b 90 4c 8b 7c 24 08 48 8b 14 24 4d 8d a7 2a 1d 00 00 4c 89 e0
RSP: 0018:ffffc9000caa7320 EFLAGS: 00010293
RAX: ffffffff8b0ddcbe RBX: dffffc0000000000 RCX: ffff888032f20000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888011f50187 R09: 1ffff110023ea030
R10: dffffc0000000000 R11: ffffed10023ea031 R12: ffff88804e3e5d2e
R13: ffff88804e3e4d80 R14: 1ffff11009c7cae4 R15: 0000000000000000
FS:  0000555560f3b500(0000) GS:ffff88808d007000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c008670000 CR3: 00000000440e0000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 rdev_tdls_oper net/wireless/rdev-ops.h:945 [inline]
 nl80211_tdls_oper+0x285/0x440 net/wireless/nl80211.c:13249
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdcac18eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe2622fcd8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdcac3e5fa0 RCX: 00007fdcac18eec9
RDX: 0000000000000050 RSI: 0000200000000240 RDI: 0000000000000005
RBP: 00007fdcac211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdcac3e5fa0 R14: 00007fdcac3e5fa0 R15: 0000000000000003
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

