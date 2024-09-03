Return-Path: <linux-wireless+bounces-12397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585CB96A3BB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10302285B4B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201B189BB7;
	Tue,  3 Sep 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G/ZBMJI7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAB189B88;
	Tue,  3 Sep 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379762; cv=none; b=olmgDkrpi8iMfgqMesvtNfReZx/VJfi5b1OrWSHzhQTqFBHHfEZ+0BnwGuMKv0v+WxmRL9dkEZx+MicCbrQIkvgcyvOObBWRyQKTjcfXBNZ9w7CuA4vYX+jIUfDK4hQtVIBeNZoSoyhJdpdE1vML6rlyrTtUEgV2luzEVbdle7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379762; c=relaxed/simple;
	bh=jawaCYi7YB1S/nE3YHVprZpILDdSvxcJZrLcPKY+Wg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWUkZ8wp4GiuCDOa0YWjwtMknH8pch8n7pA56yude4kh5RbDYcq2uKRuj/TRMujUOWTImY4rSiNUV1q5l3Y5k0Sl6J17+O/vQ5OlY2NtNZiiREP30J+iqzVTrrf6DUmhddbhFD0bi5sshlIDpwUtjW2p+9RBeHMewfEJh8Xaf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G/ZBMJI7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04CD1C0002;
	Tue,  3 Sep 2024 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725379752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rbv+YpGecw0fPUIchwhJ5PCJRkLWlECr33dmW73zeLA=;
	b=G/ZBMJI7Z1PH0JcEfVTv1X/yW7V5QRM9v+jTGdsas/UjyfmvOItsdfTSxVktJ0gc2G5m3W
	D6qnTyjEfjHh6QaYLM7X4zUZxPZ9Fr9PWqawBBXU2B8wlZFSJBuVvC/NhrZvG1Rhp7vCQT
	V3D50yKjqench43+5pn2HHlg5C/FPsFMQOqpV0Zx7z2Se1n7HPl5hIu7u2ijDpIdHrESqb
	rKKw1yziJaw9H0vjy3XZ/zK4tMAldGyxjyxE/Q5EHrj9sFSSwHEF7n8izbTsFIzZgJBVtY
	3mqXStXM6kQXrI+kB4SAhW7BIyh9+kkDaVijQhMc53wdUJN2D6E7LV4Kqr4Mgg==
Message-ID: <52e7b6d2-5d31-4ae1-bf1d-44e63a22774d@bootlin.com>
Date: Tue, 3 Sep 2024 18:09:10 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20240829004510.178016-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello everyone,

On 8/29/24 02:44, Marek Vasut wrote:
> Document compatible string for the WILC3000 chip. The chip is similar
> to WILC1000, except that the register layout is slightly different and
> it does not support WPA3/SAE.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Marek Vasut <marex@denx.de>

[...]

>  .../bindings/net/wireless/microchip,wilc1000.yaml           | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> index 2460ccc082371..5d40f22765bb6 100644
> --- a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> @@ -16,7 +16,11 @@ description:
>  
>  properties:
>    compatible:
> -    const: microchip,wilc1000
> +    oneOf:
> +      - items:
> +          - const: microchip,wilc3000
> +          - const: microchip,wilc1000
> +      - const: microchip,wilc1000
>  
>    reg: true

Following this series first revision, I have been taking a look at how to
implement bluetooth feature for wilc3000 (the chip supports Bluetooth LE through
a separated UART, see [1]), and I am facing some constraints. I feel like the
possible solutions would conflict with this new binding, so even if I am a bit
late to the party, I would like to expose the issue before the binding is merged
in case we can find something which would allow to add bluetooth support without
too much pain after the wlan part.

Downstream driver currently does not implement bluetooth as a standard bluetooth
driver (module in drivers/bluetooth, registering a HCI device) but only performs
a minimal set of operations directly in the wlan part ([2]). Getting a version
valid for upstream would need the following points to be addressed:
1. despite being controlled from a serial port for nominal operations, the
bluetooth part also depends on the "wlan" bus (spi or sdio) for initialization
2. yet init steps are not performed on any kind of subsystem ops but through
writes to a custom chardev
3. the driver does not register itself a hci interface, it is expected to be
done by userspace (hciattach).

It is only after those 3 steps that the chip can be used with standard hci
commands over serial port. IMHO 1 is the biggest point, because it means that
**a bluetooth driver for wilc3000 needs access to the bus used by wlan part**
(so only describing the bluetooth part of the chip as a child node of an uart
controller is not enough). Aside from bus access, I also expect some
interactions between bluetooth and wifi (eg: power management, sleep/wakeup)

After considering multiple solutions to try to share this bus between existing
wlan driver and a new bt driver (mfd device, auxiliary bus, device link + some
handles, etc), my current best guess is to convert wilc driver to a MFD driver
for wilc3000. I guess some work can be done so that the driver can still be
shared between wilc1000 and wilc3000 _while_ remaining compatible with current
wilc1000 description, but it would impact the DT description for wilc3000, which
would need to switch from this:

  spi {
    wifi@0 {
      compatible = "microchip,wilc3000";
      [...]
    };
  };

To something like this:

  spi {
    wilc@0 {
      compatible = "microchip,wilc3000"; /* mfd driver */
      wifi {
        compatible = "microchip,wilc3000-wlan";
        [...]
      };
      bt {
        compatible = "microchip,wilc3000-bt";
        XXXX; /* some link to the uart controller connected to the chip */
        [...]
      };
    };
  };

(and similar thing when wilc is driven over a sdio bus)

Any opinion on this ? Would it make sense to describe wilc3000 chip that way ?

Thanks,
Alexis

[1] https://www.microchip.com/en-us/product/atwilc3000
[2]
https://github.com/linux4sam/linux-at91/blob/linux-6.6-mchp/drivers/net/wireless/microchip/wilc1000/bt.c

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


