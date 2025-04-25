Return-Path: <linux-wireless+bounces-22069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2D3A9C9DF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DFE9E378E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2B324BC10;
	Fri, 25 Apr 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="k6QbSyoW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208124BCEA
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586879; cv=none; b=FUIM8JtIHVIUsNJSsZd/NLYKAJkw/mQ16Ei9fpHCJ+6U04PbqTgCSw/Svl6/NoLfSqUJMB498PAItN8P5NBRdrY2oMpZBikrPAvW76ZJGoOwiVVuyYg2PywSTEZE7SaC5KLajX48agtxPz5iioQo6QGYEDa3iwH6HwpDkd+XqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586879; c=relaxed/simple;
	bh=/s2S2E4DRxL6wPeutRskSlyShEm4JPSgzpMUgNd5OXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aj+zKs+sEroBXSbZZ8wUgMFXigDosgGcfyskTrrFBS9Z6SIq/Ngr5CnKRICQ0baXgkc58xnmgp2vT8ZaAV1rJgyZEqbGYtSXlW0JrySR5gl5YpzSzhoGM2wtSQGV/k8jBFn0nWi+ZMj07aMt6ghXZcf9D3imfhpu5QtG0gm71PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=k6QbSyoW; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.236])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 19571600BF;
	Fri, 25 Apr 2025 13:14:37 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D0BD1C0073;
	Fri, 25 Apr 2025 13:14:33 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.33.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 5701D13C2B0;
	Fri, 25 Apr 2025 06:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5701D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1745586873;
	bh=/s2S2E4DRxL6wPeutRskSlyShEm4JPSgzpMUgNd5OXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k6QbSyoWFkfOABX51zWQxzat/mXgjuGEaTAfSwlZmxPZh1sDDXUYUjzKLJ3ZCpTcV
	 I2wwc03jhKGLf2JHb3TtTT4ZssNsJFv2kYuKHYs7kF5MF8YrqDPtIm1NC6oyrXxZvs
	 alQppdqUfVclh5rWKvvPFeM0mZpzRTRbhaa35SBU=
Message-ID: <595c7624-c3ab-452a-b3c1-0b14184a6691@candelatech.com>
Date: Fri, 25 Apr 2025 06:14:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
To: Sarika Sharma <quic_sarishar@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-5-quic_sarishar@quicinc.com>
 <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
 <c3a6b07e-007e-4168-bf8a-7b0d9ebbc913@quicinc.com>
 <927c6766-47d0-dcf6-cbe5-9da1e67292ad@candelatech.com>
 <c7d093ce-11fd-44e2-ab23-6ad5a3e4bb64@quicinc.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <c7d093ce-11fd-44e2-ab23-6ad5a3e4bb64@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1745586874-UXFSNXd_GuLM
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1745586874;UXFSNXd_GuLM;<greearb@candelatech.com>;535bfda298b524f45ffb92fb019ae3e8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 4/24/25 22:33, Sarika Sharma wrote:
> On 4/24/2025 10:32 PM, Ben Greear wrote:
>> On 4/24/25 09:44, Sarika Sharma wrote:
>>> On 4/23/2025 10:22 PM, Johannes Berg wrote:
>>>> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>>>>> Current implementation of NL80211_GET_STATION does not work for
>>>>> multi-link operation(MLO) since in case of MLO only deflink (or one
>>>>> of the links) is considered and not all links.
>>>>>
>>>>> Therefore to support for MLO, start reorganizing sinfo structure
>>>>> related data elements and add link_sinfo structure for link-level
>>>>> statistics and keep station related data at sinfo structure.
>>>>> Currently, changes are done at the deflink(or one of the links) level.
>>>>> Actual link-level changes will be added in subsequent changes.
>>>>>
>>>>> Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
>>>>> structure. But to add support for station statistics at link level,
>>>>> change the ops to .link_sta_statistics() to fill link_sinfo structure.
>>>>>
>>>>> Additionally, move connected_time before assoc_at in station_info
>>>>> structure to get minimal holes.
>>>>> pahole summary before this change:
>>>>>   - size: 232, cachelines: 4, members: 23
>>>>>   - sum members: 223, holes: 3, sum holes: 9
>>>>>   - forced alignments: 1
>>>>>   - last cacheline: 40 bytes
>>>>>
>>>>> pahole summary after this change:
>>>>>   - size: 224, cachelines: 4, members: 23
>>>>>   - sum members: 223, holes: 1, sum holes: 1
>>>>>   - forced alignments: 1
>>>>>   - last cacheline: 32 bytes
>>>>>
>>>>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>>>>> ---
>>>>> NOTE:
>>>>>   - Included driver changes for fixing compilation issue.
>>>>
>>>> Does this really need to do all the changes in mac80211 and the drivers?
>>>>
>>>> OTOH maybe if not then it would cause much more back and forth?
>>>
>>> Yes, true this patch includes only the minimum necessary changes to resolve the compilation issues in mac80211 and the drivers.
>>>
>>> Without these changes, compilation issues will persist.
>>>
>>>>
>>>>> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>>>>> @@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct wiphy *wiphy, struct net_device *dev,
>>>>>       else if (left < 0)
>>>>>           return left;
>>>>> +    sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
>>>>> +    if (!sinfo->links[0])
>>>>> +        return -ENOMEM;
>>>>>
>>>>
>>>> This seems rather error-prone to me.
>>>>
>>>> We already have sinfo->pertid today, allocated and freed by cfg80211,
>>>> and here you've added something that's allocated by the driver and freed
>>>> by mac80211. That seems odd in comparison?
>>>>
>>>> I'm not sure what the choices are, but I can't say I like this one ;-)
>>>> Maybe it's still the least bad option.
>>>
>>> Options what I can think of here, other then above approach, may be can allocate memory during get_station() call only, in cfg80211(but this may not be 
>>> memory efficient as have to allocate for all possible links).
>>>
>>> or, may be can introduce an API in cfg80211 to allocate the memory for sinfo->links, and call the API from drivers/mac80211 while filling the sinfo->links[] 
>>> data.
>>
>> sinfo->links[] could be an array in sinfo instead of a pointer, so whatever allocates sinfo
>> automatically allocates the links memory area, and then just fill in those values as needed
>> in the driver and ignore them in mac80211 if not filled?
>>
> 
> sinfo->links[] cannot be used as an array because taking an array of IEEE80211_MLD_MAX_NUM_LINKS (15) would make the station_info structure too large, exceeding 
> the maximum allowed size.

If you mean max allowed size on the stack, then you could alloc it from the heap
and free it when done.

Or you could just alloc storage for 3 links for now since no radio has more than that currently.

Thanks,
Ben

> 
> Instead, we can use the earlier method (define deflink(link_station_info) for non-MLO and use the same), but Johannes did not favor that approach, so I avoided 
> providing this as an additional option.
> 
>> Thanks,
>> Ben
>>
> 
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


