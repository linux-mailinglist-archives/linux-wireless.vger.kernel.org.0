Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18854599D0D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 15:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349234AbiHSNn7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiHSNn6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 09:43:58 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DD9E132;
        Fri, 19 Aug 2022 06:43:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q8so3361964qvr.9;
        Fri, 19 Aug 2022 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc;
        bh=Vgcwh/xwToR0x9zi0fn23Nic/A8650gI91w0C/eBOJc=;
        b=M/1pP7mXIFkoqpPT3gbF5ajxscbDr9qHoFF9pDH59NN/xWBz4BJ++Pur+YsijNCZvB
         4Hr+/6E9Nuwq9k83Uc34PCZKHHjHZmbVVvz/HCZXCOa5mbTIxxszd00+1E+VTYw1nn0f
         0ruU+qI6OgqjloqRFqU0Z5mx5u3rnkfT/vaOcHR4E5ji4axK4fJ/x8yQXJchlMq5IOPX
         3eNSKS373DMwgG+9ots07yEe+F+32HwLKCJ0eDIUgQJ3qIrtCM4XZ95z1gg/rKhKot+5
         +UCF3fVi+Hz2HCL/EmK0QXja9+vevgzrdiiXMw7NrlijI4lzJkU3wprFr46XJWOrSJhX
         ZwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc;
        bh=Vgcwh/xwToR0x9zi0fn23Nic/A8650gI91w0C/eBOJc=;
        b=JsBcYHkzgFsRvKagdv+F9Gsd2pL50xaenqGqEMRbECD9veJuGAMhzNVriH2qO9IY25
         v9fAoxO+oGMbM9MiuqRa4Y+dWueHLtPLcgGimJfMNWMtr1dZKUKmFbDtiKhER/8yMNRS
         5SxLirIA7vJYNVm+R0hIbfa58o87b3pTT/7vtGosMbp5qrCKuD8yzb7ts3q70IyoZG8h
         157oaaxhx299xnp+tHYyZu3cmwACNvrETL7b9Z2jfCnEVwDtFOnNJdHh8Mg/+JLXfAPj
         csWThfVcUbmwztddEtiYtr5UcVwK3Ehy1Lmem3t5C6azoKDFK5fU0wgVknSit+6Km+hm
         N+JQ==
X-Gm-Message-State: ACgBeo2SnL/RBIlx/q/Uh2KzX4dXQdbCA3VHq7v0V4rkPvT/2hbq5vyE
        lu1F0NhW+IGtj7SNBzqRkZA=
X-Google-Smtp-Source: AA6agR7cnpy3VAMI80j5/oa300QG+78q3xTp3Wfd03/jPzB31jlhjVxJkzuTs12SITqHG1e4Qj/zmw==
X-Received: by 2002:a05:6214:21af:b0:47b:53e7:9f6 with SMTP id t15-20020a05621421af00b0047b53e709f6mr6243820qvc.109.1660916636191;
        Fri, 19 Aug 2022 06:43:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:1102::1244? ([2620:10d:c091:480::5b12])
        by smtp.gmail.com with ESMTPSA id m9-20020a05620a24c900b006af0ce13499sm3987767qkn.115.2022.08.19.06.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 06:43:54 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <bd6d437e-6dfc-bb7f-d74e-84714e952a8e@gmail.com>
Date:   Fri, 19 Aug 2022 09:43:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] wifi: rtl8xxxu: tighten bounds checking in
 rtl8xxxu_read_efuse()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <Yv8eGLdBslLAk3Ct@kili>
In-Reply-To: <Yv8eGLdBslLAk3Ct@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/19/22 01:22, Dan Carpenter wrote:
> There some bounds checking to ensure that "map_addr" is not out of
> bounds before the start of the loop.  But the checking needs to be
> done as we iterate through the loop because "map_addr" gets larger as
> we iterate.
> 
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Looks reasonable to me.

Acked-by: Jes Sorensen <Jes.Sorensen@gmail.com>



> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index c66f0726b253..f3a107f19cf5 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -1878,13 +1878,6 @@ static int rtl8xxxu_read_efuse(struct rtl8xxxu_priv *priv)
>  
>  		/* We have 8 bits to indicate validity */
>  		map_addr = offset * 8;
> -		if (map_addr >= EFUSE_MAP_LEN) {
> -			dev_warn(dev, "%s: Illegal map_addr (%04x), "
> -				 "efuse corrupt!\n",
> -				 __func__, map_addr);
> -			ret = -EINVAL;
> -			goto exit;
> -		}
>  		for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
>  			/* Check word enable condition in the section */
>  			if (word_mask & BIT(i)) {
> @@ -1895,6 +1888,13 @@ static int rtl8xxxu_read_efuse(struct rtl8xxxu_priv *priv)
>  			ret = rtl8xxxu_read_efuse8(priv, efuse_addr++, &val8);
>  			if (ret)
>  				goto exit;
> +			if (map_addr >= EFUSE_MAP_LEN - 1) {
> +				dev_warn(dev, "%s: Illegal map_addr (%04x), "
> +					 "efuse corrupt!\n",
> +					 __func__, map_addr);
> +				ret = -EINVAL;
> +				goto exit;
> +			}
>  			priv->efuse_wifi.raw[map_addr++] = val8;
>  
>  			ret = rtl8xxxu_read_efuse8(priv, efuse_addr++, &val8);

