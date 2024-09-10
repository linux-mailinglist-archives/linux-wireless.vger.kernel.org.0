Return-Path: <linux-wireless+bounces-12755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556979735A9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1664128DC8E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5018C003;
	Tue, 10 Sep 2024 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="sQtFE6T6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D84178367;
	Tue, 10 Sep 2024 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965694; cv=none; b=dyGM5LcOTwxyLpxHcq9bVbfptF+vljNXbMAeHDDaX7Qob5RkmM4W83lsGbwZUuZOaz/1OtD0l+Fvrj06i5G9oDva8Ip4v/FHLnSi3ZtLEdrkrUgSPraZbwE//O/I3+up6Qjehj09H9Zib1/JUF0Uk640bVQiVql4NH3hXg1RVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965694; c=relaxed/simple;
	bh=nTshTYXDuoRsJjBDBn9k4Vfdcx08sJyuyY/rUgJxXAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=br5QOJy/LjyMKKQHOKNsyRzUOV/dGER1ZEpW9C+ha8J5VMp90nlgdV9dgAlKDsAHRMlFPRD7ah1KV9jX69FmpiUC3fwr+kpStuOev0p0DayHfHj4SbCQ90tRmg1AtnjzKu+Y9XC83mGubxSSI7Cr1QL9qBESId41dsSLmq+y/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=sQtFE6T6; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 56C5189038;
	Tue, 10 Sep 2024 12:54:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725965691;
	bh=H9Pt/1b3LY4StMRpPEsQErPs1e6om5K3JEvYE7BLC0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sQtFE6T6oTdvf2r1z42sRsmVIj6a2PjCBkQfolqg3JrFdzWxEaahaHErOy0zUbsot
	 8LqE5TrYZjF8Dt4uLBlbadjJtgejjuurB4I8C5ko3atLJ/gzjLGDg1UAnKSMPhekFh
	 a9IsBfG9zeo40vXRaP3GeNEpKMGI1nCFiUH7zP1Il1FPTYf1X9L6E9kfTe6jm53tj0
	 EAJ0Yrcm1U3z9WKMBuXDVdsEp/kKUaX/5toEHqNc9XUYC0RWWjoqylXawFoBabswpP
	 rL9ML6v2XC3YuWxG5PzzSmepa7eowe0GaR5xa5CPYs0L1QRAX9skmyE36fZuVOY85z
	 s9hraZCaMxwLQ==
Message-ID: <7a938ca9-8099-4901-9f05-c3347c38fc53@denx.de>
Date: Tue, 10 Sep 2024 12:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] wifi: wilc1000: Register wiphy after reading out
 chipid
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240909193035.69823-1-marex@denx.de>
 <20240909193035.69823-8-marex@denx.de>
 <769f1405-62fc-4457-a958-b644c706140f@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <769f1405-62fc-4457-a958-b644c706140f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/10/24 12:08 PM, Alexis Lothoré wrote:
> On 9/9/24 21:29, Marek Vasut wrote:
>> Register wiphy after reading out chipid, so the chipid can be
>> used to determine chip features and not advertise WPA3/SAE
>> support to userspace on WILC3000. Note that wilc_netdev_cleanup()
>> will deregister the wiphy in fail path.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [...]
> 
>> @@ -1804,14 +1803,8 @@ static struct wilc *wilc_create_wiphy(struct device *dev)
>>   				BIT(NL80211_IFTYPE_P2P_GO) |
>>   				BIT(NL80211_IFTYPE_P2P_CLIENT);
>>   	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
>> -	wiphy->features |= NL80211_FEATURE_SAE;
>>   	set_wiphy_dev(wiphy, dev);
>>   	wl->wiphy = wiphy;
>> -	ret = wiphy_register(wiphy);
>> -	if (ret) {
>> -		wiphy_free(wiphy);
>> -		return NULL;
>> -	}
> 
> If I am reading the patch correctly, there are still some failure paths in
> wilc_cfg80211_init which try to call wiphy_unregister on the (not registered
> anymore in there) wphy.
>>   	return wl;
>>   }
>>   
>> @@ -1861,6 +1854,14 @@ int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
>>   }
>>   EXPORT_SYMBOL_GPL(wilc_cfg80211_init);
>>   
>> +int wilc_cfg80211_register(struct wilc *wilc)
>> +{
>> +	wilc->wiphy->features |= NL80211_FEATURE_SAE;
> 
> Even if I get the general need, it feels weird to have parts of the wphy init
> performed in wilc_create_wiphy, and some parts (the features field) here.
> Wouldn't it work to just move wilc_create_wiphy content here, since wphy will
> not be usable anyway before eventually registering it ?
That's what I thought initially too, but look closely at 
wilc_create_wiphy():

struct wilc *wilc_create_wiphy(struct device *dev)
{
...
struct wiphy *wiphy;
struct wilc *wl;
...
wiphy = wiphy_new(&wilc_cfg80211_ops, sizeof(*wl));
...
wl = wiphy_priv(wiphy); // <----------- HERE , *wl is struct wilc
...
return wl;
}

That 'struct wilc' is allocated as part of wiphy_new() and used all 
around the place before we reach wiphy_register() much later on.

