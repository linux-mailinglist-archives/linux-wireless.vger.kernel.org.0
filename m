Return-Path: <linux-wireless+bounces-22011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58CA9B4EE
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D671BA3DA7
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC56205E34;
	Thu, 24 Apr 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="kGlJaX2y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231C289363
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514156; cv=none; b=RoCYrlCHovqEgOObuc6syrtk2F3sG/7ZbNNbMCqKfubWiRjMO8cN7zFYAF8Fpm2MUr8k+uCaPVMwULVBQQBg3YM4pl/hbCUSQOMcM5X66dF5tyneA7jjzubocCfX5k5+clEekA1B/cUG8KeTCFkL83f08JJ3lkIFrXQubTb07sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514156; c=relaxed/simple;
	bh=9u09F66ITQXHDLlhFjmWW64UjJO95+du7MaSj7MZjqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDUV35n0fv2PTTX+5pxbte4j4FoqIZ3KhFxlzaELndk78z8Wr9lqVd/6jrSXO5qTrfxDXKJL2/3qRTq6FJkqpyyzse1uX32F2MDcKrDHbmvuG+UO2skC5N11eN/PBFHuOSG/sqnlj1Se8dLYe5y2D1z+iS2CPg1N+kaLvEvM/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=kGlJaX2y; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 879D42C72C6
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 17:02:33 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.7.64.23])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 15DA06013E;
	Thu, 24 Apr 2025 17:02:27 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2CFA6C0009C;
	Thu, 24 Apr 2025 17:02:24 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6E92013C2B0;
	Thu, 24 Apr 2025 10:02:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6E92013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1745514143;
	bh=9u09F66ITQXHDLlhFjmWW64UjJO95+du7MaSj7MZjqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kGlJaX2yGASEttiwA0pmO1eam0qh7yqvIymWtMYMMplfgYh2dYbvkEBzDsBWuPcuW
	 iBBLcVz8xbnPq2oloxJVcObcxD2a+Oyk0TT5mJtHXBO7K0+kfBojP/hq63cI98rCPd
	 I1kr3Kj9k5PaeXAOCgW1CovzhREwB7aHXHa3sT4o=
Message-ID: <927c6766-47d0-dcf6-cbe5-9da1e67292ad@candelatech.com>
Date: Thu, 24 Apr 2025 10:02:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wireless-next v6 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-5-quic_sarishar@quicinc.com>
 <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
 <c3a6b07e-007e-4168-bf8a-7b0d9ebbc913@quicinc.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <c3a6b07e-007e-4168-bf8a-7b0d9ebbc913@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1745514145-NX2EP57xiiMe
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1745514145;NX2EP57xiiMe;<greearb@candelatech.com>;535bfda298b524f45ffb92fb019ae3e8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 4/24/25 09:44, Sarika Sharma wrote:
> On 4/23/2025 10:22 PM, Johannes Berg wrote:
>> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>>> Current implementation of NL80211_GET_STATION does not work for
>>> multi-link operation(MLO) since in case of MLO only deflink (or one
>>> of the links) is considered and not all links.
>>>
>>> Therefore to support for MLO, start reorganizing sinfo structure
>>> related data elements and add link_sinfo structure for link-level
>>> statistics and keep station related data at sinfo structure.
>>> Currently, changes are done at the deflink(or one of the links) level.
>>> Actual link-level changes will be added in subsequent changes.
>>>
>>> Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
>>> structure. But to add support for station statistics at link level,
>>> change the ops to .link_sta_statistics() to fill link_sinfo structure.
>>>
>>> Additionally, move connected_time before assoc_at in station_info
>>> structure to get minimal holes.
>>> pahole summary before this change:
>>>   - size: 232, cachelines: 4, members: 23
>>>   - sum members: 223, holes: 3, sum holes: 9
>>>   - forced alignments: 1
>>>   - last cacheline: 40 bytes
>>>
>>> pahole summary after this change:
>>>   - size: 224, cachelines: 4, members: 23
>>>   - sum members: 223, holes: 1, sum holes: 1
>>>   - forced alignments: 1
>>>   - last cacheline: 32 bytes
>>>
>>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>>> ---
>>> NOTE:
>>>   - Included driver changes for fixing compilation issue.
>>
>> Does this really need to do all the changes in mac80211 and the drivers?
>>
>> OTOH maybe if not then it would cause much more back and forth?
> 
> Yes, true this patch includes only the minimum necessary changes to resolve the compilation issues in mac80211 and the drivers.
> 
> Without these changes, compilation issues will persist.
> 
>>
>>> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>>> @@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct wiphy *wiphy, struct net_device *dev,
>>>       else if (left < 0)
>>>           return left;
>>> +    sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
>>> +    if (!sinfo->links[0])
>>> +        return -ENOMEM;
>>>
>>
>> This seems rather error-prone to me.
>>
>> We already have sinfo->pertid today, allocated and freed by cfg80211,
>> and here you've added something that's allocated by the driver and freed
>> by mac80211. That seems odd in comparison?
>>
>> I'm not sure what the choices are, but I can't say I like this one ;-)
>> Maybe it's still the least bad option.
> 
> Options what I can think of here, other then above approach, may be can allocate memory during get_station() call only, in cfg80211(but this may not be memory 
> efficient as have to allocate for all possible links).
> 
> or, may be can introduce an API in cfg80211 to allocate the memory for sinfo->links, and call the API from drivers/mac80211 while filling the sinfo->links[] data.

sinfo->links[] could be an array in sinfo instead of a pointer, so whatever allocates sinfo
automatically allocates the links memory area, and then just fill in those values as needed
in the driver and ignore them in mac80211 if not filled?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



