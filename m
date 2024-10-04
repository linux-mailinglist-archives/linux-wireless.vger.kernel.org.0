Return-Path: <linux-wireless+bounces-13508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDA199026B
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 13:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8837D1F23BCD
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D8C15A863;
	Fri,  4 Oct 2024 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MnpeEdhu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119615855D;
	Fri,  4 Oct 2024 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042422; cv=none; b=u+4b+Yl1C+vM/fIwqNbZVum0nyuHxCoyWTkYOHnwbkLhFb7eksFdDWcju/BYUJMvsvHtbJo+Awz+hR5Nj+p7R7JpTLs7j+IXq2sI3OQJr2TiEm5zmcm0HaVK5B9SQFy6xYf6SSrI+nU1F+2W+D5X0ef4XORWqnACZ5c5MqHDseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042422; c=relaxed/simple;
	bh=MSrUt/mGFaTwIV2b751mjmEOT8brtJc/5Xrq29BCg7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+68IQWOTP9mmbwfT0m/2+b9mC8FJQZg33zPc2QPikNOsPF1p8bmGvVSes2Cbqc7e4XlyFaMrPORh8ZYZbtLxb4rOtuK316kfuNollz4Mfd0SPv7waBloU51AVWVQOjTj+omQNEo97VwwLOEopo6BjuoDpcswag3dfOk7Q/i7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MnpeEdhu; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B91E5889E9;
	Fri,  4 Oct 2024 13:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728042419;
	bh=H92uGph6TcS5Bfo2Az9GC/5kRSDeOxI/7YOKCr5ZL6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MnpeEdhuRXMRyLDjFxisASYDB8KW3lJWjbC7kCn6x3ThX0lUTa7uYOCKSF7PEbA53
	 tnba7CSOXEYXgN+3uRmzDFyeDby02K5+Xdhhar2m7jp5Yb34QQLrwPJOenHtrOdX5o
	 +m2mTIVhP5O5vjDmPeYWc8TeyVpNRtnbkL1Nh9stEFykColKqtVTSU0bkXGUevdZD5
	 Y3gspxqivB6TgEeYsNxpAGlAIA6mDzL8iNaRYHg0gLuEuNxPtKQtzSOJgX23QveNAT
	 kmROjcBU50ppWQMygiShjLaal0wO2mWqOF4I9GeMRfgaGLCpWzji/hr4bdZ231Zo3R
	 wzZDvo4izJJqA==
Message-ID: <75d92369-e987-4c8c-a7d0-be3e9d5b1157@denx.de>
Date: Fri, 4 Oct 2024 13:41:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] wifi: wilc1000: Register wiphy after reading out
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
References: <20241003111529.41232-1-marex@denx.de>
 <20241003111529.41232-6-marex@denx.de>
 <4912f382-5228-44ee-bf87-201f0ad28bf6@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4912f382-5228-44ee-bf87-201f0ad28bf6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/4/24 10:39 AM, Alexis Lothoré wrote:
> Hello Marek,

Hi,

> On 10/3/24 13:14, Marek Vasut wrote:
>> Register wiphy after reading out chipid, so the chipid can be
>> used to determine chip features and not advertise WPA3/SAE
>> support to userspace on WILC3000. Note that wilc_netdev_cleanup()
>> will deregister the wiphy in fail path.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>> index 11e0f8a473467..30015c5920467 100644
>> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>> @@ -1761,7 +1761,6 @@ static struct wilc *wilc_create_wiphy(struct device *dev)
>>   {
>>   	struct wiphy *wiphy;
>>   	struct wilc *wl;
>> -	int ret;
>>   
>>   	wiphy = wiphy_new(&wilc_cfg80211_ops, sizeof(*wl));
>>   	if (!wiphy)
>> @@ -1804,14 +1803,8 @@ static struct wilc *wilc_create_wiphy(struct device *dev)
>>   				BIT(NL80211_IFTYPE_P2P_GO) |
>>   				BIT(NL80211_IFTYPE_P2P_CLIENT);
>>   	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
>> -	wiphy->features |= NL80211_FEATURE_SAE;
>>   	set_wiphy_dev(wiphy, dev);
>>   	wl->wiphy = wiphy;
>> -	ret = wiphy_register(wiphy);
> 
> I think you did not address one of my comment in v5 about this change: in
> wilc_cfg80211_init (wilc_create_wiphy's caller), there is still a
> wiphy_unregister in the failure path, which does not make sense anymore since
> this function does not register wiphy anymore.
> 
> Once fixed: with this patch iw phy shows correctly on my platform that wilc3000
> does not support SAE authenticate command while wilc1000 does. And wilc1000
> still works correctly, even with wpa3.
> 
> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> Tested-on: WILC1000SD 07 SDIO WILC_WIFI_FW_REL_16_1_2
> Tested-on: WILC3000 A SDIO WILC_WIFI_FW_REL_16_1_1
Fixed in V8, thank you.

