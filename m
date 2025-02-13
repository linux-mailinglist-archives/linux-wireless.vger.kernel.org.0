Return-Path: <linux-wireless+bounces-18920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AC1A34679
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 16:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF057A2CB9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8284159596;
	Thu, 13 Feb 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zlt2CV4z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD81411DE;
	Thu, 13 Feb 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460339; cv=none; b=V9ok485DrGketHw8hI8SqNpXl8SLErCh0idzSrzXg9COF2u3sWx7U2JP3RmAV4u1+kZeQJy+XAaTidgljA5i/d24NhWUHBmNwjCgkazXuYZg5DIyiVpot/hAbmPbrHw/i/em7gihuzKIdHi2JAR+Xub1Un3SPy3WlSJGsE3cjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460339; c=relaxed/simple;
	bh=TPjq4XjQPNfxakLg3n1C4p8+KUOyyY7/h6//Panzx9I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RNX1TGiEWw2crqPzdVwHzYT3SsXETy95KaPXbb96mobx6cWYBSmmtNslv8urQE86QT2yFdrxc6Lr3Lc6uYfI6BBeSEAy1FUhBNCSx4ZB8RiACpF/o8L1b/S+y4Yl7mL3B2eoDe/6pyagnqLSYNjJDi9x6p3Nyo39/cffK40pugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zlt2CV4z; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09B78432B4;
	Thu, 13 Feb 2025 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739460335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFuRc4vnJDC+U8vlunBJUoC5VAZxPPiCI440ctYMhMM=;
	b=Zlt2CV4zcUYBMgVH8rk5q0w7VMbNXWZqUiByPBR1Qdrmcku9kewtaX4Fzk9SAgMH5rddsF
	WixvDN8UgC5QEOGXUw5p+PRqfbJWjwzFG6FbnXlEI3/7TOE/Gr0oy0K896FcZwt3IVdXh6
	e03IpWT0pHlAuodihUQTKMBMbNTcrGko5PwNzcp1InTVGKKwyc8QWr8dronU0o1m6aEUO5
	OFWiNk02TA+bKSa5eSv3X9fSGXkXEA4GHF62aUDU3IMaa05LHhvBHxGfd3jZq9UVkIr25r
	yipJY+cw7hVDkqCtszC5/xG+Q3q1EvJokHHpFgrh5LB0SK/ZZelOQ3kpvtD2Zw==
Message-ID: <99247019-bb41-4fd9-bc0c-d31e5688533b@bootlin.com>
Date: Thu, 13 Feb 2025 16:25:33 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH 01/12] dt-bindings: bluetooth: describe wilc 3000
 bluetooth chip
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Marek Vasut <marex@denx.de>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
 <20250212-wilc3000_bt-v1-1-9609b784874e@bootlin.com>
 <20250213-chamois-of-unexpected-glory-dd3eab@krzk-bin>
Content-Language: en-US
In-Reply-To: <20250213-chamois-of-unexpected-glory-dd3eab@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleejhfevledvgeehvdevueejgeduhfelffegkeejteejveevieejvdeifeekuedtnecuffhomhgrihhnpehmihgtrhhotghhihhprdgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 ehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghjrgihrdhkrghthhgrthesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Krzysztof,

On 2/13/25 10:25, Krzysztof Kozlowski wrote:
>> +  wlan:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the wlan part of the combo chip
> 
> No resources here and judging by the driver everything is part of wifi.
> Either you wrote it to match driver or indeed hardware is like that. In
> the first case, why this cannot be part of WiFi with phandle to serial
> bus? In the second case, this needs to be proper hardware description

First, I'd like to reclarify what the chip exactly is, to make sure that we are
talking about the same thing. The wilc3000 ([1]) is a single physical device
packaging two different discrete modules inside (one for 802.11, one for
bluetooth). The WLAN part has its own binding integrated in upstream kernel
([2]) and is based on a similar chip in the same family (wilc1000, which only
have 802.11, and so only SPI/SDIO, no UART).

Now that it is said, no, I did not write this binding only aiming to match the
new driver. I tried to base this description on how similar WLAN/BT combo chips
are usually described (based on those which have existing bindings), and they
seem to describe distinctly the two internal parts of those chips as well. For
those who use HCI commands over uart for the bluetooth part, they expose a
dedicated child node of a serial controller (distinct from the wlan part,
described as another node on PCI/SDIO/SPI/etc). The hardware architecture for
wilc3000 is similar to those, so since the serial bus is the primary interface
to operate the bluetooth part inside the chip, doesn't it makes sense to have it
under a serial controller node (and then to refer to wlan for the additional
operations needed on sdio/spi), than the other way around ?

About the lack of other resources in the new node: there are indeed additional
resources that affect bluetooth, but I am not sure how it should be handled:
there are for example a reset input and a chip enable input exposed by this
chip, which in fact do not only affect the WLAN part but the two parts inside
the chip. But those are currently described and handled by the WLAN part. I
guess that an improvement regarding this point could then be to move those out
of the wlan binding, and find a way to describe it as shared resources between
those two parts of the chip, but how should it be handled ? Is it ok to remove
those from an existing binding (and if so, where to put those ? It is not
bluetooth specific neither) ? Is the issue rather about current WILC3000 binding
kind of mixing overall chip description and internal wlan part description ?

Thanks,

Alexis

[1]
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/IEEE-802.11-b-g-n-Link-Controller-Module-with-Integrated-Bluetooth-5.0-DS70005327B.pdf
[2]
https://elixir.bootlin.com/linux/v6.12.6/source/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> Best regards,
> Krzysztof
> 


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

