Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC223F0E27
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 00:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhHRWaj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 18:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhHRWai (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 18:30:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D9C061796
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 15:30:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso3436300pjb.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DUTuMfsQqxqX+3pR2oz9dVJNWsHg80kq142ck8zdj0s=;
        b=HXqi8rpNQlqRCRobulkOlcaA4+c6J/4aW1kHG07w5z+LW3VAsPY7L3ovHbYLAvr6BW
         z8PYA40q5a4/E1aSSd1f0X7nRnd2FNDMsOqvNHCn+M7iSwPw+3HB842oCYFV1odUjD4+
         aowm4n1LLC28ISLDG0efepefjXmirvRMkeWhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DUTuMfsQqxqX+3pR2oz9dVJNWsHg80kq142ck8zdj0s=;
        b=CVIWz2KHMpqC6eb95sUc6JmBIyb0OeUYlr6yuSfABrnlB8X4twMMKkLcY9Ixqg5Uyl
         5UM/PfJ3UqwO5xhxDBA0plmipaI2fyDydrTVlTtmuu0BoeYhe+ck925tOTHTooIW06/l
         bcdKaBo+HdzFHiCbJyyLewRL51YINTwtylaaP9FVXINOHgbR57Joax8p2wEsUb6sT2Lu
         RQSshhHxPPTqYIkOahybGwTNWZt+EuWelM6QiuWBKkeLIU0//ZiDAUEAT9tJUYSbNqXk
         hvmhEZ5MWy6IKtzxizV/XSoN49Ad5ROLUT2bf1IBMDrL8TG87jQAWWUcpqo6DSwayigS
         EWnw==
X-Gm-Message-State: AOAM533q9J0Nzy1OXVvNIxc5U/HDgbrvAgiTTG+WV1sUlsfDTgeZhL9+
        FvKrSM6T83NQwOFkw8kR6meapw==
X-Google-Smtp-Source: ABdhPJwejqek+pQNgEJHoUL+LD8id8sswOa0BezZLWGyCwRRYJ3BmiAhJE1bgJAMyKte9lbr8NDHRw==
X-Received: by 2002:a17:90a:a581:: with SMTP id b1mr1663300pjq.153.1629325803017;
        Wed, 18 Aug 2021 15:30:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n185sm862325pfn.171.2021.08.18.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:30:02 -0700 (PDT)
Date:   Wed, 18 Aug 2021 15:30:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        linux-block@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        clang-built-linux@googlegroups.com, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 61/63] powerpc: Split memset() to avoid multi-field
 overflow
Message-ID: <202108181528.9CDB56FEC@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-62-keescook@chromium.org>
 <7630b0bc-4389-6283-d8b9-c532df916d60@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7630b0bc-4389-6283-d8b9-c532df916d60@csgroup.eu>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 18, 2021 at 08:42:18AM +0200, Christophe Leroy wrote:
> 
> 
> Le 18/08/2021 à 08:05, Kees Cook a écrit :
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memset(), avoid intentionally writing across
> > neighboring fields.
> > 
> > Instead of writing across a field boundary with memset(), move the call
> > to just the array, and an explicit zeroing of the prior field.
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Qinglang Miao <miaoqinglang@huawei.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Hulk Robot <hulkci@huawei.com>
> > Cc: Wang Wensheng <wangwensheng4@huawei.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
> > Link: https://lore.kernel.org/lkml/87czqsnmw9.fsf@mpe.ellerman.id.au
> > ---
> >   drivers/macintosh/smu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
> > index 94fb63a7b357..59ce431da7ef 100644
> > --- a/drivers/macintosh/smu.c
> > +++ b/drivers/macintosh/smu.c
> > @@ -848,7 +848,8 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
> >   	cmd->read = cmd->info.devaddr & 0x01;
> >   	switch(cmd->info.type) {
> >   	case SMU_I2C_TRANSFER_SIMPLE:
> > -		memset(&cmd->info.sublen, 0, 4);
> > +		cmd->info.sublen = 0;
> > +		memset(&cmd->info.subaddr, 0, 3);
> 
> subaddr[] is a table, should the & be avoided ?

It results in the same thing, but it's better form to not have the &; I
will fix this.

> And while at it, why not use sizeof(subaddr) instead of 3 ?

Agreed. :)

Thanks!

-- 
Kees Cook
