Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB56996D4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 15:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBPONy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 09:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBPONw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 09:13:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443B56ED4
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 06:13:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a10so3247716edu.9
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThaKf7TQo3GCwN8t6OxTBk+UopUNvRjwNT7xyzNLkiw=;
        b=Gzv+gCaRZHErdCtFDF6ricjCxLtaoIqHnslXw5rk3gNSXyg0tjmNn/TQ8Mew2UPAZr
         Y7j9r6l9ad6RNTTzljGVcr+5TEM00NnQpc8HOyeEa4OHLjs6JC4PIb0Kzlvr0fWQW4ZA
         G89NM7lUGPnrZAwOF0Q1+3VRh/57SssEDw8IEn/MFujv6/CwOiAywc1H4f9iqHxnJC4z
         orCFCF8wm75cLB7tkA37NNSUV+H69atfZ9FYBUzxVF44WOPu+049OahADGmQ1H6WPI2n
         ap9kLIqE8DBr+7iS6nNEKgG/7kZ4l+OSavmDVceHE6j+NRGR+ucJVGxYQzSnYGtUIz6V
         fnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThaKf7TQo3GCwN8t6OxTBk+UopUNvRjwNT7xyzNLkiw=;
        b=YSMbT8EHDAiR61h5TTWzxJjMH4dntmA165ncTtLcGwMVRskbbDD6gvrU1Qisyvb+mP
         INU9Pkmg9EU1BonAVWNkhcFPZHSPqChtbj8uV1oBoSYPHqC7MmGJIOcpcsrDxb0YrFGN
         bdEqLBN3gBWrQhPV2PoBb/gRFjKbu/OjaN1p2tvQ7oWbcSv7v4Mgj7LRdZB18LfhVUbO
         1LDIK9yfzbg+KwhIem3v2c+wmoF82yIpZpy/wAjBebkZOvk4o3eYUsQUZQCfz+8UBgoT
         O7+q6RssnW4gpyRryS6bKWyTCdUxvRUMfzW9ur1HbAscMxJZq8WJ2tpkRh4MIkDvKSDH
         dI4A==
X-Gm-Message-State: AO0yUKVgn3kGj9yuXv5VJNjK4sI8rqxhPsLpOXyY8EmBp2TRYDgUMUuK
        s5jGHWfwULoDRj8BkW4Gx7Y=
X-Google-Smtp-Source: AK7set8iO/coa+lH39q+uSdqOstP/F2n6ANr+0TJClQLiOQW93PNQZYtG1LdTEb4l2t4+8u+k+1CWQ==
X-Received: by 2002:a17:906:8046:b0:879:ec1a:4ac with SMTP id x6-20020a170906804600b00879ec1a04acmr5166736ejw.76.1676556807329;
        Thu, 16 Feb 2023 06:13:27 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id f25-20020a1709067f9900b008b14720ac80sm854799ejr.100.2023.02.16.06.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 06:13:26 -0800 (PST)
Message-ID: <615fc28f-5997-4a85-8fcf-ffccdfa4cc3f@gmail.com>
Date:   Thu, 16 Feb 2023 16:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] wifi: rtl8xxxu: 8188e: parse single one element of RA
 report for station mode
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, Jes.Sorensen@gmail.com,
        kvalo@kernel.org
Cc:     error27@gmail.com, linux-wireless@vger.kernel.org
References: <20230216004654.4642-1-pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20230216004654.4642-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16/02/2023 02:46, Ping-Ke Shih wrote:
> Intentionally parsing single one element of RA report by breaking loop
> causes a smatch warning:
>   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c:1678 rtl8188e_handle_ra_tx_report2() warn:
>   ignoring unreachable code.
> 
> With existing comments, it intends to process single one element for
> station mode, but it will parse more elements in AP mode if it's
> implemented. Implement program logic according to existing comment to avoid
> smatch warning, and also be usable for both AP and stations modes.
> 
> Compile test only.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202302142135.LCqUTVGY-lkp@intel.com/
> Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c   | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> index a99ddb41cd244..f15b099899e5c 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
> @@ -1699,6 +1699,12 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_priv *priv, struct sk_buff *s
>  
>  	dev_dbg(dev, "%s: len: %d items: %d\n", __func__, tx_rpt_len, items);
>  
> +	/* We only use macid 0, so only the first item is relevant.
> +	 * AP mode will use more of them if it's ever implemented.
> +	 */
> +	if (!priv->vif || priv->vif->type == NL80211_IFTYPE_STATION)
> +		items = 1;
> +
>  	for (macid = 0; macid < items; macid++) {
>  		valid = false;
>  
> @@ -1741,12 +1747,6 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_priv *priv, struct sk_buff *s
>  			min_rpt_time = ra->rpt_time;
>  
>  		rpt += TX_RPT2_ITEM_SIZE;
> -
> -		/*
> -		 * We only use macid 0, so only the first item is relevant.
> -		 * AP mode will use more of them if it's ever implemented.
> -		 */
> -		break;
>  	}
>  
>  	if (min_rpt_time != ra->pre_min_rpt_time) {

Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
