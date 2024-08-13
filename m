Return-Path: <linux-wireless+bounces-11329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D2094FCEE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 06:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA2A1F21BB5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 04:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905BC21345;
	Tue, 13 Aug 2024 04:37:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0820B35
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523847; cv=none; b=UD3yN5LVab78eSjltLspYeKYDbsSxrahWrO2jynX/lp+xjtj1NeLcOthClDdWo0alH5cDwUpybnJKI20yO/RjFqEunduwzLjZRsv5FYOomQbIcq4K4+LJW5JPVpiTmXqzezM9Je+VXrhfrjbjDKbhQCO6BFyF0oUHuTFpJPihXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523847; c=relaxed/simple;
	bh=9XQ+l8dVBD+WczosP8bbD5GOhPeI+bJoLGJ5Mc4wNuU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TyC3ken7cPxI9Rbmsmn6Mt2FGDKrlHwOotIR61hWBUbu89EPVh7Ghz9R5aDiiimLocZ3X+UBjlIkwkidObsopQqDZNUB42+wY2u25CYR9+hdtAQ1y+Vtnro5s7nJfe8pHx/NHrLTQTxhfClurODCTMr63z5MWdQ7uwlJ1eMOZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f95058fb9so693293439f.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 21:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723523845; x=1724128645;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWOAZ5lE73P5PioQsL145/zO+FEe7lzDRGwAr3nTRd8=;
        b=CJgA8UvNbwiqpIWAvvTU5udtNXM/DPynBBOP8kSlUaI+vFsUQQNlWI+1e5DlrBj5tX
         /8+Y4u3iySWvoLe15Ws1LXN/VIP22YJZ8tTgCwR81DW3R/Tm56zklBu4ZDzjivgQWaHh
         MINofq6R4YNnKvdQyLnbABDMLZcOIRVyOeVntnA/DcRrm7HRvZvjxH7k6jaFZk7ecYL0
         4ngnJVYvgulFvbt++NgKSJ9h7Nz6cWRjHVMQQr/PrF379m8ixWb1D2O75PN6EXyG2g9R
         H6j4YAUW64ciYOscIAL3de9cxMaUjY6hw+x4kBAAvwzurMaeoNgk0NFfOzOASL9TUcVS
         RMvw==
X-Forwarded-Encrypted: i=1; AJvYcCUYqio1O4x+9rbNl+27nXtIAn+lEVTM2/6W7juekBRYOrhDY+0DvJfk9z7lPwF8yhhRPtNAbjoKZhP/D4EB1fbOgge5k9ZoL75IZGBF8DQ=
X-Gm-Message-State: AOJu0Yxe/6UfqBjacIAlB8F0dHVuUDEn56xBb+YIL9yBrbEOUMnBZVU1
	Tj+pioI2rpY4M+csg07mYuZVs27SKM7C2/Ug1gtfp7MKFOfXl5rre3f+jxnKgnpmp+y61Go4PfI
	SFVhnlNpdnmb46+agNP3HpG+P9+D/Iz+PRVqnEojqlzYaMXaXToqkDFA=
X-Google-Smtp-Source: AGHT+IH8KRxJRZg7KG7BonMWzd6BDWeqhrduwCL5gkimhh/jYyo+dxzjDlGnO1s7JT0t1gLxk/ApcrnqqzjQsibkDk2ex1FKBg8A
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:861a:b0:4c0:9a05:44c4 with SMTP id
 8926c6da1cb9f-4ca9f43494amr147312173.0.1723523844761; Mon, 12 Aug 2024
 21:37:24 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:37:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000877f44061f892ace@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in ath9k_hif_usb_firmware_cb (3)
From: syzbot <syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb5e56d14912 Merge tag 'platform-drivers-x86-v6.11-2' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137edff9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6552acb8476/disk-eb5e56d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c0963cd33df/vmlinux-eb5e56d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ba7283f6380/bzImage-eb5e56d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com

INFO: task kworker/0:7:5284 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc2-syzkaller-00011-geb5e56d14912 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:13232 pid:5284  tgid:5284  ppid:2      flags:0x00004000
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 ath9k_hif_usb_firmware_fail drivers/net/wireless/ath/ath9k/hif_usb.c:1163 [inline]
 ath9k_hif_usb_firmware_cb+0x34a/0x4b0 drivers/net/wireless/ath/ath9k/hif_usb.c:1296
 request_firmware_work_func+0x1a4/0x280 drivers/base/firmware_loader/main.c:1167
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task udevd:2711 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc2-syzkaller-00011-geb5e56d14912 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:24864 pid:2711  tgid:2711  ppid:4679   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x17d/0x340 drivers/base/core.c:2743
 dev_attr_show+0x55/0xc0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
 seq_read_iter+0x445/0xd60 fs/seq_file.c:230
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9bd/0xbc0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa861574b6a
RSP: 002b:00007ffd4a139b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005608f0417730 RCX: 00007fa861574b6a
RDX: 0000000000001000 RSI: 00005608f0434930 RDI: 0000000000000008
RBP: 00005608f0417730 R08: 0000000000000008 R09: 0000000000000020
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffd4a13a058 R15: 000000000000000a
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e9382a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e9382a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e9382a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6620
2 locks held by getty/4986:
 #0: ffff88802b1460a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900034b32f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/0:7/5284:
 #0: ffff888015880948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015880948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90004097d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90004097d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff888023f4b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023f4b190 (&dev->mutex){....}-{3:3}, at: ath9k_hif_usb_firmware_fail drivers/net/wireless/ath/ath9k/hif_usb.c:1163 [inline]
 #2: ffff888023f4b190 (&dev->mutex){....}-{3:3}, at: ath9k_hif_usb_firmware_cb+0x34a/0x4b0 drivers/net/wireless/ath/ath9k/hif_usb.c:1296
3 locks held by kworker/u8:12/7485:
 #0: ffff88802ad75948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802ad75948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900035a7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900035a7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc81688 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
3 locks held by kworker/1:5/14520:
 #0: ffff888015880948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015880948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003db7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003db7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc81688 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
3 locks held by kworker/0:0/22216:
 #0: ffff888015880948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015880948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003977d00 ((work_completion)(&(&devlink->rwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003977d00 ((work_completion)(&(&devlink->rwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e93d678 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 #2: ffffffff8e93d678 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
5 locks held by kworker/1:4/1612:
1 lock held by syz.1.6316/1883:
4 locks held by udevd/2711:
 #0: ffff888074214e80 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff88802cf7a088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff88805dac6878 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff888056d20190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888056d20190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743
3 locks held by syz-executor/4016:
 #0: ffff88805bc68d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff88805bc68d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_unregister_dev+0x203/0x510 net/bluetooth/hci_core.c:2692
 #1: ffff88805bc68078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x572/0x11a0 net/bluetooth/hci_sync.c:5131
 #2: ffffffff8fdecfa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:1977 [inline]
 #2: ffffffff8fdecfa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_hash_flush+0xa6/0x240 net/bluetooth/hci_conn.c:2592
3 locks held by syz-executor/4137:
 #0: ffff88805b408d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff88805b408d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_unregister_dev+0x203/0x510 net/bluetooth/hci_core.c:2692
 #1: ffff88805b408078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x572/0x11a0 net/bluetooth/hci_sync.c:5131
 #2: ffffffff8fdecfa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:1977 [inline]
 #2: ffffffff8fdecfa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_hash_flush+0xa6/0x240 net/bluetooth/hci_conn.c:2592
3 locks held by syz-executor/4253:
 #0: ffff88806a4bcd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff88806a4bcd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_unregister_dev+0x203/0x510 net/bluetooth/hci_core.c:2692
 #1: ffff88806a4bc078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x572/0x11a0 net/bluetooth/hci_sync.c:5131
 #2: ffffffff8fdecfa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:1977 [inline]
 #2: ffffffff8fdecfa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_hash_flush+0xa6/0x240 net/bluetooth/hci_conn.c:2592
1 lock held by syz.2.6861/4431:
 #0: ffffffff8fc81688 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fc81688 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x1b0 drivers/net/tun.c:3510
1 lock held by syz.0.6862/4436:
 #0: ffffffff8fc81688 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fc81688 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x1b0 drivers/net/tun.c:3510

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc2-syzkaller-00011-geb5e56d14912 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 7493 Comm: kworker/u8:17 Not tainted 6.11.0-rc2-syzkaller-00011-geb5e56d14912 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:unwind_next_frame+0x8ea/0x2a00 arch/x86/kernel/unwind_orc.c:517
Code: fd 04 0f 84 6c 01 00 00 83 fd 05 0f 85 ff 02 00 00 e8 ca 56 52 00 48 8b 44 24 58 42 80 3c 28 00 74 08 48 89 df e8 46 90 b9 00 <48> 8b 33 48 8b 54 24 18 48 8d 5a 01 48 89 d0 48 c1 e8 03 42 0f b6
RSP: 0018:ffffc90003ab7308 EFLAGS: 00000246
RAX: 1ffff92000756e83 RBX: ffffc90003ab7418 RCX: ffff88804523da00
RDX: 0000000000000000 RSI: ffffffff8e7a3d60 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000005 R09: ffffffff81411f0e
R10: 0000000000000008 R11: ffff88804523da00 R12: ffffffff9030505c
R13: dffffc0000000000 R14: ffffc90003ab7430 R15: 1ffff92000756e7c
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056487295a131 CR3: 000000000e734000 CR4: 00000000003506f0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1b1e/0x2d70 net/mac80211/ibss.c:1606
 ieee80211_iface_process_skb net/mac80211/iface.c:1588 [inline]
 ieee80211_iface_work+0x8a5/0xf20 net/mac80211/iface.c:1642
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

