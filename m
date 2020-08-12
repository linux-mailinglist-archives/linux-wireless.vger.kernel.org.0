Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78F242B52
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHLOWv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHLOWv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 10:22:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA379C061383
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 07:22:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so2474965ljd.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6NnPKO1Zyy+hsOSrZ6mNNfXNuUzGpPAhHLCmOtsB8Ng=;
        b=bOVVDnc9r3uKKpt+UjP2T4E57Tnvx6fiIAOJdTtlXW1sCZ3RsljZ5rsX/zwYsx3DK+
         8KDKwJ6CJtQ+VLoEfC4qwgyUrAz7Rgt3kINM0QPMLd8CNljS/yrSr4WtyYh/oUIWTWcY
         yfdx4U+IlJYKB5WbvndljGjIFQZuh0gznYi6BqwpxBc7XYtkjejO2Zx+bclLVmTjgZNT
         6C6hkCPt1Z0U3rzrf5T1HCsOy07MsKSj6muIiBDxPv6n/6I1vD+Tg+XvqoyF9fou6yH4
         o08nTQJxDptE0Np568fuXnJYCLZUPUNnMyZj75jKl4WlIIYgmH508QJmph/LofCugdKj
         UIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6NnPKO1Zyy+hsOSrZ6mNNfXNuUzGpPAhHLCmOtsB8Ng=;
        b=MjNjc//LXdvI1vqfiU6zKpol2k1f5DgTLS92d8RWBEl/RtupQfbk9/zTplvwsRw7vL
         4Z02fidv5NmGu2F0BmllpYftUbIr43TxU2FgjeH5zUtD15YQopuFzhyGJ4qsLNSlXrtF
         Ca0MNvGduv8NI2M0+RkYBhbsR+a38xp77TgPB/DqIPLiEHCMT4vOhEsH+Ua4TvvRy9xj
         wCJF5T9l/FaedNsC7yLkc0QvNnvo47xYQc2MsHPJyUeqeYntlfO7gHWVYqd+SOH+iYuU
         6vxtT0+M1iOM8EexDABythLk5bWivFCVQ138yVVDpm/A+ZXfEAneXskOSgzaVyAd1jzD
         lu2A==
X-Gm-Message-State: AOAM533YjxOi8QV34CtMbkjOBwh+xMAUfQPYaCmFhwkZU2fNDZ9jOist
        JfarKhNeL594mg9xvvQ+L+Y8wXxV
X-Google-Smtp-Source: ABdhPJwBkdmjqlKtSjfR4idM5ipnfFQ3ddzHagE+QxnN0XB96kq9zFMP8CEEY3jcArjtete4yvSkWw==
X-Received: by 2002:a2e:9617:: with SMTP id v23mr5736552ljh.365.1597242169157;
        Wed, 12 Aug 2020 07:22:49 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id i11sm505269lfl.31.2020.08.12.07.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 07:22:48 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control
 path
To:     Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
 <20200610152106.175257-4-chi-hsien.lin@cypress.com>
 <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com>
 <875z9yr7lg.fsf@codeaurora.org>
 <ffcf55cc-b27d-78ec-ff4f-e7efa3087712@gmail.com>
 <87a6zapbqp.fsf@codeaurora.org>
 <0923f45f-03e3-a870-3d2a-35f982482e1a@cypress.com>
 <bed18d45-6119-53da-2b9c-d98d121c8298@gmail.com>
 <a7aaf6ac-d6df-ab57-4939-474b542f007c@cypress.com>
 <112956e1-df38-0a35-c2f0-8d9e1568d3c5@gmail.com>
 <725e7a73-6cbf-227e-58ea-2457179a5063@cypress.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <df1c734c-ef7c-19ae-fad0-a5db148e5220@gmail.com>
Date:   Wed, 12 Aug 2020 17:22:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <725e7a73-6cbf-227e-58ea-2457179a5063@cypress.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

12.08.2020 07:03, Wright Feng пишет:
...
> Hi Dmitry,
> 
> The last time the drivers I used is v5.4 and I was not able to see low
> throughput issue as you saw.
> At this time, I changed the base to tag wt-2020-0727 and I am able to
> reproduce the issue as you did.
> TX throughput with wt-2020-07-27 FMAC is 190 Kbits/sec
> 
> 
> The root cause should be that tx_max and tx_seq are circle positive
> numbers, it should not use ">" to check if it still exists available TX
> credit.
> With the solution below, I am able to get the normal throughput.
> TX throughput with wt-2020-07-27+patch FMAC is 40.0 Mbits/sec
> 
> Regarding another case about 40Mbit/s, I am using 4329b0(4329/2) chip to
> verify the throughput because we are not able to find 4329b1(4329/3)
> which is very old product around 10 years ago.
> The firmware I am using is the same version but the build is for 4329b0.
> (private internal build - 4.220.48). My host platform is x86_64 with 4
> cores on Linux kernel 4.12. I will try your NVRAM when I have time to
> see if I can find anything.
> 
> ---
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index e8712ad..50c8107 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -664,9 +664,14 @@ static void pkt_align(struct sk_buff *p, int len,
> int align)
>  /* To check if there's window offered */
>  static bool data_ok(struct brcmf_sdio *bus)
>  {
> -    /* Reserve TXCTL_CREDITS credits for txctl */
> -    return (bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
> -           ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
> +    u8 tx_rsv = 0;
> +
> +    /* Reserve TXCTL_CREDITS credits for txctl when it is ready to send */
> +    if (bus->ctrl_frame_stat)
> +        tx_rsv = TXCTL_CREDITS;
> +
> +    return (bus->tx_max - bus->tx_seq - tx_rsv) != 0 &&
> +           ((bus->tx_max - bus->tx_seq - tx_rsv) & 0x80) == 0;
>  }
> 
>  /* To check if there's window offered */
> ---

Wright, thank you very much for the patch! It fixes the problem!

Tested-by: Dmitry Osipenko <digetx@gmail.com>

The 4329/3 is indeed an older chip, but it's also an "old" device (Acer
A500 tablet from 2011/12) that I'm using. Upstream v5.9 kernel just got
support for the A500. There are quite a lot of other older devices with
4329/3 in a wild that are still very usable if user can wipe off ancient
Android and put a modern Linux distro on them. Today that A500 tablet is
still rocking hard running a modern upstream kernel, opensource drivers
and KDE Plasma 5. The 15Mbit is a good enough speed for a lot of things,
but of course 40Mbit will be better. Would be great if you could try to
help with improving the speed :) Please feel free to contact me at any
time if you'll have patches to try!
