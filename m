Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F0E4F5DA1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 14:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiDFMBV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 08:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiDFMBK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 08:01:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA7653D7D3
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 00:37:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so1874267pjy.5
        for <linux-wireless@vger.kernel.org>; Wed, 06 Apr 2022 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l65YhfnHNiuRQvPfyLULCDuZuVqbWmQdpnQ3LUx3xMY=;
        b=bKhQpNUy8jH9hjvXpq0ZEPbobGkkXhD42iq2mBHOxLQav1GJjyL2HGDgJkwXExAm1D
         ty0EZd2ckRHMR8qzyJVovjb00L5nPj3THLyksMXsDw+412ilM3cysOqWACKuFEGXpQRh
         l9lFFku7r/nlkrZJsWQTO9Jo+nVhz+HpuSxlWbtvjMe5NCE9nyVncVo1TsToOmW6Dwhn
         HRSgf6ckuj7dgqY3YYx/eqixL90E12hgDRbnbNOB3xp7noI7qUEExfxQtnlygjix+oW1
         mH5mw2UrhsjKNjs+h8+z7JSe0uGFl0OBrT+7EojNC09hvdGlgEP7Bia4vFSazKqOiE7O
         D9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l65YhfnHNiuRQvPfyLULCDuZuVqbWmQdpnQ3LUx3xMY=;
        b=Vl4f1ETBtMfY/6L4fGuvimHUnSPEQ1DLx8wgIlIVNiYEDZcP8kLOUqRVDJNeb9ypWn
         Df24+j/xygfhphUzFb4hMY/kHHaY1lswGgFeXqneGfZ6Eq/Eo64JjZAdVt65rdFoCxyf
         KLgTvWRJ7PLnadSxdKkzJd9gSeUCTgvRn42trUVs+BSlUfuX7I0hXQz7wq3azjpNiiVA
         zt/yG8mQ7ZLFxCr/d6umnmvS1KpFtodFrEOWl1MTaWGxLS241JjIYnqpqKxKEyXvW0Do
         RYnfu4gu4rGNK2Y90Et/TE3loqv4FJgKTMYZTDMeb01py/vPgUT57jUBzJoavqLU9GHG
         ky+Q==
X-Gm-Message-State: AOAM532Bd8JR0gFHx9JCjAR87coC5tAV+S2uOqnL/96yubLpUFeqBxqc
        mfwWM3iaDjqdoxcCotSLGZyjOjSbLZwkJQgc2O2xO6c1
X-Google-Smtp-Source: ABdhPJydd3cH/DNQxlcUrR/ItI6gYfO1vjG/vlg+S0M4ZIIJhS382S4OJ/cp853LNnK6Bk2l49Tmerj0msOmXDoTO+I=
X-Received: by 2002:a17:902:c745:b0:151:e8fa:629b with SMTP id
 q5-20020a170902c74500b00151e8fa629bmr7523294plq.90.1649230652768; Wed, 06 Apr
 2022 00:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAA=hcWQFNOeycXFPhrtHcQG3V8fWSShNRuAi49jtv8h1fPVUuQ@mail.gmail.com>
 <8ef5d73a-6293-a6c5-6bbb-b130266a8f0b@broadcom.com>
In-Reply-To: <8ef5d73a-6293-a6c5-6bbb-b130266a8f0b@broadcom.com>
From:   Jupiter <jupiter.hce@gmail.com>
Date:   Wed, 6 Apr 2022 17:36:55 +1000
Message-ID: <CAA=hcWQ_FVTVfRe91z1yHXMBLkkhi0eTq-9Lw3Tg=X6OS5Ku-Q@mail.gmail.com>
Subject: Re: Support for bcm43364 wireless chipset in brcm80211/brcmfmac
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sean Lanigan <sean@lano.id.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

Thanks for your response.

>> Our design criteria is that it must be supported by mainline Linux.
>> Searching kernel log file to find that you added bcm43364 wireless
>> chipset to broadcom/brcm80211/brcmfmac driver, could you please advise
>> how stable and reliable to run brcm80211/brcmfmac for CYW43364 /
>> Broadcom BCM43364 Chipset?
>
> Is Murata providing you with firmware or just the hardware.

Good question, we'll buy Murata hardware and we'll use Murata firmware
in linux-firmware so we can run Yocto to build WiFi to the image using
mainline Linux, linux-firmware and other open sources.

I've just checked the firmware, there is no bcm43364 binary in
linux-firmware, only bcm43362 links to cyfmac43362-sdio.bin, is the
cyfmac43362-sdio.bin the right firmware for Murata WiFi module
LBWA1KL1FX (CYW43364 / BCM43364 Chipset)? If not, where is the right
Murata WiFi module LBWA1KL1FX firmware in linux-firmware?

The Broadcom did very good job to support mainline Linux, Cypress
acquired Broadcom wireless IoT, Infineon acquired Cypress wireless,
has anyone known if the Infineon is committed to continually maintain
and support CYW43364 / BCM43364 Chipset driver and firmware in
mainline Linux and linux-firmware?

There is a wired backward tendency in recent years, large vendors
acquired wireless sectors then stopped supporting open source and
mainline Linux, switched its wireless sources to use its proprietary
Linux and SDK. Our original design was using Marvell Avastar 88W8801
chipset, the driver mwifiex and wifiex_sdio worked well for kernel 4,
but after NXP acquired Marvell wireless sector, NXP stopped supporting
mainline Linux, the kernel 5 mwifiex cannot communicate to 88W8801
chipset firmware, we were told to use the proprietary Linux driver
sources which is incompatible to our Yocto / OE build system, we have
no choice but to change the WiFi module.

>> In addition to add CONFIG_BRCMFMAC and CONFIG_BRCMFMAC_SDIO, should I
>> also add   CONFIG_BRCMFMAC_PROTO_MSGBUF, CONFIG_DMI,
>> CONFIG_BRCMFMAC_PROTO_BCDC and CONFIG_OF?
>
> I would suggest using menuconfig as it already answers some if not all
> of these. CONFIG_DMI and CONFIG_OF are really depending on your platform.

We'll certainly use the menuconfig that is not the issue, our CPU is
iMX6ULZ running on kernel 5.10, apologize we are not familiar with the
CONFIG_DMI and CONFIG_OF, appreciate your advice.

Thank you very much.

Kind regards,

Jupiter
