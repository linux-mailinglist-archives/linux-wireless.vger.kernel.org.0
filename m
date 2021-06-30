Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B03B807A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jun 2021 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhF3J6w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Jun 2021 05:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhF3J6u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Jun 2021 05:58:50 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A881C06175F
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jun 2021 02:56:22 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id l26so1323574vsm.9
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jun 2021 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ts8enXSJd4RQbVA9M/oHspg3C49QBe2DnJohDedP0sk=;
        b=t2DR/Xb7mHuPrs6XcRXZlm34DrKyzrA82PJElLBgd8dnPIZs7FBkV2xsHpagupM8S4
         QLDK6bTp93NRtsW8EAbDwqU0UkcXn9mF33JtZf602QnMc7Hcdg2k1iAfnF0YD1RqLOOB
         g12620UdxZ8xwrkWWulbxGStuN4p4J2nlE+92Dc2fwMXIhN4U3yMUV89Q+bqBiuRkkuy
         78TuX5+5e9bU3yvLUkf1VVjrbl9c6gc0a9mRsV50CFjAFx/3T3HHvB0twB17GfbCusF4
         zuSQJSImR4I/wD6iEvKXYU86tj25pZ+HLWF/CgqumbhUIWGU7tetjwhihTAxiBj9pBlZ
         sT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ts8enXSJd4RQbVA9M/oHspg3C49QBe2DnJohDedP0sk=;
        b=JaypBoruzoQyTfsMgQAGsbBBFuFdLq6AzEHMTJsFaImPMogn1j8f6/0DQ7R4scSTrj
         lYieeZmcGpdHQaLyUBo4Lr4EXJjI+1Dd+Km2tvhGo0bLt07U2JtPiSugAOOm1K+VG1T0
         cXuQWO8hw1bbuujEpUNHBYw7ZaQqxkzU/qO1FZToL0GOjIi84HDxnqE+7evDFeGuUaiv
         924KHpYxqeOz7m+GwqLoXrcrrc2945dVoho5yrhKw0oZtKX+gP10d9/tDln3QG01i4dF
         ZV/mlzS8VDkOkbQ3JWsiXUbBi3O5ihMMNQUNhSp19ZfetFYeNVltDdSh9vum7oiV1+nN
         R8SQ==
X-Gm-Message-State: AOAM530AlDVSWANSBG9QBd4G+LRiQeEyJlKJB6+KtFHBKbg/jNRiQhM2
        8DzLmFJSKQNHvzl234eW5zv/yi85+2gDPrqtgNf55g==
X-Google-Smtp-Source: ABdhPJzw/CFh9AbMDUpi48SRcKoWG5JfdfkHMjM9Dh3T95RsUm1uYFGp6UyZfdHQZPrwO/qCYZd4VIjzl28entH3rxw=
X-Received: by 2002:a05:6102:502:: with SMTP id l2mr29859307vsa.19.1625046981225;
 Wed, 30 Jun 2021 02:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210622202345.795578-1-jernej.skrabec@gmail.com> <CAK8P3a1mvRTTFHtxqREmcbgJS+e94BHajCtAU_fzBhNNKjJBcg@mail.gmail.com>
In-Reply-To: <CAK8P3a1mvRTTFHtxqREmcbgJS+e94BHajCtAU_fzBhNNKjJBcg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jun 2021 11:55:45 +0200
Message-ID: <CAPDyKFqFTCzXFMar88CYdZKc=eMjKszsOCS1LwLmnF0uNQyPAw@mail.gmail.com>
Subject: Re: [RFC PATCH] cw1200: use kmalloc() allocation instead of stack
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>, pizza@shaftnet.org,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 22 Jun 2021 at 22:33, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jun 22, 2021 at 10:24 PM Jernej Skrabec
> <jernej.skrabec@gmail.com> wrote:
> >
> > It turns out that if CONFIG_VMAP_STACK is enabled and src or dst is
> > memory allocated on stack, SDIO operations fail due to invalid memory
> > address conversion:
>
> Thank you for sending this!
>
> It's worth pointing out that even without CONFIG_VMAP_STACK, using
> dma_map_sg() on a stack variable is broken, though it will appear to
> work most of the time but rarely cause a stack data corruption when
> the cache management goes wrong.
>
> This clearly needs to be fixed somewhere, if not with your patch, then
> a similar one.
>
> > diff --git a/drivers/net/wireless/st/cw1200/hwio.c b/drivers/net/wireless/st/cw1200/hwio.c
> > index 3ba462de8e91..5521cb7f2233 100644
> > --- a/drivers/net/wireless/st/cw1200/hwio.c
> > +++ b/drivers/net/wireless/st/cw1200/hwio.c
> > @@ -66,33 +66,65 @@ static int __cw1200_reg_write(struct cw1200_common *priv, u16 addr,
> >  static inline int __cw1200_reg_read_32(struct cw1200_common *priv,
> >                                         u16 addr, u32 *val)
> >  {
> > -       __le32 tmp;
> > -       int i = __cw1200_reg_read(priv, addr, &tmp, sizeof(tmp), 0);
> > -       *val = le32_to_cpu(tmp);
> > +       __le32 *tmp;
> > +       int i;
> > +
> > +       tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
> > +       if (!tmp)
> > +               return -ENOMEM;
> > +
> > +       i = __cw1200_reg_read(priv, addr, tmp, sizeof(*tmp), 0);
> > +       *val = le32_to_cpu(*tmp);
> > +       kfree(tmp);
> >         return i;
> >  }
>
> There is a possible problem here when the function gets called from
> atomic context, so it might need to use GFP_ATOMIC instead of
> GFP_KERNEL. If it's never called from atomic context, then this patch
> looks correct to me.

I would be surprised if this is called from atomic context (when IRQs
are turned off), because in most cases, to complete the read/write
request the mmc controller driver relies on IRQs being delivered.

>
> The alternative would be to add a bounce buffer check based on
> is_vmalloc_or_module_addr() in sdio_io_rw_ext_helper(), which would
> add a small bit of complexity there but solve the problem for
> all drivers at once. In this case, it would probably have to use
> GFP_ATOMIC regardless of whether __cw1200_reg_read_32()
> is allowed to sleep, since other callers might not.

I like the idea, but...

I don't think we should see this as an alternative, but rather as a
complement which would have performance issues. A warning should be
printed, if the buffer isn't properly allocated.

Additionally, I don't think GFT_ATOMIC should be needed.

Kind regards
Uffe
