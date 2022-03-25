Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0724E7C6B
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiCYThp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 15:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiCYTh1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F49261DD3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 12:21:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d5so14973347lfj.9
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MqmH9CCCrUKFAq5y+I/qeK/sNikgDEGLg2VH+hZ/B8=;
        b=EEYCtzdxDwF4pZQoFLQy5R1bkbtIioQJ+didZOsq+7BOWsBdCAqNeXRuHlQHbxjkxI
         6ZpgNOxAuZZNbggkh7Po3d0QcOFG1glqGOPQvM9m9QhMt25NNyLu1evDrcAPEgux5s6f
         doW8iQM9agqh0IgmvQNxMRNQkwdp7w1AkhPq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MqmH9CCCrUKFAq5y+I/qeK/sNikgDEGLg2VH+hZ/B8=;
        b=6LRl08f7pUAkoX25yPiQft+FGbGC6zR7/sd107QY6eCXcM6s8UXrCrfQtbuaUxAyHO
         MQZW8+2QM+A7TJRYS3PwQoFBM5cCy2QrqOv+hsD++kbo86YaG1N6Y7HHfWlwnAAK80px
         pPXGQZb8CBtJZCpe/D8Bx8ua8fEEGd2titArNtRAn58CmLqMq2FO7ZEEB9TLvxSm91ff
         nC/pPiiculs6Q/G4JWgBNOcizIBGDyKve1E+TtLt59eSljp63XnIGuRhg23uvwfI6eHq
         07EqtOC33JrxyPZyBj218MckEuHHLCuxRH3sM0a0aKXfNw6aoCdKehYLoQXYof7rRit+
         Vs5A==
X-Gm-Message-State: AOAM531nsrNCroU369ASoWX69Ve+jDPUHT+S7qXSL4r6tsUdQMefWg/k
        tqM3HAD2pSvOn9rtbh75zeVrn1ImSvGVZy3xaUY=
X-Google-Smtp-Source: ABdhPJzmlil6CrUunu7vqwacCgmkluuwec68zdM/wlkJKinBS3grLuKcuzS2XBJ5QlIG2SDjvFccTA==
X-Received: by 2002:ac2:5e31:0:b0:44a:247d:6022 with SMTP id o17-20020ac25e31000000b0044a247d6022mr8688477lfg.509.1648236113589;
        Fri, 25 Mar 2022 12:21:53 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f17-20020a2e1f11000000b00247f8eb86a7sm746771ljf.108.2022.03.25.12.21.50
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:21:51 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 5so14988820lfp.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 12:21:50 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr8851909lfh.687.1648236109737; Fri, 25
 Mar 2022 12:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk> <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com> <a1829f4a-d916-c486-ac49-2c6dff77521a@arm.com>
In-Reply-To: <a1829f4a-d916-c486-ac49-2c6dff77521a@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 12:21:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpKDePfUoKmvJhSNbWcHFY5e7Uq5qEypD=R14+66DNvQ@mail.gmail.com>
Message-ID: <CAHk-=whpKDePfUoKmvJhSNbWcHFY5e7Uq5qEypD=R14+66DNvQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Maxime Bizon <mbizon@freebox.fr>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
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

On Fri, Mar 25, 2022 at 12:14 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Note "between the DMA transfers", and not "during the DMA transfers".
> The fundamental assumption of the streaming API is that only one thing
> is ever accessing the mapping at any given time, which is what the whole
> notion of ownership is about.

Well, but that ignores reality.

Any documentation that ignores the "CPU will want to see the
intermediate state" is by definition garbage, because that is clearly
a simple fact.

We don't write documentation for fantasy.

            Linus
