Return-Path: <linux-wireless+bounces-13821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDD8997281
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 19:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731FF283649
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C3A14D71E;
	Wed,  9 Oct 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="K/4lh9Rl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DDC3207
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493324; cv=none; b=GonyV4kE7yMCfvn0crlBqLdPw1GFo+Kj8Dx+hLExSlW7N/w13jA5gNSXH1jtwZAX8wkzIuCpIr8iLMqNveNd62XW/F6UiL+lT6AfK+b1dkZWsFV+EykVztnEblNUyVrhT5eXPWA3jQZHTuLRUf0MDMXGswUZ3iyhnqv4vy/4kKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493324; c=relaxed/simple;
	bh=3jYknHbEV29GI+jYD8Wr4NzWrJFJIbrxjjOzlEvAoaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=laB6gnS5L1qbgTAl6SVOkxAsN+VKz9FSsk9Ea21+/Pj9mCyDEZ8B/oMe2IYvPGESpfZZtj4cxDkNnmfBIPNs10vnOW7Xr6jkQd25KfVLRT5Ds4gKC1B+28LEeI0zgKGCfaDhPREorzFE47jjxr/ufn0T/A2/0qnK/ui+h2XTC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=K/4lh9Rl; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 592543000C0;
	Wed,  9 Oct 2024 17:01:57 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8951C13C2B0;
	Wed,  9 Oct 2024 10:01:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8951C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728493309;
	bh=3jYknHbEV29GI+jYD8Wr4NzWrJFJIbrxjjOzlEvAoaU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=K/4lh9RlGH0qMy9U4aHHTyyI+GOayvPvgflnbtH81rIsfRWmFvqz7417t1NTwo2dD
	 xA/GpKPoOuZ/3j2bQeqlM2eB5NZK0kXenqqUS8PePpEkGm44v0Eyx2DjBYvNPtl5KS
	 eA7G9NeaPSedkkLQ9GwL2ukDnDyW/dsDx1dw8aJs=
Message-ID: <47e7e6e5-928c-c8a4-56d1-06b9c669a57e@candelatech.com>
Date: Wed, 9 Oct 2024 10:01:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] wifi: iwlwifi: Report link-id for transmitted frames.
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20241007173851.2207849-1-greearb@candelatech.com>
 <6a2029dcaf7724b8d4516807097541f09268f828.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <6a2029dcaf7724b8d4516807097541f09268f828.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1728493320-GxoUUb_vY3e8
X-MDID-O:
 us5;at1;1728493320;GxoUUb_vY3e8;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/9/24 02:04, Johannes Berg wrote:
> Hi,
> 
> So ... I suppose I kind of get it, your product doesn't really need
> things upstream and so you don't care all _that_ much, but I'd still
> appreciate if you could take a bit more care.
> 
> There's always a large amount of friction with patches you send, which
> at this point makes me not even want to really look at them, and then I
> wonder if I should just fix it up or send it back ... Yes I can and do
> fix trivial things, but it really isn't something I feel I should need
> to be doing all the time.
> 
> And yes, I also understand you want to just throw ideas over the wall,
> but really in a v2 patchset I think we're beyond that. I'd also
> appreciate not seeing obviously wrong patches (e.g. with a ton of marker
> comments or prints left in them) since that just detracts from the
> purpose, but that's not relevant to this patchset here.
> 
> Anyway ...

I appreciate getting patches upstream, and sorry for sending a broken patch
and missing the fact that I had posted a v1 instead of just the RFC.

I believe the v3 cleans up the problems.

Thanks,
Ben

> 
> Here, the subject should've had "v2", and in the commit message, below a
> --- marker, a description of what you changed.
> 
>>   		memset(&info->status, 0, sizeof(info->status));
>>   		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
>> +		if (link_sta_id != -1)
>> +			info->control.flags = u32_replace_bits(info->control.flags, link_sta_id, IEEE80211_TX_CTRL_MLO_LINK);
> 
> That line is clearly too long for no reason at all, and same below.
> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



