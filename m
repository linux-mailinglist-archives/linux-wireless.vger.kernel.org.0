Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353084329DC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 00:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJRWwB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 18:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRWwB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 18:52:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2661AC06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 15:49:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so671856wma.4
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 15:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=08L6ahPiPVZBAM0Pb517B8J7QZf0zGeMvYDZn3F0mnI=;
        b=RAu154yvG9m47SvUAmcGVpcJ1apJ8MzOFMvrNBpyVpDNSecWbaTSkgoQE5kefMmOhq
         OzUyvr9XzccJ2FPkY8/SG9M9S1Xi8mcgLHXmXzYT2tdT81oy+VBc4kEvcTKObNRPj2NO
         qRScTAqBjVp6OVuIxwGG5aYswXNz0ktOHpzDSDaru153LVgaYUMTQGLlwe/5la+sZcA5
         E5VzqDWUroX1iFAMO9098vAHr1wXixQdfbFOyACHHtYB7JOiy3Rp98aJ36tLkkzHnWJ/
         2r1FGvKKcxAtlgj1guE9eh9aMTYzFtIncSR+wmJWEbtZXF+3aprlhUPwCGto9+rad/Te
         8MzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=08L6ahPiPVZBAM0Pb517B8J7QZf0zGeMvYDZn3F0mnI=;
        b=VznnYCPcU2DHlcqRnv/0PCVfCSmRY1V5JLD/sKYVjDfo2Lu3y74v2gRjuv9fDs9Thc
         znitebnVbWPdMdotANbctRiCCufOWT70+XMNFT5fnKJ2adD8nzxWFFDL3+rwIDEN3ekM
         5yN4SPbcckFOpzCZ+kmBUBxKuFpkctXAPM3hCAGpQP/nciXOx8Tcgm+Tu0FYFjTsLAUl
         yx7keRg5GP/RGU/qQulg/6IBVJwNOz2OaHY8VE3k/YiG9Q/CcpxcBFxmf8Eyt3o9CTvZ
         OwBBJeukraiBNO7KNPw9wHQ3zHh0Cz26kI6kwPcuv1BLQD8IJGmk480vYfXKL8YNw2bt
         4Tow==
X-Gm-Message-State: AOAM532wvcT+aD1dT1UBfzxO1UhiCD99gv9AH6FQMVaJMt+fXhuXZDzr
        cyAFNdVRVmkQM+UoGKvRZPUTHUUo5AObwg==
X-Google-Smtp-Source: ABdhPJw6Ewo1IAD0gqAqjJ5hrAfqff08LwucDdK6hJYILy11Uq0z1BnBpOOCzOVCgHrK/L3RE2OVHQ==
X-Received: by 2002:a7b:cb10:: with SMTP id u16mr1895230wmj.65.1634597387672;
        Mon, 18 Oct 2021 15:49:47 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n68sm636275wmn.13.2021.10.18.15.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:49:46 -0700 (PDT)
Message-ID: <d37b9978-7b0f-69ae-9c2f-693baec8bb2b@linaro.org>
Date:   Mon, 18 Oct 2021 23:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/2] wcn36xx: Enable hardware scan offload for 5Ghz band
Content-Language: en-US
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
 <1634554678-7993-2-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1634554678-7993-2-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18/10/2021 11:57, Loic Poulain wrote:
> Until now, offload scanning for 5Ghz channels was considered broken.
> However it was mostly a driver issue, caused by bad reporting of the
> beacons/probe-resp bands and frequencies, which has been fixed.
> 
> We can now allow offload scan for 5GHz band, this reduces the scanning
> time comparing to software driven scanning.
> 
> Note that offloaded scan is limited to 48 channels, check for this.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>   drivers/net/wireless/ath/wcn36xx/main.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index 263af65..2ac8efa 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -659,19 +659,19 @@ static int wcn36xx_hw_scan(struct ieee80211_hw *hw,
>   			   struct ieee80211_scan_request *hw_req)
>   {
>   	struct wcn36xx *wcn = hw->priv;
> -	int i;
>   
>   	if (!get_feat_caps(wcn->fw_feat_caps, SCAN_OFFLOAD)) {
>   		/* fallback to mac80211 software scan */
>   		return 1;
>   	}
>   
> -	/* For unknown reason, the hardware offloaded scan only works with
> -	 * 2.4Ghz channels, fallback to software scan in other cases.
> +	/* Firmware scan offload is limited to 48 channels, fallback to
> +	 * software driven scanning otherwise.
>   	 */
> -	for (i = 0; i < hw_req->req.n_channels; i++) {
> -		if (hw_req->req.channels[i]->band != NL80211_BAND_2GHZ)
> -			return 1;
> +	if (hw_req->req.n_channels > 48) {
> +		wcn36xx_warn("Offload scan aborted, n_channels=%u",
> +			     hw_req->req.n_channels);
> +		return 1;
>   	}
>   
>   	mutex_lock(&wcn->scan_lock);
> 

Really sweet fix, good job

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
