Return-Path: <linux-wireless+bounces-32353-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DBSB6mypWlMEgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32353-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 16:54:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4711DC366
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 16:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07BCF304A577
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEF44014BE;
	Mon,  2 Mar 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="UcP8pAu9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AA3375C3
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466677; cv=none; b=vA5d8QSTrX619m+knWjQb4URI2W64xf1H7F7LNrIAtZxbgSHQ3q2KsdvsN6f0x65/Xz0Aqxc0IQsNXDbBTvUuwz1+URqfWNcxbVHDZ435x0OqmAw8X96Vw3eKzOg5ehV84czWhhHtEj7S6bdQ4MI5qfGuhqrpHSLlTvlw6Icaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466677; c=relaxed/simple;
	bh=4yf8YFL7jyHSnGLpl3oF2CsMir9We4DXATnMYeZZZBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBFH0ytzg4A3UI333TGTt5Jdqxh8wSsh237uFQsllZklajywgxLvNxulEeH/YkPeIhewL+J+K1YAr4aG5KYvd1G3KFrVfHVQA3oiJ0cdOIZB2AZjNDHZqN6AyZX7ZmzImdNIPOAyV7vgHh5q97T1Bhw5zukvHShMjvyQ6tNhchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=UcP8pAu9; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 82C064400BA;
	Mon,  2 Mar 2026 15:51:07 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.35.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8BE5313C2B1;
	Mon,  2 Mar 2026 07:50:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8BE5313C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772466664;
	bh=4yf8YFL7jyHSnGLpl3oF2CsMir9We4DXATnMYeZZZBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UcP8pAu9WPTja7HnxC7Y4KHGOdjNHxThfs+inCHchvGGM4vrPvZjlAfsVwSAnDUZ7
	 nbFQCAkeTfQ406GHMNnsen2H4SukP8oj/ELgUIAXXZ44/ieZcVtIcKTlDAd8+yhuuy
	 5Nw+nP9yHBkbKqk4cFSFbjddjiNTyzw0P7p6bU4Y=
Message-ID: <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
Date: Mon, 2 Mar 2026 07:50:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 linux-mm@kvack.org, Tejun Heo <tj@kernel.org>
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com>
 <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772466668-vkB9hMjGlWtI
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772466668;vkB9hMjGlWtI;<greearb@candelatech.com>;4238417753472804730e2a8cda7a2ac7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 7D4711DC366
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32353-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,candelatech.com:dkim,candelatech.com:email,candelatech.com:url,candelatech.com:mid]
X-Rspamd-Action: no action

On 3/2/26 07:38, Johannes Berg wrote:
> On Mon, 2026-03-02 at 07:26 -0800, Ben Greear wrote:
>>
>>>
>>> Was this with lockdep? If so, it complain about anything?
>>>
>>> I'm having a hard time seeing why it would deadlock at all when wifi
>>> uses  schedule_work() and therefore the system_percpu_wq, and
>>> __lru_add_drain_all() flushes lru_add_drain_work on mm_percpu_wq, and
>>> lru_add_and_bh_lrus_drain() doesn't really _seem_ to do anything related
>>> to RTNL etc.?
>>>
>>> I think we need a real explanation here rather than "if I randomly
>>> change this, it no longer appears".
>>
>> The path where iwlwifi acquires CMA holds rtnl and/or wiphy locks before
>> allocating CMA memory, as expected.
>>
>> And the CMA allocation path attempts to flush the work queues in
>> at least some cases.
>>
>> If there is a work item queued that is trying to grab rtnl and/or wiphy lock
>> when CMA attempts to flush, then the flush work cannot complete, so it deadlocks.
>>
>> Lockdep doesn't warn about this.
> 
> It really should, in cases where it can actually happen, I wrote the
> code myself for that... Though things have changed since, and the checks
> were lost at least once (and re-added), so I suppose it's possible that
> they were lost _again_, but the flushing system is far more flexible now
> and it's not flushing the same workqueue anyway, so it shouldn't happen.
> 
> I stand by what I said before, need to show more precisely what depends
> on what, and I'm not going to accept a random kthread into this.

My first email on the topic has process stack traces as well as lockdep
locks-held printout that points to the deadlock.  I'm not sure what else to offer...please let me know
what you'd like to see.

Thanks,
Ben


> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


