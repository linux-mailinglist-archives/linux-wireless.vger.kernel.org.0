Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB164E85D8
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Mar 2022 07:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiC0FIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Mar 2022 01:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiC0FIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Mar 2022 01:08:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB44193D7
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 22:06:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t25so19671315lfg.7
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 22:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4DsawngOkTaf1ffe3Djt9i8R04p2xlEj2LaUyWMHpLQ=;
        b=IL1j88A1zMmNQ619gkjkOLfevd4yJp/uUvy/JL+W394T7Ci9byh8r//w+swnF4uoTk
         MZxgdJEbG5E8/y/0RfpNKMtcmR1SxV+ftoqfImF3PZxALDLZgAsd0IabrARdiKS285Pw
         iUyVNk8ywuM4lUwh7TQ+LKc1DK3c/TGkrq11k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DsawngOkTaf1ffe3Djt9i8R04p2xlEj2LaUyWMHpLQ=;
        b=Kg5skmQRLztZr7AX7O0sjTiq4YY+8cC0oGbrfIc2qZe+/+3s6Oe9aNsG593irSOHXO
         pHwgEjqdl2ZsbjfpwWIzEqixUwk4YCuI1ZLgfPSIFr3pacCi5c4FYnEczSJAG9xC+nMi
         TvxiV8sz5uDqTZmzbtdCgtbE685rEufSR58psQRzu0x17IVC/mzMAZl/QMZQ72kGBiCC
         tRHHJNa/FS+Ekjy2lkdv57E/4p7WGx9nfoLanxZe1A+23qGfiDku8NC47fo804nQiE7J
         JS32zNJmEfJR7UaPKemjsVPoXiTn3aI/SiGRijVyQNS/fCzb9EVO4rv/IxFErx43SA4+
         EWWw==
X-Gm-Message-State: AOAM531O/kOlRIUnNccwQ9WOvy+qvCh7rQdI52FKJz2JPf7hFh/6BEjj
        RP/s4Mk+mTzVkwtJdUOMyixUHKp+J95/JDst3FU=
X-Google-Smtp-Source: ABdhPJzwCIq8Y5yqGyVRS+nW3TkaBcDZffbW3ePw0+VMaz/ZDjZxHZe8qI/MCDAF2TIwcS32DfO01Q==
X-Received: by 2002:a05:6512:3a93:b0:44a:a77:e969 with SMTP id q19-20020a0565123a9300b0044a0a77e969mr14787955lfu.259.1648357594681;
        Sat, 26 Mar 2022 22:06:34 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g3-20020a05651222c300b0044a378930b0sm1252310lfu.8.2022.03.26.22.06.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 22:06:33 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id bt26so19667255lfb.3
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 22:06:32 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr14244664lfh.687.1648357591941; Sat, 26
 Mar 2022 22:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk> <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <20220327054848.1a545b12.pasic@linux.ibm.com>
In-Reply-To: <20220327054848.1a545b12.pasic@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 22:06:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
Message-ID: <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
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

On Sat, Mar 26, 2022 at 8:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> I agree it CPU modified buffers *concurrently* with DMA can never work,
> and I believe the ownership model was conceived to prevent this
> situation.

But that just means that the "ownership" model is garbage, and cannot
handle this REAL LIFE situation.

Here's the deal: if somebody makes a model that is counter-factual,
you have exactly two choices:

 - fix the damn model

 - live in a la-la-land that isn't reality

Which choice do you pick?

And I'll be brutally honest: if you pick the la-la-land one, I don't
think we can really discuss this any more.

> But a CPU can modify the buffer *after* DMA has written to
> it, while the mapping is still alive.

Yes.

But you are making ALL your arguments based on that "ownership" model
that we now know is garbage.

If you make your arguments based on garbage, the end result _might_
work just by happenstance, but the arguments sure aren't very
convincing, are they?

So let's make it really clear that the arguments must not be based on
some "ownership" model that you just admitted cannot handle the very
real case of real and common hardware.

Ok?

>  For example one could do one
> partial read from the device, *after* the DMA is done,
> sync_for_cpu(DMA_FROM_DEVICE), examine, then zero out the entire buffer,
> sync_for_device(DMA_FROM_DEVICE)

So the result you want to get to I can believe in, but your sequence
of getting there is untenable, since it depends on breaking other
cases that are more important than your utterly broken hardware that
you don't even know how much data it filled.

And I fundamentally also happen to think that since the CPU just wrote
that buffer, and *that* write is what you want to sync with the
device, then that DMA_FROM_DEVICE was just pure fantasy to begin with.

So that code sequence you quote is wrong. You are literally trying to
re-introduce the semantics that we already know broke the ath9k
driver.

Instead, let me give you a couple of alternative scenarios.

Alternative 1:

 - ok, so the CPU wrote zeroes to the area, and we want to tell the
DMA mapping code that it needs to make that CPU write visible to the
device.

 - Ahh, you mean "sync_for_device(DMA_TO_DEVICE)"?

 - Yes.

   The "for_device()" tells us that afterwards, the device can access
the memory (we synced it for the device).

   And the DMA_TO_DEVICE tells us that we're transferring the zeroes
we wrote on the CPU to the device bounce buffer.

   Now the device got those zeroes, and it can overwrite them
(partially), and everything is fine

 - And then we need to use "sync_for_cpu(DMA_FROM_DEVICE)" when we
want to see the result once it's all done?

 - Yes.

 - Splendid. Except I don't like how you mix DMA_TO_DEVICE and
DMA_FROM_DEVICE and you made the dma_alloc() not use DMA_BIDIRECTIONAL

 - Yeah, that's ugly, but it matches reality, and it would "just work" today.

Alternative 2:

 - Ok, so the CPU doesn't even want to write to the area AT ALL, but
we know we have a broken device that might not fill all of the bounce
buffer, and we don't want to see old stale bounce buffer contents that
could come from some other operation entirely and leak sensitive data
that wasn't for us.

 - Ahh, so you really want to just clear the bounce buffer before IO?

 - Yes. So let's introduce a "clear_bounce_buffer()" operation before
starting DMA. Let's call it "sync_for_device(DMA_NONE)" and teach the
non-bounce-buffer dmas mapping entities to just ignore it, because
they don't have a bounce buffer that can contain stale data.

 - Sounds good.

Alternative 3:

 - Ok, you have me stumped. I can't come up with something else sane.

Anyway, notice what's common about these alternatives? They are based
not on some "we have a broken model", but on trying to solve the
actual real-life problem case.

I'm more than happy to hear other alternatives.

But the alternative I am _not_ willing to entertain is "Yeah, we have
a model of ownership, and that can't handle ath9k because that one
wants to do CPU reads while DMA is possibly active, so ath9k is
broken".

Can we please agree on that?

                          Linus
