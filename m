Return-Path: <linux-wireless+bounces-3344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17584E4FA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC231F2AC2C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BFC7D41A;
	Thu,  8 Feb 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Xa1zD6fX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91E7BAF2
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409507; cv=none; b=haN4AlhdxqSHy1dbIV26Rm6aeN3PwO3dcNlpZU5R3gKR9wyK6hbFw/rkmuJNAgDe8rPIsBps4Zgrb9O2IUEMiJe7bc8aH7A+h8WoO/FZ7v+5Wc2/nHn0dvRjO8uF2i91zX2r9H1kwqAZytvYddaejNYnKvKSV5CQxDP3/GTxiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409507; c=relaxed/simple;
	bh=SUcSAmBkQL1ZNctgk4BYjbUP/B8BCks9Of/5RbikgfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j776VRz16v+/S4IF9OG5ji12NqZv4S06EvUniIJu+TnoGOHOb3LzDZl3BnxF6h2891b1gmRRwyMAzBh4WEUC8YGZXJfxRy8HlDrf33AMtAtt2SzNFPr6aXH09SWKesDQWl6/MAtQzPal6ZDX0brer+h/TcXiArfgkXMI9tO78XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Xa1zD6fX; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B8470240087;
	Thu,  8 Feb 2024 16:25:02 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E6B7013C2B0;
	Thu,  8 Feb 2024 08:25:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E6B7013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1707409502;
	bh=SUcSAmBkQL1ZNctgk4BYjbUP/B8BCks9Of/5RbikgfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xa1zD6fXhHCovfIiZsqzx1XQHXhpZIz9n8kPt4LGd1zfQbFa6faBlX0z9Ybwko6wV
	 yo6GVKHXsqZE5D9K6Ppm77K5ZuPAUIZO+ZOGimhc837CrZ+npEATwCYxxxwv8CN4qH
	 fRADPQBb+XgmPmSZLHPfB/AQxEWWiS80XUhRhycU=
Message-ID: <93a4c2ef-bc8f-0d68-477e-bb88afa37583@candelatech.com>
Date: Thu, 8 Feb 2024 08:25:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mac80211: Ensure bss-coloring is always configured
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20240130180848.776867-1-greearb@candelatech.com>
 <7c2721f79c1d6c0aa914db4f4d6148c8efce4b85.camel@sipsolutions.net>
 <ZcTzOm5dU9fPfYwC@lore-desk>
 <48e6ced8-b138-36a8-6c8b-b56127952bf9@candelatech.com>
 <ZcT5ibvlnU0ivp5s@lore-desk>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ZcT5ibvlnU0ivp5s@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1707409503-Ipi2gUAEEqcH
X-MDID-O:
 us5;at1;1707409503;Ipi2gUAEEqcH;<greearb@candelatech.com>;0c8f9bd5b2e25066af54324b55109d82

On 2/8/24 07:55, Lorenzo Bianconi wrote:
>> On 2/8/24 7:28 AM, Lorenzo Bianconi wrote:
>>>> On Tue, 2024-01-30 at 10:08 -0800, greearb@candelatech.com wrote:
>>>>> From: Ben Greear <greearb@candelatech.com>
>>>>>
>>>>> Old code would not set it to disabled, just assumed that driver
>>>>> would default to disabled.  Change this to explicitly request
>>>>> bss color be flushed on initial driver configuration.
>>>>
>>>> Arguably, the current behaviour is in line with the documentation of
>>>> BSS_CHANGED_HE_BSS_COLOR ... but I would tend to agree that
>>>> enabling/disabling coloring should be covered by it as well. Lorenzo?
>>>>
>>>>> And I think the beacon-change logic was slightly wrong, so adjust
>>>>> that as well.
>>>>
>>>> That's not a great thing for a commit message to say ...
>>>>
>>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>>> ---
>>>>>    net/mac80211/cfg.c | 10 +++++-----
>>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>>>>> index 1c7fb0959cfd..1a6c6c764cbc 100644
>>>>> --- a/net/mac80211/cfg.c
>>>>> +++ b/net/mac80211/cfg.c
>>>>> @@ -1331,8 +1331,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>>>>>    			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
>>>>>    		changed |= BSS_CHANGED_HE_OBSS_PD;
>>>>> -		if (params->beacon.he_bss_color.enabled)
>>>>> -			changed |= BSS_CHANGED_HE_BSS_COLOR;
>>>>> +		changed |= BSS_CHANGED_HE_BSS_COLOR;
>>>
>>> I think we should use beacon->he_bss_color_valid here instead of
>>> params->beacon.he_bss_color.enabled, agree?
>>
>> Either way, the value changed from un-set/un-known to some value, so why not just
>> mark it changed and flush to the driver?
> 
> IIUC what you mean here, if bss color changes from an un-set/un-known to a
> configured (valid) value, beacon->he_bss_color_valid will be true
> (he_bss_color_valid is used to indicate userspace provided a proper color for
> beacons). What is the difference?
> The other way around ("undo" some leftover color from a previous run), it
> seems a driver/fw bug, and it must be fixed there. Don't you think?

Well, no.  I think the stack should set to known state, thus my original
patch to do so.

But, not worth arguing about as it seems to have no functional difference
at this point.

Thanks,
Ben

> 
> Regards,
> Lorenzo
> 
>>
>> Thanks,
>> Ben
>>
>>>
>>>>>    	}
>>>>>    	if (params->he_cap) {
>>>>> @@ -1512,6 +1511,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>>>>>    	int err;
>>>>>    	struct ieee80211_bss_conf *link_conf;
>>>>>    	u64 changed = 0;
>>>>> +	bool color_en;
>>>>>    	lockdep_assert_wiphy(wiphy);
>>>>> @@ -1549,9 +1549,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>>>>>    		return err;
>>>>>    	changed |= err;
>>>>> -	if (beacon->he_bss_color_valid &&
>>>>> -	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
>>>>> -		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
>>>>> +	color_en = beacon->he_bss_color.enabled && beacon->he_bss_color_valid;
>>>>> +	if (color_en != link_conf->he_bss_color.enabled) {
>>>>> +		link_conf->he_bss_color.enabled = color_en;
>>>>>    		changed |= BSS_CHANGED_HE_BSS_COLOR;
>>>>>    	}
>>>
>>> this seems fine to me. >
>>> Regards,
>>> Lorenzo
>>>
>>>>>
>>>>
>>>> Not sure how this isn't updating the color itself, Lorenzo?
>>>>
>>>> johannes
>>>>
>>
>>
>> -- 
>> Ben Greear <greearb@candelatech.com>
>> Candela Technologies Inc  http://www.candelatech.com

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



