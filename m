Return-Path: <linux-wireless+bounces-12406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D45496A6DF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5BDB22A09
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0D192B69;
	Tue,  3 Sep 2024 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOVzyx8F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241141922CC;
	Tue,  3 Sep 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389267; cv=none; b=KiuSAtkbdYVH2Ojs9/SJ7K1rXo0/nR/Bqjwmm20dD1aZKEKxDBcqSe8D/6xc0wkiSARtZCnVO2iCQTiBckBCSx0LLfhQIXg/31QRXGpyEKvPkAvAl/Ajlh7qgwxng0XITVVj2Ki3BybRX4idYxS6kaNsDbyT4tW3kSttDtDvT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389267; c=relaxed/simple;
	bh=OUj8Q4CfO7rGEBhRXqf1GUwsr5oV4HXwtedQHeL/IzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1VCtRnICMIRn+WyParXK4/zbSHfITsBHLbtzbWp3ii6sM1Pi+5V/QKydjyAH2/+H+EoKEcc+lcNJhXg2iKNYipv4pLSlkXq3yXEdAQKMfjcX5OCInCv/xMxTPE4lUtJPXmPsNO0oLCbsnrzMkopeStIktIANDf9VKl0ubVgRvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOVzyx8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979CFC4CEC4;
	Tue,  3 Sep 2024 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725389266;
	bh=OUj8Q4CfO7rGEBhRXqf1GUwsr5oV4HXwtedQHeL/IzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BOVzyx8FSuPxAkF4TFNeDSSKdcAwuSgerUz9HiG1AKBnYZobVJseZeG22oN6o/epe
	 ioETSyl73GcfBjAZ1qWVO8OxNLoR+ES5L/BRUnwlCp0SZjye2qvhjzEC4eo4MkuYqY
	 rgGQFSqk0gd/Qh/uDZzeT/ys9GEicFY5YCq6Cw2CrONtDuf2r57ttK4onoQLERP01O
	 +Lk/RwdO79mrWVIINeqExJcb7D/iQC2txVTurLNMyEG7mSKVX/vIP4Zz1np0OeauTZ
	 uxd5YElsVaKUd8QO5HM9TvYuzFN/kny34oSeKWjuPH5ZWvXSAHcO5wCzDTkUgsieqO
	 nFVRTAmyI/Nqg==
Message-ID: <c84b783a-0118-43d8-8f03-a98fdf5bd8c5@kernel.org>
Date: Tue, 3 Sep 2024 20:47:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: wireless: wilc1000: Document WILC3000
 compatible string
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <52e7b6d2-5d31-4ae1-bf1d-44e63a22774d@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2024 18:09, Alexis Lothoré wrote:
> Hello everyone,
> 
> On 8/29/24 02:44, Marek Vasut wrote:
>> Document compatible string for the WILC3000 chip. The chip is similar
>> to WILC1000, except that the register layout is slightly different and
>> it does not support WPA3/SAE.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [...]
> 
>>  .../bindings/net/wireless/microchip,wilc1000.yaml           | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> index 2460ccc082371..5d40f22765bb6 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> @@ -16,7 +16,11 @@ description:
>>  
>>  properties:
>>    compatible:
>> -    const: microchip,wilc1000
>> +    oneOf:
>> +      - items:
>> +          - const: microchip,wilc3000
>> +          - const: microchip,wilc1000
>> +      - const: microchip,wilc1000
>>  
>>    reg: true
> 
> Following this series first revision, I have been taking a look at how to
> implement bluetooth feature for wilc3000 (the chip supports Bluetooth LE through
> a separated UART, see [1]), and I am facing some constraints. I feel like the
> possible solutions would conflict with this new binding, so even if I am a bit
> late to the party, I would like to expose the issue before the binding is merged
> in case we can find something which would allow to add bluetooth support without
> too much pain after the wlan part.
> 
> Downstream driver currently does not implement bluetooth as a standard bluetooth
> driver (module in drivers/bluetooth, registering a HCI device) but only performs
> a minimal set of operations directly in the wlan part ([2]). Getting a version
> valid for upstream would need the following points to be addressed:
> 1. despite being controlled from a serial port for nominal operations, the
> bluetooth part also depends on the "wlan" bus (spi or sdio) for initialization
> 2. yet init steps are not performed on any kind of subsystem ops but through
> writes to a custom chardev
> 3. the driver does not register itself a hci interface, it is expected to be
> done by userspace (hciattach).
> 
> It is only after those 3 steps that the chip can be used with standard hci
> commands over serial port. IMHO 1 is the biggest point, because it means that
> **a bluetooth driver for wilc3000 needs access to the bus used by wlan part**
> (so only describing the bluetooth part of the chip as a child node of an uart
> controller is not enough). Aside from bus access, I also expect some
> interactions between bluetooth and wifi (eg: power management, sleep/wakeup)
> 
> After considering multiple solutions to try to share this bus between existing
> wlan driver and a new bt driver (mfd device, auxiliary bus, device link + some

Driver design should not have impact on bindings.

> handles, etc), my current best guess is to convert wilc driver to a MFD driver
> for wilc3000. I guess some work can be done so that the driver can still be
> shared between wilc1000 and wilc3000 _while_ remaining compatible with current
> wilc1000 description, but it would impact the DT description for wilc3000, which
> would need to switch from this:
> 
>   spi {
>     wifi@0 {
>       compatible = "microchip,wilc3000";
>       [...]
>     };
>   };
> 
> To something like this:
> 
>   spi {
>     wilc@0 {
>       compatible = "microchip,wilc3000"; /* mfd driver */

I do not see any reason why... or rather: What is MFD here? MFD is Linux
stuff and we talk about hardware.

>       wifi {
>         compatible = "microchip,wilc3000-wlan";

Why? Just merge it to parent...

>         [...]
>       };
>       bt {
>         compatible = "microchip,wilc3000-bt";
>         XXXX; /* some link to the uart controller connected to the chip */

That's not how we represent UART devices. I don't understand why do you
need these - if for power sequencing, then use power sequencing
framework and describe associated hardware (there are some talks coming
about it in 2 weeks). If for something else, then for what?

>         [...]
>       };
>     };
>   };
> 
> (and similar thing when wilc is driven over a sdio bus)
> 
> Any opinion on this ? Would it make sense to describe wilc3000 chip that way ?
> 

You described drivers, not wilc3000 chip...

Best regards,
Krzysztof


