Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6DDF8FA7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 13:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfKLM2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 07:28:09 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37098 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLM2J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 07:28:09 -0500
Received: by mail-ua1-f68.google.com with SMTP id l38so4637165uad.4
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 04:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NYg2sxdqAsdXos9vvX1IK6xw/RmjO17Tz1dB+pQ0DM=;
        b=Fs6NY4Ad3ARsyWYAWHaERSV0iC1+Y5MCFDdQ1P0uXBdvnf7i+8/I+T2cLEGs2VpyC1
         Najxtan+b2r+o+Ma7jyTRFamJxKf0jHwXDwQ+kOv2QMgEEzbJpEPfvMDNrraVjV98nFw
         uqbTKbl+BUkyNEwlWakssLwACBJZeC8xkl8+f9bt2gxN5Uck71m6TGonP6D7Z3S3oYEy
         BHsKVhxOtAC9fInN1fcpLlug79dPEenlEoaD7SSu3pv/XEyNO3YDoHgNdb+sHZXbLti0
         6La01K+3EJTmFTiK+U14M/PS/usd8NoEMzdpLdj3XqpW5tUnjyAwuFQyPZU+dF7NjA5u
         a5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NYg2sxdqAsdXos9vvX1IK6xw/RmjO17Tz1dB+pQ0DM=;
        b=MWmDehZST4kpchCWG4kZWUBz4kk5TneoZFnoYSWk4/20DFjKd+Ihm2JlBpOoCkeVeR
         n0A0Rj3NLpdgLiMcqyt3SmmFxLkoZI+UUqwzx3+Esfyt0WrsAViN9grt8guYqbPtf9A9
         HQVq3xgKtMF0pIs2G1EPEOyguwjh9ZxeUQlZ83/8mE7QgNCnn2gfCmqsO3q0tcfatF8p
         r6viJ1rgLe6B2zO2Ii6a5m5fqb1mdiz9Pt0fOTFkZHcqm3MEF7AjI9dyPH6Q4yzKT3EY
         vcmwd7vcvj09c7w+/xz8eBlhwpUSP8vqjFmWrx0DTOMBRENvmg/5Ars0kisUOxgSCTKW
         BsKA==
X-Gm-Message-State: APjAAAWNbuaDQInMALXn+HGwSy1xUekEQX0m0oW3J54iPhFh5ZctfDFq
        8lyPB8zlcTA/L/ofBypfjczwlmRHhMLpnPOfLWelbg==
X-Google-Smtp-Source: APXvYqwda2bfTq3yanw3EPvprThtje6SP+M80JO7LvZx61psZkCnhHJrveEBqopM0g05IZvpSa0yX25nTGENItz7vdI=
X-Received: by 2002:ab0:3399:: with SMTP id y25mr3120372uap.100.1573561685196;
 Tue, 12 Nov 2019 04:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org> <CAD=FV=Wv9DgzQZZE8YvB+qjBzPsKdJvafSnFy8YAN_dN6UJbtQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Wv9DgzQZZE8YvB+qjBzPsKdJvafSnFy8YAN_dN6UJbtQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Nov 2019 13:27:29 +0100
Message-ID: <CAPDyKFq5=B8u=9awGaXuhTmYK6Sbbe6EmF9EMhBQQyyrD1bKRw@mail.gmail.com>
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

On Tue, 12 Nov 2019 at 01:51, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v2:
> >         - Add adaptations to the mwifiex driver.
> >         - Keep existing syncronous reset behaviour if the SDIO card has a single
> >         func driver.
> >
> > It has turned out that it's not a good idea to try to power cycle and to
> > re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
> > because there may be multiple SDIO funcs attached to the same SDIO card and
> > some of the others that didn't execute the call to mmc_hw_reset(), may then
> > simply experience an undefined behaviour.
> >
> > The following patches in this series attempts to address this problem, by
> > reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
> > mwifiex driver to these changes.
> >
> > Note that, I don't have the HW at hand so the the code has only compile tested.
> > Test on HW is greatly appreciated!
> >
> > Ulf Hansson (3):
> >   mwifiex: Re-work support for SDIO HW reset
> >   mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
> >   mmc: core: Re-work HW reset for SDIO cards
> >
> >  drivers/mmc/core/core.c                     | 12 +++-----
> >  drivers/mmc/core/core.h                     |  2 ++
> >  drivers/mmc/core/sdio.c                     | 28 ++++++++++++++++-
> >  drivers/mmc/core/sdio_bus.c                 |  9 +++++-
> >  drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
> >  drivers/net/wireless/marvell/mwifiex/main.h |  1 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
> >  include/linux/mmc/card.h                    |  1 +
> >  8 files changed, 70 insertions(+), 22 deletions(-)
>
> I put this on rk3288-veyron-jerry atop v5.4-rc7 and I could run my
> test case for a while, AKA I got over 50 cycles of:
>
> ---
>
> for i in $(seq 1000); do
>   echo "LOOP $i --------"
>   echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset
>
>   while true; do
>     if ! ping6 -w15 -c1 "${GW}" >/dev/null 2>&1; then
>       fail=$(( fail + 1 ))
>       echo "Fail WiFi ${fail}"
>       if [[ ${fail} == 3 ]]; then
>         exit 1
>       fi
>     else
>       fail=0
>       break
>     fi
>   done
>
>   hciconfig hci0 down
>   sleep 1
>   if ! hciconfig hci0 up; then
>     echo "Fail BT"
>     exit 1
>   fi
>
> done
>
> ---
>
> NOTE: with no patches I couldn't even get my test case to pass w/out
> the BT bits and I swear that used to work before.  ...but I didn't
> debug since the end result (with full card hotplug) is happy-working
> for me.  I'll still use it as further argument that (IMO) full unplug
> / plug of the card is better it uses more standard code paths and is
> less likely to break.  ;-)
>
> Tested-by: Douglas Anderson <dianders@chromium.org>

Thanks, I add this to the series and make a re-spin.

What do you think about tagging the patches for stable?

I guess there is a risk that we may "break" the other two users of
mmc_hw_reset(). But, as I said, in that case those needs to be fixed
anyways.

Kind regards
Uffe
