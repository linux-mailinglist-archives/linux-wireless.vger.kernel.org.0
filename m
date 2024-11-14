Return-Path: <linux-wireless+bounces-15303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22529C8EF6
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C0C1F2474C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB8413B288;
	Thu, 14 Nov 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="PHLKqB9T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD51420A8;
	Thu, 14 Nov 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599897; cv=none; b=Xi8ApPmYnYwZsOYsBaYxPKjUZKJFqDCYvFs8iZ2F4/9Xl4PkpEQ7aadMKOyWtmSKe/tb0wlXPb4AP9j0GGtaryc+Muq6vFEYLoSHQkyAcfkQ6RSEaGHnQoyyBvRzs29k+ERPrEbOrQKGlW1QRZTmNE7qDawpD+JFBVa0MXepToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599897; c=relaxed/simple;
	bh=P+cOsdripRFvYlyp7WYqEoj6JQsmQNtvqopRVLA9AR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jTKrN6uA2bWxoPHoAacC1t1R/m6Jce885eLhVNP22aWxW2ppRs0ZLvdJ7T33Q02UtEgrlU1ZxtSGwxSTFuPsUS6aCAJ6BnF9kUw4mEzfxu7kzunJfHNNbq0P7kS/SQgeMM2zCaSvYLwdHrVdPWccXTpf2z1SfeVY511q2qr0mZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=PHLKqB9T; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CC8CD440089;
	Thu, 14 Nov 2024 15:58:10 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.40.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 206D113C2B0;
	Thu, 14 Nov 2024 07:58:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 206D113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1731599889;
	bh=P+cOsdripRFvYlyp7WYqEoj6JQsmQNtvqopRVLA9AR4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PHLKqB9TrFph29oT1fpIsJICxW6RwWAJP+jxssgmtjLM85+rHMP0vToAGuR6uJgls
	 SEh/YtLgiiQdSQg4JF1fCKzgdWm3VgLuLPjFN9kYVBvFqnCwkXROJRWsKAQTJWlp/P
	 ViJ6rJVvIFpFW8oAdj+pjf0JkCc5NU8Dp3eBAgtU=
Message-ID: <8df6ab0a-02fa-46d0-a19c-96545dcca035@candelatech.com>
Date: Thu, 14 Nov 2024 07:58:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [wireless?] INFO: task hung in nl80211_pre_doit (3)
To: syzbot <syzbot+da14e8c0ada830335981@syzkaller.appspotmail.com>,
 johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6735b24e.050a0220.2a2fcc.0063.GAE@google.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <6735b24e.050a0220.2a2fcc.0063.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1731599892-1MVAkSQ1m9Rj
X-MDID-O:
 us5;at1;1731599892;1MVAkSQ1m9Rj;<greearb@candelatech.com>;3a4554d0eced4777ba762c7a41f48a81
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/14/24 00:18, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    de2f378f2b77 Merge tag 'nfsd-6.12-4' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a245f7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=da14e8c0ada830335981
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e635f980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-de2f378f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9ee61f45ffb8/vmlinux-de2f378f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a3b0e20d8f05/bzImage-de2f378f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+da14e8c0ada830335981@syzkaller.appspotmail.com
> 
> INFO: task syz-executor:5427 blocked for more than 144 seconds.
>        Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:20096 pid:5427  tgid:5427  ppid:1      flags:0x00004006
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:5328 [inline]
>   __schedule+0x184f/0x4c30 kernel/sched/core.c:6690
>   __schedule_loop kernel/sched/core.c:6767 [inline]
>   schedule+0x14b/0x320 kernel/sched/core.c:6782
>   schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
>   __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>   __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
>   nl80211_pre_doit+0x5f/0x8b0 net/wireless/nl80211.c:16580
>   genl_family_rcv_msg_doit net/netlink/genetlink.c:1110 [inline]
>   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>   genl_rcv_msg+0xaaa/0xec0 net/netlink/genetlink.c:1210
>   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
>   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>   netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
>   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>   sock_sendmsg_nosec net/socket.c:729 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:744
>   __sys_sendto+0x39b/0x4f0 net/socket.c:2214
>   __do_sys_sendto net/socket.c:2226 [inline]
>   __se_sys_sendto net/socket.c:2222 [inline]
>   __x64_sys_sendto+0xde/0x100 net/socket.c:2222
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f024ad805ac
> RSP: 002b:00007ffd15eb6070 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f024ba64620 RCX: 00007f024ad805ac
> RDX: 0000000000000040 RSI: 00007f024ba64670 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007ffd15eb60c4 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007f024ba64670 R15: 0000000000000000
>   </TASK>
> INFO: task syz-executor:5435 blocked for more than 148 seconds.
>        Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:20656 pid:5435  tgid:5435  ppid:1      flags:0x00004004
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:5328 [inline]
>   __schedule+0x184f/0x4c30 kernel/sched/core.c:6690
>   __schedule_loop kernel/sched/core.c:6767 [inline]
>   schedule+0x14b/0x320 kernel/sched/core.c:6782
>   schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
>   __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>   __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
>   rtnl_lock net/core/rtnetlink.c:79 [inline]
>   rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
>   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
>   netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
>   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>   sock_sendmsg_nosec net/socket.c:729 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:744
>   __sys_sendto+0x39b/0x4f0 net/socket.c:2214
>   __do_sys_sendto net/socket.c:2226 [inline]
>   __se_sys_sendto net/socket.c:2222 [inline]
>   __x64_sys_sendto+0xde/0x100 net/socket.c:2222
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7facdd1805ac
> RSP: 002b:00007ffc7ba5d850 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007facdde64620 RCX: 00007facdd1805ac
> RDX: 0000000000000040 RSI: 00007facdde64670 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007ffc7ba5d8a4 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007facdde64670 R15: 0000000000000000
>   </TASK>
> 
> Showing all locks held in the system:
> 2 locks held by kworker/0:0/8:
> 3 locks held by kworker/u4:0/11:
> 2 locks held by kworker/u4:1/12:
> 1 lock held by khungtaskd/25:
>   #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>   #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>   #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720

Since those kworkers don't show locks, it must be because they are 'running'.

The syzbot needs to learn to dump all tasks, or kernel lockdep needs to get
smarter about dumping more useful information for running tasks.  I don't see how anyone
can make progress from this report as it is, though I would very much like
to understand this problem.  We see hints of similar bugs, but no luck
reproducing them.

This might show at least some of the needed info with no extra lockdep
patches or significant changes to syzbot:

echo 1 > /proc/sys/kernel/hung_task_all_cpu_backtrace

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


