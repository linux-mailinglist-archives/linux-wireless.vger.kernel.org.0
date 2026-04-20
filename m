Return-Path: <linux-wireless+bounces-35013-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO3RBkHQ5WkfoQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35013-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:05:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD442798F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF42930037CE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26803382F18;
	Mon, 20 Apr 2026 07:05:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96234A76B
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668734; cv=none; b=YNzDF4uVnGwd8VEGpYlXg2x7iKoNcphBeEyykf0lSzdVRj9IZBMJK5bVCuEWIS3SQiBt8RZIjrxOkMS8mNu1azdnMVD5Iq+zjC/2UQ/qP3KXI09AcRg8ywfxgwjm/NqREKFR0eIphJmG57Hw/ci04uSDgtIGY/5mo0QivMl8cOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668734; c=relaxed/simple;
	bh=aUTOVM6G4NvJT53QHzhoeCouEVUPy8Fsdm+YMT0UJWo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o9D7adw/TaYM0f5rrEu5r7aPwLQyz+S9ibF8LsJb/6M13G0VDzI2JCxxqwJw3zdTCBVlAmF9wIfpHJ3VbP/5N7szeuC7EAG2mVJP7WisBa3p0YWAjptcpdMXk6kEcJ1J0nTUoBx+kRoInXFLKxJoI8k7pfOFfA2CjXFhZs05i6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7dbe76e3abcso6064849a34.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 00:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776668731; x=1777273531;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9V+hZJSDFNrj/Adh6z+KspVvdr/WxX8LwsFTS0B8es=;
        b=cSc8PKt59CXqWrnvC/iD2xpFLxpU0uPYWu0RCK57LSw8SgeJWOJSIiC8rdPVVghmMv
         1JV5MTnQ60mx1N1qczfKTztOPkcEX1SsutW/g/cAUeCd2lpgE4BrbjAj92jWPt4sErmS
         geOTT/zlXa/jb7EbZJ9niY2LLwoqrWCOp7XiWY8V+rLmDnSz7f1y6QuUORKaP3FpWI4T
         PzTU9Yc4/gSYxOkIVVdYTt6ZXJjOuA4amCLTo9YRfwAgs8J/9Ia0RCYBCkyioiSWVBk7
         +vPZdofRKOOxwG0gQHSSOUSA5UqB8qPWeVrMD28KgBbwi2Q2JmxnaOSVAKn7tgeiR/fk
         lomw==
X-Forwarded-Encrypted: i=1; AFNElJ+5yPzR85oe6GYxpBMiX8zCQCZXQ3dnh4WSjgUtZktxZEhRdyrZC5uxwuiaRi9edxB8e1cp8xaqQCDTUBJxQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NtIDfJff2ONsIgR/pN6dI1T6BF6ne8Nqe4Bi8VGYONT2r6PC
	r1NN1XIUEnJEbpy/WccKWUjgG+Y5AeN7oEsfNS8wgD5DRTY9/wu2e0sHh5GcX4njU8CJlnBqXVw
	7JPF3E3EW6iTpP21OUN542ZZEeLKSB0ISbrIZoqpk6qRjXgE72i7j+U5zCHU=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ac5:b0:68b:b62a:a4eb with SMTP id
 006d021491bc7-69462e756a8mr6476414eaf.24.1776668731292; Mon, 20 Apr 2026
 00:05:31 -0700 (PDT)
Date: Mon, 20 Apr 2026 00:05:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e5d03b.a00a0220.1bd0ca.0064.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-use-after-free Write in rsi_91x_deinit
From: syzbot <syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2056c1e3f6d3b0bc];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35013-lists,linux-wireless=lfdr.de,5de83f57cd8531f55596];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,storage.googleapis.com:url,goo.gl:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 4ABD442798F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    87117347a0e7 usb: dwc3: starfive: Add JHB100 USB 2.0 DRD c..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=171b04ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2056c1e3f6d3b0bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5de83f57cd8531f55596
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6168cf3e4727/disk-87117347.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36e554f1750a/vmlinux-87117347.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7aa92e741f66/bzImage-87117347.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com

rsi_91x: rsi_probe: Failed to init usb interface
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:283 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:366 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:383 [inline]
BUG: KASAN: slab-use-after-free in get_task_struct include/linux/sched/task.h:116 [inline]
BUG: KASAN: slab-use-after-free in kthread_stop+0x8f/0x680 kernel/kthread.c:754
Write of size 4 at addr ffff88813d339da8 by task kworker/0:3/10583

CPU: 0 UID: 0 PID: 10583 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x156/0x4c9 mm/kasan/report.c:482
 kasan_report+0xdf/0x1e0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:283 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 get_task_struct include/linux/sched/task.h:116 [inline]
 kthread_stop+0x8f/0x680 kernel/kthread.c:754
 rsi_kill_thread drivers/net/wireless/rsi/rsi_common.h:78 [inline]
 rsi_91x_deinit+0x102/0x1f0 drivers/net/wireless/rsi/rsi_91x_main.c:405
 rsi_probe+0xd27/0x1aa0 drivers/net/wireless/rsi/rsi_91x_usb.c:861
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:643 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:721
 __driver_probe_device+0x1de/0x400 drivers/base/dd.c:863
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:893
 __device_attach_driver+0x1df/0x340 drivers/base/dd.c:1021
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1093
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1148
 bus_probe_device+0x64/0x160 drivers/base/bus.c:613
 device_add+0x11d9/0x1950 drivers/base/core.c:3691
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:643 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:721
 __driver_probe_device+0x1de/0x400 drivers/base/dd.c:863
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:893
 __device_attach_driver+0x1df/0x340 drivers/base/dd.c:1021
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1093
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1148
 bus_probe_device+0x64/0x160 drivers/base/bus.c:613
 device_add+0x11d9/0x1950 drivers/base/core.c:3691
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x314d/0x4af0 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
 process_scheduled_works kernel/workqueue.c:3359 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x6c3/0xcb0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 2:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6e/0x70 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 kmem_cache_alloc_node_noprof+0x26b/0x6b0 mm/slub.c:4918
 alloc_task_struct_node kernel/fork.c:185 [inline]
 dup_task_struct kernel/fork.c:916 [inline]
 copy_process+0x48b/0x7820 kernel/fork.c:2050
 kernel_clone+0xfc/0x9a0 kernel/fork.c:2653
 kernel_thread+0xdb/0x120 kernel/fork.c:2714
 create_kthread kernel/kthread.c:459 [inline]
 kthreadd+0x498/0x7a0 kernel/kthread.c:817
 ret_from_fork+0x6c3/0xcb0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 14:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x43/0x70 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kmem_cache_free+0x105/0x640 mm/slub.c:6295
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2869
 handle_softirqs+0x1de/0x9d0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1063 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1055
 smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x6c3/0xcb0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0x8c/0xa0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3131
 put_task_struct include/linux/sched/task.h:159 [inline]
 put_task_struct include/linux/sched/task.h:128 [inline]
 delayed_put_task_struct+0xe4/0x2e0 kernel/exit.c:231
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2869
 handle_softirqs+0x1de/0x9d0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xed/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Second to last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0x8c/0xa0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3131
 put_task_struct_rcu_user kernel/exit.c:237 [inline]
 put_task_struct_rcu_user+0x6c/0xc0 kernel/exit.c:234
 context_switch kernel/sched/core.c:5301 [inline]
 __schedule+0xeb9/0x4220 kernel/sched/core.c:6911
 preempt_schedule_common+0x42/0xc0 kernel/sched/core.c:7095
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:169 [inline]
 _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:389 [inline]
 filemap_map_pages+0x130f/0x1e50 mm/filemap.c:3936
 do_fault_around mm/memory.c:5757 [inline]
 do_read_fault mm/memory.c:5790 [inline]
 do_fault mm/memory.c:5933 [inline]
 do_pte_missing mm/memory.c:4477 [inline]
 handle_pte_fault mm/memory.c:6317 [inline]
 __handle_mm_fault+0x1e2e/0x2d60 mm/memory.c:6455
 handle_mm_fault+0x36d/0xa20 mm/memory.c:6624
 do_user_addr_fault+0x5ae/0x11d0 arch/x86/mm/fault.c:1334
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x66/0xc0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

The buggy address belongs to the object at ffff88813d339d80
 which belongs to the cache task_struct of size 7296
The buggy address is located 40 bytes inside of
 freed 7296-byte region [ffff88813d339d80, ffff88813d33ba00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13d338
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88813d33f601
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff8881012d9500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800040004 00000000f5000000 ffff88813d33f601
head: 0200000000000040 ffff8881012d9500 dead000000000100 dead000000000122
head: 0000000000000000 0000000800040004 00000000f5000000 ffff88813d33f601
head: 0200000000000003 ffffea0004f4ce01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5914, tgid 5914 (dhcpcd-run-hook), ts 193584350604, free_ts 193494512770
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0xf10/0x39f0 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x273/0x2860 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab mm/slub.c:3481 [inline]
 new_slab+0xa6/0x6c0 mm/slub.c:3539
 refill_objects+0x26b/0x400 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x1ab/0x660 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 kmem_cache_alloc_node_noprof+0x4e9/0x6b0 mm/slub.c:4918
 alloc_task_struct_node kernel/fork.c:185 [inline]
 dup_task_struct kernel/fork.c:916 [inline]
 copy_process+0x48b/0x7820 kernel/fork.c:2050
 kernel_clone+0xfc/0x9a0 kernel/fork.c:2653
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2794
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0x7b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 2861 tgid 2861 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0x7b1/0xfb0 mm/page_alloc.c:2978
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xe0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x4e/0x70 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 kmem_cache_alloc_noprof+0x2e7/0x6a0 mm/slub.c:4873
 alloc_filename fs/namei.c:142 [inline]
 do_getname+0x35/0x390 fs/namei.c:182
 getname include/linux/fs.h:2512 [inline]
 class_filename_constructor include/linux/fs.h:2539 [inline]
 do_sys_openat2+0xc5/0x1e0 fs/open.c:1365
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0x7b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88813d339c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88813d339d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88813d339d80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88813d339e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88813d339e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

