Return-Path: <linux-wireless+bounces-10750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F509432FB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 17:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E061F2A209
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5E11BE876;
	Wed, 31 Jul 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PMbyMSPG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F941BE867
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438775; cv=none; b=LoxEcHDY5l2qwOdHHryAJv3haH+QOY0aLqJzeeZGJTq/2rx81RbBUAxlzGc8T7KymII1EfH5Sf7njasRPolrnjPDA3euxVzTV/b80/i7tLgy61L7h96tz71x1yR7k8olHMS5BJXXkNNrQS/qQCU//4Sf8Wa6qsvJiLEjNWZpNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438775; c=relaxed/simple;
	bh=8zhTVavCJJ8/IwBvdz+QEBE4EZM9UV2ssOh2BpQ6TwQ=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hfSuLDJOn6rqrpaKIULSlA6eI38MMVv41pd7kF+NTmpfjfhZ3LlWdjkh3iMLdtwr7Udy29qfZ20rEKWsqvEBMDTagOvCZlyJrhRnjKja28qObJaNNWI9ePblUpVhvCbDu6MkEVJng3t2W42VQdF851P5G2I7Ne5rDDVlNv/dbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PMbyMSPG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so1927135b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722438773; x=1723043573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydsvrBXtt6nU238Px/qRdSbaJLxYYF7XQP8F6wgRzZA=;
        b=PMbyMSPG6VFpJRl+SkLQ7Fdp0QvPOJ64/wtjwEqihqEkMlJ+6aiXqAq8g74BE98vuM
         wMKpLnpXCShB84N/Ggo2RDeCAGUB9hRtL3/z1pV3G+fpBbinB/j/2YVWT2+kDfgK5nv8
         3QEjvawnzCgUUsO0Rm4mZov5VSoEyvRL9YA/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438773; x=1723043573;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydsvrBXtt6nU238Px/qRdSbaJLxYYF7XQP8F6wgRzZA=;
        b=rE9SgdlAslvhA1hIrktCjk8/aX64AEApQof/n/I4ILflTM42qetY9/SfZdcNhCPTCC
         j5WaQIg5CEmhMzOHZwu7CwX1t/JZlDE4jwISQxMfz+yGGcVa4GMsYB5Gdhbt6e9Tk1my
         JUZZazMG6YjFejSy0bNdwv/ZqaqtLthBmjODB9aSar/y11+pM3K+1D/6gg5fw7JAi2m2
         /tYRsIXg/htNcDXlpaLnt+x1dW4Tt2UmCGQDdu4aDwR5ZH5CoFLzHQ1iABbLhVCAuigU
         c2npjklwdbd1nnZdhLxt9GjxmPFsaBZgEZt5xojhBM6M4Ht66p8sj0jBqRs1G/19Mwy8
         nr/g==
X-Forwarded-Encrypted: i=1; AJvYcCWoSLGo8qMByZPDAznxh8ZrRUWIi+Bqmsq/DGyacYWFmOtU5Y+BnKMYLp1tYJrI2BfoJFCGBltwNXcLeHNAoHOshtEdiTR5bR39n8qL0vo=
X-Gm-Message-State: AOJu0YzL3HEAx1WxXAGoC1VfLMEzDhlevkX6ge7faPbmILtXyQDxz2/v
	1NUBHHoaV6M3TMfavEbGRLqlc+cTqk/g8nS4qowMDtalocbDd4l8cjdzfWcD+Q==
X-Google-Smtp-Source: AGHT+IHEl06Nm3dVBLJpGj1Uk+cVGvjdXmv2CgeM4NvVMJyMb/tbEYSvWNiGXEabI5NOqoQNRCIVqA==
X-Received: by 2002:a05:6a00:8592:b0:706:31d9:9c99 with SMTP id d2e1a72fcca58-70ece928cf5mr17384197b3a.0.1722438773104;
        Wed, 31 Jul 2024 08:12:53 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7156c8sm10059508b3a.83.2024.07.31.08.12.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2024 08:12:52 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>, Andy Green <andy@warmcat.com>
Date: Wed, 31 Jul 2024 17:12:43 +0200
Message-ID: <1910959c1f8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <sgfd5ccltsi7mjbybmdbs3fmsfcp3vqtpitdac7exzgxav53kk@6lwogbq4fhks>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
 <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
 <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3d3b8e0a-7492-4db1-bd73-c30a488edaa7@kernel.org>
 <191035b8c28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <k3dhdsa5bjzad2ha5e2uurg2azzs773ier5thkot4w2qcvnv54@yuf52eluqsae>
 <dd381dc1-454f-4ecd-adb7-55de2e15d592@broadcom.com>
 <sgfd5ccltsi7mjbybmdbs3fmsfcp3vqtpitdac7exzgxav53kk@6lwogbq4fhks>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On July 31, 2024 3:54:52 PM Sebastian Reichel 
<sebastian.reichel@collabora.com> wrote:

> Hi,
>
> On Wed, Jul 31, 2024 at 02:57:37PM GMT, Arend van Spriel wrote:
>> On 7/30/2024 7:38 PM, Sebastian Reichel wrote:
>>> Hi,
>>>
>>> On Tue, Jul 30, 2024 at 01:16:57PM GMT, Arend Van Spriel wrote:
>>>> On July 30, 2024 12:18:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>>> On 30/07/2024 11:52, Arend Van Spriel wrote:
>>>>>> On July 30, 2024 11:01:43 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>
>>>>>>> On 30/07/2024 08:37, Arend Van Spriel wrote:
>>>>>>> > + Linus W
>>>>>>> >
>>>>>>> > On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>>>>>> >
>>>>>>> > > Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
>>>>>>> > > external low power clock input. In DTS the clock as an optional choice in
>>>>>>> > > the absence of an internal clock.
>>>>>>> > >
>>>>>>> > > Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>>>> > > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>>>>>>> > > ---
>>>>>>> > > .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
>>>>>>> > > 1 file changed, 8 insertions(+)
>>>>>>> > >
>>>>>>> > > diff --git
>>>>>>> > > a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>>>> > > b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>>>> > > index 2c2093c77ec9a..a3607d55ef367 100644
>>>>>>> > > --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>>>> > > +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>>>> > > @@ -122,6 +122,14 @@ properties:
>>>>>>> > > NVRAM. This would normally be filled in by the bootloader from platform
>>>>>>> > > configuration data.
>>>>>>> > >
>>>>>>> > > +  clocks:
>>>>>>> > > +    items:
>>>>>>> > > +      - description: External Low Power Clock input (32.768KHz)
>>>>>>> > > +
>>>>>>> > > +  clock-names:
>>>>>>> > > +    items:
>>>>>>> > > +      - const: lpo
>>>>>>> > > +
>>>>>>> >
>>>>>>> > We still have an issue that this clock input is also present in the
>>>>>>> > bindings specification broadcom-bluetooth.yaml (not in bluetooth
>>>>>>> > subfolder). This clock is actually a chip resource. What happens if both
>>>>>>> > are defined and both wifi and bt drivers try to enable this clock? Can this
>>>>>>> > be expressed in yaml or can we only put a textual warning in the property
>>>>>>> > descriptions?
>>>>>>>
>>>>>>> Just like all clocks, what would happen? It will be enabled.
>>>>>>
>>>>>> Oh, wow! Cool stuff. But seriously is it not a problem to have two entities
>>>>>> controlling one and the same clock? Is this use-case taken into account by
>>>>>> the clock framework?
>>>>>
>>>>> Yes, it is handled correctly. That's a basic use-case, handled by CCF
>>>>> since some years (~12?). Anyway, whatever OS is doing (or not doing)
>>>>> with the clocks is independent of the bindings here. The question is
>>>>
>>>> Agree. Probably the bindings would not be the place to document this if it
>>>> would be an issue.
>>>>
>>>>> about hardware - does this node, which represents PCI interface of the
>>>>> chip, has/uses the clocks.
>>>>
>>>> The schematics I found for the wifi module and the khadas edge platform show
>>>> these are indeed wired to the chip.
>>>
>>> I have a Rockchip RK3588 Evaluation Board on my desk, which uses the
>>> same WLAN AP6275P module. I think I already commented on a prior
>>> version of this series: The LPO clock is needed to make the PCIe
>>> device visible on the bus. That means this series only works if the
>>> clock has already been running. Otherwise the PCIe driver will never
>>> be probed. To become visible the devices requires:
>>>
>>> 1. The LPO clock to be enabled
>>> 2. Power to be applied
>>> 3. The WL_EN gpio to be configured correctly
>>>
>>> If one of the above is not met, the device will not even appear in
>>> 'lspci'. I believe the binding needs to take into consideration, that
>>> pwrseq is needed for the PCIe side. Fortuantely the heavy lifting of
>>> creating the proper infrastructure for this has already been done by
>>> Bartosz Golaszewski for Qualcomm WLAN chips. What is missing is a
>>> pwrseq driver for the Broadcom chip (or this specific module?).
>>
>> That does not really make sense. There is no relation between the LPO clock
>> and the PCIe clocks so 1) being a requirement for probing the device looks
>> odd. It also does not match past experience when I assisted Andy Green in
>> getting this module up and running almost two years ago.
>
> Well, first of all I can easily reproduce this on my RK3588 EVB1. I
> intentionally ignore any bluetooth bits to avoid cross-effects from
> bluetooth enabling any clocks / regulators / GPIOs and make sure the
> RTC output clock is disabled at boot time (i.e. boot once without
> any reference to the RTC clock and without 'clk_ignore_unused'
> kernel argument). When booting up like this the WLAN device is not
> visible in 'lspci' despite the WL_REG_ON GPIO being hogged. If I
> additionally hack the RTC output clock to be enabled the WLAN device
> becomes visible in 'lspci'.
>
> The datasheet fully explains this:
>
> https://www.lcsc.com/datasheet/lcsc_datasheet_2203281730_AMPAK-Tech-AP6275P_C2984107.pdf
>
> PDF Page 23/24 (20/21 in the footer) has the Host Interface Timing
> Diagram. WL_REG_ON should only be enabled after 2 cycles from LPO.
> That means with LPO being disabled WL_REG_ON cannot be enabled. I'm
> pretty sure WL_REG_ON means WLAN_REGULATOR_ON, so the logic is not
> powered. On page 27 (24 in the footer) there is also a PCIe Power-On
> Timing diagram, which shows that WL_REG_ON must be enabled before
> the PCIe refclk is enabled.
>
> So there is a specific power up sequence, which must be followed.

The chip also has an (less accurate) internal LPO so the 32khz sleep clock 
in the diagram does not have to be an external clock. Maybe Ampak 
bootstrapped the chip to disable the internal clock. Dunno.

What Andy needed back then to get firmware running was a change in the 
nvram file to force using the internal LPO, but the device was already 
visible on the PCIe bus.

Regards,
Arend



