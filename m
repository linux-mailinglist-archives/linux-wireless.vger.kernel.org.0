Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57CAF8F75
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 13:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfKLMOA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 07:14:00 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:32801 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLMOA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 07:14:00 -0500
Received: by mail-ua1-f67.google.com with SMTP id a13so2558024uaq.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 04:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kb99iT/gCFdRTk8k9ih2vk74MRQtd9fd4gG9oDPpRPU=;
        b=LfHRMW9zKX0g/y5YE2nRAWDy6iiFynO0+GL59U9QMcdYL+WQ4aK0gtejV8kFobOSCR
         eLQ4ZsKOTM/73Tgb7Oiuhv/Xkw+ugRqjJR+AMbygNxxpOJLRy8Tcu8wyYQl+C+Zr16f8
         gZqh6fgPv7hpJx5Xw1qVTmI9I4KMVQ6nEx7A1f0ou4txSBP3Vvmp54Lrqc3LeZco+YpP
         VVL+P2v1TvgBjV9eE7e5KWfo5fHxXJTeBUc/C5ocWr3ax1s6NtgpDcyAVMLP3V7PrUzW
         QSDvrn4Bcjs5M3fp1GACSRgLyNgLtFDQS6O1T041u1f/xKxP0FWxcs/Qp9BHSP+ARUou
         zMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kb99iT/gCFdRTk8k9ih2vk74MRQtd9fd4gG9oDPpRPU=;
        b=F3lr9ycXObmIFlr0BBVvvCGS3AkW4wCrHryjr8/VaRXR9GwUxYuq+3OgQjrajZ6uEa
         HQ5M5hDq663UG297OpPqXER6y6CWT+sRGzCcH8kMIx/XmqdduKmt5zwXWsY44xcVtikO
         QkNZB81tNVTSQ2obX7hIDn6MVYcxYmL4Tbg6/ZhCm3E+5zvVGk0zJtmHnkzHHHpQYjdH
         LWJTBEPQTFQsocaGeTf2VhMPkICZpvIaXto3s3giL5nRThmpNiBXVElbnkmrVUVZBuAe
         Ch16/t8XqeU65P63lARBGQe7UTxFkwVPvrpIAWkuoqQvJZC21BMqzR3bKWpffxhWudWx
         bN+Q==
X-Gm-Message-State: APjAAAUugjX13fqkk9Foj5BYZeL+qCPw1kIfrOtTeoKRvgF2oErQOEGn
        8Oeo/5TQ9V5ahvNHrYlQnlovkTw/dQU2UoNP2Y95DQ==
X-Google-Smtp-Source: APXvYqydXctJQNC9TmCyGpFwkkXqlkIRQS22kEBsajTRr6z5rsRsfJr1kpR/ATqoy0NuRqvTXOODHcqTvPtSJWzPdoA=
X-Received: by 2002:ab0:648d:: with SMTP id p13mr552984uam.129.1573560838317;
 Tue, 12 Nov 2019 04:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-2-ulf.hansson@linaro.org> <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA@mail.gmail.com>
In-Reply-To: <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Nov 2019 13:13:21 +0100
Message-ID: <CAPDyKFq-djJFyYu6Wzg9t9hLOQMuqff9KVhbx5Zp5i=Fsynsdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mwifiex: Re-work support for SDIO HW reset
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > The SDIO HW reset procedure in mwifiex_sdio_card_reset_work() is broken,
> > when the SDIO card is shared with another SDIO func driver. This is the
> > case when the Bluetooth btmrvl driver is being used in combination with
> > mwifiex. More precisely, when mwifiex_sdio_card_reset_work() runs to resets
> > the SDIO card, the btmrvl driver doesn't get notified about it. Beyond that
> > point, the btmrvl driver will fail to communicate with the SDIO card.
> >
> > This is a generic problem for SDIO func drivers sharing an SDIO card, which
> > are about to be addressed in subsequent changes to the mmc core and the
> > mmc_hw_reset() interface. In principle, these changes means the
> > mmc_hw_reset() interface starts to return 1 if the are multiple drivers for
> > the SDIO card, as to indicate to the caller that the reset needed to be
> > scheduled asynchronously through a hotplug mechanism of the SDIO card.
> >
> > Let's prepare the mwifiex driver to support the upcoming new behaviour of
> > mmc_hw_reset(), which means extending the mwifiex_sdio_card_reset_work() to
> > support the asynchronous SDIO HW reset path. This also means, we need to
> > allow the ->remove() callback to run, without waiting for the FW to be
> > loaded. Additionally, during system suspend, mwifiex_sdio_suspend() may be
> > called when a reset has been scheduled, but waiting to be executed. In this
> > scenario let's simply return -EBUSY to abort the suspend process, as to
> > allow the reset to be completed first.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
> >  drivers/net/wireless/marvell/mwifiex/main.h |  1 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
> >  3 files changed, 28 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> > index a9657ae6d782..dbdbdd6769a9 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> > @@ -76,6 +76,7 @@ static int mwifiex_register(void *card, struct device *dev,
> >         *padapter = adapter;
> >         adapter->dev = dev;
> >         adapter->card = card;
> > +       adapter->is_adapter_up = false;
>
> Probably not needed.  The 'adapter' was kzalloc-ed a few lines above
> and there's no need to re-init to 0.

Right, let me re-spin and drop this.

>
>
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > index 24c041dad9f6..2417c94c29c0 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > @@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
> >                 return 0;
> >         }
> >
> > +       if (!adapter->is_adapter_up)
> > +               return -EBUSY;
>
> I'm moderately concerned that there might be cases where firmware
> never got loaded but we could suspend/resume OK.  ...and now we never
> will?  I'm not familiar enough with the code to know if this is a real
> concern, so I guess we can do this and then see...

There is a completion variable that is used to make sure the firmware
is loaded, before the mwifiex driver runs ->suspend|remove(). This is
needed, because during ->probe() the FW will be loaded asynchronously,
hence both mwifiex_sdio_remove() and mwifiex_sdio_suspend(), may be
called while waiting for the FW to be loaded.

If a HW reset has been scheduled but not completed, which would be the
case if mmc_hw_reset() gets called after mmc_pm_notify() with a
PM_SUSPEND_PREPARE. This is because mmc_pm_notify() then disables the
rescan work, but then re-kicks/enables it at PM_POST_SUSPEND (after
the system has resumed).

Returning -EBUSY, should allow the mmc rescan work to be completed
when the system have resumed.

Of course, one could also considering using pm_wakeup_event(), in case
mmc_hw_reset() needed to schedule the reset, as to prevent the system
for suspending for a small amount of time. As to make sure the rescan
work, gets to run. But I am not sure that's needed here.

>
>
> > @@ -2220,22 +2223,30 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
> >         struct sdio_func *func = card->func;
> >         int ret;
> >
> > +       /* Prepare the adapter for the reset. */
> >         mwifiex_shutdown_sw(adapter);
> > +       clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
> > +       clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
> >
> > -       /* power cycle the adapter */
> > +       /* Run a HW reset of the SDIO interface. */
> >         sdio_claim_host(func);
> > -       mmc_hw_reset(func->card->host);
> > +       ret = mmc_hw_reset(func->card->host);
> >         sdio_release_host(func);
> >
> > -       /* Previous save_adapter won't be valid after this. We will cancel
> > -        * pending work requests.
> > -        */
> > -       clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
> > -       clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
>
> I don't know enough about the clearing of these bits to confirm that
> it's OK to move their clearing to be before the mmc_hw_reset().
> Possibly +Brian Norris does?

That shouldn't matter, because we are running in the path of the
mwifiex_sdio_work(), as work from the system_wq. Unless I am mistaken,
only one work of the type mwifiex_sdio_work() can execute at the same
time. By clearing these bits, we want to cancel any potential recently
scheduled work. It should matter if that's done before or after
mmc_hw_reset().

Moreover, this change makes it more consistent with how the pcie
driver clears the bits.

>
>
> I can't promise that I didn't miss anything, but to the best of my
> knowledge this is good now:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

Finally, if you want to verify that the above system suspend path
works fine, you could change the call to "_mmc_detect_change(host, 0,
false)" in mmc_sdio_hw_reset(), into "_mmc_detect_change(host,
msecs_to_jiffies(30000), false)", in patch3.

This should leave you a 30s window of where you can try to system
suspend the platform, while also waiting for the scheduled reset to be
completed.

Kind regards
Uffe
