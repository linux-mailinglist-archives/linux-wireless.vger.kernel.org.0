Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E5E4397B8
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 15:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhJYNnp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 09:43:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35058 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhJYNnn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 09:43:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635169281; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6N7Dt3qUFoWr7gkrdnctcmk+MKsEWdEdMFG4FtN4fLQ=; b=rMHnwrnwW1bTh/h6QJmaLuLbmX0DNVisGQosEljcjekposnFmdebRi43JZbVbllGtxH1ozmy
 iiFkzyQ+ul1jDg/nkX1N0YyHYQOaHGK2GMDqBSMIGAc83mRftf3kkmpCeTU3S3k3WgTmiVRl
 HAXfs/pzGaO/0qJksLWIj4hHLiE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6176b3fefd91319f0f3d7cdf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 13:41:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F771C4360C; Mon, 25 Oct 2021 13:41:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF9F7C4338F;
        Mon, 25 Oct 2021 13:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org EF9F7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org
Subject: Re: [PATCH 1/2] wcn36xx: Treat repeated BMPS entry fail as connection loss
References: <20211022140447.2846248-1-bryan.odonoghue@linaro.org>
        <20211022140447.2846248-2-bryan.odonoghue@linaro.org>
Date:   Mon, 25 Oct 2021 16:41:13 +0300
In-Reply-To: <20211022140447.2846248-2-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Fri, 22 Oct 2021 15:04:46 +0100")
Message-ID: <87ilxl9q86.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> On an open AP when you pull the plug on the AP, if we are not already in
> BMPS mode then the firmware will not generate a disconnection event.
>
> Instead we need to monitor for failure to enter BMPS and treat a string of
> failures as connection loss.
>
> Secure AP connections don't appear to demonstrate this behavior so the
> work-around is limited to open APs only.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/pmc.c     | 9 +++++++++
>  drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/pmc.c b/drivers/net/wireless/ath/wcn36xx/pmc.c
> index 2d0780fefd477..592a9416e51f9 100644
> --- a/drivers/net/wireless/ath/wcn36xx/pmc.c
> +++ b/drivers/net/wireless/ath/wcn36xx/pmc.c
> @@ -18,6 +18,8 @@
>  
>  #include "wcn36xx.h"
>  
> +#define WCN36XX_BMPS_FAIL_THREHOLD 3
> +
>  int wcn36xx_pmc_enter_bmps_state(struct wcn36xx *wcn,
>  				 struct ieee80211_vif *vif)
>  {
> @@ -31,6 +33,7 @@ int wcn36xx_pmc_enter_bmps_state(struct wcn36xx *wcn,
>  	if (!ret) {
>  		wcn36xx_dbg(WCN36XX_DBG_PMC, "Entered BMPS\n");
>  		vif_priv->pw_state = WCN36XX_BMPS;
> +		vif_priv->bmps_fail_ct = 0;
>  		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
>  	} else {
>  		/*
> @@ -39,6 +42,12 @@ int wcn36xx_pmc_enter_bmps_state(struct wcn36xx *wcn,
>  		 * received just after auth complete
>  		 */
>  		wcn36xx_err("Can not enter BMPS!\n");
> +
> +		if (vif_priv->bmps_fail_ct++ == WCN36XX_BMPS_FAIL_THREHOLD) {
> +			wcn36xx_err("BMPS fail exceeded connection loss\n");
> +			ieee80211_connection_loss(vif);

We shouldn't spam the kernel log when a connection to AP is lost, that's
a normal situation with wireless networks. So I removed the
wcn36xx_err() call in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
