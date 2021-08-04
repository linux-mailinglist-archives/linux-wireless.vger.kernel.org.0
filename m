Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007093E0035
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbhHDLcr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 07:32:47 -0400
Received: from lpdvsmtp10.broadcom.com ([192.19.11.229]:56564 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232885AbhHDLcq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 07:32:46 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EA1B62E22D;
        Wed,  4 Aug 2021 04:32:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EA1B62E22D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1628076753;
        bh=zk83iXNpbo+buzqPU3gpG1XVe6m+R78f04CnZJVATXE=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=SvvXF49IF2S3RjhuNg7T1s4JgIxbiQKstYZtxzaaHqBvGxVNC3JU9b5sMD/Ufvyg3
         eMU2bxEDjHWxi1mvqs1E8pKcK6DemcU1pZ/GcbHTTWlVYs6et+HNt2kHVwwcNjOWl0
         r2ii+pUSJWr5I90hCXFAPM79eGv8n8LG7Y52IkUE=
Received: from [10.230.42.155] (unknown [10.230.42.155])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id AEFEE1874BD;
        Wed,  4 Aug 2021 04:32:28 -0700 (PDT)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] brcmfmac: firmware: Allow per-board firmware binaries
To:     Linus Walleij <linus.walleij@linaro.org>
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
References: <20210711231659.255479-1-linus.walleij@linaro.org>
 <fca09928-72a8-a573-a862-7c486a2094d6@gmail.com>
 <02415358-6635-a974-7682-a721912ca4fc@gmail.com>
 <a2ee7f03-879e-543f-fbaf-06a58e416e9d@broadcom.com>
 <CACRpkdYSXmPO0zGfFbmg3dHrv30sTzQcaGW-vbVV+L1NNS3MqA@mail.gmail.com>
Message-ID: <dbdf5491-6365-4804-9719-e60d093a62f4@broadcom.com>
Date:   Wed, 4 Aug 2021 13:32:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYSXmPO0zGfFbmg3dHrv30sTzQcaGW-vbVV+L1NNS3MqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 04-08-2021 11:35, Linus Walleij wrote:
> On Wed, Aug 4, 2021 at 10:48 AM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>
>> Right. I didn't get to looking at this earlier, but indeed the check
>> whether the requested firmware exists is done in another thread context
>> so the return value here only indicates whether the firmware request
>> could be scheduled or not.
>
> I think my recent patch fixes is, please have a look.

Right. I want to explore another option for myself, but I will first 
look at your patch so we can fix the current issue in timely manner.

>> My first reaction to the patch was to reject it, but leaning towards
>> supporting this now. OEMs tend to get tailor-made firmware in terms of
>> features. Depending on their requirements they get their mix of firmware
>> features. That such difference lead to a crash in 3d engine is somewhat
>> surprising. I am curious if we can debug this more and learn how a
>> firmware variant could cause such a crash. Maybe some DMA issue?
>
> I am not certain what happens, but I think the 3D engine misses its
> interrupts. This may in turn be because GPIO IRQs are held
> low or fireing repeatedly for an extensive period of time, stressing
> the system to the point that other important IRQs are missed.
>
> This in turn can be caused by the wrong (non-custom) firmware
> managing these GPIO IRQs fireing left and right.
>
> I have noticed that the config files for brcmfmac contain words
> about GPIOs and so on and that is what makes me think this way.

Not sure what config files you refer to. I am only aware of the device 
tree bindings mentioning GPIO for out-of-band SDIO interrupt.

> I can tell for sure that brcmfmac has definately had special
> firmware tailored by/for Samsung for these phones. We can just
> look at the files extracted from the platforms (the original
> files are named bcmdhd_sta.bin_b2 or similar):
>
> BRCMFMAC 4330
> -rw-r--r--. 1 linus linus 213390 Mar 22 23:32
> brcmfmac4330-sdio.samsung,janice.bin
> -rw-r--r--. 1 linus linus 203593 Jul 11 01:53
> brcmfmac4330-sdio.samsung,codina.bin
> -rw-r--r--. 1 linus linus 212956 Mar 22 23:31
> brcmfmac4330-sdio.samsung,gavini.bin
>
> BRCMFMAC 4334
> -rw-r--r--. 1 linus linus 346151 Mar 16 22:53
> brcmfmac4334-sdio.samsung,golden.bin
> -rw-r--r--. 1 linus linus 434236 Jul  7 00:43 brcmfmac4334-sdio.samsung,kyle.bin
> -rw-r--r--. 1 linus linus 434236 Mar 16 22:54
> brcmfmac4334-sdio.samsung,skomer.bin
>
> All different file sizes, except Kyle and Skomer, who actually share
> the same firmware. (Those were the two last phones produced
> in this series BTW.) Doing strings * on each file reveals that they
> were compiled at different dates around the time these phones
> were produced.

As said earlier customers get their mix of firmware features. Apart from 
the compile date using strings will also give you the firmware compile 
target, ie. 4330*-roml/... Could you share that?

> These are all for standard WiFi functionality. There is two more
> firmwares for each phone, one for the access point usecase and
> one more which I don't know what it is for, the actual set of firmware
> for each phone is for example (Skomer):
>
> bcmdhd_apsta.bin_b2
> bcmdhd_mfg.bin_b2
> bcmdhd_p2p.bin_b2
> bcmdhd_sta.bin_b2
>
> So I am half-guessing that bcmdhd_sta.bin_b2 is obviously for the
> ordinary use case, *mfg* is probably for manufacturing, *apsta*
> for mobile hotspot (access point) and *p2p* for some other cool

Half-guessing seems sufficient ;-) If I recall correctly on Android the 
driver loads different firmware based on what a user selects in the gui. 
Not something we do in upstream linux. p2p is a WFA specification and 
supported in upstream linux cfg80211. Many TV sets support it to show 
content from your portable device.

Regards,
Arend

