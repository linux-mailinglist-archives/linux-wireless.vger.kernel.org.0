Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1EF21A38C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2020 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgGIPXG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jul 2020 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgGIPWq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jul 2020 11:22:46 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF677C08C5CE
        for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2020 08:22:46 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a17so1308927vsq.6
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2020 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlZV7q7oZfSsF7eZZwKOePXY88Q+axAbOXXuZcZlzCE=;
        b=hFbUxwkrUwczQtSXAxGKo0vdW2IUs0zf+zn25GxqMjc0mhWqQV+rAOaMJe31oBUkHg
         INzNLPLLe84Ksm2T8pEVrgP0fnOOez1gR9Gu3nmGD7M+NY4J9FPg2GOXGNRn2sdyUxcS
         gsU9lHLptI9Vtt2KL+FJDwLrLfmocJwZmDVfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlZV7q7oZfSsF7eZZwKOePXY88Q+axAbOXXuZcZlzCE=;
        b=ng3vir6hcXU25tFLk9DAXxqfECffmG454pciq2NlBr8tbrYBHSO6NBT1aUnyNWjGj6
         8CEhJieIBaLMDZhGkVmp8voVo7IM2ZFSAGbZmhT7E8IZ846fJ1pC3XL1K8MV9La/KPtw
         CfQv8viSqnMj/YYyC82FJNepGfXKYXPsbxhGdig2LoYk0slV5C5q5/UQ+UWx5XXxaXjN
         GMKtrLu9X33zNFJ94C0I0xFEAVgCVi9OlnVbFAYZyBgU13TYwrbGceb1vJ6PoiFhQDsV
         yuIXYifomP4QPRGaEkIWj+Y7fpRnMbyV0RBYDKhVnByH5hDOoeLazuuJeXqF6AOK75Nf
         5+xw==
X-Gm-Message-State: AOAM530P9a2Mqx5zv5Gc0ZIwCigUUa2UNpN/TmYSEiZvhIEe7pMhcd8K
        3yfdx53oEzb+9hmg/pAF6487udu7u/k=
X-Google-Smtp-Source: ABdhPJwhFuR62yYpCIrE5EYpvKzBdpjSDDYJ1i4zbtRwzyysjS0rzYEQTCBhNeWRA7zrhz/CZPcd8g==
X-Received: by 2002:a67:fa5a:: with SMTP id j26mr9044030vsq.95.1594308165381;
        Thu, 09 Jul 2020 08:22:45 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id v129sm458315vkb.17.2020.07.09.08.22.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:22:43 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id h1so518108vkn.12
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2020 08:22:42 -0700 (PDT)
X-Received: by 2002:a1f:61c2:: with SMTP id v185mr16966422vkb.42.1594308161819;
 Thu, 09 Jul 2020 08:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200707101712.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
 <CA+ASDXMXtwdV4BNL1GSj8DY-3z8-dZ=1hP8Xv_R-AjKvJs0NMw@mail.gmail.com>
 <CAD=FV=WU2dUFtG4W6o574DRN9VV+u_B5-ThqV3BogjztBibyLQ@mail.gmail.com> <CA+ASDXOwFnCcMC9g11FSVLvj2nepArJyihGvx3SU-XqySoJruw@mail.gmail.com>
In-Reply-To: <CA+ASDXOwFnCcMC9g11FSVLvj2nepArJyihGvx3SU-XqySoJruw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Jul 2020 08:22:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUpHGoLm+NG-_eGsVKO7X+SLObFCoQVBSCNEa6KRmpmA@mail.gmail.com>
Message-ID: <CAD=FV=WUpHGoLm+NG-_eGsVKO7X+SLObFCoQVBSCNEa6KRmpmA@mail.gmail.com>
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

On Wed, Jul 8, 2020 at 4:40 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Jul 8, 2020 at 4:14 PM Doug Anderson <dianders@chromium.org> wrote:
> > On Wed, Jul 8, 2020 at 4:03 PM Brian Norris <briannorris@chromium.org> wrote:
> > > If I'm reading correctly, you're removing the only remaining use of
> > > 'per_ce_irq'. Should we kill the field entirely?
> >
> > Ah, you are indeed correct!  I hadn't noticed that.  Unless I hear
> > otherwise, I'll send a v2 tomorrow that removes the field entirely.
>
> A healthy middle ground might put that in a patch 2, so it's easily
> dropped if desired. *shrug*

Sure, sounds like a plan.


> > > Or perhaps we should
> > > leave some kind of WARN_ON() (BUG_ON()?) if this function is called
> > > erroneously with per_ce_irq==true? But I suppose this driver is full
> > > of landmines if the CE API is used incorrectly.
> >
> > Yeah, I originally had a WARN_ON() here and then took it out because
> > it seemed like extra overhead and, as you said, someone writing the
> > code has to know how the API works already I think.  ...but I'll add
> > it back in if people want.
>
> I believe WARN_ON() and friends have a built-in unlikely(), so it
> shouldn't have much overhead. But I don't really mind either way.

Since you don't feel strongly, leaving it off.


> > > Do you need to clear this map if the interface goes down or if there's
> > > a firmware crash? Right now, I don't think there's a guarantee that
> > > we'll run through a NAPI poll in those cases, which is the only place
> > > you clear the map, and if the hardware/firmware has been reset, the
> > > state map is probably not valid.
> >
> > Seems like a good idea.  Is the right place at the start of
> > ath10k_snoc_hif_start()?
>
> Either there or in .power_down()/.power_up(). I think either would be
> equally correct, but I'm not entirely sure if the semantic difference
> is meaningful for this.

Will choose ath10k_snoc_hif_start() since it's where napi_enable() is
and ath10k_snoc_irq_enable() are and those are related.


-Doug
