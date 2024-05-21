Return-Path: <linux-wireless+bounces-7862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C06068CA730
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 06:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DF21C2117C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 04:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10AE1CAB8;
	Tue, 21 May 2024 04:02:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B42101F2
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 04:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264158; cv=none; b=BCQcRNOUulnyfJDAubi10Ch5gro32lX6KaNL6tx3BiZq8h4rCOsNDU3qDIyC4JUSoPNsHcOa6t07IJmpMJ8tJkoV6DUtNvdtPgyPkjjLN5cg5y2C0H/tYTgj24hwQ6Mym2FuhvQlKJ/xeZvyT2Xp+oQs4oCew1yIy2X4jYbznnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264158; c=relaxed/simple;
	bh=jJbxgLd+YWO2Lg+/N7DnuDy51HfRFPtkPt4nTh+4MBA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QOJYXPOVuAALyUwqD4O8FtOllmJQCyQUncQEgdLu4SDd5dbQ7/GZz21P+jLC6lad7+BFsnVhTRGiHtlSSH4+/2wsb5FjOIU4KAzb+adHPhvJzx204K6N2fXwVd+LFmzO25jy2auXKSF4h87OwJX8mK6fS1RuBU5nPTzRD0CloSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1c3c98401so834137939f.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 21:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716264156; x=1716868956;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0yfAWJ5qhF41x1rSSrkKGC+wMZlFsEqb4/oAdzKKOC8=;
        b=jGYnSDO3e+an2el9Vvf9MyJZeEAyGIS5QHG6R4Usu1Cf3chyI6qijaqiJaj8/83npM
         VNtgOhlPxgVnrdTWCHg38BSek0v+8e2rqJ+Q/GgQdiBh7kLxKvqvaJQPxx1P6k4Bh3vD
         zT5Zm3EwdVBhITds9Hn7AGdr7JR6jpD8g5tHnSePK7ZumZWTvGpBq2lNCpPL03RYPZgp
         4tIg5NZiSJi5R0EGYNediFT6cPAcjfohO6j0XEr+CT2dZKE312pChaIxAvJlmA9nGKgq
         ywfNCFDaNBVy+eRO3OZ3wJioO3KRv9DO7AD2Irdlh5rLfa54mgiO4kqqTvAEwZa4w/4T
         akVw==
X-Forwarded-Encrypted: i=1; AJvYcCWt9ECIIwbLJzDvnGONroMIcuW3QpE7mXTTEawjfFeB3KWCbAShhQGfio1Rh9TClfBbTF5HtUNpVEVm2ccfBmrfep4LULAubjHftktfZM0=
X-Gm-Message-State: AOJu0YzmQc3QQzeOdfvkh8An1AIubMSTnoEkzcUZb7qjmTAQmhzeYoaR
	kXcJIBBsVazm7cYE+gJ6Dxbxns9tRbILpD80d9YwwGxSWhhnKWM2NEfGMfGfv3CBeACOnC4IpBT
	DeSCbJDRwpDKc20bXPPgea12eGQ6SdqBKFwT/1Whvrk8qiSBkPI22+4g=
X-Google-Smtp-Source: AGHT+IEFT/zTHh4X7a2pzSbS/LiikWABh60nqRg30Ez6PJMC0zjbh413k4+WFmwKVpXjOgRUcJEJhKKnczaMTR2/evEVH85mX4Wm
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:7101:b0:488:77ea:f194 with SMTP id
 8926c6da1cb9f-4895903263emr2233675173.5.1716264156339; Mon, 20 May 2024
 21:02:36 -0700 (PDT)
Date: Mon, 20 May 2024 21:02:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000612f290618eee3e5@google.com>
Subject: [syzbot] [wireless?] WARNING in cfg80211_bss_color_notify
From: syzbot <syzbot+d073f255508305ccb3fd@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f6f25eebe05f Merge branch 'wangxun-fixes'
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11696b5c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bddb81daac38d475
dashboard link: https://syzkaller.appspot.com/bug?extid=d073f255508305ccb3fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f9ec92980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1595fa84980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10564bcf8b3a/disk-f6f25eeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ac9b53e5395/vmlinux-f6f25eeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be417a358cca/bzImage-f6f25eeb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d073f255508305ccb3fd@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2855 at net/wireless/nl80211.c:19469 cfg80211_bss_color_notify+0x5f6/0x8b0 net/wireless/nl80211.c:19469
Modules linked in:
CPU: 0 PID: 2855 Comm: kworker/u8:9 Not tainted 6.9.0-syzkaller-05179-gf6f25eebe05f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: phy3 ieee80211_color_collision_detection_work
RIP: 0010:cfg80211_bss_color_notify+0x5f6/0x8b0 net/wireless/nl80211.c:19469
Code: 00 e8 ee b8 b7 fe 48 83 c4 08 89 c1 c1 f8 1f 21 c8 e9 08 fd ff ff e8 09 96 ba f6 90 0f 0b 90 e9 71 fb ff ff e8 fb 95 ba f6 90 <0f> 0b 90 e9 38 fb ff ff e8 ed 95 ba f6 c6 05 46 6f bb 04 01 90 48
RSP: 0018:ffffc9000ac37aa0 EFLAGS: 00010293
RAX: ffffffff8adbc735 RBX: 0000000000000000 RCX: ffff88802b693c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000ac37bb0 R08: ffffffff8adbc262 R09: 1ffffffff1f593bd
R10: dffffc0000000000 R11: ffffffff8af73d80 R12: 1ffff92001586f5c
R13: ffff888022f48000 R14: ffff888022f48cb0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001700 CR3: 0000000022822000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

