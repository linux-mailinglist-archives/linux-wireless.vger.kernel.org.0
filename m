Return-Path: <linux-wireless+bounces-10808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEDC9445F9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 09:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A745E1C22270
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 07:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971516D4DF;
	Thu,  1 Aug 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/o6HCT6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504719478;
	Thu,  1 Aug 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499065; cv=none; b=r7HxCePPKIe1a0aGOthq7p6Ck/PjaWaWbOyI6jPKRb53tjtmRh5xika66uq1YszLn3sbsiNO8r38u1/gR1+VMwkZ1RbyxZb9zZbVoVxRjSy4mkjffg+hCYoqSHMz5DfToNqQ9l2wz2enCyMem9taaZhEynNwKADdfm40+FO28U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499065; c=relaxed/simple;
	bh=WjopyENnVZGG8BoRkf9D6WdWGKDMbJZhOejX6u3vaig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqtQz+dHnB3FKumxhQJ+g9ct7peo947nJ2nfJcvijiUG6LMg4FRXoSNO6yCvNcZQ8KkapXaU5Pj7x8b9rgdl4NNSq5ZbQIEd8CEfMP84yFdC8JtY0p1x+MpO8P0nSkL7ccdG8VQHgyVhO6AJoVn6FfaHNqzFLwVCnO/I01bdx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/o6HCT6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fdde0c8dcso37245681cf.0;
        Thu, 01 Aug 2024 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722499063; x=1723103863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH9ilRYLYFpvV4bBytWkKj2NHM9xGHTKENKnDvjIGns=;
        b=a/o6HCT68OF+t2teK5Cz3lq9xWq85hAsdl6J+KGs7+VQ2SJNxZFQgTQlf5JhInV8mY
         6bYyR1Llsrh87D43BRTw+G422g4hCqK19tXSXjU1i+H0WvW8eVB/nnqWxwPtjsRYCpWI
         X4Q2B4x9xHXbpdMhKRSdM86OLjym/JPaocrROhvq1uocf3xEcwB35K5fq9oweKpF+fxC
         MibUzj0I1LSjALXsCOIIImGkOVa2OPwQASV2g6kK0mAtq0FDbT036tAh/BnNXrZZG+3j
         NVZLSbcZ04aSNu0hmnTpFRZGeRSrhfNPgpyTFr3dHah/0D4aNeLhRrGBJ5WR3vMeeFMZ
         Qdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722499063; x=1723103863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH9ilRYLYFpvV4bBytWkKj2NHM9xGHTKENKnDvjIGns=;
        b=DqQaAc6RikrgHkxFJyPLSYfxD1KQesyc7ha/FeDjOzXKX0KKvov4kA8dk3+RXsQ3uo
         WWrEX1Hlm0ub8bOVEFonfrc0o10wPqvFbrbdfymU8ZLv1erHNiMusJBzTlp9lnU4Blti
         pzbUr16jfWCzn+If13COJvr4EBqnQ+kf61FaSHpcZmMbVBIYZuHWkYYmJgwVrYhRe1k2
         +Bj7h93cuxOwrEgTblvaWUp/HxL46BZ9buAKbJ/+DSYuTr18ayrVu85a210s5dhjeRfJ
         Leu4oPew0w2pI9ND3oyV9LQ2Y6J6o19Vp0OPbsIg22yASD5f2vGX30nslvfXULyoCI6h
         Tn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTIxMP6s9t7BAWUh7ukBiUjqYBzUOK50fWf79CyV5szH0KE00irpfNaefynP/t0u/1n7WtVTHClX8nbW2vLcmN+dC0JvOnTDrWFAy1bLTX7VjAYwFVAs5r7e5VENcM+oGUTxN6lye27vqeY8rIdCtiY2gWi+CIDVypN41AsfzL0ato9gHo1nS05vFWcN3rcXgfdg4EtTitYjmdsDAMeiU5
X-Gm-Message-State: AOJu0YzCOIVw+MriBEl3fyKqTCqmoA8u0W9BXH2eUR5JgN8n4vFgmnCH
	a1bF3d2EmasDzRmrUGsvBKED9OA3nvverXttLQPCPECJ/o9G65tAJrzU4lewy4xpe/sjbl6gfnz
	bequhfX8thgnOlfj8hl2YWVzS9yA=
X-Google-Smtp-Source: AGHT+IH9Nqcz96fXlR6qBIfn9oQsygGJT+Br+pnt3kTFU6l5J618DOIfg76qe0W8eUEc1gOKhsxpS78Zox8XqTejuMo=
X-Received: by 2002:a05:622a:206:b0:446:5787:875f with SMTP id
 d75a77b69052e-451567b4292mr18705541cf.38.1722499062896; Thu, 01 Aug 2024
 00:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
 <20240731061132.703368-5-jacobe.zang@wesion.com> <0a78a0fb-0a5e-424f-a801-4a63b9ee1a49@gmail.com>
 <3ded8aea-ee11-43da-9dd7-1259cf931747@broadcom.com> <CABjd4YxiSY0A0iVHGHw9RDey+avxmzUapoLLLyf=80MzVX0yWA@mail.gmail.com>
 <6e34c814-a6dc-4a96-9e46-ca25af67f4f6@broadcom.com> <CABjd4YxdCh7EceYOfcFxKtV0H7Von0oZAMWD=69sM6y4-CoAQw@mail.gmail.com>
 <TYZPR03MB7001889335D58561F86978A780B22@TYZPR03MB7001.apcprd03.prod.outlook.com>
In-Reply-To: <TYZPR03MB7001889335D58561F86978A780B22@TYZPR03MB7001.apcprd03.prod.outlook.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 1 Aug 2024 10:57:31 +0300
Message-ID: <CABjd4YwCFpPerXRaR=6zd-61wDE6nH7_s0C6jMRhA4x0L6guLg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] wifi: brcmfmac: Add optional lpo clock enable support
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, 
	"kvalo@kernel.org" <kvalo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"efectn@protonmail.com" <efectn@protonmail.com>, "dsimic@manjaro.org" <dsimic@manjaro.org>, 
	"jagan@edgeble.ai" <jagan@edgeble.ai>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arend@broadcom.com" <arend@broadcom.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz" <megi@xff.cz>, 
	"duoming@zju.edu.cn" <duoming@zju.edu.cn>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"minipli@grsecurity.net" <minipli@grsecurity.net>, 
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>, 
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>, Nick Xie <nick@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 6:53=E2=80=AFAM Jacobe Zang <jacobe.zang@wesion.com>=
 wrote:
>
> >>On 7/31/2024 2:01 PM, Alexey Charkov wrote:
> >>> On Wed, Jul 31, 2024 at 2:15=E2=80=AFPM Arend van Spriel
> >>> <arend.vanspriel@broadcom.com> wrote:
> >>>>
> >>>> On 7/31/2024 12:16 PM, Alexey Charkov wrote:
> >>>>> Hi Jacobe,
> >>>>>
> >>>>>
> >>>>> On 31/07/2024 9:11 am, Jacobe Zang wrote:
> >>>>>   > WiFi modules often require 32kHz clock to function. Add support=
 to
> >>>>>   > enable the clock to PCIe driver and move "brcm,bcm4329-fmac" ch=
eck
> >>>>>   > to the top of brcmf_of_probe
> >>>>>   >
> >>>>>   > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> >>>>>   > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> >>>>>   > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> >>>>>   > ---
> >>>>>   >  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 ++++=
+++++++-
> >>>>>   >  1 file changed, 11 insertions(+), 1 deletion(-)
> >>>>>   >
> >>>>>   > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/o=
f.c
> >>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >>>>>   > index e406e11481a62..7e0a2ad5c7c8a 100644
> >>>>>   > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >>>>>   > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >>>>>   > @@ -6,6 +6,7 @@
> >>>>>   >  #include <linux/of.h>
> >>>>>   >  #include <linux/of_irq.h>
> >>>>>   >  #include <linux/of_net.h>
> >>>>>   > +#include <linux/clk.h>
> >>>>>   >
> >>>>>   >  #include <defs.h>
> >>>>>   >  #include "debug.h"
> >>>>>   > @@ -70,12 +71,16 @@ void brcmf_of_probe(struct device *dev, enu=
m
> >>>>> brcmf_bus_type bus_type,
> >>>>>   >  {
> >>>>>   >      struct brcmfmac_sdio_pd *sdio =3D &settings->bus.sdio;
> >>>>>   >      struct device_node *root, *np =3D dev->of_node;
> >>>>>   > +    struct clk *clk;
> >>>>>   >      const char *prop;
> >>>>>   >      int irq;
> >>>>>   >      int err;
> >>>>>   >      u32 irqf;
> >>>>>   >      u32 val;
> >>>>>   >
> >>>>>   > +    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac=
"))
> >>>>>   > +        return;
> >>>>>
> >>>>> Did you test this? The DTS patch you sent as part of this series do=
esn't
> >>>>> list "brcm,bcm4329-fmac" in the compatible, so this will probably r=
eturn
> >>>>> right here, skipping over the rest of your patch.
> >>>>>
> >>>>> Please test before resending, both with and without the driver for =
the
> >>>>> Bluetooth part of the chip (since it also touches clocks).
> >>>>>
> >>>>> You are also changing the behavior for other systems by putting thi=
s
> >>>>> check further up the probe path, which might break things for no re=
ason.
> >>>>> Better put your clk-related addition below where this check was
> >>>>> originally, rather than reorder stuff you don't have to reorder.
> >>>>
> >>>> That was upon my suggestion. That check was originally at the top of=
 the
> >>>> function, but people added stuff before that. I agree that makes the
> >>>> compatible "brcm,brcm4329-fmac" required which is what the textual
> >>>> binding stated before the switch to YAML was made:
> >>>>
> >>>> """
> >>>> Broadcom BCM43xx Fullmac wireless SDIO devices
> >>>>
> >>>> This node provides properties for controlling the Broadcom wireless
> >>>> device. The
> >>>> node is expected to be specified as a child node to the SDIO control=
ler that
> >>>> connects the device to the system.
> >>>>
> >>>> Required properties:
> >>>>
> >>>>    - compatible : Should be "brcm,bcm4329-fmac".
> >>>> """
> >>>>
> >>>> Not sure whether this is still true for YAML version (poor YAML read=
ing
> >>>> skills ;-) ), but it should as the switch from textual to YAML shoul=
d
> >>>> not have changed the bindings specification.
> >>>>
> >>>>>   > +
> >>>>>   >      /* Apple ARM64 platforms have their own idea of board type=
,
> >>>>> passed in
> >>>>>   >       * via the device tree. They also have an antenna SKU para=
meter
> >>>>>   >       */
> >>>>>   > @@ -113,8 +118,13 @@ void brcmf_of_probe(struct device *dev, en=
um
> >>>>> brcmf_bus_type bus_type,
> >>>>>   >          of_node_put(root);
> >>>>>   >      }
> >>>>>   >
> >>>>>   > -    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac=
"))
> >>>>>   > +    clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> >>>>>   > +    if (!IS_ERR_OR_NULL(clk)) {
> >>>>>   > +        brcmf_dbg(INFO, "enabling 32kHz clock\n");
> >>>>>   > +        clk_set_rate(clk, 32768);
> >>>>>   > +    } else {
> >>>>>   >          return;
> >>>>>
> >>>>> Why return here? If the clock is optional, a lot of systems will no=
t
> >>>>> have it - that shouldn't prevent the driver from probing. And you a=
re
> >>>>> still not handling the -EPROBE_DEFER case which was mentioned on yo=
ur
> >>>>> previous submission.
> >>>>
> >>>> Right. The else statement above could/should be:
> >>>>
> >>>> } else if (clk && PTR_ERR(clk) =3D=3D -EPROBE_DEFER) {
> >>>>           return PTR_ERR(clk);
> >>>> }
> >>>
> >>> ... plus change the function prototype to return int and propagate
> >>> that error code through brcmf_get_module_param to brcmf_pcie_probe's
> >>> return value. I guess checking clk for NULL is also redundant in this
> >>> case?
> >>
> >>Only wanted to give the suggestion to get started. Propagating the
> >>return value seemed obvious to me, but you are absolutely right.
> >>PTR_ERR(NULL) will probably be something else than -EPROBE_DEFER but it
> >>seems odd to me. Maybe PTR_ERR_OR_ZERO(clk) is a better option here.
> >
> > Indeed. Perhaps something along the lines of:
> >
> >        clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> >        if (!IS_ERR_OR_NULL(clk)) {
> >                brcmf_dbg(INFO, "enabling 32kHz clock\n");
> >                return clk_set_rate(clk, 32768);
> >        } else {
> >                return PTR_ERR_OR_ZERO(clk);
> >        }
> >
> > ... which should then go at the very end of brcmf_of_probe. And all of
>
> But before end of brcmf_of_probe is to set interrupt configuration which
> wifi chip connect via sdio. Like this:
> ```
>         if (bus_type !=3D BRCMF_BUSTYPE_SDIO)
>                 return;
>
>         if (of_property_read_u32(np, "brcm,drive-strength", &val) =3D=3D =
0)
>                 sdio->drive_strength =3D val;
>
>         /* make sure there are interrupts defined in the node */
>         if (!of_property_present(np, "interrupts"))
>                 return;
>
>         irq =3D irq_of_parse_and_map(np, 0);
>         if (!irq) {
>                 brcmf_err("interrupt could not be mapped\n");
>                 return;
>         }
>         irqf =3D irqd_get_trigger_type(irq_get_irq_data(irq));
>
>         sdio->oob_irq_supported =3D true;
>         sdio->oob_irq_nr =3D irq;
>         sdio->oob_irq_flags =3D irqf;
> ```
> So I think the interrupt should be set in the if statement while
> bus_type=3D=3DBRCMF_BUSTYPE_SDIO, and add else statement
> to enable clock(or simply put it at the end as Alexey said). And
> can also use else-if statement to deal with
> bus_type =3D=3D BRCMF_BUSTYPE_USB or PCIE in the future.

SDIO devices might also want to enable a clock, so I think wrapping
the drive strength and interrupts handling into an if statement and
putting the clock-related stuff right after it (but not in the else
block) is better.

Best regards,
Alexey

