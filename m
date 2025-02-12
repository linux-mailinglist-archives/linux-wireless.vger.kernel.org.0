Return-Path: <linux-wireless+bounces-18842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6ABA325BD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 13:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2B37A2F68
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533471E493;
	Wed, 12 Feb 2025 12:19:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8345271822
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362786; cv=none; b=sKQ12pu+FB2tb1zUKH4SOuRIjnVMEJhEkBJYm1tQXY7nuh7n3hQvbLj7gBjoZNIx8FZy0fXy2j0577VLLFOle8RGZHYBkmH2QJrAV0iJEizqNvGAzkDkfE+nbdDi6AvtCYuiXy22Vdj/BJcHQCLb++ridBghiv2MOWgLrfPw3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362786; c=relaxed/simple;
	bh=M540KonqvD/VTQnEskt5at/6xIqBwnW2gbQN5ZfZw/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APTL6ytAJ7n7J9Mj7f6EGMGSjv/YhSTNqrRyDrL5znRzCAN23EgxIHKSK01mzZhijGdHEw+N1qk9t+28weM129BrENCNwQBxQK8xHt4ZCBJVLU6G+YoNetI4ROlnhGWxP+ByOx0Z50z29xo6ATh738ebAQzfYFlHT/du8ZA9olU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from [IPV6:2003:c5:9711:8990::32b] (p200300C597118990000000000000032B.dip0.t-ipconnect.de [IPv6:2003:c5:9711:8990::32b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 86970FA131;
	Wed, 12 Feb 2025 13:19:41 +0100 (CET)
Message-ID: <6ccfd806-351b-4a36-8b6b-3b9cc0570585@simonwunderlich.de>
Date: Wed, 12 Feb 2025 13:19:41 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] wifi: intel: incorrect RSSI values on beacons from APs
 using legacy rates
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>, lkp@intel.com,
 johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc: sw@simonwunderlich.de
References: <20241125164034.2712936-1-ih@simonwunderlich.de>
 <93cb3283-3fb3-47be-841b-1f8586c06216@simonwunderlich.de>
 <87535bc3-16f5-4780-900f-8aa0ec6cfd64@candelatech.com>
From: Hamdi Issam <ih@simonwunderlich.de>
In-Reply-To: <87535bc3-16f5-4780-900f-8aa0ec6cfd64@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

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
Thank you for the hint.

We prefer an upstream fix, but we will look into this workaround.

Best regards,

Issam


