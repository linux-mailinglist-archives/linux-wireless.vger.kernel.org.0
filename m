Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2AE439E81
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhJYS3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 14:29:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56501 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhJYS3k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 14:29:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635186438; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KzQ2+/Rby5ZxsebPn9QGuKsSU/kOnY4P/ULkv1aLk6s=; b=vUG/gMXS3OOAkOl/8KSZtDB8spTJwgvUeEx+RYFwTbbwCGNEJ9deXaPaH7rCrbpcLfbn/JA9
 LXNSuPjlEakICGIAuybK0sx79xV4YS0EFwSed/xA0aLe3imO71Q1r738ktm77PE/+1KUKzHo
 X1k5FgQqk1B25/XAkmfRCO3qwMg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6176f705321f24005126127c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 18:27:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67599C4360D; Mon, 25 Oct 2021 18:27:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6D7DC4338F;
        Mon, 25 Oct 2021 18:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C6D7DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        bryan.odonoghue@linaro.org
Subject: Re: [PATCH v2] wcn36xx: Channel list update before hardware scan
References: <1635175328-25642-1-git-send-email-loic.poulain@linaro.org>
Date:   Mon, 25 Oct 2021 21:27:12 +0300
In-Reply-To: <1635175328-25642-1-git-send-email-loic.poulain@linaro.org> (Loic
        Poulain's message of "Mon, 25 Oct 2021 17:22:08 +0200")
Message-ID: <87ee899czj.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> The channel scan list must be updated before triggering a hardware scan
> so that firmware takes into account the regulatory info for each single
> channel such as active/passive config, power, DFS, etc... Without this
> the firmware uses its own internal default channel configuration, which
> is not aligned with mac80211 regulatory rules, and misses several
> channels (e.g. 144).
>
> Fixes: 2f3bef4b247e ("wcn36xx: Add hardware scan offload support")
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: Use u32_replace_bits() for setting channel update fields
>
>  drivers/net/wireless/ath/wcn36xx/hal.h  | 32 +++++++++++++
>  drivers/net/wireless/ath/wcn36xx/main.c |  1 +
>  drivers/net/wireless/ath/wcn36xx/smd.c  | 82 +++++++++++++++++++++++++++++++++
>  drivers/net/wireless/ath/wcn36xx/smd.h  |  1 +
>  4 files changed, 116 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
> index 5f1f248..9bea2b0 100644
> --- a/drivers/net/wireless/ath/wcn36xx/hal.h
> +++ b/drivers/net/wireless/ath/wcn36xx/hal.h
> @@ -359,6 +359,8 @@ enum wcn36xx_hal_host_msg_type {
>  	WCN36XX_HAL_START_SCAN_OFFLOAD_RSP = 205,
>  	WCN36XX_HAL_STOP_SCAN_OFFLOAD_REQ = 206,
>  	WCN36XX_HAL_STOP_SCAN_OFFLOAD_RSP = 207,
> +	WCN36XX_HAL_UPDATE_CHANNEL_LIST_REQ = 208,
> +	WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP = 209,
>  	WCN36XX_HAL_SCAN_OFFLOAD_IND = 210,
>  
>  	WCN36XX_HAL_AVOID_FREQ_RANGE_IND = 233,
> @@ -1353,6 +1355,36 @@ struct wcn36xx_hal_stop_scan_offload_rsp_msg {
>  	u32 status;
>  } __packed;
>  
> +#define WCN36XX_HAL_CHAN_REG1_MIN_PWR_MASK  0x000000ff
> +#define WCN36XX_HAL_CHAN_REG1_MAX_PWR_MASK  0x0000ff00
> +#define WCN36XX_HAL_CHAN_REG1_REG_PWR_MASK  0x00ff0000
> +#define WCN36XX_HAL_CHAN_REG1_CLASS_ID_MASK 0xff000000
> +#define WCN36XX_HAL_CHAN_REG2_ANT_GAIN_MASK 0x000000ff

Usually people use GENMASK() but these masks are so simple that I guess
this is fine as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
