Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48AFB34C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 16:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfKMPMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 10:12:31 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33711 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfKMPMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 10:12:30 -0500
Received: by mail-vs1-f65.google.com with SMTP id c25so1575271vsp.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jc0YUAFMk4ruUPrZrPfLYvKwQ1pbJ28MVupI62fOxz8=;
        b=h9/LboM8UhK5Ev4Xcp4HH6Yqtjg0UwOzKYDdco8KYCsIFkLRpA/f6AjR7LodwHM3rk
         SR70nQg/8+1utiysrcHU+c4xEobAiqJLA1L/S8kLs4zsJC2NirISFbgiL2lfVZgncG4y
         fMEV3sdC/KUu/yJtiaFtgBs+ZFW4jhpLydhonyTlaPfh8gJqGHzufReqq4md7VLlpko2
         ZBm7Fb5gTbb7B0sKqVKP2FmOivMCSrPPqvcpybAzqmogL68RsBqZ0oCYg1/tm1CbvYxU
         ADi7mJE3FrWeIe+BuYMDgE9DWr0UoVBDlRAQFAVNbtDQ+3fB069gzMW5skyMskegyuqK
         wNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jc0YUAFMk4ruUPrZrPfLYvKwQ1pbJ28MVupI62fOxz8=;
        b=VaOC8q6bfhlU2aEcmTMq3sVST3h2ITR1Fp9Fp6M030JrcWBBo7H8tHph8yPD/91vAQ
         7qSn3bUtcZOfuuXOYm8Gwh5LqQzn3Nv3lF1A7GGjficbDYYU3U+Cv2n4pkEDG9/SQ++r
         sWe7wjmY0vnhTjHPtJbwE1+4kCbzUUQCAyDWJSF5gfcRaYRxJAQWa4qxegrzOUr/7Ib6
         0MNpycJlNHwq5Il7ODuQzW+lWfXTDYdumfWYf5j2wz6MUfKY2ta0KJELhu7Dbc7iv4EZ
         nISMjjv5XiOB8+C7P+ZGlYzIaDMo5pQ4yYr1y8MFYgVyzh5vVOUqml+FeQm369vl4xnG
         kG3Q==
X-Gm-Message-State: APjAAAWD82RilBvYc7X9nuJAFeRTh8UaDR5wHKMIXwWJ/dOzkI/wyEkT
        y6ftrGa4saHjRHdiFXmfBC8iyR41FfBYa0tFDFKyFw==
X-Google-Smtp-Source: APXvYqxxvUhyMjvqn8HC9cwUZmrGGk0V6VDNHo03lx3pKaBu2GoDkotm2dpL7tOn0d/vPwn5pymZiVlR4UeESfkN48k=
X-Received: by 2002:a67:5ec1:: with SMTP id s184mr2064193vsb.200.1573657949541;
 Wed, 13 Nov 2019 07:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <CAD=FV=Wv9DgzQZZE8YvB+qjBzPsKdJvafSnFy8YAN_dN6UJbtQ@mail.gmail.com>
 <CAPDyKFq5=B8u=9awGaXuhTmYK6Sbbe6EmF9EMhBQQyyrD1bKRw@mail.gmail.com> <CAD=FV=Xf5O_ew+hG9BLSZUM7bKAZvEvqaK4Cy1xUWgKdTGUMwA@mail.gmail.com>
In-Reply-To: <CAD=FV=Xf5O_ew+hG9BLSZUM7bKAZvEvqaK4Cy1xUWgKdTGUMwA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Nov 2019 16:11:53 +0100
Message-ID: <CAPDyKFo6=WTONuXkyWsYMy9MS8Zs0HrZue7mzPbN9WUYRWmfAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: Fixup HW reset for SDIO cards
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

On Tue, 12 Nov 2019 at 18:43, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Nov 12, 2019 at 4:28 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 12 Nov 2019 at 01:51, Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > Changes in v2:
> > > >         - Add adaptations to the mwifiex driver.
> > > >         - Keep existing syncronous reset behaviour if the SDIO card has a single
> > > >         func driver.
> > > >
> > > > It has turned out that it's not a good idea to try to power cycle and to
> > > > re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
> > > > because there may be multiple SDIO funcs attached to the same SDIO card and
> > > > some of the others that didn't execute the call to mmc_hw_reset(), may then
> > > > simply experience an undefined behaviour.
> > > >
> > > > The following patches in this series attempts to address this problem, by
> > > > reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
> > > > mwifiex driver to these changes.
> > > >
> > > > Note that, I don't have the HW at hand so the the code has only compile tested.
> > > > Test on HW is greatly appreciated!
> > > >
> > > > Ulf Hansson (3):
> > > >   mwifiex: Re-work support for SDIO HW reset
> > > >   mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
> > > >   mmc: core: Re-work HW reset for SDIO cards
> > > >
> > > >  drivers/mmc/core/core.c                     | 12 +++-----
> > > >  drivers/mmc/core/core.h                     |  2 ++
> > > >  drivers/mmc/core/sdio.c                     | 28 ++++++++++++++++-
> > > >  drivers/mmc/core/sdio_bus.c                 |  9 +++++-
> > > >  drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
> > > >  drivers/net/wireless/marvell/mwifiex/main.h |  1 +
> > > >  drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
> > > >  include/linux/mmc/card.h                    |  1 +
> > > >  8 files changed, 70 insertions(+), 22 deletions(-)
> > >
> > > I put this on rk3288-veyron-jerry atop v5.4-rc7 and I could run my
> > > test case for a while, AKA I got over 50 cycles of:
> > >
> > > ---
> > >
> > > for i in $(seq 1000); do
> > >   echo "LOOP $i --------"
> > >   echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset
> > >
> > >   while true; do
> > >     if ! ping6 -w15 -c1 "${GW}" >/dev/null 2>&1; then
> > >       fail=$(( fail + 1 ))
> > >       echo "Fail WiFi ${fail}"
> > >       if [[ ${fail} == 3 ]]; then
> > >         exit 1
> > >       fi
> > >     else
> > >       fail=0
> > >       break
> > >     fi
> > >   done
> > >
> > >   hciconfig hci0 down
> > >   sleep 1
> > >   if ! hciconfig hci0 up; then
> > >     echo "Fail BT"
> > >     exit 1
> > >   fi
> > >
> > > done
> > >
> > > ---
> > >
> > > NOTE: with no patches I couldn't even get my test case to pass w/out
> > > the BT bits and I swear that used to work before.  ...but I didn't
> > > debug since the end result (with full card hotplug) is happy-working
> > > for me.  I'll still use it as further argument that (IMO) full unplug
> > > / plug of the card is better it uses more standard code paths and is
> > > less likely to break.  ;-)
> > >
> > > Tested-by: Douglas Anderson <dianders@chromium.org>
> >
> > Thanks, I add this to the series and make a re-spin.
> >
> > What do you think about tagging the patches for stable?
> >
> > I guess there is a risk that we may "break" the other two users of
> > mmc_hw_reset(). But, as I said, in that case those needs to be fixed
> > anyways.
>
> I'm not sure how to make that judgement call.  Certainly it would help
> anyone using the Marvell case and the Marvell case was pretty broken
> before.
>
> How about this: if you can get a Tested-by from the other users then
> I'd be good with a general CC: stable.  Otherwise, I'd be OK with a CC
> to stable for 5.4, but I'd be a little hesitant to send it back to
> older kernels (even though it certainly applies and fixes problems).

This makes sense, let's go with this!

> At least in the case of Chrome OS we already have a workable solution
> for our 4.19 tree (my previous patches), and I'd guess anyone testing
> on real hardware is either not seeing problems or has their own
> private patches already.  If things have been sitting stable on 5.4
> for a while and no problems were reported, then we could consider
> going back further?

Yep!

That said, the v3 series is queued up for next and by adding a stable
tag for 5.4+.

Kind regards
Uffe
