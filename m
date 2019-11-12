Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40166F854B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 01:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKLAeA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 19:34:00 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36336 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKLAeA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 19:34:00 -0500
Received: by mail-io1-f68.google.com with SMTP id s3so16749571ioe.3
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 16:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMT4TtiLLjvcaVBuuUVFAqyUJbsnxDxtixXVboFNnfc=;
        b=RBDCBuJzAvnQvErbcYdWKdwqOMzH4pnQRpt4Tt5inZiU9Jw/GPgiCPYAbmkyXJgJ9o
         cdBDPnhd3fFoEcRDE4UInmjNojVBx/CtWC6C3SOGuS6UwnblLDQMh4jkSiR4+40lv/Sp
         TOMtG9OUBsvIRQK/LsvERhoDx6nzJ7DLjV0YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMT4TtiLLjvcaVBuuUVFAqyUJbsnxDxtixXVboFNnfc=;
        b=EIVguvNRzdvCqXBTRFyZLqOxAgQyZLeZZQE0FLuI+aISRpX5grAKgY+c2wWX7NwhSs
         WZmz3rzF3uqHqLtcK3ARgX57j/C+5iwPXjfARtRhxJwNgzwmiNb1YqzxzhD+L5gKkG4d
         pHab6kpH4S+CHPgrsLFplHGH7oGKFhOyp15BWyRxdcELbQiahqDHHHwzQw1GIW9iM69K
         qdS7ILzc6E8CQgbJuCpCIirv6N83pCFZtFQfp4naXRXoXqMgfTXeL8BQu2Xo1aliVXUD
         hvRD/A4/7QTI13yUnN93cWoRXL5yf7PFcst6K55QVI1IE3Jej1VDLOryocNsn58WoWuC
         xmmQ==
X-Gm-Message-State: APjAAAXs0ewPWJOok2Kyk61XjleQaySA132qb7BavWPiUZuMCDHNipLB
        QxhtaMsy3gTzQqzevh4aJzE5vMfBALg=
X-Google-Smtp-Source: APXvYqzdPlpC6BZWZzHiGDCbuRCyVStWOlCPHonbeuQlq6GB45RXbFT6E8xxjgMKJsi8d4Fus+2UCw==
X-Received: by 2002:a05:6602:228e:: with SMTP id d14mr15600792iod.122.1573518839020;
        Mon, 11 Nov 2019 16:33:59 -0800 (PST)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id x5sm2383186ila.34.2019.11.11.16.33.57
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 16:33:57 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id j13so16771619ioe.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 16:33:57 -0800 (PST)
X-Received: by 2002:a5d:9059:: with SMTP id v25mr22885777ioq.58.1573518836636;
 Mon, 11 Nov 2019 16:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org> <20191109103046.26445-2-ulf.hansson@linaro.org>
In-Reply-To: <20191109103046.26445-2-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Nov 2019 16:33:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA@mail.gmail.com>
Message-ID: <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mwifiex: Re-work support for SDIO HW reset
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Hi,

On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The SDIO HW reset procedure in mwifiex_sdio_card_reset_work() is broken,
> when the SDIO card is shared with another SDIO func driver. This is the
> case when the Bluetooth btmrvl driver is being used in combination with
> mwifiex. More precisely, when mwifiex_sdio_card_reset_work() runs to resets
> the SDIO card, the btmrvl driver doesn't get notified about it. Beyond that
> point, the btmrvl driver will fail to communicate with the SDIO card.
>
> This is a generic problem for SDIO func drivers sharing an SDIO card, which
> are about to be addressed in subsequent changes to the mmc core and the
> mmc_hw_reset() interface. In principle, these changes means the
> mmc_hw_reset() interface starts to return 1 if the are multiple drivers for
> the SDIO card, as to indicate to the caller that the reset needed to be
> scheduled asynchronously through a hotplug mechanism of the SDIO card.
>
> Let's prepare the mwifiex driver to support the upcoming new behaviour of
> mmc_hw_reset(), which means extending the mwifiex_sdio_card_reset_work() to
> support the asynchronous SDIO HW reset path. This also means, we need to
> allow the ->remove() callback to run, without waiting for the FW to be
> loaded. Additionally, during system suspend, mwifiex_sdio_suspend() may be
> called when a reset has been scheduled, but waiting to be executed. In this
> scenario let's simply return -EBUSY to abort the suspend process, as to
> allow the reset to be completed first.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
>  drivers/net/wireless/marvell/mwifiex/main.h |  1 +
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
>  3 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index a9657ae6d782..dbdbdd6769a9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -76,6 +76,7 @@ static int mwifiex_register(void *card, struct device *dev,
>         *padapter = adapter;
>         adapter->dev = dev;
>         adapter->card = card;
> +       adapter->is_adapter_up = false;

Probably not needed.  The 'adapter' was kzalloc-ed a few lines above
and there's no need to re-init to 0.


> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index 24c041dad9f6..2417c94c29c0 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
>                 return 0;
>         }
>
> +       if (!adapter->is_adapter_up)
> +               return -EBUSY;

I'm moderately concerned that there might be cases where firmware
never got loaded but we could suspend/resume OK.  ...and now we never
will?  I'm not familiar enough with the code to know if this is a real
concern, so I guess we can do this and then see...


> @@ -2220,22 +2223,30 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
>         struct sdio_func *func = card->func;
>         int ret;
>
> +       /* Prepare the adapter for the reset. */
>         mwifiex_shutdown_sw(adapter);
> +       clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
> +       clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
>
> -       /* power cycle the adapter */
> +       /* Run a HW reset of the SDIO interface. */
>         sdio_claim_host(func);
> -       mmc_hw_reset(func->card->host);
> +       ret = mmc_hw_reset(func->card->host);
>         sdio_release_host(func);
>
> -       /* Previous save_adapter won't be valid after this. We will cancel
> -        * pending work requests.
> -        */
> -       clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
> -       clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);

I don't know enough about the clearing of these bits to confirm that
it's OK to move their clearing to be before the mmc_hw_reset().
Possibly +Brian Norris does?


I can't promise that I didn't miss anything, but to the best of my
knowledge this is good now:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
