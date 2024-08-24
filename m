Return-Path: <linux-wireless+bounces-11890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D995E009
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212851F21B7A
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F11D7DA9C;
	Sat, 24 Aug 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="DfxGp94y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F588A94A;
	Sat, 24 Aug 2024 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724535303; cv=none; b=hw4Q6NBLsKMAPhALK/a4tUJH0xEBBUPYzjY9F9ly1yKShK5SWLc6LDOGisQ5gz5/iyAJuulf6esPjfMQEBja0+/P3uAED9oppET+iPfB/mxyZA3xApERG8squHvnLzSfaHD+d/lIqDofILz4IjMIhP3SRyxb4CJNr3w+k3dSYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724535303; c=relaxed/simple;
	bh=05h4flYVxYVmDr5sJI4fGsGtV6KOkCLCZzt3EJ1tz/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeIgTVjtJ+rs9YvNFH8lsNmDHktE06ZsaQAcglOk5OAaSfYYx6b0MbsPzncOdKJb4jWvztPs6GVn6fYoEyrGO69olEd/8SpPjSlzyOU1n8L5thNjCNQvRGZ0vGx3YXgBQ0eCzfDesrzLU1GMzlmhMPtJWhI3Un08YOq4r7eHgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=DfxGp94y; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 558E78877E;
	Sat, 24 Aug 2024 23:34:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724535293;
	bh=ajQwuj+W+LQ2qCUTuDOWr6FOmcNHRSVOPqLao3goEEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DfxGp94yy2tTS59G96xZA7+vK7VpoKG6Ig/Yqt1rb2JYvDvyIw0+wyhGbzrLv8Ao8
	 oCH/Z5VolzlLkek2lG6FJqvR8znfREcVlMOo8Ev7UitnxYhUBDncvH3JOaaJ9Ek0bj
	 cwPBLkNBggKwz5IaIB8oJRePfXXPiUO+yudA+o6HKlg/V+0Y5P0MAXmHxMvPtTZZfj
	 Fp6rMIWy7qmjL70WV/9o+RrwWmJulz/OeBtOl1RkJ/myvVRZVnqSLZkubDMcFqQP7R
	 +hSLiUpFYvwV6hfGuBfjy70ID9SoonGCYmw86X49FX6s3omF+7558KW0bmeTONq6oY
	 z5Hqo6YAeNCTQ==
Message-ID: <5e972d13-357c-41a1-ab5f-95b898ea154b@denx.de>
Date: Sat, 24 Aug 2024 23:18:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
To: Simon Horman <horms@kernel.org>
Cc: linux-wireless@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-2-marex@denx.de> <20240823174630.GD2164@kernel.org>
 <006098a3-efb5-4bf3-a28c-20702597feaa@denx.de>
 <20240824124430.GI2164@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240824124430.GI2164@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/24/24 2:44 PM, Simon Horman wrote:
> + Dan
> 
> On Fri, Aug 23, 2024 at 10:38:59PM +0200, Marek Vasut wrote:
>> On 8/23/24 7:46 PM, Simon Horman wrote:
>>> On Fri, Aug 23, 2024 at 06:08:57PM +0200, Marek Vasut wrote:
>>>> Do not use wilc_get_chipid() outside of wlan.c . Instead, call
>>>> wilc_get_chipid() right after the SDIO/SPI interface has been
>>>> initialized to cache the device chipid, and then use the cached
>>>> chipid throughout the driver. Make wilc_get_chipid() static and
>>>> remove its prototype from wlan.h .
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>
>>> ...
>>>
>>>> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
>>>
>>> ...
>>>
>>>> @@ -1535,9 +1537,18 @@ int wilc_wlan_init(struct net_device *dev)
>>>>    	if (!wilc->hif_func->hif_is_init(wilc)) {
>>>>    		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
>>>>    		ret = wilc->hif_func->hif_init(wilc, false);
>>>> +		if (!ret)
>>>> +			chipid = wilc_get_chipid(wilc);
>>>>    		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
>>>>    		if (ret)
>>>>    			goto fail;
>>>> +
>>>> +		if (!is_wilc1000(chipid)) {
>>>> +			netdev_err(dev, "Unsupported chipid: %x\n", chipid);
>>>> +			return -EINVAL;
>>>
>>> Hi Marek,
>>>
>>> Should this unwind as is the case elsewhere in this function?
>>
>> It should, will fix in V3, thanks.
>>
>>> 			ret = -EINVAL;
>>> 			goto fail;
>>>
>>> Flagged by Smatch.
>>
>> What's the trick here ?
> 
> Smatch is here. I don't think there is much of a trick other than running it :)
> 
> https://github.com/error27/smatch

Thanks !

