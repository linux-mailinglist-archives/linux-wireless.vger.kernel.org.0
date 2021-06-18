Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828213AD29C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhFRTPq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 15:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhFRTPl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 15:15:41 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331EC061574
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 12:13:30 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10735316otl.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geNt5pqM99X52K3k6bvb47iPYJ3AMaw6mG4JxCAoCRU=;
        b=GLeyGx2Rv7Z+ibDAX7ALsbfGhXcD1ljjAJjoNgyY8mGYRjz+z0MbGxoM2obArL5Mcm
         tcE2ykTJw0MgiA/UGh0rs5CYVWJJgSkumRzRR9/22ZDBMtRuZt6a4wRF1Fwf8vdB7Day
         M4RfY/2GkfvTrr6xK8ODuOAx3NwGnIsLmP78c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geNt5pqM99X52K3k6bvb47iPYJ3AMaw6mG4JxCAoCRU=;
        b=jKFl1ig4K7PLLJ/dCOPi3Kz+WPdnvGjAGTO8oIB0929/HL3xGrrD6OVDfGNLc8YqD2
         4J90f1H0OfcVuDZJNflSmNgGGBs0SlFmZvWqthHORGgRS82j8S28IDPlGSodeGpK5d/T
         Ti3B2yGkjKr+STF/bNERvWzAFcj16g9C8YyRB+UgOvIbqIW4eqGje2LxyLJDW2qmbgV+
         x9y5/wBQ1Kxxd1FwaADat9FHQrJKlbLX5z58MOiKWsOx4ECcMyrw5suTIU0ezAhaY/jQ
         xV0vhsrNmsVhkWMTPBeleTjMrxm1Mv9n6jciLNbBFF4jZjgsE7+aJR05IUZnH4Bma5yR
         QvIg==
X-Gm-Message-State: AOAM5305j0We4sHbVezzgfl+Oj0LwzsRocm/p5U47mT+Sm0LLCgqZtS2
        yXnbVTpT/YDUpaT4enunGOylTR5fLyD6SQ==
X-Google-Smtp-Source: ABdhPJwTpFn4k67fNMi2J+vhptgQBeYTKPpPUgJHbzPbwhqul6lzidUY2NEtPxk65+v8Wt8Z3Fn/1Q==
X-Received: by 2002:a05:6830:821:: with SMTP id t1mr10809338ots.227.1624043609066;
        Fri, 18 Jun 2021 12:13:29 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id w12sm1621625oor.35.2021.06.18.12.13.27
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 12:13:28 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id r16so11666958oiw.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 12:13:27 -0700 (PDT)
X-Received: by 2002:aca:1c11:: with SMTP id c17mr9840531oic.77.1624043607297;
 Fri, 18 Jun 2021 12:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210429080149.7068-1-pkshih@realtek.com> <20210429080149.7068-10-pkshih@realtek.com>
 <YMFzAZUysQ5HxZlK@google.com> <45dd7da687a444d5acbc13eb67dcee97@realtek.com>
In-Reply-To: <45dd7da687a444d5acbc13eb67dcee97@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 18 Jun 2021 12:13:16 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP1aY5Mm14GDA_qPK7+7Jri2xAMZ3fYiVrhur7N5EO0mQ@mail.gmail.com>
Message-ID: <CA+ASDXP1aY5Mm14GDA_qPK7+7Jri2xAMZ3fYiVrhur7N5EO0mQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/19] rtw89: add pci files
To:     Pkshih <pkshih@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 On Wed, Jun 16, 2021 at 1:31 AM Pkshih <pkshih@realtek.com> wrote:
> > -----Original Message-----
> > From: Brian Norris [mailto:briannorris@chromium.org]

> > On Thu, Apr 29, 2021 at 04:01:39PM +0800, Ping-Ke Shih wrote:
> > > --- /dev/null
> > > +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> > > +static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
> > > +{
> > > +   struct rtw89_dev *rtwdev = dev;
> > > +   struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
> > > +   u32 isrs[2];
> > > +   unsigned long flags;
> > > +   u32 unmask0_rx = 0;
> > > +
> > > +   isrs[0] = rtwpci->isrs[0];
> > > +   isrs[1] = rtwpci->isrs[1];

By the way, I'm pretty sure you need to hold the irq_lock to safely read these.

...

> By your suggestions, I trace the flow and picture them below:

Nice, thanks for that!

> But, three exceptions
> 1. interrupt is still triggered, even we disable interrupt by step 1).
>    That means int_handler is executed again, but threadfn doesn't enable
>    interrupt yet.

I think maybe that's what IRQF_ONESHOT is for? Do you need to use
that? But it might not be a complete solution.

>    This is because interrupt event is on the way to host (I think the path is
>    long -- from WiFi MAC to PCI MAC to PCI bus to host).
>    There's race condition between disable interrupt and interrupt event.
>
>    I don't plan to fix the race condition, but make the driver handle it properly.
>
> 2. napi_poll doesn't start immediately at the step 7).
>    I don't trace the reason yet, but I think it's reasonable that
>    int_threadfn and napi_poll can be ansynchronous.
>    Because napi_poll can run in threaded mode as well.
>
> 3. Since int_threadfn and napi_poll are ansynchronous (similar to exception 2),
>    it looks like napi_poll is done before int_threadfn in some situations.
>
> I'll make the driver handle these cases in next submission (v6).

ACK.

> Another thing is I need to do local_bh_disable() before calling napi_schedule(),
> or kernel warns " NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"
> I think this is because __napi_schedule() does local_irq_save(), not very sure.
>
> I investigate other drivers that use napi_schedule() also do local_bh_disable()
> before calling napi_schedule(), or do spin_lock_bh(), or in bh context. I think
> these are equivalent.

OK. I'll admit I'm not that familiar with the locking and context
expectations of NAPI APIs (and, they are basically undocumented), but
that sounds OK. I was mostly concerned that you were trying to use
BH-disable as a mutual exclusion mechanism, when that's not really
what it does.

> > > +           spin_lock_irqsave(&rtwpci->irq_lock, flags);
> > > +           if (rtwpci->running) {
> > > +                   rtw89_pci_clear_intrs(rtwdev, rtwpci);
> >
> > Do you really want to clear interrupts here? I'm not that familiar with
> > the hardware here or anything, but that seems like a job for your ISR,
> > not the NAPI poll. It also seems like you might double-clear interrupts
> > without properly handling them, because you only called
> > rtw89_pci_recognize_intrs() in the ISR, not here.
>
> This chip is an edge-trigger interrupt, so originally I'd like to make "(IMR & ISR)"
> become 0, and then next RX packet can trigger the interrupt.

But I believe that's racy. If you clear an interrupt now based on
rtwpci->halt_c2h_isr and rtwpci->isrs[], and later reread those fields
in rtw89_pci_recognize_intrs(), clobbering any saved values, then you
may lose an interrupt, I think.

Overall, the state you're keeping around, and all the interactions
between your NAPI poll and your IRQ handler, are very complex and hard
to reason about. I believe your rtw88 driver has a much cleaner
interrupt dispatch logic -- it doesn't try to do smart things around
reading/writing the interrupt mask in 3 different places (IRQ handler,
threaded IRQ handler, and NAPI poll), but just read/stashes/clears the
mask in one place (threadfn) and avoids saving that state globally. I
think you might have better luck if you can imitate that. But again,
maybe I'm missing something.

Brian

> But, it seems that enable RX interrupt (step 9 of above picture) can already
> raise interrupt.
