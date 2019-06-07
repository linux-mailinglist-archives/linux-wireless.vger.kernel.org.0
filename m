Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E927383AB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 07:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFGFMt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 01:12:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43616 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfFGFMt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 01:12:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so1120216edb.10
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2019 22:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=X+VdyBkwWBj+A8nZ9fuV2ga0Yg8bfWjeExs0duLp7AE=;
        b=CxTTI0DeptWFatbDZ0NKQsZsgCfYyHcMdaLCUqWl6S/Dn4R30qrCY9CJMCDiu7VBH/
         rAFskPH7JRikj2/iwuLfUpyyppc2bj8wLBxLui+oJ0FA3tRDVdWE+Z97A5pqBRz5fyAz
         E0NCsVFieCa7eiCBQh5lu4RhZCi2GE3zgGOg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=X+VdyBkwWBj+A8nZ9fuV2ga0Yg8bfWjeExs0duLp7AE=;
        b=UWV7VMO/Sjubv4Vd8RCt+g8mtwYWztVzMUF1t/lU/z2jez9fKmzWUC5E55iHaxvyCL
         t8UebS6JTmVwsdFJ6Ldl9/l48vpwNyaVbH8V4qYqM98Ed3POjSxXLgQyayhiMD3b/Ltv
         TAS7FiST1SBHULWVicMN3v2HDo+X5CpnpWBzdckXedNb1vZsLMloOBmSbSD8wN6aHv3z
         M20KsMuj9lREPBRrP+aWL8oE97lq80OIz1Ou6p8x7sLFygb6oDiyWNb1VsD0YgkGZ18p
         YuS0vPsaqSRnniOBpp+mcqZBrPWcH8K9Ol+JYqosk+nWZ5RG17LDGqojSAAL7p4QqXby
         b+/g==
X-Gm-Message-State: APjAAAXrsB9j6ooRV9dENEQ9tcdPqdEXIpvyxToWY15jBTojAyzvouXX
        c6FMH9En7M8QSPzVWSC/GlSgjA==
X-Google-Smtp-Source: APXvYqxhvPHvkv9YaUOGfD7/SxyLMutkVvxNogtZJ3H6zoYCplrVkHX8Wbxd30gY39jSIR64FYZtnw==
X-Received: by 2002:a17:906:1cc6:: with SMTP id i6mr34091753ejh.100.1559884367150;
        Thu, 06 Jun 2019 22:12:47 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id 93sm234704edk.84.2019.06.06.22.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Jun 2019 22:12:46 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Doug Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        "linux-wireless" <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        "Chi-Hsien Lin" <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        "brcm80211-dev-list" <brcm80211-dev-list@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Franky Lin <franky.lin@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 07 Jun 2019 07:12:42 +0200
Message-ID: <16b305a7110.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAD=FV=UPfCOr-syAbVZ-FjHQy7bgQf5BS5pdV-Bwd3hquRqEGg@mail.gmail.com>
References: <20190603183740.239031-1-dianders@chromium.org>
 <20190603183740.239031-4-dianders@chromium.org>
 <42fc30b1-adab-7fa8-104c-cbb7855f2032@intel.com>
 <CAD=FV=UPfCOr-syAbVZ-FjHQy7bgQf5BS5pdV-Bwd3hquRqEGg@mail.gmail.com>
User-Agent: AquaMail/1.20.0-1451 (build: 102000001)
Subject: Re: [PATCH v2 3/3] brcmfmac: sdio: Disable auto-tuning around commands expected to fail
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On June 6, 2019 11:37:22 PM Doug Anderson <dianders@chromium.org> wrote:
>
> In the case of dw_mmc, which I'm most familiar with, we don't have any
> sort of automated or timed-based retuning.  ...so we'll only re-tune
> when we see the CRC error.  If I'm understanding things correctly then
> that for dw_mmc my solution and yours behave the same.  That means the
> difference is how we deal with other retuning requests, either ones
> that come about because of an interrupt that the host controller
> provided or because of a timer.  Did I get that right?

Right.

> ...and I guess the reason we have to deal specially with these cases
> is because any time that SDIO card is "sleeping" we don't want to
> retune because it won't work.  Right?  NOTE: the solution that would
> come to my mind first to solve this would be to hold the retuning for
> the whole time that the card was sleeping and then release it once the
> card was awake again.  ...but I guess we don't truly need to do that
> because tuning only happens as a side effect of sending a command to
> the card and the only command we send to the card is the "wake up"
> command.  That's why your solution to hold tuning while sending the
> "wake up" command works, right?

Yup.

> ---
>
> OK, so assuming all the above is correct, I feel like we're actually
> solving two problems and in fact I believe we actually need both our
> approaches to solve everything correctly.  With just your patch in
> place there's a problem because we will clobber any external retuning
> requests that happened while we were waking up the card.  AKA, imagine
> this:
>
> A) brcmf_sdio_kso_control(on=True) gets called; need_retune starts as 0
>
> B) We call sdio_retune_hold_now()
>
> C) A retuning timer goes off or the SD Host controller tells us to retune
>
> D) We get to the end of brcmf_sdio_kso_control() and clear the "retune
> needed" since need_retune was 0 at the start.
>
> ...so we dropped the retuning request from C), right?
>
>
> What we truly need is:
>
> 1. CRC errors shouldn't trigger a retuning request when we're in
> brcmf_sdio_kso_control()
>
> 2. A separate patch that holds any retuning requests while the SDIO
> card is off.  This patch _shouldn't_ do any clearing of retuning
> requests, just defer them.
>
>
> Does that make sense to you?  If so, I can try to code it up...

FWIW it does make sense to me. However, I am still not sure if our sdio 
hardware supports retuning. Have to track down an asic designer who can 
tell or dive into vhdl myself.

So I want to disable device sleep and trigger retuning through debugfs or 
some other hack.

Regards,
Arend


