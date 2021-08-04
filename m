Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E403DFE12
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhHDJfx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbhHDJfx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 05:35:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9DBC0613D5
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 02:35:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n17so697583lft.13
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00MkoO9yRS4eem+IKwQx2itkmAvUEX+DZFvq8lwGwxg=;
        b=JJ6iqfFnC8PRALywPvc9JXeiyJieXXpAcIQX/xIoSzw1El/pMNU5Kyw2C+j1vfyunL
         lcv/5b1C2guMIzq+Mz6CidieA7Y3IBqwlwwOZv/H801lGiAFdV0y0k3T5DnRlV3feFHJ
         EZTsez8JFumIL7efx0WWrtjX1DzWwD5+dW6gmtusJhOUShxqn9KuWmFVmcL8Pvs9AbK1
         viFuw0z7NhcMQhxNqtWCbKDsu9tpdMLeQGVt454Zq2PGcxBBBnVSSj9Om6M+DhNq75m6
         RWkYFf/MkMkVdfh6b3wz5xK7tvCystzDpJvgKVx/F86vniGBFjU9Clrp3rlH/GkTr8tg
         93Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00MkoO9yRS4eem+IKwQx2itkmAvUEX+DZFvq8lwGwxg=;
        b=AMacQKiZljua5uE1rEeL92IHNYd4RSSjBQpgXxh95Er4GEb+yUoApfkmdGIOhRRTLu
         BVU9ftOgdE46zvy5VhuQ/5eu9CMb0DoT+b8ZEm7pjR92zurEuLAwXt/GEtZhU2V1sIce
         nsZ94DZ9hvnkq02+hrxdXmAVhVZwUVutgSGQsuv6Dvt1Mio7vomGdMg9DSTjtpEnutTH
         4m8t665bZm15taQ4MirlrBwdd56G8k1h5zjEuavxqJ6GW0QL9cne19gNlGYyxxsO0PHH
         cZhGMbeho6nOynlZSOvpPDPPjS6HQWRk/QW45gyaEQx+SzYviJMnXQtA6RJOWIlRgpOz
         J/lQ==
X-Gm-Message-State: AOAM532vQQJSHLk/hZJiwdCR7S+TzuGme07fILvWxM8PDBpcAfp6sAti
        9omVipJIYWmc4LY4aTpruOIj3w7fUvIHl0p4a1xQCA==
X-Google-Smtp-Source: ABdhPJx/JbXmfpr+me3OYu9ZzumS+j2Lz4ayk9+WNDRUJJInjQtWNkZiM7dIMz3d3Zc4b923vzcM6SbGVMm9EmnkekE=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr18874178lff.465.1628069737994;
 Wed, 04 Aug 2021 02:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210711231659.255479-1-linus.walleij@linaro.org>
 <fca09928-72a8-a573-a862-7c486a2094d6@gmail.com> <02415358-6635-a974-7682-a721912ca4fc@gmail.com>
 <a2ee7f03-879e-543f-fbaf-06a58e416e9d@broadcom.com>
In-Reply-To: <a2ee7f03-879e-543f-fbaf-06a58e416e9d@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Aug 2021 11:35:26 +0200
Message-ID: <CACRpkdYSXmPO0zGfFbmg3dHrv30sTzQcaGW-vbVV+L1NNS3MqA@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: firmware: Allow per-board firmware binaries
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, phone-devel@vger.kernel.org,
        newbyte@disroot.org, Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 4, 2021 at 10:48 AM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:

> Right. I didn't get to looking at this earlier, but indeed the check
> whether the requested firmware exists is done in another thread context
> so the return value here only indicates whether the firmware request
> could be scheduled or not.

I think my recent patch fixes is, please have a look.

> My first reaction to the patch was to reject it, but leaning towards
> supporting this now. OEMs tend to get tailor-made firmware in terms of
> features. Depending on their requirements they get their mix of firmware
> features. That such difference lead to a crash in 3d engine is somewhat
> surprising. I am curious if we can debug this more and learn how a
> firmware variant could cause such a crash. Maybe some DMA issue?

I am not certain what happens, but I think the 3D engine misses its
interrupts. This may in turn be because GPIO IRQs are held
low or fireing repeatedly for an extensive period of time, stressing
the system to the point that other important IRQs are missed.

This in turn can be caused by the wrong (non-custom) firmware
managing these GPIO IRQs fireing left and right.

I have noticed that the config files for brcmfmac contain words
about GPIOs and so on and that is what makes me think this way.

I can tell for sure that brcmfmac has definately had special
firmware tailored by/for Samsung for these phones. We can just
look at the files extracted from the platforms (the original
files are named bcmdhd_sta.bin_b2 or similar):

BRCMFMAC 4330
-rw-r--r--. 1 linus linus 213390 Mar 22 23:32
brcmfmac4330-sdio.samsung,janice.bin
-rw-r--r--. 1 linus linus 203593 Jul 11 01:53
brcmfmac4330-sdio.samsung,codina.bin
-rw-r--r--. 1 linus linus 212956 Mar 22 23:31
brcmfmac4330-sdio.samsung,gavini.bin

BRCMFMAC 4334
-rw-r--r--. 1 linus linus 346151 Mar 16 22:53
brcmfmac4334-sdio.samsung,golden.bin
-rw-r--r--. 1 linus linus 434236 Jul  7 00:43 brcmfmac4334-sdio.samsung,kyle.bin
-rw-r--r--. 1 linus linus 434236 Mar 16 22:54
brcmfmac4334-sdio.samsung,skomer.bin

All different file sizes, except Kyle and Skomer, who actually share
the same firmware. (Those were the two last phones produced
in this series BTW.) Doing strings * on each file reveals that they
were compiled at different dates around the time these phones
were produced.

These are all for standard WiFi functionality. There is two more
firmwares for each phone, one for the access point usecase and
one more which I don't know what it is for, the actual set of firmware
for each phone is for example (Skomer):

bcmdhd_apsta.bin_b2
bcmdhd_mfg.bin_b2
bcmdhd_p2p.bin_b2
bcmdhd_sta.bin_b2

So I am half-guessing that bcmdhd_sta.bin_b2 is obviously for the
ordinary use case, *mfg* is probably for manufacturing, *apsta*
for mobile hotspot (access point) and *p2p* for some other cool
thing where phones do peer-to-peer.

If you could shed some light on the above it'd be great :)

Yours,
Linus Walleij
