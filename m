Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9BF2E6C28
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 00:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgL1Wzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 17:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgL1Vrx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 16:47:53 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69218C0613D6
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 13:47:13 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id w5so8026227pgj.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 13:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WuiqFEJ4tkRy/yEjUqfTM8SERNnVSrxan3MgAiYte+U=;
        b=Wc36IUOn31vokNIAQTJfLWHQXlYzMw2DYRm20fxKr52eYtn4E5mHLfoDfg/TQzSFP1
         Ui+4it4ot17L6tJRxux8jMT4OJbqHGBrYpnrWmH9FdpAoWCk7gdgTxWgMmrGMhRW38bB
         Yjn6QUJ+bhDd4Pv7xfaZSh0dm0wzLyZuUOW5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WuiqFEJ4tkRy/yEjUqfTM8SERNnVSrxan3MgAiYte+U=;
        b=uHcAmmyQ5lvbbXpcDbuPU3Zot87Iikdk7FTEVOmrydk6zRAMQmNFnPaKZRHgyYSjUb
         hawQ+6GwO7XA4+/c2vlZFW7r9fS2zCZXenh99BSBKKT4iCw4IIOqhQV1+YCPwn9EhuaD
         dI/tspTLRPeZ2hmfo0gEwIQ/yBNDQ6GiMatPQO7HILNtxmwX9ffciJKXjPHsqcCL/jIj
         p1eRlEcYz48pT/d4a+n4cy3JMHfjZjocbun9csQjWfAiWKnxbHcPa7yAHrGROZkJ6isD
         uSi5s6ZFAd0JCv4rr8XEogRFQdw99Sm9D6pdoBlHYUs+mI97xUCMhXdBbc96HnFqwOYC
         bN1A==
X-Gm-Message-State: AOAM5325eUXqLW042DpHaW5qMETDum6MMGFL0Wco4uBCDzC9g1+riRnv
        bZF11zmPUu15Hy3nWLOzTnWvkg==
X-Google-Smtp-Source: ABdhPJyJY3encssKxCCQEIepFDoSWvjFr8na3kG8vvYCRzSGIwFYqD+lszk9IFuRly6hxGXNaJ44zA==
X-Received: by 2002:a65:6382:: with SMTP id h2mr6945380pgv.365.1609192032583;
        Mon, 28 Dec 2020 13:47:12 -0800 (PST)
Received: from benl-m5lvdt.local ([2600:1700:87d0:94f:c435:86a:a4fb:63d1])
        by smtp.gmail.com with ESMTPSA id q12sm39496587pgj.24.2020.12.28.13.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 13:47:11 -0800 (PST)
Subject: Re: [PATCH 11/13] wcn36xx: Do not suspend if scan in progress
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     shawn.guo@linaro.org, loic.poulain@linaro.org
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
 <20201228162839.369156-12-bryan.odonoghue@linaro.org>
From:   Benjamin Li <benl@squareup.com>
Message-ID: <28991a8a-7d0a-c3a4-2b74-05755cfd7113@squareup.com>
Date:   Mon, 28 Dec 2020 13:47:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201228162839.369156-12-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 12/28/20 8:28 AM, Bryan O'Donoghue wrote:
> If a scan is in progress do not attempt to enter into suspend. Allow the
> scan process to quiesce before proceeding.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/net/wireless/ath/wcn36xx/main.c    |  5 +++++
>   drivers/net/wireless/ath/wcn36xx/smd.c     | 13 +++++++++++++
>   drivers/net/wireless/ath/wcn36xx/smd.h     |  2 ++
>   drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
>   4 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index b48a3f0dcc0b..feb909192c8e 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1113,6 +1113,11 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
>   
>   	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
>   
> +	if (wcn36xx_smd_is_scanning(wcn)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +

Should just be a return, since we haven't locked conf_mutex yet?

>   	mutex_lock(&wcn->conf_mutex);
>   	vif = wcn36xx_get_first_vif(wcn);
>   	if (vif) {
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> index dd12575f33c3..378282a93aa0 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -731,6 +731,7 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
>   		wcn36xx_err("hal_init_scan response failed err=%d\n", ret);
>   		goto out;
>   	}
> +	wcn->scanning = true;
>   out:
>   	mutex_unlock(&wcn->hal_mutex);
>   	return ret;
> @@ -807,6 +808,7 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
>   	mutex_lock(&wcn->hal_mutex);
>   	INIT_HAL_MSG(msg_body, WCN36XX_HAL_FINISH_SCAN_REQ);
>   
> +	wcn->scanning = false;
>   	msg_body.mode = mode;
>   	msg_body.oper_channel = WCN36XX_HW_CHANNEL(wcn);
>   	if (vif_priv->bss_index != WCN36XX_HAL_BSS_INVALID_IDX) {
> @@ -938,6 +940,17 @@ int wcn36xx_smd_stop_hw_scan(struct wcn36xx *wcn)
>   	return ret;
>   }
>   
> +bool wcn36xx_smd_is_scanning(struct wcn36xx *wcn)
> +{
> +	bool scanning;
> +
> +	mutex_lock(&wcn->hal_mutex);
> +	scanning = wcn->scanning;
> +	mutex_unlock(&wcn->hal_mutex);
> +
> +	return scanning;
> +}
> +
>   static int wcn36xx_smd_switch_channel_rsp(void *buf, size_t len)
>   {
>   	struct wcn36xx_hal_switch_channel_rsp_msg *rsp;
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
> index b225c805107c..3488abb201d0 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.h
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.h
> @@ -159,4 +159,6 @@ int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
>   int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
>   				     struct ieee80211_vif *vif);
>   
> +bool wcn36xx_smd_is_scanning(struct wcn36xx *wcn);
> +
>   #endif	/* _SMD_H_ */
> diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> index 6121d8a5641a..36ea768a5203 100644
> --- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> +++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> @@ -249,6 +249,7 @@ struct wcn36xx {
>   	struct ieee80211_vif	*sw_scan_vif;
>   	struct mutex		scan_lock;
>   	bool			scan_aborted;
> +	bool			scanning;
>   
>   	/* DXE channels */
>   	struct wcn36xx_dxe_ch	dxe_tx_l_ch;	/* TX low */
> 
