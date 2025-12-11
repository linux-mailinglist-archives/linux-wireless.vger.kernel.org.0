Return-Path: <linux-wireless+bounces-29674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15940CB6101
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 14:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14FD03015002
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BA313529;
	Thu, 11 Dec 2025 13:41:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB443126C6
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765460486; cv=none; b=DstBofTb30/Uok3B+RJK9TGtuiVEBNzO1ITiGl9D35878cbXx9VPxMLVHonojR3YkEsdzcNBp+L7mp9QIEASDwHy6vu35fftBl+UKG/FxoHUjYUYUj03XBjxwIF3NDVE9cC8T2GCqZISOA9d4B7sK7n0Aso/765vQOCi7vRapaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765460486; c=relaxed/simple;
	bh=CDE1ttNTa5AMSgjBBmBwDvE2XcaWTCNIO92rjWyj8sE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ah4CWjRjg1YAs1hptY0MK4tJSfJ0jbKpkRYfZjdxsumsFDrItEiD9LPwpMxs9yNWvxSgTiJ2vX151jsoyO+4ashUKSvqcVTs61oAU+Q/ttbcMA74eenJpK7mpTaeWuGNe9fl4RkT7VcGOT6efe23acx7TzC1jQqNre0aAKTthrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65b2cd67cceso124953eaf.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 05:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765460484; x=1766065284;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZdhV1m8aeGU2YokLDtNvPFAfeUluHSpx/80Pd07MRPc=;
        b=EQfmqiY9Kd0SWU+zQRpj3GIDzrTcBFhkajnWo3rQh8Dzxu3YieMOcqwH76xX6LrsFN
         MoulQHuECDZhIfVKDGyYiUBd9z6Hk2cNWuBNySqW3L5EgG5aN3HQP3Nw/X6N4JjSMOSj
         d+jJvUQGHF4c7Wx4lPW0IyRJ5WuazgdLhzFy73LbTckoz4Tb2VbY5YFORfcJkUBh/ZjC
         ZgqNGuMst+GmOBDI9B9hxFeDehYEODHgKiv2Cu4p3PrpdiZKOZcEU6qzXFL18P5pxOEj
         pkDjhRuj5JI28bdgl6B5xa/iol7R1MfD8KzC4xzOYddH68aYA7DlAW35SAduxKvP59xY
         av4A==
X-Forwarded-Encrypted: i=1; AJvYcCVTnIbsVmFf54Gm85vFTqn7MxVhZ8pUFeLtN0pXvKUo+238UsH17xuD8yrt4py4yb0j1TbprER+lmebUpQR/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVESWdFNGdcE7xZ9qay14wqJF5xYaAFghvsJJe4K1hmfCYpE1K
	qv75ifegAGy1/p380xj7kgMYy38IICzkT2RPtNABP19Vc0k6d2O1rd+41MY2QtZfCtVnCudU0iV
	F2OYpBApUlJkDIb+COQvAHXy+DpCncIM1ubbBAOXjmklMq2nujk3HfrxwoQU=
X-Google-Smtp-Source: AGHT+IGNnZYJRKkVKEoqr1aOebOWcitP/eJc29wiPAqSj9kqrQC8LVU+8N0bc9k787UTSjA5rJaWEWXkMS8eEhLrT67SHYwSjOZO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3084:b0:659:9a49:8ff5 with SMTP id
 006d021491bc7-65b2accaa61mr3088477eaf.34.1765460484238; Thu, 11 Dec 2025
 05:41:24 -0800 (PST)
Date: Thu, 11 Dec 2025 05:41:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693aca04.050a0220.4004e.0346.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in __alloc_workqueue
From: syzbot <syzbot+392a2c3f461094707435@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pkshih@realtek.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    37bb2e7217b0 Merge tag 'staging-6.19-rc1' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=125bceb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e79f218bc0cd167b
dashboard link: https://syzkaller.appspot.com/bug?extid=392a2c3f461094707435
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1046f21a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b9521a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26124775173b/disk-37bb2e72.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd4182168b83/vmlinux-37bb2e72.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a78be0ee345d/bzImage-37bb2e72.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+392a2c3f461094707435@syzkaller.appspotmail.com

usb 3-1: SerialNumber: syz
usb 3-1: config 0 descriptor??
------------[ cut here ]------------
WARNING: kernel/workqueue.c:5701 at __alloc_workqueue+0x114c/0x1810 kernel/workqueue.c:5701, CPU#0: kworker/0:2/121
Modules linked in:
CPU: 0 UID: 0 PID: 121 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:__alloc_workqueue+0x114c/0x1810 kernel/workqueue.c:5701
Code: e9 de fc ff ff 48 c7 44 24 08 e8 55 e8 88 e9 8f f6 ff ff 41 be 08 00 00 00 41 bd 00 04 00 00 e9 53 f1 ff ff e8 a5 9a 34 00 90 <0f> 0b 90 31 ed e9 af fc ff ff e8 95 9a 34 00 90 0f 0b 90 31 ed e9
RSP: 0018:ffffc900014aedf8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffffff814b4179
RDX: ffff88810caa9d40 RSI: ffffffff814b527b RDI: 0000000000000005
RBP: ffffc900014aef60 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: ffff88810caaa7e8 R12: 0000000000000003
R13: 0000000000000000 R14: ffffffff87e3cc20 R15: ffffc900014aeea0
FS:  0000000000000000(0000) GS:ffff888268bf5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8d89852a60 CR3: 0000000117746000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 alloc_workqueue_noprof+0xd2/0x200 kernel/workqueue.c:5820
 rtw_usb_init_rx drivers/net/wireless/realtek/rtw88/usb.c:968 [inline]
 rtw_usb_probe+0x13bf/0x2d10 drivers/net/wireless/realtek/rtw88/usb.c:1295
 usb_probe_interface+0x303/0xa80 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xb20 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x470 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x350 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4e0 drivers/base/dd.c:1031
 device_initial_probe+0xaa/0xc0 drivers/base/dd.c:1086
 bus_probe_device+0x64/0x150 drivers/base/bus.c:574
 device_add+0x116e/0x1980 drivers/base/core.c:3689
 usb_set_configuration+0x1187/0x1e50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xb20 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x470 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x350 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4e0 drivers/base/dd.c:1031
 device_initial_probe+0xaa/0xc0 drivers/base/dd.c:1086
 bus_probe_device+0x64/0x150 drivers/base/bus.c:574
 device_add+0x116e/0x1980 drivers/base/core.c:3689
 usb_new_device+0xd07/0x1a90 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x31bf/0x5420 drivers/usb/core/hub.c:5953
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x74f/0xa30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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

