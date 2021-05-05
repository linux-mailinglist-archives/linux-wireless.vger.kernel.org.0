Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B333373D6E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 16:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhEEOQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 10:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhEEOQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 10:16:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20160C061574;
        Wed,  5 May 2021 07:15:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s6so2208141edu.10;
        Wed, 05 May 2021 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3v7GTLBkveSO/DzoiCusnfOSBV5pZgN/EggynLGhcDk=;
        b=lAGpv2W44mI+TklKu4AxJth+nxdI1zLFE3VGWqnF/G9fjl/zDe0k8uRBtfbeZvoh5+
         lALa8zlEYb3WuFMcnSqH6DMY4oiNHMfELjk8ZhLLYiPghszGyjH0JRWGxjpM0NcZBxqi
         txF7ZPsRh4CUZcW/EAjdewDwiCtYFgKSU95esRYrAxj8a6j9VFpm5nr2W7etmzfv2Nzw
         ZFtWCWfsr42N8vLdXztyX9300NLvihqD0BEwszdaRLypgP+cSAxhkiwIhgsxW3gVAinS
         7zcCqk/FabDBOmcrFTWPyckWcW5zhwV9R9vHFYXQTO4ZQx9Yjtgk+PBnhKgcGd0FCWWH
         DwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3v7GTLBkveSO/DzoiCusnfOSBV5pZgN/EggynLGhcDk=;
        b=E8dHNGx/YQtV3km8Hbje3XMxf8SpbFHkhvpHfQSW5Rm/3QqGZ3cZ+jGxuccFFdxukY
         1+Jv+lnLnsiz3xxl/AKfkS2WvDzo4Tx5wdN0QD61YT9UbfggbfGfh3IKMTwZOlx4Zp6a
         UtzqcGrFipT29gRW+IHO+HXI3k/4FOwLim/M3uN6r2FbK3GoRGE+w5uGOqBYOn4mnnvM
         AsJfwp/Hho0DPapHrgNICNThdJK8j5D9xxv+IUdBVPvvvO2guU+Rc1yVp3XzawB822xG
         YEPBXvrnxed45srW5A7eqTK+4EgalQ09cosWt6wrkvh8cQ5ztrvH2WKUH8DexRr6i81N
         b45g==
X-Gm-Message-State: AOAM5302Lcz4gXk0KI5SFf7hiDamOdU6pFJbS8Zh+wnA/n1t4pT6B5Un
        IvhfXcRsr73BtbYq5kAEGKV8ORylnyxN7q7tSyQ=
X-Google-Smtp-Source: ABdhPJzEQodWMVV/muUqtH9tMV4QSj1AoLg7azHYsXTWphHaRCJmi8DokE3iUNcJHJkKPvsg9oIvRAvfgeQcn39I924=
X-Received: by 2002:aa7:cf12:: with SMTP id a18mr32562378edy.160.1620224130659;
 Wed, 05 May 2021 07:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210505140015.60013-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210505140015.60013-1-krzysztof.kozlowski@canonical.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Wed, 5 May 2021 09:15:04 -0500
Message-ID: <CAOCHtYiicw5bqaZU5g2QGJHG3DZKRQUwAr08NZHw81S9=hmrgw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: am5729-beagleboneai: drop unused Broadcom WiFi properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        alexey.roslyakov@gmail.com, Drew Fustini <drew@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux kernel <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 5, 2021 at 9:04 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The brcm,sd-head-align, brcm,sd_head_align and brcm,sd_sgentry_align are
> not used by the driver and not present in dtschema:
>
>   arch/arm/boot/dts/am5729-beagleboneai.dt.yaml: wifi@1:
>     'brcm,sd-head-align', 'brcm,sd_head_align', 'brcm,sd_sgentry_align' do not match any of the regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm/boot/dts/am5729-beagleboneai.dts | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am5729-beagleboneai.dts b/arch/arm/boot/dts/am5729-beagleboneai.dts
> index 149cfafb90bf..d3b2e87a6266 100644
> --- a/arch/arm/boot/dts/am5729-beagleboneai.dts
> +++ b/arch/arm/boot/dts/am5729-beagleboneai.dts
> @@ -582,10 +582,6 @@ brcmf: wifi@1 {
>                 reg = <1>;
>                 compatible = "brcm,bcm4329-fmac";
>
> -               brcm,sd-head-align = <4>;
> -               brcm,sd_head_align = <4>;
> -               brcm,sd_sgentry_align = <512>;
> -
>                 interrupt-parent = <&gpio3>;
>                 interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
>                 interrupt-names = "host-wake";
> --
> 2.25.1
>

NAK, for what it is worth..

This is a plain old shitty situation, that everyone that mistakenly
chooses a BRCM based chipset in a design faces, then learns to NEVER
touch that chipset again..

These nodes have been posted before for mainline inclusion but always
get killed off:

https://lkml.org/lkml/2018/3/18/356

The TI AM57xx SDIO needs these flags for the brcmfmac driver to actually work.

I don't see the brcmfmac developers actually fixing it, as "out of
tree" work for brcmfmac is 100+ patches long:

https://www.cypress.com/documentation/software-and-drivers-archive/wifi-bt-linux-archive?source=search&cat=other

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
