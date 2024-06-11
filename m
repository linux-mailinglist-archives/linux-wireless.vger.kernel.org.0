Return-Path: <linux-wireless+bounces-8803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D4C90417E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 18:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C5B24805
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD0E3FB2C;
	Tue, 11 Jun 2024 16:37:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8821CFA9
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123849; cv=none; b=c44n4NevR8Ob7HuNPdp9g+b22aEhgJh2sTwxNcwV/HewwcdQsoOHM+swba4EJkxaAawFDx5SxWEZ63ZT36Lu3yjTcx3t1motcR9W6wEeOUDEVOb39ba6FXn5SSpbVfT014/G4ttpcunQAM4aIdVqfnrtri5umGkiGWlUQKE4fz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123849; c=relaxed/simple;
	bh=zmsOm5zVkjm7xTUsdVu8daBXMwaoTvNYKt6UYD7v+ks=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bIZsCZP+6DMptl3k/BTpz4XHKsmcDdsIP3FmwZcvVxX/gEfq4EWhv5OZ2WyePW47klzKYIsXeJKvCZyKlxOTyTkE2QEyW3W2YAEwrOqUM6vYZAC0k9sKovxzeAzDiQoUEz0HrG8Qkjd1vm/SEng4fsx9dZS9U1EuueMigzsJNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so695680339f.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 09:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718123847; x=1718728647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaVN3PXLUvhLaNmZS/WM/UFUx9n6em9c+6ETvsCf4bo=;
        b=eTVI6dnVUnoagnNO9226cATKm5P0l2L0ZJyaKvEYueNUuVkLlrTgma71MB8koRWdmN
         Yp21Ym5kThCTpCN6JH+GXbZ61Ru45ZxmPf6d1pYGRl+ADXwpM0UhwMEuhg01NtUbl0/h
         Kc0lLVjPeFEn3+mve2CuovLFlWu/JcRYLdPi5mesDIs/oanY8uu40ZU74EAUwdM3MVPK
         NwJ6rcjimmdeOi+dioUGSKjhLTE1Sdr/rndQ7ay7IxpqDKui2Mc59oTQEvj2Gh8GHc++
         mF5H/pICvOhmKWR0puRaS4IjuiPd9W8QqYO57YlHOSknUifiiETyM0iXTA0+GcRiib2a
         Ll1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWxcv7kHlEjq5vAkfpyKt+esOibA6zhXeijf0hmQRzj1kt6bpBaI7woa/V2927ZhsIWWEHdWj3wN6/+Oswc4/7OKGWVHKT7OLDFEJItbA=
X-Gm-Message-State: AOJu0Yz/sYPxJ1tJj/QhIBueCWUJjPFjQdLQtYa+GMmj2nEDaEwDSx9z
	y6lU0hAYmWCGSvA7pIGxjTZchFn/jCBQsIDzsn+sWTgcnxdCHhzI/GZNbSsFCgKLMkvw1kR5Nom
	8R+Bbe1TrhPjaPNBJbL6Hg8CFx7CsN/AYepsxGMgJKruxHekLiBfkoak=
X-Google-Smtp-Source: AGHT+IEf0JjTnlLcFctIEWKpZnmyQYtD2CsSU33V+LKNAGYPG3adHPUEu+oAQoeKn/QRwhkj4bpoS9LntDQmNv8IOehHNepsguy0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4121:b0:4b7:ca39:5869 with SMTP id
 8926c6da1cb9f-4b7ca395b64mr651611173.6.1718123846730; Tue, 11 Jun 2024
 09:37:26 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:37:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009096d3061a9fe1ac@google.com>
Subject: [syzbot] [wireless?] WARNING in rdev_scan
From: syzbot <syzbot+cd6135193ba6bb9ad158@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, ilan.peer@intel.com, 
	johannes.berg@intel.com, johannes@sipsolutions.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	miriam.rachel.korenblit@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c44711b78608 liquidio: Adjust a NULL pointer handling path..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=164c2762980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=cd6135193ba6bb9ad158
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105b4602980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163c3b32980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47ff53e982e7/disk-c44711b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b10dcb52f35/vmlinux-c44711b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b4a6bf6f87c5/bzImage-c44711b7.xz

The issue was bisected to:

commit f7a8b10bfd614d7a9a16fbe80d28ead4f063cb00
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri May 10 09:37:38 2024 +0000

    wifi: cfg80211: fix 6 GHz scan request building

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13500a36980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d00a36980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17500a36980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd6135193ba6bb9ad158@syzkaller.appspotmail.com
Fixes: f7a8b10bfd61 ("wifi: cfg80211: fix 6 GHz scan request building")

warning: `syz-executor368' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5094 at net/wireless/rdev-ops.h:462 rdev_scan+0x188/0x300 net/wireless/rdev-ops.h:462
Modules linked in:
CPU: 1 PID: 5094 Comm: syz-executor368 Not tainted 6.10.0-rc2-syzkaller-00228-gc44711b78608 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:rdev_scan+0x188/0x300 net/wireless/rdev-ops.h:462
Code: e8 0d a8 01 00 89 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 17 35 c1 f6 90 0f 0b 90 e9 23 ff ff ff e8 09 35 c1 f6 90 <0f> 0b 90 bb ea ff ff ff eb d1 e8 f9 34 c1 f6 c6 05 42 dd c2 04 01
RSP: 0018:ffffc900034778d8 EFLAGS: 00010293
RAX: ffffffff8ad4f177 RBX: ffff888022a50000 RCX: ffff88807ea21e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8ad4f033 R09: 1ffffffff1f5a965
R10: dffffc0000000000 R11: fffffbfff1f5a966 R12: dffffc0000000000
R13: ffff888022a50000 R14: ffff88807c98c000 R15: ffff88807c98c000
FS:  0000555573837380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000029ce0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cfg80211_wext_siwscan+0xcbf/0x10d0 net/wireless/scan.c:3509
 ioctl_standard_iw_point+0x788/0xcb0 net/wireless/wext-core.c:867
 ioctl_standard_call+0xc7/0x290 net/wireless/wext-core.c:1052
 wext_ioctl_dispatch+0x58e/0x640 net/wireless/wext-core.c:1016
 wext_handle_ioctl+0x15f/0x270 net/wireless/wext-core.c:1077
 sock_ioctl+0x17f/0x8e0 net/socket.c:1275
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb389e893a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc48732138 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc48732308 RCX: 00007fb389e893a9
RDX: 0000000020000000 RSI: 0000000000008b18 RDI: 0000000000000003
RBP: 00007fb389efc610 R08: 0000000000000000 R09: 00007ffc48732308
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc487322f8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

