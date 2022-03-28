Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691F14E8B3D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 02:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiC1Ai3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Mar 2022 20:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiC1Ai3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Mar 2022 20:38:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A3E4ECCF
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 17:36:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bi12so25485467ejb.3
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsBHPoKRCtwDOMc2JT/S0rILfVAOjOsIUEg1vfmMk0I=;
        b=KTuL8s82i3Mk75qC61EFLCdxdodMcKaC6rZIGrZq6pH27ySo4Ut4D253RZhCx2Apft
         KLydbkrKIkIu40UMY0bDeeXNtbHp0U0TEYaRj4iCgCkdnXvAOxzWT119PcO/nwUvO8MP
         RszsIWAmBGdjtyiwR7qPFzhdNHOMzILrN1FLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsBHPoKRCtwDOMc2JT/S0rILfVAOjOsIUEg1vfmMk0I=;
        b=EQX3z43DP7KTUmR/4dmGcG4SMH/ZTzMCHr+e5tflOr0aD88/JtsLYsiLrixEfDLygX
         bW+A+lZL9sxpz9YNvg0p3Q1EMqqzmtqMx97wZ3lK1AxcXhY4Ax6syA9kliJ/mX88Pgx8
         WXLflVvR5weThz4g0dqhk1SPf6msdFV5oeAJ0T58VSJVrPTgr0lTn4zFA56ScNavnKCM
         kyoqI6RzoMOCr+z7RT2Y2jle+kJJlYGoL24CVHLUetFcz6TFUQHj2kWmCxCmltOrJXQq
         bG1BmJ5juQ+ECbux6C4AQ0Q+LHLcF+lrX2JO61xNbjasmlCPYlWjStp9N7bQMQaiR3Ph
         r1bA==
X-Gm-Message-State: AOAM533Tm9QcenrQHk1ozM4aE4rkahQDIe3LavB2SrJhQdHU5zkvYXe/
        c3ex+8ZRpJmwrveoXCbGAr+oLdQcdqHUX5aMzwg=
X-Google-Smtp-Source: ABdhPJwY81auTxa42qkKixpyYF5dcnf9MTxSwtX0MFoilt8sp+Solp3Jt/wRQoaE6hiFub9dcLKlMA==
X-Received: by 2002:a17:906:26da:b0:6d6:da2e:d338 with SMTP id u26-20020a17090626da00b006d6da2ed338mr24619461ejc.700.1648427807908;
        Sun, 27 Mar 2022 17:36:47 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b0041902ac4c6asm6225756edy.1.2022.03.27.17.36.47
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 17:36:47 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id yy13so25454009ejb.2
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 17:36:47 -0700 (PDT)
X-Received: by 2002:a2e:a549:0:b0:249:9ec3:f2b with SMTP id
 e9-20020a2ea549000000b002499ec30f2bmr4449509ljn.358.1648427417735; Sun, 27
 Mar 2022 17:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk> <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <20220327054848.1a545b12.pasic@linux.ibm.com> <CAHk-=whUJ=tMEgP3KiWwk0pzmHn+1QORUu50syE+zOGk4UnFog@mail.gmail.com>
 <CAHk-=wgUx5CVF_1aEkhhEiRGXHgKzUdKiyctBKcHAxkxPpbiaw@mail.gmail.com> <20220328015211.296739a4.pasic@linux.ibm.com>
In-Reply-To: <20220328015211.296739a4.pasic@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 17:30:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whK3z5O4G55cOb2JYgwisb4cpDK=qhM=0CfmCC8PD+xMQ@mail.gmail.com>
Message-ID: <CAHk-=whK3z5O4G55cOb2JYgwisb4cpDK=qhM=0CfmCC8PD+xMQ@mail.gmail.com>
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

On Sun, Mar 27, 2022 at 4:52 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> I have no intention of pursuing this.  When fixing the information leak,
> I happened to realize, that a somewhat similar situation can emerge when
> mappings are reused. It seemed like an easy fix, so I asked the swiotlb
> maintainers, and they agreed. It ain't my field of expertise, and the
> drivers I'm interested in don't need this functionality.

Ok.

That said, I think you are putting yourself down when you said in an
earlier email that you aren't veryt knowledgeable in this area.

I think the fact that you *did* think of this other similar situation
is actually very interesting, and it's something people probably
_haven't_ been thinking about.

So I think your first commit fixes the straightforward and common case
where you do that "map / partial dma / unmap" case.

And that straightforward case is probably all that the disk IO case
ever really triggers, which is presumably why those "drivers I'm
interested in don't need this functionality" don't need anything else?

And yes, your second commit didn't work, but hey, whatever. The whole
"multiple operations on the same double buffering allocation"
situation is something I don't think people have necessarily thought
about enough.

And by that I don't mean you. I mean very much the whole history of
our dma mapping code.

I then get opinionated and probably too forceful, but please don't
take it as being about you - it's about just my frustration with that
code - and if it comes off too negative then please accept my
apologies.

          Linus
