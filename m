Return-Path: <linux-wireless+bounces-12072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8B9613C0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DC281EE1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43881CE6E7;
	Tue, 27 Aug 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Y1h7nvU0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A941CF28C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775176; cv=none; b=ejlaBqMQfsEMzX5pArLB7TkG4gfVAGNw8VQ2hCzA0Y3xTWsKiYN5c4XWjRV2JbDPlLTlKvhBIHLHknFHx5c66v2gYiKPkiWY1F5neXLVgHNpZk+O5NwUY1fiH4H9Bzfj+NHxeXNHQmgxF+XxZjnWPphOUf2hCJSPNM8xu5c/yZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775176; c=relaxed/simple;
	bh=cBs1FQJLbzULKkT9bO2bzCibxM+QSLUw8WGCKNZPJQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZjnQHzamXFTmbRNfY6ZyJjom5vE4VnpodZBvz1TDYJoYOxhWFi2vdrRKj9qtjmNvt4VeeZhDymvuhmQ5f4jcZPkr1U0z+fd4/yuKFbFAGRpg40bWiVNm4YSitLE7ZUsTOrd+DHMnMwHEgKOUyCC6M1IS7zhzZincmA6sFupYLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Y1h7nvU0; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0A28F780092;
	Tue, 27 Aug 2024 16:12:45 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6705B13C2B0;
	Tue, 27 Aug 2024 09:12:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6705B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724775165;
	bh=cBs1FQJLbzULKkT9bO2bzCibxM+QSLUw8WGCKNZPJQ8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Y1h7nvU05J+j4ESP1LAclTg1TUD2EAV7F9NWIubm8ggSy3+eDRNkQyI9ZndnjXV1t
	 Xub6Qnp5QARP7SAB6jAadyqIk6IDozY+1WaWnn15NajxyVOdbJv2LjWeZvgxe84iDs
	 vMo01NU0CZs9ymoWFZ/71jLYmLKiH/cLBXgQUu1Q=
Message-ID: <e5c3265a-3411-39b4-f4c4-40f3937c96fb@candelatech.com>
Date: Tue, 27 Aug 2024 09:12:45 -0700
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
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <7ccb9c8ccb0dd16539ac064a35d6bf6b31d0bf0d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1724775167-bKGm7n1YJ3J4
X-MDID-O:
 us5;ut7;1724775167;bKGm7n1YJ3J4;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 8/27/24 08:56, Johannes Berg wrote:
> On Fri, 2024-07-12 at 10:52 -0700, Ben Greear wrote:
>> Hello,
>>
>> I've been trying to get better per MLO link stats.  I see that the rx path
>> stats are there, but in the tx path, I do not see anything other than 'deflink'
>> getting updated.
> 
> Yeah, nobody really cared too much about statistics yet. I know. Sorry.
> Not much time to work on it either now.
> 
>> And, at least with iwlwifi, I cannot find any way to actually see what link-id
>> was used to transmit a frame in the tx status callbacks (or anywhere else I looked).
> 
> You can probably derive that from the band for iwlwifi, since it only
> supports one active link on each 2.4 / 5 / 6 GHz if at all. And the band
> I guess you'd get from the LMAC ID or something. Should be in there
> somewhere... IOW, I think it's possible, but I'm also not entirely sure
> how we'd do it.

When be200 goes into eMLSR mode, both 5 and 6Ghz links are shown as active, so at least
you cannot use 'active link' to reliably update stats.

>> In the case where there is a single active link, then I can hack something together
>> that should be at least mostly right, but that won't fix any future radio that can
>> do 2+ active links.
>>
>> Any suggestions for best path forward on this?
> 
> I really think we also need to do some work on the API/cfg80211 level,
> and have link station statistics in cfg80211 instead of full station,
> and then combine them to (older) userspace in cfg80211, i.e. if
> userspace doesn't request broken out per-link statistics. There's
> probably a bunch of work here, and I only have a vague idea of how it
> should be done...

I think first step is to get the driver(s) able to report the link-id in
the tx-status.  After that, mac80211 can gather the stats.  I hacked
tx/rx link stats into mac80211 ethtool (for first 3 links), but it is still not reliable since
mac80211 doesn't know the actual tx link id.

After that, then certainly I'd be happy to have per-link stats available,
and combining them in cfg80211 seems like a fine idea as well.  Some things
that don't combine well (rssi, link rates, etc) would take a bit of kludging
if trying to provide a single 'sta' view of stats.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



