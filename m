Return-Path: <linux-wireless+bounces-3967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250F86195E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 18:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5611C1C24875
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 17:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3912D217;
	Fri, 23 Feb 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="qZslH6mj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1913A264
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709125; cv=none; b=eTmD9XAfOv5nrAJUL0McsS+A0zzclqYE/McrSAobLLel/e+SZYKgM4l923S2mCcUDXRBpTA40uSl3JeC3k3T/JGyS9C75ImDVlIcM8N2ixJx9IuvcdM5RzGsoniWBJy0iFNijpzXDIG2fSnAjdRc2Dvb7IJDdy7MYRLlARTtwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709125; c=relaxed/simple;
	bh=lu/WueYkuw+u4L4QU73P2mnJJhxQwhSwlxR0BC5zRxw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BtQY6kssEKYVcvjDbpcJU3chC4/VTt7zMN1bK1QKwt8vjtm57C9NePLPMkoBQsvSKTHF6tpZIOjPM8iTpstzCJBgiEkb6f6HnBlPSZH6qhG0pfvvguvmhvplBoDSYV8lioj5j5aDzjH5dUfduURNVYoAsUk8jCjgglH2EdHyqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=qZslH6mj; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 066EF3046A9
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 17:08:11 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B9F34B8008F;
	Fri, 23 Feb 2024 17:08:02 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0268B13C2B0;
	Fri, 23 Feb 2024 09:08:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0268B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1708708082;
	bh=lu/WueYkuw+u4L4QU73P2mnJJhxQwhSwlxR0BC5zRxw=;
	h=Date:To:Cc:From:Subject:From;
	b=qZslH6mjF/07llhH/Prk6ru6zvgsv7E3iqyP3poA5j11CzIKfzph5XRhH5Zowpood
	 K6/uq3n5o8XEU9EtZTe3UZkLj6WKQAHc5m17E0qo0uD1f22wrTp2lzZrp44oRj4xbR
	 ExEHnqlVqA7ia1kH8mOZRnK8jG5PT3H/0n9M/pgk=
Message-ID: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
Date: Fri, 23 Feb 2024 09:08:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: "Berg, Johannes" <johannes.berg@intel.com>
From: Ben Greear <greearb@candelatech.com>
Subject: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1708708083-uatU8V5hFEpO
X-MDID-O:
 us5;at1;1708708083;uatU8V5hFEpO;<greearb@candelatech.com>;232dd55d48f96bb835b07b88a6baba61

Hello Johannes,

If you have time, could you please take a look at this?  I do not have any
quick or reliable way to reproduce this, but since one of the threads is blocked
on a debugfs completion, then I'm suspicious it may be some other bug in the area
you previously (mostly?) fixed.

Maybe because the kworkers are blocked on ipv6 stuff so whatever completion
work we are waiting on will never complete?

gdb) l *(wiphy_locked_debugfs_read+0x114)
0x713e4 is in wiphy_locked_debugfs_read (/home/greearb/git/linux-6.7.dev.y/net/wireless/debugfs.c:182).
177		wiphy_work_init(&work.work, wiphy_locked_debugfs_read_work);
178		wiphy_work_queue(wiphy, &work.work);
179	
180		debugfs_enter_cancellation(file, &cancellation);
181		wait_for_completion(&work.completion);
182		debugfs_leave_cancellation(file, &cancellation);
183	
184		if (work.ret < 0)
185			return work.ret;
186	
(gdb)


[905261.271981] INFO: task systemd-resolve:948 blocked for more than 180 seconds.
[905261.277834]       Tainted: G           O       6.7.3+ #34
[905261.281939] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.288474] task:systemd-resolve state:D stack:0     pid:948   tgid:948   ppid:1      flags:0x00000002
[905261.288477] Call Trace:
[905261.288478]  <TASK>
[905261.288481]  __schedule+0x377/0xa10
[905261.288486]  ? _copy_to_user+0x20/0x30
[905261.288507]  schedule+0x29/0xc0
[905261.288509]  schedule_preempt_disabled+0xc/0x20
[905261.288511]  __mutex_lock.constprop.0+0x34d/0x760
[905261.288514]  do_ip_setsockopt+0x4a/0x1150
[905261.288518]  ? ___sys_recvmsg+0x82/0xc0
[905261.288520]  ip_setsockopt+0x2a/0xb0
[905261.288523]  do_sock_setsockopt+0xa8/0x170
[905261.288527]  __sys_setsockopt+0x85/0xd0
[905261.288529]  __x64_sys_setsockopt+0x16/0x20
[905261.288530]  do_syscall_64+0x3b/0x110
[905261.288533]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[905261.288537] RIP: 0033:0x7f228251389e
[905261.288539] RSP: 002b:00007ffd4466fd38 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
[905261.288541] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f228251389e
[905261.288542] RDX: 0000000000000024 RSI: 0000000000000000 RDI: 000000000000000a
[905261.288543] RBP: 000000000000000a R08: 000000000000000c R09: 8e92374df5b14b7b
[905261.288544] R10: 00007ffd4466fd44 R11: 0000000000000246 R12: 00007ffd4466fd44
[905261.288546] R13: 0000000000000000 R14: 0000561411a0ae00 R15: 0000561411a0ae00
[905261.288548]  </TASK>
[905261.288556] INFO: task ntpd:1435 blocked for more than 180 seconds.
[905261.293524]       Tainted: G           O       6.7.3+ #34
[905261.297632] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.304168] task:ntpd            state:D stack:0     pid:1435  tgid:1435  ppid:1      flags:0x00000006
[905261.304170] Call Trace:
[905261.304171]  <TASK>
[905261.304172]  __schedule+0x377/0xa10
[905261.304174]  schedule+0x29/0xc0
[905261.304175]  schedule_preempt_disabled+0xc/0x20
[905261.304177]  __mutex_lock.constprop.0+0x34d/0x760
[905261.304179]  __netlink_dump_start+0x6c/0x280
[905261.304196]  ? rtnl_fill_ifinfo+0x1510/0x1510
[905261.304198]  rtnetlink_rcv_msg+0x267/0x3b0
[905261.304202]  ? rtnl_fill_ifinfo+0x1510/0x1510
[905261.304203]  ? rtnl_calcit.isra.0+0x120/0x120
[905261.304205]  netlink_rcv_skb+0x4f/0x100
[905261.304207]  netlink_unicast+0x18b/0x280
[905261.304209]  netlink_sendmsg+0x24b/0x4c0
[905261.304211]  __sock_sendmsg+0x33/0x60
[905261.304212]  __sys_sendto+0xec/0x130
[905261.304214]  ? __sys_socket+0xc1/0xf0
[905261.304216]  __x64_sys_sendto+0x1b/0x20
[905261.304217]  do_syscall_64+0x3b/0x110
[905261.304218]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[905261.304221] RIP: 0033:0x7f438bb13834
[905261.304222] RSP: 002b:00007fff186e10f0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[905261.304223] RAX: ffffffffffffffda RBX: 00007fff186e2180 RCX: 00007f438bb13834
[905261.304225] RDX: 0000000000000014 RSI: 00007fff186e21c0 RDI: 0000000000000004
[905261.304225] RBP: 0000000000000000 R08: 00007fff186e2180 R09: 000000000000000c
[905261.304226] R10: 0000000000000000 R11: 0000000000000293 R12: 00007fff186e21c0
[905261.304227] R13: 000055fd78123140 R14: 00007fff186e1130 R15: 00007fff186e2280
[905261.304229]  </TASK>
[905261.304239] INFO: task abrt-applet:2433 blocked for more than 180 seconds.
[905261.309820]       Tainted: G           O       6.7.3+ #34
[905261.313926] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.320462] task:abrt-applet     state:D stack:0     pid:2433  tgid:2433  ppid:2046   flags:0x00000002
[905261.320465] Call Trace:
[905261.320466]  <TASK>
[905261.320467]  __schedule+0x377/0xa10
[905261.320469]  ? poll_freewait+0x40/0xa0
[905261.320472]  schedule+0x29/0xc0
[905261.320487]  schedule_preempt_disabled+0xc/0x20
[905261.320489]  __mutex_lock.constprop.0+0x34d/0x760
[905261.320492]  __netlink_dump_start+0x6c/0x280
[905261.320494]  ? rtnl_mdb_dump+0x160/0x160
[905261.320497]  rtnetlink_rcv_msg+0x267/0x3b0
[905261.320499]  ? rtnl_mdb_dump+0x160/0x160
[905261.320501]  ? rtnl_calcit.isra.0+0x120/0x120
[905261.320504]  netlink_rcv_skb+0x4f/0x100
[905261.320506]  netlink_unicast+0x18b/0x280
[905261.320507]  netlink_sendmsg+0x24b/0x4c0
[905261.320509]  __sock_sendmsg+0x33/0x60
[905261.320510]  ? sockfd_lookup_light+0xd/0x60
[905261.320513]  __sys_sendto+0xec/0x130
[905261.320515]  ? eventfd_read+0xc9/0x200
[905261.320517]  ? eventfd_write+0xc0/0x1d0
[905261.320519]  ? ktime_get_ts64+0x44/0xe0
[905261.320523]  ? switch_fpu_return+0x47/0xc0
[905261.320526]  __x64_sys_sendto+0x1b/0x20
[905261.320527]  do_syscall_64+0x3b/0x110
[905261.320529]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[905261.320532] RIP: 0033:0x7f01c15136cc
[905261.320533] RSP: 002b:00007fff04b4a210 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[905261.320535] RAX: ffffffffffffffda RBX: 000055b502c7f3d0 RCX: 00007f01c15136cc
[905261.320536] RDX: 0000000000000014 RSI: 00007fff04b4a290 RDI: 0000000000000003
[905261.320537] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[905261.320538] R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000014
[905261.320539] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[905261.320540]  </TASK>
[905261.320542] INFO: task xdg-desktop-por:2485 blocked for more than 180 seconds.
[905261.326467]       Tainted: G           O       6.7.3+ #34
[905261.330577] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.337114] task:xdg-desktop-por state:D stack:0     pid:2485  tgid:2485  ppid:1742   flags:0x00000002
[905261.337116] Call Trace:
[905261.337117]  <TASK>
[905261.337118]  __schedule+0x377/0xa10
[905261.337120]  ? poll_freewait+0x40/0xa0
[905261.337122]  schedule+0x29/0xc0
[905261.337138]  schedule_preempt_disabled+0xc/0x20
[905261.337139]  __mutex_lock.constprop.0+0x34d/0x760
[905261.337142]  __netlink_dump_start+0x6c/0x280
[905261.337143]  ? rtnl_mdb_dump+0x160/0x160
[905261.337146]  rtnetlink_rcv_msg+0x267/0x3b0
[905261.337148]  ? rtnl_mdb_dump+0x160/0x160
[905261.337150]  ? rtnl_calcit.isra.0+0x120/0x120
[905261.337153]  netlink_rcv_skb+0x4f/0x100
[905261.337155]  netlink_unicast+0x18b/0x280
[905261.337156]  netlink_sendmsg+0x24b/0x4c0
[905261.337158]  __sock_sendmsg+0x33/0x60
[905261.337159]  ? sockfd_lookup_light+0xd/0x60
[905261.337162]  __sys_sendto+0xec/0x130
[905261.337163]  ? eventfd_read+0xc9/0x200
[905261.337165]  ? eventfd_write+0xc0/0x1d0
[905261.337167]  ? ktime_get_ts64+0x44/0xe0
[905261.337170]  ? switch_fpu_return+0x47/0xc0
[905261.337172]  __x64_sys_sendto+0x1b/0x20
[905261.337173]  do_syscall_64+0x3b/0x110
[905261.337174]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[905261.337178] RIP: 0033:0x7f21443136cc
[905261.337179] RSP: 002b:00007ffc9a315160 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[905261.337180] RAX: ffffffffffffffda RBX: 0000561a0dfc43d0 RCX: 00007f21443136cc
[905261.337181] RDX: 0000000000000014 RSI: 00007ffc9a3151e0 RDI: 0000000000000008
[905261.337182] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[905261.337183] R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000014
[905261.337184] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[905261.337185]  </TASK>
[905261.337190] INFO: task gnuserver:3266 blocked for more than 180 seconds.
[905261.342597]       Tainted: G           O       6.7.3+ #34
[905261.346705] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.353238] task:gnuserver       state:D stack:0     pid:3266  tgid:3266  ppid:3218   flags:0x00000002
[905261.353240] Call Trace:
[905261.353241]  <TASK>
[905261.353241]  __schedule+0x377/0xa10
[905261.353243]  schedule+0x29/0xc0
[905261.353245]  schedule_preempt_disabled+0xc/0x20
[905261.353247]  __mutex_lock.constprop.0+0x34d/0x760
[905261.353249]  dev_ethtool+0x9e/0x29a0
[905261.353267]  ? atime_needs_update+0x93/0x110
[905261.353270]  ? touch_atime+0x15/0x110
[905261.353273]  ? filemap_read+0x2e2/0x300
[905261.353277]  dev_ioctl+0x256/0x480
[905261.353280]  sock_do_ioctl+0x8e/0xd0
[905261.353281]  sock_ioctl+0x157/0x2a0
[905261.353283]  __x64_sys_ioctl+0x87/0xc0
[905261.353285]  do_syscall_64+0x3b/0x110
[905261.353287]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[905261.353289] RIP: 0033:0x7f40e5b0774f
[905261.353290] RSP: 002b:00007fffca032a30 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[905261.353291] RAX: ffffffffffffffda RBX: 00007fffca032b10 RCX: 00007f40e5b0774f
[905261.353292] RDX: 00007fffca033190 RSI: 0000000000008946 RDI: 0000000000000008
[905261.353293] RBP: 00007fffca033190 R08: 000000000000000a R09: 00224f4e223d4c54
[905261.353294] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
[905261.353295] R13: 0000000000000008 R14: 00007fffca033240 R15: 0000000000000000
[905261.353297]  </TASK>
[905261.353300] INFO: task btserver:3593 blocked for more than 180 seconds.
[905261.358620]       Tainted: G           O       6.7.3+ #34
[905261.362729] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.369263] task:btserver        state:D stack:0     pid:3593  tgid:3593  ppid:2866   flags:0x00000002
[905261.369265] Call Trace:
[905261.369266]  <TASK>
[905261.369267]  __schedule+0x377/0xa10
[905261.369268]  ? sched_clock+0xc/0x20
[905261.369270]  schedule+0x29/0xc0
[905261.369271]  schedule_timeout+0x136/0x150
[905261.369274]  wait_for_completion+0x7d/0x130
[905261.369292]  wiphy_locked_debugfs_read+0x114/0x180 [cfg80211]
[905261.369363]  ? wiphy_locked_debugfs_write_work+0x30/0x30 [cfg80211]
[905261.369400]  ? rts_threshold_read+0x80/0x80 [cfg80211]
[905261.369438]  ? ieee80211_link_sta_debugfs_drv_remove+0x40/0x40 [mac80211]
[905261.369516]  ieee80211_if_read_sdata+0x55/0x80 [mac80211]
[905261.369553]  ? ieee80211_link_sta_debugfs_drv_remove+0x40/0x40 [mac80211]
[905261.369587]  ? ieee80211_if_fmt_dot11MeshMaxRetries+0x20/0x20 [mac80211]
[905261.369621]  full_proxy_read+0x4e/0x70
[905261.369625]  vfs_read+0xa3/0x2c0
[905261.369628]  ksys_read+0x5e/0xe0
[905261.369630]  do_syscall_64+0x3b/0x110
[905261.369631]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[905261.369633] RIP: 0033:0x7f27db101b92
[905261.369634] RSP: 002b:00007ffffe00d918 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[905261.369636] RAX: ffffffffffffffda RBX: 00007ffffe00da20 RCX: 00007f27db101b92
[905261.369637] RDX: 0000000000001fff RSI: 0000000009dae8f0 RDI: 0000000000000012
[905261.369638] RBP: 0000000000001fff R08: 0000000000002000 R09: 0000000000000000
[905261.369639] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000009dae8f0
[905261.369640] R13: 00007ffffe00da88 R14: 0000000003971712 R15: 0000000000000001
[905261.369641]  </TASK>
[905261.369667] INFO: task kworker/6:1:2567676 blocked for more than 180 seconds.
[905261.375519]       Tainted: G           O       6.7.3+ #34
[905261.379656] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.386240] task:kworker/6:1     state:D stack:0     pid:2567676 tgid:2567676 ppid:2      flags:0x00004000
[905261.386243] Workqueue: ipv6_addrconf addrconf_dad_work
[905261.386247] Call Trace:
[905261.386248]  <TASK>
[905261.386249]  __schedule+0x377/0xa10
[905261.386251]  ? ttwu_do_activate+0x58/0x1d0
[905261.386255]  schedule+0x29/0xc0
[905261.386269]  schedule_preempt_disabled+0xc/0x20
[905261.386270]  __mutex_lock.constprop.0+0x34d/0x760
[905261.386273]  addrconf_dad_work+0x39/0x590
[905261.386275]  ? __schedule+0x37f/0xa10
[905261.386276]  process_one_work+0x15d/0x330
[905261.386291]  worker_thread+0x2e8/0x400
[905261.386293]  ? rescuer_thread+0x400/0x400
[905261.386294]  kthread+0xdc/0x110
[905261.386298]  ? kthread_complete_and_exit+0x20/0x20
[905261.386300]  ret_from_fork+0x28/0x40
[905261.386302]  ? kthread_complete_and_exit+0x20/0x20
[905261.386310]  ret_from_fork_asm+0x11/0x20
[905261.386315]  </TASK>
[905261.386317] INFO: task kworker/7:1:2579027 blocked for more than 180 seconds.
[905261.392164]       Tainted: G           O       6.7.3+ #34
[905261.396313] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.402878] task:kworker/7:1     state:D stack:0     pid:2579027 tgid:2579027 ppid:2      flags:0x00004000
[905261.402881] Workqueue: ipv6_addrconf addrconf_dad_work
[905261.402884] Call Trace:
[905261.402884]  <TASK>
[905261.402885]  __schedule+0x377/0xa10
[905261.402887]  schedule+0x29/0xc0
[905261.402889]  schedule_preempt_disabled+0xc/0x20
[905261.402891]  __mutex_lock.constprop.0+0x34d/0x760
[905261.402893]  addrconf_dad_work+0x39/0x590
[905261.402895]  ? __schedule+0x37f/0xa10
[905261.402896]  process_one_work+0x15d/0x330
[905261.402898]  worker_thread+0x2e8/0x400
[905261.402906]  ? rescuer_thread+0x400/0x400
[905261.402908]  kthread+0xdc/0x110
[905261.402911]  ? kthread_complete_and_exit+0x20/0x20
[905261.402913]  ret_from_fork+0x28/0x40
[905261.402915]  ? kthread_complete_and_exit+0x20/0x20
[905261.402917]  ret_from_fork_asm+0x11/0x20
[905261.402920]  </TASK>
[905261.402921] INFO: task kworker/u16:17:2582370 blocked for more than 180 seconds.
[905261.409024]       Tainted: G           O       6.7.3+ #34
[905261.413157] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.419735] task:kworker/u16:17  state:D stack:0     pid:2582370 tgid:2582370 ppid:2      flags:0x00004000
[905261.419738] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
[905261.419788] Call Trace:
[905261.419788]  <TASK>
[905261.419789]  __schedule+0x377/0xa10
[905261.419792]  schedule+0x29/0xc0
[905261.419793]  schedule_preempt_disabled+0xc/0x20
[905261.419795]  __mutex_lock.constprop.0+0x34d/0x760
[905261.419797]  cfg80211_wiphy_work+0x15/0xb0 [cfg80211]
[905261.419827]  process_one_work+0x15d/0x330
[905261.419829]  worker_thread+0x2e8/0x400
[905261.419831]  ? rescuer_thread+0x400/0x400
[905261.419832]  kthread+0xdc/0x110
[905261.419834]  ? kthread_complete_and_exit+0x20/0x20
[905261.419854]  ret_from_fork+0x28/0x40
[905261.419856]  ? kthread_complete_and_exit+0x20/0x20
[905261.419859]  ret_from_fork_asm+0x11/0x20
[905261.419862]  </TASK>
[905261.419864] INFO: task kworker/0:1:2591382 blocked for more than 180 seconds.
[905261.425716]       Tainted: G           O       6.7.3+ #34
[905261.429854] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[905261.436399] task:kworker/0:1     state:D stack:0     pid:2591382 tgid:2591382 ppid:2      flags:0x00004000
[905261.436403] Workqueue: ipv6_addrconf addrconf_dad_work
[905261.436406] Call Trace:
[905261.436421]  <TASK>
[905261.436422]  __schedule+0x377/0xa10
[905261.436424]  schedule+0x29/0xc0
[905261.436425]  schedule_preempt_disabled+0xc/0x20
[905261.436427]  __mutex_lock.constprop.0+0x34d/0x760
[905261.436429]  addrconf_dad_work+0x39/0x590
[905261.436431]  ? __schedule+0x37f/0xa10
[905261.436433]  process_one_work+0x15d/0x330
[905261.436435]  worker_thread+0x2e8/0x400
[905261.436436]  ? rescuer_thread+0x400/0x400
[905261.436437]  kthread+0xdc/0x110
[905261.436440]  ? kthread_complete_and_exit+0x20/0x20
[905261.436442]  ret_from_fork+0x28/0x40
[905261.436443]  ? kthread_complete_and_exit+0x20/0x20
[905261.436446]  ret_from_fork_asm+0x11/0x20
[905261.436448]  </TASK>
[905261.436449] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


