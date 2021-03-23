Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52633468A7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 20:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhCWTNN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 15:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbhCWTMo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 15:12:44 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED199C061765
        for <linux-wireless@vger.kernel.org>; Tue, 23 Mar 2021 12:12:43 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id t71so2485768vst.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Mar 2021 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NziR4wdTwbPmQRK5YhnnRmXhP9symav7D77le3H4K+M=;
        b=PMVJrfgoW6IO/eykiWrjsd3M2rhVX4YPMZxActq4wpEAmRKoODLJqZ5eOI8hAd3Ui/
         kSzrQ3FuaOzZIBiwn4SSeTiH56nva7fJ7jwJArxrKBI9I08bC2iOW/X4AFzNtLAsNXVw
         fIdYVNCx+ySgZrYUG4o13ipFMssy5VH6uWnpKJyoinFpA+/8heYRsB9WTXd4ONt/Bv7O
         +LCu9D9LBylKYOceGf33CRSQzA3Vf9iXuF4A9rSuewX9xMRvJ+rKmskixMa6u1701MFN
         KAZ3CnQdmXTvVit/bpC9d7KazulRxJUeQ0HNNX5bneUJLaxYamCbK0WSNJFdJKmbm+5W
         bGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NziR4wdTwbPmQRK5YhnnRmXhP9symav7D77le3H4K+M=;
        b=b6fzzed7UDHwkGHoYUxQDeaaGPNukshoqnPxIWKPFX2IfnPOM6f6N1mfOyMYJp9xMu
         uU9RwEpRrTze/RgenJ9XDWvp33k28a+YWbo5RS7TK5zCH74SgSFpB1dPAPiumG4ste8j
         CZUJ0vdSeBXBfu+n90fS6WYKWWTrZpbM5hr6eDPEVB9xOO8xFNV4a9EeRZBUs0748Bnf
         ciL0+rzZm1lxTooqArwTEoht1ws++iZd92i+AeQbHsDKyhwGI5hC19Mvq2vCNweMw0WX
         QWOpkUmF5MwCXzx4g/I6CUQngz5kCKvR4pFlurzNnzWNlvQ8KepntZRjr8p26IorvExm
         Q55A==
X-Gm-Message-State: AOAM532ZT73aA/gqw8tNlcGC64i8HGCfOko5te+qUkQhwuE5LwgH6MNC
        bCdTTSUcDDE6jxseKnYfEQZ66dVgMYg8sGnG6kYnZA==
X-Google-Smtp-Source: ABdhPJzXFydY5TcCz9J1Or2xn4GBkykV9ba3oKyGbccCBa4HxmuOl+Gv/PYBfFODfgfgi/kqTbKgrJDTOyQZhsuqwfY=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr4758525vsc.55.1616526762989;
 Tue, 23 Mar 2021 12:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210315132501.441681-1-Jerome.Pouiller@silabs.com>
 <4503971.bAhddQ8uqO@pc-42> <CAPDyKFoXgV3m-rMKfjqRj91PNjOGaWg6odWG-EGdFKkL+dGWoA@mail.gmail.com>
 <5713463.b6Cmjs1FeV@pc-42>
In-Reply-To: <5713463.b6Cmjs1FeV@pc-42>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Mar 2021 20:12:06 +0100
Message-ID: <CAPDyKFrONrUvbVVVF9iy4P17jZ_Fq+1pGMmsqM6C1hOXOWQnBw@mail.gmail.com>
Subject: Re: [PATCH v5 08/24] wfx: add bus_sdio.c
To:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 23 Mar 2021 at 18:53, J=C3=A9r=C3=B4me Pouiller
<jerome.pouiller@silabs.com> wrote:
>
> On Tuesday 23 March 2021 15:11:56 CET Ulf Hansson wrote:
> > On Mon, 22 Mar 2021 at 18:14, J=C3=A9r=C3=B4me Pouiller <jerome.pouille=
r@silabs.com> wrote:
> > > On Monday 22 March 2021 13:20:35 CET Ulf Hansson wrote:
> > > > On Mon, 15 Mar 2021 at 14:25, Jerome Pouiller <Jerome.Pouiller@sila=
bs.com> wrote:
> > > > >
> > > > > From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> > > > >
> > > > > Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.=
com>
> > > > > ---
> > > > >  drivers/net/wireless/silabs/wfx/bus_sdio.c | 259 +++++++++++++++=
++++++
> > > > >  1 file changed, 259 insertions(+)
> > > > >  create mode 100644 drivers/net/wireless/silabs/wfx/bus_sdio.c
> > > >
> > > > [...]
> > > >
> > > > > +static const struct sdio_device_id wfx_sdio_ids[] =3D {
> > > > > +       { SDIO_DEVICE(SDIO_VENDOR_ID_SILABS, SDIO_DEVICE_ID_SILAB=
S_WF200) },
> > > > > +       { },
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(sdio, wfx_sdio_ids);
> > > > > +
> > > > > +struct sdio_driver wfx_sdio_driver =3D {
> > > > > +       .name =3D "wfx-sdio",
> > > > > +       .id_table =3D wfx_sdio_ids,
> > > > > +       .probe =3D wfx_sdio_probe,
> > > > > +       .remove =3D wfx_sdio_remove,
> > > > > +       .drv =3D {
> > > > > +               .owner =3D THIS_MODULE,
> > > > > +               .of_match_table =3D wfx_sdio_of_match,
> > > >
> > > > It's not mandatory to support power management, like system
> > > > suspend/resume. However, as this looks like this is a driver for an
> > > > embedded SDIO device, you probably want this.
> > > >
> > > > If that is the case, please assign the dev_pm_ops here and implemen=
t
> > > > the ->suspend|resume() callbacks.
> > >
> > > I have no platform to test suspend/resume, so I have only a
> > > theoretical understanding of this subject.
> >
> > I see.
> >
> > >
> > > I understanding is that with the current implementation, the
> > > device will be powered off on suspend and then totally reset
> > > (including reloading of the firmware) on resume. I am wrong?
> >
> > You are correct, for a *removable* SDIO card. In this case, the
> > mmc/sdio core will remove the corresponding SDIO card/device and its
> > corresponding SDIO func devices at system suspend. It will then be
> > redetected at system resume (and the SDIO func driver re-probed).
> >
> > Although, as this is an embedded SDIO device, per definition it's not
> > a removable card (MMC_CAP_NONREMOVABLE should be set for the
> > corresponding mmc host), the SDIO card will stick around and instead
> > the ->suspend|resume() callback needs to be implemented for the SDIO
> > func driver.
>
> If I follow what has been done in other drivers I would write something
> like:
>
>   static int wfx_sdio_suspend(struct device *dev)
>   {
>           struct sdio_func *func =3D dev_to_sdio_func(dev);
>           struct wfx_sdio_priv *bus =3D sdio_get_drvdata(func);
>
>           config_reg_write_bits(bus->core, CFG_IRQ_ENABLE_DATA, 0);
>           // Necessary to keep device firmware in RAM
>           return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);

This will tell the mmc/sdio core to keep the SDIO card powered on
during system suspend. Thus, it doesn't need to re-initialize it at
system resume - and the firmware should not need to be re-programmed.

On the other hand, if you don't plan to support system wakeups, it
would probably be better to power off the card, to avoid wasting
energy while the system is suspended. I assume that means you need to
re-program the firmware as well. Normally, it's these kinds of things
that need to be managed from a ->resume() callback.

>   }
>
> However, why not the implementation below?
>
>   static int wfx_sdio_suspend(struct device *dev)
>   {
>           struct sdio_func *func =3D dev_to_sdio_func(dev);
>
>           wfx_sdio_remove(func);

I don't know what wfx_sdio_remove() does, but for sure you would need
a ->resume() callback to make it possible to restore power/firmware.

>           return 0;
>   }
>
> In both cases, I worry to provide these functions without being able to
> test them.

Alright, let's simply leave this driver without having the PM
callbacks assigned. I guess we can revisit this at some later point.

The mmc core will log a message about the missing callbacks, in case
someone tries to execute system suspend/resume when the driver has
been probed.

Kind regards
Uffe
