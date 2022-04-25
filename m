Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F81450EC72
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 01:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiDYXOy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Apr 2022 19:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbiDYXOy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Apr 2022 19:14:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6264614D
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 16:11:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so662185pjb.5
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7qfaiS7UptGcLjv78D3MJ3R6HW7ht14Xm/IpQ4WlFks=;
        b=MmhFoO2V8w9wi8xpsU1YJ3SIL+O1UDp6+GMDMyeQp/HYO0bw9etoHhAaDiQhGx+kCo
         9/zrw47FA6hWwth8/g/FVpkVz2aRxuLT2fHCJhSEgPH4TXyXv9Rhv+jTf2zyAbGQTK2X
         lgZ8uSIrgQAY/M9WgRVxk0xSYXDZ7ttngcP3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7qfaiS7UptGcLjv78D3MJ3R6HW7ht14Xm/IpQ4WlFks=;
        b=HfTUp7c/RPb1SKmm/QoBRxHMEVAwP1UpGzBZpVlSTrkffpBFVk6UggGqrvGgmLuUp+
         40eOHvY5yYgm5BCOVvrGoV4JKNfUwwWez4CitT9AEZ3vhjIqnxZ38pShomxU7J/bucWY
         p+WYbxeAffuTJn/KTyDUa7ubFs/7AVioPgma4u4eATonX1QJt6vn89xodOtnlvkLYj00
         SRNB0G9TQxgd3mkysae9zsoPW0fLVWcqCD+7yAND+2wy7qfPV1iXEctk3DVSot7OZGJP
         RRZhSlS8AMNTPZcgYo/SJNVYlanCEC0NscMWqPAG/M6KVXASpTP615VkWhmCWrFpLo3I
         P/9g==
X-Gm-Message-State: AOAM530CUcpngwmini96LCVbiWHJVinCzS71Wm/yIQNZfDJplX11UqMK
        +9EMSs4nk2o5B5nk8rYDhsnfxw==
X-Google-Smtp-Source: ABdhPJxq8tSG81ZERtNbzC6rp5Tzf57SH9Vgo2lZtFXB6AkCwnY/CL5q9qLUlUQbRHBd70yLFSRgyg==
X-Received: by 2002:a17:90a:a82:b0:1c9:ef95:486 with SMTP id 2-20020a17090a0a8200b001c9ef950486mr34213615pjw.93.1650928307416;
        Mon, 25 Apr 2022 16:11:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:84c6:2d6d:c16:1a1b])
        by smtp.gmail.com with ESMTPSA id f4-20020aa782c4000000b00505da6251ebsm12495302pfn.154.2022.04.25.16.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 16:11:46 -0700 (PDT)
Date:   Mon, 25 Apr 2022 16:11:44 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        netdev@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] ath10k: skip ath10k_halt during suspend for driver state
 RESTARTING
Message-ID: <YmcqsFyCMqcWAEMM@google.com>
References: <20220425021442.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425021442.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 25, 2022 at 02:15:20AM +0000, Abhishek Kumar wrote:
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -5345,8 +5345,22 @@ static void ath10k_stop(struct ieee80211_hw *hw)
>  
>  	mutex_lock(&ar->conf_mutex);
>  	if (ar->state != ATH10K_STATE_OFF) {
> -		if (!ar->hw_rfkill_on)
> -			ath10k_halt(ar);
> +		if (!ar->hw_rfkill_on) {
> +			/* If the current driver state is RESTARTING but not yet
> +			 * fully RESTARTED because of incoming suspend event,
> +			 * then ath11k_halt is already called via

s/ath11k/ath10k/

I know ath11k is the hot new thing, but this is ath10k ;)

> +			 * ath10k_core_restart and should not be called here.

s/ath10k/ath11k/

> +			 */
> +			if (ar->state != ATH10K_STATE_RESTARTING)
> +				ath10k_halt(ar);
> +			else
> +				/* Suspending here, because when in RESTARTING
> +				 * state, ath11k_core_stop skips

s/ath10k/ath11k/

> +				 * ath10k_wait_for_suspend.
> +				 */
> +				ath10k_wait_for_suspend(ar,
> +							WMI_PDEV_SUSPEND_AND_DISABLE_INTR);
> +		}
>  		ar->state = ATH10K_STATE_OFF;
>  	}
>  	mutex_unlock(&ar->conf_mutex);

Otherwise, I believe this is the right solution to the problem pointed
out in the commit message:

Reviewed-by: Brian Norris <briannorris@chromium.org>
