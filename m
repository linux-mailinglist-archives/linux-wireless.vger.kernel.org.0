Return-Path: <linux-wireless+bounces-13859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBD998B41
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D871F22994
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64D1CC880;
	Thu, 10 Oct 2024 15:19:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827417A584
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573570; cv=none; b=YoyF/IRTNE83wcA2LkdhYViT+OVmVP7fOp07bLrRP1LThYI+Gt33Ikat1qrZ5cLnOR//DKmrVK1+mNyAkKhkkkFqxVP0gFpo/ZyTPhxJthoJ2/gTUw3HbnrjUkGtGbZfoPCKRP8KNpjOWeLUJm9/jxQWFSrjyAuu/wDuZPqrFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573570; c=relaxed/simple;
	bh=icVtOVPlCKNySRBde5WTDPjnhpZaRDOvLRt2PDOJtDk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XED9i0mEBO7EPcOwELVrqY+lcgavKzsy2Te6+HBYvpYSMLWSRZegFMyxVU2HrxUOYUUJIXuogfn4hItJEzCpTNcZF/VygZYTgWI3keu2xmOt/NfLqy6BiXXxA7TgXdkPOzM0/Qfora+GpRZfEeUWPBxc6BAaUvRZOXsRCGwvK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so2268035ab.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 08:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573568; x=1729178368;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVWE38OAUYSGYOk+wfJEnOlrpjtGBc3n3tcYLekFef8=;
        b=Io4510yc7kZ9YYhMexyLfh42Wl/L2tvD4BQinUcLBuUbxR/WlIbqEna4m4Wp6IrNly
         FdYnfX99uRc16KpVKIUrWsix8yTp0ef2xSS/kx3NSNSsMMLWUyPdg7uI2G/ZJnZfFDoM
         mYA9rM58zFOpsewrgeSBjZt+5JZVc2FZnR44U9DX8ja6bafYU+nAAxxnkn0vmh6amZj4
         EA67wNVByOJ53BvtF251G//3Rc98oT0ByusWNKG/2BN6d/umCkpXU9mzEXRvOpC50DMo
         Bpft/z8QJGZF5/wpUBNCg56i0Qoy9DzfMr4uehfenQw5WVLLhR0MJeEhUu4eaG2kCJym
         Gmvw==
X-Forwarded-Encrypted: i=1; AJvYcCUIH4snXfHpc/gxV3RmtHP4S8/wWTHPsBu+PjqMf0LMYm5gixAT9E3zki/7emu+FUMNT53HHjUb9RzPiNAv1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIjT/udNrHduAUc5PEAsh+4qvB2N7DMG5rhQNwCkHz0q3J2Vr
	ThG94PDzyKkHPTEjLYPT4z525JIr/pxnfGkWwuZqVLVtKeFPCpo7Jv8hjG+fHeKNsVOJF+OQgqY
	iGdmnya2tCuRLTjCJTnFU8AtqYRoiVvBXLa4FNC97Bo5UGIPpVY+EC44=
X-Google-Smtp-Source: AGHT+IH7yplpLl/l9pSgftA+h+ZA4+mWCnCshYozMHlLsHRio/qaJGSI/qjjNAuxBDx2fnccUFqMMwVppMtQrl5VRPSj+hocCYsz
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:3a0:9829:100b with SMTP id
 e9e14a558f8ab-3a397d17959mr53263075ab.21.1728573567926; Thu, 10 Oct 2024
 08:19:27 -0700 (PDT)
Date: Thu, 10 Oct 2024 08:19:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707f07f.050a0220.64b99.001b.GAE@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in cfg80211_event_work (4)
From: syzbot <syzbot+5506b2556159a1ab6923@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a130b7e1fcd Merge tag 'kbuild-fixes-v6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1206e79f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f38c36a955431c1
dashboard link: https://syzkaller.appspot.com/bug?extid=5506b2556159a1ab6923
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155b8327980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2a130b7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea0b899b6053/vmlinux-2a130b7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ef0bad329fe/bzImage-2a130b7e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5506b2556159a1ab6923@syzkaller.appspotmail.com

INFO: task kworker/u4:4:5271 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00381-g2a130b7e1fcd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:4    state:D stack:25712 pid:5271  tgid:5271  ppid:2      flags:0x00004000
Workqueue: cfg80211 cfg80211_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 wiphy_lock include/net/cfg80211.h:6014 [inline]
 cfg80211_event_work+0x27/0x40 net/wireless/core.c:334
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
1 lock held by kswapd0/73:
3 locks held by kworker/0:3/909:
3 locks held by kworker/u4:9/2509:
3 locks held by kworker/u4:11/3318:
1 lock held by dhcpcd/4814:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
2 locks held by getty/4897:
 #0: ffff88801dda90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/u4:0/5118:
 #0: ffff88803c425948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88803c425948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90002d1fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90002d1fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
3 locks held by kworker/0:2/5170:
2 locks held by kworker/u4:2/5176:
3 locks held by kworker/u4:3/5211:
1 lock held by syz-executor/5254:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
1 lock held by syz-executor/5255:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
1 lock held by syz-executor/5258:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
1 lock held by syz-executor/5264:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
3 locks held by kworker/u4:4/5271:
 #0: ffff88801ebdf948 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ebdf948 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90002617d00 ((work_completion)(&rdev->event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90002617d00 ((work_completion)(&rdev->event_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
 #2: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_event_work+0x27/0x40 net/wireless/core.c:334
1 lock held by syz-executor/5273:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
3 locks held by kworker/u4:6/5278:
4 locks held by kworker/0:6/5390:
 #0: ffff88801ac75948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac75948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90002adfd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90002adfd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
 #3: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
 #3: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_leave_invalid_chans net/wireless/reg.c:2468 [inline]
 #3: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_check_chans_work+0x164/0xfd0 net/wireless/reg.c:2483
3 locks held by kworker/0:9/5444:
3 locks held by kworker/0:10/5446:
2 locks held by kworker/0:12/5449:
3 locks held by kworker/0:14/5454:
2 locks held by kworker/0:15/5455:
3 locks held by kworker/0:16/5456:
4 locks held by kworker/u4:10/5469:
 #0: ffff88801be8b148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801be8b148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90002cafd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90002cafd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
2 locks held by kworker/u4:13/5492:
1 lock held by syz-executor/5502:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5515:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5522:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5526:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5534:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5535:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5550:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5553:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5557:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5562:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5569:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5573:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00381-g2a130b7e1fcd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
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

