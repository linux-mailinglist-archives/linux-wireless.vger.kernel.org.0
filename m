Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD78D448C3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfFMRLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 13:11:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39503 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbfFLWUw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 18:20:52 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so14319505iod.6
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHZeRGRnRV+X3+ojI4+CNUmgv9wOm09bUYa/PdaxFuM=;
        b=USRud+vbB6HBUaZFrpr4os9K1OnSMboIZkUxuC0TDtauV5/ubrepAXgQBFRRYZwjG4
         P+T4z3FJYSwXyW3UHy/7Aq4gBGgWK2YUe3CdO57kgZXbT3EBY3ZjmmEnoYoErUBxBK92
         UvtvFU2v9L/S1i3geFt9acvWca6l4OmAOOb0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHZeRGRnRV+X3+ojI4+CNUmgv9wOm09bUYa/PdaxFuM=;
        b=mUvmJY72FWnXWSzENYqa+xTPxSD3hfpjs6EaHcScGkI6gkUs4TKhyTC9M11PxNvxNI
         Pb7sdPy02xR8BFu+EOlfxWvmx81nzZbiJahN9QiSCt+/K1CP2mTM1HX3ItuE9QaikUml
         YZ2+hLON/JXYSx64WmBLFGZ8WKllPJO2trf759+lTspY0Nesavc9X+pK/JGMBTPVrhTj
         WaaXcCjJjHGTZe4U/QeuY1iftr/gjZMwf75kcwXNJ0b0C+ROr3VMdvURVSG6zPt3pFoT
         BQh199DmTKzjCmtnmDF0n36RxT5+r3Uvro66KI3BxAGa3ZfHZaCGyDz1Pm9X+j3bSBUq
         gzAQ==
X-Gm-Message-State: APjAAAUMq9uU0OLkFCHObLBKrL1+rldAlbIV4jQXl0AqYk6pMAkYmab4
        v+iuODQnXWpBRDsHevXKOuimkuijymA=
X-Google-Smtp-Source: APXvYqwlRSS1Rb6cvkEg73Ueby8BcEYKise1hml+Mq7qkfK7lGrmE/Alz/BPUyxg9112v14UMezAvg==
X-Received: by 2002:a6b:e315:: with SMTP id u21mr48889674ioc.14.1560378051639;
        Wed, 12 Jun 2019 15:20:51 -0700 (PDT)
Received: from mail-it1-f177.google.com (mail-it1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id t5sm390072iol.55.2019.06.12.15.20.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 15:20:50 -0700 (PDT)
Received: by mail-it1-f177.google.com with SMTP id m138so13526652ita.4
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 15:20:49 -0700 (PDT)
X-Received: by 2002:a24:b106:: with SMTP id o6mr994709itf.97.1560378048963;
 Wed, 12 Jun 2019 15:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190611123221.11580-1-ulf.hansson@linaro.org>
In-Reply-To: <20190611123221.11580-1-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Jun 2019 15:20:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBVRsdiOD0vhgTvMXmqm=fzy9Bzd_x=E1TNPBsT_D-tQ@mail.gmail.com>
Message-ID: <CAD=FV=XBVRsdiOD0vhgTvMXmqm=fzy9Bzd_x=E1TNPBsT_D-tQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Prevent processing SDIO IRQs when the card is suspended
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Jun 11, 2019 at 5:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Processing of SDIO IRQs must obviously be prevented while the card is
> system suspended, otherwise we may end up trying to communicate with an
> uninitialized SDIO card.
>
> Reports throughout the years shows that this is not only a theoretical
> problem, but a real issue. So, let's finally fix this problem, by keeping
> track of the state for the card and bail out before processing the SDIO
> IRQ, in case the card is suspended.
>
> Cc: stable@vger.kernel.org
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> This has only been compile tested so far, any help for real test on HW is
> greatly appreciated.

Thanks for sending this!


> Note that, this is only the initial part of what is needed to make power
> management of SDIO card more robust, but let's start somewhere and continue to
> improve things.
>
> The next step I am looking at right now, is to make sure the SDIO IRQ is turned
> off during system suspend, unless it's supported as a system wakeup (and enabled
> to be used).

My gut says that the partway solution is going to be a problem on some
controllers / systems, even though it seems to work OK on mine.  See
my thoughts below and let me know what you think.


> ---
>  drivers/mmc/core/sdio.c     | 7 +++++++
>  drivers/mmc/core/sdio_irq.c | 4 ++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index d1aa1c7577bb..9951295d3220 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -937,6 +937,10 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
>   */
>  static int mmc_sdio_suspend(struct mmc_host *host)
>  {
> +       /* Prevent processing of SDIO IRQs in suspended state. */
> +       mmc_card_set_suspended(host->card);

Do you need to claim / release the host around the call to
mmc_card_set_suspended() to avoid races?



> +       cancel_delayed_work_sync(&host->sdio_irq_work);
> +
>         mmc_claim_host(host);
>
>         if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
> @@ -985,6 +989,9 @@ static int mmc_sdio_resume(struct mmc_host *host)
>                 err = sdio_enable_4bit_bus(host->card);
>         }
>
> +       /* Allow SDIO IRQs to be processed again. */
> +       mmc_card_clr_suspended(host->card);
> +

Do you need to check for "!err" before calling
mmc_card_clr_suspended()?  ...or add an "if (err) goto exit" type
thing and get rid of the "!err" check below?


>         if (!err && host->sdio_irqs) {
>                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>                         wake_up_process(host->sdio_irq_thread);
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 931e6226c0b3..9f54a259a1b3 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -34,6 +34,10 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>         unsigned char pending;
>         struct sdio_func *func;
>
> +       /* Don't process SDIO IRQs if the card is suspended. */
> +       if (mmc_card_suspended(card))
> +               return 0;
> +

Is it really OK to just return like this?  I guess there are two
(somewhat opposite) worries I'd have.  See A) and B) below:

A) Do we need to do anything extra to make sure we actually call the
interrupt handler after we've resumed?  I guess we can't actually
"lose" the interrupt since it will be sitting asserted in CCCR_INTx
until we deal with it (right?), but maybe we need to do something to
ensure the handler gets called once we're done resuming?

A1) old SDIO thread case

I think we'll be OK in the old SDIO thread case.  We'll call
wake_up_process() after we clear the suspended state and then we'll
either see "sdio_irq_pending" was set to true or we'll poll CCCR_INTx.

--

A2): new MMC_CAP2_SDIO_IRQ_NOTHREAD case

Should we do something to re-kick things?  We could call
sdio_signal_irq() in mmc_sdio_resume() I guess?  I was worried that
might conflict with those that call sdio_run_irqs() directly but it
seems like that's nobody as of commit 89f3c365f3e1 ("mmc: sdhci: Fix
SDIO IRQ thread deadlock").

NOTE: I put a bunch of debug printouts and I'm fairly convinced that
this is a real problem.  Sort of.  Specifically I confirmed that in
dw_mmc the SDIO interrupt seems to be treated as an edge-triggered
interrupt.  AKA: in dw_mci_interrupt() when we write to "RINTSTS" as
we're handling the interrupt the interrupt immediately stops
asserting.  It doesn't actually fire again until the Marvell SDIO
resume functions run.  I didn't dig enough to figure out what
specifically makes the interrupt fire again in the Marvell resume
functions, but it seems a little concerning that we're relying on
something in that driver to re-kick the host controller interrupt.

...side note: overall looking at this code path, two additional
questions come up for me.  One is why sdio_run_irqs() hardcodes
"sdio_irq_pending" as true.  That means we won't _ever_ poll CCCR_INTx
in the 1-function case, right?  That seems wrong.  The other is why
mmc_sdio_resume() always calls host->ops->enable_sdio_irq(host, 1) at
resume time when nobody ever turned the IRQs off.

===

B) Are there any instances where the interrupt will just keep firing
over and over again because we don't handle it?

As per above, this _isn't_ happening on dw_mmc on my setup because
dw_mmc seems to treat the SDIO interrupt as edge triggered.  ...but is
this true everywhere?  If we were using SDIO in 1-bit mode on dw_mmc,
would the interrupt re-assert right away?  If dw_mmc were configured
to use a dedicated pin would it re-assert right away?  What about
other host controllers?

If you're sure no host controllers will keep asserting the interrupt
over and over then I guess we don't need to worry about it?
...otherwise we'd need to find some way to mask the interrupt and we'd
need to make sure whatever we do doesn't interfere with anyone who
supports the SDIO interrupt as a wake source, right?

======

Overall, I can confirm that on my system your patch actually does
work.  ...so if all of the above concerns are moot and won't cause
anyone else problems then I can say that they don't seem to cause any
problems on my system.  On rk3288-veyron-jerry:

- Before your patch, I got failures at iteration 18, then 32, then 55,
then 7, then 26.

- After your patch I could do 100 iterations of suspend/resume with no
failures.  I also put printouts to confirm your patch was having an
effect.


I also confirmed that rk3288-veyron-minnie (which has Broadcom WiFi) I
could still suspend/resume fine with your patch.



-Doug
