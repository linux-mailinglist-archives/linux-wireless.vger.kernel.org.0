Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55E71D6552
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2020 04:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgEQC0B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 22:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgEQC0B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 22:26:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2BC061A0C
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 19:26:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so3042522pfx.7
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 19:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZwOdLRAvpywpS5KSJQV24hlDOCj/cM29xK3RoHEqVVY=;
        b=emhST+MX89k9qmf7vkyGfPWjnfUERVxmnQrAXJkoMulGTi3izdD5RMz+O08lv/V4rc
         3DcyJnkmTwB77yuG6Bgfi8jdU5j8rXVz9iyQgxuyHWcg/FdXeD/FPLRZpcTOUrTvCboR
         HVeE3XW7O0S9rAk04H2ACSF8cvS0QoHmtmHGZyt9xV3rGFGiEZsCO8BzbG1fJTRdf/i+
         tF0GF3vVdosrKHONtPnDQi7kh2mNfz5fESIYYBjGLqNU9aqpaPwgp9p9+Bn7jTSa0V72
         KuT+G1azxyAmBWhc7gLcW9KutX7ZFYC+i+Z1GG8baias4bJMzVBbfIDJ65ciCYDnKN7Q
         +PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZwOdLRAvpywpS5KSJQV24hlDOCj/cM29xK3RoHEqVVY=;
        b=lT65WZhA6/vFIoGXiYu6cclJOY5UGqoH3tXL+nU7WBVvlZO0fvFc1dws5UYshN8DpL
         S+rd4gwIbhBqevEfofNURDL/n2XyYB7J+IVj4Gm2BZ4x4V5kfiZSEE8xljaLabUqtfL3
         VB/H5qLJoj2S9922qO4HDiHeGDeSy1/ci++xiwbkSvTRW3DG0Ji/kg8z/CEpDJWMrZC6
         EuvSBTzuIxZGPnL77vpOAbJhFqL1WaPq67Hmomzg7jVOvPMtole7ZgJJNSItwnzeglOX
         vPROpd8Nz2qhLV3ZzvPtq2aZpqxdNbWj7fw5pKEIgasZHubjZaj9dIpgl6QE6B2328uH
         T/mw==
X-Gm-Message-State: AOAM532tlKRi+GI0mlD+IKYv0RlWjCfImAYT74KiYN3a8kskkwulyHBQ
        7+ENnp0IHpGz1p0+ymGhwyxM3K8Y
X-Google-Smtp-Source: ABdhPJzabQluLs+prH8Qg4LrI4YiZfIFvmKIwmbo9yMD46wbwp5cKSY5tGxMeYxLMW+GStz77g88yg==
X-Received: by 2002:a63:3206:: with SMTP id y6mr9407775pgy.68.1589682360058;
        Sat, 16 May 2020 19:26:00 -0700 (PDT)
Received: from [10.211.55.7] ([112.209.98.11])
        by smtp.gmail.com with ESMTPSA id x62sm5159477pfc.46.2020.05.16.19.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 19:25:59 -0700 (PDT)
Subject: Re: [PATCHv4] ath10k : Fix channel survey dump
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1588820612-15884-1-git-send-email-vnaralas@codeaurora.org>
From:   John Deere <24601deerej@gmail.com>
Message-ID: <edbb46d6-d7c1-7317-fc1f-cb06bc850c8a@gmail.com>
Date:   Sun, 17 May 2020 10:25:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588820612-15884-1-git-send-email-vnaralas@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 5/7/20 11:03 AM, Venkateswara Naralasetty wrote:
> Channel active/busy time are showing incorrect(less than previous or
> sometimes zero) for successive survey dump command.
> 
> example:
> Survey data from wlan0
> 	frequency:                      5180 MHz [in use]
> 	channel active time:            54995 ms
> 	channel busy time:              432 ms
> 	channel receive time:           0 ms
> 	channel transmit time:          59 ms
> Survey data from wlan0
> 	frequency:                      5180 MHz [in use]
> 	channel active time:            32592 ms
> 	channel busy time:              254 ms
> 	channel receive time:           0 ms
> 	channel transmit time:          0 ms
> 
> This patch fix this issue by assigning 'wmi_bss_survey_req_type'
> as 'WMI_BSS_SURVEY_REQ_TYPE_READ' which accumulate survey data in
> FW and send survey data to driver upon the driver request. Wrap around
> is taken care by FW.
> 
> hardware used : QCA9984
> firmware ver  : ver 10.4-3.5.3-00057
> 
> hardware used : QCA988X
> firmware ver  : 10.2.4-1.0-00047
> 
> Tested-by: Markus Theil <markus.theil@tu-ilmenau.de>
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
> ---
> v4:
>   * updated signed-off-by
> 
> v3:
>   * Rebased on TOT and added Tested-by
> 
>   drivers/net/wireless/ath/ath10k/mac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index a1147cc..9330b52 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -7275,7 +7275,7 @@ ath10k_mac_update_bss_chan_survey(struct ath10k *ar,
>   				  struct ieee80211_channel *channel)
>   {
>   	int ret;
> -	enum wmi_bss_survey_req_type type = WMI_BSS_SURVEY_REQ_TYPE_READ_CLEAR;
> +	enum wmi_bss_survey_req_type type = WMI_BSS_SURVEY_REQ_TYPE_READ;
>   
>   	lockdep_assert_held(&ar->conf_mutex);
>   
> 


I have tested this on a QCA9980 device on a TP-Link Archer A7v5 with the 
firmware version 10.2.4.70.70.

[root@Archer-A7v5 ~]# uptime
  10:18:40 up 7 days,  3:52,  load average: 0.03, 0.01, 0.00


It has been working fine:

Survey data from wlan0
	frequency:			5240 MHz [in use]
	noise:				-101 dBm
	channel active time:		593724580 ms
	channel busy time:		9706985 ms
	channel receive time:		2053580 ms
	channel transmit time:		6473058 ms

Tested-by: John Deere <24601deerej@gmail.com>
