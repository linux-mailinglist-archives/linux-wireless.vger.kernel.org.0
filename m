Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC62B1DDD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgKMO4E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 09:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKMO4E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 09:56:04 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDF7C0613D1;
        Fri, 13 Nov 2020 06:56:04 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id v20so1405195qvx.4;
        Fri, 13 Nov 2020 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y4W/LEbVmQftnkb6vlHa67PXtRyeKUVWzFmGV48pYso=;
        b=pZFOBGEDpPHUz4Bx9dE+yC0Ad8AxA69VfO38NxWWKtmcXM4PpymnkMyKyXem2+D137
         vbrYHvwXD/uGFJ4cPHT1YKkHSqwt5UzxAtfb8rHsQB8vOAUVG9drjEEn8NuUFX9MXhI9
         9pFzpMDxCOQc8DqWWM5tZH6yN5I4tcszBtzPup9IJ/mKm+Bp9yXZMAzySP0SntQaXMn5
         AjlAude5E7SpRGUhtY3kjoI06B6wXGhE5ST9c3kp10s/RzAk7TEIQTDkQlzWlOWqhSb2
         9EGVqNg81uoBNkLRYzy14HiHSKRG27/Nu7FSrtg1vsI2swdTlb+D5WoBOkk6OAmKt3Tw
         dkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y4W/LEbVmQftnkb6vlHa67PXtRyeKUVWzFmGV48pYso=;
        b=RWyxSodnUMLxXwx1vK9+YrcWIh9PwbLW3JPVuQ4ux5X4UxSZ4deda0TMBcgHBJ+f+B
         PLAZyG8kWGfp8yQSCSBD4bisIcTVPrIAeJkpyw9TDAco37cvXfTSDG1vOV3vD5Dyw/uE
         PEMDIgock5AddLe9VWMK+d8cXbbT/k4fqV/ugBUc0RFBXNOmjFwQquOEW72R83nUOODZ
         aN5rG9OD8WTfLONZepgMofvoRUiMfF10OfM1jLn/t4Z92C62sp7xojJaPpWh5gjwqseW
         ju8vyUBLg7igPCHOlvFotIsMS6NLRR1bgAU9h19oHkaMRw205ymV5iOlVbnktp8RAc+R
         qpdA==
X-Gm-Message-State: AOAM533LihwR/JnoQtEoO/e806iU9hf3W8GSwVKwteoey5sGHGoJLixc
        tR86tKCddMMCkd4YoKgHiUE+eMPWsSk=
X-Google-Smtp-Source: ABdhPJzdBXi6nipj7k7kHaCwM2SE0bp0QgjJ2mXo/Tb4ZeKw+ApmelheQrKPreqkwyZtxg3wMPX33g==
X-Received: by 2002:ad4:46cb:: with SMTP id g11mr2771607qvw.37.1605279363302;
        Fri, 13 Nov 2020 06:56:03 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102::1844? ([2620:10d:c091:480::1:6eec])
        by smtp.gmail.com with ESMTPSA id o9sm6912688qte.35.2020.11.13.06.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 06:56:02 -0800 (PST)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] rtl8xxxu: remove the unused variable timeout value
 assignment
To:     xiakaixu1987@gmail.com, kvalo@codeaurora.org, chiu@endlessm.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
References: <1605261010-5413-1-git-send-email-kaixuxia@tencent.com>
Message-ID: <c09a450d-7b5a-b0fa-c435-b5778de8b05a@gmail.com>
Date:   Fri, 13 Nov 2020 09:56:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1605261010-5413-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/13/20 4:50 AM, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The value of variable timeout is overwritten by the following statement in
> rtl8xxxu_gen1_init_aggregation(), so here the value assignment is useless.
> Remove it.
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 5cd7ef3..342126b 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4426,7 +4426,7 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
>  	page_thresh = (priv->fops->rx_agg_buf_size / 512);
>  	if (rtl8xxxu_dma_agg_pages >= 0) {
>  		if (rtl8xxxu_dma_agg_pages <= page_thresh)
> -			timeout = page_thresh;
> +			; /* do nothing */

Sorry this is the wrong way to do this. If the if statement is no longer
needed, then remove it, don't just make it do nothing.

Nack

Jes

