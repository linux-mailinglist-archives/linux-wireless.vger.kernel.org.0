Return-Path: <linux-wireless+bounces-12488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF96096C136
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED110B26E29
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCE61DA615;
	Wed,  4 Sep 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iNKaXNDn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDEB39FFE;
	Wed,  4 Sep 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461435; cv=none; b=BEgjU62aSm5gs/c81fNYfDloS+dgCLmKopVC5KuaPMpTaysKU4k0wK0I4PJprIZtdT0aLsXdKOJIxaJ4G5gAJMVWuOBthF8176VmQOj0YkF9z1tCffHyl7dg+4SE/mMJBfHlVz+EnAGmTA0+S2xy+IkaDYcV7KOnre9rd+owRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461435; c=relaxed/simple;
	bh=3UH2MGIc69EzoDjDvmh0oiShPsI4FSr09ftxk5ooSUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3pty/iqFFLpDjgTvtFXRv8kkWJzSQl/QqMDF6wOKnii+9WRNPiuLZz6Hoz6EC2TewjXXQl7mvCuPlyJbBaPWrbHHReS1g6SzsfpIiq+LiVcd0kJj38tceOivCHwW5k4sZFMpRYUe1w3ctVZHIJ/nUIduE/IercA91ycVByNT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iNKaXNDn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FD3260004;
	Wed,  4 Sep 2024 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725461431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLUKnub7c6Pf6UqSOzCbAefXAF8dAI8Q6zzQzb7RfpQ=;
	b=iNKaXNDnwXWQV4mGTniiCGtNJeGRptGqQs4MuwjLOKqMaIG1AiNBWuF57IqSLkJnb+Ez/n
	7mV/IYMkIhy9/E2WHJzYMobmCAOe97rrS1nft6tvGR7Pdr1wDL+5DWqqmv6O1fUj9zMpIM
	GoxOcE3PzebWuzgOO7or/YozKsQMHERREmsTuHlI2MJ1KO+F61UrDtatiMSTjh6Rj//sS1
	UpFFxLRR95OR/PwWOWyIGHOiLKHgXyYc3TOxk40fIKZ5FK1MMZjQimWbp9ZUA7hhQxkY8p
	f6dFrIuevjNs/Bxm8ajSadLqAfK+G20MSrAAye9s221ukbvCmI/qPSwxxd/CNw==
Message-ID: <95ae0eb6-72ec-4261-b9e1-8ee3e831452e@bootlin.com>
Date: Wed, 4 Sep 2024 16:50:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: wireless: wilc1000: Document WILC3000
 compatible string
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
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
 <57a7eac4-23c7-42ac-ade5-233c24a288c6@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <57a7eac4-23c7-42ac-ade5-233c24a288c6@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Marek,

On 9/3/24 21:30, Marek Vasut wrote:
> On 9/3/24 6:09 PM, Alexis Lothoré wrote:

[...]

>> It is only after those 3 steps that the chip can be used with standard hci
>> commands over serial port. IMHO 1 is the biggest point, because it means that
>> **a bluetooth driver for wilc3000 needs access to the bus used by wlan part**
>> (so only describing the bluetooth part of the chip as a child node of an uart
>> controller is not enough). Aside from bus access, I also expect some
>> interactions between bluetooth and wifi (eg: power management, sleep/wakeup)
> 
> Just a quick idea -- what about having a phandle to the BT UART node in the
> wilc3000 node ? Then the wilc driver can check if the phandle is available and
> valid, and attach the BT part to the UART, while also doing all the necessary
> power sequencing and bus accesses via SDIO/SPI.
> 
> Like this:
> 
> &uart10 {
>   status = "okay";
> };
> 
> &mmc20 {
>   ...
>   wifi@0 {
>     compatible = "microchip,wilc1000";
>     microchip,bt-uart = <&uart10>; // OPTIONAL
>     ...
>   };
> };

I thought about something like this too, indeed (but somehow inverted, a
reference to wilc node in the bt node under uart, to allow the bluetooth part to
ask wilc to perform operations over sdio/spi). The design would likely be
simpler in this case, but some internal discussions with colleagues raised some
concerns, for example with power management (but Krzysztof's suggestion about
power sequencing may help with this).

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


