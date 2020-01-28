Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E847414C372
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 00:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgA1XPB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jan 2020 18:15:01 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37648 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1XPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jan 2020 18:15:00 -0500
Received: by mail-vs1-f65.google.com with SMTP id x18so9297740vsq.4
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2020 15:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yutVdDwIR4aezSyKn/ZRy2+avDSPVz6Dc1tmaTc/rqI=;
        b=j+C/3LDHcYl8BE4EB7d97f0mZ+rasBVKKKN0BY/5xOyCQdi5RwuOrZA1313VnNaowe
         yNF6OH1FHk6BlunCMyPyKC3umpj1YvV/RDHB60Kn49xtD1wal+e4t/YgpDBTtrMxuPil
         rJgebze0QNMYuD+7U8Agzj5tX6UVEXoQob93Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yutVdDwIR4aezSyKn/ZRy2+avDSPVz6Dc1tmaTc/rqI=;
        b=J5AFAx+sA5XnVN4YK2wszpFWPSl8/LgHyG7BoMzJbIwQuqs94AygfqT7ZkkAl5aX2J
         St2FQaQK+lImI8Hv2WyMqbAQ7xXLYynN5TskttR31gNl1RSS5w8DD7jqoV53b7F85fw7
         1OQn+hiFPu5M2KXQY3Bh+MDWE8zPMLt3RAr9qdb7q+DFojro334L5EFdR3G6Wn0swH++
         jIYTXCPmDemE6RqZAaHAULMU5ZBwPdbsNnraewR/MggDOCCxWMm1HIpYPas12jeeYk72
         1MpB1I09zTXPHg4Yyl+7gtrTndzs9DKFOD2pZ5o7hV3s1y5tmkfZ74e9ExrwD/vOzNze
         o6og==
X-Gm-Message-State: APjAAAU895xb+7isymLo5fFtiQbZPPKTOdcaCb/aajCH1pY8+9HH/Kak
        dFKAd2ZSJcwTCzVGDGsynrovZ6kpe7k=
X-Google-Smtp-Source: APXvYqx9+Nm+khWrXIL8kQ1SvD1wWu5EeRo7MmTWAzsv4RI3AWPvfPcOi2sdeGtTwIcTDHATkiwsrQ==
X-Received: by 2002:a05:6102:241a:: with SMTP id j26mr8959120vsi.163.1580253298529;
        Tue, 28 Jan 2020 15:14:58 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id y7sm13724vkd.38.2020.01.28.15.14.57
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 15:14:57 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id x123so9289274vsc.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2020 15:14:57 -0800 (PST)
X-Received: by 2002:a67:fa1a:: with SMTP id i26mr2943374vsq.169.1580253297061;
 Tue, 28 Jan 2020 15:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20200128221457.12467-1-linux@roeck-us.net>
In-Reply-To: <20200128221457.12467-1-linux@roeck-us.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Jan 2020 15:14:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wg2MZ56fsCk+TvRSSeZVz5eM4cwugK=HN6imm5wfGgiw@mail.gmail.com>
Message-ID: <CAD=FV=Wg2MZ56fsCk+TvRSSeZVz5eM4cwugK=HN6imm5wfGgiw@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: abort and release host after error
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Jan 28, 2020 at 2:15 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With commit 216b44000ada ("brcmfmac: Fix use after free in
> brcmf_sdio_readframes()") applied, we see locking timeouts in
> brcmf_sdio_watchdog_thread().
>
> brcmfmac: brcmf_escan_timeout: timer expired
> INFO: task brcmf_wdog/mmc1:621 blocked for more than 120 seconds.
> Not tainted 4.19.94-07984-g24ff99a0f713 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> brcmf_wdog/mmc1 D    0   621      2 0x00000000 last_sleep: 2440793077.  last_runnable: 2440766827
> [<c0aa1e60>] (__schedule) from [<c0aa2100>] (schedule+0x98/0xc4)
> [<c0aa2100>] (schedule) from [<c0853830>] (__mmc_claim_host+0x154/0x274)
> [<c0853830>] (__mmc_claim_host) from [<bf10c5b8>] (brcmf_sdio_watchdog_thread+0x1b0/0x1f8 [brcmfmac])
> [<bf10c5b8>] (brcmf_sdio_watchdog_thread [brcmfmac]) from [<c02570b8>] (kthread+0x178/0x180)
>
> In addition to restarting or exiting the loop, it is also necessary to
> abort the command and to release the host.
>
> Fixes: 216b44000ada ("brcmfmac: Fix use after free in brcmf_sdio_readframes()")
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index f9df95bc7fa1..2e1c23c7269d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -1938,6 +1938,8 @@ static uint brcmf_sdio_readframes(struct brcmf_sdio *bus, uint maxframes)
>                         if (brcmf_sdio_hdparse(bus, bus->rxhdr, &rd_new,
>                                                BRCMF_SDIO_FT_NORMAL)) {
>                                 rd->len = 0;
> +                               brcmf_sdio_rxfail(bus, true, true);
> +                               sdio_release_host(bus->sdiodev->func1);

I don't know much about this driver so I don't personally know if
"true, true" is the correct thing to pass to brcmf_sdio_rxfail(), but
it seems plausible.  Definitely the fix to call sdio_release_host() is
sane.

Thus, unless someone knows for sure that brcmf_sdio_rxfail()'s
parameters should be different:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
