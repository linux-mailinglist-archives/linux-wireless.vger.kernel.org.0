Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7B6B8BF0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 08:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCNH2a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCNH21 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 03:28:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3DF10AAA
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 00:28:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h31so8340976pgl.6
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678778902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zrI9sVCqqmiSpcdBkCHHv05oCLBJ25Dqqg/e/HY1PE=;
        b=C9Ey32sJTJaASu+z/1FyslqsbfnyNdmJUNUB6+oB2OmmFLHW3TXdFt4/QmkDEnPkXd
         J+oc1JqjQ8+RGLMBczqsDWq8yStl1QMxo29VJMhOqitTFiKyguQUDPIIasYjKO17wHtT
         ng8Vb3hQv4v493VlrtpS5Bl24vFIuA7GnsgJts+pUOY/YGNteg6pBDhmx6ob8nHqvrTc
         aTsaVCGKF4NRp1KsEXNOuw+ii/VCp08zCDb5Qzz7Cx1Tea++NbjUycXOEphG27a5Hx4u
         K6rD7s+ZuEbs4YHjEVgPqBSYxTWJ6abqoQQ5oeQktZjIjVT6HK9Iqwt6DgFmDgHWCydb
         pk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678778902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zrI9sVCqqmiSpcdBkCHHv05oCLBJ25Dqqg/e/HY1PE=;
        b=sn7a/ck/7pFRZnLq2g0gV5aN4R50Gzb7fh70iOWhWqEdetKP+/XeSnCFj+GHbyoxnc
         CeKqX3/0qqOsAB+CcRhwWcLxdxz6EGGD6Az3wXQ+99CNanBJQZRBj2u4nZnwV8XVURtR
         hXTDaCGfBYr2XeP3/AwLLZ48YXsKQHDHKQ9xJAildhB5b6R7qw0e0/zEyuDjf++ENAW9
         TKY1kJfaCjvI101Rw0hvtc+vNN6HyVDFT0ZSEt24oT9HER4aMQWR8KRARyZZaKdECIkp
         9uOWdDJCY6K2D49DIqM/M5z/voNulTDDHECas/zrT0EExBFHwNmySet9N7XhgvLoJWct
         e62w==
X-Gm-Message-State: AO0yUKXDsNGJ4vqS6wa/1L3QYxDNlbJvCE2+EevGvfgTOEQMpFeMXP22
        8PzkSCn1t41VFH30GE1Rn21Hb2cyO1bJxpk7YNTzgw==
X-Google-Smtp-Source: AK7set/ymRCuQVVjd2YSJZ2ksOxjN0aMC8SJdN2Byssx3rCYzgon3Q33ArJQyLMI7amWxCU0riaxj2d7lDIOIcFTf1A=
X-Received: by 2002:a63:7d03:0:b0:503:a268:b81e with SMTP id
 y3-20020a637d03000000b00503a268b81emr12895598pgc.5.1678778901900; Tue, 14 Mar
 2023 00:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr> <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr> <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr> <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
 <0450e34e-7190-104c-832a-150f15f7c825@free.fr> <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
 <eecb86be-81e3-09cd-8ec7-4e77c42f2795@free.fr> <CAFBinCDHRhLSyFsEv7cdhSgZorj-TdR3HhqSBnAQcUtEsecV=Q@mail.gmail.com>
 <6ac1ecb1-eba4-b0a3-579c-afcbe532a474@free.fr>
In-Reply-To: <6ac1ecb1-eba4-b0a3-579c-afcbe532a474@free.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Mar 2023 08:27:45 +0100
Message-ID: <CAPDyKFrC3a5-VP2DvCYGYUzKtX4Jc7cvNQOKfutW0sha=szOyg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 13 Mar 2023 at 22:42, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote=
:
>
> On 13/03/2023 21:04, Martin Blumenstingl wrote:
>
> > On Mon, Mar 13, 2023 at 6:09=E2=80=AFPM Marc Gonzalez wrote:
> > [...]
> >> QUESTION:
> >> It's not clear to me why we sleep twice for host->ios.power_delay_ms?
> >
> > I'm not sure but I think host->ios.power_delay_ms is independent from
> > the post-power-on-delay-ms property of "mmc-pwrseq-simple".
>
> They are distinct indeed (the props have the same name & similar purpose =
though).

Correct.

>
> host->ios.power_delay_ms is set via:
>
> drivers/mmc/core/host.c:        device_property_read_u32(dev, "post-power=
-on-delay-ms",

This is a property that may be specified in the host's OF node. See
Documentation/devicetree/bindings/mmc/mmc-controller.yaml.

> drivers/mmc/core/host.c-                                 &host->ios.power=
_delay_ms);

Note that the default value is set to 10 ms, in mmc_alloc_host(). So,
if you need a different value, that can be specified in DT.

>
>
> pwrseq->post_power_on_delay_ms is set via:
>
> drivers/mmc/core/pwrseq_simple.c:       device_property_read_u32(dev, "po=
st-power-on-delay-ms",

This is a property that may be specified in the pwrseq OF node. See
Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml.

> drivers/mmc/core/pwrseq_simple.c-                                &pwrseq-=
>post_power_on_delay_ms);
>
>
> However, they are both used to delay mmc_power_up(),
> and the host delay is used to sleep twice, which I
> found confusing ;)

It's certainly a bit hairy to follow, but I think you have understood
things correctly.

>
> Regards
>

Looks like you are getting closer to the solution, at least for the
first step to make sure the SDIO card is getting detected properly.
Nice!

Kind regards
Uffe
