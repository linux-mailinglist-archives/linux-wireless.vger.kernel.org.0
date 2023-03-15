Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FC6BBE32
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 21:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCOU4h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCOU4g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 16:56:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2008C511
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 13:56:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h8so21415585plf.10
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678913795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z84vdnHiRqRhIyxTsu5Pz3PgSNNcE2YtTRegy9XPJ4U=;
        b=W0vzKfbMSniEwUYBLxk3WHtG0hSZCnLx2K6R6OlCD0LwPHcI0RDH6i5waZnhw9kJzn
         N3XxS+LMwYpLw3zKzLZPvpq8kQbRpVBxQOd0cp9yJQVqsiq5nRqcaGYfttvvc9jZLvu+
         2wIFNiJQfVJFYf0U4AHxZloaqEy1T5MoLmCLMGxaAnvp04Ne3OesL8QVJAJ+jx3cBf7m
         NYYwyY8hVUVn2y3ffHY34baOVwfd/NaDuKLK3XWSjDFD27zMPhmXLoQIm4kLLo51y6Xw
         6gJqZw2LHxrwGkZhWstqT66lXaSHngVWk76252J05fblP/2/0CGeXg0WtXLs2euihfi4
         PhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678913795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z84vdnHiRqRhIyxTsu5Pz3PgSNNcE2YtTRegy9XPJ4U=;
        b=uTTE8UGaEWi+mHgosiVq8eBYPTxjfwHskafwIyWhac7fIaVZ8SK2uxTNQfs55N+UWL
         o6MAMxZsj5T1oTw8xx/5HzsKWWluvxNAr1GVbtt9oqQT0V82M0uMBB7oSLbKxC0dtVyc
         k5p6OF7IsLnDRuq5kwxIbFm6rtI7ESKfS667meGnMNZzX5wDN8jV7WhzstrCVa7ZFyFo
         Hk8mc5odRYFB5CmnEJHFUOb4Ikjv+ojsy6muMNfbkzSrCpjrpbmVXe0YYaLatMcSGCWL
         WEzaB7FL8HRw5FX3xeDRDRV4X/vZdWwoM4bnzvdPKxf1BnVzGamEuAibXx5Rlwt593fl
         Nf9w==
X-Gm-Message-State: AO0yUKUTW2cRF0sT30Jad3/8Bdwq4J+5/7x6f4i4B2GNHkg2vPB3J4U6
        IuGAEVrHpbHwzj/q9hF77MWTRekSVNh1gVhhmyYqzw==
X-Google-Smtp-Source: AK7set9Lqxc9Zjf6HNWj3hSvkV7xlNAl2GlygnkcJoOS+b4e1BHgUEzRwsa+zk5UtznFzSacYBz7tBCLaD6lhJ72m+A=
X-Received: by 2002:a17:903:25d5:b0:1a0:4847:864c with SMTP id
 jc21-20020a17090325d500b001a04847864cmr377557plb.13.1678913795246; Wed, 15
 Mar 2023 13:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr> <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr> <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr> <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
 <0450e34e-7190-104c-832a-150f15f7c825@free.fr> <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
 <eecb86be-81e3-09cd-8ec7-4e77c42f2795@free.fr> <CAFBinCDHRhLSyFsEv7cdhSgZorj-TdR3HhqSBnAQcUtEsecV=Q@mail.gmail.com>
 <6ac1ecb1-eba4-b0a3-579c-afcbe532a474@free.fr> <CAPDyKFrC3a5-VP2DvCYGYUzKtX4Jc7cvNQOKfutW0sha=szOyg@mail.gmail.com>
 <c7e48c6f-530b-7198-b8bb-fc927a2fdc66@free.fr> <CAPDyKFpJR9rgadXEBn+73FKgmLM8sZgzNbKV_x_udwOSRGH44Q@mail.gmail.com>
 <893311e7-6fce-118b-a683-6988de161698@free.fr>
In-Reply-To: <893311e7-6fce-118b-a683-6988de161698@free.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Mar 2023 21:55:58 +0100
Message-ID: <CAPDyKFotQ3hVHM379f8yp7LBcyN6zGTz18x3X07_mx4mZsAh+A@mail.gmail.com>
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        Pierre-Hugues Husson <phh@phh.me>,
        linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 14 Mar 2023 at 17:38, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 14/03/2023 12:08, Ulf Hansson wrote:
>
> > If the delay is to manage vmmc and vqmmc, which is somewhat part of
> > the generic specifications (SD/MMC), then it should be described in
> > the host's node.
> >
> > A pwrseq is something special, which is also platform and device
> > specific (the SDIO device). If the delays correspond to this, it
> > should be part of the pwrseq node.
>
> Uffe,
>
> Wouldn't it make sense to warn, when probing for a non-removable card
> returns nothing?
>
> Something along these lines (which I can spin into a formal patch)
>
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2257,6 +2257,9 @@ void mmc_rescan(struct work_struct *work)
>                         break;
>         }
>
> +       if (!mmc_card_is_removable(host) && !host->card)
> +               dev_warn(mmc_dev(host), "no device found");
> +
>         /*
>          * Ignore the command timeout errors observed during
>          * the card init as those are excepted.
>
> Regards
>

Seems reasonable to me! Please post a patch.

Kind regards
Uffe
