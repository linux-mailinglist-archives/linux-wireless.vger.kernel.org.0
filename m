Return-Path: <linux-wireless+bounces-26385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB5B26172
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0739582959
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1A82E9752;
	Thu, 14 Aug 2025 09:42:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603B28504B
	for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164555; cv=none; b=L/EHz0V8FilLy4Jjf5GC0hjPCxtCP0v8ptEBybStlVvFE8HeRjdHTMFOUfnJ2Y6Jrr6FimFlSrQBkIHv767aIKHcADm/3uZZBBct6vQaj3F77RYS/hKGB0+c7aoF8ypmbeTQV36c+Xsg91RhycZORS4RBFeHLPQakSS6LfPblf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164555; c=relaxed/simple;
	bh=HK7wjbZ2TBaPM33in7VSgcP3FCSqEX29s6jE++uMvLo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j74I65So/+RgJ1gIjVV09A2RCQMujZdW2JsWGxdAI0fIsQO7wMcuKgV9+qUV/K09R5802oa8aj0+4zk3ZKjVi8y0dXS4eTEqgZ+OtN/eBgIXh240fhKXuhjgBZeqMioREKzVLYEjWMTXlP5hLD/ZxSHBDSLosNMCXhh7oMWJ6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88432e1eaa5so179810939f.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 02:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755164553; x=1755769353;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Bje1TugN+kD58hq4oWKLa5Ok4zlZyJ9oM5ehqRuTuw=;
        b=ZfEbVqVdG8nZkYNg9oVzytWUj/lutk2KBNJnWP8hkXlo0qTu4w1bajfbCLt7PjErvn
         C5nD8sbfMV3UL8qfuaN20LU4hWz4IfASI6w5JHAsECH2xlmAsP9xLI5nEVde2SJGRa88
         Aiut4NJOEfDVw7EsYyYSHMK4O+46NaDH47y4IDW6Lf8zwtVpWQ4jvZadHnl46aZHzyPZ
         9QP+LJRUFOf7XFiydKq11eFgJCU8Rt7HYgDYnT6fTA21XNuXvE7ixTKd8PIwqeMIi1LU
         ef8dz/QoYrnWH1OzcppeNRlVXi6ilKNf7wnNuquhWhKiH8n1XeE9wVEuaHQisZa94m5o
         KVRg==
X-Forwarded-Encrypted: i=1; AJvYcCUHoktNfiGif78K8wmzck0dWIvgBVxC4JzVO4Cj6odGUzDTRzyQtBApXoMEVGB1te47mtwszCvFwZHXSUA80Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlYp9hifUBkTXoV/ojCXznnd+RlHkyqwBksycgbEvn0+5Gp5cr
	hIHnr6j6nSzIeuJAwHpoaagU1D0l5305QBSznlC9dGE7x5LF2/Xuche0U11+MNum6b0JyVfftLy
	/d16H1Ke48b+hbbXr15SAgQgfNASPRdQDweLvJ3u3aF2p4gRC/yLLfsqV1H4=
X-Google-Smtp-Source: AGHT+IHaibs0qJyxxHhtqEgf2/Jjup2rZR0i2DUjwlTbduXOK6RtGuKfDvdMmsf9LakZ0xjbjjMr1I4I5Lm4ETYvW3i1Oh3xpyxO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1304:b0:881:6d77:6d81 with SMTP id
 ca18e2360f4ac-88433851730mr358291439f.8.1755164552899; Thu, 14 Aug 2025
 02:42:32 -0700 (PDT)
Date: Thu, 14 Aug 2025 02:42:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689daf88.050a0220.2d37a5.0001.GAE@google.com>
Subject: [syzbot] [libertas?] INFO: task hung in lbs_remove_card
From: syzbot <syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com>
To: libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b38afce25c4 Merge tag 'turbostat-2025.09.09' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=142f4af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc65f9fdda222232
dashboard link: https://syzkaller.appspot.com/bug?extid=c99d17aa44dbdba16ad2
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03c1659365fe/disk-2b38afce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c24a7ba0c087/vmlinux-2b38afce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae60f96c7e73/bzImage-2b38afce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com

INFO: task kworker/1:5:10878 blocked for more than 143 seconds.
      Not tainted 6.16.0-syzkaller-12288-g2b38afce25c4 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:5     state:D
 stack:21576 pid:10878 tgid:10878 ppid:2      task_flags:0x4288060 flags:0x00004000
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x12fc/0x3b90 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 lbs_wait_for_firmware_load+0x11e/0x1e0 drivers/net/wireless/marvell/libertas/firmware.c:116
 lbs_remove_card+0x84/0x390 drivers/net/wireless/marvell/libertas/main.c:913
 if_usb_disconnect+0xaf/0x2e0 drivers/net/wireless/marvell/libertas/if_usb.c:316
 usb_unbind_interface+0x1dd/0x9e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:571 [inline]
 device_remove+0x125/0x170 drivers/base/dd.c:563
 __device_release_driver drivers/base/dd.c:1274 [inline]
 device_release_driver_internal+0x44b/0x620 drivers/base/dd.c:1297
 usb_driver_release_interface drivers/usb/core/driver.c:640 [inline]
 usb_forced_unbind_intf+0x144/0x220 drivers/usb/core/driver.c:1133
 usb_reset_device+0x439/0xa90 drivers/usb/core/hub.c:6403
 if_usb_reset_device.isra.0+0x215/0x280 drivers/net/wireless/marvell/libertas/if_usb.c:400
 if_usb_prog_firmware+0x63c/0x10c0 drivers/net/wireless/marvell/libertas/if_usb.c:877
 lbs_fw_loaded drivers/net/wireless/marvell/libertas/firmware.c:23 [inline]
 helper_firmware_cb drivers/net/wireless/marvell/libertas/firmware.c:80 [inline]
 helper_firmware_cb+0x1f8/0x2e0 drivers/net/wireless/marvell/libertas/firmware.c:64
 request_firmware_work_func+0x139/0x250 drivers/base/firmware_loader/main.c:1161
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5b6/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff892c7320 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff892c7320 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff892c7320 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
2 locks held by getty/2908:
 #0: ffff8881123fe0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
4 locks held by udevd/5192:
3 locks held by kworker/0:4/5233:
3 locks held by kworker/1:5/10878:
 #0: ffff888100080d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3211
 #1: ffffc90016497d10 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3212
 #2: ffff88814573d160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:911 [inline]
 #2: ffff88814573d160 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1096 [inline]
 #2: ffff88814573d160 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xa4/0x620 drivers/base/dd.c:1294
3 locks held by kworker/1:8/12237:
3 locks held by kworker/0:1/14373:
5 locks held by kworker/0:8/19369:
 #0: ffff888106eaf548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3211
 #1: ffffc90013447d10 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3212
 #2: ffff88810b752198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:911 [inline]
 #2: ffff88810b752198 (&dev->mutex){....}-{4:4}, at: hub_event+0x1be/0x5060 drivers/usb/core/hub.c:5898
 #3: ffff88811d13c198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:911 [inline]
 #3: ffff88811d13c198 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0x10a/0x9c0 drivers/usb/core/hub.c:2335
 #4: ffff88814573d160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:911 [inline]
 #4: ffff88814573d160 (&dev->mutex){....}-{4:4}, at: device_del+0xa0/0x9f0 drivers/base/core.c:3840
2 locks held by kworker/u8:0/21113:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3211
 #1: ffffc90012d3fd10 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3212
4 locks held by kworker/1:7/23200:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.16.0-syzkaller-12288-g2b38afce25c4 #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf0e/0x1260 kernel/hung_task.c:491
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5b6/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5219 Comm: kworker/1:4 Not tainted 6.16.0-syzkaller-12288-g2b38afce25c4 #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events legacy_dvb_usb_read_remote_control
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:407
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1c 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d e9 06 6b 66 04 e8 41 85 02 ff eb a0 e8 ca 85 02
RSP: 0018:ffffc9000233f700 EFLAGS: 00000006
RAX: 0000000000000000 RBX: 00000000000003f9 RCX: 0000000000000000
RDX: 00000000000003f9 RSI: ffffffff82d9a765 RDI: ffffffff93b7f160
RBP: ffffffff93b7f120 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff93b7f120 R15: ffffffff93b7f3e0
FS:  0000000000000000(0000) GS:ffff888268ffc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555908fc4a8 CR3: 000000014b144000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 serial_out drivers/tty/serial/8250/8250.h:142 [inline]
 serial8250_clear_IER+0x9b/0xc0 drivers/tty/serial/8250/8250_port.c:713
 serial8250_console_write+0x255/0x1890 drivers/tty/serial/8250/8250_port.c:3361
 console_emit_next_record kernel/printk/printk.c:3138 [inline]
 console_flush_all+0x7fe/0xc60 kernel/printk/printk.c:3226
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xd8/0x210 kernel/printk/printk.c:3325
 vprintk_emit+0x418/0x6d0 kernel/printk/printk.c:2450
 _printk+0xc7/0x100 kernel/printk/printk.c:2475
 legacy_dvb_usb_read_remote_control+0x40b/0x4f0 drivers/media/usb/dvb-usb/dvb-usb-remote.c:124
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5b6/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

