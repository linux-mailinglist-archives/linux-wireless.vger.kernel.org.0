Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84966B822F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 21:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCMUEc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCMUE2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 16:04:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247125D466;
        Mon, 13 Mar 2023 13:04:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn21so23306645edb.0;
        Mon, 13 Mar 2023 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678737865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlsJMKW6fTnSyJwAJ4cqmlm3nWjmDE6jeDNees0hYCg=;
        b=n9+PUEiEa5PYrJ1/BoBZUrn8uJ9PX4FHL1ZcarM/14nWpoDvRkiHFPoCI7GYf11d/k
         XMKEWzewKzarPdpkk6l803LIGdy6l9fifXm4mhMfBYaRG36g1qUyg6fqa+kS8fxnhLLM
         3FV+2tbxvJwh0qY/BhfNaw0aL/+c0KYw4kzbQbzJEqOX7Tw7A8iQtWdOmL6a9lqE2oCY
         LL2hszEQ5X27jJVE9gqI8EiHzNQurEoiynjojgSUNd2VXO6wCANAVXnykRzzRLgob+M9
         32rMPxuPP9zqKh+LjmwiKhQxxdM48rHJIGJxD7tSx5Hkxd2NRAysKo2rmRm/R0lrq/hC
         xxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlsJMKW6fTnSyJwAJ4cqmlm3nWjmDE6jeDNees0hYCg=;
        b=EpbtQbBSlsx50/QRHrXjcyrHGBgybBDos6u9gsInTW8xCa3niqvk7wwUpH0Hcd5CWE
         XwRhsKf0JslWdS2jzOYijGhHWC9kLsIbY2Gty2BoiwTRpYJFAXzjAvcGJjeRCD9xW41A
         EnHiYYKx7kvcB1kBUQuhkbXerG+lUVySPuPYE7FGIFXCg9b6MEOALqyYdwkzZZHfduOM
         3XGW39ddk8ldRQNFQJz3yNQrsPofv2ruuBAJt2tgU8+lCWVKjrit9Sew9CH5YYhGzCz4
         ofZU0DozWm3mkJSueSfEjOdmibK2oretPgG0wAu6xBHDsI3mK+uS+UJIB62BC/j/8KlY
         zF4g==
X-Gm-Message-State: AO0yUKXTqLTkzhZT5oJ6QRl1j7VHXmHPj16W9n4iwa2uglNYgFdix67x
        GCc++J7Gzj60MACyl7Htq4Ymvp4ZsMYQcx81S5c=
X-Google-Smtp-Source: AK7set/oCOy3yOookh9Pv+mYKU9tKB4xqe73VFecMHnsR39xC93Ftkqk+U7IUkmAnouQMWc1/qsU77Gsu/G15zFYjJA=
X-Received: by 2002:a17:906:6083:b0:919:2e39:95e5 with SMTP id
 t3-20020a170906608300b009192e3995e5mr9803205ejj.6.1678737865203; Mon, 13 Mar
 2023 13:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr> <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr> <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr> <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
 <0450e34e-7190-104c-832a-150f15f7c825@free.fr> <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
 <eecb86be-81e3-09cd-8ec7-4e77c42f2795@free.fr>
In-Reply-To: <eecb86be-81e3-09cd-8ec7-4e77c42f2795@free.fr>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 13 Mar 2023 21:04:14 +0100
Message-ID: <CAFBinCDHRhLSyFsEv7cdhSgZorj-TdR3HhqSBnAQcUtEsecV=Q@mail.gmail.com>
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Marc,

On Mon, Mar 13, 2023 at 6:09=E2=80=AFPM Marc Gonzalez <marc.w.gonzalez@free=
.fr> wrote:
[...]
> > Wrapping mmc_send_io_op_cond() in a loop
> > makes it work on the second try.
>
> Almost there, I think, I hope :)
>
> DT prop "post-power-on-delay-ms" looks like what I needed all along.
> It exists both for host (default 10 ms) and for pwrseq_simple (default 0 =
apparently).
I think you're on the right track here!

[...]
> QUESTION:
> It's not clear to me why we sleep twice for host->ios.power_delay_ms?
I'm not sure but I think host->ios.power_delay_ms is independent from
the post-power-on-delay-ms property of "mmc-pwrseq-simple".

> Looks like all I need is to add post-power-on-delay-ms =3D <100>; to
>
>         sdio_pwrseq: sdio-pwrseq {
>                 compatible =3D "mmc-pwrseq-simple";
>                 reset-gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
>                 clocks =3D <&wifi32k>;
>                 clock-names =3D "ext_clock";
>         };
I found the following code in the vendor RTL8822CS driver [0].
Simplified version:
    for (i =3D 0; i <=3D 50; i++) {
       msleep(10);
        if (sdhci_device_attached())
           break;
   }
(so a delay of up to 500ms)

Also I found this code [1] in the same repo:
    mmc_pm_gpio_ctrl("rtl8189es_vdd_en", 1);
    udelay(100);
    mmc_pm_gpio_ctrl("rtl8189es_vcc_en", 1);
    udelay(50);

So like I said above: I think you're going in the right direction!


Best regards,
Martin


[0] https://github.com/chewitt/RTL8822CS/blob/main/platform/platform_sprd_s=
dio.c#L55-L62
[1] https://github.com/chewitt/RTL8822CS/blob/main/platform/platform_ARM_SU=
NxI_sdio.c#L35-L43
