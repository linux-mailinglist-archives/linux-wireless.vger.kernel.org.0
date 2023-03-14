Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114E46B9127
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 12:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCNLKM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCNLJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 07:09:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F07BA05
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 04:09:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so5648184pjv.5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678792172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQAiozzsgfoGxDlvyrCg9UpjYhNdzMFc50048gpfD9Y=;
        b=ANUC4vGZDGeomKUX9RdMwGHm9SlX9igqh9scv2CupwN4JAWrfLcY/+jqP/5/TjSa5B
         bKRF07o53l6Bqw+U5ADTeu5XopnqxR9c1/NeOqhGvwtmrhqqbUumpjIW93n6xAPZWwrI
         /P//0k7NoAyPy0sAYwO6rNTHOMU4TNG+ZEhxhYhTq7kRWEoKgplNFI2uZaaxv9SnhrtV
         YYoJWiH2HAwxicVlofMUuwhZ087g0/WabkvU0QFwpbxoeRlLh7rFMbOwgH+xv+hhv/OK
         xLfeKSLqBdODK8huo/wOMomMhQ6O036irhU+LGQKtVbEf7gOHSPudI8kUqr9PavPmQRF
         2WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQAiozzsgfoGxDlvyrCg9UpjYhNdzMFc50048gpfD9Y=;
        b=fYaBK8JCXpdJxlxkFL0LCxzOXQQMeQNq92lBr3rggepgu4GMToChXYT84UM09e23xB
         Sv4NsR8ffCC82Zv+WuqGlvafvKXjKKSCI01IdUWwfuN5Rcik+b47KaUujmir/UZj9yUg
         iiOlYw5T1UxEbSDWxENYo1mEJj3I5oM4C4n6Od6ZBQutjHXiDJM1lwiOPg2JeJhjmEOk
         ALXYIAVqkFHKgS43CQ3xBaBjl8fQ5j9JRkxDNuabTEv5u3V0AvSA205eLOheYjCdJI/Z
         putfZkNgXYxvbz1wCj6HEGcRtFw0mRjIlJtPRYdJwWjWpLIB7cUi7akCUZX/A01YjM9C
         l3fQ==
X-Gm-Message-State: AO0yUKVAV5FpPhkF6s6uZSb2VgiWHikJZJZNnIOCyqC7hkkEWSi6RqMh
        co3o274TRwCAUXbLKGveaZC2y+My5lxxj755NTVGsQ==
X-Google-Smtp-Source: AK7set8SoG6+bZSlQ3lAG0t9/aOo3BMF7TfVI/qKa1YUYqwAfpb+sSg8EzKkriYHbUyFmsCPrb2ZqbrscDfcU7B55cA=
X-Received: by 2002:a17:902:ba94:b0:19f:2164:9b3b with SMTP id
 k20-20020a170902ba9400b0019f21649b3bmr4366905pls.13.1678792171819; Tue, 14
 Mar 2023 04:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr> <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr> <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr> <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
 <0450e34e-7190-104c-832a-150f15f7c825@free.fr> <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
 <eecb86be-81e3-09cd-8ec7-4e77c42f2795@free.fr> <CAFBinCDHRhLSyFsEv7cdhSgZorj-TdR3HhqSBnAQcUtEsecV=Q@mail.gmail.com>
 <6ac1ecb1-eba4-b0a3-579c-afcbe532a474@free.fr> <CAPDyKFrC3a5-VP2DvCYGYUzKtX4Jc7cvNQOKfutW0sha=szOyg@mail.gmail.com>
 <c7e48c6f-530b-7198-b8bb-fc927a2fdc66@free.fr>
In-Reply-To: <c7e48c6f-530b-7198-b8bb-fc927a2fdc66@free.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Mar 2023 12:08:55 +0100
Message-ID: <CAPDyKFpJR9rgadXEBn+73FKgmLM8sZgzNbKV_x_udwOSRGH44Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 14 Mar 2023 at 09:33, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote=
:
>
> On 14/03/2023 08:27, Ulf Hansson wrote:
>
> > On Mon, 13 Mar 2023 at 22:42, Marc Gonzalez wrote:
> >>
> >> On 13/03/2023 21:04, Martin Blumenstingl wrote:
> >>
> >>> On Mon, Mar 13, 2023 at 6:09=E2=80=AFPM Marc Gonzalez wrote:
> >>> [...]
> >>>> QUESTION:
> >>>> It's not clear to me why we sleep twice for host->ios.power_delay_ms=
?
> >>>
> >>> I'm not sure but I think host->ios.power_delay_ms is independent from
> >>> the post-power-on-delay-ms property of "mmc-pwrseq-simple".
> >>
> >> They are distinct indeed (the props have the same name & similar purpo=
se though).
> >
> > Correct.
> >
> >>
> >> host->ios.power_delay_ms is set via:
> >>
> >> drivers/mmc/core/host.c:        device_property_read_u32(dev, "post-po=
wer-on-delay-ms",
> >
> > This is a property that may be specified in the host's OF node. See
> > Documentation/devicetree/bindings/mmc/mmc-controller.yaml.
> >
> >> drivers/mmc/core/host.c-                                 &host->ios.po=
wer_delay_ms);
> >
> > Note that the default value is set to 10 ms, in mmc_alloc_host(). So,
> > if you need a different value, that can be specified in DT.
> >
> >>
> >>
> >> pwrseq->post_power_on_delay_ms is set via:
> >>
> >> drivers/mmc/core/pwrseq_simple.c:       device_property_read_u32(dev, =
"post-power-on-delay-ms",
> >
> > This is a property that may be specified in the pwrseq OF node. See
> > Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml.
> >
> >> drivers/mmc/core/pwrseq_simple.c-                                &pwrs=
eq->post_power_on_delay_ms);
> >>
> >>
> >> However, they are both used to delay mmc_power_up(),
> >> and the host delay is used to sleep twice, which I
> >> found confusing ;)
> >
> > It's certainly a bit hairy to follow, but I think you have understood
> > things correctly.
> >
> >>
> >> Regards
> >>
> >
> > Looks like you are getting closer to the solution, at least for the
> > first step to make sure the SDIO card is getting detected properly.
> > Nice!
>
> What I'm confused about is:
>
> Why would I specify the delay in the host rather than in the pwrseq?

If the delay is to manage vmmc and vqmmc, which is somewhat part of
the generic specifications (SD/MMC), then it should be described in
the host's node.

A pwrseq is something special, which is also platform and device
specific (the SDIO device). If the delays correspond to this, it
should be part of the pwrseq node.

>
> I'll have to study mmc_power_up() a bit more ;)

:-)

Kind regards
Uffe
