Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7D43149AF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBIHsJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:48:09 -0500
Received: from so15.mailgun.net ([198.61.254.15]:38769 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhBIHsJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:48:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612856864; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=W9E2hKL9FEOwJG8sgNFLZYNgLl8yBkWRrvp0gt3S8CI=; b=c3h2wmbiVx3M7kt2H3vn2IVYnydxlExPnxsFQZQ78afiQnxGV72qekyYPXdt3vif3iBJlKk1
 0gWjKP/xJXRd8yd2rKAqOAxnevxORZJDGDHR8SEhq5HqOZs2qunN+N1MQ2oF6cWI7l4at8I8
 jsJAXQ/7KVjI5OfK6zaBpUOVA1k=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60223e038e43a988b76cf74f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 07:47:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BEB01C433ED; Tue,  9 Feb 2021 07:47:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79DC3C433CA;
        Tue,  9 Feb 2021 07:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79DC3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Peter Oh <peter.oh@eero.com>, kernel-janitors@vger.kernel.org,
        Carl Huang <cjhuang@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v2] ath11k: fix a locking bug in ath11k_mac_op_start()
References: <YBk4GoeE+yc0wlJH@mwanda>
Date:   Tue, 09 Feb 2021 09:47:10 +0200
In-Reply-To: <YBk4GoeE+yc0wlJH@mwanda> (Dan Carpenter's message of "Tue, 2 Feb
        2021 14:31:38 +0300")
Message-ID: <87ft25vg1t.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> This error path leads to a Smatch warning:
>
> 	drivers/net/wireless/ath/ath11k/mac.c:4269 ath11k_mac_op_start()
> 	error: double unlocked '&ar->conf_mutex' (orig line 4251)
>
> We're not holding the lock when we do the "goto err;" so it leads to a
> double unlock.  The fix is to hold the lock for a little longer.
>
> Fixes: c83c500b55b6 ("ath11k: enable idle power save mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: reviewers were concern that v1 was racy
>
>  drivers/net/wireless/ath/ath11k/mac.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index c1608f64ea95..464d3425488b 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -4248,8 +4248,6 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
>  	/* Configure the hash seed for hash based reo dest ring selection */
>  	ath11k_wmi_pdev_lro_cfg(ar, ar->pdev->pdev_id);
>  
> -	mutex_unlock(&ar->conf_mutex);
> -
>  	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx],
>  			   &ab->pdevs[ar->pdev_idx]);
>  
> @@ -4262,6 +4260,9 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
>  			goto err;
>  		}
>  	}
> +
> +	mutex_unlock(&ar->conf_mutex);
> +
>  	return 0;
>  
>  err:
> -- 
> 2.30.0

But now rcu_assign_pointer() is called while conf_mutex is held,
previously it was not. I didn't check if this creates problems, but just
to be on the safe side I modified your patch to keep the original
functionality. Please check my changes in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=8eff3667c211072a2107271139b81cbf8c7fd10a

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
