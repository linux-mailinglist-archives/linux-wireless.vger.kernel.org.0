Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBA961D46
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2019 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfGHKyc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jul 2019 06:54:32 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33444 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfGHKyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jul 2019 06:54:32 -0400
Received: by mail-vs1-f67.google.com with SMTP id m8so7888922vsj.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jul 2019 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyazCFmiETcHPerWNWUTvx/r+dCVSWwZ0Vi19gfw7Sc=;
        b=qZvpD2zHVwn6PaqQ10JpxZWZuQTM/93vh7IhhOoJRYwzU0qRFgx9zbKzYZnYN1dWFV
         s5UeS7Wmr/Q3MhsDEuN8bHhzpHKKDnFoXPaW0FZIaQfUyM54BzJRamfxU4xmOCKh0iUu
         jL4ep9iGPtxpx4V8Bv51txa/kCM/TTcKg+KjU7YdtvmKUB4uc44BfKZ7cLt+rJ01vfSk
         eW1+APOloO4bbWMTeIoNRdZtofnDOdthx06aZ25vOueZnE4yLKalJQsyoOdE/KaGKzGw
         Jn988/m8UjLu1lujciutB8r/+w76IaNn0n9qRsA6SjiGJtf23NZpBM9EB0gQgMAms9oQ
         0wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyazCFmiETcHPerWNWUTvx/r+dCVSWwZ0Vi19gfw7Sc=;
        b=U4cRUK/ssBRvGJqKTNN0GSSISANjhcOU3cGO3AhJKAEuub0hLAGBEY00Q26YDAZ1rj
         rdl3aAphHeA6/Zy0vywEwg8FUQ9/BDhXyca8+qbgt09p++AYUkZpuS4QESPVk5rGx6AU
         JjbCqAWBvLOpu2BzjBzqO+GmDb5rQLmFak2Tk+dSPAe+aL01/sBr/uN81n/F3d31CeMY
         rCdZcJc7HsnkIwsOFnLWBCZSz/B7fnAA1JdLEpemKkuxd3HcaNEm/AI+zIYZsWms4P1k
         H62pixzGqzZuODo8eIEMx7U8GAaemVg6yEcNYIRPM3O3TJ0hx3JTSsi8ntg8X9OMWpKD
         D3Rw==
X-Gm-Message-State: APjAAAWfoC27zRRac+jN12tzK2PncJJvt3deInwl2On9GzLyc0kbLqnF
        NuNuFLe8MiLqdZSNCT+JwVrLdUYeKCbqww6zwprUPg==
X-Google-Smtp-Source: APXvYqxXke3jonSsgDa/t8fMIraRgV8rH40j0h0c3P/E9HD9A4kO1rFrKZ6A6C+Na9T39v/pP5C1bcAk5pmymu0fz1o=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr9578415vsc.200.1562583270843;
 Mon, 08 Jul 2019 03:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
 <20190618153448.27145-5-ulf.hansson@linaro.org> <CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com>
In-Reply-To: <CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 12:53:54 +0200
Message-ID: <CAPDyKFoHzCmobCtyy-j+-4xjW0Bt1_vA5-s4vHLVN78jXJ4X-w@mail.gmail.com>
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

On Thu, 4 Jul 2019 at 02:02, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > To use the so called powered-on re-initialization of an SDIO card, the
> > power to the card must obviously have stayed on. If not, the initialization
> > will simply fail.
> >
> > In the runtime suspend case, the card is always powered off. Hence, let's
> > drop the support for powered-on re-initialization during runtime resume, as
> > it doesn't make sense.
> >
> > Moreover, during a HW reset, the point is to cut the power to the card and
> > then do fresh re-initialization. Therefore drop the support for powered-on
> > re-initialization during HW reset.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/sdio.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
>
> This has been on my list of things to test for a while but I never
> quite got to it...
>
> ...and then, today, I spent time bisecting why the "reset"
> functionality of miwfiex is broken on my 4.19 kernel [1].  AKA, this
> is broken:
>
> cd /sys/kernel/debug/mwifiex/mlan0
> echo 1 > reset
>
> I finally bisected the problem and tracked it down to commit
> ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs
> are enabled"), which embarrassingly has my Tested-by on it.  I guess I
> never tested the Marvell reset call.  :-/
>
> I dug a little and found that when the Marvell code did its reset we
> ended up getting a call to dw_mci_enable_sdio_irq(enb=0) and never saw
> a dw_mci_enable_sdio_irq(enb=1) after.  I tracked it down further and
> found that specifically it was the call to mmc_signal_sdio_irq() in
> mmc_sdio_power_restore() that was making the call.  The call stack
> shown for the "enb=0" call:
>
> [<c071a290>] (dw_mci_enable_sdio_irq) from [<c070a960>]
> (mmc_sdio_power_restore+0x98/0xc0)
> [<c070a960>] (mmc_sdio_power_restore) from [<c070a9b4>]
> (mmc_sdio_reset+0x2c/0x30)
> [<c070a9b4>] (mmc_signal_sdio_irq) from [<c06ff160>] (mmc_hw_reset+0xbc/0x138)
> [<c06ff160>] (mmc_hw_reset) from [<bf1bbad8>]
> (mwifiex_sdio_work+0x5d4/0x678 [mwifiex_sdio])
> [<bf1bbad8>] (mwifiex_sdio_work [mwifiex_sdio]) from [<c0247cd0>]
> (process_one_work+0x290/0x4b4)
>
> I picked your patch here (which gets rid of the call to
> mmc_signal_sdio_irq()) and magically the problem went away because
> there is no more call to mmc_signal_sdio_irq().
>
> I personally don't have lots of history about the whole
> "powered_resume" code path.  I checked and mmc_card_keep_power() was 0
> in my test case of getting called from hw_reset, so the rest of this
> patch doesn't affect me at all.  This surprised me a little since I
> saw "MMC_PM_KEEP_POWER" being set in mwifiex but then I realized that
> it was only set for the duration of suspend and then cleared by the
> core.  ;-)
>
> I will also say that I don't have any test case or knowledge of how
> SDIO runtime suspend/resume is supposed to work since on dw_mmc SDIO
> cards are currently not allowed to runtime suspend anyway.  ;-)
>
>
> So I guess the result of all that long-winded reply is that for on
> rk3288-veyron-jerry:
>
> Fixes: ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when
> SDIO IRQs are enabled")
> Tested-by: Douglas Anderson <dianders@chromium.org>

Thanks a lot for testing and for your detailed feedback. I have
amended the patch by adding your tags above.

Moreover, we seems to need this for stable as well, but I am leaving
that to be managed as a separate task. We may even consider the hole
series for stable, but that requires more testing first.

>
>
> One last note is that, though Marvell WiFi works after a reset after
> this commit, Marvell Bluetooth (on the same SDIO module) doesn't.  I
> guess next week it'll be another bisect...

Is the Bluetooth connected to the same SDIO interface, thus the
Bluetooth driver is an SDIO func driver?

>
> [1] https://crbug.com/981113
>
>
>
> -Doug

Kind regards
Uffe
