Return-Path: <linux-wireless+bounces-30207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BBACEB389
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 05:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31E53011F90
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 04:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE530F92A;
	Wed, 31 Dec 2025 04:14:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DFF30F80C
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767154468; cv=none; b=UQXs9tcza8ITadVcM/2/3be2vsLeFebv/Ln1fnflwN6vr8dV1i/jGhxRs/s0cETJETkCrHnkN6hparpKzTSTOeHqLUgcWzUIXw2WKn/YiQc/qn53XuVY5KqJOcPiFHezdPN8Hl7jXGsCHAR6p7ssJNotNsofOBSaZppCUqc1dig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767154468; c=relaxed/simple;
	bh=NLp+GqonT7TxfcBtM9AcV30QHO42A5+5z/eprZnKsso=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hDIBwXsXw2mYDN7lklHS8TMcebWC4652f3UO3wVDHYp6sSh5KK3w5Yh68lNyOhS0qTMaB/8TQ3ffwYkcvLxLTc++PlNBZNIbnKJQ1QCxXwPzpNIIRZ/Fir6h+3ZAm3nfHUT/7OjGpPuD3KfxIvwBiub2a3syAoRFCzqFCeJv+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7cdcd09efc6so15309672a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 20:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767154465; x=1767759265;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63oeKB12vFHol3QuyqrM5A0VJFGxM3N5n/+Zzmk8C64=;
        b=VW2ZKdTdcOzXOuhsCpBMGhzhzbGyY1sUH0/g7OAb9sIhoE1mRU9UINIvBdHNDYTD8e
         mbFdnMs5oP4CfwYtW1QZ9UJk5Y+s9VNNXX59Q77AU5LfbQ0ClTWw25GeRqOtuTPkC0t5
         JzGvFK9Pwb+WOMP8hxtIwvERX2vvRWXeTBqgxMHpaJj/d8qbsnWi6yCsbM55u42/k2Jl
         hkbQxBzHb6Jb60utoCEJKYFjEqV62bxvY9PSf0nGcT2BNgglNYLhjrk+C9z//PtasL32
         VJ7SlOI9URkMmy9eoYp8fV6bQBWlhMgI9luO9FylP0H32JCiEcCAPKOAG/Z2RBp3rkog
         Mh4w==
X-Forwarded-Encrypted: i=1; AJvYcCXGGHmBnDFaQiry8HVrVE33VByH3nfzSGdLpDzNNWh86pHHfp50s+kF3rJKjgWPgGNiVpEhGcnly4hQb+r3Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mjxAuxt353IcgDdfkdwPkx6ly3Fuv2Prh25SpdHXRndMFBtA
	IWrr7fP8YQ2enNt/uQt/j044+cFM48qzwh2KWTwlhBB4QNnk5r3kg4CaFQLzKNsvfiWs18/NcD+
	GNmuTN1tDXyV2DZAJahxnl1++YQzM6Z0fYXFWJVilStaGT5btNCDQq/lCH7o=
X-Google-Smtp-Source: AGHT+IEI7zOaVVhB2VUTLfQFH/VA95AWQw87O9ReoQMx0Az0WPEughRIAWeGpxsZ1UZ2hmo9+T1eTFt7kNwEjBYlVi9E0b5uieLM
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c309:b0:65d:2a0:4b57 with SMTP id
 006d021491bc7-65d0e9e3c2emr10108236eaf.34.1767154464977; Tue, 30 Dec 2025
 20:14:24 -0800 (PST)
Date: Tue, 30 Dec 2025 20:14:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6954a320.050a0220.a1b6.030c.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in rfkill_uevent_work (2)
From: syzbot <syzbot+ef8f802abdb9a32343fc@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6402078bd9d1 smc91x: fix broken irq-context in PREEMPT_RT
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1009089a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=ef8f802abdb9a32343fc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9ff0ff2d0624/disk-6402078b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35e0f035cd5b/vmlinux-6402078b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4d8903e48b4/bzImage-6402078b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef8f802abdb9a32343fc@syzkaller.appspotmail.com

INFO: task kworker/1:6:5902 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:23064 pid:5902  tgid:5902  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events rfkill_uevent_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 rfkill_uevent_work+0x1d/0xa0 net/rfkill/core.c:1046
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
INFO: task kworker/1:7:5940 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:7     state:D stack:23640 pid:5940  tgid:5940  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events rfkill_global_led_trigger_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 rfkill_global_led_trigger_worker+0x27/0xd0 net/rfkill/core.c:182
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
INFO: task syz.4.1326:10654 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.1326      state:D stack:27848 pid:10654 tgid:10645 ppid:5823   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 rfkill_unregister+0xc8/0x220 net/rfkill/core.c:1145
 nfc_unregister_device+0x96/0x300 net/nfc/core.c:1167
 virtual_ncidev_close+0x56/0x90 drivers/nfc/virtual_ncidev.c:172
 __fput+0x44c/0xa70 fs/file_table.c:468
 fput_close_sync+0x113/0x220 fs/file_table.c:573
 __do_sys_close fs/open.c:1573 [inline]
 __se_sys_close fs/open.c:1558 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1558
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe0fd38f749
RSP: 002b:00007fe0fe1af038 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007fe0fd5e6090 RCX: 00007fe0fd38f749
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007fe0fd413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe0fd5e6128 R14: 00007fe0fd5e6090 R15: 00007ffda314ccd8
 </TASK>
INFO: task syz.3.1329:10652 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.1329      state:D stack:26824 pid:10652 tgid:10651 ppid:5820   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 device_lock include/linux/device.h:895 [inline]
 nfc_dev_down+0x3b/0x290 net/nfc/core.c:143
 nfc_rfkill_set_block+0x2d/0x100 net/nfc/core.c:179
 rfkill_set_block+0x1d2/0x440 net/rfkill/core.c:346
 rfkill_fop_write+0x44b/0x570 net/rfkill/core.c:1301
 vfs_write+0x27e/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5d3df8f749
RSP: 002b:00007f5d3c1f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5d3e1e5fa0 RCX: 00007f5d3df8f749
RDX: 0000000000000008 RSI: 0000200000000080 RDI: 0000000000000007
RBP: 00007f5d3e013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5d3e1e6038 R14: 00007f5d3e1e5fa0 R15: 00007ffc31049198
 </TASK>
INFO: task syz.0.1369:10782 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.1369      state:D stack:26200 pid:10782 tgid:10780 ppid:5821   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 rfkill_register+0x37/0x8e0 net/rfkill/core.c:1071
 nfc_register_device+0x14a/0x390 net/nfc/core.c:1132
 nci_register_device+0x87f/0x9d0 net/nfc/nci/core.c:1277
 virtual_ncidev_open+0x129/0x1a0 drivers/nfc/virtual_ncidev.c:157
 misc_open+0x2d5/0x350 drivers/char/misc.c:163
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x7ce/0x1420 fs/open.c:962
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:4628 [inline]
 path_openat+0x340e/0x3dd0 fs/namei.c:4787
 do_filp_open+0x1fa/0x410 fs/namei.c:4814
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f941178f749
RSP: 002b:00007f941253e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f94119e5fa0 RCX: 00007f941178f749
RDX: 0000000000000002 RSI: 0000200000000640 RDI: ffffffffffffff9c
RBP: 00007f9411813f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f94119e6038 R14: 00007f94119e5fa0 R15: 00007ffc71b2e868
 </TASK>
INFO: task syz.2.1371:10794 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.1371      state:D stack:28152 pid:10794 tgid:10792 ppid:5836   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 misc_open+0x51/0x350 drivers/char/misc.c:125
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x7ce/0x1420 fs/open.c:962
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:4628 [inline]
 path_openat+0x340e/0x3dd0 fs/namei.c:4787
 do_filp_open+0x1fa/0x410 fs/namei.c:4814
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f052818f749
RSP: 002b:00007f0529000038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f05283e6090 RCX: 00007f052818f749
RDX: 0000000000000000 RSI: 0000200000000200 RDI: ffffffffffffff9c
RBP: 00007f0528213f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f05283e6128 R14: 00007f05283e6090 R15: 00007fffc47a0e08
 </TASK>
INFO: task syz.1.1372:10799 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1372      state:D stack:26648 pid:10799 tgid:10798 ppid:5822   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 misc_open+0x51/0x350 drivers/char/misc.c:125
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x7ce/0x1420 fs/open.c:962
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:4628 [inline]
 path_openat+0x340e/0x3dd0 fs/namei.c:4787
 do_filp_open+0x1fa/0x410 fs/namei.c:4814
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd26a18f749
RSP: 002b:00007fd2683ee038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fd26a3e5fa0 RCX: 00007fd26a18f749
RDX: 0000000000020080 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007fd26a213f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd26a3e6038 R14: 00007fd26a3e5fa0 R15: 00007ffdeeb25618
 </TASK>
INFO: task syz-executor:10806 blocked for more than 145 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27832 pid:10806 tgid:10806 ppid:1      task_flags:0x400040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 misc_open+0x51/0x350 drivers/char/misc.c:125
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x7ce/0x1420 fs/open.c:962
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:4628 [inline]
 path_openat+0x340e/0x3dd0 fs/namei.c:4787
 do_filp_open+0x1fa/0x410 fs/namei.c:4814
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e7178df11
RSP: 002b:00007ffc8e7715d0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4e7178df11
RDX: 0000000000000002 RSI: 00007f4e718149b7 RDI: 00000000ffffff9c
RBP: 00007f4e718149b7 R08: 0000000000000000 R09: 00007f4e7251d6c0
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000008
R13: 0000000000000003 R14: 00007ffc8e7719a8 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:10807 blocked for more than 145 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27688 pid:10807 tgid:10807 ppid:1      task_flags:0x400040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 misc_open+0x51/0x350 drivers/char/misc.c:125
 chrdev_open+0x4cc/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x7ce/0x1420 fs/open.c:962
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:4628 [inline]
 path_openat+0x340e/0x3dd0 fs/namei.c:4787
 do_filp_open+0x1fa/0x410 fs/namei.c:4814
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb9c638df11
RSP: 002b:00007ffcf7306890 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb9c638df11
RDX: 0000000000000002 RSI: 00007fb9c64149b7 RDI: 00000000ffffff9c
RBP: 00007fb9c64149b7 R08: 0000000000000000 R09: 00007fb9c711d6c0
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000008
R13: 0000000000000003 R14: 00007ffcf7306c68 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:0/12:
 #0: ffff88813ff29148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff88813ff29148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x1770 kernel/workqueue.c:3340
 #1: ffff8880b8724588 (psi_seq){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
1 lock held by khungtaskd/31:
 #0: ffffffff8df41a20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df41a20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8df41a20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5583:
 #0: ffff88802fb840a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x449/0x1460 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:6/5902:
 #0: ffff88813ff15948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff88813ff15948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x1770 kernel/workqueue.c:3340
 #1: ffffc90004ec7b80 ((work_completion)(&rfkill->uevent_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
 #1: ffffc90004ec7b80 ((work_completion)(&rfkill->uevent_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x1770 kernel/workqueue.c:3340
 #2: ffffffff8f5fd668 (rfkill_global_mutex){+.+.}-{4:4}, at: rfkill_uevent_work+0x1d/0xa0 net/rfkill/core.c:1046
3 locks held by kworker/1:7/5940:
 #0: ffff88813ff15948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff88813ff15948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x1770 kernel/workqueue.c:3340
 #1: ffffc90004fa7b80 ((work_completion)(&rfkill_global_led_trigger_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
 #1: ffffc90004fa7b80 ((work_completion)(&rfkill_global_led_trigger_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x1770 kernel/workqueue.c:3340
 #2: ffffffff8f5fd668 (rfkill_global_mutex){+.+.}-{4:4}, at: rfkill_global_led_trigger_worker+0x27/0xd0 net/rfkill/core.c:182
2 locks held by syz.4.1326/10654:
 #0: ffff888078c13100 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #0: ffff888078c13100 (&dev->mutex){....}-{4:4}, at: nfc_unregister_device+0x63/0x300 net/nfc/core.c:1165
 #1: ffffffff8f5fd668 (rfkill_global_mutex){+.+.}-{4:4}, at: rfkill_unregister+0xc8/0x220 net/rfkill/core.c:1145
2 locks held by syz.3.1329/10652:
 #0: ffffffff8f5fd668 (rfkill_global_mutex){+.+.}-{4:4}, at: rfkill_fop_write+0x191/0x570 net/rfkill/core.c:1293
 #1: ffff888078c13100 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #1: ffff888078c13100 (&dev->mutex){....}-{4:4}, at: nfc_dev_down+0x3b/0x290 net/nfc/core.c:143
3 locks held by syz.0.1369/10782:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
 #1: ffff8880772a7100 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #1: ffff8880772a7100 (&dev->mutex){....}-{4:4}, at: nfc_register_device+0xa1/0x390 net/nfc/core.c:1128
 #2: ffffffff8f5fd668 (rfkill_global_mutex){+.+.}-{4:4}, at: rfkill_register+0x37/0x8e0 net/rfkill/core.c:1071
1 lock held by syz.2.1371/10794:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz.1.1372/10799:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10806:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10807:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10811:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10812:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10813:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10816:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10817:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10821:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10822:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10823:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10827:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10828:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10832:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10833:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125
1 lock held by syz-executor/10834:
 #0: ffffffff8e79fae8 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x51/0x350 drivers/char/misc.c:125

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xf95/0xfe0 kernel/hung_task.c:515
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 93 90 0c 00 f3 0f 1e fa fb f4 <e9> c8 ed 02 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: e3977c00b5531a00 RBX: ffffffff81978fda RCX: e3977c00b5531a00
RDX: 0000000000000001 RSI: ffffffff8d7925ee RDI: ffffffff8bc08360
RBP: ffffc90000197f10 R08: ffff8880b87336db R09: 1ffff110170e66db
R10: dffffc0000000000 R11: ffffed10170e66dc R12: ffffffff8f822070
R13: 1ffff110038dab70 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125f35000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056230ca78000 CR3: 000000000dd3a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x1ea/0x520 kernel/sched/idle.c:332
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:430
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x147
 </TASK>


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

