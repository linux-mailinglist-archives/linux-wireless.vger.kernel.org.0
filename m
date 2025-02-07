Return-Path: <linux-wireless+bounces-18630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F4A2C2A9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 13:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20701886915
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8481DFE04;
	Fri,  7 Feb 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="FJo4EcMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9314E1DE2D7
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738931237; cv=none; b=njqT485JZgeuKdwWk6jF1GAq/b0bLn1UkIUWySexrA/I6jjo1FqSFzJKhqoVyN6M4mAcqliC8Hek3COjhfpSEDqwGtbWIxSudoyTFPcVHvcprU6g56NUj8CGQ4rN8n7lmJmAVK4Ugti6300dxIb5DikdFUgqzyovuSiA2cR8J5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738931237; c=relaxed/simple;
	bh=AIMXKWyoVG5FEx2uWqzzS+/XJUIHEFOGP/Xz9eIZJSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThNMfDbf9uZ5SdM7cIhsHeBaS2CYpNoyyFnuRj/evdjfRlA8i+BMk/INnDyu1iwvyL6AxC0elZJpLGqPjNqOsz70bbwhJnBIEhyaEqfMeXLxJs3enUCpg+npfZVl8ATZebp1MsAHegwTFpHeIJB0g9h7LG0t98m3UxWAyKOH3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=FJo4EcMp; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <8484dcdf-d3b1-4d36-8b56-6d4f381bda53@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1738931224;
	bh=AIMXKWyoVG5FEx2uWqzzS+/XJUIHEFOGP/Xz9eIZJSE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FJo4EcMpVy3dCnPLcu27Smo7U7wCFCicHP7qqCAS1C/C5Se7pvM96t++6TBx62zX/
	 flhpgUo+wiPDXY+EI3YN175jjiV7hyPUx6IXr7Byv4GKmKljxDpKS5snUsaVsHs4MB
	 ScKv0JMXrEY/a9xC063cG8pUExGB91Zv3JxMHEZw=
Date: Fri, 7 Feb 2025 13:27:04 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: nl80211/cfg80211: Stop supporting cooked
 monitor
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org,
 Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
References: <rk6oogifmfbtboifgyzluw7cu2t6i3xdtf7qtrt2suil7t7nay@binkah2qe22o>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <rk6oogifmfbtboifgyzluw7cu2t6i3xdtf7qtrt2suil7t7nay@binkah2qe22o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.02.25 11:37, Fedor Pchelkin wrote:
> Alexander Wetzel wrote:
>> I first tried to just refuse setting the flag in mac80211, but that
>> triggered a warning in nl80211 when rdev_add_virtual_intf() got the
>> error after green-lightening the flags in nl80211_parse_mon_options().
>>
>> So we could add some code in nl80211 suppressing the warning when
>> MONITOR_FLAG_COOK_FRAMES is set. That would open up drivers to refuse
>> cooperation when someone tries to use the flag.
> 
> Is that the same WARNING which is being fixed at [1] or something new?
> 

While the patch here also kind of solves the issue from [1] it's unrelated.
The warning I mentioned above was a different one. But since it was 
caused by experimental code never published noting I would call "new".

I tried to explain that mac80211 - or any other driver using nl80211 - 
can't refuse the cooked monitor flag with the current API to explain the 
brutal handling of that in the patch here.
(The flag check should be handled within nl80211_parse_mon_options(). 
But since the drivers have no way to signal cooked monitor support it 
can't be checked there by any reasonable means.)

Here the WARN() my patch triggered:

         wdev = rdev_add_virtual_intf(rdev,
                              nla_data(info->attrs[NL80211_ATTR_IFNAME]),
                                 NET_NAME_USER, type, &params);
         if (WARN_ON(!wdev)) {
                 nlmsg_free(msg);
                 return -EPROTO;

My not published patch refused the flag when rdev_add_virtual_intf() was 
creating the interface with the flag.

With the feedback from Johannes - that only mac80211 ever used cooked 
monitor mode - the current patch seems to be the preferred way and we 
don't have to find a better - and for sure ugly - way to handle that.


> FWIW, I think the current series would not go to the stable trees (at
> least there are no Fixes ot Cc: stable tags), while [1] should go there
> to suppress the currently observed and triggerable WARNING regarding
> setting the outdated cooked monitor mode mixed with some other modes.
> 

I also would not like to drop cooked monitor support for any stable 
kernel. While that would fix some monitor handling issues I see no real 
need to even fix these in the stable series.
Messung up virtual monitor interfaces by a special order creating them 
or using suspend/resume is hardly something the users of them will care 
about. Or they would have told us that long ago:-)


> [1]: https://lore.kernel.org/linux-wireless/20250131152657.5606-1-v.shevtsov@mt-integration.ru/

Alexander

