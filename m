Return-Path: <linux-wireless+bounces-12760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A9D97376E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 14:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E711F211A1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CAA190676;
	Tue, 10 Sep 2024 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dvBN11br"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E21862B8;
	Tue, 10 Sep 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971634; cv=none; b=HzJtxYyoPt3UfNRU2ytfQl+MIvfJC2eZRyItPkdi7YjUmAvFPN2z0Ov/mrj8y+dYNVAQZlzkTDZ8IwllED5BAn4auZy3fSPN3xgWIgD9rdNDBM2nWlb0tDvODdUA3aNG5i4ZNfOUBNcPK2a2CYWXaZurKgkjvn2OEIShlid9k04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971634; c=relaxed/simple;
	bh=HuWj02VIN8Ocf8mbmtc1L+Bn3PmRey727QcI9q3Y6XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDC73zI/2nKaAErUmmOfHJ9U006YBKeyMb4BTCRe0X75Ksz2Ci7iHdJMXpWj/DpNRtIYkF51iF6fD8Xifwr03NRc2TLtNxEhrsOIdqpBwx/IYZ2Pp28V4kxFMEpensTbVec+tNCMXbwuJh1xNWf/2or9En3SWZ2GcmxYKaBcmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dvBN11br; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99A6C60006;
	Tue, 10 Sep 2024 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725971625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6f4Np0cokaH3gxapqx1PNtK4LPPwRh70Qjvz4BkTjXk=;
	b=dvBN11brAErEHv09m7cbuwh5HER71BmxS/ZkXlRlxAngW5e4ZfV/qsreGFOgFKUh6pXHq+
	cwaNEaMpJ0O8xXwWn+A9mrwV5WVOZYLOnZqNQhLZJolYUwRa3bZgg6a2Af7x8PBPi/zpd+
	o+oIQtffxgujc9LcKMgiD5ZQBRwY+TzYt2C2gKjOt98LM4dnLiimONbcjODe6Jo+kM9U3d
	+Ti8fmnY0y92ga5d/Oivrlpzm2yTLz6ZnZabLn/9VrXSaGBzXz7Qb1KDP3I2oqnugsG/Bz
	onda+m98m2r+rinBCE+T5S0TPgqw+Qf8X/7IHNyCnJTf6Eh1FsWx3DwKuxZ/wQ==
Message-ID: <bdc95cac-b64e-44a7-ab52-bff5dcb81b2d@bootlin.com>
Date: Tue, 10 Sep 2024 14:33:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] wifi: wilc1000: Register wiphy after reading out
 chipid
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
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
 <7a938ca9-8099-4901-9f05-c3347c38fc53@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <7a938ca9-8099-4901-9f05-c3347c38fc53@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 9/10/24 12:53, Marek Vasut wrote:
> On 9/10/24 12:08 PM, Alexis Lothoré wrote:
>> On 9/9/24 21:29, Marek Vasut wrote:

[...]

>>>   EXPORT_SYMBOL_GPL(wilc_cfg80211_init);
>>>   +int wilc_cfg80211_register(struct wilc *wilc)
>>> +{
>>> +    wilc->wiphy->features |= NL80211_FEATURE_SAE;
>>
>> Even if I get the general need, it feels weird to have parts of the wphy init
>> performed in wilc_create_wiphy, and some parts (the features field) here.
>> Wouldn't it work to just move wilc_create_wiphy content here, since wphy will
>> not be usable anyway before eventually registering it ?
> That's what I thought initially too, but look closely at wilc_create_wiphy():
> 
> struct wilc *wilc_create_wiphy(struct device *dev)
> {
> ...
> struct wiphy *wiphy;
> struct wilc *wl;
> ...
> wiphy = wiphy_new(&wilc_cfg80211_ops, sizeof(*wl));
> ...
> wl = wiphy_priv(wiphy); // <----------- HERE , *wl is struct wilc
> ...
> return wl;
> }
> 
> That 'struct wilc' is allocated as part of wiphy_new() and used all around the
> place before we reach wiphy_register() much later on.

Meh, true. We could still let any part affecting the struct wilc in
wilc_create_wiphy, and move any wphy configuration in wilc_cfg80211_register,
but then I am not sure anymore if it makes things better.

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


