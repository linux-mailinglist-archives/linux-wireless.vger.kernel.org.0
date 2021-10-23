Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9FC4382B5
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhJWJ4J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhJWJ4I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:56:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B34C061767
        for <linux-wireless@vger.kernel.org>; Sat, 23 Oct 2021 02:53:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v17so1271902wrv.9
        for <linux-wireless@vger.kernel.org>; Sat, 23 Oct 2021 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tLEUfVhaDWp4OwmTFc7w3FrsNdUkC3A1CsKAQ60ZYsI=;
        b=RCQbvFmpEDM7OfDrUhK5FEK4+iKN8U+oeK/J2gWF4EK2lmX+KMf2c1SdtxEbYGwpIR
         dA2PoziDFLz3rmpiyeudghfcLBBq8RaWBuJZ/Vts55l/+Yivgy/2vagT2miT6raGn7lq
         EaNCuwpMXUJCdj4FICc3mZN2LRzfaVTYksfPfkF5oqjc+hRtwBsv6TpQP9u5QngXjFje
         7nZpQRkln/xfofTNDsRvjyz2Uln5DEhtwUhFG24HqfcH5zkSmRS/LMkeoeK3DCgid0Pu
         Idm2Y74MWwPlgB3txWBbOLgXF/GCf371JVdmTW5w2ZQUjWKm7NxQuHgn0dXRRxYc5CKz
         56Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tLEUfVhaDWp4OwmTFc7w3FrsNdUkC3A1CsKAQ60ZYsI=;
        b=TMgLZJwXAj1by6PhW/y6WNW86NpYGNIgT5QCP9N9GnjJfuZ0HAVcQdjCiD/1x06JPq
         qo3Vn3rolko0/hIrSB+hhbD7ILdY38ClMAOpqVq6vzKyrNTA+a0rJQOt9cIEq8mdie95
         X5KlRiDMie76BMGUTD+0ef1yaadQXsu11CKcTwH+M5I5cCgbulVuoWuPvCRhLxTbvHx3
         JzsUzBsPk+E9RHhqOSztEZ8wVntgXu5KBsQ6Ltb7hzhgkXwzjF05UeCoKO5S8Ivkgzbo
         gmVZOFvs3ZS0dGLKByWLArv5jQfy49+4dNiRKsqHj0X7sBRGwiRiNaBZVcSAJ7kN8NET
         95hA==
X-Gm-Message-State: AOAM53126jDpiYHVEBcJGKwHNhwPOHaDXgViaA9NCEcBuAonorNjolq9
        8LFQe89+08otn+hFeZfDzVYT2w==
X-Google-Smtp-Source: ABdhPJwEezcVRcVFKWLFEMF1rpA0ueoOO4uTdT37OlZWy/RfmP8+IZ/Pguz8Pk+6u45gDuVsJ9oESw==
X-Received: by 2002:a5d:6c65:: with SMTP id r5mr6630830wrz.26.1634982827717;
        Sat, 23 Oct 2021 02:53:47 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h22sm11290195wmq.42.2021.10.23.02.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 02:53:46 -0700 (PDT)
Message-ID: <f060ea87-12d8-afaf-fc7d-2b2fd461b7e7@linaro.org>
Date:   Sat, 23 Oct 2021 10:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/2] wcn36xx: add missing 5GHz channels 136 and 144
Content-Language: en-US
To:     Benjamin Li <benl@squareup.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211022235738.2970167-1-benl@squareup.com>
 <20211022235738.2970167-3-benl@squareup.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20211022235738.2970167-3-benl@squareup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 23/10/2021 00:57, Benjamin Li wrote:
> These channels missing from scan results are a regression from downstream
> prima.
> 
> Signed-off-by: Benjamin Li <benl@squareup.com>
> ---
>   drivers/net/wireless/ath/wcn36xx/main.c | 2 ++
>   drivers/net/wireless/ath/wcn36xx/smd.c  | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index 263af65a889a..13d09c66ae92 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -85,7 +85,9 @@ static struct ieee80211_channel wcn_5ghz_channels[] = {
>   	CHAN5G(5620, 124, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
>   	CHAN5G(5640, 128, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_HIGH),
>   	CHAN5G(5660, 132, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
> +	CHAN5G(5680, 136, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_LOW),
>   	CHAN5G(5700, 140, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
> +	CHAN5G(5720, 144, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_HIGH),
>   	CHAN5G(5745, 149, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
>   	CHAN5G(5765, 153, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_LOW),
>   	CHAN5G(5785, 157, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> index be6442b3c80b..9785327593d2 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -2396,6 +2396,7 @@ int wcn36xx_smd_feature_caps_exchange(struct wcn36xx *wcn)
>   	set_feat_caps(msg_body.feat_caps, STA_POWERSAVE);
>   	if (wcn->rf_id == RF_IRIS_WCN3680) {
>   		set_feat_caps(msg_body.feat_caps, DOT11AC);
> +		set_feat_caps(msg_body.feat_caps, WLAN_CH144);
>   		set_feat_caps(msg_body.feat_caps, ANTENNA_DIVERSITY_SELECTION);
>   	}
>   
> 

LGTM

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
