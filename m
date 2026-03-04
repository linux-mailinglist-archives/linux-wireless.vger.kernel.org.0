Return-Path: <linux-wireless+bounces-32428-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDd+Jih3p2nyhgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32428-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 01:04:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 299471F8A8E
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 01:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EED8B306D8EA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA425DD1E;
	Wed,  4 Mar 2026 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="cXLkuepr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1A135A53;
	Wed,  4 Mar 2026 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582542; cv=none; b=iHhcdGM3xzhg8HcedBdvzHYCs0ozMIjFbMNSSvWhOGQr10TO+/ozyywQ1eFueBukxSxvVW5/pSUEXmqOfuzeaWuUwnxkh5rMWEeZF0EdSyMMMYJ2xb69cp9RTGWq0A29IlZe/xCjhXUrVRjWlBXDv2qhOs5JPysanyLAUU7COYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582542; c=relaxed/simple;
	bh=PMlmlJTmJH+EFUFF85hcCnD7ggv7F1pWyKFzmcYHZ4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6llHURLB3I6EgbmIiAE+DEB6GZchLJ+5YjXNuPf2CeraLnIlG6eHzvBz5jd5R4ASaBi0HBcUkIM5inPRhZgIq8sXJm4Otv2RdyVYcMIEymWh6QIOoyBbD90sWcr+7pUpPE/PFLN4H/oDD0sSlNZA/AtW2O68A2O4TTHIS66Yrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=cXLkuepr; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6128B1C0075;
	Wed,  4 Mar 2026 00:02:17 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id BC95F13C2B1;
	Tue,  3 Mar 2026 16:02:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BC95F13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772582534;
	bh=PMlmlJTmJH+EFUFF85hcCnD7ggv7F1pWyKFzmcYHZ4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cXLkueprkVnUZX/SGnTCV9Wf7gb5GCyzvm/1X+aEgF1WLLXhPsfNwMH0MZYIfFQNj
	 4dRvx91uoa9krngQm1Rwz+DSuKMunp0M9c6AKYNU3fjMnC8j6sA8TVosoAWVzwnSGR
	 lIOk8EAHeibTXBlHl0oZQWmWtTUTwTQyPmUQ7t2o=
Message-ID: <de003dc3-3e37-f238-4250-2df16eeb77d6@candelatech.com>
Date: Tue, 3 Mar 2026 16:02:14 -0800
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
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
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
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <aadYoaA_JYduCx_S@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772582538-tWDR7B38HNWO
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1772582538;tWDR7B38HNWO;<greearb@candelatech.com>;e39a4ef213bcaa75c219f509376588df
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 299471F8A8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32428-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On 3/3/26 13:54, Tejun Heo wrote:
> Hello,
> 
> On Tue, Mar 03, 2026 at 01:40:54PM -0800, Ben Greear wrote:
>> If I use a kthread to do the blocking reg_todo work, then the problem
>> goes away, so it somehow does appear that the work flush logic down in swap.c
>> is somehow being blocked by the reg_todo work item, not just the swap.c
>> logic somehow blocking against itself.
>>
>> My kthread hack left the reg_todo work item logic in place, but instead of
>> the work item doing any blocking work, it instead just wakes the kthread
>> I added and has that kthread do the work under mutex.
>>
>> The second regulatory related work item in net/wireless/ causes the same
>> lockup, though it was harder to reproduce.  Putting that work in the kthread
>> also seems to have fixed it.
>>
>> I could only ever reproduce this with KASAN (and lockdep and other debugging options
>> enabled), my guess is that this is because then the system runs slower and/or there
>> is more memory pressure.
>>
>> I should still be able to reproduce this if I switch to upstream kernel, so
>> if there is any debugging code you'd like me to execute, I will attempt to
>> do so.
> 
> I think the main thing is findin out what state the work item is in. Is it
> pending, running, or finished? You can enable wq tracepoints to figure that
> out or if you can take a crashdump when it's stalled, nowadays it's really
> easy to tell the state w/ something like claude code and drgn. Just tell
> claude to use drgn to look at the crashdump and ask it to locate the work
> item and what it's doing. It works surprisingly well.

Could the logic that detects blocked work-queues instead be instrumented
to print out more useful information so that just reproducing the problem
and providing dmesg output will be sufficient?  Or does dmesg already provide
enough that would give you a clue as to what is going on?

If I were to attempt to use AI on the coredump, would echoing 'c' to /proc/sysrq-trigger
with kdump enabled (when deadlock is happening) be the appropriate action to grab the core file?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



