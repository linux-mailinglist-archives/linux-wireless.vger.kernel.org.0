Return-Path: <linux-wireless+bounces-15920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D83C9E512F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 10:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48918287C50
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD461D54C2;
	Thu,  5 Dec 2024 09:22:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C71D4612
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390545; cv=none; b=YtA+skUz8QbDeJwu7V8fVIkI7QULOJ/QKAyG3x4qRFXNumfp6hJme4SFqVR11+waNZWvnOQCC/xAySZXsvNcY+67OKFPxfO4Eu7tNArxlScsGun7cNPkKSGPtCHjVKyKVjuOXs1WY4xkyI2TD3AqpItHJgmxrlPK0ioqimj/SYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390545; c=relaxed/simple;
	bh=SmJNovRLTsLjhiKYfN39AmtFOzCx7KjE0te1DW8Dcmk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hjIo6aZBb49io3ZasddhK4Fus93KNu/ymGMXQ57G0o/otqMLJuDrwSus67liwjUc/e+cSBBFRpGrfpDYofoAnYCASdYhms2pxpu7MbIIGII4ZyldK/BmWLAqy5Q3yU6VPhO+1tZPp0v221bKhxTc67JGwG04wXRjVAg97LThf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-841ac3f9391so61562439f.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 01:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733390543; x=1733995343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OA2+yQRetYYzq/Y3/OKLhUDtYjSyb6+PCtrKpCQJjo=;
        b=GY2zRRlEh9lZbmzyLc5Xo445Ud07MOA/tCrTrZwpXp6R0PGfoxskwRjk12BYWHCErf
         DlvTjCAKeaYTpBDaPmcmWdGnsaG0FMfdW+58TmnNC7UoOSZIi/0tR8995pCKT9Zu0cjg
         3eG1xfX5HJ/3N5gW9fdBnOoizgJRPIoAe/TaOeXDoqwmW360gKHZVPUZQ9WEDKjkuhr6
         RlMGmMogKMAY5TSPBWGMtuoAZRRdsHmOIVycX3FjkRCklQF1di3c1/o9vHgzDrKvL0KQ
         0Dtz17U6yqJtcisIPdl0HBkvt9oBIreGPGRRbpkgwuipsfZrY1YgWw7XeuYlcA+N/Xdd
         aKhg==
X-Forwarded-Encrypted: i=1; AJvYcCWLHV8lHFyLGCxy4Ezd4S1o7VD0fjF2igSGB2tsrgJgCloitPElzuqPoWZ5aGMyCjJMgY85sBTzRL7D094Q4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDQ7R0SmJ5R3uBQeunleb9yDQGc4QPstn17q+DdWuTVycJRxW
	GYFie6wUH+DLycZBOSx2PIYPE22EcwYdlRhMsV+2I3WJNyJvRkidxcA5685YSS4hnPtxigBzwq5
	QyKLjWQkra6MKWuagsO+c2xaccwQdgwGdA38we29HjuxTJErTZB/rMP4=
X-Google-Smtp-Source: AGHT+IG+5VTsoXWh4ELsfn4ooKxMjdPbqAacQUCouWvGvr6gh/6SFGxjaTcA5IyUF3dYQBeqzNO6OsCbMA5hi7L+YSBLw1/94prW
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1529:b0:3a7:81c6:be7e with SMTP id
 e9e14a558f8ab-3a7f9a55b85mr128391545ab.13.1733390543234; Thu, 05 Dec 2024
 01:22:23 -0800 (PST)
Date: Thu, 05 Dec 2024 01:22:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675170cf.050a0220.17bd51.0095.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-use-after-free Read in ath9k_hif_request_firmware
From: syzbot <syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ba9f676d0a2 Merge tag 'drm-next-2024-11-29' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169900df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7903df3280dd39ea
dashboard link: https://syzkaller.appspot.com/bug?extid=50122cbc2874b1eb25b0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7db3160fdff0/disk-2ba9f676.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b3dcf97efe59/vmlinux-2ba9f676.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ee688dbbadf/bzImage-2ba9f676.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ath9k_hif_request_firmware+0x390/0x4e0
Read of size 8 at addr ffff888011969000 by task kworker/1:4/5889

CPU: 1 UID: 0 PID: 5889 Comm: kworker/1:4 Not tainted 6.12.0-syzkaller-11677-g2ba9f676d0a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 ath9k_hif_request_firmware+0x390/0x4e0
 ath9k_hif_usb_firmware_cb+0x2ad/0x4b0 drivers/net/wireless/ath/ath9k/hif_usb.c:1247
 request_firmware_work_func+0x1a4/0x280 drivers/base/firmware_loader/main.c:1196
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 51:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ath9k_hif_usb_probe+0x439/0xb80 drivers/net/wireless/ath/ath9k/hif_usb.c:1379
 usb_probe_interface+0x641/0xbb0 drivers/usb/core/driver.c:396
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:534
 device_add+0x856/0xbf0 drivers/base/core.c:3665
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:254
 usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:291
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:534
 device_add+0x856/0xbf0 drivers/base/core.c:3665
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d6d/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 51:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x430 mm/slub.c:4746
 ath9k_hif_usb_disconnect+0x1c6/0x250 drivers/net/wireless/ath/ath9k/hif_usb.c:1452
 usb_unbind_interface+0x25b/0x940 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3854
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1418
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1ebc/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888011969000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes inside of
 freed 2048-byte region [ffff888011969000, ffff888011969800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11968
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac42000 ffffea00009b7a00 dead000000000002
raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac42000 ffffea00009b7a00 dead000000000002
head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000465a01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10158, tgid 10158 (syz-executor), ts 275172754099, free_ts 275034504886
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ip_fib_net_init net/ipv4/fib_frontend.c:1556 [inline]
 fib_net_init+0x13d/0x360 net/ipv4/fib_frontend.c:1615
 ops_init+0x31e/0x590 net/core/net_namespace.c:138
 setup_net+0x287/0x9e0 net/core/net_namespace.c:362
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:500
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x57d/0xa70 kernel/fork.c:3334
page last free pid 5936 tgid 5936 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 discard_slab mm/slub.c:2673 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3142
 put_cpu_partial+0x17c/0x250 mm/slub.c:3217
 __slab_free+0x2ea/0x3d0 mm/slub.c:4468
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 __kmalloc_cache_noprof+0x1d9/0x390 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:547 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x19c5/0x4130 drivers/net/netdevsim/fib.c:1493
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888011968f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888011968f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888011969000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888011969080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888011969100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

