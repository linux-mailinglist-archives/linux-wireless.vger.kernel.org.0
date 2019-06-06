Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138E737FCA
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 23:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfFFVom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 17:44:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38483 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFFVom (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 17:44:42 -0400
Received: by mail-it1-f195.google.com with SMTP id h9so2370080itk.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2019 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QBdyZj1I7drp/b50HZlmF43JSxnAeWa0jxxMiyIVXc=;
        b=NolPoyDjYnIQMci7PwsT9RiWgwW+ar1+vnt93teKnZ+fxxJNLXO3YLuOLArf7tOCTZ
         neucsp0wiztZ64STtyZMYnz0lS0niok/nsimcR0/BPboY/HHGPohUIqIVLGjoKryaGfk
         xdAEjhPQnEEPaLFpGW/3rtXuLULRKrkaHRARM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QBdyZj1I7drp/b50HZlmF43JSxnAeWa0jxxMiyIVXc=;
        b=tPq9x+oY598/SdSeQo8iQmzO16Q3Wj1nA8k2A64TfjAUiEygyMfds8sKMNlAZYilWW
         r+FB/loFJedQjdtGaWamm2o9ZDV0fPKeTc2EDDLnAdpp0vgy/+yGcq5qk1Y0hF6QiR3D
         6j/LZTiG2i8WBFbWzEzUEZZYPHWsFOYYBjZtmD6S8JSLmuXkQBWdRQzILTxBDHfS1K8J
         zv/bIlzBBmrtw8Gl0XY5mdJVVt7UKgRmQuk/LL9INYzmYsIbI2mvOpQCBY+j76uBmyLK
         yd3qnR/mc4LLM8dMRE4XnfgaUqOt1IJPIQlfFTsaWEuR8ba2BAaVyCia4EO5nfzvcyzZ
         BoPw==
X-Gm-Message-State: APjAAAVhJz4TXN1jZ6pFiVqdbq7StKSm6mG9qe2a4tKQZvsRNO4p/UsC
        mSVxWASsQF3fmvJGyzCCA9+AMVUXJsg=
X-Google-Smtp-Source: APXvYqyCWwQ5PNl/5SvbLzrqmDcARohfbfDqiHRV6o3w6/ZouC4nEwnr8TUZj+hvowwx9RE6/MATcA==
X-Received: by 2002:a02:b01c:: with SMTP id p28mr33404990jah.130.1559857480489;
        Thu, 06 Jun 2019 14:44:40 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id j13sm16744ioa.76.2019.06.06.14.44.40
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 14:44:40 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id u13so1444371iop.0
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2019 14:44:40 -0700 (PDT)
X-Received: by 2002:a05:6602:2006:: with SMTP id y6mr29144619iod.218.1559857037515;
 Thu, 06 Jun 2019 14:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190603183740.239031-1-dianders@chromium.org>
 <20190603183740.239031-4-dianders@chromium.org> <42fc30b1-adab-7fa8-104c-cbb7855f2032@intel.com>
In-Reply-To: <42fc30b1-adab-7fa8-104c-cbb7855f2032@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jun 2019 14:37:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UPfCOr-syAbVZ-FjHQy7bgQf5BS5pdV-Bwd3hquRqEGg@mail.gmail.com>
Message-ID: <CAD=FV=UPfCOr-syAbVZ-FjHQy7bgQf5BS5pdV-Bwd3hquRqEGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] brcmfmac: sdio: Disable auto-tuning around
 commands expected to fail
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
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
        netdev <netdev@vger.kernel.org>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Franky Lin <franky.lin@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Jun 6, 2019 at 7:00 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/06/19 9:37 PM, Douglas Anderson wrote:
> > There are certain cases, notably when transitioning between sleep and
> > active state, when Broadcom SDIO WiFi cards will produce errors on the
> > SDIO bus.  This is evident from the source code where you can see that
> > we try commands in a loop until we either get success or we've tried
> > too many times.  The comment in the code reinforces this by saying
> > "just one write attempt may fail"
> >
> > Unfortunately these failures sometimes end up causing an "-EILSEQ"
> > back to the core which triggers a retuning of the SDIO card and that
> > blocks all traffic to the card until it's done.
> >
> > Let's disable retuning around the commands we expect might fail.
>
> It seems to me that re-tuning needs to be prevented before the
> first access otherwise it might be attempted there,

By this I think you mean I wasn't starting my section early enough to
catch the "1st KSO write".  Oops.  Thanks!


> and it needs
> to continue to be prevented during the transition when it might
> reasonably be expected to fail.
>
> What about something along these lines:
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 4e15ea57d4f5..d932780ef56e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -664,9 +664,18 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
>         int err = 0;
>         int err_cnt = 0;
>         int try_cnt = 0;
> +       int need_retune = 0;
> +       bool retune_release = false;
>
>         brcmf_dbg(TRACE, "Enter: on=%d\n", on);
>
> +       /* Cannot re-tune if device is asleep */
> +       if (on) {
> +               need_retune = sdio_retune_get_needed(bus->sdiodev->func1); // TODO: host->can_retune ? host->need_retune : 0
> +               sdio_retune_hold_now(bus->sdiodev->func1); // TODO: add sdio_retune_hold_now()
> +               retune_release = true;
> +       }

The code below still has retries even for the "!on" case.  That
implies that you could still get CRC errors from the card in the "!on"
direction too.  Any reason why we shouldn't just hold retuning even
for the !on case?


> +
>         wr_val = (on << SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT);
>         /* 1st KSO write goes to AOS wake up core if device is asleep  */
>         brcmf_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR, wr_val, &err);
> @@ -711,8 +720,16 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
>                         err_cnt = 0;
>                 }
>                 /* bail out upon subsequent access errors */
> -               if (err && (err_cnt++ > BRCMF_SDIO_MAX_ACCESS_ERRORS))
> -                       break;
> +               if (err && (err_cnt++ > BRCMF_SDIO_MAX_ACCESS_ERRORS)) {
> +                       if (!retune_release)
> +                               break;
> +                       /*
> +                        * Allow one more retry with re-tuning released in case
> +                        * it helps.
> +                        */
> +                       sdio_retune_release(bus->sdiodev->func1);
> +                       retune_release = false;

I would be tempted to wait before adding this logic until we actually
see that it's needed.  Sure, doing one more transfer probably won't
really hurt, but until we know that it actually helps it seems like
we're just adding extra complexity?


> +               }
>
>                 udelay(KSO_WAIT_US);
>                 brcmf_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR, wr_val,
> @@ -727,6 +744,18 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
>         if (try_cnt > MAX_KSO_ATTEMPTS)
>                 brcmf_err("max tries: rd_val=0x%x err=%d\n", rd_val, err);
>
> +       if (retune_release) {
> +               /*
> +                * CRC errors are not unexpected during the transition but they
> +                * also trigger re-tuning. Clear that here to avoid an
> +                * unnecessary re-tune if it wasn't already triggered to start
> +                * with.
> +                */
> +               if (!need_retune)
> +                       sdio_retune_clear_needed(bus->sdiodev->func1); // TODO: host->need_retune = 0
> +               sdio_retune_release(bus->sdiodev->func1); // TODO: add sdio_retune_release()
> +       }

Every time I re-look at this I have to re-figure out all the subtle
differences between the variables and functions involved here.  Let me
see if I got everything right:

* need_retune: set to 1 if we can retune and some event happened that
makes us truly believe that we need to be retuned, like we got a CRC
error or a timer expired or our host controller told us to retune.

* retune_now: set to 1 it's an OK time to be retuning.  Specifically
if retune_now is false we won't send any retuning commands but we'll
still keep track of the need to retune.

* hold_retune: If this gets set to 1 by mmc_retune_hold_now() then a
future call to mmc_retune_hold() will _not_ schedule a retune by
setting retune_now (because mmc_retune_hold() will see that
hold_retune was already 1).  ...and a future call to
mmc_retune_recheck() between mmc_hold() and mmc_release() will also
not schedule a retune because hold_retune will be 2 (or generally >
1).

---

So overall trying to summarize what I think are the differences
between your patch and my patch.

1. If we needed to re-tune _before_ calling brcmf_sdio_kso_control(),
with your patch we'll make sure that we don't actually attempt to
retune until brcmf_sdio_kso_control() finishes.

2. If we needed to retune during brcmf_sdio_kso_control() (because a
timer expired?) then we wouldn't trigger that retune while
brcmf_sdio_kso_control() is running.

In the case of dw_mmc, which I'm most familiar with, we don't have any
sort of automated or timed-based retuning.  ...so we'll only re-tune
when we see the CRC error.  If I'm understanding things correctly then
that for dw_mmc my solution and yours behave the same.  That means the
difference is how we deal with other retuning requests, either ones
that come about because of an interrupt that the host controller
provided or because of a timer.  Did I get that right?

...and I guess the reason we have to deal specially with these cases
is because any time that SDIO card is "sleeping" we don't want to
retune because it won't work.  Right?  NOTE: the solution that would
come to my mind first to solve this would be to hold the retuning for
the whole time that the card was sleeping and then release it once the
card was awake again.  ...but I guess we don't truly need to do that
because tuning only happens as a side effect of sending a command to
the card and the only command we send to the card is the "wake up"
command.  That's why your solution to hold tuning while sending the
"wake up" command works, right?

---

OK, so assuming all the above is correct, I feel like we're actually
solving two problems and in fact I believe we actually need both our
approaches to solve everything correctly.  With just your patch in
place there's a problem because we will clobber any external retuning
requests that happened while we were waking up the card.  AKA, imagine
this:

A) brcmf_sdio_kso_control(on=True) gets called; need_retune starts as 0

B) We call sdio_retune_hold_now()

C) A retuning timer goes off or the SD Host controller tells us to retune

D) We get to the end of brcmf_sdio_kso_control() and clear the "retune
needed" since need_retune was 0 at the start.

...so we dropped the retuning request from C), right?


What we truly need is:

1. CRC errors shouldn't trigger a retuning request when we're in
brcmf_sdio_kso_control()

2. A separate patch that holds any retuning requests while the SDIO
card is off.  This patch _shouldn't_ do any clearing of retuning
requests, just defer them.


Does that make sense to you?  If so, I can try to code it up...


-Doug
