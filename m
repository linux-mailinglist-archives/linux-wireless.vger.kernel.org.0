Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDFA4E85F0
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Mar 2022 07:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiC0FaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Mar 2022 01:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiC0FaY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Mar 2022 01:30:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD7340A39
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 22:28:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k21so19721694lfe.4
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AIrmmPfx/ZOrHBctYZwCCwGfAaK/1/IH4psZd3wsUE=;
        b=djCcgOaCULO1J4pux52MUZuwiPblxKGguZJ9FLwYib2dSNo188P6jyJlcS/Z3+Vjqp
         NuxHz+nULM3zYzdCDc/LCticaRTrzP6Eu8i5lYrUz9D+Qn4hFWHokDkpiq4ZgcyhM3fv
         2VMFEP6rvt3FcDITehwTGDWmAXZRTRWN+Beak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AIrmmPfx/ZOrHBctYZwCCwGfAaK/1/IH4psZd3wsUE=;
        b=VP7+79Xc+jZ06zCbfDI6ygnVemPsmDqDycaSODAusryjftN/KZlrwSRr72cBzeA3Qp
         LwwPSxZ8MXY/dLcasD6ZbH6c1JGviVrn+QyFl+2euCNazadjh/vonoI3T8nI3SHoGsRr
         mXBcFE6jP3sZEwdUGXBfO7fMzfuHFqind3uz9xkxkAJHqZN09JV3azMgEGvL7E2U+v2o
         8ZIOiFGqlBbbDpaAMA9KApIEa2g9rDVMkjsWHSwzNnVIz5CqmNGlSOSULVfWbyMfHA3Q
         8rToVtQkUpb41zY7UbWfSJd5j5vVO6BcY8I8AEQy/yagUc9VeQ92yW/IpX6NuGyAyryL
         /k8A==
X-Gm-Message-State: AOAM532r2Jzn8o05urC7U+jZNY8Hi9eupyqQWII4NYOTwSF1KO2Evv9j
        8qUQK2l3eymKP61fZj+W15cf2cSwCkcL8qCHuAc=
X-Google-Smtp-Source: ABdhPJw54dkOXgD99/24ZdX5UV4Muyacnn8eH0Z93fCmanfC7e8aDQAxgKjXH6AECPP585IN9QQLkg==
X-Received: by 2002:a05:6512:13a3:b0:44a:6ac3:754d with SMTP id p35-20020a05651213a300b0044a6ac3754dmr11086061lfa.92.1648358924036;
        Sat, 26 Mar 2022 22:28:44 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d21-20020a056512321500b0044a23434568sm1257594lfe.153.2022.03.26.22.28.43
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 22:28:43 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id u3so15225023ljd.0
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 22:28:43 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr14918936ljc.506.1648358479393; Sat, 26
 Mar 2022 22:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk> <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <20220327054848.1a545b12.pasic@linux.ibm.com> <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
In-Reply-To: <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 22:21:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUx5CVF_1aEkhhEiRGXHgKzUdKiyctBKcHAxkxPpbiaw@mail.gmail.com>
Message-ID: <CAHk-=wgUx5CVF_1aEkhhEiRGXHgKzUdKiyctBKcHAxkxPpbiaw@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Maxime Bizon <mbizon@freebox.fr>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Olha Cherevyk <olha.cherevyk@gmail.com>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 26, 2022 at 10:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Mar 26, 2022 at 8:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > I agree it CPU modified buffers *concurrently* with DMA can never work,
> > and I believe the ownership model was conceived to prevent this
> > situation.
>
> But that just means that the "ownership" model is garbage, and cannot
> handle this REAL LIFE situation.

Just to clarify: I obviously agree that the "both sides modify
concurrently" obviously cannot work with bounce buffers.

People still do want to do that, but they'll limit themselves to
actual cache-coherent DMA when they do so (or do nasty uncached
accesses but at least no bounce buffering).

But the "bounce ownership back and forth" model comes up empty when
the CPU wants to read while the DMA is still going on. And that not
only can work, but *has* worked.

You could have a new "get me a non-ownership copy" operation of
course, but that hits the problem of "which existing drivers need it?"

We have no idea, outside of ath9k.

This is why I believe we have to keep the existing semantics in a way
that keep ath9k - and any number of unknown other drivers - happy.

And then for the cases where you want to introduce the zeroing because
you don't know how much data the DMA returned - those are the ones
you'll have to mark some way.

                  Linus
