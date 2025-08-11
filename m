Return-Path: <linux-wireless+bounces-26274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DADB2150A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B30419013A0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCAE2E2EF9;
	Mon, 11 Aug 2025 18:59:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CC2E2DE5
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938773; cv=none; b=B5bFl+3OTmqmjBocj+BQe6rDxAB+c5EJXyJtdffsZsUCohH/Q1qtrsc2kHFuuPwWScj7J+iKMwsG2R5PRsRDdky/cf5mpQqjGCo2zI55ZhT5TEodSeWMVpayNTrk8nsEGMNdxGJaBajnY+moc4pxPaszlwmSKQ2Pq0iKXtOuqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938773; c=relaxed/simple;
	bh=RR4RY40LyLGxuzencW3otpe4uq9XZ8ze/HFu7iwBnUI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V8WD+/4OmA/j694vrovxbQtnJpvumN4mY0A9PGT0hprz9Ltx7FRmlKkWZdOUxYMaYevZoDFx2buoiJfoNs38QV8bPwfAhYrtHNPCb+LWpXZSW9eWA/oDS2fwuOcSzounAmT3bUSSHTBW0Rbrhm3roikRpMR71PXUSXG8FBmrVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86463467dddso474184139f.3
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 11:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754938771; x=1755543571;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6xFbPZe0HwWc3ZbGjhMq/NmNbdAPZ6NGa5AYygBZvY=;
        b=NvCNrofuFFzvX7KZVj3uqY1BfdE3v24h0gIuWwOj/QVMPjrYiLvZGUc8EHzdUz0gWb
         mIojpulsIDzB/m2os6cCECDw9qeQAqsoS2PqqjlmZXYLuiNvIYz1RIXdYrtHByYWJCnn
         keA9Cb0kCehuRBb28d5NEoDMkYXto4571YpAprpx8I8tR6d2/m40lQNVxrNiIgEfPcro
         hWWXl20DKb2gCSRA0CD8TMdj8RDmR3w0r1KyNM0n5aPERt4bHdPlNdWtY/lJ2atgiOl9
         z+VbhRCCwU38SXh5Wo8FAX2DtF+eRWIpN8SrQp1tU1EUhYACOMzS3Q5o8tj1C/cLaAJN
         jUlA==
X-Forwarded-Encrypted: i=1; AJvYcCWLp3tyDrohsTr1bhU2AgOkOpJ6mcsslhhH+PfdgxPl/ihFAlESRMcQOxGtndbNtbH0ttyeLD8WLEfdApQ52Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBeTkBELpTHlifWsrRzFkkI6sllIj8Rm4LozuudcMw37xtRYi
	23rPkLqZVkAYuxnKHxMh5SNQpnD2z/ixrhrscH52ox/PX96O3SiujH9PjSv8gZLQxOGLNO78+gL
	HtSxIBUjnpmffv63Cas13SBB5TUgBzGephNWXTrk+cMLDLhfR2Lm9EMhJvgM=
X-Google-Smtp-Source: AGHT+IFo1XhCxFqcaHX4jHSPGgaJJoUardHybCOGuV2MX1kF5Upkq0zoLt9HashddZTU58m2I9Vd/4+pA6ZkdDvEGOSs5IEHJBQA
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc4:b0:86c:f3aa:8199 with SMTP id
 ca18e2360f4ac-883f1260345mr2592913239f.11.1754938771037; Mon, 11 Aug 2025
 11:59:31 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:59:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689a3d93.050a0220.7f033.0100.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-use-after-free Read in cmp_bss
From: syzbot <syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c30a13538d9f Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17840842580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e143c1cd9dadd720
dashboard link: https://syzkaller.appspot.com/bug?extid=30754ca335e6fb7e3092
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1766fea2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e709a2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c30a1353.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8cefa7e1536e/vmlinux-c30a1353.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68b8ee3da77f/bzImage-c30a1353.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in cmp_bss+0xd4d/0xe80 net/wireless/scan.c:1504
Read of size 4 at addr ffff88804b2de518 by task kworker/u4:3/38

CPU: 0 UID: 0 PID: 38 Comm: kworker/u4:3 Not tainted 6.16.0-syzkaller-12250-gc30a13538d9f #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 cmp_bss+0xd4d/0xe80 net/wireless/scan.c:1504
 rb_find_bss net/wireless/scan.c:1693 [inline]
 __cfg80211_bss_update+0xdb/0x2120 net/wireless/scan.c:1980
 cfg80211_inform_single_bss_data+0xba9/0x1ac0 net/wireless/scan.c:2375
 cfg80211_inform_bss_data+0x1fb/0x3b30 net/wireless/scan.c:3234
 cfg80211_inform_bss_frame_data+0x3d7/0x730 net/wireless/scan.c:3325
 ieee80211_bss_info_update+0x746/0x9e0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info+0x176/0x280 net/mac80211/mlme.c:6564
 ieee80211_rx_mgmt_probe_resp net/mac80211/mlme.c:6607 [inline]
 ieee80211_sta_rx_queued_mgmt+0x1294/0x4470 net/mac80211/mlme.c:8089
 ieee80211_iface_process_skb net/mac80211/iface.c:1696 [inline]
 ieee80211_iface_work+0x652/0x12d0 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x2b8/0x470 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 3103:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 cfg80211_inform_single_bss_data+0x905/0x1ac0 net/wireless/scan.c:2351
 cfg80211_inform_bss_data+0x1fb/0x3b30 net/wireless/scan.c:3234
 cfg80211_inform_bss_frame_data+0x3d7/0x730 net/wireless/scan.c:3325
 ieee80211_bss_info_update+0x746/0x9e0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info+0x176/0x280 net/mac80211/mlme.c:6564
 ieee80211_rx_mgmt_beacon+0x197d/0x2cd0 net/mac80211/mlme.c:7513
 ieee80211_sta_rx_queued_mgmt+0x4ed/0x4470 net/mac80211/mlme.c:8085
 ieee80211_iface_process_skb net/mac80211/iface.c:1696 [inline]
 ieee80211_iface_work+0x652/0x12d0 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x2b8/0x470 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 38:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free_freelist_hook mm/slub.c:2446 [inline]
 slab_free_bulk mm/slub.c:4704 [inline]
 kmem_cache_free_bulk+0x2d1/0x520 mm/slub.c:5283
 kfree_bulk include/linux/slab.h:794 [inline]
 kvfree_rcu_bulk+0xe5/0x1f0 mm/slab_common.c:1516
 kfree_rcu_work+0xed/0x170 mm/slab_common.c:1594
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 kvfree_call_rcu+0xbb/0x410 mm/slab_common.c:1962
 cfg80211_update_known_bss+0x454/0x1330 net/wireless/scan.c:1919
 cfg80211_update_assoc_bss_entry+0x4ba/0x6a0 net/wireless/scan.c:3454
 cfg80211_ch_switch_notify+0x3c1/0x780 net/wireless/nl80211.c:20398
 ieee80211_sta_process_chanswitch+0xad4/0x2870 net/mac80211/mlme.c:-1
 ieee80211_rx_mgmt_beacon+0x19c7/0x2cd0 net/mac80211/mlme.c:7515
 ieee80211_sta_rx_queued_mgmt+0x4ed/0x4470 net/mac80211/mlme.c:8085
 ieee80211_iface_process_skb net/mac80211/iface.c:1696 [inline]
 ieee80211_iface_work+0x652/0x12d0 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x2b8/0x470 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88804b2de500
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff88804b2de500, ffff88804b2de560)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4b2de
anon flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801a441280 ffffea00010fab80 dead000000000005
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 3103, tgid 3103 (kworker/u4:12), ts 130328667868, free_ts 130314026448
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_slab_page mm/slub.c:2489 [inline]
 allocate_slab+0x65/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_node_noprof+0x2fd/0x4e0 mm/slub.c:4371
 kmalloc_array_node_noprof include/linux/slab.h:1020 [inline]
 alloc_slab_obj_exts mm/slub.c:2028 [inline]
 account_slab mm/slub.c:2614 [inline]
 allocate_slab+0x16a/0x370 mm/slub.c:2674
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
 dst_alloc+0x105/0x170 net/core/dst.c:89
 ip6_dst_alloc net/ipv6/route.c:342 [inline]
 icmp6_dst_alloc+0x75/0x420 net/ipv6/route.c:3324
 ndisc_send_skb+0x41f/0x1440 net/ipv6/ndisc.c:491
 addrconf_dad_completed+0x7ae/0xd60 net/ipv6/addrconf.c:4360
 addrconf_dad_work+0xc36/0x14b0 net/ipv6/addrconf.c:-1
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
page last free pid 5457 tgid 5457 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x112/0x1d0 mm/mmu_gather.c:500
 exit_mmap+0x44c/0xb50 mm/mmap.c:1293
 __mmput+0x118/0x430 kernel/fork.c:1129
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:949
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804b2de400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88804b2de480: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff88804b2de500: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff88804b2de580: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff88804b2de600: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
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

