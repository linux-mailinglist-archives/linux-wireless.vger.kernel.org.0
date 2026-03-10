Return-Path: <linux-wireless+bounces-32920-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDWQBadCsGlLhgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32920-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:11:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA4E2545C8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A30330098B1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115963BF668;
	Tue, 10 Mar 2026 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="e7MW2/gF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC13DBA0;
	Tue, 10 Mar 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159073; cv=none; b=LUrpv9rH6Irq41TzRyya1AkF906tzYBpaXDSGZfW3rqhlf/r8qKVUA86hiei6Mi621MDgOVebr95Q8i5c+7Tzx+qxQfG6CgqTTG9XGfU/hMmmWC+lRi99jQ0+L6gtgU1mJCLxlUlHGWVk+5Y4pBhR/RwXi7xkF5dLV1KxX9NNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159073; c=relaxed/simple;
	bh=5zKbXLO3yRW74LlTEHd2bGno6r91jmuahTP/SPinZUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nottHzb8LuzVxiFT9EJ5Iqj7FHqm221RCCCkHGq1vohoEoJ/32el/u8JLffkWliFKBxQPWGuaclXu1dIPLk7zLegukpZRfrygvmIn/gg98MesadKzZIIgKY1F1pM5Bk8V7bAZnLlJW0xRMSf4k/zqhFNuTeuS3R8tdgahu9kTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=e7MW2/gF; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ED66A340090;
	Tue, 10 Mar 2026 16:11:07 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9B00513C2B0;
	Tue, 10 Mar 2026 09:10:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9B00513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773159056;
	bh=5zKbXLO3yRW74LlTEHd2bGno6r91jmuahTP/SPinZUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e7MW2/gFMTBDhQHSAYbjSNqGfEBsd/R5nEC+4Tl+binFtZXIqca+TG/mEIJdyXf70
	 Hoctr3CpTzqAc476951tkL0uNsb3Mjh8Hbr9/bhbxWxfOdsA3v8hUPFgvLpgvf/19o
	 8Kn6WmoP6W3cNsNkn99PuCbEFmlWDlWK22+TGnqU=
Message-ID: <bba74cab-7305-a052-7e1c-7a7736ba4531@candelatech.com>
Date: Tue, 10 Mar 2026 09:10:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Miriam Rachel <miriam.rachel.korenblit@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
 <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
 <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
 <aadKDCKGHk1Ua-7_@slm.duckdns.org>
 <3303d57a4ea6776dbc66ca72441023f76e6f1234.camel@sipsolutions.net>
 <35a7ebcf-862f-0b3a-a245-c32196a58692@candelatech.com>
 <aadYoaA_JYduCx_S@slm.duckdns.org>
 <de003dc3-3e37-f238-4250-2df16eeb77d6@candelatech.com>
 <68c1ca1381d1871fff72b211890a64eb@kernel.org>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <68c1ca1381d1871fff72b211890a64eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1773159069-t8kQowwyWApu
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773159069;t8kQowwyWApu;<greearb@candelatech.com>;e39a4ef213bcaa75c219f509376588df
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: ADA4E2545C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32920-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 09:14, Tejun Heo wrote:
> Hello,
> 
> (Partially drafted with the help of Claude)
> 
> On Tue, Mar 03, 2026 at 04:02:14PM -0800, Ben Greear wrote:
>> Could the logic that detects blocked work-queues instead be instrumented
>> to print out more useful information so that just reproducing the problem
>> and providing dmesg output will be sufficient?  Or does dmesg already provide
>> enough that would give you a clue as to what is going on?
> 
> It may not be exactly the same issue, but Breno just posted a patch that
> might help. The current watchdog only prints backtraces for workers that
> are actively running on CPU, so sleeping culprits are invisible. His
> patch removes that filter so all in-flight workers get printed:
> 
>    http://lkml.kernel.org/r/aag4tTyeiZyw0jID@gmail.com
> 
> Might be worth trying.

Hello Tejun,

I applied the first 4 patches of the v2 of that series to my 6.18.14 kernel, with
my use-kthread-for-regdom patches reverted.

Stock 6.18.16 kernel crashes too often in the wifi driver to reliably reproduce the deadlock
there.

Both the reg_todo and lru_drain are on CPU 5, but I'm not sure if that really
matters.

Does this info below show anything useful to you?

Mar 10 08:59:15 ct523c-2103 kernel: BUG: workqueue lockup - pool cpus=5 node=0 flags=0x0 nice=0 stuck for 57507s!
Mar 10 08:59:15 ct523c-2103 kernel: Showing busy workqueues and worker pools:
Mar 10 08:59:15 ct523c-2103 kernel: workqueue events: flags=0x100
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=2 refcnt=3
Mar 10 08:59:15 ct523c-2103 kernel:     in-flight: 264128:disconnect_work [cfg80211] for 57502s disconnect_work [cfg80211]
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=9 refcnt=10
Mar 10 08:59:15 ct523c-2103 kernel:     in-flight: 271323:reg_todo [cfg80211] for 57507s
Mar 10 08:59:15 ct523c-2103 kernel:     pending: reg_todo [cfg80211], igb_watchdog_task [igb], output_poll_execute [drm_kms_helper], kernfs_notify_workfn, 
key_garbage_collector, 2*update_super_work, netstamp_clear
Mar 10 08:59:15 ct523c-2103 kernel: workqueue events_unbound: flags=0x2
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=2 refcnt=3
Mar 10 08:59:15 ct523c-2103 kernel:     in-flight: 236337:cfg80211_wiphy_work [cfg80211] for 57507s cfg80211_wiphy_work [cfg80211]
Mar 10 08:59:15 ct523c-2103 kernel: workqueue events_unbound: flags=0x2
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=1 refcnt=2
Mar 10 08:59:15 ct523c-2103 kernel:     in-flight: 142096:linkwatch_event for 57502s linkwatch_event
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=3 refcnt=4
Mar 10 08:59:15 ct523c-2103 kernel:     in-flight: 218388:fsnotify_mark_destroy_workfn for 55995s fsnotify_mark_destroy_workfn BAR(1309) 
,267638:fsnotify_connector_destroy_workfn for 55995s fsnotify_connector_destroy_workfn
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=2 refcnt=4
Mar 10 08:59:15 ct523c-2103 kernel: workqueue events_freezable: flags=0x104
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=2
Mar 10 08:59:15 ct523c-2103 kernel:     pending: pci_pme_list_scan
Mar 10 08:59:15 ct523c-2103 kernel: workqueue events_power_efficient: flags=0x180
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 14: cpus=3 node=0 flags=0x0 nice=0 active=2 refcnt=3
Mar 10 08:59:15 ct523c-2103 kernel:     in-flight: 268226:reg_check_chans_work [cfg80211] for 57441s reg_check_chans_work [cfg80211]
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=218 refcnt=219
Mar 10 08:59:15 ct523c-2103 kernel:     pending: gc_worker [nf_conntrack], hub_post_resume, 216*ioc_release_fn
Mar 10 08:59:15 ct523c-2103 kernel: workqueue rcu_gp: flags=0x108
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=2
Mar 10 08:59:15 ct523c-2103 kernel:     pending: process_srcu
Mar 10 08:59:15 ct523c-2103 kernel: workqueue mm_percpu_wq: flags=0x8
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=2 refcnt=4
Mar 10 08:59:15 ct523c-2103 kernel:     pending: lru_add_drain_per_cpu BAR(236337), vmstat_update
Mar 10 08:59:15 ct523c-2103 kernel: workqueue cgroup_offline: flags=0x100
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=107
Mar 10 08:59:15 ct523c-2103 kernel:     pending: css_killed_work_fn
Mar 10 08:59:15 ct523c-2103 kernel:     inactive: 105*css_killed_work_fn
Mar 10 08:59:15 ct523c-2103 kernel: workqueue cgroup_release: flags=0x100
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=15
Mar 10 08:59:15 ct523c-2103 kernel:     pending: css_release_work_fn
Mar 10 08:59:15 ct523c-2103 kernel:     inactive: 13*css_release_work_fn
Mar 10 08:59:15 ct523c-2103 kernel: workqueue cgroup_bpf_destroy: flags=0x100
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=54
Mar 10 08:59:15 ct523c-2103 kernel:     pending: cgroup_bpf_release
Mar 10 08:59:15 ct523c-2103 kernel:     inactive: 52*cgroup_bpf_release
Mar 10 08:59:15 ct523c-2103 kernel: workqueue ipv6_addrconf: flags=0x6000a
Mar 10 08:59:15 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=1 refcnt=14
Mar 10 08:59:15 ct523c-2103 kernel:     in-flight: 202972:addrconf_dad_work for 57505s
Mar 10 08:59:15 ct523c-2103 kernel:     inactive: 4*addrconf_verify_work
Mar 10 08:59:15 ct523c-2103 kernel: pool 2: cpus=0 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 203067 243191
Mar 10 08:59:15 ct523c-2103 kernel: pool 14: cpus=3 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 709498 699449
Mar 10 08:59:15 ct523c-2103 kernel: pool 22: cpus=5 node=0 flags=0x0 nice=0 hung=57507s workers=3 idle: 166929 260518
Mar 10 08:59:15 ct523c-2103 kernel: pool 32: cpus=0-7 flags=0x4 nice=0 hung=0s workers=9 idle: 631693 712021 717023 671858
Mar 10 08:59:15 ct523c-2103 kernel: Showing backtraces of busy workers in stalled CPU-bound worker pools:
Mar 10 08:59:15 ct523c-2103 kernel: pool 22:
Mar 10 08:59:15 ct523c-2103 kernel: task:kworker/5:2     state:D stack:0     pid:271323 tgid:271323 ppid:2      task_flags:0x4208060 flags:0x00080000
Mar 10 08:59:15 ct523c-2103 kernel: Workqueue: events reg_todo [cfg80211]
Mar 10 08:59:15 ct523c-2103 kernel: Call Trace:
Mar 10 08:59:15 ct523c-2103 kernel:  <TASK>
Mar 10 08:59:15 ct523c-2103 kernel:  __schedule+0x106f/0x4340
Mar 10 08:59:15 ct523c-2103 kernel:  ? lock_acquire+0x155/0x2e0
Mar 10 08:59:15 ct523c-2103 kernel:  ? io_schedule_timeout+0x150/0x150
Mar 10 08:59:15 ct523c-2103 kernel:  ? __schedule+0x1865/0x4340
Mar 10 08:59:15 ct523c-2103 kernel:  preempt_schedule_notrace+0x4c/0x70
Mar 10 08:59:15 ct523c-2103 kernel:  preempt_schedule_notrace_thunk+0x16/0x30
Mar 10 08:59:15 ct523c-2103 kernel:  rcu_is_watching+0x59/0x70
Mar 10 08:59:15 ct523c-2103 kernel:  lock_acquire+0x291/0x2e0
Mar 10 08:59:15 ct523c-2103 kernel:  schedule+0x211/0x3a0
Mar 10 08:59:15 ct523c-2103 kernel:  ? schedule+0x1f2/0x3a0
Mar 10 08:59:15 ct523c-2103 kernel:  schedule_preempt_disabled+0x11/0x20
Mar 10 08:59:15 ct523c-2103 kernel:  __mutex_lock+0xd02/0x1d60
Mar 10 08:59:15 ct523c-2103 kernel:  ? reg_process_self_managed_hints+0x70/0x190 [cfg80211]
Mar 10 08:59:15 ct523c-2103 kernel:  ? ww_mutex_lock+0x160/0x160
Mar 10 08:59:15 ct523c-2103 kernel:  ? __mutex_unlock_slowpath+0x15d/0x770
Mar 10 08:59:15 ct523c-2103 kernel:  ? wait_for_completion_io_timeout+0x20/0x20
Mar 10 08:59:15 ct523c-2103 kernel:  ? reg_process_self_managed_hints+0x70/0x190 [cfg80211]
Mar 10 08:59:15 ct523c-2103 kernel:  reg_process_self_managed_hints+0x70/0x190 [cfg80211]
Mar 10 08:59:15 ct523c-2103 kernel:  reg_todo+0x52e/0x7c0 [cfg80211]
Mar 10 08:59:15 ct523c-2103 kernel:  ? lock_release+0xce/0x290
Mar 10 08:59:15 ct523c-2103 kernel:  process_one_work+0x88b/0x1820
Mar 10 08:59:15 ct523c-2103 kernel:  ? pwq_dec_nr_in_flight+0xe00/0xe00
Mar 10 08:59:15 ct523c-2103 kernel:  ? reg_process_hint+0x1480/0x1480 [cfg80211]
Mar 10 08:59:15 ct523c-2103 kernel:  worker_thread+0x5a1/0xfd0
Mar 10 08:59:15 ct523c-2103 kernel:  ? __kthread_parkme+0xc6/0x1f0
Mar 10 08:59:15 ct523c-2103 kernel:  ? rescuer_thread+0x1350/0x1350
Mar 10 08:59:15 ct523c-2103 kernel:  kthread+0x3b7/0x770
Mar 10 08:59:15 ct523c-2103 kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Mar 10 08:59:15 ct523c-2103 kernel:  ? ret_from_fork+0x17/0x3a0
Mar 10 08:59:15 ct523c-2103 kernel:  ? lock_release+0xce/0x290
Mar 10 08:59:15 ct523c-2103 kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Mar 10 08:59:15 ct523c-2103 kernel:  ret_from_fork+0x28b/0x3a0
Mar 10 08:59:15 ct523c-2103 kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Mar 10 08:59:15 ct523c-2103 kernel:  ret_from_fork_asm+0x11/0x20
Mar 10 08:59:15 ct523c-2103 kernel:  </TASK>
Mar 10 08:59:46 ct523c-2103 kernel: BUG: workqueue lockup - pool cpus=5 node=0 flags=0x0 nice=0 stuck for 57537s!
Mar 10 08:59:46 ct523c-2103 kernel: Showing busy workqueues and worker pools:
Mar 10 08:59:46 ct523c-2103 kernel: workqueue events: flags=0x100
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=2 refcnt=3
Mar 10 08:59:46 ct523c-2103 kernel:     in-flight: 264128:disconnect_work [cfg80211] for 57533s disconnect_work [cfg80211]
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=9 refcnt=10
Mar 10 08:59:46 ct523c-2103 kernel:     in-flight: 271323:reg_todo [cfg80211] for 57537s
Mar 10 08:59:46 ct523c-2103 kernel:     pending: reg_todo [cfg80211], igb_watchdog_task [igb], output_poll_execute [drm_kms_helper], kernfs_notify_workfn, 
key_garbage_collector, 2*update_super_work, netstamp_clear
Mar 10 08:59:46 ct523c-2103 kernel: workqueue events_unbound: flags=0x2
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=2 refcnt=3
Mar 10 08:59:46 ct523c-2103 kernel:     in-flight: 236337:cfg80211_wiphy_work [cfg80211] for 57537s cfg80211_wiphy_work [cfg80211]
Mar 10 08:59:46 ct523c-2103 kernel: workqueue events_unbound: flags=0x2
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=1 refcnt=2
Mar 10 08:59:46 ct523c-2103 kernel:     in-flight: 142096:linkwatch_event for 57533s linkwatch_event
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=3 refcnt=4
Mar 10 08:59:46 ct523c-2103 kernel:     in-flight: 218388:fsnotify_mark_destroy_workfn for 56026s fsnotify_mark_destroy_workfn BAR(1309) 
,267638:fsnotify_connector_destroy_workfn for 56026s fsnotify_connector_destroy_workfn
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=2 refcnt=4
Mar 10 08:59:46 ct523c-2103 kernel: workqueue events_freezable: flags=0x104
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=2
Mar 10 08:59:46 ct523c-2103 kernel:     pending: pci_pme_list_scan
Mar 10 08:59:46 ct523c-2103 kernel: workqueue events_power_efficient: flags=0x180
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 14: cpus=3 node=0 flags=0x0 nice=0 active=2 refcnt=3
Mar 10 08:59:46 ct523c-2103 kernel:     in-flight: 268226:reg_check_chans_work [cfg80211] for 57472s reg_check_chans_work [cfg80211]
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=218 refcnt=219
Mar 10 08:59:46 ct523c-2103 kernel:     pending: gc_worker [nf_conntrack], hub_post_resume, 216*ioc_release_fn
Mar 10 08:59:46 ct523c-2103 kernel: workqueue rcu_gp: flags=0x108
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=2
Mar 10 08:59:46 ct523c-2103 kernel:     pending: process_srcu
Mar 10 08:59:46 ct523c-2103 kernel: workqueue mm_percpu_wq: flags=0x8
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=2 refcnt=4
Mar 10 08:59:46 ct523c-2103 kernel:     pending: lru_add_drain_per_cpu BAR(236337), vmstat_update
Mar 10 08:59:46 ct523c-2103 kernel: workqueue cgroup_offline: flags=0x100
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=107
Mar 10 08:59:46 ct523c-2103 kernel:     pending: css_killed_work_fn
Mar 10 08:59:46 ct523c-2103 kernel:     inactive: 105*css_killed_work_fn
Mar 10 08:59:46 ct523c-2103 kernel: workqueue cgroup_release: flags=0x100
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=15
Mar 10 08:59:46 ct523c-2103 kernel:     pending: css_release_work_fn
Mar 10 08:59:46 ct523c-2103 kernel:     inactive: 13*css_release_work_fn
Mar 10 08:59:46 ct523c-2103 kernel: workqueue cgroup_bpf_destroy: flags=0x100
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 22: cpus=5 node=0 flags=0x0 nice=0 active=1 refcnt=54
Mar 10 08:59:46 ct523c-2103 kernel:     pending: cgroup_bpf_release
Mar 10 08:59:46 ct523c-2103 kernel:     inactive: 52*cgroup_bpf_release
Mar 10 08:59:46 ct523c-2103 kernel: workqueue ipv6_addrconf: flags=0x6000a
Mar 10 08:59:46 ct523c-2103 kernel:   pwq 32: cpus=0-7 flags=0x4 nice=0 active=1 refcnt=14
Mar 10 08:59:46 ct523c-2103 kernel:     in-flight: 202972:addrconf_dad_work for 57536s
Mar 10 08:59:46 ct523c-2103 kernel:     inactive: 4*addrconf_verify_work
Mar 10 08:59:46 ct523c-2103 kernel: pool 2: cpus=0 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 203067 243191
Mar 10 08:59:46 ct523c-2103 kernel: pool 14: cpus=3 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 709498 699449
Mar 10 08:59:46 ct523c-2103 kernel: pool 22: cpus=5 node=0 flags=0x0 nice=0 hung=57537s workers=3 idle: 166929 260518
Mar 10 08:59:46 ct523c-2103 kernel: pool 32: cpus=0-7 flags=0x4 nice=0 hung=0s workers=9 idle: 631693 712021 717023 671858
Mar 10 08:59:46 ct523c-2103 kernel: Showing backtraces of busy workers in stalled CPU-bound worker pools:
Mar 10 08:59:46 ct523c-2103 kernel: pool 22:
Mar 10 08:59:46 ct523c-2103 kernel: task:kworker/5:2     state:D stack:0     pid:271323 tgid:271323 ppid:2      task_flags:0x4208060 flags:0x00080000
Mar 10 08:59:46 ct523c-2103 kernel: Workqueue: events reg_todo [cfg80211]
Mar 10 08:59:46 ct523c-2103 kernel: Call Trace:
Mar 10 08:59:46 ct523c-2103 kernel:  <TASK>
Mar 10 08:59:46 ct523c-2103 kernel:  __schedule+0x106f/0x4340
Mar 10 08:59:46 ct523c-2103 kernel:  ? lock_acquire+0x155/0x2e0
Mar 10 08:59:46 ct523c-2103 kernel:  ? io_schedule_timeout+0x150/0x150
Mar 10 08:59:46 ct523c-2103 kernel:  ? __schedule+0x1865/0x4340
Mar 10 08:59:46 ct523c-2103 kernel:  preempt_schedule_notrace+0x4c/0x70
Mar 10 08:59:46 ct523c-2103 kernel:  preempt_schedule_notrace_thunk+0x16/0x30
Mar 10 08:59:46 ct523c-2103 kernel:  rcu_is_watching+0x59/0x70
Mar 10 08:59:46 ct523c-2103 kernel:  lock_acquire+0x291/0x2e0
Mar 10 08:59:46 ct523c-2103 kernel:  schedule+0x211/0x3a0
Mar 10 08:59:46 ct523c-2103 kernel:  ? schedule+0x1f2/0x3a0
Mar 10 08:59:46 ct523c-2103 kernel:  schedule_preempt_disabled+0x11/0x20
Mar 10 08:59:46 ct523c-2103 kernel:  __mutex_lock+0xd02/0x1d60
Mar 10 08:59:46 ct523c-2103 kernel:  ? reg_process_self_managed_hints+0x70/0x190 [cfg80211]
Mar 10 08:59:46 ct523c-2103 kernel:  ? ww_mutex_lock+0x160/0x160
Mar 10 08:59:46 ct523c-2103 kernel:  ? __mutex_unlock_slowpath+0x15d/0x770
Mar 10 08:59:46 ct523c-2103 kernel:  ? wait_for_completion_io_timeout+0x20/0x20
Mar 10 08:59:46 ct523c-2103 kernel:  ? reg_process_self_managed_hints+0x70/0x190 [cfg80211]
Mar 10 08:59:46 ct523c-2103 kernel:  reg_process_self_managed_hints+0x70/0x190 [cfg80211]
Mar 10 08:59:46 ct523c-2103 kernel:  reg_todo+0x52e/0x7c0 [cfg80211]
Mar 10 08:59:46 ct523c-2103 kernel:  ? lock_release+0xce/0x290
Mar 10 08:59:46 ct523c-2103 kernel:  process_one_work+0x88b/0x1820
Mar 10 08:59:46 ct523c-2103 kernel:  ? pwq_dec_nr_in_flight+0xe00/0xe00
Mar 10 08:59:46 ct523c-2103 kernel:  ? reg_process_hint+0x1480/0x1480 [cfg80211]
Mar 10 08:59:46 ct523c-2103 kernel:  worker_thread+0x5a1/0xfd0
Mar 10 08:59:46 ct523c-2103 kernel:  ? __kthread_parkme+0xc6/0x1f0
Mar 10 08:59:46 ct523c-2103 kernel:  ? rescuer_thread+0x1350/0x1350
Mar 10 08:59:46 ct523c-2103 kernel:  kthread+0x3b7/0x770
Mar 10 08:59:46 ct523c-2103 kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Mar 10 08:59:46 ct523c-2103 kernel:  ? ret_from_fork+0x17/0x3a0
Mar 10 08:59:46 ct523c-2103 kernel:  ? lock_release+0xce/0x290
Mar 10 08:59:46 ct523c-2103 kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Mar 10 08:59:46 ct523c-2103 kernel:  ret_from_fork+0x28b/0x3a0
Mar 10 08:59:46 ct523c-2103 kernel:  ? kthread_is_per_cpu+0xb0/0xb0
Mar 10 08:59:46 ct523c-2103 kernel:  ret_from_fork_asm+0x11/0x20
Mar 10 08:59:46 ct523c-2103 kernel:  </TASK>


>> If I were to attempt to use AI on the coredump, would echoing 'c' to
>> /proc/sysrq-trigger with kdump enabled (when deadlock is happening) be
>> the appropriate action to grab the core file?
> 
> Yes, that's right, but you need to set up kdump first. The quickest way
> depends on your distro:
> 
>   - Fedora/RHEL: dnf install kexec-tools, then kdumpctl reset-crashkernel,
>     systemctl enable --now kdump
>   - Ubuntu/Debian: apt install kdump-tools (say Yes to enable), reboot
>   - Arch: Install kexec-tools, add crashkernel=512M to your kernel
>     cmdline, create a kdump.service that runs
>     kexec -p /boot/vmlinuz-linux --initrd=/boot/initramfs-linux.img \
>       --append="root=<your-root> irqpoll nr_cpus=1 reset_devices"
> 
> After reboot, verify with: cat /sys/kernel/kexec_crash_size (should be
> non-zero). Then when the deadlock happens:
> 
>    echo c > /proc/sysrq-trigger

I have kdump enabled already, and I could create a vmcore like this.
I have never used drgn, nor claude.  Based on the logs above, do
you still think it would be helpful to try drgn?  If so, can you please
suggest some commands or approaches specific to this particular bug?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



