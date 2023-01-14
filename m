Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CFA66AB3C
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jan 2023 12:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjANLno (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Jan 2023 06:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjANLnn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Jan 2023 06:43:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D9318E
        for <linux-wireless@vger.kernel.org>; Sat, 14 Jan 2023 03:43:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x40so2521915lfu.12
        for <linux-wireless@vger.kernel.org>; Sat, 14 Jan 2023 03:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQBV0x8Awv9QJzZXjFNmumI1w+XNyeDc+588e/qdpro=;
        b=eIjglmPd96U+mMoED0db5M0qGkFCX0Yrk1LsVnbaWYMNJ5X5xZaUJZQezdg+raydcT
         c2ZW5h9W0HsINytuCVYn+znjbJ9S9b/SB9prWZqdzcYen2kaasUbREcL05gAUnC764dn
         RrbBiiNbf8l/XMiZ302JIGw2pIJ5mfl6RdS78+cLDlrFoW83YOMmcssBLMWuPBglykou
         G3Pmb4DM20x84qvzOtw7ttKF4jboo+J6MbfVSRj3TFoUFwtm4VbLUa+ng3bK2PuKR0Xs
         eu0qjAtqLWCHhOSl8vZrk57S6EVo+Nk7ggBdPjY2S7Sgg9DSsh9q8AMbWoMXCxhxuRF9
         cl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQBV0x8Awv9QJzZXjFNmumI1w+XNyeDc+588e/qdpro=;
        b=FMlkqUui15+PeVPShWpFAR9fXoX8hJ838rwZoD3Fd0CPXd763bl6wZC0RAuo/ZeAYh
         7bBGX6Tu8JBA7pRVJ3xSGeFPH3h3/UY8FrVvAWII76lHMiz1FvqR14Z2+jfo018XrPj2
         VAF3GJBMy2ii6udJ2m3ItPrQANQhWFBPvS8BeiRGEsw1Mmva67hEAKSAFarDnnGcNHHa
         0cQmnPOPWU2+ypCHuO4ojYEDj+cpIlvH7dHQ+CsQM8eq558bPdNaFlNsXg0Vt0n4UYhY
         EZ0Tv4nobRjzRI0dN+WDd9LNPGFTplI9T8NiDBr+w8hSHtfa9FXUKp39EqqNzIKUgiDG
         WH9Q==
X-Gm-Message-State: AFqh2kquZR2IIf2VnTtEynAesovgw/PoX3bsXXJg7652tlpM0gUlqqoh
        f1PeOrJiY5e8i/xV2UzAoU7Vkh21cz3Epl6/xvo=
X-Google-Smtp-Source: AMrXdXs4uq86oix8nUfD3UtWt7DiQZvfb9zUqeC8exrwbssmmTmbJ3Y+Oxik3q8LVQuBXnDpThZ9kxkRn60TXL3J9ss=
X-Received: by 2002:a05:6512:3d29:b0:4c4:dd2a:284f with SMTP id
 d41-20020a0565123d2900b004c4dd2a284fmr4918323lfv.440.1673696620565; Sat, 14
 Jan 2023 03:43:40 -0800 (PST)
MIME-Version: 1.0
References: <CY4PR1001MB237594C816BB0C957FC7CF9CC9C39@CY4PR1001MB2375.namprd10.prod.outlook.com>
In-Reply-To: <CY4PR1001MB237594C816BB0C957FC7CF9CC9C39@CY4PR1001MB2375.namprd10.prod.outlook.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 14 Jan 2023 12:43:03 +0100
Message-ID: <CA+icZUVyMQ89oxfvkmMNdhN_2BLgF2ZeKiBQx3gWxEJmXC13VQ@mail.gmail.com>
Subject: Re: Wireless 7260 on Debian 11
To:     Chris <powersurge69@hotmail.com>
Cc:     linuxwifi@intel.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Jan 14, 2023 at 6:41 AM Chris <powersurge69@hotmail.com> wrote:
>
> Hi,
>
> I just purchased a Dell Latitude 3340 on eBay and I tried installing
> Debian 11 on it but I am unable to get the wireless network to enable.
> The wireless was working perfectly in Windows 10. According to lshw the
> laptop uses a Wireless 7260. I first tried running 'apt install
> firmware-iwlwifi', but Network Manager just says that the wireless
> network is unavailable. I then tried downloading
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/iwlwifi-7260-17.ucode
> and copying it into the /lib/firmware folder, but that didn't work
> either. Is there anything else that I can try? Thank you in advance for
> your assistance.
>

What says dmesg - typed in a terminal?

Here on my Debian/unstable AMD64:

root# dmesg | egrep -i 'iwl|ucode|firmware'

[   54.675939] iwlwifi 0000:01:00.0: firmware: direct-loading firmware
iwlwifi-6000g2b-6.ucode
[   54.676668] iwlwifi 0000:01:00.0: loaded firmware version
18.168.6.1 6000g2b-6.ucode op_mode iwldvm
...
[   58.417970] iwlwifi 0000:01:00.0: Detected Intel(R) Centrino(R)
Advanced-N 6230 AGN, REV=0xB0

You need to install firmware-iwlwifi Debian package.

# dpkg -L firmware-iwlwifi | grep iwlwifi-72
/lib/firmware/iwlwifi-7260-17.ucode
/lib/firmware/iwlwifi-7265-17.ucode
/lib/firmware/iwlwifi-7265D-22.ucode
/lib/firmware/iwlwifi-7265D-29.ucode

Cannot say if the firmware-iwlwifi package ships the latest firmware
you need on Debian-11 for your wifi-card.

Here I have:

# dpkg -l | grep firmware-iwlwifi | awk '/^(ii|hi|rc)/ {print $1 " "
$2 " " $3}' | column -t
ii  firmware-iwlwifi  20221214-3

Hope that helps.

-Sedat-
