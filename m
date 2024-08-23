Return-Path: <linux-wireless+bounces-11873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E4B95D803
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 22:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC92C1C229BB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612EB1C7B79;
	Fri, 23 Aug 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="P+xxtCB6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33E1C8234;
	Fri, 23 Aug 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724446053; cv=none; b=IBbY4p/H9BvhsQokdC3CUPC3qPIHmwo6KLhgSS3Tv3Bs/Qv3F1v3pNnifJW2uKrKoaWqD1FrWF2aw0kw/FADdVvKFAYMcn7gMwKaIzzI2C1WTl1pgRPwNFtYpFhaxrEl8x1Rktw4ZAV2WR2M6iXKfhMIHWtqZN3pfeCFyLtTpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724446053; c=relaxed/simple;
	bh=SFA6OhGdvYnzGuHtrbwbU2aV2URqe9+O3zDiDLa1+nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vnzz2n/q9T8MJhnIvmH7Dv6hYpH8EYpzAjMaLmyY6RNddrI67xJDWCYB/1/Nnm7aIdt34Pgfg+6fLh+ZrAWnTBuWpVs2pVP4x3YPZ+nPSy9NIEOdfjM3kXjGOmUIudLdhBbQKgZo5HE7AMSLBjjFbdMd9E/+ZwKHbWQ9Kjy2wJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=P+xxtCB6; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CBB5188936;
	Fri, 23 Aug 2024 22:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724446049;
	bh=o8jsv7hRh9bwtKvqiYHYxwW6UBK6950W5nDdHWSrMQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P+xxtCB6nvqufyhuTkiaH/awWvXgtKcCDdfIuzE6AXYOJ1XfYzQyk9RTsQsXUn7VJ
	 jsLpaHbQhTL0+0lw8RPSEG0p5lPDhKpUqOKleQ/eWXoZpl7LWJ5nlXZk8iMSdnV8EO
	 IUbWFwh/qOlevr5gb0MF8qOj0lhBUr+09+E/p5MH5VN+CSfukRPliZyef9upQEW+fA
	 us5A6tcjjI6lQ/iDWYeQNMs8GuqYcIJ7oXQ3CMi9XyjMP7yo5aGzBhRewr2q8vV81A
	 Wwf5QIv5whYUfaDgNQIJMdAlhQZ6LFXC/BdF6s1iyws+jtgVBdvmoU6QpXTl7PUl7E
	 i9Q6jsDhVhXig==
Message-ID: <006098a3-efb5-4bf3-a28c-20702597feaa@denx.de>
Date: Fri, 23 Aug 2024 22:38:59 +0200
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
 netdev@vger.kernel.org
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-2-marex@denx.de> <20240823174630.GD2164@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240823174630.GD2164@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/23/24 7:46 PM, Simon Horman wrote:
> On Fri, Aug 23, 2024 at 06:08:57PM +0200, Marek Vasut wrote:
>> Do not use wilc_get_chipid() outside of wlan.c . Instead, call
>> wilc_get_chipid() right after the SDIO/SPI interface has been
>> initialized to cache the device chipid, and then use the cached
>> chipid throughout the driver. Make wilc_get_chipid() static and
>> remove its prototype from wlan.h .
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> ...
> 
>> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
> 
> ...
> 
>> @@ -1535,9 +1537,18 @@ int wilc_wlan_init(struct net_device *dev)
>>   	if (!wilc->hif_func->hif_is_init(wilc)) {
>>   		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
>>   		ret = wilc->hif_func->hif_init(wilc, false);
>> +		if (!ret)
>> +			chipid = wilc_get_chipid(wilc);
>>   		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
>>   		if (ret)
>>   			goto fail;
>> +
>> +		if (!is_wilc1000(chipid)) {
>> +			netdev_err(dev, "Unsupported chipid: %x\n", chipid);
>> +			return -EINVAL;
> 
> Hi Marek,
> 
> Should this unwind as is the case elsewhere in this function?

It should, will fix in V3, thanks.

> 			ret = -EINVAL;
> 			goto fail;
> 
> Flagged by Smatch.

What's the trick here ?

