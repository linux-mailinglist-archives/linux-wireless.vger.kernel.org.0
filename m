Return-Path: <linux-wireless+bounces-404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154F68040E7
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 22:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C125228129C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF45364BA;
	Mon,  4 Dec 2023 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQCt6M60"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083F33CE6;
	Mon,  4 Dec 2023 21:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B67C433C8;
	Mon,  4 Dec 2023 21:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701724576;
	bh=2iD8vt6eNm0XmwO6zdz79g9BRAd6Cvlx6ThzdonFSAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GQCt6M601eJY4Nnaz4H8Um9YD8LcC+BhL95rxh+WB9jRneB4AiVcAxsuG29q+65Jg
	 G49tfFPUGRjA47FN2yJYhoX5aCQS90IeMlWvYwgs6QgGUERMYYrZdVIQAOKO5UKL25
	 Vm57s5/IRbWOUQwueBvoLJYZ5S88aomGHu8R9HJbhrnuRCP6SDP9HF/NREBzkjTJR7
	 aoz4nb2Z80HkvfMPTh8f//kqLKxZaq7acIsnMh28BxU6ebPzhZUmoMsVqDrs1EDRbz
	 v8kuHxmibuoWpusFUiv0PInA3IPlunxIneyFCNjmqThjhEUsVccdrWH6m7qAgGZ8YY
	 Nsl+00Zc4s8uA==
Date: Mon, 4 Dec 2023 13:16:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Marc MERLIN <marc@merlins.org>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ilw@linux.intel.com,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: Thinkpad P17 keep hanging in ipv6_addrconf addrconf_verify_work
 / netlink in 6.4 and 6.6
Message-ID: <20231204131615.26b57722@kernel.org>
In-Reply-To: <69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
References: <20231202171326.GB24486@merlins.org>
	<20231204004003.GB29484@merlins.org>
	<20231204073515.GA9208@merlins.org>
	<69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

CC: Intel Wired

https://lore.kernel.org/all/20231204004003.GB29484@merlins.org/

On Mon, 04 Dec 2023 11:57:44 +0100 Johannes Berg wrote:
> On Sun, 2023-12-03 at 23:35 -0800, Marc MERLIN wrote:
> > So, I thought that maybe my custom built kernel had options that somehow
> > made P17 unhappy, and went to a stock debian kernel.
> > It's not really looking better with that kernel unfortunately :-/
> > 
> > Still seems unhappy with networking, first wireless and then ethtool.
> > Adding wireless lists to Cc just in case  
> 
> Well clearly something is not unlocking the RTNL, but digging through
> the below I only found places that want to acquire the RTNL and wait
> forever on it (including wireless), but none that actually got stuck
> while having it acquired already.
> 
> 
> Actually ... no that's wrong.
> 
> I can:
> 
> > > [  363.945427] INFO: task powertop:6279 blocked for more than 120 seconds.
> > > [  363.945446]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> > > [  363.945452] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [  363.945456] task:powertop        state:D stack:0     pid:6279  ppid:6267   flags:0x00004002
> > > [  363.945468] Call Trace:
> > > [  363.945473]  <TASK>
> > > [  363.945481]  __schedule+0xba0/0xc05
> > > [  363.945497]  schedule+0x95/0xce
> > > [  363.945504]  schedule_preempt_disabled+0x15/0x22
> > > [  363.945511]  __mutex_lock.constprop.0+0x18b/0x291
> > > [  363.945520]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> > > [  363.945531]  igc_resume+0x18b/0x1ca [igc 1a96e277f8878a2a3c9599226acd0eeb7de577b7]  
> 
> this is trying to acquire the RTNL, by looking at the code
> 
> > > [  363.945566]  __rpm_callback+0x7a/0xe7
> > > [  363.945578]  rpm_callback+0x35/0x64
> > > [  363.945587]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> > > [  363.945592]  rpm_resume+0x342/0x44a
> > > [  363.945600]  ? __kmem_cache_alloc_node+0x123/0x154
> > > [  363.945614]  __pm_runtime_resume+0x5a/0x7a
> > > [  363.945624]  dev_ethtool+0x15a/0x24e7  
> 
> but this already holds it
> 
> So looks like bug in the 'igc' driver wrt. runtime PM locking.
> 
> johannes
> 
> 


