Return-Path: <linux-wireless+bounces-10746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B9942F7E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 15:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B216B1C21131
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC85A1B1421;
	Wed, 31 Jul 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edJdJ41D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164391B1409;
	Wed, 31 Jul 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430592; cv=none; b=I6asboWcyibPotVKFJz2XsUDKoUYh+z4Yu9Nu0xq9LsknqeJzfCASSf716f/Wo1JQHJD6fBzIhWH5qnSjPnilX/2ykL88apOC3UPvZ8DlnQvXGDly9FEwYJZ5qUUtM64kWGzqbf888uTalVv/YArip44T61R6CgzduHPMywNxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430592; c=relaxed/simple;
	bh=ReKHMmunPvE+vcGTa+O4hLPOMROj0UD+UoMrTRavCqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqHOpBTp/84E/qYkP+d+FKbTZv3Z+p6iVKSbl5BjusM0L3LnF2fFI6sS1GshlxpYPHdVPBDYYTSfyAF0VSAmPmtzifnpsMkb/F2M6MjKSDsuIEzY31VBjo0l2VWKrAFPRXPFUha9Ry+7e9fDDMCC/GWgUKEEZrfAnYla58OckpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edJdJ41D; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44ff132ff9cso32813131cf.2;
        Wed, 31 Jul 2024 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722430590; x=1723035390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1seQq6pVWKt421meYywLs/KfxY3tgGQZFmNZ1IQhRhU=;
        b=edJdJ41DLGIZg04oxN1omytOV3hoDzvHbWFbAQUDz6vr9mEWElY6C6p65x4+WoCFid
         cOv9/hDeB1feT2eEsYamUArczWlhwTalZL+QfluGvogIYWfUUqeQMYA6GuGlBE2WUbP7
         7YtxBZUcV/5etyCk0TDl/ZmbrSODNw4QN86y1Qep45nsVdTXGxTjx+0fxeb09P6emlGE
         8zKcaEHMvb/V7pmWjwGa3JX8zc4PsUjLQcxMDegpAXAy2pg4tfr58HpeMN2iZZ8qcPzk
         9UIKpz2SZcWcfnhcNEzFFuXCqocTH8edLyQhnV+MfUxF7OP2Stez4vY4D9CJyYTb2Vwp
         1YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722430590; x=1723035390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1seQq6pVWKt421meYywLs/KfxY3tgGQZFmNZ1IQhRhU=;
        b=LMH++SyO1cub5vMYMxvEpI/ob68OHdRNVf8O2ro3pw+gu6s6sSXLKB9blOoHjNHbV7
         1zZZRGgm5CXyT1sobf43Rs0M7Mv6+wDqYpXTyrTqz0PdfHbBQUGby0IuUobtFk5fuG6T
         K/7oIt7JfkYSMkSH0khYwZIixisLwI+2RMkjoHZ1zgS5toLxBPRD+Ene7ZQmxoMwc34e
         Y6NduA5q0bk2vZPQVyyX7yjShnqr1Y6HC4zvWq9dB1z+uHWHTzuXTu45VUSY/QSJAood
         Oa6JcVhZza5jqxH42fldadQS8vY4/3y4NWjNN7XO4p3FON81K49+aBtCOyMfDuhZkNT2
         yZYg==
X-Forwarded-Encrypted: i=1; AJvYcCUCXjOQKv8shvr6SHnG26Gvj2O3wYOnCg5z+VTlA8pXx8jq8/hXu//FPi9aJk12qrNJjTmPbSBbQ7r9+LjYL62OlStxm68MuM7PLBVupyC/DB4fHMFtvRJfNIzFcfY1iI78d6jbn+UATy0o+ZrJgU9wGBpJ9T8Leq2KSt1ZwtJrO8QpdXuRbUseaPA9/FPh6C0+z5W6a5HKgi0UiQX4nmNM
X-Gm-Message-State: AOJu0Yx9nGfLzpSjKoc34YXD8vQBP1kvSb6VQAEvdnN33KZov/4c2MCB
	7AR+IZR8bFYMdH/3XejqApy8TBW2KQpq/B9iw1UADGuhQ1Szp7B5eOY6WNK4N1vx7NWLx9sjXHD
	rS+eO8Bih+ciAnVcjWCkel1M5KRo=
X-Google-Smtp-Source: AGHT+IHjDtpIf0QCPWYz+XhMAa8yvBe/ManCTONa09BmUisSVpzkusuCKuxED1ndPBdlxCf66ZyqBkZoqGckyZQwO10=
X-Received: by 2002:ac8:7d10:0:b0:447:f469:b58d with SMTP id
 d75a77b69052e-45004f4e214mr187667771cf.42.1722430589901; Wed, 31 Jul 2024
 05:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
 <20240731061132.703368-5-jacobe.zang@wesion.com> <0a78a0fb-0a5e-424f-a801-4a63b9ee1a49@gmail.com>
 <3ded8aea-ee11-43da-9dd7-1259cf931747@broadcom.com> <CABjd4YxiSY0A0iVHGHw9RDey+avxmzUapoLLLyf=80MzVX0yWA@mail.gmail.com>
 <6e34c814-a6dc-4a96-9e46-ca25af67f4f6@broadcom.com>
In-Reply-To: <6e34c814-a6dc-4a96-9e46-ca25af67f4f6@broadcom.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 31 Jul 2024 15:56:18 +0300
Message-ID: <CABjd4YxdCh7EceYOfcFxKtV0H7Von0oZAMWD=69sM6y4-CoAQw@mail.gmail.com>
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

On Wed, Jul 31, 2024 at 3:32=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 7/31/2024 2:01 PM, Alexey Charkov wrote:
> > On Wed, Jul 31, 2024 at 2:15=E2=80=AFPM Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On 7/31/2024 12:16 PM, Alexey Charkov wrote:
> >>> Hi Jacobe,
> >>>
> >>>
> >>> On 31/07/2024 9:11 am, Jacobe Zang wrote:
> >>>   > WiFi modules often require 32kHz clock to function. Add support t=
o
> >>>   > enable the clock to PCIe driver and move "brcm,bcm4329-fmac" chec=
k
> >>>   > to the top of brcmf_of_probe
> >>>   >
> >>>   > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> >>>   > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> >>>   > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> >>>   > ---
> >>>   >  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 ++++++=
+++++-
> >>>   >  1 file changed, 11 insertions(+), 1 deletion(-)
> >>>   >
> >>>   > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.=
c
> >>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >>>   > index e406e11481a62..7e0a2ad5c7c8a 100644
> >>>   > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >>>   > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >>>   > @@ -6,6 +6,7 @@
> >>>   >  #include <linux/of.h>
> >>>   >  #include <linux/of_irq.h>
> >>>   >  #include <linux/of_net.h>
> >>>   > +#include <linux/clk.h>
> >>>   >
> >>>   >  #include <defs.h>
> >>>   >  #include "debug.h"
> >>>   > @@ -70,12 +71,16 @@ void brcmf_of_probe(struct device *dev, enum
> >>> brcmf_bus_type bus_type,
> >>>   >  {
> >>>   >      struct brcmfmac_sdio_pd *sdio =3D &settings->bus.sdio;
> >>>   >      struct device_node *root, *np =3D dev->of_node;
> >>>   > +    struct clk *clk;
> >>>   >      const char *prop;
> >>>   >      int irq;
> >>>   >      int err;
> >>>   >      u32 irqf;
> >>>   >      u32 val;
> >>>   >
> >>>   > +    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac")=
)
> >>>   > +        return;
> >>>
> >>> Did you test this? The DTS patch you sent as part of this series does=
n't
> >>> list "brcm,bcm4329-fmac" in the compatible, so this will probably ret=
urn
> >>> right here, skipping over the rest of your patch.
> >>>
> >>> Please test before resending, both with and without the driver for th=
e
> >>> Bluetooth part of the chip (since it also touches clocks).
> >>>
> >>> You are also changing the behavior for other systems by putting this
> >>> check further up the probe path, which might break things for no reas=
on.
> >>> Better put your clk-related addition below where this check was
> >>> originally, rather than reorder stuff you don't have to reorder.
> >>
> >> That was upon my suggestion. That check was originally at the top of t=
he
> >> function, but people added stuff before that. I agree that makes the
> >> compatible "brcm,brcm4329-fmac" required which is what the textual
> >> binding stated before the switch to YAML was made:
> >>
> >> """
> >> Broadcom BCM43xx Fullmac wireless SDIO devices
> >>
> >> This node provides properties for controlling the Broadcom wireless
> >> device. The
> >> node is expected to be specified as a child node to the SDIO controlle=
r that
> >> connects the device to the system.
> >>
> >> Required properties:
> >>
> >>    - compatible : Should be "brcm,bcm4329-fmac".
> >> """
> >>
> >> Not sure whether this is still true for YAML version (poor YAML readin=
g
> >> skills ;-) ), but it should as the switch from textual to YAML should
> >> not have changed the bindings specification.
> >>
> >>>   > +
> >>>   >      /* Apple ARM64 platforms have their own idea of board type,
> >>> passed in
> >>>   >       * via the device tree. They also have an antenna SKU parame=
ter
> >>>   >       */
> >>>   > @@ -113,8 +118,13 @@ void brcmf_of_probe(struct device *dev, enum
> >>> brcmf_bus_type bus_type,
> >>>   >          of_node_put(root);
> >>>   >      }
> >>>   >
> >>>   > -    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac")=
)
> >>>   > +    clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> >>>   > +    if (!IS_ERR_OR_NULL(clk)) {
> >>>   > +        brcmf_dbg(INFO, "enabling 32kHz clock\n");
> >>>   > +        clk_set_rate(clk, 32768);
> >>>   > +    } else {
> >>>   >          return;
> >>>
> >>> Why return here? If the clock is optional, a lot of systems will not
> >>> have it - that shouldn't prevent the driver from probing. And you are
> >>> still not handling the -EPROBE_DEFER case which was mentioned on your
> >>> previous submission.
> >>
> >> Right. The else statement above could/should be:
> >>
> >> } else if (clk && PTR_ERR(clk) =3D=3D -EPROBE_DEFER) {
> >>           return PTR_ERR(clk);
> >> }
> >
> > ... plus change the function prototype to return int and propagate
> > that error code through brcmf_get_module_param to brcmf_pcie_probe's
> > return value. I guess checking clk for NULL is also redundant in this
> > case?
>
> Only wanted to give the suggestion to get started. Propagating the
> return value seemed obvious to me, but you are absolutely right.
> PTR_ERR(NULL) will probably be something else than -EPROBE_DEFER but it
> seems odd to me. Maybe PTR_ERR_OR_ZERO(clk) is a better option here.

Indeed. Perhaps something along the lines of:

       clk =3D devm_clk_get_optional_enabled(dev, "lpo");
       if (!IS_ERR_OR_NULL(clk)) {
               brcmf_dbg(INFO, "enabling 32kHz clock\n");
               return clk_set_rate(clk, 32768);
       } else {
               return PTR_ERR_OR_ZERO(clk);
       }

... which should then go at the very end of brcmf_of_probe. And all of
the existing void returns should get appropriate errno's. And the
functions prototypes should be updated along the call chain. And then
it would still only work after pwrseq is added to ensure that power
and wake signals are applied correctly along with this clock, as
Sebastian pointed out in the other thread :)

Which really prompts a question: should this clock be added to the
PCIe driver and the respective DT binding in the first place, or
should it instead be claimed by pwrseq, leaving brcmfmac alone?

Best regards,
Alexey

