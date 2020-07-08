Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3EF219426
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2020 01:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgGHXOm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jul 2020 19:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGHXOd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jul 2020 19:14:33 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68854C061A0B
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2020 16:14:33 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id e10so20374vkm.10
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2020 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mw2PmlJzHWQhRNNd30hc3xruqPMvRejs+H96jtSFf2Q=;
        b=kk8nuYBif+rgHaNw9hL1gR1Vae1V/jQHGwONLe1TxyhDzjPnEdAojzripI9lqKlDuJ
         nTWZC3Qj9n0Xx2pPKxQNMVMV0PknVfApA/VUmZeUgCwCiBWmowJYRlxLp8Z4gxW63v6H
         iJjlAIYvbg2zTxdoC11Y3otPA3qowTJKaiojc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mw2PmlJzHWQhRNNd30hc3xruqPMvRejs+H96jtSFf2Q=;
        b=o5JOO8u4L2syXmMuh2sai8zE+Vq53kbEVzFqD/TxSa5De05ivPgO3ApYjPpFHvCG5h
         CS+NkXseneCpLm1p8+SmIqW2jEvhiTlBgkAyq0XLZvG3cbRuyAj8PQVuhf+bh0W+L6Sh
         hu2wfqsXHzX/aEbrrxVwvnealnYQni1CkO0dV97iy4P7906GtcWWB5dLEl/1UlvMBMVB
         HQLNcnNfqvc6q0JNPex5uxhUNXqfJZ8yH0q8htE+fNAON891W95s5KICGxmuggGCTL7u
         UJHhi0kyN78MH9ipoHQZy6/EE3ZwKBH8JYVdUXBfeOIGEpXmwfY6o9O/WoU2x9C2Eus/
         Ei5w==
X-Gm-Message-State: AOAM533leC1RLmqx4hM3Sker9ZoGRR15cJFD+hoGGXBrPZ229QyNKpvt
        lxj/ofNyz6/Nq9Lp2HPm/6J4OsnDkWc=
X-Google-Smtp-Source: ABdhPJxQWGHIKIxKcRFkQ+Du1h7SbZX/vq1w9222w5RphWmLgu8alQHeBPpyW6pDF7wIN2xlo3HE/A==
X-Received: by 2002:a1f:ae51:: with SMTP id x78mr42407640vke.49.1594250071914;
        Wed, 08 Jul 2020 16:14:31 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id e16sm141872vso.34.2020.07.08.16.14.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 16:14:31 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id l12so132064uak.7
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2020 16:14:30 -0700 (PDT)
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr48881584uav.0.1594250070318;
 Wed, 08 Jul 2020 16:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200707101712.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
 <CA+ASDXMXtwdV4BNL1GSj8DY-3z8-dZ=1hP8Xv_R-AjKvJs0NMw@mail.gmail.com>
In-Reply-To: <CA+ASDXMXtwdV4BNL1GSj8DY-3z8-dZ=1hP8Xv_R-AjKvJs0NMw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jul 2020 16:14:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WU2dUFtG4W6o574DRN9VV+u_B5-ThqV3BogjztBibyLQ@mail.gmail.com>
Message-ID: <CAD=FV=WU2dUFtG4W6o574DRN9VV+u_B5-ThqV3BogjztBibyLQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Keep track of which interrupts fired, don't poll them
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Abhishek Kumar <kuabhs@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Wed, Jul 8, 2020 at 4:03 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Tue, Jul 7, 2020 at 10:18 AM Douglas Anderson <dianders@chromium.org> wrote:
> > diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
> > index a440aaf74aa4..666ce384a1d8 100644
> > --- a/drivers/net/wireless/ath/ath10k/ce.h
> > +++ b/drivers/net/wireless/ath/ath10k/ce.h
> ...
> > @@ -376,12 +377,9 @@ static inline u32 ath10k_ce_interrupt_summary(struct ath10k *ar)
> >  {
> >         struct ath10k_ce *ce = ath10k_ce_priv(ar);
> >
> > -       if (!ar->hw_params.per_ce_irq)
>
> If I'm reading correctly, you're removing the only remaining use of
> 'per_ce_irq'. Should we kill the field entirely?

Ah, you are indeed correct!  I hadn't noticed that.  Unless I hear
otherwise, I'll send a v2 tomorrow that removes the field entirely.


> Or perhaps we should
> leave some kind of WARN_ON() (BUG_ON()?) if this function is called
> erroneously with per_ce_irq==true? But I suppose this driver is full
> of landmines if the CE API is used incorrectly.

Yeah, I originally had a WARN_ON() here and then took it out because
it seemed like extra overhead and, as you said, someone writing the
code has to know how the API works already I think.  ...but I'll add
it back in if people want.


> > -               return CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_GET(
> > -                       ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
> > -                       CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
> > -       else
> > -               return ath10k_ce_gen_interrupt_summary(ar);
> > +       return CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_GET(
> > +               ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
> > +               CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
> >  }
> >
> >  /* Host software's Copy Engine configuration. */
>
> > diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
> > index a3dd06f6ac62..5095d1893681 100644
> > --- a/drivers/net/wireless/ath/ath10k/snoc.h
> > +++ b/drivers/net/wireless/ath/ath10k/snoc.h
> > @@ -78,6 +78,7 @@ struct ath10k_snoc {
> >         unsigned long flags;
> >         bool xo_cal_supported;
> >         u32 xo_cal_data;
> > +       DECLARE_BITMAP(pending_ce_irqs, CE_COUNT_MAX);
>
> Do you need to clear this map if the interface goes down or if there's
> a firmware crash? Right now, I don't think there's a guarantee that
> we'll run through a NAPI poll in those cases, which is the only place
> you clear the map, and if the hardware/firmware has been reset, the
> state map is probably not valid.

Seems like a good idea.  Is the right place at the start of
ath10k_snoc_hif_start()?


> Otherwise, looks OK to me:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks for the review!

-Doug
