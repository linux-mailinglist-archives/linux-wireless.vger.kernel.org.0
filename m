Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2645785A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 22:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhKSVvr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 16:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhKSVvq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 16:51:46 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A028C061574
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 13:48:44 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id k21so14573461ioh.4
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 13:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0Jjnsc5W0ZRgdIM3rUP5BZ3A9WvESp7bI0/hjoIiwg=;
        b=X+O4nVgLAZEiY7jEpqEI502St8G7C+CedgFQ3icEgghqhzNYz+CxKcIq7ALipS52Vh
         Z+Jjce/vzPbJUMTPMD+abKsZZtLopXf/54eGX4IocOJH0dw/oXiEI0sjjcrnEUsAqGv2
         6Y+t6QKshVE9/w9XELwcZQQjmYySx6BxVhtrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0Jjnsc5W0ZRgdIM3rUP5BZ3A9WvESp7bI0/hjoIiwg=;
        b=DgBgxMNUIgJ352UxDJMzp6nWNFxnIqf/ZDrSXgzgUvA+uVlZjei2GzG2d+YUAC2Jr7
         nuEKUBM3i6L3OG5vPJhLTiwRfspYq56yFig6Lz4cYToNgtBnHTDhNyix3rWj1Vr+JiY0
         6vvjlnvYViuPrL/TR5/vn3CEHphQFid2cS6lNXtRIOfw9q3nTxhKr9m3UAIEjjJrUgHa
         Yw1m90/M/IWIHDHSbMsH43qWNrNbvwAW4S/YHd/ep3mKlj4cCEj6q3/GA+kM4mgColFr
         UJ/aWACByRjO02JYb96dvH/vYnUzGj8oH+7zXiQtUhjJl/C46jJr02GzRX8xQNo4xV53
         Eeuw==
X-Gm-Message-State: AOAM532O/3vzVuWpk9v5Ce1whEVSh0WwWRRboSYTDbg/vmHOGJqGrCpD
        csqmwMBuArM9rSOVMz9yorU0Q3aHEF2scg==
X-Google-Smtp-Source: ABdhPJxMwaxnxG9Caspff8QGf53BGjvsOmsYScfmxAteu38hzf4CL0q5x00z9O1JLNUC7BKow2Hh4w==
X-Received: by 2002:a05:6602:2d84:: with SMTP id k4mr7894431iow.168.1637358523678;
        Fri, 19 Nov 2021 13:48:43 -0800 (PST)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id p14sm497018iod.38.2021.11.19.13.48.43
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 13:48:43 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id s14so11562992ilv.10
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 13:48:43 -0800 (PST)
X-Received: by 2002:a05:6e02:18ce:: with SMTP id s14mr6796507ilu.142.1637358522720;
 Fri, 19 Nov 2021 13:48:42 -0800 (PST)
MIME-Version: 1.0
References: <CAA=hcWT_dmKU1Uj4YmJ_rxZ+HsCVOEYJLSH-h3B3qqNhC1xi-g@mail.gmail.com>
In-Reply-To: <CAA=hcWT_dmKU1Uj4YmJ_rxZ+HsCVOEYJLSH-h3B3qqNhC1xi-g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 Nov 2021 13:48:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V3n95DNXFd4mHpkAAKapCs5UWZXUkw=1vWpfn6oXfouA@mail.gmail.com>
Message-ID: <CAD=FV=V3n95DNXFd4mHpkAAKapCs5UWZXUkw=1vWpfn6oXfouA@mail.gmail.com>
Subject: Re: mwifiex reset buggy
To:     Jupiter <jupiter.hce@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Nov 19, 2021 at 1:36 PM Jupiter <jupiter.hce@gmail.com> wrote:
>
> Hi,
>
> After days debugging, enabled CONFIG_MMC_DEBUG=y, I suspect the
> mwifiex reset issue could still  be a mwifiex bug.
>
> I use firmware sd8801_uapsta.bin, it is able to connect to the WiFi
> network, but  reset either from WiFi modem or following command killed
> WiFi, disabled mwifiex and wiped off /sys/kernel/debug/mwifiex/mlan0:
>
> # echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset
>
> [  416.311114] mwifiex_sdio mmc0:0001:1: Resetting per request
> [  416.333491] mwifiex_sdio mmc0:0001:1: info: successfully
> disconnected from 34:08:04:12:b1:a2: reason code 3
> [  416.366368] mwifiex_sdio mmc0:0001:1: info: shutdown mwifiex...
> [  416.374812] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [  416.381431] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
> [  416.387455] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [  416.393423] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
> [  416.399401] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [  416.405364] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
> [  416.411332] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [  416.417410] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
> [  416.423293] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [  416.429349] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
> root@solar:~# [  416.546386] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [  416.583278] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
> [  416.888906] IPv6: ADDRCONF(NETDEV_UP): sit0: link is not ready
> [  416.894822] IPv6: ADDRCONF(NETDEV_UP): wwan0: link is not ready
> [  417.302781] mwifiex_sdio mmc0:0001:1: WLAN FW already running! Skip FW dnld
> [  417.310149] mwifiex_sdio mmc0:0001:1: WLAN FW is active
> [  427.490344] mwifiex_sdio mmc0:0001:1: mwifiex_cmd_timeout_func:
> Timeout cmd id = 0xa9, act = 0x0
> [  427.499732] mwifiex_sdio mmc0:0001:1: num_data_h2c_failure = 0
> [  427.505825] mwifiex_sdio mmc0:0001:1: num_cmd_h2c_failure = 0
> [  427.511751] mwifiex_sdio mmc0:0001:1: is_cmd_timedout = 1
> [  427.517216] mwifiex_sdio mmc0:0001:1: num_tx_timeout = 0
> [  427.522686] mwifiex_sdio mmc0:0001:1: last_cmd_index = 1
> [  427.528063] mwifiex_sdio mmc0:0001:1: last_cmd_id: 28 00 a9 00 07
> 01 07 01 24 00
> [  427.535612] mwifiex_sdio mmc0:0001:1: last_cmd_act: 13 00 00 00 00
> 00 00 00 34 08
> [  427.543248] mwifiex_sdio mmc0:0001:1: last_cmd_resp_index = 0
> [  427.549058] mwifiex_sdio mmc0:0001:1: last_cmd_resp_id: 28 80 07 81
> 07 81 07 81 24 80
> [  427.557033] mwifiex_sdio mmc0:0001:1: last_event_index = 3
> [  427.562670] mwifiex_sdio mmc0:0001:1: last_event: 0b 00 0a 00 0b 00
> 0a 00 0a 00
> [  427.570045] mwifiex_sdio mmc0:0001:1: data_sent=0 cmd_sent=0
> [  427.575852] mwifiex_sdio mmc0:0001:1: ps_mode=0 ps_state=0
> [  427.591087] mwifiex_sdio mmc0:0001:1: info: _mwifiex_fw_dpc:
> unregister device
>
> The /sys/kernel/debug/mwifiex/mlan0 was deleted:
>
> # ls /sys/kernel/debug/mwifiex/
>
> Looked at Douglas Anderson post "Fix Marvell WiFi reset by adding SDIO
> API to replug card"
> https://patchwork.kernel.org/project/linux-mmc/cover/20190716164209.62320-1-dianders@chromium.org/,
> I believe mwifiex should be able to replug card after reset, is it
> still buggy or is it the firmware sd8801_uapsta.bin problem?

I think I blocked most of this stuff out of my mind and it's also been
over 2 years. ;-) ...but any chance that Bluetooth could somehow be
involved, too? I seem to remember that things got complicated because
we could have both functions going at once. I think I advocated for
keeping it simple and always doing a full unplug / replug of the card
to reset it, but from notes I guess upstream landed it so you need to
handle the two cases (just WiFi vs WiFi+BT) in totally different ways.

It looks like there's ongoing discussion going on in
https://issuetracker.google.com/172214846. Maybe something there would
be helpful?

-Doug
