Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87B146FCFA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 09:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhLJIwy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 03:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbhLJIwy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 03:52:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D24C061746
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 00:49:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ED8B8CE2A04
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 08:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B65C00446;
        Fri, 10 Dec 2021 08:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639126156;
        bh=sHJ2K4HWmLNgcWaZ8JeGY7iqpMYUyAqbVSIEietNe9M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Bh9Av8Z5EEvQ8cY1y+SAorgyDjQ0IWWJMPaYpK7yS+UeyGWPng0QFsgXG8lQUm219
         y0ZMClZdU9+JAoAa6s+qMy9pjdOJGIICPkul6+NJ9PYkMwZzRkM7ISRVtFzaqs6Cyq
         jQFgcqFeS3HC/SwVeKUitDZViJd9Y5qaWiFt/uu1kcMpZor1mTkFX9VtEgCPpNyU6O
         RVVV5A7h2OtU/xoxvpwewEhpmNYvY0vM2RRdK7nhaJfGC8MMrqOaEqfa5QMn7w/CGZ
         QPDt4rC3XFjo6FCdfZTtN/nzo3iMjxAG8/2Ou19iX92OcAu6khlTQoHjvfGwrEbabw
         4dw5w0A3CBzag==
From:   Kalle Valo <kvalo@kernel.org>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: reduce log severity levels for informative messages
References: <20211210082247.977043-1-tzungbi@google.com>
Date:   Fri, 10 Dec 2021 10:49:11 +0200
In-Reply-To: <20211210082247.977043-1-tzungbi@google.com> (Tzung-Bi Shih's
        message of "Fri, 10 Dec 2021 16:22:47 +0800")
Message-ID: <8735n0oneg.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tzung-Bi Shih <tzungbi@google.com> writes:

> "ASIC revision" and "Firmware init done" shouldn't be error messages.
> Reduces the severity level to info.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> index 6ada1ebe7d68..99b144fd8db5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -882,7 +882,7 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
>  	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
>  #endif /* CONFIG_PM */
>  
> -	dev_err(dev->mt76.dev, "Firmware init done\n");
> +	dev_info(dev->mt76.dev, "Firmware init done\n");

Shouldn't that be a debug message? Hard to see how's that useful in
normal operation.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
