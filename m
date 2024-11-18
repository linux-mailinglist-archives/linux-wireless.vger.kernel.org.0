Return-Path: <linux-wireless+bounces-15466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561019D1657
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD66F1F22338
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558FE1BD9FE;
	Mon, 18 Nov 2024 16:56:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58731A00F8
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948991; cv=none; b=qcrHFuqjhyGVuLMtihk9mxFllfvAPm8tPtIljdI6s/eEtYAWssh7fZRdrPjQuI3dbPUvc2zXSr6W/Sa5I1bWl1ZINkbZOU6nxaheOVdmXyIskWjOlBxZk8SnQq35lNVEVJfscDneZ1CmUSjqhAqnRrETpj0uS7oS+S43rKsLsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948991; c=relaxed/simple;
	bh=vSauUQbqQRm+D9Sxdbn4/Gv0ov6NEV3lh/o1vp3dGzc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YuPSJgJxh7nC264VdoeLFgyCr58eDqbs2keajMUulRLCmTWZWWar71EcdYHQ+AwtzwIFUbICgnAUAu7dvDBTJ7Yu8chzZviRL30cMqj4spQ/DqNIs3/EwyOMln9/yD+oKy77qPzG/dw3Tx5uIHvXDC6bcO7yr1gJJWe+XJDjBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso23593495ab.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 08:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731948989; x=1732553789;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4Bnyr5J+1A12yJaaALa01BifYyba1Nn08q6McE9/0s=;
        b=GZkT0VTEWF3yKDo6VP9cUxNJjR/8nddUEBPtvoEtxSrQSvhhRZM44dMfrcipySCsfv
         uMf03B9vZ3ycAJ+Avh9kogRlIMJ7BxFLRT4VTWXT6lexnVyCen7pOxEidRBXcfGM7fXm
         cHxxP3Ilp1gV+xX8IXIXGywgqfsY6qKiZvrzY8ZRXDsdnLrZVSjgpctJdmfiverZGqNz
         L+kg0tcTqhs6nmpXKiQbn3r38hrCnHrzrycO/xD4eZ0Is1d3Gp+wzTLUmVYLDaY8iFCk
         AiU0M1s932NlfTyF3q+yLd6o80UVfh9ZeQFt3Ez+GBnuhRW3N9iP32roz5u5Z8jVS+fy
         y8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXRGGEk7llrCQKyMtgNvFuMkK9dQdQ/2XyAedEF/HLqB5+UEB5MtvrsCWAAvcLBp4exrdAbke0xUI5KIzFvWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk7raRLctWsPK6RwD0XMNuJuYSzBTybL4P2/02ldnCe0H0F6at
	h+wTDpqcUhG1KO9UwpAMmPJB2kmR9F/Pj9haYfNF8irprvEdkcJ7jtyXJDUrujsFNgUqiJf56TK
	CYu71vpyEN4mtk0ALj8i8EcLhnawbURhi6NEBjmbCoodHd4rxWfYjrcA=
X-Google-Smtp-Source: AGHT+IHC5DXB+ncNKrBTrSgiiRPB8eY+Tyj7FSJZH/ocRI+BEF08rpezB+dRjHBAJOw44RD0QVnKWnAJrlLkYEIYHFT0r+2B/buS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:3a7:432d:912f with SMTP id
 e9e14a558f8ab-3a74800f3e4mr123928455ab.1.1731948988827; Mon, 18 Nov 2024
 08:56:28 -0800 (PST)
Date: Mon, 18 Nov 2024 08:56:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b71bc.050a0220.87769.004d.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in sta_info_insert_rcu (4)
From: syzbot <syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0a9b9d17f3a7 Merge tag 'pm-6.12-rc8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179ef4c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=8b512026a7ec10dcbdd9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0a9b9d17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b80dd0292210/vmlinux-0a9b9d17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/42a07c5c6678/bzImage-0a9b9d17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1025 at net/mac80211/sta_info.c:738 sta_info_insert_check net/mac80211/sta_info.c:737 [inline]
WARNING: CPU: 0 PID: 1025 at net/mac80211/sta_info.c:738 sta_info_insert_rcu+0x322/0x1900 net/mac80211/sta_info.c:942
Modules linked in:
CPU: 0 UID: 0 PID: 1025 Comm: kworker/u4:4 Not tainted 6.12.0-rc7-syzkaller-00070-g0a9b9d17f3a7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:sta_info_insert_check net/mac80211/sta_info.c:737 [inline]
RIP: 0010:sta_info_insert_rcu+0x322/0x1900 net/mac80211/sta_info.c:942
Code: 85 db 4c 8b 6c 24 28 0f 84 90 00 00 00 e8 16 6e 4a f6 84 c0 0f 84 b4 00 00 00 e8 b9 80 64 f6 e9 0d 01 00 00 e8 af 80 64 f6 90 <0f> 0b 90 41 be ea ff ff ff 4c 8b 6c 24 28 4c 89 ee e8 98 d0 ff ff
RSP: 0018:ffffc9000227f9c0 EFLAGS: 00010293
RAX: ffffffff8b306961 RBX: 0000000000000001 RCX: ffff88803581a440
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffffffff8b3068ee R09: 1ffff11009fc6ace
R10: dffffc0000000000 R11: ffffed1009fc6acf R12: 00000000ffeeffff
R13: 000000000000ffff R14: 000000000000feff R15: ffff88804fe34cc0
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fca30a06fb8 CR3: 00000000363e4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_ocb_finish_sta net/mac80211/ocb.c:102 [inline]
 ieee80211_ocb_work+0x2fd/0x550 net/mac80211/ocb.c:136
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

