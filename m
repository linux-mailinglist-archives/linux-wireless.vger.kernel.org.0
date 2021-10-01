Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A7541E771
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 08:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhJAGUv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 02:20:51 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29692 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352143AbhJAGUt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 02:20:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633069145; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=vFrl5Qa6NHWAHNL9PUWTDNcJIOV8l6E7VKSTe+6fk8g=; b=j2xF2j67TATxxu+hN5QXsRPBMNYPv/YfrgH8YzrZi3+3p0ZNk12Lhi8j2FIhFStvTZ8WY70B
 7wC/fK6Z88kKSGpeMMKbZYXfhU+ScBKHbYL16DW8s4o/fxwiPvQCQt7E9a6fKbbZWCIAr9f0
 inVzLCqtsydbULydWS9rSfA9vSE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6156a852713d5d6f96fdbbe3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 06:18:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9652C4360D; Fri,  1 Oct 2021 06:18:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C41ECC4338F;
        Fri,  1 Oct 2021 06:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C41ECC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH] rtw88: consider triggering state of simulating fw crash
References: <20210929094724.23595-1-pkshih@realtek.com>
Date:   Fri, 01 Oct 2021 09:18:49 +0300
In-Reply-To: <20210929094724.23595-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Wed, 29 Sep 2021 17:47:24 +0800")
Message-ID: <87o889mfna.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> In certain cases, triggering fw crash simulation via fw_crash debugfs
> will take a while. If the state is queried too early before restart
> begins processing, it may mistakenly think restart process has been
> done. If some tests are started at this time, something unexpected
> might happen due to the follow-up restart process.
>
> To avoid that, we consider the triggering state.
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/debug.c | 5 ++++-
>  drivers/net/wireless/realtek/rtw88/main.c  | 1 +
>  drivers/net/wireless/realtek/rtw88/main.h  | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
> index babf7fb238cc..682b23502e6e 100644
> --- a/drivers/net/wireless/realtek/rtw88/debug.c
> +++ b/drivers/net/wireless/realtek/rtw88/debug.c
> @@ -886,6 +886,7 @@ static ssize_t rtw_debugfs_set_fw_crash(struct file *filp,
>  
>  	mutex_lock(&rtwdev->mutex);
>  	rtw_leave_lps_deep(rtwdev);
> +	set_bit(RTW_FLAG_RESTART_TRIGGERING, rtwdev->flags);
>  	rtw_write8(rtwdev, REG_HRCV_MSG, 1);
>  	mutex_unlock(&rtwdev->mutex);
>  
> @@ -897,7 +898,9 @@ static int rtw_debugfs_get_fw_crash(struct seq_file *m, void *v)
>  	struct rtw_debugfs_priv *debugfs_priv = m->private;
>  	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
>  
> -	seq_printf(m, "%d\n", test_bit(RTW_FLAG_RESTARTING, rtwdev->flags));
> +	seq_printf(m, "%d\n",
> +		   test_bit(RTW_FLAG_RESTART_TRIGGERING, rtwdev->flags) ||
> +		   test_bit(RTW_FLAG_RESTARTING, rtwdev->flags));
>  	return 0;
>  }

You use the verb "consider" both in the title and the commit log, but
it's not really telling much (though I admit my english isn't very
good). From looking at the patch all I see is that it prints the state
of RTW_FLAG_RESTART_TRIGGERING flag. How is that "considering" anything
and how does that improve any of this?

Can you improve the commit log and explain this is in detail? And what's
"it" in this case?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
