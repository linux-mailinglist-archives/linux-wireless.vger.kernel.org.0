Return-Path: <linux-wireless+bounces-5490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A689088D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6FD1C27C24
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F14436B;
	Thu, 28 Mar 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="T74uUOaY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD9374F1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651730; cv=none; b=upNv4j7HAGfCdQ1q6CjsOB3QQB3ibkxzqRUpVknNGM12I73ww7ERTAeWdOaQvgdY7tBaPPJrYJSxt/yo0KF7s8+/NIx0L8CDgi0/BH+wqQS21gwBy1FqzFN21FaHqBDKDLFPsFuEKoGcQRV/5tSb2gUi5dwBqaJ0QNUtgOI1u+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651730; c=relaxed/simple;
	bh=CmB2h6S88adzHttfAYrKSEf4TP3tIHk7MJBcg9ErpW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nke0d3hco2+tkUfL2+yCLtOQMMcpXyb3qZpZBeICCL5U56hKy7mdM63PPULQc25ve8JiNlHVGuBkxd9c0eltD75UGdnaAgmUUef1MxTld4Zzsy44wU6CqkcRRaPt9i8MSMjVAUJ3Yq1fGb1dm2Un/dlpwpBgiw7eQAd4svtSiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=T74uUOaY; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 447FF300079;
	Thu, 28 Mar 2024 18:48:40 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9B5B113C2B0;
	Thu, 28 Mar 2024 11:48:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9B5B113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711651718;
	bh=CmB2h6S88adzHttfAYrKSEf4TP3tIHk7MJBcg9ErpW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T74uUOaYaRZa3U6sZ3vv6DBvwAel+fvNMJ490xACYVZWggN/GMg2FCYhxuveMnqpp
	 O14Qn2yiY1d62Ab3F0ZBO1bfiQcTJ6KZuXxDem4n3DM88low/AviAFUbjyF3ya8XwV
	 GXaVNib8j/t2waGOsLw75wo2tkC4cb5ebaGM8Tr4=
Message-ID: <b890c308-5d66-d9cc-ebff-17e8554f9a69@candelatech.com>
Date: Thu, 28 Mar 2024 11:48:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry
 stats
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Hari Chandrakanthan <quic_haric@quicinc.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
 <20240319134522.4021062-2-quic_haric@quicinc.com>
 <d364e872eb29f03236630bab49a3243e2118ab22.camel@sipsolutions.net>
 <14699537-99b2-e468-6a7b-7b721193400e@quicinc.com>
 <b9dfab64822bacf0cc72380c0de034b79d489668.camel@sipsolutions.net>
 <68c6fcbd-0aaa-43b2-b5e2-08367c11e79d@quicinc.com>
 <f5cb9edcea875920e0ce156be76d06c78d1279ec.camel@sipsolutions.net>
 <4d569d40-d0a8-10d5-7e6d-4c9c03c14371@quicinc.com>
 <3f6de100163a8521ab09929abc537e57d26dafea.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <3f6de100163a8521ab09929abc537e57d26dafea.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1711651721-hBjz7CKCAwug
X-MDID-O:
 us5;at1;1711651721;hBjz7CKCAwug;<greearb@candelatech.com>;a91bce00847de6afce4cb86e1e327970

On 3/28/24 10:54, Johannes Berg wrote:
> On Thu, 2024-03-28 at 22:49 +0530, Hari Chandrakanthan wrote:
>> On 3/27/2024 8:37 PM, Johannes Berg wrote:
>>> On Wed, 2024-03-27 at 08:02 -0700, Jeff Johnson wrote:
>>>>> I'm also imagining that we change the API from cfg80211 to the drivers
>>>>> to get the *link* STA information, and do the summing up and/or "best"
>>>>> selection there in cfg80211 itself. However, I am prepared to accept the
>>>>> possibility that we may do _both_ in the API, if not all drivers can
>>>>> even do all of the statistics per link. We should probably still have
>>>>> the link STAs in the statistics in nl80211, but then they may not be
>>>>> populated?
>>>> First remember that there are a lot of statistics, and each driver is free to
>>>> return as many or as few as they support, indicating the ones they are
>>>> returning using the "filled" bitmap.
>>> Yes, I'd think we want to use the same data structure for both, though
>>> setting something in *both* links and *mld* would (should) be an error.
>> The statistics can be populated by driver or mac80211.(say tx retries,
>> tx packets etc)
> 
> Right.
> 
>> So we should also change the existing stats update in mac80211 on link
>> STA basis instead of deflink?
> 
> Absolutely, we need to do that, it's been on my list forever, since the
> early MLO work... I'm a bit torn between not wanting you to have to do
> all that work (even if we know that we'll have to do it) and on the
> other hand not wanting to make it worse with more statistics now ...
> There's no good middle ground here though now.
> 
>>> Good point, when they're really removed we'd want to probably keep that
>>> value as a bias for the MLD-level stats?
>>
>> ok. Then the statistics value in MLD STA would be bias + summed up value
>> of currently alive links?
> 
> I guess? But I'm not sure where we'd actually _keep_ the bias values.
> Maybe give up on that idea that cfg80211 could sum it all up, and just
> require the underlying driver (or mac80211) to report both per-link and
> total stats, where available? That way, mac80211 could keep the bias
> somewhere and just add it to the total before reporting _that_.
> 
>> On the same line , ethtool stats(*interface level stats*) in
>> mac80211(ieee80211_get_stats())
>> computes the stats by summing up the current STA statistics.
>> Here stations can come and go and the ethtool stats may not reflect the
>> total packets transmitted or received by the interface.
>> It just reflects the summed up value of current alive stations.
> 
> Yeah ... I know Ben loves it, but personally I kind of think of ethtool
> as a dead legacy interface for this respect, it just doesn't have the
> ability to reflect the required structures/hierarchy/etc. well since
> it's just a flat list. Sure you can structure the names in some way, but
> it's iffy at best. I'd just ignore that for now. If we have better
> statistics to nl80211, we can always make ethtool support on top of
> that, perhaps even moving it to cfg80211, if we even need more support
> there. I'm not hugely in favour, but if it stays contained somewhere and
> consumes existing APIs I'm OK with it.

I have my own hacks to make ethtool be minimally useful for MLO,
but I think it can be revisited later once the over-all MLO
architecture is solidified.

As Hari says, even without MLO, the AP's ethtool stats are not well
defined (it works better for STA vdevs).  Something that can also be fixed later after MLO calms down,
but my initial thought is to keep per-vdev counters that accumulate
any per-station counters and then the ethtool logic would not
try to sum the current stations but rather just grab the accumulated stats.

Thanks,
Ben

> 
>> Since these two problems are similar (ethtool stats and MLD stats
>> calculation),
>> would like to understand what type of value would be more useful to user?
>>
> 
> What do you mean by that?
> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



