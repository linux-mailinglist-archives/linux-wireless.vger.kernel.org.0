Return-Path: <linux-wireless+bounces-14372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FBD9AC329
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 11:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76693B23AC7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB65175D2D;
	Wed, 23 Oct 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="0VZg0Fvt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20415F330;
	Wed, 23 Oct 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674691; cv=none; b=DLds3miTRxq+Z4aOcNj5quDGxfhnyDRFKy1xuJAY5K0aK/Dc+INFzJ5FwSDEaFwnXRIcu6epFc88t2zjnl1UrZKQaFhumFbLT3GM9RuBoiSfwnvCbhKIcHj2xzHm+XBpHxaA302QD+7VeumUDQTFGfwduSTkLp2BgGICpphBsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674691; c=relaxed/simple;
	bh=WGx7Tarp0BmupSMXd5gBDlD6bEjKjOIYqL5ojiHhZoY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dyYVr5227y0S3OMx4kFq3MY26yMEy+tHwFTkPVP0HPd8uSUeyxas3IARySSq58hDDbqU2hHir+DrHtSGqkr2MESeCrsNLtOCRNJwTLLYrmj7xei0n6nVfcjfkfa2DFKsEgnfK9JoMBYf/oWUMrqCk0Z3D5/l3OVbp0S6RrNhfnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=0VZg0Fvt; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=yrOFcq3pQeSmFJGAhQX43gag3cRloi4K5j2bHRXHL3Q=;
	t=1729674689; x=1730106689; b=0VZg0FvtunHC4HYXTtrm2Wpo5OOIfM3hPz4F+jFZOKIZewh
	tLfLSFR7NoBvRWW53ZUK6Lzfd2zJzmzzKP9ZEEBGBYnzaoxopnxGyAJi4bR4vGh75qY9TR+1tlC6n
	kzYa90yUxsp5JZzbvZ460n+OO5HCSNE5uLgOoxwRIE/MFtzJP/fjkvPKJHcW5tGExbD4d8KljjyAp
	N4IRco+yaITAqlMbjS2zK2Ej0mvRotYX5JpfPJ2n4AmOedQ1F9RvebjVHNEv3lMLVJkAgrmVYzKpw
	OFxrDUyFsSZ10sFpd27Nn2ORXEA+S0PxaTdF+OrekBBBT8U0JKUW4HqHpzzNC6vQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t3XOk-0003yd-0l; Wed, 23 Oct 2024 11:11:22 +0200
Message-ID: <8de3cde0-2f20-4ca5-a70c-deb954f28fce@leemhuis.info>
Date: Wed, 23 Oct 2024 11:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] wifi problems since tg3 started throwing rcu stall
 warnings
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>,
 netdev <netdev@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <b8da4aec-4cca-4eb0-ba87-5f8641aa2ca9@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <b8da4aec-4cca-4eb0-ba87-5f8641aa2ca9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729674689;383787ce;
X-HE-SMSGID: 1t3XOk-0003yd-0l

[reply to self to CC the tg3 maintainers, netdev, and linux-wireless;
sorry, forgot them earlier, but they should be involved, as I guess this
is a problem in tg3 interfering with wifi drivers that the rcu change
just exposed]

On 23.10.24 10:27, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> Frederic, I noticed a report about a regression in bugzilla.kernel.org
> that appears to be caused by the following change of yours:
> 
> 55d4669ef1b768 ("rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU
> invocation")
> 
> As many (most?) kernel developers don't keep an eye on the bug tracker,
> I decided to write this mail. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=219390:
> 
>>  Mingcong Bai 2024-10-15 13:32:35 UTC
>>
>> Since aa162aa4aa383a0a714b1c36e8fcc77612ddd1a2 between v6.10.4 and
>> v6.10.5, the Broadcom Tigon3 Ethernet interface (tg3) found on Apple
>> MacBook Pro (15'', Mid 2010) would throw many rcu stall errors during
>> boot up, causing peripherals such as the wireless card to misbehave:
>>
>> [   24.153855] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 2-.... } 21 jiffies s: 973 root: 0x4/.
>> [   24.166938] rcu: blocking rcu_node structures (internal RCU debug):
>> [   24.177800] Sending NMI from CPU 3 to CPUs 2:
>> [   24.183113] NMI backtrace for cpu 2
>> [   24.183119] CPU: 2 PID: 1049 Comm: NetworkManager Not tainted 6.10.5-aosc-main #1
>> [   24.183123] Hardware name: Apple Inc. MacBookPro6,2/Mac-F22586C8, BIOS    MBP61.88Z.005D.B00.1804100943 04/10/18
>> [   24.183125] RIP: 0010:__this_module+0x2d3d1/0x4f310 [tg3]
>> [   24.183135] Code: c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 89 f6 48 03 77 30 8b 06 <31> f6 31 ff c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90
>> [   24.183138] RSP: 0018:ffffbf1a011d75e8 EFLAGS: 00000082
>> [   24.183141] RAX: 0000000000000000 RBX: ffffa04ec78f8a00 RCX: 0000000000000000
>> [   24.183143] RDX: 0000000000000000 RSI: ffffbf1a00fb007c RDI: ffffa04ec78f8a00
>> [   24.183145] RBP: 0000000000000b50 R08: 0000000000000000 R09: 0000000000000000
>> [   24.183147] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000216
>> [   24.183148] R13: ffffbf1a011d7624 R14: ffffa04ec78f8a08 R15: ffffa04ec78f8b40
>> [   24.183151] FS:  00007f4c524b2140(0000) GS:ffffa05007d00000(0000) knlGS:0000000000000000
>> [   24.183153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   24.183155] CR2: 00007f7025eae3e8 CR3: 00000001040f8000 CR4: 00000000000006f0
>> [   24.183157] Call Trace:
>> [   24.183162]  <NMI>
>> [   24.183167]  ? nmi_cpu_backtrace+0xbf/0x140
>> [   24.183175]  ? nmi_cpu_backtrace_handler+0x11/0x20
>> [   24.183181]  ? nmi_handle+0x61/0x160
>> [   24.183186]  ? default_do_nmi+0x42/0x110
>> [   24.183191]  ? exc_nmi+0x1bd/0x290
>> [   24.183194]  ? end_repeat_nmi+0xf/0x53
>> [   24.183203]  ? __this_module+0x2d3d1/0x4f310 [tg3]
>> [   24.183207]  ? __this_module+0x2d3d1/0x4f310 [tg3]
>> [   24.183210]  ? __this_module+0x2d3d1/0x4f310 [tg3]
>> [   24.183213]  </NMI>
>> [   24.183214]  <TASK>
>> [   24.183215]  __this_module+0x31828/0x4f310 [tg3]
>> [   24.183218]  ? __this_module+0x2d390/0x4f310 [tg3]
>> [   24.183221]  __this_module+0x398e6/0x4f310 [tg3]
>> [   24.183225]  __this_module+0x3baf8/0x4f310 [tg3]
>> [   24.183229]  __this_module+0x4733f/0x4f310 [tg3]
>> [   24.183233]  ? _raw_spin_unlock_irqrestore+0x25/0x70
>> [   24.183237]  ? __this_module+0x398e6/0x4f310 [tg3]
>> [   24.183241]  __this_module+0x4b943/0x4f310 [tg3]
>> [   24.183244]  ? delay_tsc+0x89/0xf0
>> [   24.183249]  ? preempt_count_sub+0x51/0x60
>> [   24.183254]  __this_module+0x4be4b/0x4f310 [tg3]
>> [   24.183258]  __dev_open+0x103/0x1c0
>> [   24.183265]  __dev_change_flags+0x1bd/0x230
>> [   24.183269]  ? rtnl_getlink+0x362/0x400
>> [   24.183276]  dev_change_flags+0x26/0x70
>> [   24.183280]  do_setlink+0xe16/0x11f0
>> [   24.183286]  ? __nla_validate_parse+0x61/0xd40
>> [   24.183295]  __rtnl_newlink+0x63d/0x9f0
>> [   24.183301]  ? kmem_cache_alloc_node_noprof+0x12b/0x360
>> [   24.183308]  ? kmalloc_trace_noprof+0x11e/0x350
>> [   24.183312]  ? rtnl_newlink+0x2e/0x70
>> [   24.183316]  rtnl_newlink+0x47/0x70
>> [   24.183320]  rtnetlink_rcv_msg+0x152/0x400
>> [   24.183324]  ? __netlink_sendskb+0x68/0x90
>> [   24.183329]  ? netlink_unicast+0x237/0x290
>> [   24.183333]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>> [   24.183336]  netlink_rcv_skb+0x5b/0x110
>> [   24.183343]  netlink_unicast+0x1a4/0x290
>> [   24.183347]  netlink_sendmsg+0x222/0x4a0
>> [   24.183350]  ? proc_get_long.constprop.0+0x116/0x210
>> [   24.183358]  ____sys_sendmsg+0x379/0x3b0
>> [   24.183363]  ? copy_msghdr_from_user+0x6d/0xb0
>> [   24.183368]  ___sys_sendmsg+0x86/0xe0
>> [   24.183372]  ? addrconf_sysctl_forward+0xf3/0x270
>> [   24.183378]  ? _copy_from_iter+0x8b/0x570
>> [   24.183384]  ? __pfx_addrconf_sysctl_forward+0x10/0x10
>> [   24.183388]  ? _raw_spin_unlock+0x19/0x50
>> [   24.183392]  ? proc_sys_call_handler+0xf3/0x2f0
>> [   24.183397]  ? trace_hardirqs_on+0x29/0x90
>> [   24.183401]  ? __fdget+0xc2/0xf0
>> [   24.183405]  __sys_sendmsg+0x5b/0xc0
>> [   24.183410]  ? syscall_trace_enter+0x110/0x1b0
>> [   24.183416]  do_syscall_64+0x64/0x150
>> [   24.183423]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> I have bisected the error to this commit. Reverting it caused no new or
>> perceivable issues on both the MacBook and a Zen4-based laptop.
> 
> [...]
> 
>>> Ohh, and when you say "causing peripherals such as the wireless card to
>>> misbehave" what exactly do you mean?
>>
>> When the kernel throws rcu stall messages, the wireless card on the
>> MacBook may fail to discover and/or connect to wireless networks - not a
>> consistent behaviour but I suppose that something in the kernel got stuck.
> 
> See the ticket for more details and dmesg logs; the problem still
> happens with 6.12-rc. The reporter is CCed.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> P.S.: let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: 55d4669ef1b76823083caecfab12a8bd2ccdcf64
> #regzbot from: Mingcong Bai <jeffbai@aosc.io>
> #regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219390
> #regzbot title: rcu: wifi problems since tg3 started throwing rcu stall
> warnings
> #regzbot ignore-activity
> 
> 


