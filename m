Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F37A4E89F0
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Mar 2022 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiC0UG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Mar 2022 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbiC0UGy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Mar 2022 16:06:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9374FC42
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 13:05:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bt26so21473887lfb.3
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 13:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wob/7GSQVIpO7i1InQcutyEWYgbvdwTICG96D7RFBB8=;
        b=MBKpZ1UtrtPBVIHqjdSKYB/rkJWZ1f0vdHzhtdISyO5M6IfCasC0hYp5oS9+XwcX2g
         onX3toZbyl+fJ/Tk2m9EN2QoWGToeUma4YxombZeY5ZkW09xgeyTm/fWrkUSPf9q19W+
         djbSzf2EiLGwXDF9V4ce2XqsgWTUpumTDa/0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wob/7GSQVIpO7i1InQcutyEWYgbvdwTICG96D7RFBB8=;
        b=ssIpUuCv650WIDYs4rQMnFOdePXxTjA1BNYDWOMcIUgzEnJf1Qd7kUjc8Kdbl+jzk7
         +gganeAg+AkApUZFPnC/gkVunsmc38K2PP70+CS3I5ezsTv5hE2Twh2totLmf4HYFPdR
         S87HsCmuzu9JQrzsfHwuaZMnoWRBdjsMEp00pdikfDxgrhMpTDjMmn3DnwJHck3Yhum8
         2NxBav2QM9lrgPHpXjtJj1fEWM1DA9Eu1faxWe1TOJQXs+6dZjRvUJ3LPVDeXd2PXlwG
         QDD0Ld4WdBTwQS/XOaAGLUkjHyDJIasmfSrO2fKXRw5n2CFPBvxl7KiMJOz4DCqVhDWe
         5YVg==
X-Gm-Message-State: AOAM5333X9TN+7vXU0C/cykhNiSOUMsYZn0YW8gpe+O1FcKap0BMXRXF
        J0GCa0xDZObtiYWre/+7Re3qLdbCtM7Iowm/Jbg=
X-Google-Smtp-Source: ABdhPJy7WCOJdozRkjkGmFijIdiJu9u3F4tt49vKbXZq+Tdlly2M3HUcpJ9fJwdyBuQl+PMvRVysnA==
X-Received: by 2002:a05:6512:1295:b0:44a:27fd:cd00 with SMTP id u21-20020a056512129500b0044a27fdcd00mr16272718lfs.196.1648411513429;
        Sun, 27 Mar 2022 13:05:13 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z17-20020a19e211000000b0044a1348fc87sm1447194lfg.43.2022.03.27.13.05.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 13:05:12 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id s25so16645380lji.5
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 13:05:10 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr16821393lji.152.1648411509868; Sun, 27
 Mar 2022 13:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk> <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <20220327054848.1a545b12.pasic@linux.ibm.com> <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
 <CAHk-=wgUx5CVF_1aEkhhEiRGXHgKzUdKiyctBKcHAxkxPpbiaw@mail.gmail.com>
 <0745b44456d44d1e9fc364e5a3780d9a@AcuMS.aculab.com> <CAHk-=wgLyqNJx=bb8=o0Nk5U8gMnf0-=qx53ShLEb3V=Yrt8fw@mail.gmail.com>
In-Reply-To: <CAHk-=wgLyqNJx=bb8=o0Nk5U8gMnf0-=qx53ShLEb3V=Yrt8fw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 13:04:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+TzZhMCiPPnchC4FSeS53-QCN3RYqxLAh4ahKMLoj9A@mail.gmail.com>
Message-ID: <CAHk-=wh+TzZhMCiPPnchC4FSeS53-QCN3RYqxLAh4ahKMLoj9A@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     David Laight <David.Laight@aculab.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
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

On Sun, Mar 27, 2022 at 12:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I will propose that we really make it very much about practical
> concerns, and we document things as
>
>  (a) the "sync" operation has by definition a "whose _future_ access
> do we sync for" notion.
>
>      So "dma_sync_single_for_cpu()" says that the future accesses to
> this dma area is for the CPU.
>
>      Note how it does *NOT* say that the "CPU owns the are". That's
> bullsh*t, and we now know it's BS.
>
>  (b) but the sync operation also has a "who wrote the data we're syncing"
>
>      Note that this is *not* "who accessed or owned it last", because
> that's nonsensical: if we're syncing for the CPU, then the only reason
> to do so is because we expect that the last access was by the device,
> so specifying that separately would just be redundant and stupid.
>
>      But specifying who *wrote* to the area is meaningful and matters.

We could also simply require that the bounce buffer code *remember*
who wrote to it last.

So when the ath9k driver does

 - setup:

                bf->bf_buf_addr = dma_map_single(sc->dev, skb->data,
                                                 common->rx_bufsize,
                                                 DMA_FROM_DEVICE);

we clear the bounce buffer and remember that the state of the bounce
buffer is "device wrote to it" (because DMA_FROM_DEVICE).

Then, we have an interrupt or other event, and ath9k does

 - rc event:

        dma_sync_single_for_cpu(sc->dev, bf->bf_buf_addr,
                                common->rx_bufsize, DMA_FROM_DEVICE);

        ret = ath9k_hw_process_rxdesc_edma(ah, rs, skb->data);
        if (ret == -EINPROGRESS) {
                /*let device gain the buffer again*/
                dma_sync_single_for_device(sc->dev, bf->bf_buf_addr,
                                common->rx_bufsize, DMA_FROM_DEVICE);
                return false;
        }

and the first dma_sync_single_for_cpu() now sees "Ok, I want the CPU
buffer, and I remember that the device wrote to it, so I will copy
from the bounce buffer". It's still DMA_FROM_DEVICE, so that "the
device wrote to it" doesn't change.

When the CPU then decides "ok, that wasn't it", and does that
dma_sync_single_for_device(), the bounce buffer code goes "Ok, the
last operation was that the device wrote to the buffer, so the bounce
buffer is still valid and I should do nothing".

Voila, no ath9k breakage, and it all still makes perfect sense.

And that sounds like an even more logical model than the one where we
tell the bounce buffer code what the previous operation was, but it
involves basically the DMA mapping code remembering what the last
direction was. That makes perfect sense to me, but it's certainly not
what the DMA mapping code has traditionally done, which makes me
nervous that it would just expose a _lot_ of other drivers that do odd
things.

The "good news" (if there is such a thing) is that usually the
direction doesn't actually change. So if you use DMA_FROM_DEVICE
initially, you'll continue to use that. So there is probably basically
never any difference between "what was the previous operation" and
"what is the next operation".

So maybe practically speaking, we don't care.

Anyway, I do think we have choices here on how to describe things.

I do think that the "DMA code doesn't have to remember" model has the
advantage that remembering is always an added complexity, and
operations that behave differently depending on previous history are
always a bit harder to think about because of that. Which is why I
think that model I outlined in the previous email is probably the most
straightforward one.

                 Linus
