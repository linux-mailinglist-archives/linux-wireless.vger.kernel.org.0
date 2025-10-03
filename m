Return-Path: <linux-wireless+bounces-27799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01967BB6ABA
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 14:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05A284E3A6D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Oct 2025 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490F2EDD78;
	Fri,  3 Oct 2025 12:36:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEFC2ECD22
	for <linux-wireless@vger.kernel.org>; Fri,  3 Oct 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494988; cv=none; b=NI344OSNngm0RbxAiA9tEx+eb0ZQjHOLuvar7MC+D7p9xByxXTvqyBzT9lWRGCykKyO54jk9Km4F7h5p9elwysyEHTgDqUdWmduGnqZeVFl/uXIBNgeQLev9nO6A9lq5Phcb5sjrsC0hZ9UWretJfONu7FWACHgLoKsDQNSxvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494988; c=relaxed/simple;
	bh=97/QPeIM5ZpfDMeD/GwkZZTuKP9MmcOyHIHKKJMBdhc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d09LxH9Ne9dZj9QVpNo1W9cYIK1PyY3hqTUIW1/LEnFroWVwJXgLSA/Kxrhd8AhvldLDi0YYwwSbsGYUHsVZxiijbs3R4yZWZ6P9JnOownLCT4l8ST71gkfhvpAYe5VuOfXj761zF0Mhc8CqQd9wxZKZp1yV1mVhG4Ftb9XgpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42a076e4f9eso29837145ab.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Oct 2025 05:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759494986; x=1760099786;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emQMY+NBClx28AnDJBfSwmxL4rlqBlzxd5y+572udsg=;
        b=PZGyzXfcIZn4fND3yxVMiWQzk9su5X72/H2NEU2+emITcz1kbstCQOFK6dGdr2fcOA
         KFxeEa/sq1W6AH3ObJW9KAGjBgTqabHyRonayg9fMi5E2hT1kVIpj7sBFWFexRaNRv9F
         8g3QG7mS0skJ7Pt96ciPCw0rOFpBLuAIsoFWDF47/QM4igVZOI11TjuKaJMjKDyCbpiX
         ByTzIKInTxthdV6FH6qbNAUxJWbnU6h6Rny2yYOBKXH6qS1Vjb4QQqUoSW/jBf77OPBJ
         xBkOrHk+Pc9GCb1+IJ6mWWJQXsROKBUA/OWiN6O7242sNQyE7oQ6KXZxRhpHUFAANY1j
         gnqw==
X-Forwarded-Encrypted: i=1; AJvYcCVU1HU+UGywbm+KepK/pifTfgcGIPo0fpPDYpeQ62frG2mzmXI21VJG/VSJKfawI98TuVgN4OR9RejhQtGuzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBuL16cfV4hgekN2l1Ns+8U+0U426zkVO7X/z1bkXmCA/keYE
	QbW+k02sNmTUuhMsS8Gof0u9tA2mB5cqlFKM2s+g4+0meLtpgsb7FYBFOLAvKXSIw/RFwljzruM
	3ZDnG5zg4fkKSWrMgtdWBw+JQFYxzeo09Sbur9G/kV4etz+ENqQpynwpmQ4c=
X-Google-Smtp-Source: AGHT+IF/N946G7ih/QJNT9h1L5L+MVsNDmho1laEdm0bUECBdT+KUJQSHclCYZjoga6zggTyySR33Y10hW/is6CWczVq41exr0dL
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1648:b0:423:fce3:9255 with SMTP id
 e9e14a558f8ab-42e7ad7b08dmr30510035ab.23.1759494986119; Fri, 03 Oct 2025
 05:36:26 -0700 (PDT)
Date: Fri, 03 Oct 2025 05:36:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dfc34a.050a0220.1696c6.0041.GAE@google.com>
Subject: [syzbot] [wireless?] KASAN: slab-out-of-bounds Read in ieee80211_ie_split_ric
From: syzbot <syzbot+8c46f153d4b6c8093075@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    012ea489aeda Merge branch 'net-macb-various-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=130d7f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=8c46f153d4b6c8093075
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb0af64f5007/disk-012ea489.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c014e9dda3de/vmlinux-012ea489.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8328e9c7c14/bzImage-012ea489.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c46f153d4b6c8093075@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in skip_ie net/wireless/util.c:2013 [inline]
BUG: KASAN: slab-out-of-bounds in ieee80211_ie_split_ric+0x8fa/0x950 net/wireless/util.c:-1
Read of size 1 at addr ffff8880538220c1 by task syz.0.2592/15438

CPU: 1 UID: 0 PID: 15438 Comm: syz.0.2592 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 skip_ie net/wireless/util.c:2013 [inline]
 ieee80211_ie_split_ric+0x8fa/0x950 net/wireless/util.c:-1
 ieee80211_ie_split include/net/cfg80211.h:9461 [inline]
 cfg80211_sme_get_conn_ies net/wireless/sme.c:529 [inline]
 cfg80211_sme_connect net/wireless/sme.c:586 [inline]
 cfg80211_connect+0x10bb/0x21a0 net/wireless/sme.c:1527
 cfg80211_mgd_wext_connect+0x4b0/0x610 net/wireless/wext-sme.c:57
 cfg80211_wext_siwessid+0xc4/0x160 net/wireless/wext-compat.c:1412
 ioctl_standard_iw_point+0x686/0xd40 net/wireless/wext-core.c:865
 ioctl_standard_call+0xaf/0x1b0 net/wireless/wext-core.c:1050
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0xee/0x410 net/wireless/wext-core.c:1014
 wext_handle_ioctl+0x100/0x1c0 net/wireless/wext-core.c:1075
 sock_ioctl+0x15f/0x790 net/socket.c:1291
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda6dd8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fda6ec55038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fda6dfe5fa0 RCX: 00007fda6dd8eec9
RDX: 0000200000000040 RSI: 0000000000008b1a RDI: 0000000000000004
RBP: 00007fda6de11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fda6dfe6038 R14: 00007fda6dfe5fa0 R15: 00007ffd700ba618
 </TASK>

Allocated by task 11663:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kmalloc_node_track_caller_noprof+0x271/0x4e0 mm/slub.c:4395
 kmemdup_noprof+0x2b/0x70 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:765 [inline]
 cfg80211_wext_siwgenie+0x1ad/0x320 net/wireless/wext-sme.c:322
 ioctl_standard_iw_point+0x686/0xd40 net/wireless/wext-core.c:865
 ioctl_standard_call+0xaf/0x1b0 net/wireless/wext-core.c:1050
 wireless_process_ioctl net/wireless/wext-core.c:-1 [inline]
 wext_ioctl_dispatch+0xee/0x410 net/wireless/wext-core.c:1014
 wext_handle_ioctl+0x100/0x1c0 net/wireless/wext-core.c:1075
 sock_ioctl+0x15f/0x790 net/socket.c:1291
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880538220c0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 1-byte region [ffff8880538220c0, ffff8880538220c1)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888053822e40 pfn:0x53822
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801a441500 ffffea0001b2fad0 ffffea00014e9f10
raw: ffff888053822e40 0000000000800068 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 11644, tgid 11643 (syz.4.1506), ts 186114687557, free_ts 185745645903
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_node_track_caller_noprof+0x2f8/0x4e0 mm/slub.c:4395
 kvasprintf+0xdc/0x190 lib/kasprintf.c:25
 kobject_set_name_vargs+0x61/0x110 lib/kobject.c:274
 kobject_add_varg lib/kobject.c:368 [inline]
 kobject_init_and_add+0xdd/0x190 lib/kobject.c:457
 netdev_queue_add_kobject net/core/net-sysfs.c:1995 [inline]
 netdev_queue_update_kobjects+0x249/0x6c0 net/core/net-sysfs.c:2054
 register_queue_kobjects net/core/net-sysfs.c:2117 [inline]
 netdev_register_kobject+0x258/0x310 net/core/net-sysfs.c:2360
 register_netdevice+0x126c/0x1ae0 net/core/dev.c:11206
 bond_newlink+0x60/0xb0 drivers/net/bonding/bond_netlink.c:590
 rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3825
 __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
 rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4057
page last free pid 11632 tgid 11632 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 pagetable_free include/linux/mm.h:2898 [inline]
 pagetable_dtor_free include/linux/mm.h:2996 [inline]
 __tlb_remove_table+0x2d2/0x3b0 include/asm-generic/tlb.h:220
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff888053821f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888053822000: 06 fc fc fc 06 fc fc fc fa fc fc fc fa fc fc fc
>ffff888053822080: fa fc fc fc 05 fc fc fc 01 fc fc fc 00 fc fc fc
                                           ^
 ffff888053822100: 00 fc fc fc 00 fc fc fc 05 fc fc fc 05 fc fc fc
 ffff888053822180: 05 fc fc fc 05 fc fc fc 05 fc fc fc fa fc fc fc
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

