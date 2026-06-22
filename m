Return-Path: <linux-wireless+bounces-37975-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5KRmHhAoOWphngcAu9opvQ
	(envelope-from <linux-wireless+bounces-37975-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 14:18:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD96AF611
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 14:18:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37975-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37975-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D8CD3057752
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D62EDD6C;
	Mon, 22 Jun 2026 12:15:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205E1991D4
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 12:15:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130526; cv=none; b=FXst80pMgwe+OzH6AwkpRrelczN98iUA4pjFhdDgXJ58/EhU5fopAXNybxUD8NKSSYtefKIdkIGhgyhmYJFmcAxUxy2aqAVreEvt+FIMasEFFk970ZNoZMIlUJwuQvjgGkzKrT4fiVBW07E7aOzjjXrn6Be98zl9GYQKE0U5DlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130526; c=relaxed/simple;
	bh=iUTH8IWnPm/z1bbfDmIlJlByTLab51WLdmchf63yBXE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eHZFnZTUrs1WZAIsR8xY+DAjuJe9RsFc2NcuJ4dhKsUKwfdNGcS1Y/NNIBfrLr1X3P3KXxCSgPYcpUXy9iPBGglGZQygv7gR/doBXjFJnGSkuDsrBikVy0zYEekQxCJFIxv6bwsSusCKA8ZZDCRuoXJbVYemtdv0h/u1eiRpzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-486a2a910efso9047167b6e.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 05:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782130524; x=1782735324;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+t9IVbbOIStIDm5nW3UphHoukIuS9MqTVXcISHJjlE=;
        b=C1z6UD2yq6exjWBheBA1Jv0hMpXIQAqW4kBKXWcEVFAou2dbmArihGwD58PuZYkLtQ
         J9ZutPjIozqZktc6v9l9fSnaWfwkqgrECBrr+ppJRJLCIGiQliHwEX8w38kilWsZ/8MU
         xlXFkSJRgoYTqGblsy8AtEGW2iF5jTjV9Co7o4jQGpjxXDLpN6U0RVOpntCiwEEzk0Vf
         /ic6zMPpOG1hDUdLa9GvueiSAApGjdnzlzXxMMMj8Yv/3uaZ+YNtq2F7G9pq08b53o7C
         IyZuSG8oPk/SmJUnSodqbUZnFSz0dLWyymurVoqz7Xj7j0/E8yCUKhlcQCo7v8X7R5Cp
         nJBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vhia6Y9iyeUZOGLIR4qW4Opk7x1oLWrdIocX7Ldm3FlQDpR0U1eRS5pOu5fBjLX/WmAj1KFSTznrONzIeKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjjvC/P4Q0EnHUYM1E7b8MFEXiHlChjgsG6scDtx34/uDzaP8
	ordtXfa+g8+k+TM1RnnqqMfzAjPw/DYWnpqJOCUa/q4O4fSyRh36lodNKdOhUVVF6XAOmj6eVJ3
	PegBj6BMhWrxE5bsBMufOtE7g6swRKYS35+iZhuGhyeixkc64CKASxqFct6Y=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:250a:b0:46a:ccae:5517 with SMTP id
 5614622812f47-4896abffb92mr12335578b6e.28.1782130523947; Mon, 22 Jun 2026
 05:15:23 -0700 (PDT)
Date: Mon, 22 Jun 2026 05:15:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a39275b.5031c61f.34f2da.0003.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-use-after-free Read in
 ath9k_hif_request_firmware (2)
From: syzbot <syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=26c7945305cfa3b1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37975-lists,linux-wireless=lfdr.de,cb7ed9d85261445a0201];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,goo.gl:url,storage.googleapis.com:url,vger.kernel.org:from_smtp,appspotmail.com:email,syzkaller.appspot.com:url,googlegroups.com:email];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:toke@toke.dk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-wireless];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3BD96AF611

Hello,

syzbot found the following issue on:

HEAD commit:    1a3746ccbb0a Merge tag 'strncpy-removal-v7.2-rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153b07f2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26c7945305cfa3b1
dashboard link: https://syzkaller.appspot.com/bug?extid=cb7ed9d85261445a0201
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/634e430ffbca/disk-1a3746cc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b11553afbbe2/vmlinux-1a3746cc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fa9342aa2a9/bzImage-1a3746cc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ath9k_hif_request_firmware+0x416/0x450 drivers/net/wireless/ath/ath9k/hif_usb.c:1219
Read of size 8 at addr ffff888053c45000 by task kworker/1:8/11284

CPU: 1 UID: 0 PID: 11284 Comm: kworker/1:8 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 ath9k_hif_request_firmware+0x416/0x450 drivers/net/wireless/ath/ath9k/hif_usb.c:1219
 ath9k_hif_usb_firmware_cb+0x3f9/0x530 drivers/net/wireless/ath/ath9k/hif_usb.c:1237
 request_firmware_work_func+0x13f/0x440 drivers/base/firmware_loader/main.c:1164
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 11281:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 _kmalloc_noprof include/linux/slab.h:969 [inline]
 _kzalloc_noprof include/linux/slab.h:1286 [inline]
 ath9k_hif_usb_probe+0x30e/0x830 drivers/net/wireless/ath/ath9k/hif_usb.c:1369
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x314d/0x4af0 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5704:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2700 [inline]
 slab_free mm/slub.c:6310 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6625
 ath9k_hif_usb_disconnect+0x207/0x3c0 drivers/net/wireless/ath/ath9k/hif_usb.c:1439
 usb_unbind_interface+0x1dd/0x9e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:618 [inline]
 device_remove+0x12a/0x180 drivers/base/dd.c:610
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3961
 usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1478
 usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1d0c/0x4af0 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888053c45000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes inside of
 freed 2048-byte region [ffff888053c45000, ffff888053c45800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x53c40
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe40000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe40000 dead000000000100 dead000000000122
head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4965, tgid 4965 (klogd), ts 316220316300, free_ts 316211784975
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3289 [inline]
 allocate_slab mm/slub.c:3404 [inline]
 new_slab+0xa2/0x670 mm/slub.c:3447
 refill_objects+0xe3/0x430 mm/slub.c:7241
 refill_sheaf mm/slub.c:2827 [inline]
 __pcs_replace_empty_main+0x375/0x660 mm/slub.c:4692
 alloc_from_pcs mm/slub.c:4790 [inline]
 slab_alloc_node mm/slub.c:4924 [inline]
 __kmalloc_cache_noprof+0x48d/0x6e0 mm/slub.c:5446
 _kmalloc_noprof include/linux/slab.h:969 [inline]
 syslog_print+0xf8/0x620 kernel/printk/printk.c:1585
 do_syslog+0x5bd/0x6d0 kernel/printk/printk.c:1763
 __do_sys_syslog kernel/printk/printk.c:1855 [inline]
 __se_sys_syslog kernel/printk/printk.c:1853 [inline]
 __x64_sys_syslog+0x74/0xb0 kernel/printk/printk.c:1853
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 11284 tgid 11284 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_pages_prepare+0x586/0xd80 mm/page_alloc.c:1451
 __free_contig_range_common+0x14f/0x250 mm/page_alloc.c:6895
 __free_contig_range mm/page_alloc.c:6940 [inline]
 free_pages_bulk+0x12a/0x200 mm/page_alloc.c:5257
 vm_area_free_pages+0xad/0x2b0 mm/vmalloc.c:3439
 vfree mm/vmalloc.c:3488 [inline]
 vfree+0x107/0x750 mm/vmalloc.c:3462
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3392
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888053c44f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888053c44f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888053c45000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888053c45080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888053c45100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

