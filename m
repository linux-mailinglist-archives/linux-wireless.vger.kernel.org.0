Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C6A3A4E42
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhFLK5i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 06:57:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37878 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLK5h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 06:57:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623495338; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=fBn0Cjt0QiXmY3PYkDhLPufmmhux4Vuvq4XC/avbJD8=; b=nMuFW/I8+x3aejUmSVTPdvWHBqL3I77RQMi1H8VCKaPD0/AkrB60OdERC+//TXVnkf7ySvFI
 R+P8y4dM7lCeHH2YK5GqYu9CaczAB1/gy4y93mWtgqr2PpVslnzKMdGCnyzGV2iOqWgkCU/q
 qwPq69rZsys22hrzmXVvVZ3N37A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60c49299e27c0cc77f4a8128 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Jun 2021 10:55:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2200BC43217; Sat, 12 Jun 2021 10:55:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 702EEC433F1;
        Sat, 12 Jun 2021 10:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 702EEC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org
Subject: Re: [PATCH] net: wireless: wcn36xx: Handle scan initialization error
References: <1621958739-5557-1-git-send-email-loic.poulain@linaro.org>
Date:   Sat, 12 Jun 2021 13:55:15 +0300
In-Reply-To: <1621958739-5557-1-git-send-email-loic.poulain@linaro.org> (Loic
        Poulain's message of "Tue, 25 May 2021 18:05:39 +0200")
Message-ID: <87a6nvz71o.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> In case firmware is not able to initialize scanning, return
> an error to skip scanning on the channel. Scan initialization
> can fail, if e.g. the firmware is not able to submit the null
> function packet with PS bit set.
>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>

No "net: wireless:" in the title, please.

> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -433,8 +433,11 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
>  			/* A scan is ongoing, do not change the operating
>  			 * channel, but start a scan session on the channel.
>  			 */
> -			wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN,
> -					      wcn->sw_scan_vif);
> +			if (wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN,
> +						  wcn->sw_scan_vif)) {
> +				mutex_unlock(&wcn->conf_mutex);
> +				return -EIO;
> +			}

Why are you rewriting the error code from wcn36xx_smd_init_scan()?

Also I think this style is more readable (which does not rewrite the
error code either):

ret = foo();
if (ret) {
    ...
}

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
