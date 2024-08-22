Return-Path: <linux-wireless+bounces-11768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E295A8D1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 02:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC0DB22CAC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA89461;
	Thu, 22 Aug 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcrOz4t/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4325661;
	Thu, 22 Aug 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286389; cv=none; b=peVgQCdelgmes5Y8XBtFxcPvLotEs+yzSi2Gdh6v+WS65zcT//Ch6xgrulkn9XX72yKmFlJD98tDRpHTda14p6ehsF8iRBlzXgCs87Reqympx+ZcyvMYhNSmGO2taLl4iJIwn9RGCOiWtAIlZjUx3nyoQUARTYvwoPB2vkn8C/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286389; c=relaxed/simple;
	bh=sbaExOJNUa3u/kFBfMA5JdWqNWYBSpyn5r+f72RsFoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8m3AmsbGQpGSs6amRnhCuEUqHwR3t4QvrLp0wbT/lbOd+6bhcGxxlcL391jrbE2sRA2BxmODTbQ3H1+zt3uI+Ncn39ThuP6qUiFjgxm7kZ2uocXmSsj7VfQcKBgTYm0z2rm4ZeETzQUwYXE7LWmSt/SRUDE9cJ+udyXUECAiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcrOz4t/; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b4432b541aso2773857b3.1;
        Wed, 21 Aug 2024 17:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286387; x=1724891187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yygxy+SswvTalGTzXLF9xOU7VfSvEWj/WAnP+sa6pLQ=;
        b=dcrOz4t/Jfo68vkwaSVWoyjAE1Bt+9sSrTXFcB06HS9obfAw+AXB1oqepwPBcvY+fh
         KtnBU5VldGU6N6gKYaNA5nmQMrX3uWd6SoaQygtdaSbdwaOBZT1h6eyzdcy1qgpTmiA7
         E/gUZCp68kY2c7bwze1V9UcsQqQfT0LnNtfWsAWBA+/E1pboN27S343D3ZBHD5vcNg/9
         m0OldVpWLVZCypZxQ+9SVQHne+rnSnxQQ+dC0axVFKVKijV7voJ//DxDek3GOMnxX0bz
         Z10hSff0eEoH0ijmKPUTuJltioNVjOer5Kd1HXtCbi62X/PcnrOx/J/qQYvZUb/l7ih2
         Y/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286387; x=1724891187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yygxy+SswvTalGTzXLF9xOU7VfSvEWj/WAnP+sa6pLQ=;
        b=FIF1OSFYzYGW8eoDqLjoNeDsnDTOljOEPS80ttD2rzXsbngNazM1rAkMKR+l1POEB2
         b7Ue7dn6RGe2iweym1vBaXFUAUHqj+qxk7SvI9pDrD+Dd6jz48movsDHCYa8cG4DSJDe
         w4eAlA1Iryj0SVxw1aqxqUV7QBQyG9T3q6tpTQQ0twPk7fNX26XemkNUxdmU/RkR031u
         K2c6l5mw5EgD8de0qip4lhaOQaqAzTHKt/uUT+EmWKjIVahgjuH3oCYeq2IngOdGJ/zJ
         QEWzm6eAe8vKk+M5tae0nr+EZbATqU6pBKojMn9CIo1BMMT4ktcXCqgQ1jSpkfjWGXrT
         St8g==
X-Forwarded-Encrypted: i=1; AJvYcCV50EUDiJgATwsQy/uQVAuzZRpG45Q3kxLq/7K0GsAgtPs/9nSzncJOLRts6luJu6lpUZg83Uf3fPjYTJATz28=@vger.kernel.org, AJvYcCXuVY5H+UotNFk8cz0nKt/XhZt6TOp0kGSLvcOsxHQdEov/GeO7YeHeVIlQ7083Q5JtosxF491z8h4j@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzJUYWyTjudU8MjzqC3nURn3RGxJPG45qnJCLrorZTe/mHI/S
	xGoZiIWm+KBcqWUMitpOPsC9vGd4IBA5IcgStnzC4SMB6GnzSJRm2HO8fZP7D5HM86IMveNzIkR
	1Ab2lvaOwffL0EBlkkBvJkdSdY/s=
X-Google-Smtp-Source: AGHT+IFHWv8m2dGCwdLvgaOkJlgTnvi/SA3k6TMvgah+tUzw9I7WiOv51zfqWgdB3bIHvytzPn4RPv0uIDiv6SkBxIM=
X-Received: by 2002:a05:690c:288f:b0:62a:530:472f with SMTP id
 00721157ae682-6c09fa8b1b1mr43824207b3.32.1724286386825; Wed, 21 Aug 2024
 17:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
 <20240820101216.355012-2-arend.vanspriel@broadcom.com> <mbvhz3wosnykejgs65es2sfedxoevysbqu3jxmpgdze2b2tl6o@grx4mxas2bmf>
 <7881c303-bef1-403a-aa70-30d33558f57f@kernel.org> <6777d425-b27f-43d0-ba81-b36ac0b8f929@broadcom.com>
 <0b639d04-af33-44b0-a556-40decff683c5@kernel.org> <3ed394a3-2b5e-4096-b090-c805657585a3@kernel.org>
 <f7c17dff-fd64-4769-9fc4-7ff929a2c5d8@broadcom.com> <931f4acc-6fb5-4f0d-9e37-b945de2e7349@kernel.org>
In-Reply-To: <931f4acc-6fb5-4f0d-9e37-b945de2e7349@kernel.org>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 22 Aug 2024 10:26:15 +1000
Message-ID: <CAGRGNgWeuJ4Y4AwvDQWw9nZ=tVCsaqVnmeyD+ywT4c4+LmmXCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: wireless: restore constraint for
 brcm,bcm4329-fmac compatible property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof, Arend,

On Wed, Aug 21, 2024 at 4:46=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 20/08/2024 21:29, Arend van Spriel wrote:
> > On August 20, 2024 5:51:03 PM Krzysztof Kozlowski <krzk@kernel.org> wro=
te:
> >
> >> On 20/08/2024 17:36, Krzysztof Kozlowski wrote:
> >>> On 20/08/2024 14:50, Arend van Spriel wrote:
> >>>> On 8/20/2024 1:39 PM, Krzysztof Kozlowski wrote:
> >>>>> On 20/08/2024 13:27, Krzysztof Kozlowski wrote:
> >>>>>> On Tue, Aug 20, 2024 at 12:12:15PM +0200, Arend van Spriel wrote:
> >>>>>>> When extending the bindings for Apple PCIe devices the compatible=
 property
> >>>>>>> specification was changed. However, it was changed such that for =
these
> >>>>>>> devices it was no longer necessary to have "brcm,bcm4329-fmac" li=
sted as
> >>>>>>> string in the compatible list property as it was before that exte=
nsion.
> >>>>>>
> >>>>>> Apart that this was never tested... That statement is not true. Lo=
ok at
> >>>>>> "fixed" commit - it is not doing like that at all.
> >>>>>>
> >>>>>> I don't understand the reasoning.
> >>>>>>
> >>>>>>> This patch restores that constraint.
> >>>>>>>
> >>>>>>> Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple p=
roperties
> >>>>>>> & chips")
> >>>>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> >>>>>>> ---
> >>>>>>> .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++----=
-----
> >>>>>>> 1 file changed, 10 insertions(+), 9 deletions(-)
> >>>>>>>
> >>>>>>> diff --git
> >>>>>>> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fma=
c.yaml
> >>>>>>> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fma=
c.yaml
> >>>>>>> index e564f20d8f41..47f90446322f 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329=
-fmac.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329=
-fmac.yaml
> >>>>>>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.=
yaml#
> >>>>>>> title: Broadcom BCM4329 family fullmac wireless SDIO/PCIE devices
> >>>>>>>
> >>>>>>> maintainers:
> >>>>>>> -  - Arend van Spriel <arend@broadcom.com>
> >>>>>>> +  - Arend van Spriel <arend.vanspriel@broadcom.com>
> >>>>>>>
> >>>>>>> description:
> >>>>>>> The Broadcom Single chip MAC part for the BCM4329 family and
> >>>>>>> @@ -27,7 +27,6 @@ properties:
> >>>>>>>            - brcm,bcm4341b0-fmac
> >>>>>>>            - brcm,bcm4341b4-fmac
> >>>>>>>            - brcm,bcm4341b5-fmac
> >>>>>>> -              - brcm,bcm4329-fmac
> >>>>>>>            - brcm,bcm4330-fmac
> >>>>>>>            - brcm,bcm4334-fmac
> >>>>>>>            - brcm,bcm43340-fmac
> >>>>>>> @@ -46,13 +45,15 @@ properties:
> >>>>>>>            - cypress,cyw43012-fmac
> >>>>>>>            - infineon,cyw43439-fmac
> >>>>>>>        - const: brcm,bcm4329-fmac
> >>>>>>> -      - enum:
> >>>>>>> -          - brcm,bcm4329-fmac
> >>>>>>> -          - pci14e4,43dc  # BCM4355
> >>>>>>> -          - pci14e4,4464  # BCM4364
> >>>>>>> -          - pci14e4,4488  # BCM4377
> >>>>>>> -          - pci14e4,4425  # BCM4378
> >>>>>>> -          - pci14e4,4433  # BCM4387
> >>>>>>> +    - items:
> >>>>>>> +          - enum:
> >>>>>>> +              - pci14e4,43dc  # BCM4355
> >>>>>>> +              - pci14e4,4464  # BCM4364
> >>>>>>> +              - pci14e4,4488  # BCM4377
> >>>>>>> +              - pci14e4,4425  # BCM4378
> >>>>>>> +              - pci14e4,4433  # BCM4387
> >>>>>>> +          - const: brcm,bcm4329-fmac
> >>>>>>> +    - const: brcm,bcm4329-fmac
> >>>>>>
> >>>>>> And this does not make sense... You claim that some constrained wa=
s
> >>>>>> droppped and you re-add it, but in fact you still add the same cod=
e as
> >>>>>> it was before.
> >>>>>>
> >>>>>> NAK.
> >>>>>
> >>>>> Ah, the last "const" actually makes sense, I missed that.
> >>>>>
> >>>>> Commit still however lacks rationale why these devices are compatib=
le.
> >>>>> Plus existing rationale that e2e37224e8b3 changed something is enti=
rely
> >>>>> WRONG. It changed nothing. ZERO. It only added new devices, which w=
as
> >>>>> claimed are not compatible with brcm,bcm4329-fmac.
> >>>>
> >>>> So is that claim true? What does it mean that these new devices are =
not
> >>>> compatible. If they are they should be in a separate binding or the
> >>>
> >>> Whether binding is separate or not, is just way of organizing things.
> >>>
> >>>> applicable properties for these devices should be made conditional.
> >>>
> >>> Could be if they are not applicable.
> >>>
> >>>>
> >>>>> Now if you claim that original commit which said "these devices are=
 not
> >>>>> compatible with brcm,bcm4329-fmac", then please provide arguments, =
not
> >>>>> just say "other commit did something". It did nothing...
> >>>>
> >>>> Not entirely true. Indeed new devices were added for which no
> >>>> "brcm,bcm4329-fmac" string is required in the compatible property. A=
lso
> >>>> the commit added new properties for these new devices. Now in my opi=
nion
> >>>> a driver should not use these properties without a "compatible" chec=
k.
> >>>> Hope we can agree to that. However, the driver patch for supporting =
the
> >>>
> >>> Sorry, I don't follow. Why the driver would need to check for compati=
ble?
> >>>
> >>>> binding change does no such thing. So if we leave the binding as it
> >>>> currently is the driver will have to check if compatible has any of =
the
> >>>> listed PCI IDs before processing the properties. As all properties o=
ld
> >>>
> >>> Why driver needs to check it? Are these properties not valid?
> >
> > How would the driver know other than the compatible property? The node
> > with properties is delivered by the bus driver. If that comes with
> > guarantees about validity than that's great.
>
> I still do not follow what is the problem being addressed by driver
> needing to check.
>
> >
> >>>
> >>>
> >>>> and new are marked as optional I can not come up with an argument th=
at
> >>>> these new devices are *not* compatible with brcm,bcm4329-fmac.
> >>>
> >>> Compatibility is expressed by implementing same programming interfasc=
e
> >>> (or its subset) thus being able to bind via fallback and correctly
> >>> operate in given SW.
> >
> > This exactly what I mean to say (and apparently fail to do so ;-s ).
> >
> >>> I don't know whether that's the case here, so rephrasing my earlier
> >>> comments - the commit msg should focus on this aspect and tell that
> >>> devices are fully compatible, thus they should use fallback.
> >>>
> >>> Quick look at drivers told me that not - they are not compatible...
> >
> > Okay. That puts use in different corner of the arena. Can you elaborate
> > how you come to that assessment? Is that based on the fact that some of
> > the properties are SDIO-only?
>
> The simplest: because they do not use the same match/bind code. Plus PCI
> devices never used half of brcmf_of_probe(). Although that's more of a
> reason these are significantly different.
>
> >
> >>>
> >> Another thing is that calling SDIO and PCI devices compatible is quite=
 a
> >> stretch... Clearly hardware-wise they are very different and Linux doe=
s
> >> not use the same interfaces to match/bind them.
> >
> > These are wifi devices which hardware-wise are 95% the same. If you fin=
d
> > the block diagram with IP cores for these devices (enough google result=
s
> > to find some) you can see they sometimes even have both PCI and SDIO
> > block on-chip although only one is used so they can be considered 100%
> > the same. In both cases the bus driver will attach the DT node to the
> > binding device.
>
> I understand they are similar, but it does not matter if that is 95% or
> even 99% if the interface is different. Linux cannot use these devices
> through the same interface. However if you claim it can, then please
> write appropriate commit msg.
>
> My entire objection hare started not because I believe these are not
> compatible (although based on different buses I believe they are not
> compatible), but because the argument was about that other commit. That
> argument is not correct to make the change. Correct argument to make the
> change could be: These devices are compatible, because of foo and bar.

A way to put it might be something like:

Almost all Broadcom wireless chipsets, some Broadcom ethernet chipsets
and most Broadcom-derived Infineon and Cypress wireless chipsets share
the same rough layout:

System bus -> bus glue logic -> internal bus -> RF chipset(s)

Previous generations had separate drivers for the bus glue logic and
then probed the internal bus for the RF chipset(s), however in the
current generation that separation is mostly just a historical
artifact and abstraction layer.

The firmwares for all WiFi chipsets in this generation also provide
fundamentally identical interfaces with any differences either probed
at runtime or derived from data in the firmware. As such, once the
glue logic is abstracted away, all chipsets of this generation are
fundamentally identical from a software perspective. Therefore the
only data needed to use one of these chipsets is the type of bus to
select the glue logic driver and the firmware to load which is derived
from the vendor and product IDs.

The only real hardware differences between different chipsets are that
some have external interrupt lines or additional clocks and I'm not
sure if hooking those up is actually mandatory.

Thanks,

Julian Calaby



--
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

