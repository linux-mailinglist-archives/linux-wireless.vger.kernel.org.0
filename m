Return-Path: <linux-wireless+bounces-17563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9205BA1295A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 18:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299EC3A4639
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189F886348;
	Wed, 15 Jan 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="lgU/KrzC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10651791F4
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960574; cv=none; b=kSF4YpL+k8XqcLqCxLx0FttPlxklddGS0pCMIbKtfnmNmXQEb6N/hVTrsasUXSd1T4OCZ9OsniqJBCQpuEgnIboaKTLwEnckAtu4yaujSJEpB7tSppO00h6N0Mie7UMbLy1i+Y1KI7c5HqbZO9Wh39t75RspHGIKmyUj0mvc+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960574; c=relaxed/simple;
	bh=5hQSDYoG5kemTizSc2BHURHca27FwjbzlSQx85vaRZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k14BmXeVxJaZxV3MrsPuKyfDzuP+wyml5EIU+u7KCvgD/Z4SRKYJ7qxN/aSc+uUEeiOm/r3AcGi4l85KIo7IsDa+bnY72p6KdwkXzXnGbYOdZPN2hJoIWqdDNSTCoZ6gl/6uIDkDaN6ldEkrI54AzFwEqJm9UefbnW3807AG/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=lgU/KrzC; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C2A18B001A4;
	Wed, 15 Jan 2025 17:02:40 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 18ADD13C2B0;
	Wed, 15 Jan 2025 09:02:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 18ADD13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1736960552;
	bh=5hQSDYoG5kemTizSc2BHURHca27FwjbzlSQx85vaRZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lgU/KrzChy+D8ZkiiazooQiXZxfKfFVXQ8eBKBD/W5LukraTCLaPXZDwwtpOGuH4t
	 LOj4gV5n5ooGSBqqLAvJAWM3bcMZDgW69ioM0r0XrO3OYxe6AVlctt+TzRZWZlANfZ
	 B1m1laGZnDoBtKqGhHqj1eENIqoifPUJhV/eIOsI=
Message-ID: <31d7e5e7-2290-76fc-2440-16d6e5df3dca@candelatech.com>
Date: Wed, 15 Jan 2025 09:02:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 0/7] wifi: cfg80211/mac80211: add support to handle
 per link statistics of multi-link station
To: Sarika Sharma <quic_sarishar@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
 <38a7b894-9528-123a-28b8-fd9613fe4a13@candelatech.com>
 <5d5b4723-95a2-41c1-be26-534bb5ff1abe@quicinc.com>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <5d5b4723-95a2-41c1-be26-534bb5ff1abe@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1736960563-9jm2Ll2GQoG5
X-MDID-O:
 us5;ut7;1736960563;9jm2Ll2GQoG5;<greearb@candelatech.com>;535bfda298b524f45ffb92fb019ae3e8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 1/14/25 21:11, Sarika Sharma wrote:
> On 1/10/2025 10:23 PM, Ben Greear wrote:
>> On 1/9/25 20:24, Sarika Sharma wrote:
>>> Current implementation of NL80211_CMD_GET_STATION does not work
>>> for multi-link operation(MLO) since in case of MLO only deflink
>>> (or one of the links) is considered and not all links.
>>>
>>> Hence, add the link_sinfo structure to provide infrastructure
>>> for link-level station statistics for multi-link operation(MLO).
>>>
>>> Additionally, accumulated stats for MLO are included in a concise
>>> manner to provide a comprehensive overview of the ML stations.
>>>
>>> NOTE:
>>>     1. Current code changes are done to get an early feedback on design.
>>>     2. Once RFC patches are approved will add the required driver changes.
>>>     3. Ath12k changes are included in this series for reference to other
>>>        driver changes.
>>
>>> Alternate approach:
>>>     - Keep sinfo structure as it is and use this for non-ML or
>>>       accumulated statistics for ML station.
>>>     - Add link sinfo for links with only certain link specific statistics.
>>>     - Keep mac_op_sta_statistics at MLD level and let driver fill the
>>>       MLO and link level data, if driver not filling let mac80211 fill
>>>       the data.
>>>     - Corresponding changes done to embed statistics into the NL message
>>>       based on the sinfo/link_sinfo.
>>
>> My suggestions for general approach to this:
>>
>> 1)  current sinfo stats should report totals for all links,
>> but it should not sum them up at query time because links come
>> and go.  So driver/firmware/mac80211 or whatever is keeping count
>> of the stats needs to count the total tx/rx/ packets/bytes/whatever
>> as it happens.
> 
> Alternate approach is not considered here, because some fields at station level could not be much meaningful like rx_beacon, pertid ,etc.
> I believe the total count is better to do from links data in cfg80211/mac80211, as if link's data is provided it is easy to aggregate them, during query time.
> 
> Also removed link_data is maintained in implemented approach, so that could be helpful if any link go down.
> 
>>
>> 2)  Per-link stats can be over duration of the link object.
>>
>> 3)  For sinfo logic that currently reports tx/rx mcs rate and such that cannot
>> be summed, use 'best' link's for those values.  Effectively, this probably means highest
>> frequency is 'best' link.
> 
> Every fields have it's own way of best, so based on field need to check what is best for this field value? but some parameters not have much meaning at MLO 
> level like rx_beacon, pertid, etc. So keeping best of it, will be useful here?
> 
> or you mean need to check for best frequency link and take this link data as MLO data? if yes? will it be useful here?

My goal is to allow legacy user-space to report something useful for MLO netdevs, and in my opinion, reporting
tx/rx mcs rates in this case should use the highest frequency link that is active.


>> 4) Add per-link stats data that looks very much like 'sinfo' data struct and user-space
>> that can support that could then get detailed per-link stats at same time it is getting
>> per netdev 'sinfo' stats.
> 
> Again, some fields that are in sinfo structure could not be very useful at link level like generation, sta_info, etc. So keeping same structure for station 
> level and link level is not very useful, instead better to split the structure, fields for station level and some fields at link level.
> 
>>
>> 5) Assuming there will never be more than 3 links for any radios supported by Linux in the near future,
>> embed the 3 link's 'sinfo-like' stats data structure in the per-netdev sinfo stats struct
>> so that we can get all 3 link's data at same time that we are getting the other stats.
>> That should save calls into the driver and ensure that per-links stats can be gathered
>> at exactly the same time.
> 
> Yes, I agree currently it's 3 only, but everywhere we are using max-15, so explicitly keeping it 3 here isn't questionable? In future also it will not be useful.

Changing a 3 to a 4 is easy future change, and should not affect user-space API one
way or another.  If we can simplify code and stats memory allocation by using a smaller
link count for stats gathering, I think we should do that.  As soon as something supporting
more than 3 links exists, we can increase it.

But, it is not a big deal to me, so if you like the other approach, I'll not
argue further.

Thanks,
Ben

> 
>>
>> Thanks,
>> Ben
>>
> 
> Currently, addressing the comments on current implemented approach.
> 
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



