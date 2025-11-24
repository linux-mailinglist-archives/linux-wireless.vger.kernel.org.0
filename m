Return-Path: <linux-wireless+bounces-29276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41455C7F3E4
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 08:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C604346ECA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4F2550D7;
	Mon, 24 Nov 2025 07:47:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F4250C06
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970445; cv=none; b=EeSokobUAJuBGAadfV3tuiItzoc9ahmnotvCrpZupMgKOt0NSH1EYw8kHTHA3/Uvmt5wGdWC+bdecrLinxoGxBwiVEevkPhD8VNIoCAbYMhbZx74Opd8/ZqK+DeJ6y7RCbkmHeoimCxXxniNoOsSWiSybojk4Fwg0HOXyhcxnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970445; c=relaxed/simple;
	bh=G5/Z6P8DRLqsxaGNNoFfUPk7C678KpbfQ76AeFelfyo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IjpJW7y6zUK9RCXEgRdcJil1RWA8AiSvhmFAY+Mo0aWb9ScTA9PGCV6K4s6sqs/dZ3j0Jn7R2Wto5A433nkLW+pYDD43uC9bwOdb0bD0yMZVmz2snWrXf52Stfg7kGOGUJCq/ZlWlPyacZifqSy9/GUX8P5003K6jacos7cwhPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-948ffd40eefso276758339f.0
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 23:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970442; x=1764575242;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVL52Uwhc9wSn+zFE1gytux9w1Qap3oJOsMkvaz/Qs0=;
        b=WolWvcdfTI47Cc6ihUoofHFFe7AvpjEhzZbu2qu+tE9W2UekhQkQ1LuuTGTyhbb4Vq
         rsd4EuUWJmJHuBnX5yKnfRocGTsZzmmj5/F8VD7w5NBtTwWvURxB5spvqzzY46rOQA3a
         k6pdzlGePm0GMxnf3GxlkO01hlmfr/PzvgfHIGMukg3mRFDaA1C/f1tz/QwnCiRWTDEU
         vmTu8Zfi0V9yozUQgdK7Ox64q61EtYYOPI3aWUVKdDEKp7gxMot7sMHiulOecHgAahx1
         HYjgBEjxkV6dyc6MtFf8E8DHol+2uSfqQsRY+SNI4WquecokUGr6TR5GlKsigwJyKovg
         Zv3g==
X-Forwarded-Encrypted: i=1; AJvYcCXbr2cAhNQBnUmk4OYWNpE/FqiG+UH6qPrJGTeDipm7Mk5GRWkXixlmm0sMDPb5vlJUsRhLgEv/IKcPO6EIlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ9jGaumT7dH9N+rM0RkQ0A8/ylJ0yqQQLmjZ/b3L1mVgsy3OL
	V6ke7SV27ytr65MmDofBiVCtHCetwWmXwDYW6K8aXV/jHiQd6Np61hzrxxKtw7GV4L3Nuy61joT
	UdWRht2HXiFVIMAC0bCR66fL2T3pSPudmBO7jf/vEUsQ+XTvZTrkgmKLH43U=
X-Google-Smtp-Source: AGHT+IGiSn+oITFsLh805fFCaICBO6NKVgl2YHm0SKQqQnfDzBUYDScgyHO4BxkXxFdLZDVJzrkQJIQ5rJggKWh7HuoR+LQxy9e8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e89:b0:434:96ea:ff81 with SMTP id
 e9e14a558f8ab-435b98e9d15mr89852635ab.33.1763970442283; Sun, 23 Nov 2025
 23:47:22 -0800 (PST)
Date: Sun, 23 Nov 2025 23:47:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69240d8a.a70a0220.d98e3.0080.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-use-after-free Read in __ieee80211_beacon_add_tim
From: syzbot <syzbot+62ae1cd7eea59d8b9252@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe4d0dea039f Add linux-next specific files for 20251119
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15580514580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=151bfd5098f42253
dashboard link: https://syzkaller.appspot.com/bug?extid=62ae1cd7eea59d8b9252
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8ba50fe0f8f3/disk-fe4d0dea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b6fd6a81a075/vmlinux-fe4d0dea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78cb38ef15c3/bzImage-fe4d0dea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62ae1cd7eea59d8b9252@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ieee80211_get_link_sband net/mac80211/ieee80211_i.h:1737 [inline]
BUG: KASAN: slab-use-after-free in __ieee80211_beacon_add_tim+0x1d7/0x15a0 net/mac80211/tx.c:5001
Read of size 8 at addr ffff888031b68890 by task syz-executor/15086

CPU: 0 UID: 0 PID: 15086 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ieee80211_get_link_sband net/mac80211/ieee80211_i.h:1737 [inline]
 __ieee80211_beacon_add_tim+0x1d7/0x15a0 net/mac80211/tx.c:5001
 ieee80211_beacon_add_tim net/mac80211/tx.c:5071 [inline]
 __ieee80211_beacon_get+0x9df/0x1880 net/mac80211/tx.c:5696
 ieee80211_beacon_get_tim+0xb4/0x2b0 net/mac80211/tx.c:5774
 ieee80211_beacon_get include/net/mac80211.h:5669 [inline]
 mac80211_hwsim_beacon_tx+0x3ce/0x860 drivers/net/wireless/virtual/mac80211_hwsim.c:2361
 __iterate_interfaces+0x2ab/0x590 net/mac80211/util.c:761
 ieee80211_iterate_active_interfaces_atomic+0xdb/0x180 net/mac80211/util.c:797
 mac80211_hwsim_beacon+0xbb/0x180 drivers/net/wireless/virtual/mac80211_hwsim.c:2395
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x51c/0xc70 kernel/time/hrtimer.c:1841
 hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
 handle_softirqs+0x27d/0x880 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:727
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:743
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_acquire+0x16c/0x350 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 c4 21 1c 11 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc9000caf72b0 EFLAGS: 00000206
RAX: 5380659d3018f300 RBX: 0000000000000000 RCX: 5380659d3018f300
RDX: 0000000000000000 RSI: ffffffff8dc75c47 RDI: ffffffff8be14f60
RBP: ffffffff82344eda R08: 0000000000000000 R09: ffffffff82344eda
R10: dffffc0000000000 R11: fffff940001faf59 R12: 0000000000000002
R13: ffffffff8e33d800 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:958 [inline]
 pfn_valid+0xd6/0x490 include/linux/mmzone.h:2183
 page_table_check_set+0x25/0x610 mm/page_table_check.c:105
 page_table_check_ptes_set include/linux/page_table_check.h:76 [inline]
 set_ptes include/linux/pgtable.h:292 [inline]
 __copy_present_ptes mm/memory.c:1102 [inline]
 copy_present_ptes mm/memory.c:1181 [inline]
 copy_pte_range mm/memory.c:1304 [inline]
 copy_pmd_range+0x5092/0x7fa0 mm/memory.c:1392
 copy_pud_range mm/memory.c:1429 [inline]
 copy_p4d_range mm/memory.c:1453 [inline]
 copy_page_range+0xb88/0x11d0 mm/memory.c:1535
 dup_mmap+0xeed/0x1b00 mm/mmap.c:1825
 dup_mm kernel/fork.c:1488 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1540
 copy_process+0x1663/0x3930 kernel/fork.c:2180
 kernel_clone+0x21e/0x850 kernel/fork.c:2609
 __do_sys_clone kernel/fork.c:2750 [inline]
 __se_sys_clone kernel/fork.c:2734 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2734
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5eae785e93
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffca7cc2c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5eae785e93
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 000055557a19b7d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 00000000000b17e8 R15: 00007ffca7cc2dc0
 </TASK>

Allocated by task 1952:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5652 [inline]
 __kmalloc_noprof+0x41d/0x800 mm/slub.c:5664
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 ieee80211_alloc_chanctx net/mac80211/chan.c:823 [inline]
 ieee80211_new_chanctx+0x152/0x4f0 net/mac80211/chan.c:876
 _ieee80211_link_use_channel+0xbaa/0x1080 net/mac80211/chan.c:2023
 ieee80211_link_use_channel net/mac80211/ieee80211_i.h:2735 [inline]
 __ieee80211_sta_join_ibss+0x653/0x1630 net/mac80211/ibss.c:296
 ieee80211_sta_create_ibss+0x300/0x480 net/mac80211/ibss.c:1316
 ieee80211_sta_find_ibss net/mac80211/ibss.c:1445 [inline]
 ieee80211_ibss_work+0xdb6/0x1060 net/mac80211/ibss.c:1666
 cfg80211_wiphy_work+0x2ab/0x470 net/wireless/core.c:438
 process_one_work+0x93a/0x15e0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Freed by task 1952:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free_freelist_hook mm/slub.c:2569 [inline]
 slab_free_bulk mm/slub.c:6696 [inline]
 kmem_cache_free_bulk+0x3fb/0xdc0 mm/slub.c:7383
 kfree_bulk include/linux/slab.h:830 [inline]
 kvfree_rcu_bulk+0xe5/0x1f0 mm/slab_common.c:1523
 kfree_rcu_work+0xed/0x170 mm/slab_common.c:1601
 process_one_work+0x93a/0x15e0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 kvfree_call_rcu+0x135/0x490 mm/slab_common.c:1994
 ieee80211_vif_use_reserved_switch+0x24ba/0x28a0 net/mac80211/chan.c:1917
 ieee80211_link_use_reserved_context+0x361/0x580 net/mac80211/chan.c:2102
 __ieee80211_csa_finalize net/mac80211/cfg.c:4134 [inline]
 ieee80211_csa_finalize+0x598/0x1110 net/mac80211/cfg.c:4165
 cfg80211_wiphy_work+0x2ab/0x470 net/wireless/core.c:438
 process_one_work+0x93a/0x15e0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

The buggy address belongs to the object at ffff888031b68800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 144 bytes inside of
 freed 512-byte region [ffff888031b68800, ffff888031b68a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x31b68
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe26c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe26c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000c6da01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 7562, tgid 7562 (syz-executor), ts 182666350860, free_ts 95263555076
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xf56/0x1990 mm/slub.c:4651
 __slab_alloc+0x65/0x100 mm/slub.c:4774
 __slab_alloc_node mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:5246 [inline]
 __do_kmalloc_node mm/slub.c:5651 [inline]
 __kmalloc_noprof+0x47d/0x800 mm/slub.c:5664
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 fib6_info_alloc+0x30/0xf0 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x142/0x860 net/ipv6/route.c:3809
 addrconf_f6i_alloc+0x1d2/0x450 net/ipv6/route.c:4678
 ipv6_add_addr+0x56e/0x1090 net/ipv6/addrconf.c:1126
 inet6_addr_add+0x377/0xc00 net/ipv6/addrconf.c:3050
 inet6_rtm_newaddr+0x93d/0xd20 net/ipv6/addrconf.c:5059
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
page last free pid 5200 tgid 5200 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 __slab_free+0x21b/0x2a0 mm/slub.c:5999
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:349
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4948 [inline]
 slab_alloc_node mm/slub.c:5258 [inline]
 kmem_cache_alloc_noprof+0x37d/0x700 mm/slub.c:5265
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2499 [inline]
 getname_maybe_null include/linux/fs.h:2506 [inline]
 vfs_fstatat+0x43/0x170 fs/stat.c:370
 __do_sys_newfstatat fs/stat.c:542 [inline]
 __se_sys_newfstatat fs/stat.c:536 [inline]
 __x64_sys_newfstatat+0x116/0x190 fs/stat.c:536
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888031b68780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888031b68800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888031b68880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888031b68900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888031b68980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	9c                   	pushf
   5:	8f 44 24 30          	pop    0x30(%rsp)
   9:	f7 44 24 30 00 02 00 	testl  $0x200,0x30(%rsp)
  10:	00
  11:	0f 85 cd 00 00 00    	jne    0xe4
  17:	f7 44 24 08 00 02 00 	testl  $0x200,0x8(%rsp)
  1e:	00
  1f:	74 01                	je     0x22
  21:	fb                   	sti
  22:	65 48 8b 05 c4 21 1c 	mov    %gs:0x111c21c4(%rip),%rax        # 0x111c21ee
  29:	11
* 2a:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax <-- trapping instruction
  2f:	0f 85 f2 00 00 00    	jne    0x127
  35:	48 83 c4 60          	add    $0x60,%rsp
  39:	5b                   	pop    %rbx
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	41 5e                	pop    %r14


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

