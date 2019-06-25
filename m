Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34A352382
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 08:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfFYGXj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 02:23:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbfFYGXj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 02:23:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4EE24609CD; Tue, 25 Jun 2019 06:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561443818;
        bh=Hd5gbuNTsYiH27rbkPYy6wRdEF/4Ba/kNXkgRJE/o74=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jt5StXuwx/HH8nOv67zaV+dmyQLZAzVH2BpOUs03Wj3xdgoDZJYk536FHRC2IdRmS
         BNRFLyTE62eHbLW0mcTICMK5iUisQRP7IN21L9HJlf8Msj9nC9o2ceQ0iunXSKI25T
         O0fnS4FCctWqkM2KpDIl9FdyKdBL8Pym2a7jEJ0o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38728609CD;
        Tue, 25 Jun 2019 06:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561443817;
        bh=Hd5gbuNTsYiH27rbkPYy6wRdEF/4Ba/kNXkgRJE/o74=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FsnQz2NwSl+XDNdi+l3C5/zs1mriNI/7E0OjIE63a1OD4uf7hlrM3NaC1mOOMJNr8
         trz+cR/kaxT5pVQg0jQA732x0Vbx3iG+9ObiRTJVhFsbH9Ts09rMmVybAC6NO7fZBv
         ieyXsRcKPPIvwJSiTPL1e/zhLQcsq2jWZ3hF4wy8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38728609CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: linux-next: build failure after merge of the tip tree
References: <20190625160432.533aa140@canb.auug.org.au>
Date:   Tue, 25 Jun 2019 09:23:33 +0300
In-Reply-To: <20190625160432.533aa140@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 25 Jun 2019 16:04:32 +1000")
Message-ID: <8736jyfaje.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> drivers/net/wireless/intersil/p54/txrx.c: In function 'p54_rx_data':
> drivers/net/wireless/intersil/p54/txrx.c:386:28: error: implicit declaration of function 'ktime_get_boot_ns'; did you mean 'ktime_get_raw_ns'? [-Werror=implicit-function-declaration]
>    rx_status->boottime_ns = ktime_get_boot_ns();
>                             ^~~~~~~~~~~~~~~~~
>                             ktime_get_raw_ns
>
> Caused by commit
>
>   c11c75ec784e ("p54: Support boottime in scan results")
>
> from the wireless-drivers-next tree interacting with commit
>
>   9285ec4c8b61 ("timekeeping: Use proper clock specifier names in functions")
>
> from the tip tree.
>
> I have added the following merge fix patch:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 25 Jun 2019 15:55:36 +1000
> Subject: [PATCH] p54: fix up for ktime_get_boot_ns() name change
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/wireless/intersil/p54/txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireless/intersil/p54/txrx.c
> index be6968454282..873fea59894f 100644
> --- a/drivers/net/wireless/intersil/p54/txrx.c
> +++ b/drivers/net/wireless/intersil/p54/txrx.c
> @@ -383,7 +383,7 @@ static int p54_rx_data(struct p54_common *priv, struct sk_buff *skb)
>  
>  	fc = ((struct ieee80211_hdr *)skb->data)->frame_control;
>  	if (ieee80211_is_probe_resp(fc) || ieee80211_is_beacon(fc))
> -		rx_status->boottime_ns = ktime_get_boot_ns();
> +		rx_status->boottime_ns = ktime_get_boottime_ns();

Thanks for the report. Any suggestions how to handle this? Or do we let
Linus take care of this?

-- 
Kalle Valo
