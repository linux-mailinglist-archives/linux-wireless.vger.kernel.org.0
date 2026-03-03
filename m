Return-Path: <linux-wireless+bounces-32425-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB6GC3hVp2lsgwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32425-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:41:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C81F7AAC
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 22:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0FAD30131C8
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 21:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88423932CB;
	Tue,  3 Mar 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="o6trfUCS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7CE3932C0;
	Tue,  3 Mar 2026 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574066; cv=none; b=ZZMN0RIY96LHzRPT0+YCjcnP0TapGLHiucjrq4AhsGxXaVJ4RFQ2tRX17lUHkCLhhJrxdwqyA7IKZ8RN+a4jeggUq4omJMgY9Zs2HmW1nLttypmH9yrUE0fPfbK/Wy3/gCVVN3MaArpEuzFkrsGGK6TRlQgw9qHx/njoKpTziu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574066; c=relaxed/simple;
	bh=znA5tqnvgNYmnwGDlFG5uCbSpnh0UQ+1XGZxgDBaB24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJdIJxIX5TsPAX6LqnLnzvgnJpNOtuIBOIEr8rn+yS2O/L7VbLjYYMrdCcyaj5DY52i7qM+Zp0o5bOuNnYMCdErEKCulj2RNqFX32/6q/H3ecQxwpUtIYeJ/yJd3S6Id9qhFLK3uSdcga/hgF5UXnGAsNnoi6/7ZKgQnDZJQJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=o6trfUCS; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 41CB4340067;
	Tue,  3 Mar 2026 21:40:57 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8F1A313C2B0;
	Tue,  3 Mar 2026 13:40:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8F1A313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772574054;
	bh=znA5tqnvgNYmnwGDlFG5uCbSpnh0UQ+1XGZxgDBaB24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o6trfUCS9Pnbs4ZJ5ybn4kCHaW9unuQkeruCDzHtDQbLbgJ9u9CLuBto6S4K76I6o
	 F5FLhn5/g3Wjk1YMoMm7SOoF3NvguD4PxqkSkll3tLW9kEA5g4ZkvN2knqlGn2sOey
	 EZHc9WvBaUruCH/8nHnqDxrDZHFMm9jQLsxCLDeY=
Message-ID: <35a7ebcf-862f-0b3a-a245-c32196a58692@candelatech.com>
Date: Tue, 3 Mar 2026 13:40:54 -0800
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
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, Tejun Heo <tj@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com>
 <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
 <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
 <35779061f94c2a55bb58dcd619ae91c618509cf4.camel@sipsolutions.net>
 <aadKDCKGHk1Ua-7_@slm.duckdns.org>
 <3303d57a4ea6776dbc66ca72441023f76e6f1234.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <3303d57a4ea6776dbc66ca72441023f76e6f1234.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772574058-GeJRA8u8Q2pf
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1772574058;GeJRA8u8Q2pf;<greearb@candelatech.com>;e39a4ef213bcaa75c219f509376588df
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 347C81F7AAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32425-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,candelatech.com:dkim,candelatech.com:email,candelatech.com:url,candelatech.com:mid]
X-Rspamd-Action: no action

On 3/3/26 13:12, Johannes Berg wrote:
> On Tue, 2026-03-03 at 10:52 -1000, Tejun Heo wrote:
>> Hello,
>>
>> On Tue, Mar 03, 2026 at 12:49:24PM +0100, Johannes Berg wrote:
>>> Fair. I don't know, I don't think there's anything that even shows that
>>> there's a dependency between the two workqueues and the
>>> "((wq_completion)events_unbound)" and "((wq_completion)events)", and
>>> there would have to be for it to deadlock this way because of that?
>>>
>>> But one is mm_percpu_wq and the other is system_percpu_wq.
>>>
>>> Tejun, does the workqueue code somehow introduce a dependency between
>>> different per-CPU workqueues that's not modelled in lockdep?
>>
>> Hopefully not. Kinda late to the party. Why isn't mm_percpu_wq making
>> forward progress? That should in all circumstances. What's the work item and
>> kworker doing?
> 
> Oh and in addition: the worker that's kicked off by
> __lru_add_drain_all() doesn't really seem to do anything long-running?
> It's lru_add_drain_per_cpu(), which is lru_add_and_bh_lrus_drain(),
> which would appear to be entirely non-sleepable code (holding either
> local locks or having irqs disabled.) It also doesn't show up in the
> log, apparently, hence my question about strange dependencies.

Hello Tejun,

If I use a kthread to do the blocking reg_todo work, then the problem
goes away, so it somehow does appear that the work flush logic down in swap.c
is somehow being blocked by the reg_todo work item, not just the swap.c
logic somehow blocking against itself.

My kthread hack left the reg_todo work item logic in place, but instead of
the work item doing any blocking work, it instead just wakes the kthread
I added and has that kthread do the work under mutex.

The second regulatory related work item in net/wireless/ causes the same
lockup, though it was harder to reproduce.  Putting that work in the kthread
also seems to have fixed it.

I could only ever reproduce this with KASAN (and lockdep and other debugging options
enabled), my guess is that this is because then the system runs slower and/or there
is more memory pressure.

I should still be able to reproduce this if I switch to upstream kernel, so
if there is any debugging code you'd like me to execute, I will attempt to
do so.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



