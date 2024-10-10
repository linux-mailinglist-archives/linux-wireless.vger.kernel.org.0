Return-Path: <linux-wireless+bounces-13862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DA998DCA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6350B23F66
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093D74E09;
	Thu, 10 Oct 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Ms7Boc61"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05126AFC;
	Thu, 10 Oct 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578691; cv=none; b=co1IOpQLSoqy4ZsN7oa1PnG5oTExvfHlz/0TpJkZK9HqHgC3U9Wq7UQJuEkEoFb/hHL37y26T8RTkaSVAbSPRDD6VSx0LIvKMRxoMRQzPtmG0gcm1vFNQ7Q7qO3TIULkOUYieXYPsjtSvPGhuxJZoVwAfMttvXKO5ZbkNX/QV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578691; c=relaxed/simple;
	bh=3F8t5QLzmaWk/KQkP3a+lrUCDUuBtvcOCUDeU3Hj3Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QIYV8gAPJpAdsLeGeLH6h3BV9IvxiDXhGOGTDF4eFHhPAPNvZxEfg3YiEvtubCCbLovdCDorfVjSoi+UsUS12wM/O8zwijxVjgCcQP4iK05oI1aE4sD9vyJiKkfjdDp/AFAYodvJ8WA9Iusks4gu2OYZSZxK9JAYgN3M4dQgiro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Ms7Boc61; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 316E91C00BD;
	Thu, 10 Oct 2024 16:44:46 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7731C13C2B0;
	Thu, 10 Oct 2024 09:44:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7731C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728578685;
	bh=3F8t5QLzmaWk/KQkP3a+lrUCDUuBtvcOCUDeU3Hj3Os=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ms7Boc61Vrcjf1eHik20fqs83WnIBkn0VQxEnHcEaLNPqrt+98nred98TV+wip46p
	 YL/FL8GoWNAmLUAhd4KAX+O8Ule8gq5MF9ytCAJgVR1lIzKBDU7mxW1jDeLna8YjZe
	 fgFMwCfWw5RGf+e4OoRqVo0OvQZHQJguIEluhcmM=
Message-ID: <05d3d02d-69c7-24a4-c2b2-26bdb53556db@candelatech.com>
Date: Thu, 10 Oct 2024 09:44:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [syzbot] [wireless?] INFO: task hung in cfg80211_event_work (4)
Content-Language: en-US
To: syzbot <syzbot+5506b2556159a1ab6923@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <6707f07f.050a0220.64b99.001b.GAE@google.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <6707f07f.050a0220.64b99.001b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1728578687-NdUd_waGqutT
X-MDID-O:
 us5;ut7;1728578687;NdUd_waGqutT;<greearb@candelatech.com>;b2ba5a57174c2712e3a528a5073252d4
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/10/24 08:19, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2a130b7e1fcd Merge tag 'kbuild-fixes-v6.12' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1206e79f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f38c36a955431c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=5506b2556159a1ab6923
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155b8327980000

This looks like something I saw in 6.11 and 6.10.  My guess was that one of the
running processes that lockdep does not print locks for is holding the wiphy mtx.

Maybe it would help if syzbot would use sysrq to dump all running tasks to the console, and maybe
lockdep could print locks for running processes, even if they are marked as potentially
unreliable?

Thanks,
Ben

> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2a130b7e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ea0b899b6053/vmlinux-2a130b7e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4ef0bad329fe/bzImage-2a130b7e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5506b2556159a1ab6923@syzkaller.appspotmail.com
> 
> INFO: task kworker/u4:4:5271 blocked for more than 143 seconds.
>        Not tainted 6.12.0-rc1-syzkaller-00381-g2a130b7e1fcd #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u4:4    state:D stack:25712 pid:5271  tgid:5271  ppid:2      flags:0x00004000
> Workqueue: cfg80211 cfg80211_event_work
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:5315 [inline]
>   __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
>   __schedule_loop kernel/sched/core.c:6752 [inline]
>   schedule+0x14b/0x320 kernel/sched/core.c:6767
>   schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
>   __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>   __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
>   wiphy_lock include/net/cfg80211.h:6014 [inline]
>   cfg80211_event_work+0x27/0x40 net/wireless/core.c:334
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/25:
>   #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>   #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>   #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
> 1 lock held by kswapd0/73:
> 3 locks held by kworker/0:3/909:
> 3 locks held by kworker/u4:9/2509:
> 3 locks held by kworker/u4:11/3318:
> 1 lock held by dhcpcd/4814:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 2 locks held by getty/4897:
>   #0: ffff88801dda90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>   #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
> 3 locks held by kworker/u4:0/5118:
>   #0: ffff88803c425948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
>   #0: ffff88803c425948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>   #1: ffffc90002d1fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>   #1: ffffc90002d1fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>   #2: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
> 3 locks held by kworker/0:2/5170:
> 2 locks held by kworker/u4:2/5176:
> 3 locks held by kworker/u4:3/5211:
> 1 lock held by syz-executor/5254:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
> 1 lock held by syz-executor/5255:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
> 1 lock held by syz-executor/5258:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
> 1 lock held by syz-executor/5264:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
> 3 locks held by kworker/u4:4/5271:
>   #0: ffff88801ebdf948 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
>   #0: ffff88801ebdf948 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>   #1: ffffc90002617d00 ((work_completion)(&rdev->event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>   #1: ffffc90002617d00 ((work_completion)(&rdev->event_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>   #2: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
>   #2: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_event_work+0x27/0x40 net/wireless/core.c:334
> 1 lock held by syz-executor/5273:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
> 3 locks held by kworker/u4:6/5278:
> 4 locks held by kworker/0:6/5390:
>   #0: ffff88801ac75948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
>   #0: ffff88801ac75948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>   #1: ffffc90002adfd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>   #1: ffffc90002adfd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>   #2: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
>   #3: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
>   #3: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_leave_invalid_chans net/wireless/reg.c:2468 [inline]
>   #3: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_check_chans_work+0x164/0xfd0 net/wireless/reg.c:2483
> 3 locks held by kworker/0:9/5444:
> 3 locks held by kworker/0:10/5446:
> 2 locks held by kworker/0:12/5449:
> 3 locks held by kworker/0:14/5454:
> 2 locks held by kworker/0:15/5455:
> 3 locks held by kworker/0:16/5456:
> 4 locks held by kworker/u4:10/5469:
>   #0: ffff88801be8b148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
>   #0: ffff88801be8b148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>   #1: ffffc90002cafd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>   #1: ffffc90002cafd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>   #2: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
>   #3: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
> 2 locks held by kworker/u4:13/5492:
> 1 lock held by syz-executor/5502:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5515:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5522:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5526:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5534:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5535:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5550:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5553:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5557:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5562:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5569:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 1 lock held by syz-executor/5573:
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
> 
> =============================================


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



