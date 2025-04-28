Return-Path: <linux-wireless+bounces-22141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB05A9F32D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 16:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7754718927AD
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB4263C71;
	Mon, 28 Apr 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FRbnJKgb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC6156677
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849414; cv=none; b=koBipInKw24Mi64gUix7QhO56CUe3lLxZ0EXUsi333hQ2B54kGJIumhD4nFB7aDcLpuMTxQcTS2YYuBI6i3zbmsJDt9PhaexinKpIR/yPPNG+Fh6o9Yo/g7Yq8lrVb0SuYsOobnolHYxxyKGLjep0O/BfSBSHsDAMGF2zRiyCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849414; c=relaxed/simple;
	bh=ER+M54+nSI4XYawSAxC0+EGZYnXt2c4bGF+Te0olAWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwZftqrVYSsZ52D1mV5XRzHCcKbUBW29bE39I4E7exwBZVGlK7hNoG3BfOYa39yLCqEYIjWFigdwNcTDllv1dATeoNk87NdgxZ2xMBr5cU21LLne+Ba8g3gG6Wu2EYA8I6fz3VXRYgOyQcpP65J2baksPt6rOmDBKwyg5l/Sq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FRbnJKgb; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8147F2C3DCB
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 14:10:11 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.7.65.200])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id CFFE960140;
	Mon, 28 Apr 2025 14:10:04 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 12292C0071;
	Mon, 28 Apr 2025 14:10:00 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.33.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 368D813C2B0;
	Mon, 28 Apr 2025 07:10:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 368D813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1745849400;
	bh=ER+M54+nSI4XYawSAxC0+EGZYnXt2c4bGF+Te0olAWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FRbnJKgbY7j04yz4jZweG/XgIyKSsW4fCs2CLBtmsf4i7zIWm/xX65Zmqqw1Hgtg9
	 nNVimnEwG7rFvbCzyYa+RSVG0dpr33pLk+GNbR3NUcxr+/4wq89xEs77/WUwYOl5M4
	 uZ4VFEBwpa+mEGV9F32F2OwPqsiRjedXXKSSpi3o=
Message-ID: <fb8e9d15-3450-4462-b6d4-994abd15f8e2@candelatech.com>
Date: Mon, 28 Apr 2025 07:09:59 -0700
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
 <595c7624-c3ab-452a-b3c1-0b14184a6691@candelatech.com>
 <6dc1f603-096f-45e8-9a28-69e414fe467a@quicinc.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <6dc1f603-096f-45e8-9a28-69e414fe467a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1745849402-SMTRjHS591oN
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1745849402;SMTRjHS591oN;<greearb@candelatech.com>;535bfda298b524f45ffb92fb019ae3e8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 4/27/25 22:20, Sarika Sharma wrote:
> On 4/25/2025 6:44 PM, Ben Greear wrote:
>> On 4/24/25 22:33, Sarika Sharma wrote:
>>> On 4/24/2025 10:32 PM, Ben Greear wrote:
>>>> On 4/24/25 09:44, Sarika Sharma wrote:
>>>>> On 4/23/2025 10:22 PM, Johannes Berg wrote:
>>>>>> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>>>>>>> Current implementation of NL80211_GET_STATION does not work for
>>>>>>> multi-link operation(MLO) since in case of MLO only deflink (or one
>>>>>>> of the links) is considered and not all links.
>>>>>>>
>>>>>>> Therefore to support for MLO, start reorganizing sinfo structure
>>>>>>> related data elements and add link_sinfo structure for link-level
>>>>>>> statistics and keep station related data at sinfo structure.
>>>>>>> Currently, changes are done at the deflink(or one of the links) level.
>>>>>>> Actual link-level changes will be added in subsequent changes.
>>>>>>>
>>>>>>> Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
>>>>>>> structure. But to add support for station statistics at link level,
>>>>>>> change the ops to .link_sta_statistics() to fill link_sinfo structure.
>>>>>>>
>>>>>>> Additionally, move connected_time before assoc_at in station_info
>>>>>>> structure to get minimal holes.
>>>>>>> pahole summary before this change:
>>>>>>>   - size: 232, cachelines: 4, members: 23
>>>>>>>   - sum members: 223, holes: 3, sum holes: 9
>>>>>>>   - forced alignments: 1
>>>>>>>   - last cacheline: 40 bytes
>>>>>>>
>>>>>>> pahole summary after this change:
>>>>>>>   - size: 224, cachelines: 4, members: 23
>>>>>>>   - sum members: 223, holes: 1, sum holes: 1
>>>>>>>   - forced alignments: 1
>>>>>>>   - last cacheline: 32 bytes
>>>>>>>
>>>>>>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>>>>>>> ---
>>>>>>> NOTE:
>>>>>>>   - Included driver changes for fixing compilation issue.
>>>>>>
>>>>>> Does this really need to do all the changes in mac80211 and the drivers?
>>>>>>
>>>>>> OTOH maybe if not then it would cause much more back and forth?
>>>>>
>>>>> Yes, true this patch includes only the minimum necessary changes to resolve the compilation issues in mac80211 and the drivers.
>>>>>
>>>>> Without these changes, compilation issues will persist.
>>>>>
>>>>>>
>>>>>>> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>>>>>>> @@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct wiphy *wiphy, struct net_device *dev,
>>>>>>>       else if (left < 0)
>>>>>>>           return left;
>>>>>>> +    sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
>>>>>>> +    if (!sinfo->links[0])
>>>>>>> +        return -ENOMEM;
>>>>>>>
>>>>>>
>>>>>> This seems rather error-prone to me.
>>>>>>
>>>>>> We already have sinfo->pertid today, allocated and freed by cfg80211,
>>>>>> and here you've added something that's allocated by the driver and freed
>>>>>> by mac80211. That seems odd in comparison?
>>>>>>
>>>>>> I'm not sure what the choices are, but I can't say I like this one ;-)
>>>>>> Maybe it's still the least bad option.
>>>>>
>>>>> Options what I can think of here, other then above approach, may be can allocate memory during get_station() call only, in cfg80211(but this may not be 
>>>>> memory efficient as have to allocate for all possible links).
>>>>>
>>>>> or, may be can introduce an API in cfg80211 to allocate the memory for sinfo->links, and call the API from drivers/mac80211 while filling the 
>>>>> sinfo->links[] data.
>>>>
>>>> sinfo->links[] could be an array in sinfo instead of a pointer, so whatever allocates sinfo
>>>> automatically allocates the links memory area, and then just fill in those values as needed
>>>> in the driver and ignore them in mac80211 if not filled?
>>>>
>>>
>>> sinfo->links[] cannot be used as an array because taking an array of IEEE80211_MLD_MAX_NUM_LINKS (15) would make the station_info structure too large, 
>>> exceeding the maximum allowed size.
>>
>> If you mean max allowed size on the stack, then you could alloc it from the heap
>> and free it when done.
>>
>> Or you could just alloc storage for 3 links for now since no radio has more than that currently.
> 
> I agree, currently it's 3 only, but everywhere we are using max-15, so explicitly keeping it 3 here isn't questionable?
> Also, in future it will not be useful approach, when we need to increase the links(that time we have to change this to pointer instead of array).

You can change allocation scheme in the future easily enough, and maybe there will never exist any linux
driver with more than 3 links anyway?  And you can allocate quite large amounts of memory in the kernel,
so you could always have it a single struct if you wanted.

Anyway, Johannes makes the real decisions on this, so hopefully you can get his approval before you
code something up he dislikes, I was just voicing my suggestion.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


