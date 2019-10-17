Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E1DA2A2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 02:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbfJQAWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 20:22:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43010 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbfJQAWY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 20:22:24 -0400
Received: by mail-io1-f66.google.com with SMTP id v2so758470iob.10
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 17:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssXZYIfbBoFlq5o8fLFe5texKrdyJMrZYOXv4r4D2eM=;
        b=YaFT1Q5meCXdX8c6PZ7iRxWAGR3vsMIrZ4+0Y3+B6CPkpxiLnnwfpPv58dvBDfyB+J
         5KIa35vr8kmEsKqso7MTr5vdDzYVfXdtCbpprTk3yX+Lg6zsTkplbzXvre1UnbJI6hDe
         PVkqbLvb1vrKxIFOxfVSIPBrqSFlFyecIo8f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssXZYIfbBoFlq5o8fLFe5texKrdyJMrZYOXv4r4D2eM=;
        b=HvgaLrhS9o2XHWBXQrQ7UyemHRxyOD6Dba48EtgWn7FRXtjphZyb/SwzzuVn+c4FWe
         pZ22sK5HuVcmq7RRJWHXzhrPguT5YA3EpzNbrgfwIWqd1JruzTTtipxWxSrdDIPkuM8Z
         6gA291n2L3hZdukNLEp1TaydigdygTYJe48W7eKqw+TmeWhVauIJ1M8CgaW5dKgh8jzp
         SvvYxkIJz0+IGYhn4u/5NlNOoIemOpjLA4NmczejMMQomo4P7o53oFbiOtYpn/l58zb2
         ca1qW7JxIiVQssRWfIcsJnB1fq14tRxNOY865ocPhJLBY8j0s3gUkN896dFeTfM1yxAE
         Gyvw==
X-Gm-Message-State: APjAAAVCVCslNexynS5M1gvV7G4sG9BdO/tVq2V0EJwzgFGIYGt5YTa5
        KqMzyF0+jtBj8b6IXHjzF7CVvLkwetk=
X-Google-Smtp-Source: APXvYqx7vZK79x+wo2Hx8UKSndJyamcEsrDMZ4GrOKx4kZTJogsQfgRWoTWXk84H8HPZ+CmBgVa11g==
X-Received: by 2002:a02:c015:: with SMTP id y21mr730195jai.138.1571271742829;
        Wed, 16 Oct 2019 17:22:22 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id z16sm123940iol.64.2019.10.16.17.22.21
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 17:22:21 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id c12so312664ilm.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 17:22:21 -0700 (PDT)
X-Received: by 2002:a92:819c:: with SMTP id q28mr703756ilk.269.1571271741101;
 Wed, 16 Oct 2019 17:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190722193939.125578-1-dianders@chromium.org>
 <20190722193939.125578-2-dianders@chromium.org> <CAPDyKFpKWo4n+nmBXVcDc4TNzFV3vc+3aeKcu_nKaB=hj=RKUQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpKWo4n+nmBXVcDc4TNzFV3vc+3aeKcu_nKaB=hj=RKUQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Oct 2019 17:22:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WTKy3PmMSCbjKA_Ro_MP+dFE89oCzi_Bs7YeCrcD+3Xg@mail.gmail.com>
Message-ID: <CAD=FV=WTKy3PmMSCbjKA_Ro_MP+dFE89oCzi_Bs7YeCrcD+3Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: Add sdio_trigger_replug() API
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Andreas Fenkart <afenkart@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        netdev <netdev@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Xinming Hu <huxinming820@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Oct 10, 2019 at 7:11 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 22 Jul 2019 at 21:41, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > When using Marvell WiFi SDIO cards, it is not uncommon for Linux WiFi
> > driver to fully lose the communication channel to the firmware running
> > on the card.  Presumably the firmware on the card has a bug or two in
> > it and occasionally crashes.
> >
> > The Marvell WiFi driver attempts to recover from this problem.
> > Specifically the driver has the function mwifiex_sdio_card_reset()
> > which is called when communcation problems are found.  That function
> > attempts to reset the state of things by utilizing the mmc_hw_reset()
> > function.
> >
> > The current solution is a bit complex because the Marvell WiFi driver
> > needs to manually deinit and reinit the WiFi driver around the reset
> > call.  This means it's going through a bunch of code paths that aren't
> > normally tested.  However, complexity isn't our only problem.  The
> > other (bigger) problem is that Marvell WiFi cards are often combo
> > WiFi/Bluetooth cards and Bluetooth runs on a second SDIO func.  While
> > the WiFi driver knows that it should re-init its own state around the
> > mmc_hw_reset() call there is no good way to inform the Bluetooth
> > driver.  That means that in Linux today when you reset the Marvell
> > WiFi driver you lose all Bluetooth communication.  Doh!
>
> Thanks for a nice description to the problem!
>
> In principle it makes mmc_hw_reset() quite questionable to use for
> SDIO func drivers, at all. However, let's consider that for later.

Yeah, unless you somehow knew that your card would only have one function.


> > One way to fix the above problems is to leverage a more standard way
> > to reset the Marvell WiFi card where we go through the same code paths
> > as card unplug and the card plug.  In this patch we introduce a new
> > API call for doing just that: sdio_trigger_replug().  This API call
> > will trigger an unplug of the SDIO card followed by a plug of the
> > card.  As part of this the card will be nicely reset.
>
> I have been thinking back and forth on this, exploring various
> options, perhaps adding some callbacks that the core could invoke to
> inform the SDIO func drivers of what is going on.
>
> Although, in the end this boils done to complexity and I think your
> approach is simply the most superior in regards to this. However, I
> think there is a few things that we can do to even further simply your
> approach, let me comment on the code below.

Right.  Unplugging / re-plugging is sorta gross / inelegant, but it is
definitely simpler and nice that it doesn't add so many new code
paths.  For cases where you're just trying to re-init things with a
hammer it works pretty well.


> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> > Changes in v2:
> > - s/routnine/routine (Brian Norris, Matthias Kaehlcke).
> > - s/contining/containing (Matthias Kaehlcke).
> > - Add Matthias Reviewed-by tag.
> >
> >  drivers/mmc/core/core.c       | 28 ++++++++++++++++++++++++++--
> >  drivers/mmc/core/sdio_io.c    | 20 ++++++++++++++++++++
> >  include/linux/mmc/host.h      | 15 ++++++++++++++-
> >  include/linux/mmc/sdio_func.h |  2 ++
> >  4 files changed, 62 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 221127324709..5da365b1fdb4 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2161,6 +2161,12 @@ int mmc_sw_reset(struct mmc_host *host)
> >  }
> >  EXPORT_SYMBOL(mmc_sw_reset);
> >
> > +void mmc_trigger_replug(struct mmc_host *host)
> > +{
> > +       host->trigger_replug_state = MMC_REPLUG_STATE_UNPLUG;
> > +       _mmc_detect_change(host, 0, false);
> > +}
> > +
> >  static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
> >  {
> >         host->f_init = freq;
> > @@ -2214,6 +2220,11 @@ int _mmc_detect_card_removed(struct mmc_host *host)
> >         if (!host->card || mmc_card_removed(host->card))
> >                 return 1;
> >
> > +       if (host->trigger_replug_state == MMC_REPLUG_STATE_UNPLUG) {
> > +               mmc_card_set_removed(host->card);
> > +               return 1;
>
> Do you really need to set state of the card to "removed"?
>
> If I understand correctly, what you need is to allow mmc_rescan() to
> run a second time, in particular for non removable cards.
>
> In that path, mmc_rescan should find the card being non-functional,
> thus it should remove it and then try to re-initialize it again. Etc.
>
> Do you want me to send a patch to show you what I mean!?

If you don't mind, that would probably be easiest.  I've totally
swapped out all of the implementation details of this from my brain
now, but if I saw a patch from you it would be easy for me to analyze
it and test it.

Thanks!

-Doug
