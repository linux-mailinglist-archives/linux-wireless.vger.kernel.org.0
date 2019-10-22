Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B570EDFDD3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbfJVGvx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 02:51:53 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32840 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJVGvw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 02:51:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id p13so10632436vso.0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2019 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJWB3ZJ1SKiV9McwPYauc4L6u+mwLIjdOa8szB0AUFI=;
        b=P9eXHm3Wk/x6Oy/xQAeL5kZGtZfUhsAcaRpEMW/vL2sjEaqOz+AaJrS80Uh6SV7o5V
         6RJvqnoFbhHQXo8g0C4wpHVaGXL1wUu/o0V0L1xJfTIyiHZq26COuz05Rvo9+b3L4FqV
         8HzVYt3lqy6U8NfVi8IISQLU0Sy/MpJW41t5RNXbm7NnbhTI4Ei7+iLZ8LYSjvuH70Qs
         +bNepuqD1Q9Zn9dpd15Xt0X4AMnZb14khjdL5e+OeKeDYPbNSLC2tB+PJwhoXuQnEAyb
         7cMCfIOAt2Zo+XfZ8UGnpkx5Lq0urXv3UOcy9cGwcFDeLIxqthG948BewbRu7vJPoTw0
         YRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJWB3ZJ1SKiV9McwPYauc4L6u+mwLIjdOa8szB0AUFI=;
        b=jQWjvHjvhIHEMwfvBLl7VRMbBRG5aeBosFsX7v95IgdzKpeewlauY3gjyc1yTtD2cz
         8YyPEoSEF/p0twPdUdPgw2sJE4afyqoNnmnAiSYgz+hx6ySBOb4vZI86c2YpDcs3hLAu
         S/QkggKXn/IDf+ZMFsxR+r3V6jRJ8Vk3AKjvlXuetHqbio/PLZtGNF6B2qqNlF7R9/Sz
         Nkesq1fQmYErJ4tPpwnrntKVLxz+5n5/FsjuRzUIa0Y335cdM71BL3/e434Tyyi5kjfe
         FEBbNPX607vjn/QPsHwyQIaZJS7CSsPZRBmA3Q+SwRi36x7a8UnJMmq/nANmJNvFCtSO
         0wZg==
X-Gm-Message-State: APjAAAXMfngYrAeCYzIcx8ms68oPQAxZxtQBw/F1cMcrqiJjesMiFIVY
        9t9nQ68IWMnD76e3NZIcVMK/qtesrtZ3FgYOdY46EQ==
X-Google-Smtp-Source: APXvYqyjubu/KFW/0QbLz+1GmnWilUQgyoAF66sE82ItwNWiK3wnVox3xtQVRJ+kcZHtu9pch4p9tnleGs2Z3f/SSpM=
X-Received: by 2002:a67:ad0e:: with SMTP id t14mr911196vsl.35.1571727110390;
 Mon, 21 Oct 2019 23:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-3-ulf.hansson@linaro.org>
 <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com>
In-Reply-To: <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Oct 2019 08:51:14 +0200
Message-ID: <CAPDyKFq_Utz+ztdXTV534pY9Q9CyTSBJV_mfyPKAsHxaSyZjpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 22 Oct 2019 at 00:13, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Oct 17, 2019 at 6:58 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > It have turned out that it's not a good idea to try to power cycle and to
> > re-initialize the SDIO card, via mmc_hw_reset. This because there may be
> > multiple SDIO funcs attached to the same SDIO card.
> >
> > To solve this problem, we would need to inform each of the SDIO func in
> > some way when mmc_sdio_hw_reset() gets called, but that isn't an entirely
> > trivial operation. Therefore, let's instead take the easy way out, by
> > triggering a card removal and force a new rescan of the SDIO card.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/core.c |  3 +--
> >  drivers/mmc/core/core.h |  2 ++
> >  drivers/mmc/core/sdio.c | 11 +++++++++--
> >  3 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 6f8342702c73..39c4567e39d8 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
> >         mmc_bus_put(host);
> >  }
> >
> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> > -                               bool cd_irq)
> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
> >  {
> >         /*
> >          * If the device is configured as wakeup, we prevent a new sleep for
> > diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> > index 328c78dbee66..575ac0257af2 100644
> > --- a/drivers/mmc/core/core.h
> > +++ b/drivers/mmc/core/core.h
> > @@ -70,6 +70,8 @@ void mmc_rescan(struct work_struct *work);
> >  void mmc_start_host(struct mmc_host *host);
> >  void mmc_stop_host(struct mmc_host *host);
> >
> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> > +                       bool cd_irq);
> >  int _mmc_detect_card_removed(struct mmc_host *host);
> >  int mmc_detect_card_removed(struct mmc_host *host);
> >
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > index 26cabd53ddc5..5d7462c223c3 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > @@ -1050,8 +1050,15 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
> >
> >  static int mmc_sdio_hw_reset(struct mmc_host *host)
> >  {
> > -       mmc_power_cycle(host, host->card->ocr);
> > -       return mmc_sdio_reinit_card(host);
> > +       /*
> > +        * We may have more multiple SDIO funcs. Rather than to inform them all,
> > +        * let's trigger a removal and force a new rescan of the card.
> > +        */
> > +       host->rescan_entered = 0;
> > +       mmc_card_set_removed(host->card);
> > +       _mmc_detect_change(host, 0, false);
> > +
> > +       return 0;
> >  }
>
> The problem I see here is that callers of this reset function aren't
> expecting it to work this way.  Look specifically at
> mwifiex_sdio_card_reset_work().  It's assuming that it needs to do
> things like shutdown / reinit.  Now it's true that the old
> mwifiex_sdio_card_reset_work() was pretty broken on any systems that
> also had SDIO bluetooth, but presumably it worked OK on systems
> without SDIO Bluetooth.  I don't think it'll work so well now.

Good point!

I guess I was hoping that running through ->remove() and then
->probe() for the SDIO func drivers should simply take care of
whatever that may be needed. In some way this makes the driver broken
already in regards to this path, but never mind.

>
> Testing shows that indeed your patch breaks mwifiex reset worse than
> it was before (AKA WiFi totally fails instead of it just killing
> Bluetooth).
>
> I think it may be better to add a new API call rather than trying to
> co-opt the old one.  Maybe put a WARN_ON() for the old API call to
> make people move away from it, or something?

Thanks again for testing and for valuable feedback! Clearly this needs
a little more thinking.

An additional concern I see with the "hotplug approach" implemented in
$subject patch, is that it becomes unnecessary heavy when there is
only one SDIO func driver bound.

In one way I am tempted to try to address that situation, as it seems
a bit silly to do full hotplug dance when it isn't needed.

>
>
> ...but on the bright side, your patch does seem to work.  If I add my
> patch from <https://lkml.kernel.org/r/20190722193939.125578-3-dianders@chromium.org>
> and change "sdio_trigger_replug(func)" to
> "mmc_hw_reset(func->card->host)" then I can pass reboot tests.  I made
> it through about 300 cycles of my old test before stopping the test to
> work on other things.

That's really good news. Thanks!

>
>
> In terms of the implementation, I will freely admit that I'm always
> confused by the SD/MMC state machines, but as far as I can tell your
> patch accomplishes the same thing as mine but in a bit simpler way.
> ;-)  I even confirmed that with your patch mmc_power_off() /
> mmc_power_up are still called...
>
> Thanks!
>
> -Doug

Alright, let me rework this and post a new version. I keep you posted.

Kind regards
Uffe
