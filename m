Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5162AB3
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2019 23:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbfGHVM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jul 2019 17:12:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40103 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfGHVM4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jul 2019 17:12:56 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so30309298iom.7
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jul 2019 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hIeaajyw500fJnJGNNNHDu3MsgjWCQ+XfK0sXNM8fg=;
        b=FK3VWVeeOVvAYGYu29dfojz/KKzgOlwrjURUJT1j9gsNcsQXEmfDbafvX003L8ECHf
         vxECi5X3tOppTeebFug5HQhlVZiPSbLQatlzVB/8rCixKclaNNupmBFX+rUlQaQV3G62
         V2J35yykeWOg5La0TrdT5EixD+6AAJZ6N9z6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hIeaajyw500fJnJGNNNHDu3MsgjWCQ+XfK0sXNM8fg=;
        b=clkVWAD2FY9N600zr7axF0yy3wnsFoGAgl/vnGHk22qnwqo5itZKJYqYn7kS0jGun2
         bYh0kLG0afn9fnpXNsbF8jc6w/uuH+2vmBKBLlcunWYK4aXMWg1HlcwbjAW63ZqJkQhe
         mvDa2lM0uZG/FZWkcLy9MU0pIUS9ai0g72nav4NXJvZlxgcwPysshTKTHge9yY/6Tfns
         7rmGFzWWjX/bfMhcbfMVm0noJ2nlQA//qv2J1QAGeQAXsksjq0Q2FZnK7vZLpXFiNISF
         p7WtX23lxj1+2ydT/HxocqwgWq0qShrnb2O95UdkQY+brQm2706H5afSppECE+Kq87IU
         a/KQ==
X-Gm-Message-State: APjAAAVCV9MFkTMdBybAOaXzPA69XDn4Qi8XXPuNFmk5zajEJOYMrzHY
        ehxIJPEpjHCwSSwQWxEzTtB2DQeK5dk=
X-Google-Smtp-Source: APXvYqzUi2z8oYpEGiMkNFZSLrS5kZmZ3Gof+RRdqWZhF8Je1DHq0o7Mr4WswL7GGZYdIy0sizFmAw==
X-Received: by 2002:a02:6016:: with SMTP id i22mr23342560jac.56.1562620374257;
        Mon, 08 Jul 2019 14:12:54 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id n7sm14371665ioo.79.2019.07.08.14.12.53
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 14:12:53 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id q22so16720898iog.4
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jul 2019 14:12:53 -0700 (PDT)
X-Received: by 2002:a5d:8ccc:: with SMTP id k12mr21179336iot.141.1562620372772;
 Mon, 08 Jul 2019 14:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
 <20190618153448.27145-5-ulf.hansson@linaro.org> <CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com>
 <CAPDyKFoHzCmobCtyy-j+-4xjW0Bt1_vA5-s4vHLVN78jXJ4X-w@mail.gmail.com>
In-Reply-To: <CAPDyKFoHzCmobCtyy-j+-4xjW0Bt1_vA5-s4vHLVN78jXJ4X-w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 Jul 2019 14:12:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UfHd=_gqEMajABV19Mb=G-tz6VptDQa48g4kUPxo-A6g@mail.gmail.com>
Message-ID: <CAD=FV=UfHd=_gqEMajABV19Mb=G-tz6VptDQa48g4kUPxo-A6g@mail.gmail.com>
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

On Mon, Jul 8, 2019 at 3:54 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 4 Jul 2019 at 02:02, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > To use the so called powered-on re-initialization of an SDIO card, the
> > > power to the card must obviously have stayed on. If not, the initialization
> > > will simply fail.
> > >
> > > In the runtime suspend case, the card is always powered off. Hence, let's
> > > drop the support for powered-on re-initialization during runtime resume, as
> > > it doesn't make sense.
> > >
> > > Moreover, during a HW reset, the point is to cut the power to the card and
> > > then do fresh re-initialization. Therefore drop the support for powered-on
> > > re-initialization during HW reset.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/mmc/core/sdio.c | 8 +-------
> > >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > This has been on my list of things to test for a while but I never
> > quite got to it...
> >
> > ...and then, today, I spent time bisecting why the "reset"
> > functionality of miwfiex is broken on my 4.19 kernel [1].  AKA, this
> > is broken:
> >
> > cd /sys/kernel/debug/mwifiex/mlan0
> > echo 1 > reset
> >
> > I finally bisected the problem and tracked it down to commit
> > ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs
> > are enabled"), which embarrassingly has my Tested-by on it.  I guess I
> > never tested the Marvell reset call.  :-/
> >
> > I dug a little and found that when the Marvell code did its reset we
> > ended up getting a call to dw_mci_enable_sdio_irq(enb=0) and never saw
> > a dw_mci_enable_sdio_irq(enb=1) after.  I tracked it down further and
> > found that specifically it was the call to mmc_signal_sdio_irq() in
> > mmc_sdio_power_restore() that was making the call.  The call stack
> > shown for the "enb=0" call:
> >
> > [<c071a290>] (dw_mci_enable_sdio_irq) from [<c070a960>]
> > (mmc_sdio_power_restore+0x98/0xc0)
> > [<c070a960>] (mmc_sdio_power_restore) from [<c070a9b4>]
> > (mmc_sdio_reset+0x2c/0x30)
> > [<c070a9b4>] (mmc_signal_sdio_irq) from [<c06ff160>] (mmc_hw_reset+0xbc/0x138)
> > [<c06ff160>] (mmc_hw_reset) from [<bf1bbad8>]
> > (mwifiex_sdio_work+0x5d4/0x678 [mwifiex_sdio])
> > [<bf1bbad8>] (mwifiex_sdio_work [mwifiex_sdio]) from [<c0247cd0>]
> > (process_one_work+0x290/0x4b4)
> >
> > I picked your patch here (which gets rid of the call to
> > mmc_signal_sdio_irq()) and magically the problem went away because
> > there is no more call to mmc_signal_sdio_irq().
> >
> > I personally don't have lots of history about the whole
> > "powered_resume" code path.  I checked and mmc_card_keep_power() was 0
> > in my test case of getting called from hw_reset, so the rest of this
> > patch doesn't affect me at all.  This surprised me a little since I
> > saw "MMC_PM_KEEP_POWER" being set in mwifiex but then I realized that
> > it was only set for the duration of suspend and then cleared by the
> > core.  ;-)
> >
> > I will also say that I don't have any test case or knowledge of how
> > SDIO runtime suspend/resume is supposed to work since on dw_mmc SDIO
> > cards are currently not allowed to runtime suspend anyway.  ;-)
> >
> >
> > So I guess the result of all that long-winded reply is that for on
> > rk3288-veyron-jerry:
> >
> > Fixes: ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when
> > SDIO IRQs are enabled")
> > Tested-by: Douglas Anderson <dianders@chromium.org>
>
> Thanks a lot for testing and for your detailed feedback. I have
> amended the patch by adding your tags above.

Sure!  I'm going to try to do some detailed testing on the next patch
too to confirm it's OK, but I have a few other tasks to get to first.
;-)


> Moreover, we seems to need this for stable as well, but I am leaving
> that to be managed as a separate task. We may even consider the hole
> series for stable, but that requires more testing first.

Sure, makes sense.  We'll pick it to the Chrome OS 4.19 kernel
directly but it's usually nice to get fixes like this into stable so
everyone can benefit.


> > One last note is that, though Marvell WiFi works after a reset after
> > this commit, Marvell Bluetooth (on the same SDIO module) doesn't.  I
> > guess next week it'll be another bisect...
>
> Is the Bluetooth connected to the same SDIO interface, thus the
> Bluetooth driver is an SDIO func driver?

Yes, it's a SDIO func driver connected to the same interface.  So far
I've managed to confirm the problem on:

v4.4 (plus 76ae3e26ea43 mwifiex: add debugfs file for testing reset of card)
v4.9
next-20190708

...so it seems like it's not a "regression", it's just never worked.
:-P  I guess I'll have to see if I can figure out what's different in
our chromeos-3.14 kernel.  Ah, I see.  In 3.14 we had this solution:

pr_err("Resetting card...\n");
mmc_remove_host(reset_host);
/* 200ms delay is based on experiment with sdhci controller */
mdelay(200);
reset_host->rescan_entered = 0;
mmc_add_host(reset_host);

...I think that didn't fly upstream.  ...but I can confirm that this works fine:

cd /sys/bus/platform/drivers/dwmmc_rockchip
echo ff0d0000.dwmmc > unbind
sleep .5
echo ff0d0000.dwmmc > bind

...so I guess this boils down to: how does the mwifiex reset code not
behave like a full removal and re-insertion of the card?  Oh, but
maybe that's obvious.  We're doing all the reset / re-init from the
WiFi side of things (mwifiex_sdio_card_reset_work) but I don't think
anything is communicated to the Bluetooth side of things.  Presumably
this is just totally broken for everyone?  ...or am I confused?


-Doug


-Doug
