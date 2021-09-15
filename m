Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E619840BC73
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 02:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhIOAFr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 20:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhIOAFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 20:05:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729EC061574
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 17:04:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so2161428lfu.5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 17:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rrb0i3CrOqHfXZi44d5xQhz/TU/wsHws6K9w0KwaZk4=;
        b=a5BTOa1TpN15iamVfg+z5MCp4yaNefjbXka6teLp6ZWJmCi6nHr6ipzy51PiNx/J9h
         ibLhy50bZZzDKvO5W3rbeHtyIBMQzFJFnj+vQxfllen/cWfrB6M9IY7Bly5EOWIMvFD/
         qKCVcXs5z/gkdjLtarXdkkftVVS82p+zXI//YrFwdaYtgHTYoXVCzd0IZ/5dHe9YtisT
         mtg+x4t9/LXGpbO8SycopNCgdOqLBsyst6cwVTab+l7ylPNkaOoO26YQvY487cOqurDy
         0XurbEqeqh+Zv/5an4aHJ0r2b1U7dV1PJgeSlIgf/vK96EcADqmNs1Potg6MhztFvUh1
         a+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rrb0i3CrOqHfXZi44d5xQhz/TU/wsHws6K9w0KwaZk4=;
        b=6PGUq0G+ZftUy0HcxsJfT5jgC8osQfwfbXLobEGSndP4+yiY1gnNnOm+u65+UuTyo9
         mf0BkntfkjHMogDx96plcSHGKvjUfaG6Sf2JQkol1/ZEscpO+MifQ5FP/D7OsiAExHXJ
         pcD3PLwwZMj6XGtUlLkTZtm3GfzKTM6na8C3bUshKKqRWcCPEAGOUd13RLO8VWwMdYFA
         Lyb0CDjnMYNgIyiSuld2jv9W5+KoWhTMIbg1M/flfWJiKeNpYslrTKHU8x4t3Gedjqsi
         +V0TasMzt83CsGZM/mXLBA+btukGRFdNK4+h8Q42GJjD1O0NGc9xBA26O9sJuVe8jIg4
         Nrpw==
X-Gm-Message-State: AOAM533aX+2B8Xb+VF2jFcXzR7hCamFpx2sHniWw0ldemG1e7bFiYV2f
        LVLMMiqb6hKznmUMfEjlS2qoMkSL9viYjIuMRhc=
X-Google-Smtp-Source: ABdhPJz7nP5paeSvQxWcJ39K2jYlhUAtcbwJQnUm8N0/44tFeorVrFxa9wNKI/ACiohLyPYRsBIz4Ce4UZTB2Ec2NRo=
X-Received: by 2002:a05:6512:21b0:: with SMTP id c16mr15403821lft.100.1631664266278;
 Tue, 14 Sep 2021 17:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5CHuYX6heA-3+jJ+wHUOBFcLsiy43E9qOoOx3WuJ_kP_g@mail.gmail.com>
In-Reply-To: <CAOMZO5CHuYX6heA-3+jJ+wHUOBFcLsiy43E9qOoOx3WuJ_kP_g@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 14 Sep 2021 21:04:15 -0300
Message-ID: <CAOMZO5CiWXEDKt6gJAUBkPjtogrHQtBcr0e3pn1+w1JiFqrw7Q@mail.gmail.com>
Subject: Re: ath10k: Incorrect MTU size for SDIO
To:     alagusankar@silex-india.com, erik.stromdahl@gmail.com
Cc:     ath10k@lists.infradead.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        wgong@codeaurora.org, Peter Oh <peter.oh@eero.com>,
        jouni@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 19, 2021 at 2:29 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi,
>
> On a i.MX7-based board with QCA9377 chip, I received the following
> report from a user running kernel 5.10.48:
>
> "Doing scp or just pipe through files with >10 lines I get stalls and
> error logs. The ath10k_sdio errors look like this:
> [  196.822363] ath10k_sdio mmc2:0001:1: failed to transmit packet, dropping: -12
> [  196.830109] ath10k_sdio mmc2:0001:1: failed to submit frame: -12
> [  196.836279] ath10k_sdio mmc2:0001:1: failed to push frame: -12
> [  196.925452] ath10k_sdio mmc2:0001:1: failed to transmit packet, dropping: -12
> [  196.933090] ath10k_sdio mmc2:0001:1: failed to submit frame: -12
> [  196.939334] ath10k_sdio mmc2:0001:1: failed to push frame: -12
>
> I am able to reliably reproduce the issue by sending a lot of data
> from the i.MX7 board to a host connected via the AP:
> printf '=%.0s' {1..24000} | nc 192.168.0.2 1234
>
> I was able to narrow the issue down to the mtu. If I set the mtu for
> the wlan0 device to 1486 instead of 1500, the issue does not happen.
>
> The size of frames that I see on Wireshark is exactly 1500 after
> setting it to 1486."

I am able to reproduce this locally on an imx6dl-pico-pi board with a
QCA9377 SDIO chip
running kernel 5.15-rc1.

[   10.383463] ath10k_sdio mmc1:0001:1: qca9377 hw1.1 sdio target
0x05020001 chip_id 0x00000000 sub 0000:0000
[   10.393717] ath10k_sdio mmc1:0001:1: kconfig debug 0 debugfs 0
tracing 0 dfs 0 testmode 0
[   10.405764] ath10k_sdio mmc1:0001:1: firmware ver
WLAN.TF.1.1.1-00061-QCATFSWPZ-1 api 5 features ignore-otp crc32
7746e551
[   10.640195] ath10k_sdio mmc1:0001:1: failed to fetch board data for
bus=sdio,vendor=0271,device=0701,subsystem-vendor=0000,subsystem-device=0000
from ath10k/QCA9377/hw1.0/board-2.bin
[   10.664515] ath10k_sdio mmc1:0001:1: board_file api 1 bmi_id N/A
crc32 544289f7

The QCA9377 operates in STA mode.

Simply doing "ssh user@192.168.0.1" causes:

[   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
[   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
[   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
[   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
[   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
[   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12

and it is not possible to connect via ssh to the other machine.

Changing the MTU size to 1486:

# ifconfig wlan0 mtu 1486

and trying the ssh connection again, it is possible to connect to the
other machine.

Any logs I should capture to help to analyze this problem?

Thanks
