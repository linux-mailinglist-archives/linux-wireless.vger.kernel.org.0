Return-Path: <linux-wireless+bounces-4010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BA58679B0
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 16:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366551C2B0B7
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD905A7BF;
	Mon, 26 Feb 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="SBS7PK2f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DFB53E28
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959536; cv=none; b=i2knBHYYUD70GcVWu1spq/wPukp6cwnALw41iEndYCIKHcIyPW5+I2eJWxPqam6h43f1by0/ttCup75WFDSO3OyfQxE7rD02cXaJqCo8FzuG9qWArKyKYt0KH9LPBEapNQ46pvyhjtM8SNh9OkmI7APrqKh0Sr/MkkAwWfcdtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959536; c=relaxed/simple;
	bh=7fUSg0zLbjuPwA/7Ei7JaEvKXN2ivmknv1Kt+lIVpWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q4rhR+yEt15kntKuXJ5AChFOSlrRoqhU2pYaHbFg4z0hjBX2brbf2j8iQCDTZm97+SI/S5FR7E2WZbqD3oLwO3t2mPn9mEx6oRgCb4l/J2Y8DUJgI7aB9t1flAVEDY/1U00Nm4a87V1aqGlJrJL1fma5tiLidID9sRPOPFIfBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=SBS7PK2f; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 32A8594008D;
	Mon, 26 Feb 2024 14:58:38 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.112.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4836213C2B0;
	Mon, 26 Feb 2024 06:58:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4836213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1708959517;
	bh=7fUSg0zLbjuPwA/7Ei7JaEvKXN2ivmknv1Kt+lIVpWE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SBS7PK2f+YL6h0kP1f7RHUIwtaCFNrQWIH21WIaCrtWfWwMi6aGQFZYJ6gwXMmPjV
	 fsozzGYBDMF2HII9gq/WT79KH1qgDWKcZyEi3I+Zbr3iEMVATViXbKLt6jZ6k1blmf
	 9bBIg0axkCRg+ZmUUtJi47SNZvK5kCd7DAp/sSN8=
Message-ID: <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
Date: Mon, 26 Feb 2024 06:58:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
Content-Language: en-MW
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
 <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1708959519-C_uW8PR885ig
X-MDID-O:
 us5;at1;1708959519;C_uW8PR885ig;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 2/26/24 00:42, Johannes Berg wrote:
> On Fri, 2024-02-23 at 09:08 -0800, Ben Greear wrote:
> 
>> [905261.271981] INFO: task systemd-resolve:948 blocked for more than 180 seconds.
>> [905261.277834]       Tainted: G           O       6.7.3+ #34
>> [905261.281939] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [905261.288474] task:systemd-resolve state:D stack:0     pid:948   tgid:948   ppid:1      flags:0x00000002
> 
> I don't know what that's doing, but
> 
>> [905261.288477] Call Trace:
>> [905261.288478]  <TASK>
>> [905261.288481]  __schedule+0x377/0xa10
>> [905261.288486]  ? _copy_to_user+0x20/0x30
>> [905261.288507]  schedule+0x29/0xc0
>> [905261.288509]  schedule_preempt_disabled+0xc/0x20
>> [905261.288511]  __mutex_lock.constprop.0+0x34d/0x760
>> [905261.288514]  do_ip_setsockopt+0x4a/0x1150
> 
> I'm going to assume that this is RTNL, the socket lock isn't technically
> a mutex, and doesn't seem reasonable in this context.
> 
>> [905261.337114] task:xdg-desktop-por state:D stack:0     pid:2485  tgid:2485  ppid:1742   flags:0x00000002
>> [905261.337116] Call Trace:
>> [905261.337117]  <TASK>
>> [905261.337118]  __schedule+0x377/0xa10
>> [905261.337120]  ? poll_freewait+0x40/0xa0
>> [905261.337122]  schedule+0x29/0xc0
>> [905261.337138]  schedule_preempt_disabled+0xc/0x20
>> [905261.337139]  __mutex_lock.constprop.0+0x34d/0x760
>> [905261.337142]  __netlink_dump_start+0x6c/0x280
>> [905261.337143]  ? rtnl_mdb_dump+0x160/0x160
>> [905261.337146]  rtnetlink_rcv_msg+0x267/0x3b0
> 
> A lot of other things are waiting for the RTNL too.
> 
>> [905261.353300] INFO: task btserver:3593 blocked for more than 180 seconds.
>> [905261.358620]       Tainted: G           O       6.7.3+ #34
>> [905261.362729] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [905261.369263] task:btserver        state:D stack:0     pid:3593  tgid:3593  ppid:2866   flags:0x00000002
>> [905261.369265] Call Trace:
>> [905261.369266]  <TASK>
>> [905261.369267]  __schedule+0x377/0xa10
>> [905261.369268]  ? sched_clock+0xc/0x20
>> [905261.369270]  schedule+0x29/0xc0
>> [905261.369271]  schedule_timeout+0x136/0x150
>> [905261.369274]  wait_for_completion+0x7d/0x130
>> [905261.369292]  wiphy_locked_debugfs_read+0x114/0x180 [cfg80211]
>> [905261.369363]  ? wiphy_locked_debugfs_write_work+0x30/0x30 [cfg80211]
>> [905261.369400]  ? rts_threshold_read+0x80/0x80 [cfg80211]
>> [905261.369438]  ? ieee80211_link_sta_debugfs_drv_remove+0x40/0x40 [mac80211]
>> [905261.369516]  ieee80211_if_read_sdata+0x55/0x80 [mac80211]
> 
> This you saw - it's waiting for the completion of the read of the ...
> not sure which file? Any chance you could find out which fd this process
> has open when it happens?
> 
>> [905261.369553]  ? ieee80211_link_sta_debugfs_drv_remove+0x40/0x40 [mac80211]
>> [905261.369587]  ? ieee80211_if_fmt_dot11MeshMaxRetries+0x20/0x20 [mac80211]
> 
> I don't think we can trust any of the lines marked "?", they're probably
> old prior stack contents ... these don't show up in the call stack of
> ieee80211_if_read_sdata() directly, after all.
> 
>> [905261.402921] INFO: task kworker/u16:17:2582370 blocked for more than 180 seconds.
>> [905261.409024]       Tainted: G           O       6.7.3+ #34
>> [905261.413157] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [905261.419735] task:kworker/u16:17  state:D stack:0     pid:2582370 tgid:2582370 ppid:2      flags:0x00004000
>> [905261.419738] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
>> [905261.419788] Call Trace:
>> [905261.419788]  <TASK>
>> [905261.419789]  __schedule+0x377/0xa10
>> [905261.419792]  schedule+0x29/0xc0
>> [905261.419793]  schedule_preempt_disabled+0xc/0x20
>> [905261.419795]  __mutex_lock.constprop.0+0x34d/0x760
>> [905261.419797]  cfg80211_wiphy_work+0x15/0xb0 [cfg80211]
>> [905261.419827]  process_one_work+0x15d/0x330
> 
> This is a bit interesting - why is the wiphy work stuck trying to
> acquire the wiphy mutex? But nothing related to the RTNL.
> 
> This does explain why the debugfs is stuck though. So maybe doesn't
> matter knowing which file got stuck ...
> 
>> [905261.436449] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> 
> I think we're missing the process that's actually stuck though, maybe
> here or later?
> 
> Seems like there must be a process somewhere that holds RTNL and wiphy
> mutex, but didn't get listed here. Maybe it's live-locked? Maybe it's
> actually a netdev removal (which would hold both those locks), but then
> why is it stuck and not shown?

I managed to catch it in a lockdep enabled kernel.  There were no lockdep
warnings, but more lock info was printed at least:

Maybe ordering of this one's lock printout means it is 'ip' that is actually holding the rtnl?

[Seen in context further below]
Feb 26 06:01:45 ct523c-0b0b kernel: 3 locks held by ip/28125:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x13e/0x620
Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffff888122e60768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_stop+0x2d/0x180 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  #2: ffff88812661d768 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: simple_recursive_removal+0x189/0x2b0



Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task kworker/6:3:542 blocked for more than 180 seconds.
Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:01:45 ct523c-0b0b kernel: task:kworker/6:3     state:D stack:0     pid:542   tgid:542   ppid:2      flags:0x00004000
Feb 26 06:01:45 ct523c-0b0b kernel: Workqueue: ipv6_addrconf addrconf_verify_work
Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_acquire+0xc6/0x2b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? addrconf_verify_work+0x9/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? addrconf_verify_work+0x9/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  addrconf_verify_work+0x9/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  process_one_work+0x1f6/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  worker_thread+0x1cc/0x3b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? wq_sysfs_prep_attrs+0x90/0x90
Feb 26 06:01:45 ct523c-0b0b kernel:  kthread+0xec/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  ? kthread_complete_and_exit+0x20/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ret_from_fork+0x28/0x40
Feb 26 06:01:45 ct523c-0b0b kernel:  ? kthread_complete_and_exit+0x20/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ret_from_fork_asm+0x11/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task ntpd:1448 blocked for more than 180 seconds.
Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:01:45 ct523c-0b0b kernel: task:ntpd            state:D stack:0     pid:1448  tgid:1448  ppid:1      flags:0x00000006
Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
Feb 26 06:01:45 ct523c-0b0b kernel:  ? netlink_lookup+0x13b/0x2f0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __netlink_dump_start+0x7d/0x290
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __netlink_dump_start+0x7d/0x290
Feb 26 06:01:45 ct523c-0b0b kernel:  __netlink_dump_start+0x7d/0x290
Feb 26 06:01:45 ct523c-0b0b kernel:  ? rtnl_fill_ifinfo+0x1960/0x1960
Feb 26 06:01:45 ct523c-0b0b kernel:  rtnetlink_rcv_msg+0x4d1/0x620
Feb 26 06:01:45 ct523c-0b0b kernel:  ? rtnl_fill_ifinfo+0x1960/0x1960
Feb 26 06:01:45 ct523c-0b0b kernel:  ? rtnl_getlink+0x3e0/0x3e0
Feb 26 06:01:45 ct523c-0b0b kernel:  netlink_rcv_skb+0x4f/0x100
Feb 26 06:01:45 ct523c-0b0b kernel:  netlink_unicast+0x18e/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  netlink_sendmsg+0x257/0x4d0
Feb 26 06:01:45 ct523c-0b0b kernel:  __sock_sendmsg+0x33/0x60
Feb 26 06:01:45 ct523c-0b0b kernel:  __sys_sendto+0xef/0x130
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_release+0xc5/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  ? fd_install+0xb8/0x2e0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __sys_socket+0xc1/0xf0
Feb 26 06:01:45 ct523c-0b0b kernel:  __x64_sys_sendto+0x1b/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  do_syscall_64+0x3b/0x110
Feb 26 06:01:45 ct523c-0b0b kernel:  entry_SYSCALL_64_after_hwframe+0x46/0x4e
Feb 26 06:01:45 ct523c-0b0b kernel: RIP: 0033:0x7f14ccd13834
Feb 26 06:01:45 ct523c-0b0b kernel: RSP: 002b:00007ffdaa403950 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
Feb 26 06:01:45 ct523c-0b0b kernel: RAX: ffffffffffffffda RBX: 00007ffdaa4049e0 RCX: 00007f14ccd13834
Feb 26 06:01:45 ct523c-0b0b kernel: RDX: 0000000000000014 RSI: 00007ffdaa404a20 RDI: 0000000000000004
Feb 26 06:01:45 ct523c-0b0b kernel: RBP: 0000000000000000 R08: 00007ffdaa4049e0 R09: 000000000000000c
Feb 26 06:01:45 ct523c-0b0b kernel: R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffdaa404a20
Feb 26 06:01:45 ct523c-0b0b kernel: R13: 000055a0c5771010 R14: 00007ffdaa403990 R15: 00007ffdaa404ae0
Feb 26 06:01:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task gnuserver:3271 blocked for more than 180 seconds.
Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:01:45 ct523c-0b0b kernel: task:gnuserver       state:D stack:0     pid:3271  tgid:3271  ppid:3212   flags:0x00000002
Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
Feb 26 06:01:45 ct523c-0b0b kernel:  ? dev_ethtool+0x9e/0x29b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? dev_ethtool+0x9e/0x29b0
Feb 26 06:01:45 ct523c-0b0b kernel:  dev_ethtool+0x9e/0x29b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_acquire+0xc6/0x2b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? dev_load+0x1c/0x140
Feb 26 06:01:45 ct523c-0b0b kernel:  ? find_held_lock+0x2b/0x80
Feb 26 06:01:45 ct523c-0b0b kernel:  ? dev_load+0x64/0x140
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_release+0xc5/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  dev_ioctl+0x29d/0x510
Feb 26 06:01:45 ct523c-0b0b kernel:  sock_do_ioctl+0x8e/0xd0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? find_held_lock+0x2b/0x80
Feb 26 06:01:45 ct523c-0b0b kernel:  sock_ioctl+0x168/0x2e0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_release+0xc5/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  __x64_sys_ioctl+0x87/0xc0
Feb 26 06:01:45 ct523c-0b0b kernel:  do_syscall_64+0x3b/0x110
Feb 26 06:01:45 ct523c-0b0b kernel:  entry_SYSCALL_64_after_hwframe+0x46/0x4e
Feb 26 06:01:45 ct523c-0b0b kernel: RIP: 0033:0x7f3739b0774f
Feb 26 06:01:45 ct523c-0b0b kernel: RSP: 002b:00007ffc571e7140 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Feb 26 06:01:45 ct523c-0b0b kernel: RAX: ffffffffffffffda RBX: 00007ffc571e7220 RCX: 00007f3739b0774f
Feb 26 06:01:45 ct523c-0b0b kernel: RDX: 00007ffc571e78a0 RSI: 0000000000008946 RDI: 0000000000000008
Feb 26 06:01:45 ct523c-0b0b kernel: RBP: 00007ffc571e78a0 R08: 000000000000000a R09: 00224f4e223d4c54
Feb 26 06:01:45 ct523c-0b0b kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
Feb 26 06:01:45 ct523c-0b0b kernel: R13: 0000000000000008 R14: 00007ffc571e7950 R15: 0000000000000000
Feb 26 06:01:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task kworker/u16:1:8298 blocked for more than 180 seconds.
Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:01:45 ct523c-0b0b kernel: task:kworker/u16:1   state:D stack:0     pid:8298  tgid:8298  ppid:2      flags:0x00004000
Feb 26 06:01:45 ct523c-0b0b kernel: Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
Feb 26 06:01:45 ct523c-0b0b kernel:  ? cfg80211_wiphy_work+0x1a/0xc0 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? cfg80211_wiphy_work+0x1a/0xc0 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  cfg80211_wiphy_work+0x1a/0xc0 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  process_one_work+0x1f6/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  worker_thread+0x1cc/0x3b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? wq_sysfs_prep_attrs+0x90/0x90
Feb 26 06:01:45 ct523c-0b0b kernel:  kthread+0xec/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  ? kthread_complete_and_exit+0x20/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ret_from_fork+0x28/0x40
Feb 26 06:01:45 ct523c-0b0b kernel:  ? kthread_complete_and_exit+0x20/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ret_from_fork_asm+0x11/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task wpa_supplicant:26601 blocked for more than 180 seconds.
Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:01:45 ct523c-0b0b kernel: task:wpa_supplicant  state:D stack:0     pid:26601 tgid:26601 ppid:1      flags:0x00000002
Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __kmem_cache_alloc_node+0x4f/0x1e0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x41/0xe0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? nl80211_pre_doit+0x1f/0x250 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? nl80211_pre_doit+0x1f/0x250 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  nl80211_pre_doit+0x1f/0x250 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  genl_family_rcv_msg_doit+0xc0/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  genl_rcv_msg+0x182/0x290
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __cfg80211_wdev_from_attrs+0x2b0/0x2b0 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? nl80211_set_sar_specs+0x3e0/0x3e0 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? nlmsg_trim+0x20/0x20 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
Feb 26 06:01:45 ct523c-0b0b kernel:  netlink_rcv_skb+0x4f/0x100
Feb 26 06:01:45 ct523c-0b0b kernel:  genl_rcv+0x1f/0x30
Feb 26 06:01:45 ct523c-0b0b kernel:  netlink_unicast+0x18e/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  netlink_sendmsg+0x257/0x4d0
Feb 26 06:01:45 ct523c-0b0b kernel:  __sock_sendmsg+0x33/0x60
Feb 26 06:01:45 ct523c-0b0b kernel:  ____sys_sendmsg+0x22c/0x2a0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? copy_msghdr_from_user+0x68/0xa0
Feb 26 06:01:45 ct523c-0b0b kernel:  ___sys_sendmsg+0x81/0xc0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? find_held_lock+0x2b/0x80
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __might_fault+0x3c/0x70
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_release+0xc5/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  ? _copy_from_user+0x4c/0x90
Feb 26 06:01:45 ct523c-0b0b kernel:  ? netlink_setsockopt+0x248/0x350
Feb 26 06:01:45 ct523c-0b0b kernel:  ? kfree+0xfc/0x130
Feb 26 06:01:45 ct523c-0b0b kernel:  __sys_sendmsg+0x52/0xa0
Feb 26 06:01:45 ct523c-0b0b kernel:  do_syscall_64+0x3b/0x110
Feb 26 06:01:45 ct523c-0b0b kernel:  entry_SYSCALL_64_after_hwframe+0x46/0x4e
Feb 26 06:01:45 ct523c-0b0b kernel: RIP: 0033:0x7fe226313737
Feb 26 06:01:45 ct523c-0b0b kernel: RSP: 002b:00007fff50b8c6d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
Feb 26 06:01:45 ct523c-0b0b kernel: RAX: ffffffffffffffda RBX: 00000000009354e0 RCX: 00007fe226313737
Feb 26 06:01:45 ct523c-0b0b kernel: RDX: 0000000000000000 RSI: 00007fff50b8c730 RDI: 0000000000000007
Feb 26 06:01:45 ct523c-0b0b kernel: RBP: 0000000000a11ec0 R08: 0000000000000004 R09: 000000000000000d
Feb 26 06:01:45 ct523c-0b0b kernel: R10: 00007fff50b8c7fc R11: 0000000000000246 R12: 00000000009353f0
Feb 26 06:01:45 ct523c-0b0b kernel: R13: 00007fff50b8c730 R14: 00000000007a0d98 R15: 00007fe226cc1000
Feb 26 06:01:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task kworker/3:1:27514 blocked for more than 180 seconds.
Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:01:45 ct523c-0b0b kernel: task:kworker/3:1     state:D stack:0     pid:27514 tgid:27514 ppid:2      flags:0x00004000
Feb 26 06:01:45 ct523c-0b0b kernel: Workqueue: ipv6_addrconf addrconf_verify_work
Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_acquire+0xc6/0x2b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? addrconf_verify_work+0x9/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? addrconf_verify_work+0x9/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  addrconf_verify_work+0x9/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  process_one_work+0x1f6/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  worker_thread+0x1cc/0x3b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? wq_sysfs_prep_attrs+0x90/0x90
Feb 26 06:01:45 ct523c-0b0b kernel:  kthread+0xec/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  ? kthread_complete_and_exit+0x20/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ret_from_fork+0x28/0x40
Feb 26 06:01:45 ct523c-0b0b kernel:  ? kthread_complete_and_exit+0x20/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  ret_from_fork_asm+0x11/0x20
Feb 26 06:01:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task ip:28125 blocked for more than 180 seconds.
Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:01:45 ct523c-0b0b kernel: task:ip              state:D stack:0     pid:28125 tgid:28125 ppid:3604   flags:0x00004002
Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_timeout+0x19c/0x1b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? mark_held_locks+0x49/0x70
Feb 26 06:01:45 ct523c-0b0b kernel:  __wait_for_common+0xba/0x1d0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? usleep_range_state+0xb0/0xb0
Feb 26 06:01:45 ct523c-0b0b kernel:  remove_one+0x6b/0x100
Feb 26 06:01:45 ct523c-0b0b kernel:  simple_recursive_removal+0x20c/0x2b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? start_creating.part.0+0x170/0x170
Feb 26 06:01:45 ct523c-0b0b kernel:  debugfs_remove+0x3b/0x60
Feb 26 06:01:45 ct523c-0b0b kernel:  ieee80211_debugfs_recreate_netdev+0x30/0xac0 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_is_held_type+0xa6/0x110
Feb 26 06:01:45 ct523c-0b0b kernel:  drv_remove_interface+0x96/0x210 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ieee80211_do_stop+0x5e7/0x820 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? mark_held_locks+0x49/0x70
Feb 26 06:01:45 ct523c-0b0b kernel:  ieee80211_stop+0x51/0x180 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  __dev_close_many+0xa7/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  __dev_change_flags+0x198/0x240
Feb 26 06:01:45 ct523c-0b0b kernel:  dev_change_flags+0x1d/0x60
Feb 26 06:01:45 ct523c-0b0b kernel:  do_setlink+0x333/0x1160
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __nla_validate_parse+0x5f/0xd10
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __lock_acquire+0x405/0x2380
Feb 26 06:01:45 ct523c-0b0b kernel:  __rtnl_newlink+0x5a2/0x940
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_is_held_type+0xa6/0x110
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __kmem_cache_alloc_node+0x10/0x1e0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? rtnetlink_rcv_msg+0x93/0x620
Feb 26 06:01:45 ct523c-0b0b kernel:  ? rtnl_newlink+0x25/0x60
Feb 26 06:01:45 ct523c-0b0b kernel:  rtnl_newlink+0x3e/0x60
Feb 26 06:01:45 ct523c-0b0b kernel:  rtnetlink_rcv_msg+0x161/0x620
Feb 26 06:01:45 ct523c-0b0b kernel:  ? rtnl_getlink+0x3e0/0x3e0
Feb 26 06:01:45 ct523c-0b0b kernel:  netlink_rcv_skb+0x4f/0x100
Feb 26 06:01:45 ct523c-0b0b kernel:  netlink_unicast+0x18e/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  netlink_sendmsg+0x257/0x4d0
Feb 26 06:01:45 ct523c-0b0b kernel:  __sock_sendmsg+0x33/0x60
Feb 26 06:01:45 ct523c-0b0b kernel:  ____sys_sendmsg+0x22c/0x2a0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? copy_msghdr_from_user+0x68/0xa0
Feb 26 06:01:45 ct523c-0b0b kernel:  ___sys_sendmsg+0x81/0xc0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __lock_acquire+0x405/0x2380
Feb 26 06:01:45 ct523c-0b0b kernel:  ? fsnotify_grab_connector+0x41/0x160
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_acquire+0xc6/0x2b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? mntput_no_expire+0x3f/0x410
Feb 26 06:01:45 ct523c-0b0b kernel:  ? find_held_lock+0x2b/0x80
Feb 26 06:01:45 ct523c-0b0b kernel:  ? mntput_no_expire+0x8d/0x410
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_release+0xc5/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  __sys_sendmsg+0x52/0xa0
Feb 26 06:01:45 ct523c-0b0b kernel:  do_syscall_64+0x3b/0x110
Feb 26 06:01:45 ct523c-0b0b kernel:  entry_SYSCALL_64_after_hwframe+0x46/0x4e
Feb 26 06:01:45 ct523c-0b0b kernel: RIP: 0033:0x7f4c73f13737
Feb 26 06:01:45 ct523c-0b0b kernel: RSP: 002b:00007ffda71adb38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
Feb 26 06:01:45 ct523c-0b0b kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4c73f13737
Feb 26 06:01:45 ct523c-0b0b kernel: RDX: 0000000000000000 RSI: 00007ffda71adba0 RDI: 0000000000000004
Feb 26 06:01:45 ct523c-0b0b kernel: RBP: 0000000065dc9874 R08: 0000000000000010 R09: 0000000000000060
Feb 26 06:01:45 ct523c-0b0b kernel: R10: 00007f4c73e0df08 R11: 0000000000000246 R12: 00007ffda71adba0
Feb 26 06:01:45 ct523c-0b0b kernel: R13: 0000000000496560 R14: 0000000000000000 R15: 00007f4c741e0000
Feb 26 06:01:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task cat:28128 blocked for more than 180 seconds.
Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:01:45 ct523c-0b0b kernel: task:cat             state:D stack:0     pid:28128 tgid:28128 ppid:28123  flags:0x00000002
Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_timeout+0x19c/0x1b0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? __wait_for_common+0xb1/0x1d0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_release+0xc5/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  __wait_for_common+0xba/0x1d0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? usleep_range_state+0xb0/0xb0
Feb 26 06:01:45 ct523c-0b0b kernel:  wiphy_locked_debugfs_read+0x111/0x180 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? wiphy_locked_debugfs_write_work+0x30/0x30 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? rts_threshold_read+0x80/0x80 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? ieee80211_link_sta_debugfs_drv_remove+0x40/0x40 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ieee80211_if_read_sdata+0x55/0x80 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? ieee80211_link_sta_debugfs_drv_remove+0x40/0x40 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  ? ieee80211_if_fmt_dot11MeshMaxRetries+0x20/0x20 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  full_proxy_read+0x51/0x70
Feb 26 06:01:45 ct523c-0b0b kernel:  vfs_read+0xa3/0x2c0
Feb 26 06:01:45 ct523c-0b0b kernel:  ? find_held_lock+0x2b/0x80
Feb 26 06:01:45 ct523c-0b0b kernel:  ? do_user_addr_fault+0x371/0x850
Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_release+0xc5/0x270
Feb 26 06:01:45 ct523c-0b0b kernel:  ksys_read+0x64/0xe0
Feb 26 06:01:45 ct523c-0b0b kernel:  do_syscall_64+0x3b/0x110
Feb 26 06:01:45 ct523c-0b0b kernel:  entry_SYSCALL_64_after_hwframe+0x46/0x4e
Feb 26 06:01:45 ct523c-0b0b kernel: RIP: 0033:0x7f6af1901b92
Feb 26 06:01:45 ct523c-0b0b kernel: RSP: 002b:00007ffd1a1972a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Feb 26 06:01:45 ct523c-0b0b kernel: RAX: ffffffffffffffda RBX: 00007f6af1a49000 RCX: 00007f6af1901b92
Feb 26 06:01:45 ct523c-0b0b kernel: RDX: 0000000000020000 RSI: 00007f6af1a49000 RDI: 0000000000000003
Feb 26 06:01:45 ct523c-0b0b kernel: RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000000000000
Feb 26 06:01:45 ct523c-0b0b kernel: R10: 0000000000000022 R11: 0000000000000246 R12: 00007f6af1a49000
Feb 26 06:01:45 ct523c-0b0b kernel: R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000020000
Feb 26 06:01:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:01:45 ct523c-0b0b kernel:
                                     Showing all locks held in the system:
Feb 26 06:01:45 ct523c-0b0b kernel: 1 lock held by khungtaskd/66:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffffffff8296d640 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x32/0x1c0
Feb 26 06:01:45 ct523c-0b0b kernel: 3 locks held by kworker/6:3/542:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffff888109b33b38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffffc90000f77e58 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  #2: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x9/0x20
Feb 26 06:01:45 ct523c-0b0b kernel: 1 lock held by ntpd/1448:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: __netlink_dump_start+0x7d/0x290
Feb 26 06:01:45 ct523c-0b0b kernel: 1 lock held by fuse mainloop/2633:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffff8881230a6668 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xc0
Feb 26 06:01:45 ct523c-0b0b kernel: 1 lock held by fuse mainloop/2634:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffff88812cb63068 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xc0
Feb 26 06:01:45 ct523c-0b0b kernel: 1 lock held by gnuserver/3271:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: dev_ethtool+0x9e/0x29b0
Feb 26 06:01:45 ct523c-0b0b kernel: 3 locks held by kworker/u16:1/8298:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffff888108058d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffffc9000abcfe58 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  #2: ffff888122e60768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0x1a/0xc0 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel: 2 locks held by wpa_supplicant/26601:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffffffff82a7a630 (cb_lock){++++}-{4:4}, at: genl_rcv+0x10/0x30
Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: nl80211_pre_doit+0x1f/0x250 [cfg80211]
Feb 26 06:01:45 ct523c-0b0b kernel: 3 locks held by kworker/3:1/27514:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffff888109b33b38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffffc900089fbe58 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:01:45 ct523c-0b0b kernel:  #2: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x9/0x20
Feb 26 06:01:45 ct523c-0b0b kernel: 3 locks held by ip/28125:
Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x13e/0x620
Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffff888122e60768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_stop+0x2d/0x180 [mac80211]
Feb 26 06:01:45 ct523c-0b0b kernel:  #2: ffff88812661d768 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: simple_recursive_removal+0x189/0x2b0
Feb 26 06:01:45 ct523c-0b0b kernel:
Feb 26 06:01:45 ct523c-0b0b kernel: =============================================
Feb 26 06:04:01 ct523c-0b0b dhcpd[24940]: DHCPREQUEST for 172.16.222.81 from 94:1c:56:bf:fa:61 (GRBE330C-FA60) via eth2
Feb 26 06:04:01 ct523c-0b0b dhcpd[24940]: DHCPACK on 172.16.222.81 to 94:1c:56:bf:fa:61 (GRBE330C-FA60) via eth2
Feb 26 06:04:45 ct523c-0b0b kernel: INFO: task kworker/6:3:542 blocked for more than 360 seconds.
Feb 26 06:04:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:04:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:04:45 ct523c-0b0b kernel: task:kworker/6:3     state:D stack:0     pid:542   tgid:542   ppid:2      flags:0x00004000
Feb 26 06:04:45 ct523c-0b0b kernel: Workqueue: ipv6_addrconf addrconf_verify_work
Feb 26 06:04:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:04:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:04:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:04:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:04:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
Feb 26 06:04:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
Feb 26 06:04:45 ct523c-0b0b kernel:  ? lock_acquire+0xc6/0x2b0
Feb 26 06:04:45 ct523c-0b0b kernel:  ? addrconf_verify_work+0x9/0x20
Feb 26 06:04:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
Feb 26 06:04:45 ct523c-0b0b kernel:  ? addrconf_verify_work+0x9/0x20
Feb 26 06:04:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
Feb 26 06:04:45 ct523c-0b0b kernel:  addrconf_verify_work+0x9/0x20
Feb 26 06:04:45 ct523c-0b0b kernel:  process_one_work+0x1f6/0x4e0
Feb 26 06:04:45 ct523c-0b0b kernel:  worker_thread+0x1cc/0x3b0
Feb 26 06:04:45 ct523c-0b0b kernel:  ? wq_sysfs_prep_attrs+0x90/0x90
Feb 26 06:04:45 ct523c-0b0b kernel:  kthread+0xec/0x120
Feb 26 06:04:45 ct523c-0b0b kernel:  ? kthread_complete_and_exit+0x20/0x20
Feb 26 06:04:45 ct523c-0b0b kernel:  ret_from_fork+0x28/0x40
Feb 26 06:04:45 ct523c-0b0b kernel:  ? kthread_complete_and_exit+0x20/0x20
Feb 26 06:04:45 ct523c-0b0b kernel:  ret_from_fork_asm+0x11/0x20
Feb 26 06:04:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:04:45 ct523c-0b0b kernel: INFO: task ntpd:1448 blocked for more than 360 seconds.
Feb 26 06:04:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
Feb 26 06:04:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 26 06:04:45 ct523c-0b0b kernel: task:ntpd            state:D stack:0     pid:1448  tgid:1448  ppid:1      flags:0x00000006
Feb 26 06:04:45 ct523c-0b0b kernel: Call Trace:
Feb 26 06:04:45 ct523c-0b0b kernel:  <TASK>
Feb 26 06:04:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
Feb 26 06:04:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
Feb 26 06:04:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
Feb 26 06:04:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
Feb 26 06:04:45 ct523c-0b0b kernel:  ? netlink_lookup+0x13b/0x2f0
Feb 26 06:04:45 ct523c-0b0b kernel:  ? __netlink_dump_start+0x7d/0x290
Feb 26 06:04:45 ct523c-0b0b kernel:  ? __netlink_dump_start+0x7d/0x290
Feb 26 06:04:45 ct523c-0b0b kernel:  __netlink_dump_start+0x7d/0x290
Feb 26 06:04:45 ct523c-0b0b kernel:  ? rtnl_fill_ifinfo+0x1960/0x1960
Feb 26 06:04:45 ct523c-0b0b kernel:  rtnetlink_rcv_msg+0x4d1/0x620
Feb 26 06:04:45 ct523c-0b0b kernel:  ? rtnl_fill_ifinfo+0x1960/0x1960
Feb 26 06:04:45 ct523c-0b0b kernel:  ? rtnl_getlink+0x3e0/0x3e0
Feb 26 06:04:45 ct523c-0b0b kernel:  netlink_rcv_skb+0x4f/0x100
Feb 26 06:04:45 ct523c-0b0b kernel:  netlink_unicast+0x18e/0x270
Feb 26 06:04:45 ct523c-0b0b kernel:  netlink_sendmsg+0x257/0x4d0
Feb 26 06:04:45 ct523c-0b0b kernel:  __sock_sendmsg+0x33/0x60
Feb 26 06:04:45 ct523c-0b0b kernel:  __sys_sendto+0xef/0x130
Feb 26 06:04:45 ct523c-0b0b kernel:  ? lock_release+0xc5/0x270
Feb 26 06:04:45 ct523c-0b0b kernel:  ? fd_install+0xb8/0x2e0
Feb 26 06:04:45 ct523c-0b0b kernel:  ? __sys_socket+0xc1/0xf0
Feb 26 06:04:45 ct523c-0b0b kernel:  __x64_sys_sendto+0x1b/0x20
Feb 26 06:04:45 ct523c-0b0b kernel:  do_syscall_64+0x3b/0x110
Feb 26 06:04:45 ct523c-0b0b kernel:  entry_SYSCALL_64_after_hwframe+0x46/0x4e
Feb 26 06:04:45 ct523c-0b0b kernel: RIP: 0033:0x7f14ccd13834
Feb 26 06:04:45 ct523c-0b0b kernel: RSP: 002b:00007ffdaa403950 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
Feb 26 06:04:45 ct523c-0b0b kernel: RAX: ffffffffffffffda RBX: 00007ffdaa4049e0 RCX: 00007f14ccd13834
Feb 26 06:04:45 ct523c-0b0b kernel: RDX: 0000000000000014 RSI: 00007ffdaa404a20 RDI: 0000000000000004
Feb 26 06:04:45 ct523c-0b0b kernel: RBP: 0000000000000000 R08: 00007ffdaa4049e0 R09: 000000000000000c
Feb 26 06:04:45 ct523c-0b0b kernel: R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffdaa404a20
Feb 26 06:04:45 ct523c-0b0b kernel: R13: 000055a0c5771010 R14: 00007ffdaa403990 R15: 00007ffdaa404ae0
Feb 26 06:04:45 ct523c-0b0b kernel:  </TASK>
Feb 26 06:04:45 ct523c-0b0b kernel: Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
Feb 26 06:04:45 ct523c-0b0b kernel:
                                     Showing all locks held in the system:
Feb 26 06:04:45 ct523c-0b0b kernel: 1 lock held by khungtaskd/66:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffffffff8296d640 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x32/0x1c0
Feb 26 06:04:45 ct523c-0b0b kernel: 3 locks held by kworker/6:3/542:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffff888109b33b38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:04:45 ct523c-0b0b kernel:  #1: ffffc90000f77e58 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:04:45 ct523c-0b0b kernel:  #2: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x9/0x20
Feb 26 06:04:45 ct523c-0b0b kernel: 1 lock held by ntpd/1448:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: __netlink_dump_start+0x7d/0x290
Feb 26 06:04:45 ct523c-0b0b kernel: 1 lock held by fuse mainloop/2633:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffff8881230a6668 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xc0
Feb 26 06:04:45 ct523c-0b0b kernel: 1 lock held by fuse mainloop/2634:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffff88812cb63068 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xc0
Feb 26 06:04:45 ct523c-0b0b kernel: 1 lock held by gnuserver/3271:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: dev_ethtool+0x9e/0x29b0
Feb 26 06:04:45 ct523c-0b0b kernel: 3 locks held by kworker/u16:1/8298:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffff888108058d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:04:45 ct523c-0b0b kernel:  #1: ffffc9000abcfe58 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:04:45 ct523c-0b0b kernel:  #2: ffff888122e60768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0x1a/0xc0 [cfg80211]
Feb 26 06:04:45 ct523c-0b0b kernel: 2 locks held by wpa_supplicant/26601:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffffffff82a7a630 (cb_lock){++++}-{4:4}, at: genl_rcv+0x10/0x30
Feb 26 06:04:45 ct523c-0b0b kernel:  #1: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: nl80211_pre_doit+0x1f/0x250 [cfg80211]
Feb 26 06:04:45 ct523c-0b0b kernel: 3 locks held by kworker/3:1/27514:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffff888109b33b38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:04:45 ct523c-0b0b kernel:  #1: ffffc900089fbe58 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
Feb 26 06:04:45 ct523c-0b0b kernel:  #2: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x9/0x20
Feb 26 06:04:45 ct523c-0b0b kernel: 3 locks held by ip/28125:
Feb 26 06:04:45 ct523c-0b0b kernel:  #0: ffffffff82a6d588 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x13e/0x620
Feb 26 06:04:45 ct523c-0b0b kernel:  #1: ffff888122e60768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_stop+0x2d/0x180 [mac80211]
Feb 26 06:04:45 ct523c-0b0b kernel:  #2: ffff88812661d768 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: simple_recursive_removal+0x189/0x2b0
Feb 26 06:04:45 ct523c-0b0b kernel: 3 locks held by sadc/28824:
Feb 26 06:04:45 ct523c-0b0b kernel:
Feb 26 06:04:45 ct523c-0b0b kernel: =============================================

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



