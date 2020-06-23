Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27ED205AAD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgFWS3w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 14:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbgFWS3t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 14:29:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D9C061796
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2020 11:29:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so1844150pjb.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2020 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXkDSAr5/uPdypFT+vPhb9QM0XECCw1QogkIjza9trI=;
        b=VRPOqKgXBbe1omCau4oEOar/p3bhX1hnmkDK5oo6kzWoboZd6SthW3HQ/fnF48E5Ad
         TFy6wVC1Zt0tVzcHOtTOw47hdeOauaMgmaZ6zltDMfNdLob+S/bzF8RmsABX4aqnrS72
         FqSw42FCWi78K/1FW37NBnAtRs40JSIujuQZ/C35kNhgObkKHAK+mu644bPs+DnywUvm
         fYYXdKXmrR/Epl78LsQPaZhh4kpgqCqvEbEKQBq3LNEoOjFO3Gb/VXUTw5HcjdoODVkn
         jAQBGKwdodjJ4m51Dq2h17KJmJpx4MvyUs2jS+Pi8XwYstLDwRvgem5B+kNI/TaA60cZ
         bdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXkDSAr5/uPdypFT+vPhb9QM0XECCw1QogkIjza9trI=;
        b=hAOS/2SaYtOtWtGfmlYUtvD1/nRFnJeNVRMGYdfUWjv0Gf7cg+0tJ5wBcf/dZIYTg7
         0ZeioHbA3fuwvL6EE1PqDL9GkOyCca0Tbo9bC2jIpYnr/gEd4BJkQrytO4bBBcsLqFDm
         Sa4gsu16n8EvZPOWflY8YmDGVc6B/xVhuto7XqEOuWNtIq7h8b6EltjMkwxzAFiUbZ+x
         ISBa4nLyOLyvxHJn+a9d9/P3MVKkNi3z8xRI1CK5UsgjZcWBf8pa5CKKaP+ZX3l1Sfmw
         taHU9HZq/FMirL7EyslUFFH0EsVByIfXAgE1DtZVy+aOSEqkNdwgZXeeGeNovZqcVU8Q
         edeA==
X-Gm-Message-State: AOAM530vd3KPlK7JHjBOEC0VWOIkJk6VggAElC0h6sSZuhUctuQjfkg2
        lM92jZNrt6/HYlmwMB7cgRreHcxPUBxpT8Ar7+Iw6g==
X-Google-Smtp-Source: ABdhPJwFYRuJg9EUbjSytVc+yfQjuDOMjwE4SVCIBy3rni20OvAXlm0XdI+2Z8txK6JARtyDXhDgAzhgcWbhIpdXKAY=
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr24842368plm.179.1592936988375;
 Tue, 23 Jun 2020 11:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200620033007.1444705-1-keescook@chromium.org>
 <20200620033007.1444705-5-keescook@chromium.org> <CAKwvOdmsXuqx-3Rt_KNFq4psAeFjG2-7qQaqkJ7dDqqmscUFNw@mail.gmail.com>
 <202006221403.EEAD37E94B@keescook>
In-Reply-To: <202006221403.EEAD37E94B@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jun 2020 11:29:38 -0700
Message-ID: <CAKwvOdmr0dmC7UtL9Qcgm9Ue_Q2mhKzYiHcXpaB=LpMKpYeYqA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] b43: Remove uninitialized_var() usage
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org,
        Network Development <netdev@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 22, 2020 at 2:04 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 22, 2020 at 10:04:18AM -0700, Nick Desaulniers wrote:
> > On Fri, Jun 19, 2020 at 8:30 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > > (or can in the future), and suppresses unrelated compiler warnings (e.g.
> > > "unused variable"). If the compiler thinks it is uninitialized, either
> > > simply initialize the variable or make compiler changes. As a precursor
> > > to removing[2] this[3] macro[4], just initialize this variable to NULL.
> > > No later NULL deref is possible due to the early returns outside of the
> > > (phy->rev >= 7 && phy->rev < 19) case, which explicitly tests for NULL.
> > >
> > > [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> > > [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> > > [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> > > [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> > >
> > > Fixes: 58619b14d106 ("b43: move under broadcom vendor directory")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > I see three total uses of uninitialized_var() in this file, do we want
> > to eliminate all of them?
>
> This is the only one that needed an explicit initialization -- all the
> others are handled in the treewide patch. I *could* split it out here,
> but I found it easier to keep the "no op" changes together in the
> treewide patch.

Ah, got it.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> -Kees
>
> >
> > > ---
> > >  drivers/net/wireless/broadcom/b43/phy_n.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
> > > index c33b4235839d..46db91846007 100644
> > > --- a/drivers/net/wireless/broadcom/b43/phy_n.c
> > > +++ b/drivers/net/wireless/broadcom/b43/phy_n.c
> > > @@ -4222,7 +4222,7 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
> > >         u32 rfpwr_offset;
> > >         u8 pga_gain, pad_gain;
> > >         int i;
> > > -       const s16 *uninitialized_var(rf_pwr_offset_table);
> > > +       const s16 *rf_pwr_offset_table = NULL;
> > >
> > >         table = b43_nphy_get_tx_gain_table(dev);
> > >         if (!table)
> > > --
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers
