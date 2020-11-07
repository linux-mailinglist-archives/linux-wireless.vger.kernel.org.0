Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3542AA327
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgKGICn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:02:43 -0500
Received: from z5.mailgun.us ([104.130.96.5]:40655 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgKGICn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:02:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604736163; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Dze6yiFyX80WT4DfxYCWtJQqkOwt1Zw4tJhevbXewfE=;
 b=MR9WVLys0LoU+An5206OAtdQi5U+CBy6yob7ojPcBk0IG5xVXjUOQkIYFBcMWSPNt4H5i0Fl
 KmvhJtV6vBH6P6uO5OGMg2jDGtIpEIT4gbYTZAOx08yYbRqwcxkQC0oTL/XYZ03jAKsT7efm
 JGGYxSsX9+uE7+vKotlyUNs1HUg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fa654a202f4ee3801b25537 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 08:02:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5DC1C433C9; Sat,  7 Nov 2020 08:02:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35C8AC433C6;
        Sat,  7 Nov 2020 08:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35C8AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Initialize complete alpha2 for regulatory change
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201021140555.4114715-1-sven@narfation.org>
References: <20201021140555.4114715-1-sven@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <sven@narfation.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107080241.C5DC1C433C9@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 08:02:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> The function ath11k_wmi_send_init_country_cmd is taking 3 byte from alpha2
> of the structure wmi_init_country_params. But the function
> ath11k_reg_notifier is only initializing 2 bytes. The third byte is
> therefore always an uninitialized value.
> 
> The command can happen to look like
> 
>   0c 00 87 02 01 00 00 00 00 00 00 00 43 41 f8 00
> 
> instead of
> 
>   0c 00 87 02 01 00 00 00 00 00 00 00 43 41 00 00
> 
> Tested-on: IPQ8074 hw2.0 WLAN.HK.2.1.0.1-01161-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2
> Tested-on: IPQ8074 hw2.0 WLAN.HK.2.4.0.1.r1-00019-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

383a32cde417 ath11k: Initialize complete alpha2 for regulatory change

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201021140555.4114715-1-sven@narfation.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

