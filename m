Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA34E7CFE
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiCYT3s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 15:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiCYT3e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 15:29:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253B81F1602
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 12:03:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w21so7515249wra.2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgGZKxsD9TLt3F67gvL7glAxKY5LH/ALHfbJS10Unqo=;
        b=Ifi0U+jMvGYK0BTqlDqJD7wDJnEG/YfUGRvZzfRr8j43WKraDG3cCjf0FFuimZ9VSg
         Z0g9+NcUuKem/himXNWFu4jQmCzk/SXJEhcY5eS/wYwMyvOJB4gmBU/F0T+ou6Dqjoci
         oWVtYazkM++O6R/PwREQdtdeDirieoe3APP1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgGZKxsD9TLt3F67gvL7glAxKY5LH/ALHfbJS10Unqo=;
        b=1Veuim0H8n9Owe/AH1opOM0Mzqy6veDUhvGkAxkX0+EOyBAW3kUoPtWbNv6SX71Z2D
         izjFUisFC7OihOjUO2yzVMAwzH+Nmyuu6oqON6VHbw59xGEbTI7GOWL/DYmTrwK8SOan
         7ESFw5BECNkFsJcjEZldAmeprlMCuSUOa/kd555boynvHVJARtTg48pfP/OEA7QC7Gio
         e6FStTgaZ5Pv1QctbWq66jnPp2U3mMWHih5VeoLFb4jky/MRIaJMS2lGW64DTIs7ugv4
         5e8hNVWjfrmguKX2Z3H2G/WJ8KCpn2ftUsFWRYaVSj8/tMcQvISrVeG1w1/p/8FWH13b
         4YbA==
X-Gm-Message-State: AOAM532JCehNoyYVhijT6suTaLkMJVUd7psbuvctPnf5ObXJM2VVk7pu
        fF7qjBmP1YdzMwzHoX40a6br6TnGAceC/TfYWQ4=
X-Google-Smtp-Source: ABdhPJxJnOF035WMGXd6rJmIwsBuwAs8bLRalA4nU77gntWswo4PYWV/rLmTFCCZE1c0gtlpwK2X8g==
X-Received: by 2002:a05:651c:105c:b0:249:60b8:d3bf with SMTP id x28-20020a05651c105c00b0024960b8d3bfmr9229080ljm.89.1648234474291;
        Fri, 25 Mar 2022 11:54:34 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w23-20020a0565120b1700b0044829a6061esm791048lfu.186.2022.03.25.11.54.33
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 11:54:33 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id q5so11456503ljb.11
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 11:54:33 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr9323690ljc.506.1648233985657; Fri, 25
 Mar 2022 11:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com> <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com> <20220324190216.0efa067f.pasic@linux.ibm.com>
 <20220325163204.GB16426@lst.de> <87y20x7vaz.fsf@toke.dk> <e077b229-c92b-c9a6-3581-61329c4b4a4b@arm.com>
In-Reply-To: <e077b229-c92b-c9a6-3581-61329c4b4a4b@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 11:46:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKF5GfLXyVGDQDifh0MpMccDdmBvJBG3dt2+idCa5DzQ@mail.gmail.com>
Message-ID: <CAHk-=wgKF5GfLXyVGDQDifh0MpMccDdmBvJBG3dt2+idCa5DzQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Christoph Hellwig <hch@lst.de>,
        Halil Pasic <pasic@linux.ibm.com>,
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

On Fri, Mar 25, 2022 at 11:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Note that the current code is already a violation of the DMA
> API (because the device keeps writing even when it doesn't have
> ownership), so there's not a very strong argument in that regard.

See my other email. I actually think that the ath9k code is 100%
correct, adn it's the dma-mapping code that is in violation of the
rules.

And a big part of the problem - I think - is that the rules are so
badly documented and not explicitly listed.

I think my list of three different sync cases (not just two! It's not
just about whether to sync for the CPU or the device, it's also about
what direction the data itself is taking) is correct.

But maybe I'm wrong.

I really want people to think about this, because right now my gut
feel is that commit aa6f8dcbab47 was just absolutely incorrect.

              Linus
