Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7755363E63
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2019 01:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfGIXfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 19:35:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34226 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGIXfr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 19:35:47 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so768286iot.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLYclg4ubvXYAp8d++jPvg8MTD6u2FcKpktsiaOH49o=;
        b=fyaigPphLxAKyI8WYGuChKDTXa2pzW7ffY0rNX5IrGmhu1goqf6pBwdk7/WXxSNAtw
         uJETYxaY0YWsA+sM+vG34OoJrsfeDuRSGRsEmcIzfZBjG3w9MEGhxRAzFvYJldWsi6Wl
         2yftjdGdeTkX4mQvSj0yr5fujm2gyH/F8gqkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLYclg4ubvXYAp8d++jPvg8MTD6u2FcKpktsiaOH49o=;
        b=i873ohB9b1Nu5nPCJIU8GOz7xHhmoCXiKn9u4CRUUun+XZgEV/zO7AuQPJ8ivSrgeC
         47Pms7hOICe8f+GN12/GskSZZP2d15jl1Ob6Q2u2neCASt95QtcLr36ygIhdkWCubKZu
         vTPSyj7t/cMz4lWw4gPki4XqCpY29R/Nm3P+rknj5w3pjJuoxl9n4X11qufSK8sxYYd2
         p+/sKBsLjZwkEtMssMOOpGWr/tWEmwO1smUAMfV83PheQP6QOES0aitUnzTTW+lS+0yB
         n5c+ZeWi9COyaqpfcbp4dJju734ggSFJl1y4gBhtoI21hasahwscb+UnNmh17B+J71En
         QPRQ==
X-Gm-Message-State: APjAAAXs5dBHMtfMUfyhJGdWm5+E6Tb+JfODtfwg8t7Y+rewu2hoMVqz
        QpXAKJ68A23g5ZoucLcnv9fRP1vusKA=
X-Google-Smtp-Source: APXvYqwcezh+Lbr32hYJbqOpj8inHWqcET6r6VnSYPJkyEPZzzdhIV9LMkHjQyJu1iiv/8sB/zvAnA==
X-Received: by 2002:a5e:d618:: with SMTP id w24mr28693332iom.73.1562715345836;
        Tue, 09 Jul 2019 16:35:45 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id i4sm558901iog.31.2019.07.09.16.35.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 16:35:45 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id k8so768213iot.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 16:35:44 -0700 (PDT)
X-Received: by 2002:a6b:5103:: with SMTP id f3mr3561297iob.142.1562715344450;
 Tue, 09 Jul 2019 16:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
 <20190618153448.27145-5-ulf.hansson@linaro.org> <CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com>
 <CAPDyKFoHzCmobCtyy-j+-4xjW0Bt1_vA5-s4vHLVN78jXJ4X-w@mail.gmail.com>
 <CAD=FV=UfHd=_gqEMajABV19Mb=G-tz6VptDQa48g4kUPxo-A6g@mail.gmail.com> <CAPDyKFpN38G-Oj-+cKcxQ8z8K7M_0sA6_CTSKuxvez2s3Td+xw@mail.gmail.com>
In-Reply-To: <CAPDyKFpN38G-Oj-+cKcxQ8z8K7M_0sA6_CTSKuxvez2s3Td+xw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 16:35:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W_L7fV+Tra2oMBMVJUMOgvS9ZaOSy80fx+3cNrqW976g@mail.gmail.com>
Message-ID: <CAD=FV=W_L7fV+Tra2oMBMVJUMOgvS9ZaOSy80fx+3cNrqW976g@mail.gmail.com>
Subject: Re: [PATCH 4/7] mmc: sdio: Drop powered-on re-init at runtime resume
 and HW reset
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Jul 9, 2019 at 5:02 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 8 Jul 2019 at 23:12, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Jul 8, 2019 at 3:54 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 4 Jul 2019 at 02:02, Doug Anderson <dianders@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > To use the so called powered-on re-initialization of an SDIO card, the
> > > > > power to the card must obviously have stayed on. If not, the initialization
> > > > > will simply fail.
> > > > >
> > > > > In the runtime suspend case, the card is always powered off. Hence, let's
> > > > > drop the support for powered-on re-initialization during runtime resume, as
> > > > > it doesn't make sense.
> > > > >
> > > > > Moreover, during a HW reset, the point is to cut the power to the card and
> > > > > then do fresh re-initialization. Therefore drop the support for powered-on
> > > > > re-initialization during HW reset.
> > > > >
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > ---
> > > > >  drivers/mmc/core/sdio.c | 8 +-------
> > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > >
> > > > This has been on my list of things to test for a while but I never
> > > > quite got to it...
> > > >
> > > > ...and then, today, I spent time bisecting why the "reset"
> > > > functionality of miwfiex is broken on my 4.19 kernel [1].  AKA, this
> > > > is broken:
> > > >
> > > > cd /sys/kernel/debug/mwifiex/mlan0
> > > > echo 1 > reset
> > > >
> > > > I finally bisected the problem and tracked it down to commit
> > > > ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs
> > > > are enabled"), which embarrassingly has my Tested-by on it.  I guess I
> > > > never tested the Marvell reset call.  :-/
> > > >
> > > > I dug a little and found that when the Marvell code did its reset we
> > > > ended up getting a call to dw_mci_enable_sdio_irq(enb=0) and never saw
> > > > a dw_mci_enable_sdio_irq(enb=1) after.  I tracked it down further and
> > > > found that specifically it was the call to mmc_signal_sdio_irq() in
> > > > mmc_sdio_power_restore() that was making the call.  The call stack
> > > > shown for the "enb=0" call:
> > > >
> > > > [<c071a290>] (dw_mci_enable_sdio_irq) from [<c070a960>]
> > > > (mmc_sdio_power_restore+0x98/0xc0)
> > > > [<c070a960>] (mmc_sdio_power_restore) from [<c070a9b4>]
> > > > (mmc_sdio_reset+0x2c/0x30)
> > > > [<c070a9b4>] (mmc_signal_sdio_irq) from [<c06ff160>] (mmc_hw_reset+0xbc/0x138)
> > > > [<c06ff160>] (mmc_hw_reset) from [<bf1bbad8>]
> > > > (mwifiex_sdio_work+0x5d4/0x678 [mwifiex_sdio])
> > > > [<bf1bbad8>] (mwifiex_sdio_work [mwifiex_sdio]) from [<c0247cd0>]
> > > > (process_one_work+0x290/0x4b4)
> > > >
> > > > I picked your patch here (which gets rid of the call to
> > > > mmc_signal_sdio_irq()) and magically the problem went away because
> > > > there is no more call to mmc_signal_sdio_irq().
> > > >
> > > > I personally don't have lots of history about the whole
> > > > "powered_resume" code path.  I checked and mmc_card_keep_power() was 0
> > > > in my test case of getting called from hw_reset, so the rest of this
> > > > patch doesn't affect me at all.  This surprised me a little since I
> > > > saw "MMC_PM_KEEP_POWER" being set in mwifiex but then I realized that
> > > > it was only set for the duration of suspend and then cleared by the
> > > > core.  ;-)
> > > >
> > > > I will also say that I don't have any test case or knowledge of how
> > > > SDIO runtime suspend/resume is supposed to work since on dw_mmc SDIO
> > > > cards are currently not allowed to runtime suspend anyway.  ;-)
> > > >
> > > >
> > > > So I guess the result of all that long-winded reply is that for on
> > > > rk3288-veyron-jerry:
> > > >
> > > > Fixes: ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when
> > > > SDIO IRQs are enabled")
> > > > Tested-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > Thanks a lot for testing and for your detailed feedback. I have
> > > amended the patch by adding your tags above.
> >
> > Sure!  I'm going to try to do some detailed testing on the next patch
> > too to confirm it's OK, but I have a few other tasks to get to first.
> > ;-)
> >
> >
> > > Moreover, we seems to need this for stable as well, but I am leaving
> > > that to be managed as a separate task. We may even consider the hole
> > > series for stable, but that requires more testing first.
> >
> > Sure, makes sense.  We'll pick it to the Chrome OS 4.19 kernel
> > directly but it's usually nice to get fixes like this into stable so
> > everyone can benefit.
> >
> >
> > > > One last note is that, though Marvell WiFi works after a reset after
> > > > this commit, Marvell Bluetooth (on the same SDIO module) doesn't.  I
> > > > guess next week it'll be another bisect...
> > >
> > > Is the Bluetooth connected to the same SDIO interface, thus the
> > > Bluetooth driver is an SDIO func driver?
> >
> > Yes, it's a SDIO func driver connected to the same interface.  So far
> > I've managed to confirm the problem on:
> >
> > v4.4 (plus 76ae3e26ea43 mwifiex: add debugfs file for testing reset of card)
> > v4.9
> > next-20190708
> >
> > ...so it seems like it's not a "regression", it's just never worked.
> > :-P  I guess I'll have to see if I can figure out what's different in
> > our chromeos-3.14 kernel.  Ah, I see.  In 3.14 we had this solution:
> >
> > pr_err("Resetting card...\n");
> > mmc_remove_host(reset_host);
> > /* 200ms delay is based on experiment with sdhci controller */
> > mdelay(200);
> > reset_host->rescan_entered = 0;
> > mmc_add_host(reset_host);
> >
> > ...I think that didn't fly upstream.  ...but I can confirm that this works fine:
> >
> > cd /sys/bus/platform/drivers/dwmmc_rockchip
> > echo ff0d0000.dwmmc > unbind
> > sleep .5
> > echo ff0d0000.dwmmc > bind
> >
> > ...so I guess this boils down to: how does the mwifiex reset code not
> > behave like a full removal and re-insertion of the card?  Oh, but
> > maybe that's obvious.  We're doing all the reset / re-init from the
> > WiFi side of things (mwifiex_sdio_card_reset_work) but I don't think
> > anything is communicated to the Bluetooth side of things.  Presumably
> > this is just totally broken for everyone?  ...or am I confused?
>
> Nope, that is most likely what is happening.
>
> I am not sure what is the best method to deal with this. Perhaps we
> should invent some callback the SDIO core code can call, for each
> active SDIO func on the particular SDIO card that becomes reset.
>
> Or is there a better way you think?

I didn't get a chance to fully dig today, but I keep thinking that the
cleanest way would be if I could somehow tell the MMC core to pretend
to unplug the card and then re-plug it in.  Then we could go through
all the standard code paths.  I remember the last time I looked for a
nice way to do that I couldn't find one.

...barring that I wonder if it's enough to just remove and re-add all
the active SDIO funcs?

-Doug
