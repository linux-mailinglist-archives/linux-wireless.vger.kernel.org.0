Return-Path: <linux-wireless+bounces-11248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4852694DB83
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6571C20FEC
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66314BF90;
	Sat, 10 Aug 2024 08:42:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9B14AD3A
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279341; cv=none; b=Mj3oub1jYU8Pys6IlEHPQ0Ae/P9WJPqfjL+JRK6ckt7cnHkHeJdYSQacUjvcR1xKy/CfHx87Io0uUGnk3rd6o06rcRJoXLZzxEdQslIAokLkWRC0USrNefrFxmML72Av0wgrLsYN9xPszMQ8yYwQ6M+VQCZ2PLw2HnElnHog/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279341; c=relaxed/simple;
	bh=yQEbVHn6BaKMCt0IVCu3suh1Y+atI0rmkyG9pZIs4PM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=saPxgKFFhf+PInULRkt3CpsdSXC6mivvw3nZRadUNE+Rb0dRMh6JAo2U51FZKQR263UJ83fD4UgT5JHsbF90vesOd7idqnP60H5u5kmshqlN5fJkHQsdop/CTpW/KBmd4BmYueg2PyG7mJVQMgajWX1tyiKloPdHOu1xNmQWYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37642e69d7eso35064295ab.3
        for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 01:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723279339; x=1723884139;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbcGf+ZscPGswmn1AVRKuI6rDAL+SV2cKXetUeYdang=;
        b=ALEAHLunT30p6suEU/slAW7TJHxzYj0qptPkgRmTJDxvX4EAYNCd8XRifaC29Zi5gq
         FAJsSYPrrXMZIlZ6nkikZVXodp90hj2pdTr8kK6BeybXa/UWTuoL7A9ZmNpT+Ery2eug
         Bvy2Zu9YhT0P6hdGKy7240GbeCNnqKHvAGH2VuWeySvxViXclVd2GUpdRDSHv41Gd2dx
         9Tm5Xf2qKhaxsLPy1QKi1lUMEW+UT5s2g8PxBWHeTIhitP+Uc1yjsEy85NiyvFnV7t0A
         x36zp7myRqe0tr19thOukWt/4zeii9SWgZ/OqFGQKc6zMqxE291yxTIFFE60FQpPspM7
         Zjmw==
X-Forwarded-Encrypted: i=1; AJvYcCVmgbe5qniSSayePZIXrcuK+0M4RahlVE7xE5dRbZz/boGiiQHpTNQYMoHtHKN4e9totlnDLXtp1D9gFDkG1uzg8yh23uOWltlsWHmApXs=
X-Gm-Message-State: AOJu0YxShjnhjt3zvY2MZppFVJ8Z5AGoCsBKs9CUEl+lVXwBNfosHIdr
	C27Y/0ISOBin2oLC9Vk4QRaou8+McPFXzIeVpiI0O5hay3d032US6cuBhL9H0UbSVnHfPYMIJ+C
	ln6iFgBKvfjlErScJCQb35A7Wu+yCP5MrIyZyyrQnAGeNcgCMn1987mA=
X-Google-Smtp-Source: AGHT+IF6nOx97wMoZLJrKo88WJeuHpchdPI9KzP5X+aTL6qZPqUHzN3Uaipw/gIl2ZDGD+Nk9btllFUgTdWIW705hYTAmlWgjSQ2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c562:0:b0:381:24e:7a8c with SMTP id
 e9e14a558f8ab-39b7a474c66mr2146205ab.1.1723279338904; Sat, 10 Aug 2024
 01:42:18 -0700 (PDT)
Date: Sat, 10 Aug 2024 01:42:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d830f0061f503c6a@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in skb_trim (2)
From: syzbot <syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b446a2dae984 Merge tag 'linux_kselftest-fixes-6.11-rc3' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13eb467d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=305509ad8eb5f9b8
dashboard link: https://syzkaller.appspot.com/bug?extid=98afa303be379af6cdb2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49d96e53e1c4/disk-b446a2da.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f05350d128a7/vmlinux-b446a2da.xz
kernel image: https://storage.googleapis.com/syzbot-assets/805c7d86a2db/bzImage-b446a2da.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in skb_trim+0x13a/0x190 net/core/skbuff.c:2673
 skb_trim+0x13a/0x190 net/core/skbuff.c:2673
 ath9k_hif_usb_reg_in_cb+0x582/0x970 drivers/net/wireless/ath/ath9k/hif_usb.c:758
 __usb_hcd_giveback_urb+0x572/0x840 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x157/0x720 drivers/usb/core/hcd.c:1734
 dummy_timer+0xd3f/0x6aa0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x564/0xe40 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x3ab/0x1490 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0xa6/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x7e/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 __nr_to_section include/linux/mmzone.h:1862 [inline]
 __pfn_to_section include/linux/mmzone.h:1970 [inline]
 pfn_valid include/linux/mmzone.h:2023 [inline]
 kmsan_virt_addr_valid arch/x86/include/asm/kmsan.h:94 [inline]
 virt_to_page_or_null+0x7a/0x150 mm/kmsan/shadow.c:75
 kmsan_get_metadata+0x13e/0x1c0 mm/kmsan/shadow.c:141
 kmsan_get_shadow_origin_ptr+0x38/0xb0 mm/kmsan/shadow.c:97
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
 __msan_metadata_ptr_for_load_4+0x24/0x40 mm/kmsan/instrumentation.c:93
 stack_trace_consume_entry+0x16f/0x1e0 kernel/stacktrace.c:94
 arch_stack_walk+0x1ca/0x2d0 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:73 [inline]
 kmsan_internal_poison_memory+0x49/0x90 mm/kmsan/core.c:57
 kmsan_slab_alloc+0xdf/0x160 mm/kmsan/hooks.c:66
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_node_track_caller_noprof+0x6c7/0xf90 mm/slub.c:4177
 kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:605
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x3f5/0x1230 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4723
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page mm/slub.c:2321 [inline]
 allocate_slab+0x203/0x1220 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0x12ef/0x35e0 mm/slub.c:3723
 __slab_alloc mm/slub.c:3813 [inline]
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_noprof+0x57a/0xb20 mm/slub.c:4044
 skb_clone+0x303/0x550 net/core/skbuff.c:2071
 deliver_clone net/bridge/br_forward.c:125 [inline]
 maybe_deliver+0x3ad/0x590 net/bridge/br_forward.c:190
 br_flood+0x574/0xbd0 net/bridge/br_forward.c:236
 br_dev_xmit+0x1bfa/0x1f10
 __netdev_start_xmit include/linux/netdevice.h:4913 [inline]
 netdev_start_xmit include/linux/netdevice.h:4922 [inline]
 xmit_one net/core/dev.c:3580 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3596
 __dev_queue_xmit+0x358c/0x5610 net/core/dev.c:4423
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_resolve_output+0x9ca/0xae0 net/core/neighbour.c:1565
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0x233e/0x2ba0 net/ipv6/ip6_output.c:137
 __ip6_finish_output net/ipv6/ip6_output.c:211 [inline]
 ip6_finish_output+0xbb8/0x14b0 net/ipv6/ip6_output.c:222
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x356/0x620 net/ipv6/ip6_output.c:243
 dst_output include/net/dst.h:450 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0xb9f/0x14c0 net/ipv6/ndisc.c:511
 ndisc_send_rs+0x97b/0xae0 net/ipv6/ndisc.c:721
 addrconf_rs_timer+0x488/0x6f0 net/ipv6/addrconf.c:4040
 call_timer_fn+0x49/0x580 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x84e/0xe90 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0x3a/0x70 kernel/time/timer.c:2447
 handle_softirqs+0x1ce/0x800 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0x68/0x120 kernel/softirq.c:637
 irq_exit_rcu+0x12/0x20 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702

CPU: 1 UID: 0 PID: 5253 Comm: kworker/1:6 Not tainted 6.11.0-rc2-syzkaller-00004-gb446a2dae984 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events nsim_dev_trap_report_work
=====================================================


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

