Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EEC373D90
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhEEOXj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 10:23:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55683 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhEEOXi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 10:23:38 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leIQD-00027b-8e
        for linux-wireless@vger.kernel.org; Wed, 05 May 2021 14:22:41 +0000
Received: by mail-qk1-f199.google.com with SMTP id g2-20020a37b6020000b02902ea40e87ecbso1223415qkf.14
        for <linux-wireless@vger.kernel.org>; Wed, 05 May 2021 07:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2p0gJ55l2BrIuGW3fGJbblLcGMFAVclXvZPsg/9734=;
        b=C1mDEUlbc2ROWyGEyRXcVc2ZUYrWVm635N9v9wlyITPd6PvTwyqu6zaoA3K4LEG1eE
         vbEb3MNfo3nehCJ77dQh59xA9XHe3ta0euC2eNL96Pci1XkBo8yFZpKw/Uijpc77ldXW
         Hd3Ki3l1dkdm4jfhhNA15cugwIW5dHC+vxlTKkPqH2UR1mXkJ0k+1bVnKDU578vwxQzL
         xmTuf9H4EAFgDFv1fQsAMTecQDjyIw2wBDnxUrwXCyRc2dXKTUMvx99I8EA3aqUnvwJk
         5pjLoiib4EQTSIb5WSA7swfQnKPqSgUiXU/66r+4qEqCe2pbk2bCkGmdZHxufV5TYhKm
         DpPw==
X-Gm-Message-State: AOAM532GhAJrDAA5IIjlXnhidofWIJhDvEdyyKhYn0ceyWS/ll2LQk65
        +iDoBmD8HoU4edL/Ro1qMkCrOZBR1t0qRgjFO6wZVDwOwQoTPiHlTKfEDgeocKuSPiGnyAzfhut
        +xi3tfnE6pOdpz/FQV4rgZyFCas1XBe3crftP4GARbVV9
X-Received: by 2002:a37:e11:: with SMTP id 17mr24576834qko.499.1620224560354;
        Wed, 05 May 2021 07:22:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpQ3TLPSdk4w5AAovg0o+kr9jYYchgdMLem+pb6Sh/mSEWGzgGWWL46ISf/llPTJXMza6lWw==
X-Received: by 2002:a37:e11:: with SMTP id 17mr24576805qko.499.1620224560113;
        Wed, 05 May 2021 07:22:40 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.1])
        by smtp.gmail.com with ESMTPSA id r16sm1041922qtx.36.2021.05.05.07.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 07:22:39 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: am5729-beagleboneai: drop unused Broadcom WiFi
 properties
To:     Robert Nelson <robertcnelson@gmail.com>,
        alexey.roslyakov@gmail.com, Drew Fustini <drew@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Cc:     =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux kernel <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
References: <20210505140015.60013-1-krzysztof.kozlowski@canonical.com>
 <CAOCHtYiicw5bqaZU5g2QGJHG3DZKRQUwAr08NZHw81S9=hmrgw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7ced6d2f-7107-e612-6787-63e38e5e3edd@canonical.com>
Date:   Wed, 5 May 2021 10:22:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAOCHtYiicw5bqaZU5g2QGJHG3DZKRQUwAr08NZHw81S9=hmrgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05/05/2021 10:15, Robert Nelson wrote:
> On Wed, May 5, 2021 at 9:04 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> The brcm,sd-head-align, brcm,sd_head_align and brcm,sd_sgentry_align are
>> not used by the driver and not present in dtschema:
>>
>>   arch/arm/boot/dts/am5729-beagleboneai.dt.yaml: wifi@1:
>>     'brcm,sd-head-align', 'brcm,sd_head_align', 'brcm,sd_sgentry_align' do not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  arch/arm/boot/dts/am5729-beagleboneai.dts | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/am5729-beagleboneai.dts b/arch/arm/boot/dts/am5729-beagleboneai.dts
>> index 149cfafb90bf..d3b2e87a6266 100644
>> --- a/arch/arm/boot/dts/am5729-beagleboneai.dts
>> +++ b/arch/arm/boot/dts/am5729-beagleboneai.dts
>> @@ -582,10 +582,6 @@ brcmf: wifi@1 {
>>                 reg = <1>;
>>                 compatible = "brcm,bcm4329-fmac";
>>
>> -               brcm,sd-head-align = <4>;
>> -               brcm,sd_head_align = <4>;
>> -               brcm,sd_sgentry_align = <512>;
>> -
>>                 interrupt-parent = <&gpio3>;
>>                 interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
>>                 interrupt-names = "host-wake";
>> --
>> 2.25.1
>>
> 
> NAK, for what it is worth..
> 
> This is a plain old shitty situation, that everyone that mistakenly
> chooses a BRCM based chipset in a design faces, then learns to NEVER
> touch that chipset again..
> 
> These nodes have been posted before for mainline inclusion but always
> get killed off:
> 
> https://lkml.org/lkml/2018/3/18/356
> 
> The TI AM57xx SDIO needs these flags for the brcmfmac driver to actually work.
> 
> I don't see the brcmfmac developers actually fixing it, as "out of
> tree" work for brcmfmac is 100+ patches long:


Thanks for explanation. I understand these are actually used by
out-of-tree driver? That's a valid reason to add them to the binding then...

> 
> https://www.cypress.com/documentation/software-and-drivers-archive/wifi-bt-linux-archive?source=search&cat=other

Requires login - I am not able to get the sources.

Best regards,
Krzysztof
