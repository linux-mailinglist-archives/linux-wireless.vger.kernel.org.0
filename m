Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D313F55CCD9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 15:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbiF0MSu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 08:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiF0MSt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 08:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AD2CBC22
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656332324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeTRmruqb8PXfYbpUfjyc9E5QDPm7vrxIbGT7xAqTVw=;
        b=RfSebZVFG5u245fH1w11v0iZz3pmrP5Nd4UK+EI/pVug867ROZFfUqG8ZvjF2550fkiXBZ
        RyOtoDWfV83YmAjE7RZ4EJC/JMvWp+JMCf8Ba1jgol/v+FHnuzuQ296pkAVxbNykx4bkws
        QrENAUhC4pPAxuGRcXW/Q+e+5w+gbRE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-X9Rf0My1NgyAj_k5D_p0ig-1; Mon, 27 Jun 2022 08:18:43 -0400
X-MC-Unique: X9Rf0My1NgyAj_k5D_p0ig-1
Received: by mail-ej1-f69.google.com with SMTP id e20-20020a170906315400b007262bd0111eso2330213eje.9
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 05:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QeTRmruqb8PXfYbpUfjyc9E5QDPm7vrxIbGT7xAqTVw=;
        b=oTi6Bm2XPwjhg21Z+hwtGTFfBh5S+/NmyCDk4v5AiueZQeKS/sBvBp6y4yqSvB3Hhd
         6qyV28Bi+WR6QD3/PBupVRYL0gKdVBpntU1HSi/dsNXUh7Ngqy/Ca42RhhDgkbqyauyX
         u+obN7GKM0JqECTL5thFUcvFE50e9M+m2i5YVlYpEgX5JbZvRwLnIU/DukfNIgAglssc
         NtYbiaHums/xq2cVB0Sz1lPjWcwPa2w3a6XMcMoAy4eLhokuDyVGX2P3dsY4E43hsLbC
         i2S6xNTnIkj+eRiv2dZu2NTwmmf+WIBhZ4vLf//iaQJAdj+iLDqrR+oq0GWBSrh4e2DP
         2vpQ==
X-Gm-Message-State: AJIora8LRnqeor0GSDpj6adihw1SSpmbyelaN86vtVc5jRT/CtJZWIXV
        nUEF1UXPkrjYsaPQpPCIP7tQ6xoqDb4IzBEUWCaEt/hXYFaWSDGpDr3b36+kEarnGgCCRmCqRM7
        lZ6ftecOrs3U+82JeDalSQ2i2PPU=
X-Received: by 2002:a05:6402:320f:b0:435:7236:e312 with SMTP id g15-20020a056402320f00b004357236e312mr16272773eda.115.1656332320678;
        Mon, 27 Jun 2022 05:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkzyK4X8BkQekizGdw2RIZ8xukoWzY0sSwXgAYAPhEmTwq0WxbjiOjIOET+0jJY1iqXoU9eg==
X-Received: by 2002:a05:6402:320f:b0:435:7236:e312 with SMTP id g15-20020a056402320f00b004357236e312mr16272566eda.115.1656332318612;
        Mon, 27 Jun 2022 05:18:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7cd05000000b0042bc5a536edsm7343465edw.28.2022.06.27.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:18:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BFDC7476CA0; Mon, 27 Jun 2022 14:18:36 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gregory Erwin <gregerwin256@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        stable@vger.kernel.org
Subject: Re: [PATCH v6] ath9k: sleep for less time when unregistering hwrng
In-Reply-To: <20220627120735.611821-1-Jason@zx2c4.com>
References: <20220627113749.564132-1-Jason@zx2c4.com>
 <20220627120735.611821-1-Jason@zx2c4.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 27 Jun 2022 14:18:36 +0200
Message-ID: <87y1xib8pv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Even though hwrng provides a `wait` parameter, it doesn't work very well
> when waiting for a long time. There are numerous deadlocks that emerge
> related to shutdown. Work around this API limitation by waiting for a
> shorter amount of time and erroring more frequently. This commit also
> prevents hwrng from splatting messages to dmesg when there's a timeout
> and switches to using schedule_timeout_interruptible(), so that the
> kthread can be stopped.
>
> Reported-by: Gregory Erwin <gregerwin256@gmail.com>
> Tested-by: Gregory Erwin <gregerwin256@gmail.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Rui Salvaterra <rsalvaterra@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: stable@vger.kernel.org
> Fixes: fcd09c90c3c5 ("ath9k: use hw_random API instead of directly dumpin=
g into random.c")
> Link: https://lore.kernel.org/all/CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsF=
GTEjs0c00giw@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/CAO+Okf5k+C+SE6pMVfPf-d8MfVPVq4PO7EY8H=
ys_DVXtent3HA@mail.gmail.com/
> Link: https://bugs.archlinux.org/task/75138
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Gregory, care to take this version for a spin as well to double-check
that it still resolves the issue? :)

-Toke

