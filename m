Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8954E7B69
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiCYU5G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiCYU5F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 16:57:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65CC366B7
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 13:55:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a8so17585134ejc.8
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTyIfzc6eWn8tPRbJvu4pItLGCLIkdX7GJakm9zDrl8=;
        b=gm5AHFVvThRrK7sA/BQ6fJ/iDwpQq6O0/7tOPWKWfF0gNOKqop2SvIcH4r/OClE48L
         VFW0eVhGjvjiyVqrrrPg6Q1OkP1qou04a5ugVipBYO9VTlVyEcQ7kokZzVjAoN7pS1Ch
         +u+3DjL5YncJtUcCyN3Ju5WCdBaFHsUNObffo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTyIfzc6eWn8tPRbJvu4pItLGCLIkdX7GJakm9zDrl8=;
        b=YNeX1Ul/84LKpMQxiu4S3a5gKQvGypcp+gy3xzxz/qmJLjHj7KzqwAqGne7GNjYNl5
         gDa1izoT7EYXzG/A/+RBN/6Bre8bvIgntmP027i4ApvQcgAJRj91NoIMKkCJPtr2Hn6L
         g0jbhW62+sB1ExQiLiUXhBXgD9tgQRJKrsy2N5omn9DWib2Ei5fAHddDzj0QEYyBwOkV
         Ls5Gei2p9TVTqIub+EsZnx5GROM9V+V2SilzTWi0JXZjjVh5He1VZCrFr72VPjBv1qys
         UYUGnnqcKhfjElnJFwE6/94tbwb3C7PNszmffFvg1kVrTYN0kY2xYL3R/ShVEfZyNGKx
         RcZQ==
X-Gm-Message-State: AOAM533MBxfL82e1qNRvn+pUic/7Vlh5Cr6WulAcF2QqzIr1DnkhQbfh
        FDga4HScKCATHafQM8A2w9tjzpjwFIl86pHvU1M=
X-Google-Smtp-Source: ABdhPJyYoXMGkAuY3MHVyrHwSKCZ65+TvXFHSjA4YRaoW4SkiXCwrk49JlNWkYzSteNtvnyueWJj/A==
X-Received: by 2002:a17:907:a40e:b0:6e0:5c84:9ced with SMTP id sg14-20020a170907a40e00b006e05c849cedmr5122250ejc.284.1648241728886;
        Fri, 25 Mar 2022 13:55:28 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm2726492ejc.64.2022.03.25.13.55.28
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 13:55:28 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id b19so12333578wrh.11
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 13:55:28 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr9094484lfh.687.1648241278691; Fri, 25
 Mar 2022 13:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk> <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com> <298f4f9ccad7c3308d3a1fd8b4b4740571305204.camel@sipsolutions.net>
In-Reply-To: <298f4f9ccad7c3308d3a1fd8b4b4740571305204.camel@sipsolutions.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 13:47:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXAan2ExANMryPSFaBWeyzikPi+fPUseMoVhQAxR7cEA@mail.gmail.com>
Message-ID: <CAHk-=whXAan2ExANMryPSFaBWeyzikPi+fPUseMoVhQAxR7cEA@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Maxime Bizon <mbizon@freebox.fr>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Halil Pasic <pasic@linux.ibm.com>,
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

On Fri, Mar 25, 2022 at 1:38 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> >  (2) The CPU now wants to see any state written by the device since
> > the last sync
> >
> >     This is "dma_sync_single_for_cpu(DMA_FROM_DEVICE)".
> >
> >     A bounce-buffer implementation needs to copy *from* the bounce buffer.
> >
> >     A cache-coherent implementation needs to do nothing.
> >
> >     A non-coherent implementation maybe needs to do nothing (ie it
> > assumes that previous ops have flushed the cache, and just accessing
> > the data will bring the rigth thing back into it). Or it could just
> > flush the cache.
>
> Doesn't that just need to *invalidate* the cache, rather than *flush*
> it?

Yes.  I should have been more careful.

That said, I think "invalidate without writeback" is a really
dangerous operation (it can generate some *really* hard to debug
memory state), so on the whole I think you should always strive to
just do "flush-and-invalidate".

If the core has support for "invalidate clean cache lines only", then
that's possibly a good alternative.

> >   A non-coherent implementation needs to flush the cache again, bot
> > not necessarily do a writeback-flush if there is some cheaper form
> > (assuming it does nothing in the "CPU now wants to see any state" case
> > because it depends on the data not having been in the caches)
>
> And similarly here, it would seem that the implementation can't _flush_
> the cache as the device might be writing concurrently (which it does in
> fact do in the ath9k case), but it must invalidate the cache?

Right, again, when I said "flush" I really should have said "invalidate".

> I'm not sure about the (2) case, but here it seems fairly clear cut that
> if you have a cache, don't expect the CPU to write to the buffer (as
> evidenced by DMA_FROM_DEVICE), you wouldn't want to write out the cache
> to DRAM?

See above: I'd *really* want to avoid a pure "invalidate cacheline"
model. The amount of debug issues that can cause is not worth it.

So please flush-and-invalidate, or invalidate-non-dirty, but not just
"invalidate".

> Then, however, we need to define what happens if you pass
> DMA_BIDIRECTIONAL to the sync_for_cpu() and sync_for_device() functions,
> which adds two more cases? Or maybe we eventually just think that's not
> valid at all, since you have to specify how you're (currently?) using
> the buffer, which can't be DMA_BIDIRECTIONAL?

Ugh. Do we actually have cases that do it? That sounds really odd for
a "sync" operation. It sounds very reasonable for _allocating_ DMA,
but for syncing I'm left scratching my head what the semantics would
be.

But yes, if we do and people come up with semantics for it, those
semantics should be clearly documented.

And if we don't - or people can't come up with semantics for it - we
should actively warn about it and not have some code that does odd
things that we don't know what they mean.

But it sounds like you agree with my analysis, just not with some of
my bad/incorrect word choices.

            Linus
