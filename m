Return-Path: <linux-wireless+bounces-17667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6169A15993
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 23:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CC31882347
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595801DA10E;
	Fri, 17 Jan 2025 22:44:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0AF1BE87B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153862; cv=none; b=oL2zFV3CY52mv0LsH1/iUg9D9M9DCKjIXsy+cYg9dZGqHjD8XEdc5XoBvGMETjHmWeN/fKsVawZYw8d+t5kjk1DMOE5v16mf/NBTaaLPQLDhSEnMyI8/K2bUpmHfOu5Ru8BGIm/xkxs+NpklK+Mw04YjW9PeFZAiBT/XXpfMT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153862; c=relaxed/simple;
	bh=sHlR9V1r6jP9xFsceVsELkCDS3kR96/2CujWA8btVsg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NbrQHrl1BOiC7r1YxnLATz/CdWhZ0EOS+MKG21Igb/4fE+FnUI80w/5qwrqF1D7to/mQiOJu4yxNzczKerNmAcXmwp8bdqB2LuKCN/2AP+VFvtQ6raEq//+baIroMj5CEpyyTf1oQuj4y8rg22TofgnkN4nBh/cuWif2rerqLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cf6ceaccdbso17617645ab.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 14:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737153859; x=1737758659;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7RrhgjZYtvPZcYAN5b0RCSWkhBjOlEmR5OPIQjnKXQ=;
        b=OIJFxIJNn3VG2yQlmmk0ITwmjVfz6wqomJflNyX15YIY62ZIbf+dwGEo2PGFGiYtU3
         zUiwa0RFVwoM/ONG5sgeiZi73RLTIIOLL/18cVEoYf7V0PcBaAndF3IHN6zmLivQZfLL
         fqKv83OzwNhot8/rIhFmw8I04DQw1t/QwPMPQ9AyE3z/Z8TsbrlJS65ITrscrGfM5THx
         ccHAlnOK5rtb/23wgkvRUglXOI++5sfJgnzA9wqtc+LJ6z3gEJHrs/dtrIjkz81g6vW6
         bwUT4wiQWUScGmEss/a5vaJLpYCf/V8DMvdwO2DzPtlcm1cXkcBUGFZJMmDG/mLy3L61
         0wMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmBvekU17x1OvcSZ28pDzsRs7LhkKcv5eQ3SWZDBzZXLqBRuqPbg3cHqn4oj3I9d7yIvoOQfDupFk7NC1D1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2RuH6zmMe1vkXpYZFBCnH0o5w3l7g/vZuer0W78j6WeX7l1RD
	8YQSmuoqAOI8MI3ZDG2j27br4MynhJDCgb7wiTRmk5Dl/T5InBenrUB/WtTqoga5X6YqCIvUrSi
	E2kbPNjERkzqQgkIn5X4mO8GhdO35XBJXeokceKs/dqwIGxks6RD3QNA=
X-Google-Smtp-Source: AGHT+IGUrxAw+btpJ1VSdv/ZGL704SgMRa0RjYKrpW1c1Z8LRmA4x5q+qM+/tHdULQK3jI0lRxW5K2oMVn4ZjnXkkqHqLyY3xtzw
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26b:0:b0:3ce:7ac0:64ce with SMTP id
 e9e14a558f8ab-3cf74495f72mr41048905ab.18.1737153859687; Fri, 17 Jan 2025
 14:44:19 -0800 (PST)
Date: Fri, 17 Jan 2025 14:44:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678add43.050a0220.303755.0016.GAE@google.com>
Subject: [syzbot] [bluetooth?] [wireless?] WARNING in free_netdev (2)
From: syzbot <syzbot+85ff1051228a04613a32@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d20dcda404d selftests: drv-net-hw: inject pp_alloc_fail e..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ffc2b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c30f048a4f12891
dashboard link: https://syzkaller.appspot.com/bug?extid=85ff1051228a04613a32
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ffc2b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ce07c743ced/disk-8d20dcda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/66f2a9a35d5e/vmlinux-8d20dcda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c790c086a46/bzImage-8d20dcda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85ff1051228a04613a32@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 5961 at kernel/locking/mutex.c:564 __mutex_lock_common kernel/locking/mutex.c:564 [inline]
WARNING: CPU: 1 PID: 5961 at kernel/locking/mutex.c:564 __mutex_lock+0xdac/0xee0 kernel/locking/mutex.c:735
Modules linked in:
CPU: 1 UID: 0 PID: 5961 Comm: syz-executor Not tainted 6.13.0-rc7-syzkaller-01131-g8d20dcda404d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:564 [inline]
RIP: 0010:__mutex_lock+0xdac/0xee0 kernel/locking/mutex.c:735
Code: 0f b6 04 38 84 c0 0f 85 1a 01 00 00 83 3d 6f 40 4c 04 00 75 19 90 48 c7 c7 60 84 0a 8c 48 c7 c6 00 85 0a 8c e8 f5 dc 91 f5 90 <0f> 0b 90 90 90 e9 c7 f3 ff ff 90 0f 0b 90 e9 29 f8 ff ff 90 0f 0b
RSP: 0018:ffffc90003987580 EFLAGS: 00010246
RAX: ef7de89246652d00 RBX: ffff888029dc0cb0 RCX: ffff888025ad3c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003987710 R08: ffffffff81602ac2 R09: 1ffff110170e519a
R10: dffffc0000000000 R11: ffffed10170e519b R12: 0000000000000000
R13: 0000000000000000 R14: 1ffff92000730ec4 R15: dffffc0000000000
FS:  000055558b849500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffad944418 CR3: 00000000336ec000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netdev_lock include/linux/netdevice.h:2691 [inline]
 __netif_napi_del include/linux/netdevice.h:2829 [inline]
 netif_napi_del include/linux/netdevice.h:2848 [inline]
 free_netdev+0x2d9/0x610 net/core/dev.c:11621
 netdev_run_todo+0xf21/0x10d0 net/core/dev.c:11189
 nsim_destroy+0x3c3/0x620 drivers/net/netdevsim/netdev.c:1028
 __nsim_dev_port_del+0x14b/0x1b0 drivers/net/netdevsim/dev.c:1428
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1440 [inline]
 nsim_dev_reload_destroy+0x28a/0x490 drivers/net/netdevsim/dev.c:1661
 nsim_drv_remove+0x58/0x160 drivers/net/netdevsim/dev.c:1676
 device_remove drivers/base/dd.c:567 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x4a9/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3854
 device_unregister+0x20/0xc0 drivers/base/core.c:3895
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:462 [inline]
 del_device_store+0x363/0x480 drivers/net/netdevsim/bus.c:226
 kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f44ce1847df
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007ffde8b7b2a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f44ce1847df
RDX: 0000000000000001 RSI: 00007ffde8b7b2f0 RDI: 0000000000000005
RBP: 00007f44ce202d15 R08: 0000000000000000 R09: 00007ffde8b7b0f7
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 00007ffde8b7b2f0 R14: 00007f44ceea4620 R15: 0000000000000003
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

