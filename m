Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3CF853B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 01:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKLAdm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 19:33:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44771 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKLAdm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 19:33:42 -0500
Received: by mail-io1-f66.google.com with SMTP id j20so16450627ioo.11
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 16:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qm9qC61frUmjw7P/ieSKt2kG2a2HaCUv4lVcNyooLzU=;
        b=odI2yIUMmbLRIEI5p0mrTZm2bP1f6NB1QkpIbKCTy+shpXtRSRdIPXeZNPXaOkG/je
         064fQpAqA3GCg89a0wWZUUtoZTj0mxs4CheDPZG9YH61fAQ5Ldidskkbin6D3ZGex29q
         SsG+/Js3LB2Iz5/Bk4nzHixTYci4bQyShyFLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qm9qC61frUmjw7P/ieSKt2kG2a2HaCUv4lVcNyooLzU=;
        b=SZN9UHDE6MkHt6jldO+r0Gpi5DewYVUJmlW3nRp7eQKrsaEOYzKliH6k/I4458KHpM
         b/C960+FgILWzWZdcUwdPe2jS+2MNgYysQl/fJ4CHNtHPTWhrei6H1tjOPuEvk/fokR6
         bBh9TNTT+DeVaoh4fXNu4xVUQAya4i5ElYHDrfsro73tqhNus/cRYWNTd1NbWv/YwRor
         K0+1o3SMc4DJenPA97qoDL8QjFR0ZKLKqCg8FNx7DqlF2M2/mj4UY6TgDSWTEfyfMcAA
         rmIfBaIYREy1haU6JCgwb8DQKk3mJrgoCA6PMyO4kYiepiXDa3Kpk2a1/1vctVHnZEuJ
         hidg==
X-Gm-Message-State: APjAAAUZGz2yPu46ZeOPDQtiTH9Xd6oG2QxglGioO9uZGPYglkpwiZpY
        CAiNEUo/DYO7fCs3OUwZbGDnMPMDDSY=
X-Google-Smtp-Source: APXvYqyLBwa1frnEoRAbQyDqwVStmTMZCzGbdwBWu0lp+1daDMLpdAzFjkYR0OZ9rkP4x5FGMS053w==
X-Received: by 2002:a6b:16c5:: with SMTP id 188mr27091664iow.195.1573518821376;
        Mon, 11 Nov 2019 16:33:41 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id d11sm2293994ill.17.2019.11.11.16.33.38
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 16:33:38 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id 1so16731546iou.4
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 16:33:38 -0800 (PST)
X-Received: by 2002:a5d:8953:: with SMTP id b19mr28438799iot.168.1573518818050;
 Mon, 11 Nov 2019 16:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org> <20191109103046.26445-4-ulf.hansson@linaro.org>
In-Reply-To: <20191109103046.26445-4-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Nov 2019 16:33:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
Message-ID: <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6f8342702c73..abf8f5eb0a1c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>         mmc_bus_put(host);
>  }
>
> -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> -                               bool cd_irq)
> +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>  {
>         /*
>          * If the device is configured as wakeup, we prevent a new sleep for
> @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>         ret = host->bus_ops->hw_reset(host);
>         mmc_bus_put(host);
>
> -       if (ret)
> +       if (ret < 0)
>                 pr_warn("%s: tried to HW reset card, got error %d\n",
>                         mmc_hostname(host), ret);

Other callers besides marvell need to be updated?  In theory only SDIO
should have positive return values so I guess we don't care about the
caller in drivers/mmc/core/block.c, right?  What about:

drivers/net/wireless/ath/ath10k/sdio.c

...I guess I don't know if there is more than one function probed
there.  Maybe there's not and thus we're fine here too?


I didn't spend massive amounts of time looking for potential problems,
but in general seems workable to me.  Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
