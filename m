Return-Path: <linux-wireless+bounces-12075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C52EB96140F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750721F23F43
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D31C9458;
	Tue, 27 Aug 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="D0lUOB7I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39331C7B6F
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776132; cv=none; b=kzjSFoeEXXWPxRo0Pbm6KLcjuWGvA52Nvx2C+7TGNCaKgx1FksHLYH8Hyl8fCQeg7zmAAGu6Z7PkKENFs20TBsXboYl6fCyr2yarfkp6hMXlSC0tqII3A4GJuaO0v8QrGe+z2oH8SBoYBO6TGJj/62hjA2gvmMMiWjFQuiEgrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776132; c=relaxed/simple;
	bh=CKcEtqGM2HxI2mjdsYMB9OUr+er0Y54QouzS432aVQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m6U3EKe1rqg9TYXYB5Skk+oQiZppiPzhUO/kmmGtWftc+3Y89mVL4baTaOEfZoCm7p1bSU0kEKXIWy0edFCKJS3tGo6F4CcoeP+6qi1gQX4gj5edwrtbHHTLk8kgLUsdXZ0R4s61hJOdWZTPAVf2ftqP4e1SdHnqn9etrqe5BLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=D0lUOB7I; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B9C19340068;
	Tue, 27 Aug 2024 16:28:48 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3217F13C2B0;
	Tue, 27 Aug 2024 09:28:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3217F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724776126;
	bh=CKcEtqGM2HxI2mjdsYMB9OUr+er0Y54QouzS432aVQ0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=D0lUOB7IOMf+/UFf5D7j/67z03NpL5hoAA7UXjsolUhJe3W02kufJ1vkl4csKTjzX
	 DtjQ8cHs3TvQHmwwt7ZdljpgpVLyEZaca3tS1Zg0MUX+Sog2cx+5IF7w5NE9VHjAEK
	 NLoHWEIH4P+krJQvEv5r6gRzG9dVbmJZBRkzUOyk=
Message-ID: <41008ac0-ca36-b19f-c3a4-61f54ce2d2f7@candelatech.com>
Date: Tue, 27 Aug 2024 09:28:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Per MLO link TX stats
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <c896c0d6-b43f-ba6d-336a-eca15c60529f@candelatech.com>
 <7ccb9c8ccb0dd16539ac064a35d6bf6b31d0bf0d.camel@sipsolutions.net>
 <e5c3265a-3411-39b4-f4c4-40f3937c96fb@candelatech.com>
 <9093726e308d0a26e8afe2323a865d222e48fe61.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <9093726e308d0a26e8afe2323a865d222e48fe61.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1724776129-ayzjUIl0Onp9
X-MDID-O:
 us5;ut7;1724776129;ayzjUIl0Onp9;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 8/27/24 09:20, Johannes Berg wrote:
> On Tue, 2024-08-27 at 09:12 -0700, Ben Greear wrote:
>>
>> When be200 goes into eMLSR mode, both 5 and 6Ghz links are shown as active, so at least
>> you cannot use 'active link' to reliably update stats.
> 
> Sure, not active link - but there's an LMAC bit somewhere ... Ah, it's
> not documented, it's actually documented *differently*, but it should be
> bit 31 in len_n_flags in struct iwl_rx_packet.
> 
> Given the LMAC ID on the TX response notification we should know which
> LMAC transmitted it, and then I think it's a simple mapping to the
> active link. But I haven't actually really tried it.

If you can share a patch that documents this bit (like 0 means 5Ghz and 1 means 6Ghz??)
then we can try it out.

And maybe your idea for how to report it in tx-status too since that will touch
mac80211?

>>>> In the case where there is a single active link, then I can hack something together
>>>> that should be at least mostly right, but that won't fix any future radio that can
>>>> do 2+ active links.
>>>>
>>>> Any suggestions for best path forward on this?
>>>
>>> I really think we also need to do some work on the API/cfg80211 level,
>>> and have link station statistics in cfg80211 instead of full station,
>>> and then combine them to (older) userspace in cfg80211, i.e. if
>>> userspace doesn't request broken out per-link statistics. There's
>>> probably a bunch of work here, and I only have a vague idea of how it
>>> should be done...
>>
>> I think first step is to get the driver(s) able to report the link-id in
>> the tx-status.  After that, mac80211 can gather the stats.
> 
> Yeah, that makes sense, at least partially that's needed. I suspect that
> also we need to extend the API down to the sta_statistics call though to
> return per-link statistics, e.g. the TX bitrate would seem should be
> reported per link, and that's done through that call now I believe.

Yes.  At least at cfg80211 level, I think we should be able to query all
link stats in a single call into mac80211.  Down in mac80211, then per-link
stats structs appears to be how things are done now and seems like a good
solution.

> 
>> I hacked
>> tx/rx link stats into mac80211 ethtool (for first 3 links), but it is still not reliable since
>> mac80211 doesn't know the actual tx link id.
> 
> Right.
> 
>> After that, then certainly I'd be happy to have per-link stats available,
>> and combining them in cfg80211 seems like a fine idea as well.  Some things
>> that don't combine well (rssi, link rates, etc) would take a bit of kludging
>> if trying to provide a single 'sta' view of stats.
> 
> True, some can't just be added up and we'd have to find a sane different
> "best" view, perhaps for rates it'd be the better of the two or the sum
> if only reporting the bitrate, or better of the RSSI, etc. Case by case,
> I guess.

I'd suggest using highest active band when we have no better option for
summing/combining.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



