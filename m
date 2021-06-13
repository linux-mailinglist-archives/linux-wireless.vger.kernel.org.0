Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240423A5613
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jun 2021 04:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhFMC7C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 22:59:02 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40567 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMC7A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 22:59:00 -0400
Received: by mail-ot1-f45.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so7309362otr.7
        for <linux-wireless@vger.kernel.org>; Sat, 12 Jun 2021 19:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mOAEpeZMqBh4CF7tKkSYNil1m5voHKfi6yDQu1hrWRU=;
        b=yN7SOzeBQE+g/tOayYKRE/urcB9rw5UtC8dO95QALy78cfOGXIe3X3fJZXonMMfmyK
         kVaai6Jbd6N4TFwucbv6znztJ5iRRv5n+NjXrGyppPULHKilnZWZJpFErOzgFy60LV9c
         ACNuqDbz+43v0NKF6aPZB2YVNLL6B9SzjBdQ2y2sFp5g+6XT9nwA4e4sleEntl/8W8dl
         ll/DzC4X/ehFLKjK08RYLbNKkBNkuiWaQURszLiZi9Kl+j8Q75QDgxkMOE4G89Sj6/p7
         5Un6H6BeC0oesiBDKtS8kZEVCp1PL2EerELtNaqP3WNq+GMJ1R6AAzozm5cu1/Gq62au
         cnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOAEpeZMqBh4CF7tKkSYNil1m5voHKfi6yDQu1hrWRU=;
        b=Vy1iGZ/H9p0ZcNDhkTIauCNeI8iPmh7gF5ouxkgPEvNJVuy2CLAljMJAQm/7wR8Edc
         iYIxVPcW9wT544MfzZLbByaQ5+Ltqt5kdqQgO5xifC8ocFtBHxCruR7W6esxF/D6FuFv
         E56FN1/09XmGG3+FvIyJukERn3OkJXSkJYvQlNGYT2JsOS3CF4pZKQMayaFJuJMTzrqP
         qxeglidppYBj1pe8LjQ7GSDHgGRBpCLkjLcYWU5PqsmUlxuT/FnbacDUiFPAWYzgOfAG
         qtqn6O1YjKUBKtiQqZRorXEHxT02BQaDtjau+QYq2bP2IuVXWo6baJ57P27RNqkuR0KL
         aJhw==
X-Gm-Message-State: AOAM530zsozy7/PICCgeeTfr0UTyqzdgMMinHfQ2wKdFJAbDbBKYz8Dc
        5bBOs03L0nBPoEAt1Q88hJT1XQ==
X-Google-Smtp-Source: ABdhPJz+IURZIjeFNVFk/haPQ6MuItn76Xuga7jrS16ZeIDKLr/uunCrG8ozzcTE4BmoW0BWIHvEHA==
X-Received: by 2002:a9d:4c91:: with SMTP id m17mr8596878otf.347.1623552949368;
        Sat, 12 Jun 2021 19:55:49 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a6sm2233649oon.20.2021.06.12.19.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 19:55:48 -0700 (PDT)
Date:   Sat, 12 Jun 2021 21:55:46 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: Re: [PATCH] wcn36xx: Move hal_buf allocation to devm_kmalloc in probe
Message-ID: <YMVzsh7CxGUmTprx@yoga>
References: <20210605173347.2266003-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605173347.2266003-1-bryan.odonoghue@linaro.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat 05 Jun 12:33 CDT 2021, Bryan O'Donoghue wrote:

> Right now wcn->hal_buf is allocated in wcn36xx_start(). This is a problem
> since we should have setup all of the buffers we required by the time
> ieee80211_register_hw() is called.
> 
> struct ieee80211_ops callbacks may run prior to mac_start() and therefore
> wcn->hal_buf must be initialized.
> 
> This is easily remediated by moving the allocation to probe() taking the
> opportunity to tidy up freeing memory by using devm_kmalloc().
> 
> Fixes: 8e84c2582169 ('wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680
> hardware')
> 

I don't think you're supposed to have an empty line between your Fixes
and S-o-b. That said, this looks good and your reasoning is sound.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index 84e117e0546c..2ccf7a8924a0 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -296,23 +296,16 @@ static int wcn36xx_start(struct ieee80211_hw *hw)
>  		goto out_free_dxe_pool;
>  	}
>  
> -	wcn->hal_buf = kmalloc(WCN36XX_HAL_BUF_SIZE, GFP_KERNEL);
> -	if (!wcn->hal_buf) {
> -		wcn36xx_err("Failed to allocate smd buf\n");
> -		ret = -ENOMEM;
> -		goto out_free_dxe_ctl;
> -	}
> -
>  	ret = wcn36xx_smd_load_nv(wcn);
>  	if (ret) {
>  		wcn36xx_err("Failed to push NV to chip\n");
> -		goto out_free_smd_buf;
> +		goto out_free_dxe_ctl;
>  	}
>  
>  	ret = wcn36xx_smd_start(wcn);
>  	if (ret) {
>  		wcn36xx_err("Failed to start chip\n");
> -		goto out_free_smd_buf;
> +		goto out_free_dxe_ctl;
>  	}
>  
>  	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
> @@ -339,8 +332,6 @@ static int wcn36xx_start(struct ieee80211_hw *hw)
>  
>  out_smd_stop:
>  	wcn36xx_smd_stop(wcn);
> -out_free_smd_buf:
> -	kfree(wcn->hal_buf);
>  out_free_dxe_ctl:
>  	wcn36xx_dxe_free_ctl_blks(wcn);
>  out_free_dxe_pool:
> @@ -375,8 +366,6 @@ static void wcn36xx_stop(struct ieee80211_hw *hw)
>  
>  	wcn36xx_dxe_free_mem_pools(wcn);
>  	wcn36xx_dxe_free_ctl_blks(wcn);
> -
> -	kfree(wcn->hal_buf);
>  }
>  
>  static void wcn36xx_change_ps(struct wcn36xx *wcn, bool enable)
> @@ -1499,6 +1488,12 @@ static int wcn36xx_probe(struct platform_device *pdev)
>  	mutex_init(&wcn->hal_mutex);
>  	mutex_init(&wcn->scan_lock);
>  
> +	wcn->hal_buf = devm_kmalloc(wcn->dev, WCN36XX_HAL_BUF_SIZE, GFP_KERNEL);
> +	if (!wcn->hal_buf) {
> +		ret = -ENOMEM;
> +		goto out_wq;
> +	}
> +
>  	ret = dma_set_mask_and_coherent(wcn->dev, DMA_BIT_MASK(32));
>  	if (ret < 0) {
>  		wcn36xx_err("failed to set DMA mask: %d\n", ret);
> -- 
> 2.30.1
> 
