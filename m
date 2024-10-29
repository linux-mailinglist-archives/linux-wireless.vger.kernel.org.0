Return-Path: <linux-wireless+bounces-14656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62339B4F03
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244C51C20C15
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82268196D9D;
	Tue, 29 Oct 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="hHRjlIjq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FDC194AEE
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218395; cv=none; b=MfuV3GkEUlAF/6kWLswtgy4VIBiUtSwWlGik/DrReboAQRq3DW8vcNEiDAeBdcgFDVMM8rjgZ9e5KXBtXl47gAaJNd5XcOJ9DuY5JgKuL0QJKpQotxwTzAnBgSbu5VcJp0JUoxW4TYBidC3oXcDUoFWoT0cyspCaVQoPdlW5mg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218395; c=relaxed/simple;
	bh=OnJXCx70fcMYT5CiwQCMYwEFFHItsJ/aojXN891d1gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kw/ookiCpux/X+x8DSy5Dyn/WbC87vmsXuDwzuV0DQH98IsrddE1bQMzsC+gSjUP4np1DbyIEvrJyuJ4E146Zfs3Cz4jaHbs33nuyFRsVcte6FAefPV8tEVTNrykbJ0my3lDMkQtF7RWeCOu/PFKBhzq8zqUe88AuwWADxjAyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=hHRjlIjq; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C62B86C008A;
	Tue, 29 Oct 2024 16:13:04 +0000 (UTC)
Received: from [10.252.34.165] (unknown [198.134.98.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2486613C2B0;
	Tue, 29 Oct 2024 09:13:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2486613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1730218384;
	bh=OnJXCx70fcMYT5CiwQCMYwEFFHItsJ/aojXN891d1gU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hHRjlIjqdHYlYv51GTPzGBx132v7NartKaauN9kswqWXt7yhuOTzqfysdfxZqQe/W
	 gOmH1I8kPo3NhTce7NMNExsWTDjX/QxtaCt14SupA6byqsPhVCQMMCfFOnJZaxnz2C
	 wn5kzqV0YnWyd3qzVEgcg7o7qFxyS6Ya7Ol/PyrA=
Message-ID: <2fae54fe-9a15-4003-855f-34a8de889f3c@candelatech.com>
Date: Tue, 29 Oct 2024 09:13:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question on iwlwifi iwl_mvm_mac_itxq_xmit, possible busy-spin.
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <8dce89a1-350c-4885-afcc-0eda162fd76c@candelatech.com>
 <1f6d998c16510426e57b774c42358dcef7a5cd31.camel@sipsolutions.net>
 <9cfa23e6-3c4e-4c45-b6db-2148c9bdd2b0@candelatech.com>
 <10ef9bc82600e0ee0ccf763b842f056bcb1e2fdb.camel@sipsolutions.net>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <10ef9bc82600e0ee0ccf763b842f056bcb1e2fdb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1730218385-PXIA8gS4IiHx
X-MDID-O:
 us5;at1;1730218385;PXIA8gS4IiHx;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/29/24 9:02 AM, Johannes Berg wrote:
> On Tue, 2024-10-29 at 08:55 -0700, Ben Greear wrote:
>>>
>>> Not really? It should only get here from two places: userspace
>>> (serialized, so you're not going to get to this point with two threads
>>> from there), and the "queue no longer full" logic I mentioned above. Oh,
>>> maybe technically a third at the beginning after allocating a new queue.
>>
>> How is user-space serialized here?  The comments in the code seem to assume
>> that multiple threads/whatever calling into this is expected (ie, the whole
>> 3-state atomic counter).
> 
> Well mac80211, certainly serialized per iTXQ, but since we don't have
> LLTX (yet) also through a single netdev queue.
> 
>>> I guess I could sort of see a scenario where
>>>
>>>    - queues got full
>>>    - queues got not full
>>>    - we kick this logic via "queue not full"
>>>    - while this is running, userspace TX permanently bumps
>>>      tx_request from 1 to 2, this decrements it again, etc.
>>
>> Considering GSO and KASAN slowness and highly loaded system, perhaps under memory pressure too,
>> maybe upper stack could feed the txq fast enough that something is always bumping
>> tx_requests to 2 before inner loop can finish?
> 
> Maybe? But at some point the socket buffers are full too. You can't
> indefinitely queue packets.
> 
>>> What thread is the soft lockup in that you see?
>>
>> I believe this below is the culprit.  Other threads are blocked on trying to grab xmit lock on
>> netdev and sock locks on tcp socket(s).
> 
> That seems odd though - it's locked up at a different place, and also
> coming in from userspace - but that's serialized against other
> userspace, and the "queue not full" thread can only run once really?
> 
> OTOH if it's deadlocked at that level you could get interrupted at any
> level below...
> 
> I guess it's still possible that you end up pushing a packet down, it
> gets transmitted, space becomes available, and then we run this again to
> push more packets all while the original loop didn't finish? But that
> seem pretty unlikely?
> 
> Hard to tell what's going on.

Yes, that sums it up nicely.  Anyway, we'll keep digging and thanks for
taking a look.

--Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

