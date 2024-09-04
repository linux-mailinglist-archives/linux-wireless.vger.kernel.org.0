Return-Path: <linux-wireless+bounces-12485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F26196C0A9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9609B1C251F3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DEB1DC1BE;
	Wed,  4 Sep 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VqVNIVqU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD51DC07E;
	Wed,  4 Sep 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460342; cv=none; b=ZNwjb5KzdyXU3NoxCI/hSL5cDryXcHUJNXidT7sZnbUrn/mALU3BvrC9Xk7lKEeVPqsZPhK2O43hVaj3+rfNN6RSzPLOi94NwmQ9JFbCjm20SKCTKi0CIzNjZSwrBRDetlO7Pym0lZjPr2bzcq8UcgKZgy+p93iGL8dbWVkMPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460342; c=relaxed/simple;
	bh=Yro6c6PmezwPavyduv1RlKWA15hTf9IKGGuvHCMw8x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKReLiknL6a9jTIKHeYOH/ST9UPPIEI7W5EYymbpwjb9PzK0GWZIgdavDbEI1/1zcyYod5J7FthFA4qHcPJQ7w6ju0pLB3qfVA9SRe7hGT69uIIwRlJWWTLAnGBxvCZRSj3ZHE+pnLosBUsgoVM0523GmvakuvlxvIQwcqg2W+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VqVNIVqU; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 088F4FF803;
	Wed,  4 Sep 2024 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725460337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gHbIC9zWHgKFfK6RJ+EjBW+ThiCH2NjY3SZ4ktPpSk=;
	b=VqVNIVqUZl8c8Naw3DjPBeA4A8fEELsws3oUvlnA+JvSZsBn3kTZ4s6sjg6gNcL93FPjdp
	QgiWNRDdkfhWmHJ6wivhfUlCSsmCdNK7VIz8/U+O4zVxRr7LmTWcp7P/o8L5kdOUgAbKMQ
	oCSc86SAv6bqXSzm+LgmCnA8zJ5fgQhECGLQctLb69W/DYvV2KbasauDnITanFYWuEwfli
	0E+a97rXr2mHyuRiEHccUK1XFp1UR8sKTsCsGwyN4RA4wpw9SA51jSapYsGOCqmNgoKHI9
	VSfgRrsZj01QGEcOqdGpOU4FI/VLpvbM4XRlN/ChwVC19NdjQodhZwFSkRpdsw==
Message-ID: <f7572a63-73e0-4d1c-af04-6930e4bdc84f@bootlin.com>
Date: Wed, 4 Sep 2024 16:32:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: wireless: wilc1000: Document WILC3000
 compatible string
To: Krzysztof Kozlowski <krzk@kernel.org>, Marek Vasut <marex@denx.de>,
 linux-wireless@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240829004510.178016-1-marex@denx.de>
 <52e7b6d2-5d31-4ae1-bf1d-44e63a22774d@bootlin.com>
 <c84b783a-0118-43d8-8f03-a98fdf5bd8c5@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <c84b783a-0118-43d8-8f03-a98fdf5bd8c5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Krzysztof,

On 9/3/24 20:47, Krzysztof Kozlowski wrote:
> On 03/09/2024 18:09, Alexis Lothoré wrote:

[...]

>> After considering multiple solutions to try to share this bus between existing
>> wlan driver and a new bt driver (mfd device, auxiliary bus, device link + some
> 
> Driver design should not have impact on bindings.
> 
>> handles, etc), my current best guess is to convert wilc driver to a MFD driver
>> for wilc3000. I guess some work can be done so that the driver can still be
>> shared between wilc1000 and wilc3000 _while_ remaining compatible with current
>> wilc1000 description, but it would impact the DT description for wilc3000, which
>> would need to switch from this:
>>
>>   spi {
>>     wifi@0 {
>>       compatible = "microchip,wilc3000";
>>       [...]
>>     };
>>   };
>>
>> To something like this:
>>
>>   spi {
>>     wilc@0 {
>>       compatible = "microchip,wilc3000"; /* mfd driver */
> 
> I do not see any reason why... or rather: What is MFD here? MFD is Linux
> stuff and we talk about hardware.
> 
>>       wifi {
>>         compatible = "microchip,wilc3000-wlan";
> 
> Why? Just merge it to parent...
> 
>>         [...]
>>       };
>>       bt {
>>         compatible = "microchip,wilc3000-bt";
>>         XXXX; /* some link to the uart controller connected to the chip */
> 
> That's not how we represent UART devices. I don't understand why do you
> need these - if for power sequencing, then use power sequencing
> framework and describe associated hardware (there are some talks coming
> about it in 2 weeks). If for something else, then for what?

I have to check more for this power sequencing framework, it look likes it could
handle parts of the wifi/bt shared power management, but it will not cover
everything. The need for this bus on the BT side is not only for power
sequencing, there is some chip initialization to be performed over this bus,
like firmware upload to the chip (not the wifi firmware, it is an additional
bluetooth firmware).

I guess you are referring to Bartosz Golaszewski's talk at Plumbers.
Unfortunately I can not attend, but I'll make sure to check the materials once
available :)

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


