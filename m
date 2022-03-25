Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9094E7C95
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiCYTqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 15:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiCYTq1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 15:46:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887612B51AD
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 12:28:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h7so15023007lfl.2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c98skZ0BjUMamIjtZ5imiZLVO/gl8DuHYbRwakJRogU=;
        b=Suev8BbZiQARkSS4t03OA365leJb0pqRURfN9ENchEyRkWs2YFj9yYWgBOyB03AwTX
         YhQZoZ7id1LSxPtVADVUj2io0XoJ1lCVLAHAHk2KnNq1hnonb7XuA9aYxWYlTBAgFBqO
         RtHXpHxhqkzfBGrkr/vstccVIywh2CCLpuHps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c98skZ0BjUMamIjtZ5imiZLVO/gl8DuHYbRwakJRogU=;
        b=AIzzBTmGa+VqkYL2+zKgHDEfw8nDChYiWSC/sLJVcZO+Ph56ebjTEmBHCxUD/PJHyy
         7/CCEc1ed+ZXJxvJ6yYwSvmnEhTPnp0QtdPqgPViEuwfnj7zzSIxktz7D0n2GRgQ/qhM
         LF261SHnVCV2SVY8rQeGKjB0CwpJpWyAjPTClhjw5om3h6uT5srmIKO9cHR263wYTM+H
         6Pi54gXljcK5YwUoxlI3h/fZMDdwEU4rZtNpp3oXTI29lbq3jAJMF3g7wDUP/cZHYMDJ
         mRkuqy4EO5HH6kgnAu1rPhnDudctIplKzfLoEycfIc4/yjDRbK0mm2pVuxNOGD5FssPw
         00zQ==
X-Gm-Message-State: AOAM532QJh5D9uwjxtcKX4GjzuVqSXa2Y8jwLr4pN1BizJkrJihhnD2f
        iTR68v5a522OkETglomuQu3RUcjqHjetENQwCpM=
X-Google-Smtp-Source: ABdhPJwkiaPKFXhDZQ0aQR2NiKWIbHnQbrr+7VuyzvRQNHElbKIAQ1ol+ebUQVpyJ+7tD/3ZWnn2rQ==
X-Received: by 2002:a19:dc13:0:b0:448:3735:776b with SMTP id t19-20020a19dc13000000b004483735776bmr8815280lfg.77.1648236482454;
        Fri, 25 Mar 2022 12:28:02 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n22-20020a2e7216000000b0024ac2b26734sm11035ljc.23.2022.03.25.12.28.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:28:01 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id bt26so14994305lfb.3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 12:28:00 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr9229114lfj.449.1648236479896; Fri, 25
 Mar 2022 12:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com> <12981608.uLZWGnKmhe@natalenko.name>
In-Reply-To: <12981608.uLZWGnKmhe@natalenko.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 12:27:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghZ3c4G2xjy3pR7txmdCnau21z_tidjfU2w0HO-90=sw@mail.gmail.com>
Message-ID: <CAHk-=wghZ3c4G2xjy3pR7txmdCnau21z_tidjfU2w0HO-90=sw@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Maxime Bizon <mbizon@freebox.fr>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 25, 2022 at 12:26 PM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> On p=C3=A1tek 25. b=C5=99ezna 2022 19:30:21 CET Linus Torvalds wrote:
> > The reason the ath9k issue was found quickly
> > is very likely *NOT* because ath9k is the only thing affected. No,
> > it's because ath9k is relatively common.
>
> Indeed. But having a wife who complains about non-working Wi-Fi printer d=
efinitely helps in finding the issue too.

Well, maybe we should credit her in the eventual resolution (whatever
it ends up being).

Although probably not using that exact wording.

        Linus
