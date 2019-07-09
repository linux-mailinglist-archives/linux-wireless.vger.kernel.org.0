Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C84063552
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGIMCO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 08:02:14 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40722 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGIMCO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 08:02:14 -0400
Received: by mail-ua1-f68.google.com with SMTP id s4so6278096uad.7
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7TYxwUHfP1RfnvgzcLBrDO8C0nSGaZoAqyiz7wkUO0=;
        b=bBnHsG9K7MOhzR5Bv5tLfVTHlsTuhO6RPKpJUov0tdf584AghwZrNiXzG0kJkHudqN
         nmwJYmr0AOK9sHYdJVOZzdai0co1g9aB7wIwLwaWYRirePlRXQxuCDbcmAGCleOeSm/A
         yWwEmBC9TL10QjOTj2q48mOc/24zyrBAR7iW0XHv4oxQW4iEcocYUQjizVArb/Rs1pmD
         rrZZaNLWPOONrcVve/KHYtBV4kODBJ8bNey62c4GhetTs/G4Xq/eGkJOk0wywwC+NX9y
         mvsTvqelfGxIYoHtXTxlUv2N3UGSDWqfCOLHOK48Zouv6a/NHmbp1tfJc4dItzobgczW
         +LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7TYxwUHfP1RfnvgzcLBrDO8C0nSGaZoAqyiz7wkUO0=;
        b=pFmg9u+8K6PgiSPCm1bpcP0xlew4ZP4FNJs+YVSh6Lxx5GWrCv28E1ChJq+fVb6gg1
         zE9REN/N3YOVOqvr3RgrFMJvMMotUNMK0nSdO8DcU6nQcHzQGY3vFAffQvG3m7OKkc+h
         MV5VdleJs9Y4/p26dDurLpx9XCV4wU2xM1XwFapiTiOfyJ6IpyL3BnaNtpmORw18Jmz2
         uA+2DQ5ojkuSWv5Japuy7PhRohuqmunAjygO9OQSoVADhM3wpsbzE5tT+6hIN96QVu17
         ip0ztUY5deOTxMwGZJF5cipQO+f1u70ZJwkwb5yOn6BTdC83RZtlXz9gAHVigO93Rjz2
         CF9A==
X-Gm-Message-State: APjAAAXOmy+F4YdPqmD4uxirDZJdHtZxMP376ZBv90sMBRL1sMC3Gdwf
        DN8LyzV8T2GTd54s4ZrdrnC5hxn0mNIbnNtqgO8qxA==
X-Google-Smtp-Source: APXvYqxmymfOm1OuJ/ONX38D9R4w8a7/OllAaN8D6x8WVFfTkpw2ikWIZubP8RQ3yACii6tXJWtI5eR/ZPEwYNpc2+0=
X-Received: by 2002:ab0:60ad:: with SMTP id f13mr13647491uam.129.1562673732913;
 Tue, 09 Jul 2019 05:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
 <20190618153448.27145-5-ulf.hansson@linaro.org> <CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com>
 <CAPDyKFoHzCmobCtyy-j+-4xjW0Bt1_vA5-s4vHLVN78jXJ4X-w@mail.gmail.com> <CAD=FV=UfHd=_gqEMajABV19Mb=G-tz6VptDQa48g4kUPxo-A6g@mail.gmail.com>
In-Reply-To: <CAD=FV=UfHd=_gqEMajABV19Mb=G-tz6VptDQa48g4kUPxo-A6g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Jul 2019 14:01:36 +0200
Message-ID: <CAPDyKFpN38G-Oj-+cKcxQ8z8K7M_0sA6_CTSKuxvez2s3Td+xw@mail.gmail.com>
Subject: Re: [PATCH 4/7] mmc: sdio: Drop powered-on re-init at runtime resume
 and HW reset
To:     Doug Anderson <dianders@chromium.org>
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

On Mon, 8 Jul 2019 at 23:12, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 8, 2019 at 3:54 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 4 Jul 2019 at 02:02, Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > To use the so called powered-on re-initialization of an SDIO card, the
> > > > power to the card must obviously have stayed on. If not, the initialization
> > > > will simply fail.
> > > >
> > > > In the runtime suspend case, the card is always powered off. Hence, let's
> > > > drop the support for powered-on re-initialization during runtime resume, as
> > > > it doesn't make sense.
> > > >
> > > > Moreover, during a HW reset, the point is to cut the power to the card and
> > > > then do fresh re-initialization. Therefore drop the support for powered-on
> > > > re-initialization during HW reset.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/mmc/core/sdio.c | 8 +-------
> > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > >
> > > This has been on my list of things to test for a while but I never
> > > quite got to it...
> > >
> > > ...and then, today, I spent time bisecting why the "reset"
> > > functionality of miwfiex is broken on my 4.19 kernel [1].  AKA, this
> > > is broken:
> > >
> > > cd /sys/kernel/debug/mwifiex/mlan0
> > > echo 1 > reset
> > >
> > > I finally bisected the problem and tracked it down to commit
> > > ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs
> > > are enabled"), which embarrassingly has my Tested-by on it.  I guess I
> > > never tested the Marvell reset call.  :-/
> > >
> > > I dug a little and found that when the Marvell code did its reset we
> > > ended up getting a call to dw_mci_enable_sdio_irq(enb=0) and never saw
> > > a dw_mci_enable_sdio_irq(enb=1) after.  I tracked it down further and
> > > found that specifically it was the call to mmc_signal_sdio_irq() in
> > > mmc_sdio_power_restore() that was making the call.  The call stack
> > > shown for the "enb=0" call:
> > >
> > > [<c071a290>] (dw_mci_enable_sdio_irq) from [<c070a960>]
> > > (mmc_sdio_power_restore+0x98/0xc0)
> > > [<c070a960>] (mmc_sdio_power_restore) from [<c070a9b4>]
> > > (mmc_sdio_reset+0x2c/0x30)
> > > [<c070a9b4>] (mmc_signal_sdio_irq) from [<c06ff160>] (mmc_hw_reset+0xbc/0x138)
> > > [<c06ff160>] (mmc_hw_reset) from [<bf1bbad8>]
> > > (mwifiex_sdio_work+0x5d4/0x678 [mwifiex_sdio])
> > > [<bf1bbad8>] (mwifiex_sdio_work [mwifiex_sdio]) from [<c0247cd0>]
> > > (process_one_work+0x290/0x4b4)
> > >
> > > I picked your patch here (which gets rid of the call to
> > > mmc_signal_sdio_irq()) and magically the problem went away because
> > > there is no more call to mmc_signal_sdio_irq().
> > >
> > > I personally don't have lots of history about the whole
> > > "powered_resume" code path.  I checked and mmc_card_keep_power() was 0
> > > in my test case of getting called from hw_reset, so the rest of this
> > > patch doesn't affect me at all.  This surprised me a little since I
> > > saw "MMC_PM_KEEP_POWER" being set in mwifiex but then I realized that
> > > it was only set for the duration of suspend and then cleared by the
> > > core.  ;-)
> > >
> > > I will also say that I don't have any test case or knowledge of how
> > > SDIO runtime suspend/resume is supposed to work since on dw_mmc SDIO
> > > cards are currently not allowed to runtime suspend anyway.  ;-)
> > >
> > >
> > > So I guess the result of all that long-winded reply is that for on
> > > rk3288-veyron-jerry:
> > >
> > > Fixes: ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when
> > > SDIO IRQs are enabled")
> > > Tested-by: Douglas Anderson <dianders@chromium.org>
> >
> > Thanks a lot for testing and for your detailed feedback. I have
> > amended the patch by adding your tags above.
>
> Sure!  I'm going to try to do some detailed testing on the next patch
> too to confirm it's OK, but I have a few other tasks to get to first.
> ;-)
>
>
> > Moreover, we seems to need this for stable as well, but I am leaving
> > that to be managed as a separate task. We may even consider the hole
> > series for stable, but that requires more testing first.
>
> Sure, makes sense.  We'll pick it to the Chrome OS 4.19 kernel
> directly but it's usually nice to get fixes like this into stable so
> everyone can benefit.
>
>
> > > One last note is that, though Marvell WiFi works after a reset after
> > > this commit, Marvell Bluetooth (on the same SDIO module) doesn't.  I
> > > guess next week it'll be another bisect...
> >
> > Is the Bluetooth connected to the same SDIO interface, thus the
> > Bluetooth driver is an SDIO func driver?
>
> Yes, it's a SDIO func driver connected to the same interface.  So far
> I've managed to confirm the problem on:
>
> v4.4 (plus 76ae3e26ea43 mwifiex: add debugfs file for testing reset of card)
> v4.9
> next-20190708
>
> ...so it seems like it's not a "regression", it's just never worked.
> :-P  I guess I'll have to see if I can figure out what's different in
> our chromeos-3.14 kernel.  Ah, I see.  In 3.14 we had this solution:
>
> pr_err("Resetting card...\n");
> mmc_remove_host(reset_host);
> /* 200ms delay is based on experiment with sdhci controller */
> mdelay(200);
> reset_host->rescan_entered = 0;
> mmc_add_host(reset_host);
>
> ...I think that didn't fly upstream.  ...but I can confirm that this works fine:
>
> cd /sys/bus/platform/drivers/dwmmc_rockchip
> echo ff0d0000.dwmmc > unbind
> sleep .5
> echo ff0d0000.dwmmc > bind
>
> ...so I guess this boils down to: how does the mwifiex reset code not
> behave like a full removal and re-insertion of the card?  Oh, but
> maybe that's obvious.  We're doing all the reset / re-init from the
> WiFi side of things (mwifiex_sdio_card_reset_work) but I don't think
> anything is communicated to the Bluetooth side of things.  Presumably
> this is just totally broken for everyone?  ...or am I confused?

Nope, that is most likely what is happening.

I am not sure what is the best method to deal with this. Perhaps we
should invent some callback the SDIO core code can call, for each
active SDIO func on the particular SDIO card that becomes reset.

Or is there a better way you think?

Kind regards
Uffe
