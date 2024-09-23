Return-Path: <linux-wireless+bounces-13091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B6097F17C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 22:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB631C21136
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AAF19F131;
	Mon, 23 Sep 2024 20:03:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CF19F128
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121808; cv=none; b=OQOvubXzoAANpm2t9B/7k7f9Yj9X0mFfapkihW7mMtsizQ3oBiinXrnboeNUOfA8+F2pU/t6WhMi2vxsf6qBHSgJDvUAR9/PqAKqucJk7ULVmo+lCafCFZ4w9HVDRUhBGfqOi41HmhBlUAEp02TcBAo0ZzYzAB1khoR5TbqATHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121808; c=relaxed/simple;
	bh=w2esq3Hu1A46P9t7jE8A5C06Qan2vNN+R5ZECbCiWsg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ptOBI90PO2iPSyz82LpFZzUOMNimjW1DnoL5fvAiTh4qXc2W6im/4MPFxG4nzGeOzk3418GPeaK0MGLmoVc7ExoLSWNGOZnPGuNqEdqieGvGeMyIfZoguOLEc1TuG188aVLYni4GrrtQa8Lw2yLFIo4bfwPuQY3PmY4FBfmGlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aa3527331so488111839f.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 13:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727121806; x=1727726606;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpUmBDq/JOI0pBXVMAzZKutOBIMRstQUmYBemAkVWpY=;
        b=fEpQdqLkTDzjID38dASB/Kl5t45ZA6YoIYWLzO7gTO+GVwSZ3koehDmAO2eCoxxaCp
         kW9dYTNpk+AxrhzLZ2Ie8hkWhZskqXnhKjiFArEq8N0vxQXT+7spzvmleMepXvi7w+ol
         QBBV4DVC1xrKESSh28Oaga2bu66NpKyd65DOTV8MmK45bj/PEPR6uHHNbcSa/NS+Fkmc
         WLLAjzyVim4B13+oTXWqhh4isLlQKXxxK8E+YkGyAlKIVk+7z73qm8qWzJdCAUDugMqe
         EYllReLFlyspOzAK2cIDlleld+hb2lWuZW82ysqSMbA0e3ccKhGvwd0t5S04bjCXjUeM
         8asQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQAGMYZ+RdhBR114ZrhSJS9xR6rsHSllukIgGVPtg6VljdB7g0svdhlOhhe30X4KeqCb4UzWEBVv6jgPUr1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSxyUejSuxa7Zo248mX8Fd2EChfqvMaYcMvzSG/GZ8sEu+ugi
	seFT6Ln/atcEttfpzO/xk78JiYeLOOv8fYlBM7otwYs5uDGNgDH/I34TVKQlVxV0KQ27C5PMj/Q
	ChNlTfF1NmaIdoLRoABK099a3jIOayQMw3IEm/ppksqIQEPA0SbCRBCs=
X-Google-Smtp-Source: AGHT+IEKwBOxEMwYUmg80EeMdLFDwUUQ14/Kx62fkG50+oBQ7MVwET5osVzKaMqZxSoQ2UCiK/iFppLqEgUEWlJjb8YydeKggyHH
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-3a0c8b734e6mr110795295ab.0.1727121806115; Mon, 23 Sep 2024
 13:03:26 -0700 (PDT)
Date: Mon, 23 Sep 2024 13:03:26 -0700
In-Reply-To: <000000000000114385061d997d9c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f1c98e.050a0220.3eed3.0018.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in rfkill_global_led_trigger_worker
 (3)
From: syzbot <syzbot+50499e163bfa302dfe7b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    de5cb0dcb74c Merge branch 'address-masking'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ee0c80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99f4d8e33bb9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fa1e07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e1a107980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-de5cb0dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b69b8a02541/vmlinux-de5cb0dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d8b6c7690df/zImage-de5cb0dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50499e163bfa302dfe7b@syzkaller.appspotmail.com

INFO: task kworker/1:3:111 blocked for more than 450 seconds.
      Not tainted 6.11.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:0     pid:111   tgid:111   ppid:2      flags:0x00000000
Workqueue: events rfkill_global_led_trigger_worker
Call trace: 
[<819b466c>] (__schedule) from [<819b52ac>] (__schedule_loop kernel/sched/core.c:6751 [inline])
[<819b466c>] (__schedule) from [<819b52ac>] (schedule+0x2c/0xfc kernel/sched/core.c:6766)
 r10:82c18205 r9:00000000 r8:827ec108 r7:00000002 r6:df9a1e74 r5:834d9800
 r4:834d9800
[<819b5280>] (schedule) from [<819b5660>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6823)
 r5:834d9800 r4:827ec104
[<819b5648>] (schedule_preempt_disabled) from [<819b8138>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<819b5648>] (schedule_preempt_disabled) from [<819b8138>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<819b7e50>] (__mutex_lock.constprop.0) from [<819b8a04>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c18205 r9:834d9800 r8:01800000 r7:ddde40c0 r6:82c18200 r5:82931dd4
 r4:827ec104
[<819b89f0>] (__mutex_lock_slowpath) from [<819b8a44>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<819b8a08>] (mutex_lock) from [<818bbfb8>] (rfkill_global_led_trigger_worker+0x1c/0xc0 net/rfkill/core.c:182)
[<818bbf9c>] (rfkill_global_led_trigger_worker) from [<80266148>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3229)
 r5:82931dd4 r4:8346f880
[<80265f94>] (process_one_work) from [<80266d2c>] (process_scheduled_works kernel/workqueue.c:3310 [inline])
[<80265f94>] (process_one_work) from [<80266d2c>] (worker_thread+0x1ec/0x3bc kernel/workqueue.c:3391)
 r10:834d9800 r9:8346f8ac r8:61c88647 r7:ddde40e0 r6:82604d40 r5:ddde40c0
 r4:8346f880
[<80266b40>] (worker_thread) from [<8026fd9c>] (kthread+0x104/0x134 kernel/kthread.c:389)
 r10:00000000 r9:df921e78 r8:82f39c00 r7:8346f880 r6:80266b40 r5:834d9800
 r4:8368ab80
[<8026fc98>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf9a1fb0 to 0xdf9a1ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026fc98 r4:8368ab80
INFO: task kworker/1:0:3121 blocked for more than 450 seconds.
      Not tainted 6.11.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:0     pid:3121  tgid:3121  ppid:2      flags:0x00000000
Workqueue: events rfkill_sync_work
Call trace: 
[<819b466c>] (__schedule) from [<819b52ac>] (__schedule_loop kernel/sched/core.c:6751 [inline])
[<819b466c>] (__schedule) from [<819b52ac>] (schedule+0x2c/0xfc kernel/sched/core.c:6766)
 r10:82c18205 r9:00000000 r8:827ec108 r7:00000002 r6:ec251e74 r5:83e02400
 r4:83e02400
[<819b5280>] (schedule) from [<819b5660>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6823)
 r5:83e02400 r4:827ec104
[<819b5648>] (schedule_preempt_disabled) from [<819b8138>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<819b5648>] (schedule_preempt_disabled) from [<819b8138>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<819b7e50>] (__mutex_lock.constprop.0) from [<819b8a04>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:82c18205 r9:83e02400 r8:01800000 r7:ddde40c0 r6:82c18200 r5:8444e684
 r4:8444e684
[<819b89f0>] (__mutex_lock_slowpath) from [<819b8a44>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<819b8a08>] (mutex_lock) from [<818bd800>] (rfkill_sync_work+0x1c/0x5c net/rfkill/core.c:1055)
[<818bd7e4>] (rfkill_sync_work) from [<80266148>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3229)
 r5:8444e684 r4:8467cc00
[<80265f94>] (process_one_work) from [<80266d2c>] (process_scheduled_works kernel/workqueue.c:3310 [inline])
[<80265f94>] (process_one_work) from [<80266d2c>] (worker_thread+0x1ec/0x3bc kernel/workqueue.c:3391)
 r10:83e02400 r9:8467cc2c r8:61c88647 r7:ddde40e0 r6:82604d40 r5:ddde40c0
 r4:8467cc00
[<80266b40>] (worker_thread) from [<8026fd9c>] (kthread+0x104/0x134 kernel/kthread.c:389)
 r10:00000000 r9:df931e78 r8:84496980 r7:8467cc00 r6:80266b40 r5:83e02400
 r4:84496ac0
[<8026fc98>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xec251fb0 to 0xec251ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026fc98 r4:84496ac0
INFO: task syz-executor355:3616 blocked for more than 450 seconds.
      Not tainted 6.11.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor355 state:D stack:0     pid:3616  tgid:3616  ppid:3127   flags:0x00000005
Call trace: 
[<819b466c>] (__schedule) from [<819b52ac>] (__schedule_loop kernel/sched/core.c:6751 [inline])
[<819b466c>] (__schedule) from [<819b52ac>] (schedule+0x2c/0xfc kernel/sched/core.c:6766)
 r10:81c7ff84 r9:00000000 r8:83efc860 r7:00000002 r6:dfc05de4 r5:83701800
 r4:83701800
[<819b5280>] (schedule) from [<819b5660>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6823)
 r5:83701800 r4:83efc85c
[<819b5648>] (schedule_preempt_disabled) from [<819b8138>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<819b5648>] (schedule_preempt_disabled) from [<819b8138>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<819b7e50>] (__mutex_lock.constprop.0) from [<819b8a04>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:81c7ff84 r9:200000c0 r8:00000000 r7:83701800 r6:00000001 r5:83efc85c
 r4:83efc800
[<819b89f0>] (__mutex_lock_slowpath) from [<819b8a44>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<819b8a08>] (mutex_lock) from [<819016f8>] (device_lock include/linux/device.h:1014 [inline])
[<819b8a08>] (mutex_lock) from [<819016f8>] (nfc_dev_down+0x20/0xc8 net/nfc/core.c:143)
[<819016d8>] (nfc_dev_down) from [<819017cc>] (nfc_rfkill_set_block+0x2c/0x68 net/nfc/core.c:179)
 r7:83701800 r6:00000001 r5:83efc800 r4:00000001
[<819017a0>] (nfc_rfkill_set_block) from [<818bcda0>] (rfkill_set_block+0x90/0x144 net/rfkill/core.c:346)
 r5:00000001 r4:83efe800
[<818bcd10>] (rfkill_set_block) from [<818bd358>] (rfkill_fop_write+0x1a8/0x258 net/rfkill/core.c:1301)
 r7:83701800 r6:83efe800 r5:827ec118 r4:00000008
[<818bd1b0>] (rfkill_fop_write) from [<805168b8>] (vfs_write+0xac/0x44c fs/read_write.c:681)
 r6:00000008 r5:84667780 r4:818bd1b0
[<8051680c>] (vfs_write) from [<80516e28>] (ksys_write+0xc4/0xf8 fs/read_write.c:736)
 r10:00000004 r9:83701800 r8:8020029c r7:00000008 r6:200000c0 r5:84667780
 r4:84667780
[<80516d64>] (ksys_write) from [<80516e6c>] (__do_sys_write fs/read_write.c:748 [inline])
[<80516d64>] (ksys_write) from [<80516e6c>] (sys_write+0x10/0x14 fs/read_write.c:745)
 r7:00000004 r6:7edc3160 r5:00000000 r4:ffffffff
[<80516e5c>] (sys_write) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdfc05fa8 to 0xdfc05ff0)
5fa0:                   ffffffff 00000000 00000004 200000c0 00000008 00000000
5fc0: ffffffff 00000000 7edc3160 00000004 7e85fc6c 00002710 000f4240 00000000
5fe0: 7e85fc58 7e85fc48 000106d8 0002ea30
INFO: task syz-executor355:3617 blocked for more than 450 seconds.
      Not tainted 6.11.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor355 state:D stack:0     pid:3617  tgid:3617  ppid:3125   flags:0x00000004
Call trace: 
[<819b466c>] (__schedule) from [<819b52ac>] (__schedule_loop kernel/sched/core.c:6751 [inline])
[<819b466c>] (__schedule) from [<819b52ac>] (schedule+0x2c/0xfc kernel/sched/core.c:6766)
 r10:000000f8 r9:00000000 r8:827ec108 r7:00000002 r6:dfc25e04 r5:83702400
 r4:83702400
[<819b5280>] (schedule) from [<819b5660>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6823)
 r5:83702400 r4:827ec104
[<819b5648>] (schedule_preempt_disabled) from [<819b8138>] (__mutex_lock_common kernel/locking/mutex.c:684 [inline])
[<819b5648>] (schedule_preempt_disabled) from [<819b8138>] (__mutex_lock.constprop.0+0x2e8/0xae0 kernel/locking/mutex.c:752)
[<819b7e50>] (__mutex_lock.constprop.0) from [<819b8a04>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1040)
 r10:000000f8 r9:00000000 r8:82cad790 r7:83f7b000 r6:83f7b024 r5:83efea40
 r4:83efe800
[<819b89f0>] (__mutex_lock_slowpath) from [<819b8a44>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:286)
[<819b8a08>] (mutex_lock) from [<818bca90>] (rfkill_unregister+0x5c/0xc4 net/rfkill/core.c:1145)
[<818bca34>] (rfkill_unregister) from [<81900e80>] (nfc_unregister_device+0x44/0x118 net/nfc/core.c:1167)
 r5:83efc85c r4:83efc800
[<81900e3c>] (nfc_unregister_device) from [<8190de2c>] (nci_unregister_device+0x94/0x98 net/nfc/nci/core.c:1312)
 r5:83f7b024 r4:83f7b024
[<8190dd98>] (nci_unregister_device) from [<80b011c0>] (virtual_ncidev_close+0x18/0x30 drivers/nfc/virtual_ncidev.c:172)
 r9:00000000 r8:82cad790 r7:83867e58 r6:83022ee0 r5:000e001b r4:843549c0
[<80b011a8>] (virtual_ncidev_close) from [<80518350>] (__fput+0xdc/0x2e4 fs/file_table.c:431)
 r5:000e001b r4:84686cc0
[<80518274>] (__fput) from [<805185e0>] (____fput+0x14/0x18 fs/file_table.c:459)
 r9:00000000 r8:82871694 r7:83702400 r6:83702c84 r5:83702c54 r4:00000000
[<805185cc>] (____fput) from [<8026c6e4>] (task_work_run+0x90/0xb8 kernel/task_work.c:228)
[<8026c654>] (task_work_run) from [<80248f4c>] (exit_task_work include/linux/task_work.h:40 [inline])
[<8026c654>] (task_work_run) from [<80248f4c>] (do_exit+0x304/0xaa0 kernel/exit.c:939)
 r9:00000000 r8:dfc25f50 r7:83702c80 r6:83ee0978 r5:83ee0900 r4:83702400
[<80248c48>] (do_exit) from [<802498ac>] (do_group_exit+0x40/0x8c kernel/exit.c:1088)
 r7:83ecdf80
[<8024986c>] (do_group_exit) from [<80249910>] (__do_sys_exit_group kernel/exit.c:1099 [inline])
[<8024986c>] (do_group_exit) from [<80249910>] (pid_child_should_wake+0x0/0x6c kernel/exit.c:1097)
 r7:000000f8 r4:00000001
[<802498f8>] (sys_exit_group) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdfc25fa8 to 0xdfc25ff0)
5fa0:                   00000001 0008b3ac 00000000 00000000 00000000 00000000
5fc0: 00000001 0008b3ac 00000000 000000f8 0008b8d0 00089158 00089158 0008b8d0
5fe0: 128a5b9d 7e85fc28 00016fa8 0002bdb4
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 32 Comm: khungtaskd Not tainted 6.11.0-syzkaller #0
Hardware name: ARM-Versatile Express
Call trace: 
[<81992360>] (dump_backtrace) from [<8199245c>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:00000013 r5:60000093 r4:82039e28
[<81992444>] (show_stack) from [<819b0758>] (__dump_stack lib/dump_stack.c:94 [inline])
[<81992444>] (show_stack) from [<819b0758>] (dump_stack_lvl+0x70/0x7c lib/dump_stack.c:120)
[<819b06e8>] (dump_stack_lvl) from [<819b077c>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r5:00000001 r4:00000001
[<819b0764>] (dump_stack) from [<8197f620>] (nmi_cpu_backtrace+0x160/0x17c lib/nmi_backtrace.c:113)
[<8197f4c0>] (nmi_cpu_backtrace) from [<8197f76c>] (nmi_trigger_cpumask_backtrace+0x130/0x1d8 lib/nmi_backtrace.c:62)
 r7:00000001 r6:8260c5d0 r5:8261a88c r4:ffffffff
[<8197f63c>] (nmi_trigger_cpumask_backtrace) from [<802103e8>] (arch_trigger_cpumask_backtrace+0x18/0x1c arch/arm/kernel/smp.c:851)
 r9:00019000 r8:828b6cf8 r7:8260c730 r6:00007f60 r5:8261ae48 r4:8351451c
[<802103d0>] (arch_trigger_cpumask_backtrace) from [<803582e0>] (trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline])
[<802103d0>] (arch_trigger_cpumask_backtrace) from [<803582e0>] (check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline])
[<802103d0>] (arch_trigger_cpumask_backtrace) from [<803582e0>] (watchdog+0x498/0x5b8 kernel/hung_task.c:379)
[<80357e48>] (watchdog) from [<8026fd9c>] (kthread+0x104/0x134 kernel/kthread.c:389)
 r10:00000000 r9:df819e58 r8:82f23980 r7:00000000 r6:80357e48 r5:82e59800
 r4:82ec84c0
[<8026fc98>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf8e1fb0 to 0xdf8e1ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8026fc98 r4:82ec84c0
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 2932 Comm: klogd Not tainted 6.11.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at 0x76dbd918
LR is at 0x76db8460
pc : [<76dbd918>]    lr : [<76db8460>]    psr: 60000010
sp : 7eec3bc8  ip : 00000000  fp : 017e4b1b
r10: 76e30e60  r9 : 00000013  r8 : 00000000
r7 : 00000121  r6 : 76f665a0  r5 : 76f665a0  r4 : 017dd1a8
r3 : 00004000  r2 : 0000003e  r1 : 017e4b18  r0 : 0000003e
Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user
Control: 30c5387d  Table: 84347480  DAC: fffffffd
Call trace: invalid frame pointer 0x017e4b1b


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

