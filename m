Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5ED2517D4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgHYLkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 07:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgHYLj7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 07:39:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D0EC061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 04:39:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t2so2097204wma.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jukB4zz6dwC5ey5IRBypMctEG1CK3rIG/3PkqkNzlVU=;
        b=vzJH3vbky8C5YVfoDZYsRFc7vVgRnSxYw8tlBZf84LlDnDTr7e1udj8jfUp3X8vk8A
         QW+U35IUpu5BCDOXS20iloP2MLTTDiM/T2Yd8+ONZH795kPzJfiYZlSmxbJnpshjjHCL
         OEL2UuY/hqpyqmXJ2DSctiX9vv1yq1BvYlHDVxJCc7xdScXUJC5b0d41hUjNfhhqDWA5
         BtrsHoqnh4HxC+JRoXVRIppddE4kxs4cvZyMBNdalISDl3imfc5/66yFi6ngAbhJqjy5
         6eu+QthGjXNNgmERURvqx/oemlzwQOTOUO7HUwnO+llIp32xnafV0RC0fT57/fkB/8Al
         Tn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jukB4zz6dwC5ey5IRBypMctEG1CK3rIG/3PkqkNzlVU=;
        b=rFDuMAibL2DFRrvhoMktjT6qiv2Iiz9jCrGlikmwSSMkSfjMq79QMbroXZAR531QyI
         Ck7mNagRcfFw4dnO+XPRYXFVCpWpRAoS8Y46ZXVAOqNGfwMC6bxxoZHDQoGPvThe8Txn
         Vc9454pKMeRzd784TzZEh9rwPAYh7fQBUat7/CqFEyIQjs9ysru3G4Rrhyd9jWAmbMZZ
         JbO4ALbczk1xugf6HLElLDHqqdy+9UhuLPdq/4mpKQPkyx+MFObSzuRcl6azWpPvvPPP
         HMLSxysh4J9AGSfp0pCn2d8tBImHfLjpWOZgLRv8eZmCJhdjyhUww+oeVaxONmh2kC3r
         7z0A==
X-Gm-Message-State: AOAM530mzIh6pLxQpB++vY2SNnUhXwqwdh+O9VqLM5trVgmnYVWVO0Ji
        f3BjP/iLqI4AqfXpvjEbmF5QQyMmR+ml31jb
X-Google-Smtp-Source: ABdhPJxS/xdz42wio1PRNg1SQOuLGeXRcvGy4ZAnZKOJSYCFWXZgXZOaipo3TFGWiAmBppuHKApdhQ==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr1632698wmi.139.1598355597907;
        Tue, 25 Aug 2020 04:39:57 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k15sm27470005wrp.43.2020.08.25.04.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 04:39:57 -0700 (PDT)
Subject: Re: [PATCH] wcn36xx: Setup starting bitrate to MCS-5
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1598345341-4505-1-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <23c5eccc-a23e-0b14-ba16-ce6de7a3fb11@linaro.org>
Date:   Tue, 25 Aug 2020 12:40:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598345341-4505-1-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/08/2020 09:49, Loic Poulain wrote:
> By default, after associated to an AP, the wcn36xx bitrate adjustment
> algorithm starts sending data at 1Mbps, and increases the rate slowly
> (1Mbps, 2Mbps, 6Mbps...) over the further TX packets.
> 
> Starting at 1Mbps usually causes the initial throughput to be really
> low and the maximum possible bitrate to be reached after about hundreed
> of TX packets.
> 
> That can be improved by setting a different initial bitrate for data
> packets via the ENABLE_DYNAMIC_RA_START_RATE configuration value, this
> value can be a legacy or MCS rate.
> 
> This patch sets the starting bitrate value to MCS-5, which seems to be
> a good compromise given it can be quickly adjusted low or up if necessary.
> (and based on what I observed in the wild with some mobile devices)
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>   drivers/net/wireless/ath/wcn36xx/hal.h | 8 ++++++++
>   drivers/net/wireless/ath/wcn36xx/smd.c | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
> index 6ba0fd5..88e1ed5 100644
> --- a/drivers/net/wireless/ath/wcn36xx/hal.h
> +++ b/drivers/net/wireless/ath/wcn36xx/hal.h
> @@ -728,6 +728,14 @@ enum pe_stats_mask {
>   #define WCN36XX_HAL_CFG_ENABLE_TDLS_OXYGEN_MODE		104
>   #define WCN36XX_HAL_CFG_MAX_PARAMS			105
>   
> +/* Specify the starting bitrate, 11B and 11A/G rates can be specified in
> + * multiples of 0.5 So for 5.5 mbps => 11. for MCS 0 - 7 rates, Bit 7 should
> + * set to 1 and Bit 0-6 represent the MCS index. so for MCS2 => 130.
> + * Any invalid non-zero value or unsupported rate will set the start rate
> + * to 6 mbps.
> + */
> +#define WCN36XX_HAL_CFG_ENABLE_DYNAMIC_RA_START_RATE	210
> +
>   /* Message definitons - All the messages below need to be packed */
>   
>   /* Definition for HAL API Version. */
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> index 9864c6f..83247d3 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -77,6 +77,7 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
>   	WCN36XX_CFG_VAL(BTC_STATIC_LEN_LE_WLAN, 30000),
>   	WCN36XX_CFG_VAL(MAX_ASSOC_LIMIT, 10),
>   	WCN36XX_CFG_VAL(ENABLE_MCC_ADAPTIVE_SCHEDULER, 0),
> +	WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 133), /* MCS 5 */
>   };
>   
>   static int put_cfg_tlv_u32(struct wcn36xx *wcn, size_t *len, u32 id, u32 value)
> 

Interesting.

I did this to the wcn3680 config I have, which if I've understood your 
description right is MCS8 default

+       WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 136),

I'd say anecdotally I get up to higher data-rates faster. So its 
probably the right thing to do on the 3620/3660 too.

I'll rebase my 3680 patches since this patch will conflict
