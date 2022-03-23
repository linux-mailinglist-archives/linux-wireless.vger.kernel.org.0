Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7D4E5903
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 20:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbiCWTS1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 15:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344123AbiCWTSZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 15:18:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054AB8567C
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:16:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id l20so4313238lfg.12
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaXnwbXaSXbCX4JA5a0+pq4aaz2a8Xc9Ap8EekKfrJg=;
        b=P9ZcEpik6R5EPT4CggIUIW5sJuzMdcf8B0GMQ57M9+1WIls6aC+OjCSeLSGFKdwBgq
         gDZxv7j9z3xw9CvLBywUXZn41za0VVQ/9nq70BC0iyCUf/T9GlF7P+qvj0GM1CjFfk0Y
         40eaqcCqV0NJJlet/B4OqeaNkITYKUoe+Gn8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaXnwbXaSXbCX4JA5a0+pq4aaz2a8Xc9Ap8EekKfrJg=;
        b=iadlLY56xx2umDQurgiUSbUGtxBqYH5BI4XrFkbjmq5bUVLA7Zw6BGmCeFg9IeulNX
         XOwPfVrAusG6uI3avbJhzXEC55Qruss+JpMhPez8jsE1gHSHfNeXaE3lcyPIgCOuk055
         hsRGThab8u7aousQF236XG0gIr69U9QdebatMXm8K0aBnT1bJ4QkO0lfpBPVfKTG1wu9
         mgT6M55c2LPdMpEcvuGjHF1lQ9YEkpxIFHddQEcnAw1jSkgZItIU75L0grWLncgQaRjw
         0zr51XPiXUCd9G6oKqUnD7wk6dxul8pnhqNUH0tFegsDPc8uXyq4oFtmaCpJ/PinjyT0
         vCvw==
X-Gm-Message-State: AOAM533B4d9ctGhdvRnT1JyvXIpVdKTCwZT4xFglMIh35DupVjwIiKxP
        UEdm1F7JfW4MpjyCrA5inKk+jdFSAzt/3dzVGiI=
X-Google-Smtp-Source: ABdhPJxRegwVcRrEiJXQUi0DIUTUklcwsYp6XPGu405joNyJIuEnftINKDK74vHB2O/aGQgG1sq6jQ==
X-Received: by 2002:a19:9201:0:b0:443:c317:98ff with SMTP id u1-20020a199201000000b00443c31798ffmr1008093lfd.331.1648063013012;
        Wed, 23 Mar 2022 12:16:53 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 8-20020a2e1548000000b002463639d0f2sm80199ljv.68.2022.03.23.12.16.50
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 12:16:50 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id a26so4318386lfg.10
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:16:50 -0700 (PDT)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr987003lfu.531.1648063009559; Wed, 23
 Mar 2022 12:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
In-Reply-To: <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 12:16:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
Message-ID: <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
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

On Wed, Mar 23, 2022 at 12:06 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-23 17:27, Linus Torvalds wrote:
> >
> > I'm assuming that the ath9k issue is that it gives DMA mapping a big
> > enough area to handle any possible packet size, and just expects -
> > quite reasonably - smaller packets to only fill the part they need.
> >
> > Which that "info leak" patch obviously breaks entirely.
>
> Except that's the exact case which the new patch is addressing

Not "addressing". Breaking.

Which is why it will almost certainly get reverted.

Not doing DMA to the whole area seems to be quite the sane thing to do
for things like network packets, and overwriting the part that didn't
get DMA'd with zeroes seems to be exactly the wrong thing here.

So the SG_IO - and other random untrusted block command sources - data
leak will almost certainly have to be addressed differently. Possibly
by simply allocating the area with GFP_ZERO to begin with.

              Linus
