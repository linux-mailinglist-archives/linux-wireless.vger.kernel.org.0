Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004471F9A7A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgFOOjs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbgFOOjs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 10:39:48 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C263DC05BD43
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2020 07:39:47 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id w20so5762257uaa.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2020 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEeXvFEwQXQ2y1eWlGB8T8Xdt9cee0AQhh/eHPPAS7A=;
        b=IjXvDmBNK5eFh5/xjjshicx5i0C0eryt36PZLb6YWSCQUQbzhvG1iR7GQQNXMe6GMg
         QETkfdn5LSARucFRdaAqF9OtFB+jgMVp55JCfmlpdbnwKJXbddu6Vgm1rUVIPBOtV7nv
         jLtitgQgqLA7qf1vzt6Eys8MG767Vc5x0+oJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEeXvFEwQXQ2y1eWlGB8T8Xdt9cee0AQhh/eHPPAS7A=;
        b=lCqp2lE3uNUaPLNgVTt8etrxLSiDORVKA/kz7uOTwDYvLRAjSLuivNacUJeLZEowTY
         NM0RrN3IvmcdQ1EfAkn3zfnmglKjghG+BOuQhcQM+2cqiv1JMZFN1XJEBy3VUT/ompEB
         J72CgW0ggRVxOhzdin2f1nI9aIcE2FcfkJgVYDLUPoqW1qfHy44k0DTGzaPqDJMtbMoR
         vo5db6tDBXFbzx2yJMPugZucSzBk+439Kq9NEx2XNkCJKFe9ql5TzOSetk6tb03VWigi
         QWsjVN5v0M6IKbd7ZFSqWMC2lUrOSNHc+UQ5RK+D3aLEqe6H3bEXj8htateLRbrhcUx/
         5xEg==
X-Gm-Message-State: AOAM53374AiD9XyHuJUIEVllETDhLC91r+CMOgkgNGtPQhZPDDQO4M8z
        9wqM+VLWvFVR2KvLb2nGOwutHgK3QB4=
X-Google-Smtp-Source: ABdhPJzCoGQ9lNO/Bek/5CnJ4A7BjslTtys15WoAEfR9Rx3ETbbRubPW0/pgkcxWG0OMfuPWOWp9AA==
X-Received: by 2002:ab0:3145:: with SMTP id e5mr19159634uam.73.1592231986356;
        Mon, 15 Jun 2020 07:39:46 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id r128sm2279759vkf.48.2020.06.15.07.39.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:39:46 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id c1so9449908vsc.11
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2020 07:39:45 -0700 (PDT)
X-Received: by 2002:a67:1703:: with SMTP id 3mr20641752vsx.169.1592231985028;
 Mon, 15 Jun 2020 07:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200609082015.1.Ife398994e5a0a6830e4d4a16306ef36e0144e7ba@changeid>
 <20200615143237.519F3C433C8@smtp.codeaurora.org>
In-Reply-To: <20200615143237.519F3C433C8@smtp.codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Jun 2020 07:39:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaexjLaaZJSxndTEi6KCFaPWW=sUt6hjy9=0Qn68kH1g@mail.gmail.com>
Message-ID: <CAD=FV=VaexjLaaZJSxndTEi6KCFaPWW=sUt6hjy9=0Qn68kH1g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Wait until copy complete is actually done before completing
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     kuabhs@google.com, Rakesh Pillai <pillair@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Jun 15, 2020 at 7:32 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Douglas Anderson <dianders@chromium.org> wrote:
>
> > On wcn3990 we have "per_ce_irq = true".  That makes the
> > ath10k_ce_interrupt_summary() function always return 0xfff. The
> > ath10k_ce_per_engine_service_any() function will see this and think
> > that _all_ copy engines have an interrupt.  Without checking, the
> > ath10k_ce_per_engine_service() assumes that if it's called that the
> > "copy complete" (cc) interrupt fired.  This combination seems bad.
> >
> > Let's add a check to make sure that the "copy complete" interrupt
> > actually fired in ath10k_ce_per_engine_service().
> >
> > This might fix a hard-to-reproduce failure where it appears that the
> > copy complete handlers run before the copy is really complete.
> > Specifically a symptom was that we were seeing this on a Qualcomm
> > sc7180 board:
> >   arm-smmu 15000000.iommu: Unhandled context fault:
> >   fsr=0x402, iova=0x7fdd45780, fsynr=0x30003, cbfrsynra=0xc1, cb=10
> >
> > Even on platforms that don't have wcn3990 this still seems like it
> > would be a sane thing to do.  Specifically the current IRQ handler
> > comments indicate that there might be other misc interrupt sources
> > firing that need to be cleared.  If one of those sources was the one
> > that caused the IRQ handler to be called it would also be important to
> > double-check that the interrupt we cared about actually fired.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> ath10k firmwares work very differently, on what hardware and firmware did you
> test this? I'll add that information to the commit log.

I am running on a Qualcomm sc7180 SoC.

> --
> https://patchwork.kernel.org/patch/11595887/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>
