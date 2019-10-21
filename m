Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25AADF7DD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 00:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfJUWNj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Oct 2019 18:13:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39150 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJUWNj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Oct 2019 18:13:39 -0400
Received: by mail-io1-f65.google.com with SMTP id y12so337306ioa.6
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2019 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTBTIb7uX8kBH/yT0u2SZNScMLlRONMVcLtJ0vnMtbk=;
        b=YLiYk9sF8hX6S6MgP+5PthQsVKIO8eAIvEjyWhUUoWsT17OIIyUrjawoglwGLlOagi
         YBlJupYN6Z3Wj9kQw2FL/rlI1jM3ApYt3o2o5U08bV04hQKTj1htwj3CJd5au333PZhz
         29/tc2+ZTO4HXyViWSm5/nfwsoZKQmgpwxkeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTBTIb7uX8kBH/yT0u2SZNScMLlRONMVcLtJ0vnMtbk=;
        b=Ucx+sXFu1m37PIyqJbw4K4ohsVyubvTGjP4NewC13mvOuUUJv8rI/QnvTc3CcgW0CX
         L1f98i2fcxfGoyufwHMprvwCes46Y1h2a0qhXmYA4vhcyF76Y1w1t3OS+8108cI2csMX
         RjklFpDWYioLMBihU6Is8inXU5fpmixfeCXz9whoIN/CoxioBkiWhPsYSeB+9BsEin/9
         me+AogE4YLNcacHnGraHlksmEvFLwFsKTGuo6tlr5m9hJWljtjzGqMPrHrLVdZTz2LQz
         HmshCKc8ab3sCkEML5EN8aOTmdPmFwpqCwT4C71KBzjHewraaBcbWiZEgfuUtOA9G+O7
         ms+A==
X-Gm-Message-State: APjAAAWNSEUoyZJpP2droDAtRoHdcjeGAYOXAlXOK0if5R1FMHcGCREF
        6P/WkpLrN3ZC2mqa9QV0ZwNYOlEpTPk=
X-Google-Smtp-Source: APXvYqzgvMVEry/F4n5XuLfKiqf7PMa74/1zSBbmkfm8BsI3fF1oAkvig6VQsg0TcRNMONv/oIPGsg==
X-Received: by 2002:a6b:7514:: with SMTP id l20mr510555ioh.267.1571696016611;
        Mon, 21 Oct 2019 15:13:36 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id f9sm624485ioj.46.2019.10.21.15.13.34
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 15:13:35 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id c12so13571979ilm.1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2019 15:13:34 -0700 (PDT)
X-Received: by 2002:a92:d652:: with SMTP id x18mr26858977ilp.58.1571696013898;
 Mon, 21 Oct 2019 15:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-3-ulf.hansson@linaro.org>
In-Reply-To: <20191017135739.1315-3-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Oct 2019 15:13:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com>
Message-ID: <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Hi,

On Thu, Oct 17, 2019 at 6:58 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It have turned out that it's not a good idea to try to power cycle and to
> re-initialize the SDIO card, via mmc_hw_reset. This because there may be
> multiple SDIO funcs attached to the same SDIO card.
>
> To solve this problem, we would need to inform each of the SDIO func in
> some way when mmc_sdio_hw_reset() gets called, but that isn't an entirely
> trivial operation. Therefore, let's instead take the easy way out, by
> triggering a card removal and force a new rescan of the SDIO card.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c |  3 +--
>  drivers/mmc/core/core.h |  2 ++
>  drivers/mmc/core/sdio.c | 11 +++++++++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6f8342702c73..39c4567e39d8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>         mmc_bus_put(host);
>  }
>
> -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> -                               bool cd_irq)
> +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>  {
>         /*
>          * If the device is configured as wakeup, we prevent a new sleep for
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 328c78dbee66..575ac0257af2 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -70,6 +70,8 @@ void mmc_rescan(struct work_struct *work);
>  void mmc_start_host(struct mmc_host *host);
>  void mmc_stop_host(struct mmc_host *host);
>
> +void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> +                       bool cd_irq);
>  int _mmc_detect_card_removed(struct mmc_host *host);
>  int mmc_detect_card_removed(struct mmc_host *host);
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 26cabd53ddc5..5d7462c223c3 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1050,8 +1050,15 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
>
>  static int mmc_sdio_hw_reset(struct mmc_host *host)
>  {
> -       mmc_power_cycle(host, host->card->ocr);
> -       return mmc_sdio_reinit_card(host);
> +       /*
> +        * We may have more multiple SDIO funcs. Rather than to inform them all,
> +        * let's trigger a removal and force a new rescan of the card.
> +        */
> +       host->rescan_entered = 0;
> +       mmc_card_set_removed(host->card);
> +       _mmc_detect_change(host, 0, false);
> +
> +       return 0;
>  }

The problem I see here is that callers of this reset function aren't
expecting it to work this way.  Look specifically at
mwifiex_sdio_card_reset_work().  It's assuming that it needs to do
things like shutdown / reinit.  Now it's true that the old
mwifiex_sdio_card_reset_work() was pretty broken on any systems that
also had SDIO bluetooth, but presumably it worked OK on systems
without SDIO Bluetooth.  I don't think it'll work so well now.

Testing shows that indeed your patch breaks mwifiex reset worse than
it was before (AKA WiFi totally fails instead of it just killing
Bluetooth).

I think it may be better to add a new API call rather than trying to
co-opt the old one.  Maybe put a WARN_ON() for the old API call to
make people move away from it, or something?


...but on the bright side, your patch does seem to work.  If I add my
patch from <https://lkml.kernel.org/r/20190722193939.125578-3-dianders@chromium.org>
and change "sdio_trigger_replug(func)" to
"mmc_hw_reset(func->card->host)" then I can pass reboot tests.  I made
it through about 300 cycles of my old test before stopping the test to
work on other things.


In terms of the implementation, I will freely admit that I'm always
confused by the SD/MMC state machines, but as far as I can tell your
patch accomplishes the same thing as mine but in a bit simpler way.
;-)  I even confirmed that with your patch mmc_power_off() /
mmc_power_up are still called...

Thanks!

-Doug
