Return-Path: <linux-wireless+bounces-11420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C5195180A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740A81F239FA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168B419F461;
	Wed, 14 Aug 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfD0Jj3A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA813634A;
	Wed, 14 Aug 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628934; cv=none; b=FUa5WxjbZAZ2KnPyWiQxSB3rhcii8Ztoyi3e/aFGZ0L3ffTn2RfE10nuUlDCtCHOO+nDZA1OzfLCstsd13lr+UguDtGfP5FHY1WRJW9R4Mz9HeruZE3/MmdhLjTgxu6gOJ1/nCC+ramxuarK+yPEP9L5ROTVbxZJp1Xmco8Rmkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628934; c=relaxed/simple;
	bh=n7denkbqhgALgUseHii2av+n0Qsgr2MUbPt4EdOcoJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOKVnO3N6E9BdCvzs5moG/RoY+JVWql7wKxvRJjj0+Fz9oZM5W7oLHujd6HoDS/i25nnqH2YCZM4GBV0B3bvXZ9Kq3rvFGsMcAa6OGX2xzm9TgIxne8z8UFtoXSXvRniNFxqwGFft0YkkJf7AesrB7xrrqViQlNgIPDOrAWScYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfD0Jj3A; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45006bcb482so33265181cf.3;
        Wed, 14 Aug 2024 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723628930; x=1724233730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E9dz5B79iMiE9YR//5bouzEa+H1xHgYZ6HkutyLa1Y=;
        b=lfD0Jj3AtDHTvE1rBghXqvTCIlKoyuNDCJrkAFJVnA3dJswod5ICcDOeLbeFnW/0Mo
         XK36fGS4gB35K5/QVKIPYuph34rOkp1wbjwGzEN5TzcmXWLkCYs7jjpjuYc5HgDZKXVS
         XqqSSzQB8ASidxWMTIgS2QOFYuDh7JK0r9zTFTwf4Mci/dhl/TVqTngXF4Q0nGDWenQl
         SoaFkuCtIcxh/C0whwmN50YnK3CXNgbqpaOKMMoKR4uAh1qQP/HsNWxpjRSRonPbjjTO
         38IvLnzjVSuV9NAGKfiQGRD8JiPam78eYq/Kb7/AgdxVW2is+3XG64RSY6ce/BVlrBcN
         UJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628930; x=1724233730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7E9dz5B79iMiE9YR//5bouzEa+H1xHgYZ6HkutyLa1Y=;
        b=a2KST69iSvUeftA/ySliFcHK42QHbGtYiU8aaipU48kfoKdLvcy10UXhJduGHstSK1
         vreip/Ao+9vreOkB2kziC4ykuuJrM62Cl42udrM+JPQQzJMvnqNN8hluO48MnhOb/kNa
         ek5odNTNtTAg+iKiAFU68Nwdk419iGLjUtYeXZxkoI12j2b9b6brsxY9xYEU/HfN734R
         +HlWJEcg80+dJzgGwJHbRgJWWUzfP1k7RCR22G6O3zTxdW+dLtG/59TE0cvBGZhV2w82
         x5cAgzRdxT+Y7PvR+dqI7HVoutAcZfvRoGkx/QZ+kM8KxyjdVHC6ycD7ScZ3qlxA7tbE
         LZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnmb5VQ7GT0AN91v6fPMXd2oZQ6iJ3m0/04RjrINNdcMPwGpACEt515peq+uU1kNyfmc7KzvvyZWdIrnD/tbON3uvx/6DnRf4J2sAdMmkr6EwxQCOx+Jiedy7B/MFLA5ZV+1V0BHQSUjo4fXRwjqIejDN9bkfIOfHzorZkwJ2gDEp408yBWNeYZy0CyAHlT2rU0ANuyoQ0wMLd0UxeyZ7F
X-Gm-Message-State: AOJu0YwVKgCL46KRSjHKAvFjrKkiLPicS/2v6oLWlmwIQohobyk6PAoU
	gfvZAlwoh+MyZIz4ugY/E7JohiEyho6X4ycsbRyOIopULMREyvERjvHJEKarxGuxcLAim1dw8IK
	QqaqZ9XqLNQvPgILdBSyVwlD2J2M=
X-Google-Smtp-Source: AGHT+IHHkrK7mmSRX+NFljHlJety4di7IkukkrNgDqvQHopRybi91eO1UnO/AUVkPQhhdbCRrGEPu+h2HKURrxKNdnc=
X-Received: by 2002:a05:622a:40cc:b0:447:e562:b6b with SMTP id
 d75a77b69052e-4535bbd981fmr26069981cf.64.1723628930043; Wed, 14 Aug 2024
 02:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
 <20240813082007.2625841-5-jacobe.zang@wesion.com> <721da64c-42ec-4be6-8ad3-e2685a84823a@broadcom.com>
 <2269063.vFx2qVVIhK@latitude-fedora> <fa019ee9-3f4d-4bea-92a7-929713518dc9@wesion.com>
In-Reply-To: <fa019ee9-3f4d-4bea-92a7-929713518dc9@wesion.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 14 Aug 2024 12:48:39 +0300
Message-ID: <CABjd4YwTbG8pm_xwrOVtVwMwvarvz2SB9bapH3LDMqPn6pH9Ew@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] wifi: brcmfmac: Add optional lpo clock enable support
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	conor+dt@kernel.org, linux-rockchip@lists.infradead.org, 
	efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, arend@broadcom.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, megi@xff.cz, 
	duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	nick@khadas.com, Sai Krishna <saikrishnag@marvell.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:27=E2=80=AFPM Jacobe Zang <jacobe.zang@wesion.co=
m> wrote:
>
>
>
> On 2024/8/14 16:47, Alexey Charkov wrote:
> > Hi Arend, Jacobe,
> >
> > On Tuesday, August 13, 2024 2:57:28=E2=80=AFPM GMT+3 Arend van Spriel w=
rote:
> >> On 8/13/2024 10:20 AM, Jacobe Zang wrote:
> >>> WiFi modules often require 32kHz clock to function. Add support to
> >>> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> >>> to the top of brcmf_of_probe. Change function prototypes from void
> >>> to int and add appropriate errno's for return values that will be
> >>> send to bus when error occurred.
> >>
> >> I was going to say it looks good to me, but....
> >>
> >>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> >>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> >>> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> >>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> >>> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> >>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> >>> ---
> >>>
> >>>    .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
> >>>    .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
> >>>    .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++----=
----
> >>>    .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
> >>>    .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
> >>>    .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++---
> >>>    .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
> >>>    7 files changed, 61 insertions(+), 36 deletions(-)
> >>
> >> [...]
> >>
> >>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c index
> >>> e406e11481a62..f19dc7355e0e8 100644
> >>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> >>
> >> [...]
> >>
> >>> @@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum
> >>> brcmf_bus_type bus_type,>
> >>>             of_node_put(root);
> >>>
> >>>     }
> >>>
> >>> -   if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> >>> -           return;
> >>> -
> >>>
> >>>     err =3D brcmf_of_get_country_codes(dev, settings);
> >>>     if (err)
> >>>
> >>>             brcmf_err("failed to get OF country code map (err=3D%d)
> > \n", err);
> >>>
> >>>     of_get_mac_address(np, settings->mac);
> >>>
> >>> -   if (bus_type !=3D BRCMF_BUSTYPE_SDIO)
> >>> -           return;
> >>> +   if (bus_type =3D=3D BRCMF_BUSTYPE_SDIO) {
> >>
> >> Don't like the fact that this now has an extra indentation level and i=
t
> >> offers no extra benefit. Just keep the original if-statement and retur=
n
> >> 0. Consequently the LPO clock code should move just before the if-stat=
ement.
> >>> +           if (of_property_read_u32(np, "brcm,drive-strength",
> > &val) =3D=3D 0)
> >>> +                   sdio->drive_strength =3D val;
> >>>
> >>> -   if (of_property_read_u32(np, "brcm,drive-strength", &val) =3D=3D =
0)
> >>> -           sdio->drive_strength =3D val;
> >>> +           /* make sure there are interrupts defined in the node */
> >>> +           if (!of_property_present(np, "interrupts"))
> >>> +                   return 0;
> >>>
> >>> -   /* make sure there are interrupts defined in the node */
> >>> -   if (!of_property_present(np, "interrupts"))
> >>> -           return;
> >>> +           irq =3D irq_of_parse_and_map(np, 0);
> >>> +           if (!irq) {
> >>> +                   brcmf_err("interrupt could not be
> > mapped\n");
> >>> +                   return 0;
> >>> +           }
> >>> +           irqf =3D irqd_get_trigger_type(irq_get_irq_data(irq));
> >>> +
> >>> +           sdio->oob_irq_supported =3D true;
> >>> +           sdio->oob_irq_nr =3D irq;
> >>> +           sdio->oob_irq_flags =3D irqf;
> >>> +   }
> >>>
> >>> -   irq =3D irq_of_parse_and_map(np, 0);
> >>> -   if (!irq) {
> >>> -           brcmf_err("interrupt could not be mapped\n");
> >>> -           return;
> >>> +   clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> >>> +   if (!IS_ERR_OR_NULL(clk)) {
> >>> +           brcmf_dbg(INFO, "enabling 32kHz clock\n");
> >>> +           return clk_set_rate(clk, 32768);
> >>> +   } else {
> >>> +           return PTR_ERR_OR_ZERO(clk);
> >>>
> >>>     }
> >>
> >> Change this to:
> >>   > +        clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> >>   > +        if (IS_ERR_OR_NULL(clk)) {
> >>   > +                return PTR_ERR_OR_ZERO(clk);
> >
> > Perhaps in this case we should go for IS_ERR and PTR_ERR respectively.
> > devm_clk_get_optional_enabled would return NULL when the optional clock=
 is not
> > found, so NULL is not an error state but serves as a dummy clock that c=
an be> used with clk_set_rate.
>
> I think we don't need to set clock rate for clock is NULL. So it should
> be changed to:
>
> +       clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> +       if (IS_ERR(clk)) {
> +               return PTR_ERR(clk);
> +       } else if (clk) {
> +               brcmf_dbg(INFO, "enabling 32kHz clock\n");
> +               clk_set_rate(clk, 32768);
> +       }

If clk is NULL then clk_set_rate returns immediately with status zero,
so there is little difference from whether you wrap it into another if
(clk) or not. You can probably drop the debug statement altogether and
call clk_set_rate unconditionally - this will look neater.

Best regards,
Alexey

