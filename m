Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9F2DBD45
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 10:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgLPJG7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 04:06:59 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:11531 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLPJG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 04:06:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608109593; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=QIAiSIfGteTfftpeFpmU8XTLiCAnt6Lfk6Zo648dcP8=; b=LX4JdKkPJw15qIZloNz2jcKUQ9MdcUFrUqD3u0CUVKJ1X0/QKJ/L0WkiRkvFzsOWJgkGQbO4
 vDjgeDi5BljG6SGmpEoVQj//W6vMywGm8HGxUuh0gDx1wcTEOkX9QbFQQTdu/X8qnUT75vDW
 JtK1qme/K/VR7ageGaeDmDAJg3c=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fd9ce000564dfefcd1901e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Dec 2020 09:06:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A3ACC433C6; Wed, 16 Dec 2020 09:06:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E3F4C433C6;
        Wed, 16 Dec 2020 09:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E3F4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Carl Huang <cjhuang@codeaurora.org>,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 1/2] ath11k: Fix error code in ath11k_core_suspend()
References: <X9nF17L2/EKOSbn/@mwanda>
Date:   Wed, 16 Dec 2020 11:06:03 +0200
In-Reply-To: <X9nF17L2/EKOSbn/@mwanda> (Dan Carpenter's message of "Wed, 16
        Dec 2020 11:31:19 +0300")
Message-ID: <87h7omxgqs.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> The "if (!ret)" condition is inverted and it should be "if (ret)".  It
> means that we return success when we had intended to return an error
> code.
>
> Fixes: d1b0c33850d2 ("ath11k: implement suspend for QCA6390 PCI devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index b97c38b9a270..350b7913622c 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -185,7 +185,7 @@ int ath11k_core_suspend(struct ath11k_base *ab)
>  	ath11k_hif_ce_irq_disable(ab);
>  
>  	ret = ath11k_hif_suspend(ab);
> -	if (!ret) {
> +	if (ret) {
>  		ath11k_warn(ab, "failed to suspend hif: %d\n", ret);
>  		return ret;
>  	}

I suspect I created these bugs while cleaning up the patches. But I
don't get how I missed them in testing, that's a mystery to me.

Anyway, I'll queue these two to v5.11.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
