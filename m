Return-Path: <linux-wireless+bounces-16431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122A9F3C39
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 22:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9DC1892872
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD411D618E;
	Mon, 16 Dec 2024 20:51:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DD1DEFCD
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382283; cv=none; b=JHIOUNfmodmZhocvLFVDWmJazJtczYRCW7TJgUCB6gBlos2V451oKlGXHH0xFsa1xTJrCXk9M2VvCGphrTEf6L3dtDpU8ER19lmHFyOPH34dcZaEvuBVuEhIu9NeIVXTSjrUUhKBpysO6wqI9WYC8NCpnSenyTJ1nBOhMdTtmTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382283; c=relaxed/simple;
	bh=5hBavAvkUqlEhwW/X+Vsrjs2Q733UU3i1+O7VcdVZAg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nY7EUOtotnNZJKosMD+kn6KmvhfZruxp49Rdk6rZgz1f7Dr9hoaL0D1W+BSxiq1O47Md+L84GkpFbQEb4fnYcYvuicDcrDuynBtezQ+iON1C5yx5RQvTuzvDSaw7nPPpnO6a6/76HKsu7dzTcMDbJETLQPxE7ITvUyNuKDqKd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso93207475ab.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 12:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382280; x=1734987080;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuoktDTmJSIdgn8GjmVl4YmQSHzGiATw0fD+sFyNswk=;
        b=KbELUJXdCrrpMDaxreejaOJAVF1lDaMnOTPzskUbmCmmZtXYIn9ScryoSsNsJP5MR7
         Nudgh1Jx/DoBlehtyYfgP4MJDPZxlCeZ4hV0b+6tSNqEbJcEIdeSfM3UABbel8bnpED1
         AQsTauC1yz+dC2keYQc5F+fgCG0c9vxlAlc+EPdJr+9F6Eh8x8n9KRA5awcf1WaFeSCt
         XsIJaoD7oMyRGPayyWtMYQADToXlSbTUIgnOB82yXF9KgQ3wsbz46heOr21K4EMJwRIc
         ocYIOgeFqtWCTrySW1ntrvwKGjhZ2RTbuWRGg2we+9GFvtYLZvqJiRfHQ3RMYjU/vrrW
         IEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB1/ThPoqmP7eI+RTySeYITFpkq9BH5kJCPSusK9Qh77GQByA1wK/5XfLNHuHT7qwmO5fF0k3ZJVjlj31mqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMzBiqNdr7u4b0+ZNrwHcz8jVUKiq+WubyuHIyJ1QL+5h+bGu
	42MX7SNN6yVpc7SzdSg32zmbAlR2N2ZlCpII32485H3fJRNF5lukhFNaI9VJqtc06jwZf/HDwLH
	MxwYJ0ZtpWO485PAwsga8uSX9eEcKT/R622TYQkAiuZSOrmkF5G73KbM=
X-Google-Smtp-Source: AGHT+IHBgQAvJi2fYClc9MdDYUKCyyXM70mQhWHGs34X4ROy3lrdVtiqTZFI2wLzATYLAgwuM0tPyxU2n7mGlnTyNBdAcZeMHadb
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c565:0:b0:3a7:7d26:4ce4 with SMTP id
 e9e14a558f8ab-3bad2ea5de6mr10848005ab.9.1734382280344; Mon, 16 Dec 2024
 12:51:20 -0800 (PST)
Date: Mon, 16 Dec 2024 12:51:20 -0800
In-Reply-To: <000000000000877f44061f892ace@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676092c8.050a0220.37aaf.013e.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in ath9k_hif_usb_firmware_cb (3)
From: syzbot <syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com>
To: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, nbd@nbd.name, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    78d4f34e2115 Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d10b44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c532525a32eb57d
dashboard link: https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166cb4f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/297b40bb0993/disk-78d4f34e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3ec807b99e0/vmlinux-78d4f34e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/226a54b87ab2/bzImage-78d4f34e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com

INFO: task kworker/0:0:8 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:23832 pid:8     tgid:8     ppid:2      flags:0x00004000
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x7e7/0xee0 kernel/locking/mutex.c:735
 device_lock include/linux/device.h:1014 [inline]
 ath9k_hif_usb_firmware_fail drivers/net/wireless/ath/ath9k/hif_usb.c:1161 [inline]
 ath9k_hif_usb_firmware_cb+0x34a/0x4b0 drivers/net/wireless/ath/ath9k/hif_usb.c:1294
 request_firmware_work_func+0x1a6/0x280 drivers/base/firmware_loader/main.c:1196
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:5:6041 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:23856 pid:6041  tgid:6041  ppid:2      flags:0x00004000
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x7e7/0xee0 kernel/locking/mutex.c:735
 device_lock include/linux/device.h:1014 [inline]
 ath9k_hif_usb_firmware_fail drivers/net/wireless/ath/ath9k/hif_usb.c:1161 [inline]
 ath9k_hif_usb_firmware_cb+0x34a/0x4b0 drivers/net/wireless/ath/ath9k/hif_usb.c:1294
 request_firmware_work_func+0x1a6/0x280 drivers/base/firmware_loader/main.c:1196
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/8:
 #0: ffff88801ac78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc900000d7d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900000d7d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff888144f05190 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144f05190 (&dev->mutex){....}-{4:4}, at: ath9k_hif_usb_firmware_fail drivers/net/wireless/ath/ath9k/hif_usb.c:1161 [inline]
 #2: ffff888144f05190 (&dev->mutex){....}-{4:4}, at: ath9k_hif_usb_firmware_cb+0x34a/0x4b0 drivers/net/wireless/ath/ath9k/hif_usb.c:1294
4 locks held by kworker/1:0/25:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
3 locks held by kworker/u8:2/35:
 #0: ffff88814d7b6948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814d7b6948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90000ab7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000ab7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fcb2848 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4215
3 locks held by kworker/1:1/46:
3 locks held by kworker/u8:3/47:
4 locks held by kworker/u8:7/3543:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000d297d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000d297d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fca6390 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x16a/0xd50 net/core/net_namespace.c:602
 #3: ffff8880304214e8 (&wg->device_update_lock){+.+.}-{4:4}, at: wg_destruct+0x110/0x2e0 drivers/net/wireguard/device.c:249
2 locks held by getty/5582:
 #0: ffff8880317de0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
5 locks held by kworker/1:5/6014:
3 locks held by kworker/1:6/6029:
3 locks held by kworker/0:5/6041:
 #0: ffff88801ac78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90003417d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003417d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88814532e190 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff88814532e190 (&dev->mutex){....}-{4:4}, at: ath9k_hif_usb_firmware_fail drivers/net/wireless/ath/ath9k/hif_usb.c:1161 [inline]
 #2: ffff88814532e190 (&dev->mutex){....}-{4:4}, at: ath9k_hif_usb_firmware_cb+0x34a/0x4b0 drivers/net/wireless/ath/ath9k/hif_usb.c:1294
5 locks held by kworker/0:7/6074:
 #0: ffff88801e285148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801e285148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90003537d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003537d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff888145346190 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888145346190 (&dev->mutex){....}-{4:4}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff88805b53c190 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88805b53c190 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0x103/0x950 drivers/usb/core/hub.c:2295
 #4: ffff8880606b3160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff8880606b3160 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff8880606b3160 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
2 locks held by kworker/1:8/6083:
2 locks held by kworker/1:10/6095:
3 locks held by kworker/1:11/6098:
3 locks held by kworker/u8:12/6337:
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000415fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000415fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fcb2848 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:281
4 locks held by syz-executor/6344:
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x225/0xd30 fs/read_write.c:675
 #1: ffff888027074c88 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff8880275f2e18 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f55e628 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/6350:
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x225/0xd30 fs/read_write.c:675
 #1: ffff88809451fc88 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff8880275f2d28 (kn->active#56){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f55e628 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
1 lock held by syz-executor/6351:
 #0: ffffffff8fcb2848 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcb2848 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:326 [inline]
 #0: ffffffff8fcb2848 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xbcb/0x2150 net/core/rtnetlink.c:4010
4 locks held by syz-executor/6355:
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x225/0xd30 fs/read_write.c:675
 #1: ffff88807bd80088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff8880275f2e18 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f55e628 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/6357:
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x225/0xd30 fs/read_write.c:675
 #1: ffff8880a018b888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff8880275f2e18 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f55e628 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
8 locks held by syz-executor/6371:
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #0: ffff8880240f8420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x225/0xd30 fs/read_write.c:675
 #1: ffff8880926f3888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff8880275f2e18 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f55e628 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff8880755860e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff8880755860e8 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff8880755860e8 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff888075587250 (&devlink->lock_key#2){+.+.}-{4:4}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1675
 #6: ffffffff8fcb2848 (rtnl_mutex){+.+.}-{4:4}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:816
 #7: ffffffff8e93cff8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:297 [inline]
 #7: ffffffff8e93cff8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:976

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6029 Comm: kworker/1:6 Not tainted 6.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:unwind_next_frame+0x37/0x22d0 arch/x86/kernel/unwind_orc.c:470
Code: 53 48 81 ec 98 00 00 00 49 89 fd 49 bc 00 00 00 00 00 fc ff df 48 8d 5f 48 48 89 d8 48 c1 e8 03 48 89 44 24 30 42 80 3c 20 00 <74> 08 48 89 df e8 df 33 ba 00 48 89 5c 24 18 4d 8b 75 48 49 8d 6d
RSP: 0018:ffffc90000a183f0 EFLAGS: 00000046
RAX: 1ffff920001430ad RBX: ffffc90000a18568 RCX: 0000000000000002
RDX: dffffc0000000000 RSI: ffffffff8e19e0e4 RDI: ffffc90000a18520
RBP: 1ffff920001430a5 R08: ffffc90000a18500 R09: ffffc90000a18520
R10: dffffc0000000000 R11: fffff520001430b0 R12: dffffc0000000000
R13: ffffc90000a18520 R14: ffffc90000a18520 R15: ffffc90000a18528
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f35ffff CR3: 000000000e736000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __unwind_start+0x59a/0x740 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe5/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x430 mm/slub.c:4761
 dummy_timer+0x7f4/0x4620 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x59d/0xd30 kernel/time/hrtimer.c:1803
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1820
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:should_resched arch/x86/include/asm/preempt.h:103 [inline]
RIP: 0010:__local_bh_enable_ip+0x170/0x200 kernel/softirq.c:396
Code: 8c e8 94 c3 66 0a 65 66 8b 05 34 11 a2 7e 66 85 c0 75 5d bf 01 00 00 00 e8 5d bd 0b 00 e8 c8 78 45 00 fb 65 8b 05 f8 10 a2 7e <85> c0 75 05 e8 77 82 a8 ff 48 c7 44 24 20 0e 36 e0 45 49 c7 04 1c
RSP: 0018:ffffc90003437a80 EFLAGS: 00000282
RAX: 0000000080000000 RBX: 1ffff92000686f54 RCX: ffffffff817b275a
RDX: dffffc0000000000 RSI: ffffffff8c0a96c0 RDI: ffffffff8c5faaa0
RBP: ffffc90003437b28 R08: ffffffff942a1927 R09: 1ffffffff2854324
R10: dffffc0000000000 R11: fffffbfff2854325 R12: dffffc0000000000
R13: 1ffff92000686f58 R14: ffffc90003437ac0 R15: 0000000000000201
 neigh_periodic_work+0xbcb/0xde0 net/core/neighbour.c:968
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

