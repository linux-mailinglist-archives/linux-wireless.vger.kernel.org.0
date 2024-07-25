Return-Path: <linux-wireless+bounces-10524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A57193C82A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1581C210BA
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC2619DF82;
	Thu, 25 Jul 2024 18:12:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6170DF6C
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931147; cv=none; b=IwQcEmHz+ye9U9Haf+0KeXeT+odv3/hHnFaHry4Yk53vZ127seVKPlucSDHDGmsGyKZy315yt9y7y7YWdC+8I8Gdh8t3adipotwozAaWgZ8hANox3sZBiJEvcltLxDDotwezoPrLX0himLS77Up3FesQYVLMUT8OefWn+Y47wcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931147; c=relaxed/simple;
	bh=4JTPn+J6usux6zvE5pJLxvGgaDpqYPpBK8RRL2QmkvY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PyK+LcquLVRCxkDjSEtTneZa1Zu3iFYq0L/TOTQhoeqCOMP0BBfo8fnPiY48FmoTaaBdNMKehUei8gdpC2FWoMAGponcu+l6lBgGMzfHv6DurLFZ39JUfem9QmAHxjK9wpA8vY1SgZiMgiuEdjn29vLTcQpBBqk7AEjjFCBWHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a29e7099dso3421955ab.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 11:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931145; x=1722535945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JETA834thd8Jh0rYhOK21d9SQK3wbvER8fne9A9biCs=;
        b=laEPcH8HgEwRxLM6btrNRbQJubUqi/4BEbV68dkD7ebP5tsQbbbQoXWotgyCiYs3O4
         YzI+b9J+y9VNjUF2LnzdCTnpvSiqH8Op1606EN9v6PQeIbu2EaQDretF++VJoJUps24r
         wT5y1KNYA2SHcABxn4ZBZ2ON6vEjrM5eMYF6Te8bthgYAAEGSV3fDW9/Fdx3im+WpVxT
         EeSeoVV29mdnbpA2lsB6utIbzN0X+xvJxKl/nyeAjNIA2OTp9odK68I9B6TY9/Koxxr2
         bOfCEiBYznkUTwUjMT/GoFVriVM4k+U1fM7X/EEv2HEqCtpK2IQyAxVwVWAlQB442ZD4
         oX+g==
X-Forwarded-Encrypted: i=1; AJvYcCXf5ANCP8BaQuY0XvSgDUWy49UsRKPTaAPBNrjLueTakpr2RfitkWOYwDgvyWFZw0GXNXcGR5ei0qaXDlKIVH3Q1ydC6Cermn/1ysntwrA=
X-Gm-Message-State: AOJu0Yy1qQm4YiBr1JeuFSRBkubnYzu6CHsTVpRa21Z9Yy19K5ZCXNiE
	4l1iM5lAu9R3xRt4uBJIM0TmcRNUp1En87gOa1iTlm7tww4wNYU53S+SIXm96QQ45OkdnViRsXB
	esa+N79T0FvVY/b1yHbb5NtydXf/A5zX4BKKTQtwUco/gpe6DgPFlr0g=
X-Google-Smtp-Source: AGHT+IF98dI2ibOwPmHuRUwYyhpwZzxsaoiRO5QpRK6ndGSXI7/gYLJKqci9azIV7bPslGoVmCU2jmi+cMggmqMd1ilj63zSKcLU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:380:c34a:df56 with SMTP id
 e9e14a558f8ab-39a218579d0mr3109805ab.6.1721931144955; Thu, 25 Jul 2024
 11:12:24 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:12:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000391c1d061e1656a0@google.com>
Subject: [syzbot] [wireless?] [usb?] KASAN: use-after-free Read in rtw_load_firmware_cb
From: syzbot <syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pkshih@realtek.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    933069701c1b Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=124e2b19980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f828342678294017
dashboard link: https://syzkaller.appspot.com/bug?extid=6c6c08700f9480c41fe3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1530a6c9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114aa9e6980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/22dd51445d03/disk-93306970.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f85f111961d5/vmlinux-93306970.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7971b4814e87/bzImage-93306970.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com

rtw_8822cu 1-1:15.79: Direct firmware load for rtw88/rtw8822c_wow_fw.bin failed with error -2
==================================================================
BUG: KASAN: use-after-free in rtw_load_firmware_cb+0x917/0x9f0 drivers/net/wireless/realtek/rtw88/main.c:1764
Read of size 8 at addr ffff888113598bc0 by task kworker/0:0/8

CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.10.0-syzkaller-g933069701c1b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 rtw_load_firmware_cb+0x917/0x9f0 drivers/net/wireless/realtek/rtw88/main.c:1764
 request_firmware_work_func+0x13a/0x250 drivers/base/firmware_loader/main.c:1167
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88811359d700 pfn:0x113598
flags: 0x200000000000000(node=0|zone=2)
raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff88811359d700 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 4, migratetype Unmovable, gfp_mask 0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), pid 9, tgid 9 (kworker/0:1), ts 54741596219, free_ts 54774261673
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1311/0x25f0 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x21e/0x2290 mm/page_alloc.c:4696
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x7f/0x1a0 mm/slub.c:4103
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4130
 __do_kmalloc_node mm/slub.c:4146 [inline]
 __kmalloc_noprof.cold+0xc/0x61 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 wiphy_new_nm+0x701/0x2120 net/wireless/core.c:477
 ieee80211_alloc_hw_nm+0x1b7a/0x2260 net/mac80211/main.c:828
 ieee80211_alloc_hw include/net/mac80211.h:4857 [inline]
 rtw_usb_probe+0x32/0x1d80 drivers/net/wireless/realtek/rtw88/usb.c:853
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
page last free pid 9 tgid 9 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 __free_pages_ok+0x5c1/0xba0 mm/page_alloc.c:1214
 __folio_put+0x1dc/0x260 mm/swap.c:128
 device_release+0xa1/0x240 drivers/base/core.c:2581
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fa/0x5b0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3787
 rtw_usb_probe+0x7a4/0x1d80 drivers/net/wireless/realtek/rtw88/usb.c:925
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210

Memory state around the buggy address:
 ffff888113598a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888113598b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888113598b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                           ^
 ffff888113598c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888113598c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

