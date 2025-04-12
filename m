Return-Path: <linux-wireless+bounces-21470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362EA86C63
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 12:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575211896365
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7981B87E1;
	Sat, 12 Apr 2025 10:12:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C024197A68
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744452748; cv=none; b=He2GlG1/zcs7/6vVXhMSuBdLyLAGx61DK6az2/pMUxpZOD5egSN5wfiZDDFFe5wmy3ITtV6AJ15R+m1v473bBuqF2dAL7QY01JKVaSZA5gR0N9C1K6eLi8WaD+PdxqhYcoIGtRmraTGCzkxstkooQElu6a7ep2FGFSzx2EUCieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744452748; c=relaxed/simple;
	bh=MhUEV/KLzQ00UWqF1T/ULd9J3ItGJyzd46fl6I3Qj44=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lyPBEdo5CC6W6vXdQL0xm88HckF7u0QO3oGWHB4W6eC9LVV7pvKVaCsSBE6q/6im6cYy0mzNM8EYXxjGVv1WTxiwoBiZ5b7/mm+24X6Dv8SKV3lERfglGMZ3bZmLM8P6aHkU6n8TD+OuxTBWf+FJsRSHBWxjx59xLgAVHZ+Q1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d6e10e3644so29359145ab.1
        for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 03:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744452746; x=1745057546;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYa9pe9sUSOHSN28lPFUiX8ar13op2aDSplKzMBOR2k=;
        b=Ev3Cg3dLJrMkl9VelqjCzMw+32jDvJIX4RESTNZTXVSlqK9kMxQZ+BiSeu5sxJPuk8
         IZL9evcYAtnFlMJpJ+n4cGJKW5isr1dbDFLevRVYwTN2mDsQZd+rBNRCwY/UAOSNoEkz
         2fFyib4ek74dI38SCSTt6N7k/9B8FfpkNOXjSGGywQZeSF2Qry73J6dlwPPJkzAlexsu
         +8nogVyaUDsClMHX0utSWqq0AmtO6vgIco7F2hbiwasLB/GaLcMOnj8scNYukiyZvin7
         JlLGEhw/46lMYDTnrGA81Q0Mxgv6kHF+lAhdTTFw61QCSbfzoZjoTNznm8j+dCqA66AB
         BWVg==
X-Forwarded-Encrypted: i=1; AJvYcCW1BKD1iE85iNkCbjvZcNZFSgDEX5PamSwR+ZeX70UZCW13AngFbro2TUT6mDHBO36HgE65h7QvHzsQiJTY8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM33VFTeffr01Qt8adJq91XOAqmut0VBZvLBabA0IofYB4ia0v
	jF7PmbvJ7u+cO1nFIMiJ/6tXnQdGhP6wMCD0ED/hGACa1FHPy2O1hmoeF4COC3vQJ0J3F7BO+NP
	Q9V9hcPByoJ2cdTLs5YKjAenfQ9wCBade27Igt5CkL8uNfEeQ0Uxw0z8=
X-Google-Smtp-Source: AGHT+IEixtoBkzGmC63GhfcIw3kuB/LY1ED06eWgkgSMBP7PQ3yNJEeYGx2JmoZVUImCJtx1rBHQ1cqcS6VL0+5wtl4v6Fit3jds
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:3cf:c9b9:3eb with SMTP id
 e9e14a558f8ab-3d7ec0e1659mr51769765ab.0.1744452746165; Sat, 12 Apr 2025
 03:12:26 -0700 (PDT)
Date: Sat, 12 Apr 2025 03:12:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fa3c8a.050a0220.379d84.0009.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in __ieee80211_start_scan
From: syzbot <syzbot+33a62232cb175e2e2fa4@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69ae94725f4f tipc: fix memory leak in tipc_link_xmit
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=100d8070580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=33a62232cb175e2e2fa4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18aabd5abc54/disk-69ae9472.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb0ce52c96b6/vmlinux-69ae9472.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e54e711975b/bzImage-69ae9472.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33a62232cb175e2e2fa4@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 20781 at net/mac80211/scan.c:848 __ieee80211_start_scan+0x13f7/0x1ee0 net/mac80211/scan.c:848
Modules linked in:
CPU: 0 UID: 0 PID: 20781 Comm: syz.6.5078 Not tainted 6.14.0-syzkaller-13311-g69ae94725f4f #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__ieee80211_start_scan+0x13f7/0x1ee0 net/mac80211/scan.c:848
Code: eb 0b e8 cc 61 2b f6 41 be 08 00 00 00 41 83 fe 09 0f 84 63 06 00 00 e8 b7 61 2b f6 45 31 e4 e9 51 f2 ff ff e8 aa 61 2b f6 90 <0f> 0b 90 e9 0b fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c ab f9
RSP: 0018:ffffc9000390f540 EFLAGS: 00010283
RAX: ffffffff8b97f596 RBX: ffff8880786c4d80 RCX: 0000000000080000
RDX: ffffc9001dba7000 RSI: 000000000000065a RDI: 000000000000065b
RBP: ffffc9000390f788 R08: ffffffff8b98511e R09: 1ffff1100c07a1d3
R10: dffffc0000000000 R11: ffffed100c07a1d4 R12: ffff8880603d2978
R13: dffffc0000000000 R14: ffff8880603d2978 R15: ffffffff9368a020
FS:  00007f4f747176c0(0000) GS:ffff888124f96000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2834dd CR3: 000000004b8ec000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rdev_scan+0x155/0x300 net/wireless/rdev-ops.h:467
 cfg80211_conn_scan+0xa5b/0xdc0 net/wireless/sme.c:135
 cfg80211_sme_connect net/wireless/sme.c:630 [inline]
 cfg80211_connect+0x1790/0x20e0 net/wireless/sme.c:1525
 cfg80211_mgd_wext_connect+0x470/0x5d0 net/wireless/wext-sme.c:57
 cfg80211_wext_siwessid+0xc0/0x130 net/wireless/wext-compat.c:1412
 ioctl_standard_iw_point+0x675/0xd30 net/wireless/wext-core.c:865
 ioctl_standard_call+0xbd/0x190 net/wireless/wext-core.c:1050
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0xe4/0x410 net/wireless/wext-core.c:1014
 wext_handle_ioctl+0x15a/0x260 net/wireless/wext-core.c:1075
 sock_ioctl+0x181/0x900 net/socket.c:1243
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4f7398d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4f74717038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4f73ba5fa0 RCX: 00007f4f7398d169
RDX: 0000200000000040 RSI: 0000000000008b1a RDI: 0000000000000005
RBP: 00007f4f73a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4f73ba5fa0 R15: 00007ffc1d008b88
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

