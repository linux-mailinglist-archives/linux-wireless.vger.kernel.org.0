Return-Path: <linux-wireless+bounces-21407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F36CA851DC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 05:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382D14C2BD1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A876FB9;
	Fri, 11 Apr 2025 03:06:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24826FA65
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744340791; cv=none; b=mdzwp7xEg1UCJDjgq+lQepX8eMf4X8lAN7wOyOP4/+8ldio9QzJJPzPKgCzUZ0APYR8xXU9Vw4F3BZJ2tOiub7kKE6xQj62cqB0Ov1WxKOHkLlmRSOUG7knz3hv5rSN+XeleaM6gJqa9k4QPcHj0Mkrjl0JZ6fhDnNvCXJSwg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744340791; c=relaxed/simple;
	bh=MuWu9AUSQ1+1uSylGxd3T7Cf+OjRoDsOR58E90b4AgI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uVgP5WqVccX1tlwjz+97dlEgv9ibNZbBXncMYgIsl6+gGbu0OA97woyNnoHgOyJmbdvzOduW2RY8z7Zm310kOJpmGmPN6ZHlhjmpDoQ83XDEUPZZN62Rcmvncks7qhx7ReQggVTCcbJOKmpQYWg8F5RTaZi0Ia5SyJDSoVWJV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d43541a706so14533825ab.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 20:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744340789; x=1744945589;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nvms1JaVVvcVzFNT1SNwDdqauS7cR0nPqFAyXLTYyU4=;
        b=e0oHiWkOUNEXrgm68EdMoOlfuDcaW/Ah0juvt0bqeG+nAgMZ2CQV2C2eJRJ1aC22Rn
         d6yu7rtzvanFaRVWSUvJHBAZOPB6s553UjbhMtuKHyqapVcaFH489kIv7W0pbjqE4HOa
         AJM9zU/LY2iX2RMrt3Yh7ptatPe2q5+ueQ9CSp0zE/6bqNB2Dz6RQYEdMF+Xholg/txo
         JXpkUf7g0OHNui4NjAAtvUI0eqmn+i26dXjvPNTvU0auJl+iJ5HiUAgDx4zWPdPUiaZ8
         /B6YzbZNIL5t6hy8vh8unDkm5FI+Ntu6GDkny8jB2uoxXMJ+tZCRFShygVFlhPNyT579
         AJIg==
X-Forwarded-Encrypted: i=1; AJvYcCUt/DljAd378ZnPvUbtewnfhntPVASUTK/tl3uy/XjQOfhF5L0r2y24Zf1NZ0EW82cDP/zJ57g6BxOgu9RfbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOUpnIWjddZ7StLAYQsSYCKIg0S9Tgl1ThoDQoYXvVULDrKN1q
	6+qt7tohw7n02AW4vcoGGVSqrJTavfKvA1fED3o9CPcPRLEe8UVGRZMLfZt6MWFe7NSDitbYCZJ
	8M1cl+b8PkkmLDwaZFBySjJfMb4jv3RsmEc3rj0r8cOWBTMhMyIrdseE=
X-Google-Smtp-Source: AGHT+IE8WDKXOhB70GjiVNV6AR9t2d6YxCElhdByaHvkDj95/MMR/d+yH5BAQtdR/OmE0MLtd7fS8WTr8gEoWZTqOzxkVSMWllOB
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c245:0:b0:3d5:be65:34ac with SMTP id
 e9e14a558f8ab-3d7ec1dd513mr12454675ab.2.1744340788798; Thu, 10 Apr 2025
 20:06:28 -0700 (PDT)
Date: Thu, 10 Apr 2025 20:06:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f88734.050a0220.355867.001b.GAE@google.com>
Subject: [syzbot] [wireless?] divide error in mac80211_hwsim_link_info_changed (2)
From: syzbot <syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    16cd1c265776 Merge tag 'timers-cleanups-2025-04-06' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b1bd98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=5bb5f06f99924ea0cf86
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20e7988b77fa/disk-16cd1c26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aca60f83d6d9/vmlinux-16cd1c26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b56870bab231/bzImage-16cd1c26.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.14.0-syzkaller-13546-g16cd1c265776 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:mac80211_hwsim_link_info_changed+0x42a/0xf10 drivers/net/wireless/virtual/mac80211_hwsim.c:2549
Code: 00 49 89 c5 74 08 4c 89 ff e8 22 25 cf fa 49 8b 0f 89 ce 48 89 d8 48 c1 e8 20 4c 8b 74 24 10 0f 84 18 01 00 00 48 89 d8 31 d2 <48> f7 f6 e9 11 01 00 00 e8 89 fb 64 fa eb 05 e8 82 fb 64 fa 4c 8d
RSP: 0018:ffffc90000117700 EFLAGS: 00010246
RAX: 000632276c5d693b RBX: 000632276c5d693b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000040
RBP: ffffc900001177f0 R08: ffffffff81b0eef1 R09: 1ffffffff20bfbee
R10: dffffc0000000000 R11: ffffffff81624770 R12: 0000000000000200
R13: dffffc0000000000 R14: 1ffff92000022eec R15: ffff88807a30f040
FS:  0000000000000000(0000) GS:ffff888125096000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000008000579c CR3: 0000000068a92000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drv_link_info_changed+0x53d/0x8b0 net/mac80211/driver-ops.c:-1
 ieee80211_offchannel_return+0x3a4/0x530 net/mac80211/offchannel.c:160
 __ieee80211_scan_completed+0x77f/0xb60 net/mac80211/scan.c:495
 ieee80211_scan_work+0x1d6/0x1dd0 net/mac80211/scan.c:1162
 cfg80211_wiphy_work+0x2f0/0x490 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mac80211_hwsim_link_info_changed+0x42a/0xf10 drivers/net/wireless/virtual/mac80211_hwsim.c:2549
Code: 00 49 89 c5 74 08 4c 89 ff e8 22 25 cf fa 49 8b 0f 89 ce 48 89 d8 48 c1 e8 20 4c 8b 74 24 10 0f 84 18 01 00 00 48 89 d8 31 d2 <48> f7 f6 e9 11 01 00 00 e8 89 fb 64 fa eb 05 e8 82 fb 64 fa 4c 8d
RSP: 0018:ffffc90000117700 EFLAGS: 00010246
RAX: 000632276c5d693b RBX: 000632276c5d693b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000040
RBP: ffffc900001177f0 R08: ffffffff81b0eef1 R09: 1ffffffff20bfbee
R10: dffffc0000000000 R11: ffffffff81624770 R12: 0000000000000200
R13: dffffc0000000000 R14: 1ffff92000022eec R15: ffff88807a30f040
FS:  0000000000000000(0000) GS:ffff888125096000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000080065018 CR3: 000000005144e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	49 89 c5             	mov    %rax,%r13
   3:	74 08                	je     0xd
   5:	4c 89 ff             	mov    %r15,%rdi
   8:	e8 22 25 cf fa       	call   0xfacf252f
   d:	49 8b 0f             	mov    (%r15),%rcx
  10:	89 ce                	mov    %ecx,%esi
  12:	48 89 d8             	mov    %rbx,%rax
  15:	48 c1 e8 20          	shr    $0x20,%rax
  19:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
  1e:	0f 84 18 01 00 00    	je     0x13c
  24:	48 89 d8             	mov    %rbx,%rax
  27:	31 d2                	xor    %edx,%edx
* 29:	48 f7 f6             	div    %rsi <-- trapping instruction
  2c:	e9 11 01 00 00       	jmp    0x142
  31:	e8 89 fb 64 fa       	call   0xfa64fbbf
  36:	eb 05                	jmp    0x3d
  38:	e8 82 fb 64 fa       	call   0xfa64fbbf
  3d:	4c                   	rex.WR
  3e:	8d                   	.byte 0x8d


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

