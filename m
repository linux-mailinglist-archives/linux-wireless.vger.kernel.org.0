Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F076B26E6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 15:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjCIO34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 09:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjCIO3v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 09:29:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC04BEA4
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 06:29:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so2178089pjg.4
        for <linux-wireless@vger.kernel.org>; Thu, 09 Mar 2023 06:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678372189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl8Ig/SoPa8kDLYKK3prG31XNLf3b2Jf0y8Fe1Nszhg=;
        b=KXzftEo97Ncd8U2Nct5HSClvktPm38x7Z0DV+cVzUHNw73Oj/0EOiNr76CnEirvHAg
         imhztQaPQu2bRpkHVVaHEfkORonqTJNfWRgkRrynJ4zy5RImnqcQ5y/UmUrGvMb9lTWP
         smiHrjGyyIxXJrWJbhDdJkOMi0CULLVvBvyrObU+Fw10W8HzBZWyhqQfvUAk2EXtLsH3
         P0LxupICPgo+Neqj0aKO1cG1+hMKptFBMR3EpkTsVlyMzxe1JPlqrsyQsZeD8OZ15K/9
         g2Aap7dLX1/eVBP8YAR6kAn9NygmzGrV4aeSJXS4UQIgjf2plFmO5wYoHDX8SHwjdfdQ
         Leww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bl8Ig/SoPa8kDLYKK3prG31XNLf3b2Jf0y8Fe1Nszhg=;
        b=V1PMwOBTmbt5gpRNvMZyD19SKoput1ckjkAHhQ7Sep+BAWvLjdhlUYbYFJ6QrfWjXY
         Vg6hQkfG6uk+1r/RaU4YYjlx08n5KCTBTfxcxmkkmhFJwunwuDnx2WIebVIfwugHYaYz
         wGSZq1YWk4AkN97fqmhCVsJ5ZSl7MsEbZq2j21XZLEKbjFVvMdX27uefLKAXOOmcjCXE
         UvVEYDSNxVZ/L7IlOSd83FRBrqNjubZ0naXNxSyDckWQx+6VpHxnGdtvrm5LGXGEJDO1
         vaDxyLhkaptOjUbIxuBOQYpXvhXZwlpOl/8kLQlK/MnNa0ysZP2dkZsc9s72TsUTxfIV
         T4Tw==
X-Gm-Message-State: AO0yUKXRJkCbZrzXULvVGfBiK1UElnEUwaSdgRFO4DlDJe8gzxFD6g2t
        A4qjzTmqWSfyznxTP//fOAUPvrou4NJSTgiqXsoiIw==
X-Google-Smtp-Source: AK7set+glvYNvDZxTUBfPhpgrApdWUfFFkXJTzZ2wmNX+EGwaR3PkxDslYM/tT+6TY505jyjk6efgubWdeulOyxI/k0=
X-Received: by 2002:a17:90a:ab06:b0:230:80d7:2158 with SMTP id
 m6-20020a17090aab0600b0023080d72158mr8365554pjq.4.1678372189413; Thu, 09 Mar
 2023 06:29:49 -0800 (PST)
MIME-Version: 1.0
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr> <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr> <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr>
In-Reply-To: <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 15:29:12 +0100
Message-ID: <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
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
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-wireless@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 9 Mar 2023 at 13:13, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 09/03/2023 11:16, Marc Gonzalez wrote:
>
> > On 06/03/2023 11:24, Marc Gonzalez wrote:
> >
> >> # cat /sys/bus/sdio/devices/mmc2:0001:1/uevent
> >> OF_NAME=wifi
> >> OF_FULLNAME=/soc/sd@ffe03000/wifi@1
> >> OF_COMPATIBLE_0=brcm,bcm4329-fmac
> >> OF_COMPATIBLE_N=1
> >> SDIO_CLASS=00
> >> SDIO_ID=02D0:AAE7
> >> SDIO_REVISION=0.0
> >> MODALIAS=sdio:c00v02D0dAAE7
> >>
> >> NB: 0xaae7 = 43751
> >
> > I have run into another issue.
> >
> > The WiFi device (and the mmc2 bus it sits on) don't show up at all
> > in the kernel log *unless* I add lots of debug output, such as with
> > #define DEBUG in drivers/base/dd.c
> >
> > I think this points to some kind of race condition?
> >
> > Neil suggested that maybe the host probes the mmc2 bus "too soon",
> > when the WiFi device is still powering up, which makes the entire
> > probe fail.

Ideally, the WiFi device/driver should not need to be initialized to
allow the SDIO card to be detected properly. Looks like there is
something fishy going on.

> >
> > This patch appears to solve the symptom:
> >
> > diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> > index 6e5ea0213b477..999b3843c0d0b 100644
> > --- a/drivers/mmc/host/meson-gx-mmc.c
> > +++ b/drivers/mmc/host/meson-gx-mmc.c
> > @@ -1400,7 +1400,7 @@ static struct platform_driver meson_mmc_driver = {
> >       .remove         = meson_mmc_remove,
> >       .driver         = {
> >               .name = DRIVER_NAME,
> > -             .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > +             .probe_type = PROBE_FORCE_SYNCHRONOUS,
> >               .of_match_table = meson_mmc_of_match,
> >       },
> >  };
> >
> > But this might just be delaying the probe enough for the device
> > to become ready?
>
> FWIW, the relevant device tree nodes are:
>
> /* decompiled DTS */
>
>                 sd@ffe03000 {
>                         compatible = "amlogic,meson-axg-mmc";
>                         reg = <0x0 0xffe03000 0x0 0x800>;
>                         interrupts = <0x0 0xbd 0x4>;
>                         status = "okay";
>                         clocks = <0x2 0x21 0x2 0x3c 0x2 0x2>;
>                         clock-names = "core", "clkin0", "clkin1";
>                         resets = <0x5 0x2c>;
>                         amlogic,dram-access-quirk;
>                         pinctrl-0 = <0x2c>;
>                         pinctrl-1 = <0x2d>;
>                         pinctrl-names = "default", "clk-gate";
>                         #address-cells = <0x1>;
>                         #size-cells = <0x0>;
>                         bus-width = <0x4>;
>                         cap-sd-highspeed;
>                         sd-uhs-sdr50;
>                         max-frequency = <0x5f5e100>;
>                         non-removable;
>                         disable-wp;
>                         keep-power-in-suspend;
>                         mmc-pwrseq = <0x2e>;
>                         vmmc-supply = <0x2b>;
>                         vqmmc-supply = <0x21>;
>
>                         wifi@1 {
>                                 reg = <0x1>;
>                                 compatible = "brcm,bcm4329-fmac";
>                         };
>                 };
>
>
> /* original DTS */
>
>                 sd_emmc_a: sd@ffe03000 {
>                         compatible = "amlogic,meson-axg-mmc";
>                         reg = <0x0 0xffe03000 0x0 0x800>;
>                         interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
>                         status = "disabled";
>                         clocks = <&clkc CLKID_SD_EMMC_A>,
>                                  <&clkc CLKID_SD_EMMC_A_CLK0>,
>                                  <&clkc CLKID_FCLK_DIV2>;
>                         clock-names = "core", "clkin0", "clkin1";
>                         resets = <&reset RESET_SD_EMMC_A>;
>                 };
>
> &sd_emmc_a {
>         status = "okay";
>         pinctrl-0 = <&sdio_pins>;
>         pinctrl-1 = <&sdio_clk_gate_pins>;
>         pinctrl-names = "default", "clk-gate";
>         #address-cells = <1>;
>         #size-cells = <0>;
>
>         bus-width = <4>;
>         cap-sd-highspeed;
>         sd-uhs-sdr50;
>         max-frequency = <100000000>;
>
>         non-removable;
>         disable-wp;
>
>         /* WiFi firmware requires power to be kept while in suspend */
>         keep-power-in-suspend;
>
>         mmc-pwrseq = <&sdio_pwrseq>;

This one is particularly interesting. Can you share the content of the
sdio_pwrseq node too?

>
>         vmmc-supply = <&vddao_3v3>;
>         vqmmc-supply = <&vddio_ao1v8>;
>
>         brcmf: wifi@1 {
>                 reg = <1>;
>                 compatible = "brcm,bcm4329-fmac";
>         };
> };
>
> With an asynchronous probe, meson_mmc_probe() always succeeds,
> yet the WiFi card is not detected later on, even if I sleep
> 1-2 seconds in meson_mmc_probe().
>
> [    0.879756] YO: meson_mmc_probe: ffe03000.sd
> [    0.914320] YO: meson_mmc_probe: ffe03000.sd ALL OK
> [    1.199170] YO: meson_mmc_probe: ffe07000.mmc
> [    1.232734] YO: meson_mmc_probe: ffe07000.mmc ALL OK

To narrow down the problem, I would start by preventing the WiFi
driver from being insmoded. To make sure it doesn't affect the SDIO
card detection process.

The point is, the SDIO card should be detected properly, no matter
whether there is a corresponding SDIO func driver (WiFi driver)
available for it. For a detected SDIO/eMMC/SD card, mmc_add_card()
prints a message about the card in the log during initialization. It
could look like the below print, for example:

"mmc2: new ultra high speed SDR104 SDIO card at address 0001".

>
> Confused again...
>
> Regards
>

Kind regards
Uffe
