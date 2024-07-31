Return-Path: <linux-wireless+bounces-10738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E638942DAB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 14:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AD01F24A5A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C71AD9CA;
	Wed, 31 Jul 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kln8riWt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B918DF93;
	Wed, 31 Jul 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427317; cv=none; b=GBceeHYmKHMoQJMelwYO5c7+nEfahK5gDLklq5T+6SSMJ21BhQgWQlL3lcgVBEKyXFoukK3cKP3ER/F6S4oHke7PXNpuAUMWxkaUtJmzgezf9+UU05qcdaGV6a2Hyr31SvU8XW8iFCRiPg2dJmNZun70Gwvq2ON3BVBCCRkq2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427317; c=relaxed/simple;
	bh=LVjov7ClVWhHYmB27oJpJCKYTDKiwHUtuAGM7drOpZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtXRLVBW+ik1TwNQV0HC7cvfGmeCdI6/7niykXrFJZR4NkmssFQX66GG0Paa/Sh/sfUTKgIsle/Rmu++/51oZ/7xXTM6CpuRyQyLKUM5b86ukKl8/m7dIoBYOiJF2a3eVzrxhanTr0hK92BOvV7p2fcUtB8ISkfY4v2P5Z6Rg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kln8riWt; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44ff132ff9cso32526141cf.2;
        Wed, 31 Jul 2024 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722427313; x=1723032113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdxVctv+DdSXKhp2nW8V2B7yfwAa9gWaT7Efbbf2MUs=;
        b=Kln8riWt/2sCcqnfj7MU4WZ4NWqFZy815ymwHnro7Vw8FP+V/HZNO5yEVKHtgTbEId
         wIzQK2jO7sZ0/ciTBRmBx2gYCIXI5dPGxI/dy+feersBcnxAXxfomUGNF+jNs5YJeRuJ
         3HzrwCY4qjoUID0fm2ETxSQLJYYZmLJtMSk9MLlBNANvxKlieFfwb/43Qz7o9/eV9PV7
         xprki3sg/cIHzImwKKI05QWDlYoOklCzUVMv3U99VhsX+c0xeOHLzk9QGurBP1KPi8PI
         qpNJaIEKufYD2HD4Vo1DTGsMopU+TVt7mgQfQU+QfYx6d1QDczIeZ/YAZfeWL+f10oyf
         cEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427313; x=1723032113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdxVctv+DdSXKhp2nW8V2B7yfwAa9gWaT7Efbbf2MUs=;
        b=bJBNqmmhlbA75oeypAvRCq3jQgHUgO0FQjRhGnl7eCz9mVZ7kN49VSFZqyPz4mAYb/
         wqOLcyczvjpthrY95b8AcyNxSayBDQ0SfNxgmafgdkhBgnJ9R3RHqrO/Mu81eEm1Q8TC
         6Wah8pB7dQbmyr4RKHA/cFu7+F4dkznvFzLVOH8hDT8+twVyaHqeXWm6Hf1dQyBHXxtG
         40kFTEQFs+zKEudXUi0BcacTivzq2txQ5lW9z0lfchIJkAUgprWA2rRMHbI8YJ6hqFkC
         FhWJyzTjyVkhU+V4mL6Ww3utAZxTs61b4z56LDXWeHyF4WJtjaoxnqD2CiuOF6X35jCd
         ztuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeltVgVvDKSaU+brk1pyM2DD0zySS9ZRhydjrnxysiO952uvglUplzrG9mmBmwG2BqnuyCeDUBlF4CPNh1b0ZGhNCse8z/lBzR3H4r2eY7PCYEO9f6s0YXRHj8B1QBpF1Yvm/5qMFNGYSGMNP8yK3PS6wq6JQZUwwO5osF2sV5AZaFSOWLz4qtzhKIPgyxYnvzJZ5U9zQHJFKKaz3ZQH9O
X-Gm-Message-State: AOJu0YwIjl45ldU8NPsZIQPO6wBNhIXktfrRSyJz8uNvohDjp4IyVuvW
	++Mg/eQ7XmG9Le4u/kmbPokl34IrVdCqcRbEgwJxHS4r9NhDsAGaI6Z3QROfdMK4yLgE2BNnCy+
	nLiK0TFFrzQqA/mM+m8wG9SUExXk=
X-Google-Smtp-Source: AGHT+IFi2BbcxJpNlMrpYMLQzS7Jo6R2My/hEHuRqvwqwW1vOU0rinmMmWgsYL/ghObViGzEfNFNw52JVfzra3ViMP4=
X-Received: by 2002:ac8:5806:0:b0:44f:f9ce:25df with SMTP id
 d75a77b69052e-45004f4bf36mr164398711cf.46.1722427313075; Wed, 31 Jul 2024
 05:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
 <20240731061132.703368-5-jacobe.zang@wesion.com> <0a78a0fb-0a5e-424f-a801-4a63b9ee1a49@gmail.com>
 <3ded8aea-ee11-43da-9dd7-1259cf931747@broadcom.com>
In-Reply-To: <3ded8aea-ee11-43da-9dd7-1259cf931747@broadcom.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 31 Jul 2024 15:01:41 +0300
Message-ID: <CABjd4YxiSY0A0iVHGHw9RDey+avxmzUapoLLLyf=80MzVX0yWA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] wifi: brcmfmac: Add optional lpo clock enable support
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org, krzk+dt@kernel.org, 
	heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org, 
	efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	nick@khadas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:15=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 7/31/2024 12:16 PM, Alexey Charkov wrote:
> > Hi Jacobe,
> >
> >
> > On 31/07/2024 9:11 am, Jacobe Zang wrote:
> >  > WiFi modules often require 32kHz clock to function. Add support to
> >  > enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> >  > to the top of brcmf_of_probe
> >  >
> >  > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> >  > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> >  > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> >  > ---
> >  >  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 +++++++++=
++-
> >  >  1 file changed, 11 insertions(+), 1 deletion(-)
> >  >
> >  > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >  > index e406e11481a62..7e0a2ad5c7c8a 100644
> >  > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >  > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >  > @@ -6,6 +6,7 @@
> >  >  #include <linux/of.h>
> >  >  #include <linux/of_irq.h>
> >  >  #include <linux/of_net.h>
> >  > +#include <linux/clk.h>
> >  >
> >  >  #include <defs.h>
> >  >  #include "debug.h"
> >  > @@ -70,12 +71,16 @@ void brcmf_of_probe(struct device *dev, enum
> > brcmf_bus_type bus_type,
> >  >  {
> >  >      struct brcmfmac_sdio_pd *sdio =3D &settings->bus.sdio;
> >  >      struct device_node *root, *np =3D dev->of_node;
> >  > +    struct clk *clk;
> >  >      const char *prop;
> >  >      int irq;
> >  >      int err;
> >  >      u32 irqf;
> >  >      u32 val;
> >  >
> >  > +    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> >  > +        return;
> >
> > Did you test this? The DTS patch you sent as part of this series doesn'=
t
> > list "brcm,bcm4329-fmac" in the compatible, so this will probably retur=
n
> > right here, skipping over the rest of your patch.
> >
> > Please test before resending, both with and without the driver for the
> > Bluetooth part of the chip (since it also touches clocks).
> >
> > You are also changing the behavior for other systems by putting this
> > check further up the probe path, which might break things for no reason=
.
> > Better put your clk-related addition below where this check was
> > originally, rather than reorder stuff you don't have to reorder.
>
> That was upon my suggestion. That check was originally at the top of the
> function, but people added stuff before that. I agree that makes the
> compatible "brcm,brcm4329-fmac" required which is what the textual
> binding stated before the switch to YAML was made:
>
> """
> Broadcom BCM43xx Fullmac wireless SDIO devices
>
> This node provides properties for controlling the Broadcom wireless
> device. The
> node is expected to be specified as a child node to the SDIO controller t=
hat
> connects the device to the system.
>
> Required properties:
>
>   - compatible : Should be "brcm,bcm4329-fmac".
> """
>
> Not sure whether this is still true for YAML version (poor YAML reading
> skills ;-) ), but it should as the switch from textual to YAML should
> not have changed the bindings specification.
>
> >  > +
> >  >      /* Apple ARM64 platforms have their own idea of board type,
> > passed in
> >  >       * via the device tree. They also have an antenna SKU parameter
> >  >       */
> >  > @@ -113,8 +118,13 @@ void brcmf_of_probe(struct device *dev, enum
> > brcmf_bus_type bus_type,
> >  >          of_node_put(root);
> >  >      }
> >  >
> >  > -    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> >  > +    clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> >  > +    if (!IS_ERR_OR_NULL(clk)) {
> >  > +        brcmf_dbg(INFO, "enabling 32kHz clock\n");
> >  > +        clk_set_rate(clk, 32768);
> >  > +    } else {
> >  >          return;
> >
> > Why return here? If the clock is optional, a lot of systems will not
> > have it - that shouldn't prevent the driver from probing. And you are
> > still not handling the -EPROBE_DEFER case which was mentioned on your
> > previous submission.
>
> Right. The else statement above could/should be:
>
> } else if (clk && PTR_ERR(clk) =3D=3D -EPROBE_DEFER) {
>          return PTR_ERR(clk);
> }

... plus change the function prototype to return int and propagate
that error code through brcmf_get_module_param to brcmf_pcie_probe's
return value. I guess checking clk for NULL is also redundant in this
case?

Best,
Alexey

