Return-Path: <linux-wireless+bounces-12702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF797238E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 22:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91F11F2268B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 20:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E626E189F33;
	Mon,  9 Sep 2024 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="SI8ycpVd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA916EB55;
	Mon,  9 Sep 2024 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913379; cv=none; b=hu+h/AcEgYJRgTRWxLb2HkHD+i8xz3mYjW411ABzSaCGRf0PKQDb/FXRPoiKiP6xEKGcz3aYlbSOUAYnGvdZeb8fJjla2rHPToZi5ofgAdqe833E5XTwLTB4bg1U+JxvOR+wcRqHGHRlDnbvVVLCrmideZbn0za/2sDwXj0Ytx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913379; c=relaxed/simple;
	bh=fym61vLnxXmDgk70up1GmkJ4kJkjM6TUHDTPoPEQZ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSl0UdoPajH3a9Dl28BZa6fDOH8VvfZzU9xSxoh/N+7LKtibTfLXxjDJBjJWVWJ4L652lr4ZLg07jgHzJx4RfQOtkOJCvIwcwvy0w48BrneF5eycuXqoARvWo+HOeUGbC0xsLWiR0nWMNvteBDbmDUscukXsTsqq4MpWMzMTIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=SI8ycpVd; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1DC4B86E61;
	Mon,  9 Sep 2024 22:22:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725913376;
	bh=gh2pbKUyt80M2vvl5LahTSASU0bun/RjZ+T7oyUJOyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SI8ycpVdcefwl+a6fifw/j7nVoXVk/vSZiyh+oMmexzbjjtSOYGLrLYcnU2zsKyuc
	 9ROQVkyiYcc9CNVWdSIAZcZe5996rGGQWMEO6X7XNHhWQoMKIkXefZ8QYOdoOxyRh8
	 hletsVMuCXl/ZyUoWZI5Zg+/ZBpPeDmqmu/8BdEf2VN6hTXKrKGhXZaQ/xC6zNeqZR
	 EEzOvNKl+b8avx9KhOKNqA8uyf1PTfm0mmrGganwqJtdXVSTZbglR/0ryDG88aifG0
	 3k+kC2fONgbho/dx55R7GRBtfJhHp8dBLv3HqZWzx4jJo1/A5cGbub5G8uzzhGcTR9
	 5UqfZAgyqwDBQ==
Message-ID: <a25ab711-2680-4bc0-a80e-40699b504903@denx.de>
Date: Mon, 9 Sep 2024 21:54:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20240829004510.178016-1-marex@denx.de>
 <20240829004510.178016-5-marex@denx.de> <87ed5tgofh.fsf@kernel.org>
 <343a45a8-1891-4e66-a77c-ad6e4d485903@denx.de> <87seu8g96u.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87seu8g96u.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/9/24 5:04 PM, Kalle Valo wrote:
> Marek Vasut <marex@denx.de> writes:
> 
>> On 9/9/24 11:35 AM, Kalle Valo wrote:
>>
>>> Marek Vasut <marex@denx.de> writes:
>>>
>>>> From: Ajay Singh <ajay.kathat@microchip.com>
>>>>
>>>> Add support for the WILC3000 chip. The chip is similar to WILC1000,
>>>> except that the register layout is slightly different and it does
>>>> not support WPA3/SAE.
>>>>
>>>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> [...]
>>>
>>>> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>>>> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>>>> @@ -313,6 +313,13 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
>>>>      	vif->connecting = true;
>>>>    +	if (sme->auth_type == NL80211_AUTHTYPE_SAE &&
>>>> +	    is_wilc3000(vif->wilc->chipid)) {
>>>> +		netdev_err(dev, "WILC3000: WPA3 not supported\n");
>>>> +		ret = -EOPNOTSUPP;
>>>> +		goto out_error;
>>>> +	}
>>> This looks wrong. If wilc3000 doesn't support SAE you shouldn't
>>> advertise NL80211_FEATURE_SAE to user space. I think the check for
>>> wilc3000 should be in wilc_create_wiphy():
>>> if (!is_wilc3000(vif->wilc->chipid))
>>
>> It is probably better to do "if (is_wilc1000(wl->chipid))" here.
> 
> Good point.
I did send v5 which grew a few more patches to address getting chipid early.

