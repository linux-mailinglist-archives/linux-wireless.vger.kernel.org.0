Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21A222C5F2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGXNMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 09:12:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24964 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgGXNMo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 09:12:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595596364; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+qOuyETGDUAk+noiE7nwzixrWA3C1XWM0tBMuyJewdo=; b=Iq3yjjUgkqbnfPSMhCF2NCxlMRW6jHLm/k92oA09ukK+ODvtzCk2fUyEPWfrk3nOc0O9UmxI
 Kp931DgqTHxjORj4ar1taTUF7C9jnS9sztjHVVDB2GgEj9qlIlJZmv/3mTTz7uS6puOQU78D
 fGKyrZ96c+Ulg14AFhH+cEBGtc4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f1ade4b35f3e3d31696fcee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 13:12:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 511B7C433CB; Fri, 24 Jul 2020 13:12:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1D6CC433C6;
        Fri, 24 Jul 2020 13:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1D6CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ramon Fried <ramon.fried@gmail.com>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/6] wcn36xx: Increase number of TX retries
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
        <1595586052-16081-4-git-send-email-loic.poulain@linaro.org>
        <CA+Kvs9nZm+uoRJfjq33s1_nTbPt82NnEKmgYCWk0q5vH+-ca9w@mail.gmail.com>
Date:   Fri, 24 Jul 2020 16:12:39 +0300
In-Reply-To: <CA+Kvs9nZm+uoRJfjq33s1_nTbPt82NnEKmgYCWk0q5vH+-ca9w@mail.gmail.com>
        (Ramon Fried's message of "Fri, 24 Jul 2020 15:50:35 +0300")
Message-ID: <877dut5a60.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ramon Fried <ramon.fried@gmail.com> writes:

> On Fri, Jul 24, 2020 at 1:15 PM Loic Poulain <loic.poulain@linaro.org>
> wrote:
>
>     Increase the short/long retry limit to 15 in order to impove TX
>     robustness in noisy/busy environment. 15 is the default value
>     defined in the downstream driver. Observed number of ack timeout
>     is reduced with this change.
>     
>     Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>     ---
>     drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++--
>     1 file changed, 2 insertions(+), 2 deletions(-)
>     
>     diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c
>     b/drivers/net/wireless/ath/wcn36xx/smd.c
>     index 59f9f53..908cc6c 100644
>     --- a/drivers/net/wireless/ath/wcn36xx/smd.c
>     +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
>     @@ -45,8 +45,8 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[]
>     = {
>     WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 6000),
>     WCN36XX_CFG_VAL(MAX_MPDUS_IN_AMPDU, 64),
>     WCN36XX_CFG_VAL(RTS_THRESHOLD, 2347),
>     - WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 6),
>     - WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 6),
>     + WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 15),
>     + WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 15),
>     WCN36XX_CFG_VAL(FRAGMENTATION_THRESHOLD, 8000),
>     WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ZERO, 5),
>     WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ONE, 10),
>     -- 
>     2.7.4
>     
>     
>     
>
> These set of patches fixed my connectivity issues with TP-Link DECO
> routers. 
> Acked-By: Ramon Fried <rfried.dev@gmail.com> 

HTML emails are dropped by the list, please use text/plain only.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
