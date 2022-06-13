Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15054A22C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jun 2022 00:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiFMWkw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 18:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiFMWkv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 18:40:51 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7B231201
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 15:40:50 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id f7so5365471ilr.5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 15:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tqq8Ug/EqtkzORZL90pCviuNcEhayeMVzSL/wXVCwy4=;
        b=C0Wqy4RlNX4uITk55yB04SgXFCcl6LzJtpHp2yb8NZ8iflcJy9Wi4SfYWZvwqDirqR
         7aHudNoMPa71X/egLpuLEtfBRVwIBuS8zmP4IOE5veeRUv9OYtuwx+BKmApBJge6pI8h
         S2TfLupdROd94TabQXk0uHrBez9qjaA8TIFnYR+Bch3HVX/mKtqP143GYz9quO7x+jaO
         q/fYmLLFQTXribUVijtBLXDrtquFfClv9k6OJuuL4tq7GTeduLrmgJpamHKHs1ErfygL
         aVlJMUQEjvVXMLbbNPjwPbn1fqg2R2WiKn9LSSYt828RhALpoFUkMjU5imieM+PyS/kM
         ogLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tqq8Ug/EqtkzORZL90pCviuNcEhayeMVzSL/wXVCwy4=;
        b=YMR9qw/OGs4Vt7WjGSI6Z2iWnbp6TvfOaQ3/BczhJq+tpRFFP02whNR21/zeklFdWm
         iOgp0sqvRC97p0HjdO9gfGQsG5Gdhg+Pzs8qMa4qF5Rq3q775tlOyBI09rHW1g+K8wMG
         RmULInseDayJ7e83vmV7mLA6DyYFtGzuT88iMpONKAOPSJrKyQChJBDnQgsWQp7IdJ09
         39pWen72FC65iJ8yZPXXLRQtmh36eg59QjDOgEe7vnSbCK9+H+Nsf2X0ITtuz4knsBNi
         mG3I3YVtHzKFEFG6jaY5udJ06fiFHiLGl114Ob+e34WdREOwKv/IBDa/lv/9OoNtOvQh
         uUGw==
X-Gm-Message-State: AJIora/WBJOMMbe6Y5Bv0TS4lJZL8oUZwM9FyleCrPbFEkE9t2Wwfu5k
        cwdKdJYhHjVrlX0NaQlQtxsaqA==
X-Google-Smtp-Source: AGRyM1tjq+KmPCarJeQ9VzZrtSVHoICOq3twLcOGtnWddzE5IICqCwaSPm7uCWUrNw92U/Pv3MhtbA==
X-Received: by 2002:a05:6e02:1a44:b0:2d3:ff91:12a3 with SMTP id u4-20020a056e021a4400b002d3ff9112a3mr1259727ilv.82.1655160049803;
        Mon, 13 Jun 2022 15:40:49 -0700 (PDT)
Received: from elrond.bobcopeland.com (cpe30b5c2fb365b-cma456cc3dfbbf.cpe.net.cable.rogers.com. [99.232.36.65])
        by smtp.gmail.com with ESMTPSA id o188-20020a0222c5000000b003317fc4aa87sm4064722jao.150.2022.06.13.15.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:40:49 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 380F8FC00A8; Mon, 13 Jun 2022 18:40:48 -0400 (EDT)
Date:   Mon, 13 Jun 2022 18:40:48 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, loic.poulain@linaro.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wcn36xx: Fix typo in comment
Message-ID: <Yqe88CP9URS/E30s@bobcopeland.com>
References: <20220613172818.7491-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613172818.7491-1-wangxiang@cdjrlc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 14, 2022 at 01:28:18AM +0800, Xiang wangx wrote:
> Delete the redundant word 'the'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/net/wireless/ath/wcn36xx/hal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
> index 46a49f0a51b3..874746b5993c 100644
> --- a/drivers/net/wireless/ath/wcn36xx/hal.h
> +++ b/drivers/net/wireless/ath/wcn36xx/hal.h
> @@ -1961,7 +1961,7 @@ struct wcn36xx_hal_config_bss_params {
>  
>  	/* HAL should update the existing BSS entry, if this flag is set.
>  	 * UMAC will set this flag in case of reassoc, where we want to
> -	 * resue the the old BSSID and still return success 0 = Add, 1 =
> +	 * resue the old BSSID and still return success 0 = Add, 1 =
>  	 * Update */

Also "reuse"

>  	u8 action;
>  
> @@ -2098,7 +2098,7 @@ struct wcn36xx_hal_config_bss_params_v1 {
>  
>  	/* HAL should update the existing BSS entry, if this flag is set.
>  	 * UMAC will set this flag in case of reassoc, where we want to
> -	 * resue the the old BSSID and still return success 0 = Add, 1 =
> +	 * resue the old BSSID and still return success 0 = Add, 1 =

Here too.

-- 
Bob Copeland %% https://bobcopeland.com/
