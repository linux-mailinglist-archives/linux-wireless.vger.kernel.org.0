Return-Path: <linux-wireless+bounces-25408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB51B048EF
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 23:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5FA4A1A10
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E124239E6E;
	Mon, 14 Jul 2025 21:02:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED6238150
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526955; cv=none; b=RBz1RUgD2+ejR7ZfHp98t6hf6PxDqK24k/SvG1yZEstfrBhNT1/GRArrOk2PD8q/CFyMmdtq7k48eBybzJfe/crDOnQS0wFwKayioQ7lPt/cHt5kp1QbSUWpwwznkpypvp4x6zFR2jK+DdNQoNFQvEC/qLRa03l/BgbaiFaQl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526955; c=relaxed/simple;
	bh=xH3QLy9ZM+VnbqR3ZsfNogbkwjOy1dIvl2E4ICHDUwY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cEgQJeY1LIX1jwIjgwvRzSNy5FE2Y1vvRfSLZ2nU09RJZd0w3NXpE9kWC4tzefS/dMZ+2td+IWbv9/H+ahZ8Kpg2AhGKBQXn0x9/cH7B64oJRXfqC9JRG4osK7fBNrBWBnIsx/3DsaAQWZB0582A1hlZdgyeeMmJ0623CuLfH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86d07944f29so1010065139f.0
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 14:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752526953; x=1753131753;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2Q1NLh7gUoTVClx27jDS/g66nSd1V24PSANTOejsys=;
        b=jGPCNMzSNkzVU1WgFHQpHNvVJIebj5lvHntATupxSCrb+h6kRI5S1+jRq4jqEE2CfF
         t0XCnsD3V80aB63uHFCpuXhmOU6DjdqDyX2htXK4cdZKEuWx7FL9j+wfRvF3uRtXNqMP
         lWQvApIZ45nbiDMrs8pih7T7ccx46+oMEMTVocyZA+9JwAdspeIJr1cyGMbneAQFoA9e
         vL2WcJkvzXIELf5sYndhzdFQRf61rYtajerKTSCxVsdMTPLGEWT6x1RQByfMOR9w3pck
         MxzAoQnh+11E/4SgzrwAlhHSowq5aQ+JnAi2mPqkzwpU9fAJHykKWzmNonYtoqSPU+pa
         IL6A==
X-Forwarded-Encrypted: i=1; AJvYcCWT8og8ZUgg8s/EadLwsOi8DRaHq1PL1XAUvWRNAwrtMkNoS36Al84FSXYSTOHcEe66kwjFbiIiOpAG+8KGxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaDWByHTt8RyKu8x3SiYLG907wE7o0kVbQ85NI84iIH7bqpkn
	AlWXzcp4ohojQOLRtbWBrPMZj/qhU5Up18MM3PI9/yYvjRqrQfuNzuSq68VV/v5wpbGnt2Lw90y
	3L+9Rg1riaPuYwuAXIrCrmBopt4Vevx+PP1BZt09r0vD8Ac9bAL8Zhh8l7gM=
X-Google-Smtp-Source: AGHT+IH8lFGhU84Vmgqxm566NwZTQrh3zGXp2GScmXDpOp9azBaSRZ+zVJ3KiQ1WYhskdPAtHVvLeToalmaGLoapz1rMj4jaMNII
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60ca:b0:86c:ef0b:3a52 with SMTP id
 ca18e2360f4ac-8797883ec84mr1643507939f.11.1752526952671; Mon, 14 Jul 2025
 14:02:32 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:02:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68757068.a70a0220.18f9d4.000a.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in el1_interrupt
From: syzbot <syzbot+6d053681b57b25d51ba9@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ec4801305969 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=157c3a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=6d053681b57b25d51ba9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141c0d82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137c3a8c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64d8dc107d9d/disk-ec480130.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31280b2dee28/vmlinux-ec480130.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3f9fb3d09f8/Image-ec480130.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d053681b57b25d51ba9@syzkaller.appspotmail.com

INFO: task kworker/u8:7:279 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc5-syzkaller-gec4801305969 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:7    state:D stack:0     pid:279   tgid:279   ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: events_power_efficient crda_timeout_work
Call trace:
 __switch_to+0x414/0x834 arch/arm64/kernel/process.c:742 (T)
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x1414/0x2a28 kernel/sched/core.c:6790
 preempt_schedule_irq+0x80/0x188 kernel/sched/core.c:7113
 arm64_preempt_schedule_irq+0x44/0x58 arch/arm64/kernel/entry-common.c:305
 el1_interrupt+0x3c/0x
 __el1_irq arch/arm64/kernel/entry-common.c:656 [inline]
 el1_interrupt+0x3c/0x54 arch/arm64/kernel/entry-common.c:668
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:673
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 put_cpu_partial+0x154/0x1c0 mm/slub.c:3258 (P)
 __slab_free+0x1b0/0x280 mm/slub.c:4513
 do_slab_free mm/slub.c:4595 [inline]
 ___cache_free+0x150/0x170 mm/slub.c:4701
 qlink_free+0x48/0x94 mm/kasan/quarantine.c:163
 qlist_free_all+0x44/0xb8 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x118/0x124 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x2c/0x88 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __kmalloc_cache_noprof+0x238/0x3fc mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 regulatory_hint_core net/wireless/reg.c:3246 [inline]
 restore_regulatory_settings+0x1664/0x2504 net/wireless/reg.c:3578
 crda_timeout_work+0x38/0x68 net/wireless/reg.c:543
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3402
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:843

Showing all locks held in the system:
3 locks held by kworker/u8:0/12:
 #0: ffff0000d11ae948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x63c/0x155c kernel/workqueue.c:3212
 #1: ffff800097a87bc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x6d4/0x155c kernel/workqueue.c:3212
 #2: ffff8000928b6568 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
2 locks held by kworker/1:0/24:
1 lock held by khungtaskd/32:
 #0: ffff80008f8599c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:330
3 locks held by kworker/u8:2/41:
 #0: ffff0000c0031948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x63c/0x155c kernel/workqueue.c:3212
 #1: ffff8000990e7bc0 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work+0x6d4/0x155c kernel/workqueue.c:3212
 #2: ffff8000928b6568 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
3 locks held by kworker/u8:3/42:
5 locks held by pr/ttyAMA0/43:
2 locks held by kworker/u8:6/217:
4 locks held by kworker/u8:7/279:
3 locks held by kworker/u8:8/318:
2 locks held by kworker/1:2/1821:
3 locks held by kworker/u8:10/2084:
3 locks held by kworker/u8:11/2164:
4 locks held by kworker/0:2/2316:
1 lock held by klogd/6132:
4 locks held by udevd/6143:
3 locks held by dhcpcd/6198:
2 locks held by getty/6295:
 #0: ffff0000d25040a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80009ba2e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x34c/0xfa4 drivers/tty/n_tty.c:2222
2 locks held by kworker/1:3/6637:
3 locks held by kworker/0:3/6642:
 #0: ffff0000c0028d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x63c/0x155c kernel/workqueue.c:3212
 #1: ffff80009ff67bc0 (deferred_process_work){+.+.}-{0:0}, at: process_one_work+0x6d4/0x155c kernel/workqueue.c:3212
 #2: ffff8000928b6568 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
1 lock held by syz-executor/6650:
 #0: ffff8000928b6568 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
3 locks held by syz-executor/6651:
 #0: ffff80009291bdb0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x28/0x50 net/netlink/genetlink.c:1218
 #1: ffff80009291bbc8 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffff80009291bbc8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffff80009291bbc8 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0xf4/0x624 net/netlink/genetlink.c:1209
 #2: ffff8000928b6568 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
2 locks held by syz-executor/6657:
 #0: ffff80009291bdb0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x28/0x50 net/netlink/genetlink.c:1218
 #1: ffff8000928b6568 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
1 lock held by syz-executor/6658:
 #0: ffff8000928b6568 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
3 locks held by kworker/u8:12/6822:
3 locks held by kworker/u8:13/6823:
2 locks held by kworker/1:5/6824:
3 locks held by kworker/u8:16/6827:
2 locks held by kworker/u8:17/6828:
3 locks held by syz-executor/6829:
2 locks held by udevd/6832:

=============================================



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

