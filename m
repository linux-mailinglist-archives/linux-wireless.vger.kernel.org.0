Return-Path: <linux-wireless+bounces-20003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B17A56D5A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 17:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75E23A93F0
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0DB224AF1;
	Fri,  7 Mar 2025 16:16:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993D23817D
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364198; cv=none; b=PWQs6IBYZu7pklRzAiXN4EJJNshGTwlG8W1qPLFfOenVlFn8XPjSmp3PZao4K7aDHFIolXUdILSa0A2LSQiPs/xaQT+GoSY9SWYJ/92cLvmYvcAMDP6KOFI9L4QLyPVt0LC/MoxDRZFj8OmZ7mLb/wuyjTqurs0XVrkkh6iOuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364198; c=relaxed/simple;
	bh=EIYJ7Tw23PJwShD2o2bb273liU7svjuxdjWArDwFWeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Grp9yz6iPaRp7+72MMfGth9azAHGpEdnc6EwA2c6OiuDZkWvftOyTA4jFglZi/BEnK2cEFwnSN5RQNA2nfjq1eo/9zVM4nLcTmNWdC6stsPVlKC3LKEPJmVxbd/853dHCrZu6fmHY1Wy9zULq9d5Wd7Yq5B+/TtT9dabGECTUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from [IPV6:2003:c5:970a:9690::32b] (p200300c5970a9690000000000000032B.dip0.t-ipconnect.de [IPv6:2003:c5:970a:9690::32b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C1A64FA131;
	Fri,  7 Mar 2025 17:07:05 +0100 (CET)
Message-ID: <218c5d56-360b-49cf-b1a5-54ab32daa070@simonwunderlich.de>
Date: Fri, 7 Mar 2025 17:07:04 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] wifi: intel: incorrect RSSI values on beacons from APs
 using legacy rates
To: Ben Greear <greearb@candelatech.com>, lkp@intel.com,
 johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc: sw@simonwunderlich.de
References: <20241125164034.2712936-1-ih@simonwunderlich.de>
 <93cb3283-3fb3-47be-841b-1f8586c06216@simonwunderlich.de>
 <87535bc3-16f5-4780-900f-8aa0ec6cfd64@candelatech.com>
Content-Language: en-US
From: Hamdi Issam <ih@simonwunderlich.de>
In-Reply-To: <87535bc3-16f5-4780-900f-8aa0ec6cfd64@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Thank you Ben.

We tried the patch in [1] and it works for us, now we are getting the 
correct values of RSSI from the APs with the legacy rates.

Regards,

Issam

[1] 
https://github.com/greearb/linux-ct-6.14/commit/401a9ee5b9b0a759325d9d3750e868c96fdaf17e

On 2/12/25 02:26, Ben Greear wrote:
> On 2/11/25 8:58 AM, Hamdi Issam wrote:
>> Hello,
>>
>> I have opened a ticket 
>> (https://community.intel.com/t5/Wireless/wifi-intel-incorrect-RSSI-values-on-beacons-from-APs-using/m-p/1647584#M57080) 
>> on the intel support community about this issue, but the Linux OS is 
>> unsupported by them.
>>
>> Does anyone have any ideas on how to further debug this issue or what 
>> might be causing it?
>
> I'm not sure about this specific issue, but if you feel like using 
> out-of-tree patches
> that are never likely to make it upstream, you can find patches in our 
> tree that disables
> the Intel firmware's beacon filtering (and beacon RSSI reporting)
> and then does the RSSI calculation in the driver.  It is not a small 
> change and might
> have some weird dependencies on other stuff in our tree.
>
> That fixed some inaccuracies that we found, but it may have draw-backs 
> that I'm
> not aware of.
>
> https://github.com/greearb/linux-ct-6.13
>
> Thanks,
> Ben
>

