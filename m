Return-Path: <linux-wireless+bounces-3341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB79484E44E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773E828DCCD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A8D7CF39;
	Thu,  8 Feb 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="F3qcmpQj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5BF7D3EF
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407398; cv=none; b=K0I4eXmmQNGx8kIR1+PHSdm2xBsRMUOxn3xK+ZNNKScowJ441yTMz5hNsgfZxl0QrHUjJINMNOC3hjRv7vO29Iq/ChRjR2mUDl+UAs1IbwVYqiLNTGGWRp/Od4KTvnXfUk3DCbDod/HADcG6gpekXfG1O7aEZIMiepR8nbDBOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407398; c=relaxed/simple;
	bh=kTJpVfWndpTXxsDNvPg0W77p5JC5w9Jr5GMU4HxXEHw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jY5zIlkkK4vbgdrvhvEzf1aSadSVsobaHGXSKGDUwUogAX5B3MYGaYnSXrEZmMTBGddojoAZQ9MTlnTY7Q3G2FRL2opQ+VgK6v49X9m0GNNf64/DjxH01FeIhN4vT4d3daZVi7t6XmRcRBur3lNJaYcyBcGFPtLaNh/83o2gx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=F3qcmpQj; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CC6B2503A97
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 15:41:44 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C6D9E240084;
	Thu,  8 Feb 2024 15:41:36 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.116.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 26CE013C2B0;
	Thu,  8 Feb 2024 07:41:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 26CE013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1707406896;
	bh=kTJpVfWndpTXxsDNvPg0W77p5JC5w9Jr5GMU4HxXEHw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=F3qcmpQjvLPh8zyZmBIMjgfJsGnS4A7C8ckBMplizVrXEGj/CIX6YeDA8xAlVx5Xb
	 I7NNRCinIrGZ6XJRuMZMhRHKl4J3SmjgJXZL7JFieMttfpwTn5/TePiQ6wv60eX/3R
	 j3o/zFCn7sDgtQiiACtpctj5sBt9df6lK4lswzT4=
Subject: Re: [PATCH] mac80211: Ensure bss-coloring is always configured
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20240130180848.776867-1-greearb@candelatech.com>
 <7c2721f79c1d6c0aa914db4f4d6148c8efce4b85.camel@sipsolutions.net>
 <ZcTzOm5dU9fPfYwC@lore-desk>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <48e6ced8-b138-36a8-6c8b-b56127952bf9@candelatech.com>
Date: Thu, 8 Feb 2024 07:41:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcTzOm5dU9fPfYwC@lore-desk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1707406897-z6MjxzC1vYor
X-MDID-O:
 us5;at1;1707406897;z6MjxzC1vYor;<greearb@candelatech.com>;0c8f9bd5b2e25066af54324b55109d82

On 2/8/24 7:28 AM, Lorenzo Bianconi wrote:
>> On Tue, 2024-01-30 at 10:08 -0800, greearb@candelatech.com wrote:
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> Old code would not set it to disabled, just assumed that driver
>>> would default to disabled.  Change this to explicitly request
>>> bss color be flushed on initial driver configuration.
>>
>> Arguably, the current behaviour is in line with the documentation of
>> BSS_CHANGED_HE_BSS_COLOR ... but I would tend to agree that
>> enabling/disabling coloring should be covered by it as well. Lorenzo?
>>
>>> And I think the beacon-change logic was slightly wrong, so adjust
>>> that as well.
>>
>> That's not a great thing for a commit message to say ...
>>
>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>> ---
>>>   net/mac80211/cfg.c | 10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>>> index 1c7fb0959cfd..1a6c6c764cbc 100644
>>> --- a/net/mac80211/cfg.c
>>> +++ b/net/mac80211/cfg.c
>>> @@ -1331,8 +1331,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>>>   			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
>>>   		changed |= BSS_CHANGED_HE_OBSS_PD;
>>>   
>>> -		if (params->beacon.he_bss_color.enabled)
>>> -			changed |= BSS_CHANGED_HE_BSS_COLOR;
>>> +		changed |= BSS_CHANGED_HE_BSS_COLOR;
> 
> I think we should use beacon->he_bss_color_valid here instead of
> params->beacon.he_bss_color.enabled, agree?

Either way, the value changed from un-set/un-known to some value, so why not just
mark it changed and flush to the driver?

Thanks,
Ben

> 
>>>   	}
>>>   
>>>   	if (params->he_cap) {
>>> @@ -1512,6 +1511,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>>>   	int err;
>>>   	struct ieee80211_bss_conf *link_conf;
>>>   	u64 changed = 0;
>>> +	bool color_en;
>>>   
>>>   	lockdep_assert_wiphy(wiphy);
>>>   
>>> @@ -1549,9 +1549,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>>>   		return err;
>>>   	changed |= err;
>>>   
>>> -	if (beacon->he_bss_color_valid &&
>>> -	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
>>> -		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
>>> +	color_en = beacon->he_bss_color.enabled && beacon->he_bss_color_valid;
>>> +	if (color_en != link_conf->he_bss_color.enabled) {
>>> +		link_conf->he_bss_color.enabled = color_en;
>>>   		changed |= BSS_CHANGED_HE_BSS_COLOR;
>>>   	}
> 
> this seems fine to me. >
> Regards,
> Lorenzo
> 
>>>
>>
>> Not sure how this isn't updating the color itself, Lorenzo?
>>
>> johannes
>>


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

