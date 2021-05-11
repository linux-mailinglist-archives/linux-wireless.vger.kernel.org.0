Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD837A279
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhEKIto (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 04:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhEKIto (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 04:49:44 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFEAC061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 01:48:38 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 66so9812099vsk.9
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 01:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+OybVOZDjffV9fCxk6L7StkiAEN+2vDpamJv6n/cXQ=;
        b=YEw3177WZxZnAdlDc+pzXzwD6r4iIZjk/XFlRNuCv5A1n8xmP010LLb4xQkMNWjUc3
         BLd9Aa2u6lAkCJReuymYpcvMbCotOvCzz7tFMXlvtWHo+KyIoxLUBerduPEUUZsTbvEF
         7Pp0mH50SAyceyfXgVUWhQvcq+vudHJHdZL3cn1qCQufGd/8knLSJWSfm0eQ2Kfvqe+n
         FgH8QJrbRKsCZkmgRUSmH02B2Szv4T4tSSposmlu3HyQk93po91J8t4xQK/pXj+vtkM8
         w38Q1NSw4hMLYVvPg5pqKdrAq0tm/0U88uyvbunfCvYaEFXtn3sngU6mzI8qSOM+nDCH
         hWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+OybVOZDjffV9fCxk6L7StkiAEN+2vDpamJv6n/cXQ=;
        b=ojLTjCIsjmB81xespSBedGG2TMJAtHHisPBdSPV7SYvUec5k0P3b/P2VdA8XnxRtyw
         TVeEmUzL52UTVg+80MQG7DyO8HIQ52cQ/CBOL2nGfj0Zn8dJG7tsnABpZir5y4yB9S4R
         SH3FHvDoawSTvfLR97sJG6hHWYxsp4ueIDAXSo+tE+OqAh8YEycr0TkbsDJ0Zaxr+tV7
         pWcgUed8aGfTmNbFsiQZOEY8mkzLtbbENjQiKzhEPFY30NzWSjrdSJFWZaVG3lgdvuuM
         J+qGfkMbkTbULO9ZPcOOM09/NXYaCYApiY92y0YB3jF0t9Eh++5NGGAyd8069hEGXX4s
         WeDQ==
X-Gm-Message-State: AOAM532s9k/Oqc75eck1MbpGpw0xav4hgBlFbyRg6X7ayLPOxgb/Q36l
        9a+9ZQEUbw9KeT9ZORHoruiZx+R/w/0srkhrydvLvg==
X-Google-Smtp-Source: ABdhPJz/daDUyKRo8v+4rlpOBElnUxqML9fx1ysbvbpsXoLdmYoqtA8SaUYenO5opWEvoXPYc0ne0/f0wOXxzd0MPgg=
X-Received: by 2002:a05:6102:505:: with SMTP id l5mr20057935vsa.55.1620722917369;
 Tue, 11 May 2021 01:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210509224226.348127-1-linus.walleij@linaro.org>
 <c5370b69-eac2-815e-27cb-f865a7885830@broadcom.com> <CAPDyKFq6PEx9YNF5VDjEy2giLOe=NJPxM2KCAWOOQxeGR_3jMw@mail.gmail.com>
 <30a7bbeb-d588-4780-bd6c-d99f72898138@broadcom.com>
In-Reply-To: <30a7bbeb-d588-4780-bd6c-d99f72898138@broadcom.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 10:48:00 +0200
Message-ID: <CAPDyKFpiXWygrBBHzGXBU2dC3SuxC3Uj868BAgagbv8FMmyGeQ@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Obtain reset GPIO
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 10 May 2021 at 11:27, Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
>
>
> On 5/10/2021 11:14 AM, Ulf Hansson wrote:
> > On Mon, 10 May 2021 at 09:37, Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> + Uffe
> >>
> >> On 5/10/2021 12:42 AM, Linus Walleij wrote:
> >>> This grabs the reset GPIO and holds it de-asserted, if available.
> >>> Asserting this signal will make the SDIO card re-enumerate.
> >>
> >> looks ok to me, but could this also be done through SDIO power sequence
> >> stuff?
> >
> > Yes, it certainly looks like that to me. It should be the mmc
> > host/core that manages the power on/off thingy for the SDIO card.
>
> Thanks, Uffe
>
> This is not directly power on/off, but a separate "reset" GPIO. However,
> checking in pwrseq_simple.c I see:
>
> struct mmc_pwrseq_simple {
>         struct mmc_pwrseq pwrseq;
>         bool clk_enabled;
>         u32 post_power_on_delay_ms;
>         u32 power_off_delay_us;
>         struct clk *ext_clk;
>         struct gpio_descs *reset_gpios;
> };
>
> So the term 'reset_gpios' is also used in pwrseq context.

I think this boils down to that to allow the mmc core to detect and
initialize the SDIO card, it needs to manage potential reset pins as
well.

In cases when the SDIO func driver may need to execute a reset, the
mmc core provides two APIs, mmc_hw|sw_reset().

Does this make sense to you?

Kind regards
Uffe
