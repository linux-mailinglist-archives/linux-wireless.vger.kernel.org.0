Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E90B45C37
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfFNMKY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 08:10:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45519 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfFNMKY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 08:10:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id n21so1581182vsp.12
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5D+HakwAE2WgxfHyzl83ZwTB437sX3wIDlJ8qrfryI=;
        b=igk9dt/vAQdzxT8QzdZI/Ievysa9xK3WPDJK4vcC3mDYTCNmuMk9blJgU6OL9Yc0dK
         Tio9BFMzxl///10xMQOIVDRbhF/nM/Hlu2UzObSKzWbdltAQYn565CyrftqwwoLEd33B
         Cr7ROv4Q0dHUiigBi2fHNGkoZUZUg1UIePaijaE5FoQNP4Rj7BRVnnrvi3b8R3WX/hJu
         CM8fh8LGVg8luPx2wjcpony8vE0jjzt/t5njqGuSo/mVk/E4Zw+RG33ExdPs2KeVtCjq
         cOiCldbH6KD71Pzci41unZHGuT1+Ngh7l43T59JmGfcQNXWayyQYrKADlRuNeU7nV5CB
         2Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5D+HakwAE2WgxfHyzl83ZwTB437sX3wIDlJ8qrfryI=;
        b=Uzb8f/3+5SIHUgvsd+TBk7qlr3QX0Zl56INkfrAV5UxTCDdWUxu8+OPItIuBmKRy4k
         xJ/rklkwyZW8NLulQ7BN4Xjg8krYrFGXCy4KSrlSLC5dJCJ6Y4mIL8aY17WSTwBYAJU8
         L7tmxJOQYLoM8U0PZnOYjOClaFyrE7yNfMLUFfmp5eFlOFTKFRFsYwftEjw0MgpGZ57F
         Wnib0O3T+GOWbbtX8NVgwDoWQP5/35YMXkgnKAxlBSxOsbs6VKjxZNNLIqSRLE1E6Pk6
         6Vg/n82gtvPKTPk9MGYGQs4vr3S2Ec/9Hf43/v/FAb0kvLXuTLB6kj8Mb6TVJBSnLI50
         zumA==
X-Gm-Message-State: APjAAAXDfOJvhPMZ2yHFrDOy1X7JwPNYyOeau28OjCn0KN9KUUxk66Gc
        qWXCzjtxH5TBy+Cwa4+oZM6dDGdC4pWfZG2oZST/PQ==
X-Google-Smtp-Source: APXvYqydln8EpljbWUJIef2R+juyAWV3U5n+26y/5MI0AqXoz3GwtqMW3kyvstIYiC/7nRtirT+2WiUXP5SR66PbMWA=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr52752594vsp.35.1560514222446;
 Fri, 14 Jun 2019 05:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190613234153.59309-1-dianders@chromium.org> <20190613234153.59309-5-dianders@chromium.org>
In-Reply-To: <20190613234153.59309-5-dianders@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jun 2019 14:09:45 +0200
Message-ID: <CAPDyKFrJ4+zn7Ak0tYHkBfXUtH3N7erb5R7Q+hgugchZmCRGrw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev@vger.kernel.org, brcm80211-dev-list@cypress.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 14 Jun 2019 at 01:42, Douglas Anderson <dianders@chromium.org> wrote:
>
> We want SDIO drivers to be able to temporarily stop retuning when the
> driver knows that the SDIO card is not in a state where retuning will
> work (maybe because the card is asleep).  We'll move the relevant
> functions to a place where drivers can call them.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

This looks good to me.

BTW, seems like this series is best funneled via my mmc tree, no? In
such case, I need acks for the brcmfmac driver patches.

Kind regards
Uffe




> ---
>
> Changes in v4:
> - Moved retune hold/release to SDIO API (Adrian).
>
> Changes in v3:
> - ("mmc: core: Export mmc_retune_hold_now() mmc_retune_release()") new for v3.
>
> Changes in v2: None
>
>  drivers/mmc/core/sdio_io.c    | 40 +++++++++++++++++++++++++++++++++++
>  include/linux/mmc/sdio_func.h |  3 +++
>  2 files changed, 43 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index f822a9630b0e..1b6fe737bd72 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -15,6 +15,7 @@
>  #include "sdio_ops.h"
>  #include "core.h"
>  #include "card.h"
> +#include "host.h"
>
>  /**
>   *     sdio_claim_host - exclusively claim a bus for a certain SDIO function
> @@ -770,3 +771,42 @@ void sdio_retune_crc_enable(struct sdio_func *func)
>         func->card->host->retune_crc_disable = false;
>  }
>  EXPORT_SYMBOL_GPL(sdio_retune_crc_enable);
> +
> +/**
> + *     sdio_retune_hold_now - start deferring retuning requests till release
> + *     @func: SDIO function attached to host
> + *
> + *     This function can be called if it's currently a bad time to do
> + *     a retune of the SDIO card.  Retune requests made during this time
> + *     will be held and we'll actually do the retune sometime after the
> + *     release.
> + *
> + *     This function could be useful if an SDIO card is in a power state
> + *     where it can respond to a small subset of commands that doesn't
> + *     include the retuning command.  Care should be taken when using
> + *     this function since (presumably) the retuning request we might be
> + *     deferring was made for a good reason.
> + *
> + *     This function should be called while the host is claimed.
> + */
> +void sdio_retune_hold_now(struct sdio_func *func)
> +{
> +       mmc_retune_hold_now(func->card->host);
> +}
> +EXPORT_SYMBOL_GPL(sdio_retune_hold_now);
> +
> +/**
> + *     sdio_retune_release - signal that it's OK to retune now
> + *     @func: SDIO function attached to host
> + *
> + *     This is the complement to sdio_retune_hold_now().  Calling this
> + *     function won't make a retune happen right away but will allow
> + *     them to be scheduled normally.
> + *
> + *     This function should be called while the host is claimed.
> + */
> +void sdio_retune_release(struct sdio_func *func)
> +{
> +       mmc_retune_release(func->card->host);
> +}
> +EXPORT_SYMBOL_GPL(sdio_retune_release);
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
> index 4820e6d09dac..5a177f7a83c3 100644
> --- a/include/linux/mmc/sdio_func.h
> +++ b/include/linux/mmc/sdio_func.h
> @@ -170,4 +170,7 @@ extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
>  extern void sdio_retune_crc_disable(struct sdio_func *func);
>  extern void sdio_retune_crc_enable(struct sdio_func *func);
>
> +extern void sdio_retune_hold_now(struct sdio_func *func);
> +extern void sdio_retune_release(struct sdio_func *func);
> +
>  #endif /* LINUX_MMC_SDIO_FUNC_H */
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
