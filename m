Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8D82F119C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbhAKLjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:39:16 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:51903 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbhAKLjQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:39:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610365136; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=pQACgeh06jM/Va/IEKYEEoBFT3+M6M/Rt7XK3ZlSC7o=; b=WO2Ehf/5OXgVVHmEjg8Gyxbjt38/XFRSJbLUPLQ39VIu9YNsGF25CXVBcFnCHIIrRY4R+YEd
 qpMysJ5E/Texy3j2POMoxALpmFRZwS2emLWjyEmK7SOhhAHbjeZb7zkpeE3yOqiIWAtACQDS
 iWfqgmrcH9YJn/ydX5UArrbG9SE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ffc38aad84bad35476206c6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:38:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 609B6C433CA; Mon, 11 Jan 2021 11:38:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20886C433ED;
        Mon, 11 Jan 2021 11:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20886C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
Subject: Re: [PATCH 07/13] wcn36xx: Flag WIPHY_WOWLAN_MAGIC_PKT
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
        <20201228162839.369156-8-bryan.odonoghue@linaro.org>
Date:   Mon, 11 Jan 2021 13:38:14 +0200
In-Reply-To: <20201228162839.369156-8-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Mon, 28 Dec 2020 16:28:33 +0000")
Message-ID: <87o8hvk8k9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> Set a flag to indicate magic packet wakeup support on wcn36xx.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c
> b/drivers/net/wireless/ath/wcn36xx/main.c
> index 579bb7f4db9c..cfa2e2d20a20 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -173,7 +173,7 @@ static struct ieee80211_supported_band wcn_band_5ghz = {
>  #ifdef CONFIG_PM
>  
>  static const struct wiphy_wowlan_support wowlan_support = {
> -	.flags = WIPHY_WOWLAN_ANY
> +	.flags = WIPHY_WOWLAN_ANY | WIPHY_WOWLAN_MAGIC_PKT
>  };

Shouldn't this be the last patch so that we don't enable the feature
until it's fully implemented? This makes a difference when doing a
bisect, for example.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
