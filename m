Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF626465847
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 22:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbhLAVWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 16:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344010AbhLAVWx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 16:22:53 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC0C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 13:19:31 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w22so32815599ioa.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVbfKm2smLVX7EsOzYxeqw8e6/GNH2NpDw3hCe87mYY=;
        b=XQT/dgOlrx3TkIkPBdmDKpck7E7VSu+Bm3t8Yst5lYwiMXxUbtCNQuvvKLMhVkOaDW
         tFC0kX2sduksceTOxQGW68MZj1pTqrebRH0KXG8On0lFVJ4udnX674SCbKnxA9iaDubt
         kun0e3brRxFqVY+UtJlcdrhWd9ETa0bBjRNdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVbfKm2smLVX7EsOzYxeqw8e6/GNH2NpDw3hCe87mYY=;
        b=1gmr7W5n4L6hpdOhndro6HT1d+1+QcgoA2Q50Z/u04Vl4Fu+q7hUPVPjcO7s5F0vhn
         kGt3ydwN9ldxh/5lWbVX1j/ICQSx9yERWBX3A22/Bw235Q5v6mp/2Cr7hkVETH3THr6X
         R0h9eywiXdjaJQ7RkZBqm6ExfkTiZ4JXdGTVXjnjRW2NO6VYk/l38ZpgQiKhMqCXyx87
         Rp29CD75ho9F9J2gJQu3rQrTkL4D9wDdpCgH07uV4KaB0n78EXweFi3RAWO9by7/drb7
         agbxCeJKrDzZTXfb4R0snyARlpLzCr5bRpuZ77GZ8lZICaPGfiUev7swtBcE2PKcyHbe
         jxfw==
X-Gm-Message-State: AOAM531aUO83NT08vSJmVI5PjWS0wcC1kSxQ3goP5EF9/3HQLTKoyAmQ
        kTFJ3dZhqaGxkUS2Z7PABEkorvZUIYVAzA==
X-Google-Smtp-Source: ABdhPJwLI9OX8ayBCkl+cUytf+k0FvQq/gVnqHqeYJ3iRI2bV1oyP2x9cbirrfOgz8ct40dEI8HRzA==
X-Received: by 2002:a05:6638:190f:: with SMTP id p15mr14274292jal.82.1638393570329;
        Wed, 01 Dec 2021 13:19:30 -0800 (PST)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id o22sm891123iow.52.2021.12.01.13.19.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:19:29 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id i9so26908048ilu.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 13:19:29 -0800 (PST)
X-Received: by 2002:a05:6e02:12ed:: with SMTP id l13mr10144997iln.165.1638393568924;
 Wed, 01 Dec 2021 13:19:28 -0800 (PST)
MIME-Version: 1.0
References: <CAA=hcWT_dmKU1Uj4YmJ_rxZ+HsCVOEYJLSH-h3B3qqNhC1xi-g@mail.gmail.com>
 <CAD=FV=V3n95DNXFd4mHpkAAKapCs5UWZXUkw=1vWpfn6oXfouA@mail.gmail.com>
 <CAA=hcWS91uL4kRK8r1uJ_2YLXi1ZuB067ACVPTDZKnF53jgrRQ@mail.gmail.com> <CAA=hcWR+9rsoy-dCnpai+fw_+JcO6X6oMBNPHJGqpuRy8mJszw@mail.gmail.com>
In-Reply-To: <CAA=hcWR+9rsoy-dCnpai+fw_+JcO6X6oMBNPHJGqpuRy8mJszw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Dec 2021 13:19:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XMR33LONcyuvfLzJNd7vKB7vmiE1VSC_QArXA+Hy4Nsw@mail.gmail.com>
Message-ID: <CAD=FV=XMR33LONcyuvfLzJNd7vKB7vmiE1VSC_QArXA+Hy4Nsw@mail.gmail.com>
Subject: Re: mwifiex reset buggy
To:     Jupiter <jupiter.hce@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Brian Norris <briannorris@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Nov 22, 2021 at 8:39 PM Jupiter <jupiter.hce@gmail.com> wrote:
>
> Hi Doug,
>
> I have updated the kernel to 5.10.59 which should be guaranteed to
> include your reset patch.
>
> But I could not connect to the WiFi.
>
> #  ifconfig mlan0 up
> [10262.988302] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
>  (1) failed: -110
> [10262.996049] mwifiex_sdio mmc0:0001:1: write CFG reg failed
> [10263.007337] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
>  (2) failed: -110
> [10263.015299] mwifiex_sdio mmc0:0001:1: write CFG reg failed
> [10263.021675] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
>  (3) failed: -110
> [10263.029839] mwifiex_sdio mmc0:0001:1: write CFG reg failed
> [10263.035386] mwifiex_sdio mmc0:0001:1: DNLD_CMD: host to card failed
>
> # echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset
> [10517.451193] mwifiex_sdio mmc0:0001:1: Resetting per request
> [10517.479235] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
>  (1) failed: -110
> [10517.490283] mwifiex_sdio mmc0:0001:1: write CFG reg failed
> [10517.498995] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
>  (2) failed: -110
> [10517.509257] mwifiex_sdio mmc0:0001:1: write CFG reg failed
> [10517.517649] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
>  (3) failed: -110
> [10517.527838] mwifiex_sdio mmc0:0001:1: write CFG reg failed
> [10517.533765] mwifiex_sdio mmc0:0001:1: DNLD_CMD: host to card failed
>
> [10529.871099] mwifiex_sdio mmc0:0001:1: cmd_wait_q terminated: -110
> [10529.883401] mwifiex_sdio mmc0:0001:1: PREP_CMD: FW in reset state
> [10529.890488] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
> [10529.896573] mwifiex_sdio mmc0:0001:1: PREP_CMD: FW in reset state
> [10529.903316] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
>
> [10530.014334] mwifiex_sdio mmc0:0001:1: DNLD_CMD: host to card failed
> [10530.049847] mwifiex_sdio mmc0:0001:1: info: shutdown mwifiex...
> [10530.239910] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [10530.247919] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [10530.268721] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [10531.665962] mwifiex_sdio mmc0:0001:1: info: FW download over, size
> 255988 bytes
> [10531.911608] mwifiex_sdio mmc0:0001:1: WLAN FW is active
> [10531.964352] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x242 error, result=0x2
> [10531.971894] mwifiex_sdio mmc0:0001:1: mwifiex_process_cmdresp: cmd
> 0x242 failed during       initialization
> [10532.125947] mwifiex_sdio mmc0:0001:1: info: MWIFIEX VERSION:
> mwifiex 1.0 (14.68.36.p204)
> [10532.134573] mwifiex_sdio mmc0:0001:1: driver_version = mwifiex 1.0
> (14.68.36.p204)
>
> Again, the /sys/kernel/debug/mwifiex/mlan0 is removed, it is
> completely broken for both WiFi modem reset and
> /sys/kernel/debug/mwifiex/mlan0/reset, let me know your advice to
> debug it or modify mwifiex source files.

Sorry, I think you're on your own here. I've only briefly touched upon
the Marvell reset code when I ran into trouble with it in the past but
it's definitely not something I have any real inside knowledge about.
My only suggestions would be to somehow get someone from Marvell (now
NXP I guess?) to help you debug or perhaps the people you got your
module from have some technical contacts that can help rope in someone
to help?

-Doug
