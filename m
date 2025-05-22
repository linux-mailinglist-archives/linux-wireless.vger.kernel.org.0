Return-Path: <linux-wireless+bounces-23327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32365AC153A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 22:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226A67AF60C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 20:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06C148827;
	Thu, 22 May 2025 20:04:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F69190696
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944270; cv=none; b=KbYtOYLMaLnL7jbTdlVk5+NdktiiIZ+VQ4GNiLZ6Ev0OaZSwQLBJKBkz1YDpDs5qAu7qy4zadGSvNoGI7sOW5j4cGo18BszooEhoYa4/r0k/gYJQBFme0i8nEKMCYkvGvkPi9hYDIy3GVNn7L4NKpMybncJv7vYBYqbD7sfx8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944270; c=relaxed/simple;
	bh=rV/Ro3iX2RMOfud0KrwZX3Hq/ENtf1zv5sHaVE5jOpg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dfjZB5UK2miB8UvJzju2t4VOMeDVSVcBcj2cgZ90MdjmU3jsg4dNDt0bSqHl+6ls9cnGJwrXFrCynLa4n5LXKt/QV299LdQvfy5+Y89T8YRmhAyzLnMRqE1Wi8SGQsXJZTVLRSN3T9TlYLexFhhh85jInmvyOhBKreZiFka+nrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86a5def8869so526809839f.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 13:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747944267; x=1748549067;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQqYmnl7Dt0jcW9L7a+1hbupO+yf8/+C2SKc2pOJE8U=;
        b=a7NCuIo4G7prsKOMyufcvsY6mekmuy3szWEXZO+XNtI3nNAi5zkAKLNZws6/rjV7Fk
         Ml6jNYysj/0Ejt5Kyb3BY6wipoT5Wl6iRaQlAR+EaP5FLTN6M2bAI+T92bRKyjPXScEV
         jGwIKRZGFKIVeSqnT0rRTI5Nh1/jmJT3nLp5FvLe8X911K8mo2VXcP5PAwKRLfnlxXie
         aW3mHPpTTbDugHnByOUnaTMpOIVBGASJdS1wq05qf+p5FiqoI1buoRyREE6fDp9LayZH
         2LEfFjubS5oNHbCN/ZEk93IvnfW7ojztx5gzuypW6ZQ5+VUu5PPYn7V3na7Ii0yqrjg0
         YC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+bXweXE/CwPjtxNDknPzTLW4txaSz56cDlEaB5VyC24t4UoahtlnDZ2qCB/xCQ4Zr1WwcrBpEqj/NOPY4uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykKBOjRUugk4LNEAYRIW4x386hVDTia3joidEMZFeW814qLVM2
	OGAXG9DRepvBOHOilNz6TxJwgzZklQFN1KjVzCWhjHsQRt+Ck/E45Vk+fbebpJX3pHsp4vDA5BN
	vWWEN2lFpE1kv/K1pfr3xGF7AmU4SRbyLhsCw/rmg/xZ/wrShcfH1WqId0K4=
X-Google-Smtp-Source: AGHT+IFvfHO2VnvfTIWLKtUbqi1ak+FnQOb/++fOtMXym9IHzFF71Q/LkmcVFyuTagT5zuzyTn2a2VWdPnm/+TfQ1V3sgrPCidyI
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f0c:b0:869:fc1b:2194 with SMTP id
 ca18e2360f4ac-86a24be4576mr3972513239f.6.1747944267341; Thu, 22 May 2025
 13:04:27 -0700 (PDT)
Date: Thu, 22 May 2025 13:04:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682f834b.a70a0220.1765ec.0144.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-out-of-bounds Read in mac80211_hwsim_new_radio
From: syzbot <syzbot+314853b9e8b9b3624502@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5723cc3450bc Merge tag 'dmaengine-fix-6.15' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13db41f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b197212d89c3c28
dashboard link: https://syzkaller.appspot.com/bug?extid=314853b9e8b9b3624502
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e9dbf7fa47fa/disk-5723cc34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da7091265dff/vmlinux-5723cc34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/364a1ac0c828/bzImage-5723cc34.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+314853b9e8b9b3624502@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __rhashtable_insert_fast include/linux/rhashtable.h:741 [inline]
BUG: KASAN: slab-out-of-bounds in rhashtable_insert_fast include/linux/rhashtable.h:834 [inline]
BUG: KASAN: slab-out-of-bounds in mac80211_hwsim_new_radio+0x4b81/0x54d0 drivers/net/wireless/virtual/mac80211_hwsim.c:5591
Read of size 8 at addr ffff88807c02b0b0 by task syz-executor/10418

CPU: 0 UID: 0 PID: 10418 Comm: syz-executor Not tainted 6.15.0-rc6-syzkaller-00346-g5723cc3450bc #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 __rhashtable_insert_fast include/linux/rhashtable.h:741 [inline]
 rhashtable_insert_fast include/linux/rhashtable.h:834 [inline]
 mac80211_hwsim_new_radio+0x4b81/0x54d0 drivers/net/wireless/virtual/mac80211_hwsim.c:5591
 hwsim_new_radio_nl+0xb51/0x12c0 drivers/net/wireless/virtual/mac80211_hwsim.c:6243
 genl_family_rcv_msg_doit+0x209/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16d/0x440 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 __sys_sendto+0x498/0x510 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f42501907fc
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007ffc18488b90 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f4250ee4620 RCX: 00007f42501907fc
RDX: 0000000000000024 RSI: 00007f4250ee4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc18488be4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f4250ee4670 R15: 0000000000000000
 </TASK>

Allocated by task 36:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_track_caller_noprof+0x221/0x510 mm/slub.c:4346
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
 __alloc_skb+0x166/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1340 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x2b1/0xcf0 drivers/net/netdevsim/dev.c:851
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 36:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kfree+0x2b6/0x4d0 mm/slub.c:4841
 skb_kfree_head net/core/skbuff.c:1058 [inline]
 skb_free_head+0x108/0x1d0 net/core/skbuff.c:1070
 skb_release_data+0x7a5/0x960 net/core/skbuff.c:1097
 skb_release_all net/core/skbuff.c:1162 [inline]
 __kfree_skb net/core/skbuff.c:1176 [inline]
 consume_skb net/core/skbuff.c:1408 [inline]
 consume_skb+0xbf/0x100 net/core/skbuff.c:1402
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x8bd/0xcf0 drivers/net/netdevsim/dev.c:851
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807c02a000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 176 bytes to the right of
 allocated 4096-byte region [ffff88807c02a000, ffff88807c02b000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c028
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b442140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b442140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001f00a01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 36, tgid 36 (kworker/u8:2), ts 742363181667, free_ts 742221384347
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1714
 prep_new_page mm/page_alloc.c:1722 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3684
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4966
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __do_kmalloc_node mm/slub.c:4326 [inline]
 __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4346
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
 __alloc_skb+0x166/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1340 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x2b1/0xcf0 drivers/net/netdevsim/dev.c:851
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 10539 tgid 10539 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1258 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2721
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4147 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 __do_kmalloc_node mm/slub.c:4326 [inline]
 __kmalloc_node_track_caller_noprof+0x1d3/0x510 mm/slub.c:4346
 __kmemdup_nul mm/util.c:63 [inline]
 kstrdup+0x53/0x100 mm/util.c:83
 kstrdup_const+0x63/0x80 mm/util.c:103
 kvasprintf_const+0x10f/0x1a0 lib/kasprintf.c:48
 kobject_set_name_vargs+0x5a/0x140 lib/kobject.c:274
 dev_set_name+0xc7/0x100 drivers/base/core.c:3495
 netdev_register_kobject+0xc5/0x3a0 net/core/net-sysfs.c:2323
 register_netdevice+0x13dc/0x2270 net/core/dev.c:10999
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:960 [inline]
 nsim_create+0xc70/0x10a0 drivers/net/netdevsim/netdev.c:1028
 __nsim_dev_port_add+0x42b/0x7d0 drivers/net/netdevsim/dev.c:1393
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1449 [inline]
 nsim_drv_probe+0xdca/0x1490 drivers/net/netdevsim/dev.c:1607
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:657

Memory state around the buggy address:
 ffff88807c02af80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c02b000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807c02b080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff88807c02b100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807c02b180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 10418 Comm: syz-executor Tainted: G    B               6.15.0-rc6-syzkaller-00346-g5723cc3450bc #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__rhashtable_insert_fast include/linux/rhashtable.h:741 [inline]
RIP: 0010:rhashtable_insert_fast include/linux/rhashtable.h:834 [inline]
RIP: 0010:mac80211_hwsim_new_radio+0x3740/0x54d0 drivers/net/wireless/virtual/mac80211_hwsim.c:5591
Code: 8b 6c 24 48 48 89 5c 24 70 48 8b 1c 24 4c 89 74 24 68 eb 3e e8 a1 6e c1 fa 4c 89 e0 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 <80> 3c 08 00 0f 85 2f 14 00 00 4d 8b 24 24 31 ff 45 89 e6 41 83 e6
RSP: 0018:ffffc900042df518 EFLAGS: 00010056
RAX: 0000000000000000 RBX: ffff88802547f000 RCX: dffffc0000000000
RDX: ffff88802a7d1e00 RSI: ffffffff86f9d69f RDI: 0000000000000005
RBP: 0000000000000011 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 6e696c6261736944 R12: 0000000000000000
R13: 000000000000000c R14: 0000000000000000 R15: ffff888066738e40
FS:  0000555572ad4500(0000) GS:ffff8881249e0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff7a5f3d200 CR3: 000000003b5b7000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 hwsim_new_radio_nl+0xb51/0x12c0 drivers/net/wireless/virtual/mac80211_hwsim.c:6243
 genl_family_rcv_msg_doit+0x209/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16d/0x440 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 __sys_sendto+0x498/0x510 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f42501907fc
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007ffc18488b90 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f4250ee4620 RCX: 00007f42501907fc
RDX: 0000000000000024 RSI: 00007f4250ee4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc18488be4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f4250ee4670 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__rhashtable_insert_fast include/linux/rhashtable.h:741 [inline]
RIP: 0010:rhashtable_insert_fast include/linux/rhashtable.h:834 [inline]
RIP: 0010:mac80211_hwsim_new_radio+0x3740/0x54d0 drivers/net/wireless/virtual/mac80211_hwsim.c:5591
Code: 8b 6c 24 48 48 89 5c 24 70 48 8b 1c 24 4c 89 74 24 68 eb 3e e8 a1 6e c1 fa 4c 89 e0 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 <80> 3c 08 00 0f 85 2f 14 00 00 4d 8b 24 24 31 ff 45 89 e6 41 83 e6
RSP: 0018:ffffc900042df518 EFLAGS: 00010056
RAX: 0000000000000000 RBX: ffff88802547f000 RCX: dffffc0000000000
RDX: ffff88802a7d1e00 RSI: ffffffff86f9d69f RDI: 0000000000000005
RBP: 0000000000000011 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 6e696c6261736944 R12: 0000000000000000
R13: 000000000000000c R14: 0000000000000000 R15: ffff888066738e40
FS:  0000555572ad4500(0000) GS:ffff8881249e0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff7a5f3d200 CR3: 000000003b5b7000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	8b 6c 24 48          	mov    0x48(%rsp),%ebp
   4:	48 89 5c 24 70       	mov    %rbx,0x70(%rsp)
   9:	48 8b 1c 24          	mov    (%rsp),%rbx
   d:	4c 89 74 24 68       	mov    %r14,0x68(%rsp)
  12:	eb 3e                	jmp    0x52
  14:	e8 a1 6e c1 fa       	call   0xfac16eba
  19:	4c 89 e0             	mov    %r12,%rax
  1c:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  23:	fc ff df
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	0f 85 2f 14 00 00    	jne    0x1463
  34:	4d 8b 24 24          	mov    (%r12),%r12
  38:	31 ff                	xor    %edi,%edi
  3a:	45 89 e6             	mov    %r12d,%r14d
  3d:	41                   	rex.B
  3e:	83                   	.byte 0x83
  3f:	e6                   	.byte 0xe6


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

