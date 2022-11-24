Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C180637254
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 07:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKXGYl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 01:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKXGYi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 01:24:38 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495CFBB5DB
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 22:24:34 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h10-20020a056e021b8a00b00302671bb5fdso666793ili.21
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 22:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvurK3vPeolq8+l22wZqEza2FpxKDON9MY1XG+dbjbs=;
        b=MJZYPo+rZwpjxOSGIFoje6WIfPTtkFbZrNKth2xX5AS4/VWMh3zdss2FrMyf0jYqzm
         DSneWRIjzK+pNxPePEuY7Cokv1iiF95yegSkH8xau4bjHwYkOSLvIQtMbGYReSKQOeqe
         ZMcdGnkCapEYJhcS6qv5BEY7tmOqrkcnTnzFJcLWUNKkV3ML34/HcCNkDz/qWjE7uovR
         9HFYvJpm2rMQ/OhpGtCneP23w8giKfVcXHVICeyQ/ZU3V9efFm4z/98y+NBKCcPavk0L
         6AKzH3CL8QJ/pN5GdsIzMsFK/MlnRKpiUXGZg3uNtt03+iute3eMxN8LsZyCA3NxsTZz
         +lrA==
X-Gm-Message-State: ANoB5pmk2nHDxqfy/r53oIWKYcWftfC1e/bPd7ZfTthJCeEHLDyAgR2w
        q7qoF7G+kvgPVeiU+ZqUiVD4xX5r9I+oJEsv8ueKU/jNNWff
X-Google-Smtp-Source: AA0mqf54blPo68qW5pSmONCjN+L4K7nIJqOAtBaGIFm7aRmOKxqM1ZYC9gK3njOh5vZufoBEzSI2vvFa6mR+GVGxnozyiSvhTHey
MIME-Version: 1.0
X-Received: by 2002:a02:cc2a:0:b0:372:bf99:b645 with SMTP id
 o10-20020a02cc2a000000b00372bf99b645mr5953173jap.278.1669271075227; Wed, 23
 Nov 2022 22:24:35 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:24:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000790da005ee3175a8@google.com>
Subject: [syzbot] KASAN: use-after-free Read in rfkill_blocked
From:   syzbot <syzbot+0299462c067009827b2a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11196d0d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
dashboard link: https://syzkaller.appspot.com/bug?extid=0299462c067009827b2a
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0299462c067009827b2a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x8ee/0x333e kernel/locking/lockdep.c:4897
Read of size 8 at addr ffffaf8024249018 by task syz-executor.0/7946

CPU: 0 PID: 7946 Comm: syz-executor.0 Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
[<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
[<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
[<ffffffff8047479e>] print_address_description.constprop.0+0x2a/0x330 mm/kasan/report.c:255
[<ffffffff80474d4c>] __kasan_report mm/kasan/report.c:442 [inline]
[<ffffffff80474d4c>] kasan_report+0x184/0x1e0 mm/kasan/report.c:459
[<ffffffff80475b20>] check_region_inline mm/kasan/generic.c:183 [inline]
[<ffffffff80475b20>] __asan_load8+0x6e/0x96 mm/kasan/generic.c:256
[<ffffffff80112b70>] __lock_acquire+0x8ee/0x333e kernel/locking/lockdep.c:4897
[<ffffffff80116582>] lock_acquire.part.0+0x1d0/0x424 kernel/locking/lockdep.c:5639
[<ffffffff8011682a>] lock_acquire+0x54/0x6a kernel/locking/lockdep.c:5612
[<ffffffff831afa2c>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
[<ffffffff831afa2c>] _raw_spin_lock_irqsave+0x3e/0x62 kernel/locking/spinlock.c:162
[<ffffffff83034f0a>] rfkill_blocked+0x22/0x62 net/rfkill/core.c:941
[<ffffffff830b8862>] nfc_dev_up+0x8e/0x26c net/nfc/core.c:102
[<ffffffff830bb742>] nfc_genl_dev_up+0x5e/0x8a net/nfc/netlink.c:770
[<ffffffff8296f9ae>] genl_family_rcv_msg_doit+0x19a/0x23c net/netlink/genetlink.c:731
[<ffffffff82970420>] genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
[<ffffffff82970420>] genl_rcv_msg+0x236/0x3ba net/netlink/genetlink.c:792
[<ffffffff8296ded2>] netlink_rcv_skb+0xf8/0x2be net/netlink/af_netlink.c:2494
[<ffffffff8296ecb2>] genl_rcv+0x36/0x4c net/netlink/genetlink.c:803
[<ffffffff8296cbcc>] netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
[<ffffffff8296cbcc>] netlink_unicast+0x40e/0x5fe net/netlink/af_netlink.c:1343
[<ffffffff8296d29c>] netlink_sendmsg+0x4e0/0x994 net/netlink/af_netlink.c:1919
[<ffffffff826d264e>] sock_sendmsg_nosec net/socket.c:705 [inline]
[<ffffffff826d264e>] sock_sendmsg+0xa0/0xc4 net/socket.c:725
[<ffffffff826d4dd4>] ____sys_sendmsg+0x46e/0x484 net/socket.c:2413
[<ffffffff826d8bca>] ___sys_sendmsg+0x16c/0x1f6 net/socket.c:2467
[<ffffffff826d8e78>] __sys_sendmsg+0xba/0x150 net/socket.c:2496
[<ffffffff826d8f3a>] __do_sys_sendmsg net/socket.c:2505 [inline]
[<ffffffff826d8f3a>] sys_sendmsg+0x2c/0x3a net/socket.c:2503
[<ffffffff80005716>] ret_from_syscall+0x0/0x2

Allocated by task 7946:
 stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0x80/0xb2 mm/kasan/common.c:524
 kasan_kmalloc include/linux/kasan.h:270 [inline]
 __kmalloc+0x190/0x318 mm/slub.c:4424
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:715 [inline]
 rfkill_alloc+0x96/0x1aa net/rfkill/core.c:983
 nfc_register_device+0xe4/0x29e net/nfc/core.c:1129
 nci_register_device+0x538/0x612 net/nfc/nci/core.c:1252
 virtual_ncidev_open+0x82/0x12c drivers/nfc/virtual_ncidev.c:143
 misc_open+0x272/0x2c8 drivers/char/misc.c:141
 chrdev_open+0x1d4/0x478 fs/char_dev.c:414
 do_dentry_open+0x2a4/0x7d4 fs/open.c:824
 vfs_open+0x52/0x5e fs/open.c:959
 do_open fs/namei.c:3476 [inline]
 path_openat+0x12b6/0x189e fs/namei.c:3609
 do_filp_open+0x10e/0x22a fs/namei.c:3636
 do_sys_openat2+0x174/0x31e fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 sys_openat+0xdc/0x164 fs/open.c:1241
 ret_from_syscall+0x0/0x2

Freed by task 7944:
 stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
 kasan_set_track+0x1a/0x26 mm/kasan/common.c:45
 kasan_set_free_info+0x1e/0x3a mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x15e/0x180 mm/kasan/common.c:328
 __kasan_slab_free+0x10/0x18 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8e/0x1cc mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xe0/0x3e4 mm/slub.c:4562
 rfkill_release+0x20/0x2a net/rfkill/core.c:831
 device_release+0x66/0x148 drivers/base/core.c:2229
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1bc/0x38e lib/kobject.c:753
 put_device+0x28/0x3a drivers/base/core.c:3512
 rfkill_destroy+0x2a/0x3c net/rfkill/core.c:1142
 nfc_unregister_device+0xac/0x232 net/nfc/core.c:1167
 nci_unregister_device+0x168/0x182 net/nfc/nci/core.c:1298
 virtual_ncidev_close+0x9c/0xbc drivers/nfc/virtual_ncidev.c:163
 __fput+0x164/0x502 fs/file_table.c:311
 ____fput+0x1a/0x24 fs/file_table.c:344
 task_work_run+0xdc/0x154 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 do_notify_resume+0x894/0xa56 arch/riscv/kernel/signal.c:320
 ret_from_exception+0x0/0x10

Last potentially related work creation:
 stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xc4/0xdc mm/kasan/generic.c:348
 kasan_record_aux_stack_noalloc+0xe/0x16 mm/kasan/generic.c:358
 insert_work+0x40/0x1d4 kernel/workqueue.c:1368
 __queue_work+0x4ec/0xed0 kernel/workqueue.c:1534
 queue_work_on+0xe8/0xfe kernel/workqueue.c:1562
 queue_work include/linux/workqueue.h:502 [inline]
 schedule_work include/linux/workqueue.h:563 [inline]
 rfkill_register+0x46e/0x60e net/rfkill/core.c:1089
 nfc_register_device+0x10a/0x29e net/nfc/core.c:1132
 nci_register_device+0x538/0x612 net/nfc/nci/core.c:1252
 virtual_ncidev_open+0x82/0x12c drivers/nfc/virtual_ncidev.c:143
 misc_open+0x272/0x2c8 drivers/char/misc.c:141
 chrdev_open+0x1d4/0x478 fs/char_dev.c:414
 do_dentry_open+0x2a4/0x7d4 fs/open.c:824
 vfs_open+0x52/0x5e fs/open.c:959
 do_open fs/namei.c:3476 [inline]
 path_openat+0x12b6/0x189e fs/namei.c:3609
 do_filp_open+0x10e/0x22a fs/namei.c:3636
 do_sys_openat2+0x174/0x31e fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 sys_openat+0xdc/0x164 fs/open.c:1241
 ret_from_syscall+0x0/0x2

The buggy address belongs to the object at ffffaf8024249000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 24 bytes inside of
 2048-byte region [ffffaf8024249000, ffffaf8024249800)
The buggy address belongs to the page:
page:ffffaf807b073440 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa4448
head:ffffaf807b073440 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xa000010200(slab|head|section=20|node=0|zone=0)
raw: 000000a000010200 0000000000000100 0000000000000122 ffffaf8007202000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
raw: 00000000000007ff
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 3932, ts 2633362768300, free_ts 2631908277000
 __set_page_owner+0x48/0x136 mm/page_owner.c:183
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0xd0/0x10a mm/page_alloc.c:2427
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0x8da/0x12d8 mm/page_alloc.c:4165
 __alloc_pages+0x150/0x3b6 mm/page_alloc.c:5389
 alloc_pages+0x132/0x2a6 mm/mempolicy.c:2271
 alloc_slab_page.constprop.0+0xc2/0xfa mm/slub.c:1799
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x25a/0x2cc mm/slub.c:2004
 ___slab_alloc+0x56e/0x918 mm/slub.c:3018
 __slab_alloc.constprop.0+0x50/0x8c mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 __kmalloc_node_track_caller+0x26c/0x362 mm/slub.c:4957
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0xee/0x2e4 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1158 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 rtmsg_ifinfo_build_skb+0x62/0x142 net/core/rtnetlink.c:3829
 unregister_netdevice_many+0x7dc/0xf50 net/core/dev.c:10419
 default_device_exit_batch+0x28a/0x2dc net/core/dev.c:10945
 ops_exit_list+0xcc/0xe8 net/core/net_namespace.c:173
 cleanup_net+0x430/0x732 net/core/net_namespace.c:597
page last free stack trace:
 __reset_page_owner+0x4a/0xea mm/page_owner.c:142
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x29c/0x45e mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x6a/0x31e mm/page_alloc.c:3404
 free_the_page mm/page_alloc.c:706 [inline]
 __free_pages+0xe2/0x112 mm/page_alloc.c:5474
 __free_slab+0x122/0x27c mm/slub.c:2028
 free_slab mm/slub.c:2043 [inline]
 discard_slab+0x4c/0x7a mm/slub.c:2049
 __unfreeze_partials+0x16a/0x18e mm/slub.c:2536
 put_cpu_partial+0xf6/0x162 mm/slub.c:2612
 __slab_free+0x166/0x29c mm/slub.c:3378
 do_slab_free mm/slub.c:3497 [inline]
 ___cache_free+0x17c/0x354 mm/slub.c:3516
 qlink_free mm/kasan/quarantine.c:157 [inline]
 qlist_free_all+0x7c/0x132 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x14c/0x1c8 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x5c/0x98 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 kmem_cache_alloc_node+0x368/0x41c mm/slub.c:3266
 __alloc_skb+0x234/0x2e4 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1158 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 inet6_netconf_notify_devconf+0xb6/0x1f2 net/ipv6/addrconf.c:584

Memory state around the buggy address:
 ffffaf8024248f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffaf8024248f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffffaf8024249000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffffaf8024249080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffffaf8024249100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
