Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0D4459B47
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 05:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhKWEma (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 23:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKWEma (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 23:42:30 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACAFC061574;
        Mon, 22 Nov 2021 20:39:22 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id p37so41119134uae.8;
        Mon, 22 Nov 2021 20:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5GdoLpX4+wjTgePS+FUzB17W3Yjovzx0eFuCdj5KDA=;
        b=S1wJ2WPtsF+GwG8fgyIYpfJqmlsgjoL7lcKsHP5j/N4os2H6YV1r1+7VmRORm4yXul
         dmd8ulZXdWguy6sxt0xIGcSQe5oN/2Fmc9e85lG0YO6c6xmkFpnhKdl5yaAhYiJHRH+A
         poW1PilI8jMT2GSTTYzlzPh7H6qLdXUeo0DjMIWFmf4nGwsUhHb/BCTmfxhuwQtPph5t
         BFjDzmkKbVwUjHyPfgG4K2ywtUV0UZGapgmDU2bMkCCV/51HX8I1GyacRJwK7RdPUhVO
         46auYmGNeizpT5hcVREf7VURNo1ipueDtTXiW7YrinGhG4n2h7jhEBWlC6IdJM+8oe7e
         LC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5GdoLpX4+wjTgePS+FUzB17W3Yjovzx0eFuCdj5KDA=;
        b=QDpYXYd5439JTZMPlC7h07vAEeeKNCdJK2tiTkcwuH67E5m+HYWWWI+eEq4b4iEmOP
         FejRraDSmwKG2boFtbGRMBfJJzTabuAwLWxNSBDmO9+mac1XGFF1+PvKHq0yAn/8fdII
         za6B3rehB/bqe9n4J93QX4pi3mEuYZ3iRPB66jqzrfGPjdh/eek31EUvPfVai3K81td7
         TZxP/nKA3+ZhYdgwbq++zin4VgPkOUfsZIn+taeeFp73fq5TCNDGOgO4E1HY7185LUj9
         T+dW7ehvQ8thvPs0wUu4C/hUAIc0nADVBfkS4+n/VF+ZGddbFdl6aqKare3g0z4qHxDc
         sMxg==
X-Gm-Message-State: AOAM533cRKhBX4IdhJbYTY+5JH2GA/iv5MEhmu7pVQCApIwmv+FuBZ2H
        mXj8jssf4a+Ar+ISntXDbAw1xHnNWa+4R3RkIuw=
X-Google-Smtp-Source: ABdhPJxsOOl/7jciwGxrv5h/mSPJY2pkqJthOafpXIXJfb1GLJX8rLCmOQYn0XW+crCifn7vFG3S/t7PleZ1NksbQro=
X-Received: by 2002:ab0:5b5d:: with SMTP id v29mr4042891uae.110.1637642361774;
 Mon, 22 Nov 2021 20:39:21 -0800 (PST)
MIME-Version: 1.0
References: <CAA=hcWT_dmKU1Uj4YmJ_rxZ+HsCVOEYJLSH-h3B3qqNhC1xi-g@mail.gmail.com>
 <CAD=FV=V3n95DNXFd4mHpkAAKapCs5UWZXUkw=1vWpfn6oXfouA@mail.gmail.com> <CAA=hcWS91uL4kRK8r1uJ_2YLXi1ZuB067ACVPTDZKnF53jgrRQ@mail.gmail.com>
In-Reply-To: <CAA=hcWS91uL4kRK8r1uJ_2YLXi1ZuB067ACVPTDZKnF53jgrRQ@mail.gmail.com>
From:   Jupiter <jupiter.hce@gmail.com>
Date:   Tue, 23 Nov 2021 15:38:45 +1100
Message-ID: <CAA=hcWR+9rsoy-dCnpai+fw_+JcO6X6oMBNPHJGqpuRy8mJszw@mail.gmail.com>
Subject: Re: mwifiex reset buggy
To:     Doug Anderson <dianders@chromium.org>
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

Hi Doug,

I have updated the kernel to 5.10.59 which should be guaranteed to
include your reset patch.

But I could not connect to the WiFi.

#  ifconfig mlan0 up
[10262.988302] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
 (1) failed: -110
[10262.996049] mwifiex_sdio mmc0:0001:1: write CFG reg failed
[10263.007337] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
 (2) failed: -110
[10263.015299] mwifiex_sdio mmc0:0001:1: write CFG reg failed
[10263.021675] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
 (3) failed: -110
[10263.029839] mwifiex_sdio mmc0:0001:1: write CFG reg failed
[10263.035386] mwifiex_sdio mmc0:0001:1: DNLD_CMD: host to card failed

# echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset
[10517.451193] mwifiex_sdio mmc0:0001:1: Resetting per request
[10517.479235] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
 (1) failed: -110
[10517.490283] mwifiex_sdio mmc0:0001:1: write CFG reg failed
[10517.498995] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
 (2) failed: -110
[10517.509257] mwifiex_sdio mmc0:0001:1: write CFG reg failed
[10517.517649] mwifiex_sdio mmc0:0001:1: host_to_card, write iomem
 (3) failed: -110
[10517.527838] mwifiex_sdio mmc0:0001:1: write CFG reg failed
[10517.533765] mwifiex_sdio mmc0:0001:1: DNLD_CMD: host to card failed

[10529.871099] mwifiex_sdio mmc0:0001:1: cmd_wait_q terminated: -110
[10529.883401] mwifiex_sdio mmc0:0001:1: PREP_CMD: FW in reset state
[10529.890488] mwifiex_sdio mmc0:0001:1: deleting the crypto keys
[10529.896573] mwifiex_sdio mmc0:0001:1: PREP_CMD: FW in reset state
[10529.903316] mwifiex_sdio mmc0:0001:1: deleting the crypto keys

[10530.014334] mwifiex_sdio mmc0:0001:1: DNLD_CMD: host to card failed
[10530.049847] mwifiex_sdio mmc0:0001:1: info: shutdown mwifiex...
[10530.239910] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[10530.247919] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[10530.268721] mwifiex_sdio mmc0:0001:1: PREP_CMD: card is removed
[10531.665962] mwifiex_sdio mmc0:0001:1: info: FW download over, size
255988 bytes
[10531.911608] mwifiex_sdio mmc0:0001:1: WLAN FW is active
[10531.964352] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x242 error, result=0x2
[10531.971894] mwifiex_sdio mmc0:0001:1: mwifiex_process_cmdresp: cmd
0x242 failed during       initialization
[10532.125947] mwifiex_sdio mmc0:0001:1: info: MWIFIEX VERSION:
mwifiex 1.0 (14.68.36.p204)
[10532.134573] mwifiex_sdio mmc0:0001:1: driver_version = mwifiex 1.0
(14.68.36.p204)

Again, the /sys/kernel/debug/mwifiex/mlan0 is removed, it is
completely broken for both WiFi modem reset and
/sys/kernel/debug/mwifiex/mlan0/reset, let me know your advice to
debug it or modify mwifiex source files.

Thank you.

Kind regards,

- JH

On 11/20/21, Jupiter <jupiter.hce@gmail.com> wrote:
> Hi Doug,
>
> Thank you for your kindly response.
>
>> I think I blocked most of this stuff out of my mind and it's also been
>> over 2 years. ;-) ...but any chance that Bluetooth could somehow be
>> involved, too? I seem to remember that things got complicated because
>> we could have both functions going at once. I think I advocated for
>> keeping it simple and always doing a full unplug / replug of the card
>> to reset it, but from notes I guess upstream landed it so you need to
>> handle the two cases (just WiFi vs WiFi+BT) in totally different ways.
>
> I think the main issue is many of you tested the mwifiex reset on
> Marvell card (or BT?), unfortunately I am using uBlox Lily module
> which is a WiFi only no Bluetooth, it is a iMX6ULL custom design, MMC
> and SDIO are based on iMX6ULL EVK. I don't think anyone tested mwifiex
> reset on that card, to make it worse, I am new to mwifiex, I might be
> able to assist with debugging, but certainly not in the position to
> contribute to fixing it.
>
>> It looks like there's ongoing discussion going on in
>> https://issuetracker.google.com/172214846. Maybe something there would
>> be helpful?
>
> I am using mwifiex on kernel upstream v4.19.75, does that include your
> fix? Do you have a patch I can add to my Yocto build? Should I make
> comments to the discussion at
> https://issuetracker.google.com/172214846?
>
> Thank you very much Doug.
>
> - JH
>


--
"A man can fail many times, but he isn't a failure until he begins to
blame somebody else."
-- John Burroughs
