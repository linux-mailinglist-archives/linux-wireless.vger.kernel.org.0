Return-Path: <linux-wireless+bounces-17385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438FAA0AAC9
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 17:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7A3162136
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB291BD50D;
	Sun, 12 Jan 2025 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="jjKmIluZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C6D1BD9CB
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736698491; cv=none; b=si/FVqMQdsUJVyO/upZbxz4kNf0uQbujTnR41YYgSd3bze6oYpnlR9MWMAW0r375zG9HCAZjqecwmq36XhqOsTTsUABGioh5SLfWSWu7tuJECvPPBgb45cg7VgufjtHJl3Go5do+KhdkmmvX5FJp3IEapsnoAeXLi3UAW8wlnLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736698491; c=relaxed/simple;
	bh=bK21uoMXNt7FSUXzGvf/eZtNyCCNur2P0FKFqx87MIs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kfgPnYXSOvr1kPCv3Mi3SMfqCiGWWO/AD1jO1fC2udOeUBLaDyh0KYuDAcZE6A9HqufDuc0/LMW38WV2qNCKlHDjSj/lNN677JUWsaI9nESb9r3o2NBCkBKy2QZpKBhoxEU0UQvxZ5CpfgQOb3TBB6kZsCRcBZlo3pkchdEAKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=jjKmIluZ; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <19d0ea5a-237a-48da-9d01-e380d7419101@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1736698089;
	bh=bK21uoMXNt7FSUXzGvf/eZtNyCCNur2P0FKFqx87MIs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=jjKmIluZzt6i2IMvziP8OSL7FDH8VmJds0hx/+yiX5PNL9943crOz5eqjkyjkYHEI
	 Ry3AsFWyphnj2KaUsYi69QgRZedDMJ/TJMQX+hHqjWPtWxIcYo/zOqUx0IOcQHC+Te
	 AaeuyxgI/3OFSzZc+ABEmJ0eeMfmpcH++YOvXqPQ=
Date: Sun, 12 Jan 2025 17:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance degradation with "wifi: mac80211: Drop support for TX
 push path"
From: Alexander Wetzel <alexander@wetzel-home.de>
To: Maxime Bizon <mbizon@freebox.fr>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ZEwBXkj7nwXY2cF+@sakura>
 <140bdbc3-8cb3-e7bd-13ee-fdacdf3b20da@wetzel-home.de>
 <1f5e0a66-e68e-a673-feea-d2a3baaf54d4@wetzel-home.de>
Content-Language: en-US, de-DE
In-Reply-To: <1f5e0a66-e68e-a673-feea-d2a3baaf54d4@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.23 09:36, Alexander Wetzel wrote:
...
>>> First I would like to thank you for the cleanups you are doing in
>>> mac80211, as a driver writer [1] I used to scratch my head to
>>> understand the internals.
>>>
>>> I work for a french ISP called Free, and actively maintain the
>>> software of all router/gateway devices (couple millions deployed)
>>>
>>> We have a very large number of old devices deployed that are >10 years
>>> old but on which we manage to run a mainline kernel. Those are ARM
>>> Kirkwook (armv5 1Ghz) based devices, wifi is Marvell 11n 2.4Ghz (mwl8k
>>> based) + QCA 11ac 5ghz (QCA998X/ath10k).
>>>
>>> The CPU was always a bit underpowered for the 11ac card, but I could
>>> reach ~400Mbit/s in a routing test between WAN and Wifi, 100% CPU usage.
>>>
>>> Since work started in 2019 on ath10k debloat, I applied that patch [2]
>>> to avoid performance degration.
>>>
>>> Since "wifi: mac80211: Drop support for TX push path", it's not
>>> possible to do that anymore, so I did a benchmark to see the impact,
>>> the same routing test caps at 250Mbit/s. I suppose some openwrt users
>>> will be affected also.
>>
>> Well, I guess calling wake_tx_queue and then transmitting (mostly) one 
>> packet is probably causing that. Now there are some ideas to improve 
>> that by using a kthreads. It's hidden in the discussion here:
>> https://lore.kernel.org/all/82d5623b-8d21-a8c1-e835- 
>> e446adf96cde@wetzel-home.de/
>>
>> My problem with doing that *now* is, that I'm working on a invasive 
>> patch set in mac80211. Which will really clean up the old logic and 
>> not just tweak some simple things.
>> It's mostly sorted out and written, only a few issue left till I can 
>> try it out. But I'm not getting around to wrap that up for work/ 
>> private reasons for quite some weeks (really months...) now. Rebasing 
>> and then testing the already working patches for a wake_tx_queue 
>> implementation using kthreads is something I'm hoping to avoid:-)
>>
>> Now, I've more or less already decided to add the kthread patch to 
>> that series, once I get it stabilized at its current level.
>> I have some hopes, that I can reuse the reworked PS mechanism to even 
>> simplify such an patch.

I did put the promised patch set aside for quite some time again and 
just resumed looking into them a few weeks ago.

They are now good enough that I could share patches moving TX a kthread.
So if you - or anyone else - is interested to check the performance with 
kthread TX I would wrap them up and post an RFC for that.


Alexander


