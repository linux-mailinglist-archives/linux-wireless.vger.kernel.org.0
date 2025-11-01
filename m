Return-Path: <linux-wireless+bounces-28452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C68C27665
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 04:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8321894F48
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09124DD01;
	Sat,  1 Nov 2025 03:12:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DEB1C860B
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761966753; cv=none; b=eB4rlHW0gkjspM2lopHa8Pme6RveW1bBTVClbEUuWT6ZCe9KP6rr5RKb5iufCkTryBRyFeWv3lH0DQTfwiQ8btcGODWGjjo7aAdTBhrUg3REj7pI8UOAjLPutuoYIu4Lr/HbI0M2JnQbM0jk/pgJyj9+2XD/+tyBePuBwgVwD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761966753; c=relaxed/simple;
	bh=1nJzeRaMWwh80JChzmBrDut1RAfItrUcuVoWyS9W8BI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HyVWNSb5yjzdOp5Aun5YYpnvMROP9NclVNVUx7aolgcaPUFsul1Y0pTi6hNWZo2LlarZOxVlDhtWqUYem8wd/XVL0AJSpKw8CUiIN0icsiOy4wyyEU//hw1ku96HlLjMqif2wwBgBZRzQ/RMPUVs1LMEspZyQI5wDBY7ShiKGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-43300f41682so28770285ab.1
        for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 20:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761966750; x=1762571550;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nl4e23YNqS4a7oAFSjJzU/Fyw1wJYae3i9pNM46KVAQ=;
        b=Z74fL5vnp6r/QMLoTwLuRgLuRwqxhrI40fL+DUncCcaBd8hB0SJUwEslJAFVctRNDC
         vvsvbcxp40dJFfr4KHcRCJfrowWDZ2QEqjs+NVDwftnHId6CkmmerX4jmwHkYRkT53Ch
         A22523cNWAmvzpttjcw2c5AMkQmKpbBDtYAEgrak3n1sk1OyLwq+sg9BVRPVWy8y/toB
         NjmdCqQxWAJX0z4ouMBBR6lkYR/dJ3tIPk0jfbVDZghEhIEGep3+R5RGAhpAsR9KLmbD
         KcWaQt6n85antuPEnwo7DQaOWjPhdY//WZKZ3/5aQvvVqQoeps49ePb4822nmbKfCrv5
         8eBg==
X-Forwarded-Encrypted: i=1; AJvYcCXMHMVYHrKjxdQLLJJ1JSDV05NFigTkDti8fdIwusVXaoKSa+YJh0DR2S+oHQwfyrfQKpCFTHZ8MTzDyi4+IA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxviji/IGG7/k8HpPxd2Nb5ClFymDFz1JC8+58JHK7KBpObAKWf
	79fH4lOJpuPYGwYhHaZ0rblVRemnPuzul0qAk8VCKH5wjBbTvSEEhNj1tHY+nwqmKZsqIq3drWx
	VIgpAzhWkLqUHzvK5cd00HNSc6TthaJdh6cNVadL0DOVadX4yYRPQFh7SmSI=
X-Google-Smtp-Source: AGHT+IGU9iu+ivCWDkfgQvQKDWX2CZ+qpkUm7qlePBwEIbdYdZA9JhcDVKqMu9RL2kdzvV76yqGo/riCLF1afnUzzVFv2/wklNNG
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2501:b0:430:d5b8:6160 with SMTP id
 e9e14a558f8ab-4330d1e6f32mr100382805ab.29.1761966750612; Fri, 31 Oct 2025
 20:12:30 -0700 (PDT)
Date: Fri, 31 Oct 2025 20:12:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69057a9e.050a0220.e9cb8.001f.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in rfkill_fop_open
From: syzbot <syzbot+1254ea61f6f4969c9ef4@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fd57572253bc Merge tag 'sched_ext-for-6.18-rc3-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14140704580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=1254ea61f6f4969c9ef4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c72764dfac75/disk-fd575722.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0f65b3e3b85/vmlinux-fd575722.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53a0e239c3e5/bzImage-fd575722.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1254ea61f6f4969c9ef4@syzkaller.appspotmail.com

------------[ cut here ]------------
rtmutex deadlock detected
WARNING: CPU: 1 PID: 13303 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
Modules linked in:
CPU: 1 UID: 0 PID: 13303 Comm: syz.5.857 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
Code: 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 8c 00 00 00 48 89 f7 e8 a6 3c 01 00 90 48 c7 c7 e0 18 eb 8a e8 39 7f c0 f6 90 <0f> 0b 90 90 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 40 a2 91 4c 8d
RSP: 0018:ffffc9000543f490 EFLAGS: 00010246
RAX: 3180a59543ab4000 RBX: ffffc9000543f520 RCX: ffff888057f79e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000543f628 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101712487b R12: 1ffff92000a87ea0
R13: ffffffff8ac280a9 R14: ffffffff8eb42480 R15: dffffc0000000000
FS:  00007f6af12ee6c0(0000) GS:ffff888126efc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6af12edf98 CR3: 000000003d872000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x692/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 rfkill_fop_open+0x138/0x820 net/rfkill/core.c:1178
 misc_open+0x2de/0x350 drivers/char/misc.c:163
 chrdev_open+0x4cf/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x9b1/0x1350 fs/open.c:965
 vfs_open+0x3b/0x350 fs/open.c:1097
 do_open fs/namei.c:3975 [inline]
 path_openat+0x2ef1/0x3840 fs/namei.c:4134
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6af308efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6af12ee038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f6af32e5fa0 RCX: 00007f6af308efc9
RDX: 0000000000000801 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007f6af3111f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6af32e6038 R14: 00007f6af32e5fa0 R15: 00007ffeabd8a878
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

