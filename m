Return-Path: <linux-wireless+bounces-17329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60989A09362
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D725162710
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81520FAAE;
	Fri, 10 Jan 2025 14:26:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821E320FA88
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519184; cv=none; b=IOJy3dIyX//kogwh9/QoLLCRDpJHh+MaBVfHP3HvXeQZ8i1/IOSk+LlNWfn0un9fNoRM/aslQSQcqGhblSh0zbESSdNm65/wfw+EfhigrW3jYPyQ2aXvhgYYl/5M8DlRaNll6FVg1+Di/PKrrOWtB8PB1W+mOQlRgkkop3Cvg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519184; c=relaxed/simple;
	bh=qqBakNXYvbiCQEGAfikcMrx/vc8EeodCOs13Awspa+s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mSRlC1w7pLs82+5f5lvoxRKAb8pqJtL48QDXdDvNbulqMC53IvhIq0UzJjPEWrn+Fzx+wCPGa+8PdJyxk6nvCunlw50KbgR0A+BJirRfrGR4QYxM4tcX10PAsS8kD+fVKspWORVP+hTz0fHMZylYVStZKhjOwniN4g3Xroi4Sc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3cca581135dso35664455ab.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 06:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519181; x=1737123981;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hV5fQEcBQovLfGffXD+3G1PqJGkp6eQP70KdyQTeXPc=;
        b=nOd2YAuE6MwuC/PvOF+u02S0nTbEUYd9Btmc0zR0AxfjO7w0KWiNWJuxGKcHOq2oI2
         TOb5NykXf8dEIHjG1UfNIAvz/tOq3gjIv0JgsfPZK9rqwUzyh6pHPqaHdvYYck3MwB4M
         eBDgblLqh/CxalCuK6/yS0oqu8zBRuhPwA1aGG9wPOOShgpg2WRT/j89Fz8hVZZvGOmF
         xeR7Tv24k0ma6DsWfTGFYz0y5ZifBsBQQ9fcpy2gri8i7fVn/EmmJADjgHc8x23rnRgd
         zU3x1+/5ub7At2ad8cI9BY0fn6QJ/2a8C3cQME9y4HQs+dqnScCKPO/NQt8B6oc+t7h+
         semA==
X-Forwarded-Encrypted: i=1; AJvYcCX9m2Ukv1+WJ8aa1I+LWtGmPbkl4TlgMIVZoXM6gP4P6eydMraJke+AMQn1mH21jt2bIo9EfF981SMFohAtSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmnBwf+7JNhcmVz82A/8xIx4ILlHqn1l1pGlIHJjDCA8NN5MCi
	QF74+cfBQO0ERQdpoPHYjY7b7iLaEYg8bv+22Rb6h9XsIFy/Knal8Tm91C5J61Tt0fGMvNXTLov
	eKjPFrOk3W0tbuPqyEOFkDQVcK45pxO7vu7+HlojpH+vWCSO5L8FZZlo=
X-Google-Smtp-Source: AGHT+IGvxzrD1Fzz1imV4sJt94Rv/iBg/PkrKOxggFbrZjdpV9S1o9smiknTRNG19vnQ/BxzY2ZdLOQ3RRJqClDq7VU3mnQXz2xK
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b44:b0:3a7:15aa:3fcc with SMTP id
 e9e14a558f8ab-3ce3a86a440mr96257375ab.1.1736519181753; Fri, 10 Jan 2025
 06:26:21 -0800 (PST)
Date: Fri, 10 Jan 2025 06:26:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67812e0d.050a0220.216c54.0014.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: use-after-free Read in cfg80211_shutdown_all_interfaces
From: syzbot <syzbot+9f80a60b805b070b9702@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7123c77dc60 usb: gadget: f_tcm: Refactor goto check_condi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=11a8fcc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7df994a0b7c30a9
dashboard link: https://syzkaller.appspot.com/bug?extid=9f80a60b805b070b9702
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ccb59f24626e/disk-d7123c77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b51b5c87b9dc/vmlinux-d7123c77.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f66bf96bc8cc/bzImage-d7123c77.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f80a60b805b070b9702@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in cfg80211_shutdown_all_interfaces+0x1ed/0x200 net/wireless/core.c:278
Read of size 8 at addr ffff88811b318d68 by task kworker/0:9/17903

CPU: 0 UID: 0 PID: 17903 Comm: kworker/0:9 Not tainted 6.13.0-rc4-syzkaller-00068-gd7123c77dc60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events cfg80211_rfkill_block_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 cfg80211_shutdown_all_interfaces+0x1ed/0x200 net/wireless/core.c:278
 cfg80211_rfkill_set_block net/wireless/core.c:312 [inline]
 cfg80211_rfkill_set_block net/wireless/core.c:304 [inline]
 cfg80211_rfkill_block_work+0x1e/0x30 net/wireless/core.c:324
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88811b318f00 pfn:0x11b318
flags: 0x200000000000000(node=0|zone=2)
raw: 0200000000000000 ffffea00047a7a08 ffff8881f5842ff0 0000000000000000
raw: ffff88811b318f00 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), pid 12252, tgid 12252 (kworker/0:7), ts 1567506366580, free_ts 1570817378586
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xe76/0x2b90 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x21c/0x22a0 mm/page_alloc.c:4753
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x84/0x1b0 mm/slub.c:4243
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4270
 __do_kmalloc_node mm/slub.c:4286 [inline]
 __kmalloc_noprof.cold+0xc/0x61 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 wiphy_new_nm+0x701/0x2120 net/wireless/core.c:477
 ieee80211_alloc_hw_nm+0x1b7a/0x2260 net/mac80211/main.c:830
 ieee80211_alloc_hw include/net/mac80211.h:4899 [inline]
 rtl8187_probe+0x176/0x19a0 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c:1444
 usb_probe_interface+0x300/0x9c0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
page last free pid 12252 tgid 12252 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0xe40 mm/page_alloc.c:2659
 __folio_put+0x1e8/0x2d0 mm/swap.c:112
 device_release+0xa1/0x240 drivers/base/core.c:2567
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3773
 rtl8187_disconnect+0x117/0x150 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c:1678
 usb_unbind_interface+0x1e2/0x960 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3854
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391

Memory state around the buggy address:
 ffff88811b318c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88811b318c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88811b318d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                          ^
 ffff88811b318d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88811b318e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

