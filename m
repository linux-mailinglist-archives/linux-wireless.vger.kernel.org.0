Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F510399F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 13:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfKTMLU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 07:11:20 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45159 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfKTMLT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 07:11:19 -0500
Received: by mail-vk1-f194.google.com with SMTP id s4so3810063vkk.12
        for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2019 04:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TTQmUnxx/A5I0Bxrjss+V5U2UZVsS2bqEfobf0oldI=;
        b=LkRSXf+ELb+h/vladC+QqVFmluR42y1NL2iY4BeJP3MohYqlUCaT0HwRUFtzJuhNph
         dy9vAoWzKulW6iqBvsbbT2++OLQDpmk+MEP59p57QtKW+uHyvX7uqZLzaz73CdRvsuJi
         5qAXSzywZmUj0D9w0LHoKgXV9WI+isr72MKXfDaPHDngF2gNcWULcFx2jzPBf8AOmBwq
         Lkw7wiOctL9NKFuECXwjCPBkwCxSsSDFcMS5C3v9t4/8MY21LOcohl4sdDqQgM1IWaYP
         insmHLPIJIUJ3k7nWEaOI3AIhotdkl8gciZnSXCkgmWKxGNuve0olbMxWab0kAVqPjXD
         okzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TTQmUnxx/A5I0Bxrjss+V5U2UZVsS2bqEfobf0oldI=;
        b=si4/ZbYLcpl7DjvxneGF7OEQmId8tZh9X205a9qioKzjZfIe29DAe0NTb6JWp4lkHg
         oV0m/szPYyJ3qojRtvF27lDDi8CfKJ2zvpb+GcxCUcdgFGsh18w3yrfaIfmejhdZ3CWa
         FbR6U2XMh8Rl1w/bVeoLPSonDHOiSoTNx2RDLO//o0YOyuf1U+YUWqkWLhvv+4oaR38G
         y5UQE8CNzeYc2jwiBkBWe/E5tRFlgpOKpetySUwJ2T4wL5/KZe3RgEMdNK1DY5TAjzXN
         zef24rwAWgQnqGEs9Z5yhWTk9kiY6xO95BYt2QtNAuM7yzwlsjvDoII8WYLU9vwWbWpk
         ah9Q==
X-Gm-Message-State: APjAAAUycgLlk/4uUVW5MALG+fzEIPAxCQnJ28Gqc4JpFRVUnTE4lYd3
        Hzhbbg226DTtJadP+vTezt+rh0Kf5sEBGDPjH1T5Tg==
X-Google-Smtp-Source: APXvYqx1NvzsYFgHrpNCMAwcfciLmzVErw4FNgcN0Ycp3GE4yO5vawQgneqbBpXdQIy8aO9tIPcLZWf4/9kDJf0vkC0=
X-Received: by 2002:ac5:cd47:: with SMTP id n7mr1215984vkm.101.1574251878287;
 Wed, 20 Nov 2019 04:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-4-ulf.hansson@linaro.org> <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
 <CAPDyKFrCyJBz2=RzKPxqn0FSEq500=dEDsTUWYZeoFKWvSRAdA@mail.gmail.com>
 <87zhgr5af6.fsf@codeaurora.org> <6e6b53b28581a8f1a2944ca0bc65311e@codeaurora.org>
 <0101016e87aeb8b6-761ad812-5da7-4b0d-8cae-c69633d90de0-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016e87aeb8b6-761ad812-5da7-4b0d-8cae-c69633d90de0-000000@us-west-2.amazonses.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 13:10:42 +0100
Message-ID: <CAPDyKFoWxw9r=GZhvF=TxHxo=zRfKr0hknEeQNPdfwPx4ORxuQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
To:     Kalle Valo <kvalo@codeaurora.org>, Wen Gong <wgong@codeaurora.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 20 Nov 2019 at 08:20, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> wgong@codeaurora.org writes:
>
> > On 2019-11-20 14:28, Kalle Valo wrote:
> >> + wen, ath10k
> >>
> >> Ulf Hansson <ulf.hansson@linaro.org> writes:
> >>
> >>> On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders@chromium.org>
> >>> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson
> >>>> <ulf.hansson@linaro.org> wrote:
> >>>> >
> >>>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >>>> > index 6f8342702c73..abf8f5eb0a1c 100644
> >>>> > --- a/drivers/mmc/core/core.c
> >>>> > +++ b/drivers/mmc/core/core.c
> >>>> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
> >>>> >         mmc_bus_put(host);
> >>>> >  }
> >>>> >
> >>>> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> >>>> > -                               bool cd_irq)
> >>>> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
> >>>> >  {
> >>>> >         /*
> >>>> >          * If the device is configured as wakeup, we prevent a new sleep for
> >>>> > @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
> >>>> >         ret = host->bus_ops->hw_reset(host);
> >>>> >         mmc_bus_put(host);
> >>>> >
> >>>> > -       if (ret)
> >>>> > +       if (ret < 0)
> >>>> >                 pr_warn("%s: tried to HW reset card, got error %d\n",
> >>>> >                         mmc_hostname(host), ret);
> >>>>
> >>>> Other callers besides marvell need to be updated?  In theory only
> >>>> SDIO
> >>>> should have positive return values so I guess we don't care about the
> >>>> caller in drivers/mmc/core/block.c, right?
> >>>
> >>> Correct, but maybe I should add some more information about that in a
> >>> function header of mmc_hw_reset(). Let me consider doing that as a
> >>> change on top.
> >>>
> >>>>  What about:
> >>>>
> >>>> drivers/net/wireless/ath/ath10k/sdio.c
> >>>>
> >>>> ...I guess I don't know if there is more than one function probed
> >>>> there.  Maybe there's not and thus we're fine here too?
> >>>
> >>> Well, honestly I don't know.
> >>>
> >>> In any case, that would mean the driver is broken anyways and needs to
> >>> be fixed. At least that's my approach to doing this change.
> >>
> >> Wen, does QCA6174 or QCA9377 SDIO devices have other SDIO functions,
> >> for
> >> example bluetooth? I'm just wondering how should we handle this in
> >> ath10k.
> >
> > it does not have other SDIO functions for QCA6174 or QCA9377.
>
> Thanks, then I don't think we need to change anything in ath10k.
>
> --
> Kalle Valo

Kalle, Wen - thanks for looking into this and for the confirmation.

One thing though, perhaps it's worth to add this as a comment in the
code for ath10k, where mmc_hw_reset() is called. Just to make it
clear.

Kind regards
Uffe
