Return-Path: <linux-wireless+bounces-15805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E949DEBFF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7ED1634E6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D992B19F419;
	Fri, 29 Nov 2024 18:15:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21214A60F
	for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904138; cv=none; b=vBSdc/MQ2hXLnhMmNrY6DqTrkZHoBksKonNKSDwVPjEBlBkySw94qfrGjA8PTVbFopLRY/PQEuynlUITpE8X4RrZGKovJhi2bmfhfw7An0+sUJd45yVtqD4pdun5NdrEBqbTmJm78ZSScTe4o5Rgc8546diMfaExbEHdbVrRJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904138; c=relaxed/simple;
	bh=ODrikStavoiMY7VKXZ6vjJRz2baOE58fq/U84GkXlz4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tht4WUYGp3XypLMwc5KGYM8eEgMDVl0SP5EymDTxnVART0OfzXKzNN1FWsQc85kAnqiDlHOa7mlTFu+kZLJlItNHUtZc01lTHP+hZsBEU+K+23DPhKVks72lV8e8YUGT29x3tc/nea+qbJqWtX1V6WXE0JsC9LaBO0W0txydzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a78589df29so21207035ab.2
        for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2024 10:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732904136; x=1733508936;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84075KVo47fiijVJfrB0Ak1lJCREGTv5YUnoksiNDDk=;
        b=E1RfcMIXFWMwvEJqg4SKVwDDqFaepirTdTBtnvDt+2KGLhJRaRTiQHTSsP3c+OFFUq
         AhugArFWvWnrHJb058ub2k2rrKSV6aiGC59WHVaVbY372nqPjG2cpLpmUgjekRO2AoMr
         0B7Jy42oeZjxQdNi5GHs4kAWrdokYhG/e3rhhzSUgLcBJSERNexDDQRnWfBk5Q3LXCVi
         /MIe8qN/imr5nzeE/FwL9PXiff86jCMdXUfe83/0LD7z86bLEdMm7pVrsZBGxhJ9Pqqm
         ICI0K7HlshWJIrLTzG91VWKXoDrYrCETZB6olOLVEkg6RtKnh1y8YCS8AQiShDd2dIMx
         eBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXleRw/P58ykHF1XsBdQgFFOG9EphQEiVP1vvHftIzIaNQuJvaKNcQ2YcbAMOOwjJW2exjGZYENRJ5tPXIRiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7FyIYbMM/+VZakTl6sKb94te2wdxO9csdFO2M7yeKivg7Qf9
	0gxqtc7z6i6ztma1OEbbqUwb+PI2fzidY/ZeqeVgalDfGutTV/YXUxEAAmijuhloRXwSb/XMW7i
	ei8AZuPpidUMIWEjlqaQ/aSSNQFH46NtoT9CG3eMZf5epPVXIUXGRmPU=
X-Google-Smtp-Source: AGHT+IEfcI4U46a3fb5BxRHFVEiNPHGyuhDoEemNgA7f2YUTyHDcdVRn3HvPkmB9d+uSuR2TrwHjRGJY/W26gsZ7QNgRkUtvBAI7
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3a6:cac0:1299 with SMTP id
 e9e14a558f8ab-3a7c5580a93mr105066565ab.14.1732904135338; Fri, 29 Nov 2024
 10:15:35 -0800 (PST)
Date: Fri, 29 Nov 2024 10:15:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a04c7.050a0220.253251.00bf.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in probe
From: syzbot <syzbot+5b2a06382baebaf31011@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	srini.raju@purelifi.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177d65c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bc8a5565eebec6
dashboard link: https://syzkaller.appspot.com/bug?extid=5b2a06382baebaf31011
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbaabe559df8/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fe0afceb260/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b2a06382baebaf31011@syzkaller.appspotmail.com

plfxlc 10-1:0.133: request_firmware failed (-110)
plfxlc 10-1:0.133: FPGA download failed (-110)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8769 at drivers/net/wireless/purelifi/plfxlc/mac.c:105 plfxlc_mac_release+0x89/0xb0 drivers/net/wireless/purelifi/plfxlc/mac.c:105
Modules linked in:
CPU: 0 UID: 0 PID: 8769 Comm: kworker/0:5 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: usb_hub_wq hub_event
Code: 4d 37 dc fa 48 8d bb 08 33 00 00 be ff ff ff ff e8 6c 3c 7c 04 31 ff 89 c3 89 c6 e8 71 39 dc fa 85 db 75 d4 e8 28 37 dc fa 90 <0f> 0b 90 5b 5d e9 1d 37 dc fa 48 c7 c7 74 c9 60 90 e8 a1 13 3f fb
RSP: 0018:ffffc9000355ef48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff86b2839f
RDX: ffff8880273ca440 RSI: ffffffff86b283a8 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920006abdf0
R13: ffff8880650a9000 R14: ffff8880548230a0 R15: ffff8880650a9078
FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ba1743e680 CR3: 000000000df7e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 probe+0x84a/0xba0 drivers/net/wireless/purelifi/plfxlc/usb.c:694
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

