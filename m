Return-Path: <linux-wireless+bounces-16488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB8D9F5540
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478C718916E2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE661FC7EC;
	Tue, 17 Dec 2024 17:48:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AF1FC7DD
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457703; cv=none; b=VoDwte1aF9iMQms4pppVydJMzzmITtN7zxeXLNYu/4v2D0EtGtBgbBzvSMFBIl7rw8K5h2qBEBKtyw33T8njQIi1aZZomHtJjm/jS2CAXJg6ccPN4Gm8eQ8et66Lwvl1SReWcGbJ05tp+TYYo/Cih6LOVpTeEdhdLx2plcYf2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457703; c=relaxed/simple;
	bh=Ltqla7Ek+8zXoBBFuA+L1KhaLefGmWF0PR2+Um1akc8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pUgAo+4cYs+FE6GN2jBS3kWuR7Ens5Vyp3YyPLcMtXPEj7Zb1G6Y6bKPYj6flDWxXk4Q/JgdZTqZcfCBzroqCrVxeAfS4/RcPRrtPmv4aVp62+MCu6/yUVLF8BxmdlnPQR1I+7ye2kqrVaO40BcFe3iUeVKTLMAFjon5sIAeapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-847500c9b9aso85207539f.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 09:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457701; x=1735062501;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSnnY6pqR3DU+mumbdIFd+6+d6LrrMp8CrvhSQnxUb4=;
        b=WzHwdI1MATlYEtpb208bEkoRYIP+I0XWPCGggmIa9DYk8y3JUtvuRVh8cxT2ggXhft
         RohqouQQ7ZZQYFrD8Dix1tK6MU5zWTbCHrLxTDKGhv0TeoCHII37yieEEqXtdx/VAE81
         7vGdAKdDkXp7zqQqGEoRF6QeC6JeFWIT254XjDXiSr8V5LL/fkQ4eJlxsMurFtPQrrfd
         jHvnnFgQOqyWKXK4VnzcqzL3jY9TJL2F0Sf93TNOYZ9Txd/sZO1He8zu+nV2mdiYGhq5
         phPEDSIQlkOGksjxFOi9ShmQtlsQ07GJ06N8ZU6OAkOgYp59Q6tst7fSHAI5dLMaA0b3
         0H9g==
X-Forwarded-Encrypted: i=1; AJvYcCVmO/KwJYFeHQBZAR4Lu2JpqBzu8924ygww4XZNGVTvG7B2+qmUHQxJE14FQ8hIfRkoUUE2PtR4XuZ92ogBHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKxbgf0ljEYyGOFLTonbmeZttZyoF6VfAYmpAEpdgpG+bMxQA
	+4s2DUnKpbzwBuJzGYD+nLg9684scrxY1tW2bsPBbwy02dITnIVRLGWwMweJEGoRZ6Wp2wUVrt3
	upVYJDz6CTi7c/TVfyxEoWGdr1oWEyfVb/kLTXZInsR5Sr8DlgF9r6Xo=
X-Google-Smtp-Source: AGHT+IE4CtTcVTXUS0otXiFVgvu46iNog/C8HpUqfzJbf0N6T+qsecmebXd7eshH6kwJU3N6ZSVONiXvAholpcai/YFU4iDgaxjE
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4d:b0:3a7:776e:93fb with SMTP id
 e9e14a558f8ab-3bad2ea6702mr44327905ab.8.1734457701400; Tue, 17 Dec 2024
 09:48:21 -0800 (PST)
Date: Tue, 17 Dec 2024 09:48:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6761b965.050a0220.29fcd0.0071.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in __ieee80211_suspend
From: syzbot <syzbot+56a1a45a9a2c04d425ff@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a0e3919a2df2 Merge tag 'usb-6.13-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d44344580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=56a1a45a9a2c04d425ff
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127a14f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d0fbe8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/669aa1e15c11/disk-a0e3919a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee966f8b50ac/vmlinux-a0e3919a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e872e1d072f1/bzImage-a0e3919a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56a1a45a9a2c04d425ff@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5838 at net/mac80211/pm.c:171 __ieee80211_suspend+0x1059/0x1300 net/mac80211/pm.c:171
Modules linked in:
CPU: 0 UID: 0 PID: 5838 Comm: syz-executor739 Not tainted 6.13.0-rc2-syzkaller-00333-ga0e3919a2df2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__ieee80211_suspend+0x1059/0x1300 net/mac80211/pm.c:171
Code: 47 f7 f0 41 80 a4 24 81 01 00 00 fe 4c 89 e0 48 c1 e8 03 42 80 3c 30 00 74 c4 4c 89 e7 e8 2f 91 47 f7 eb ba e8 f8 08 e5 f6 90 <0f> 0b 90 e9 4c f8 ff ff e8 ea 08 e5 f6 90 0f 0b 90 e9 2d f6 ff ff
RSP: 0018:ffffc90003857c50 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888072948e40 RCX: ffffffff8a8c6bc6
RDX: ffff8880121e8000 RSI: ffffffff8ab434f8 RDI: 0000000000000001
RBP: ffff88807294aac0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000005 R12: dffffc0000000000
R13: ffffed100e5291d0 R14: ffff88807294a8c8 R15: 0000000000000001
FS:  0000555575a7d380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c5a7eec030 CR3: 000000003056c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reset_write+0x7a/0x2a0 net/mac80211/debugfs.c:418
 full_proxy_write+0xfb/0x1b0 fs/debugfs/file.c:356
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9548c0f559
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe1003cdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f9548c0f559
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9548c5c0be
R13: 00007ffe1003ce30 R14: 00007ffe1003cdec R15: 00007ffe1003ce20
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

