Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2372244D69
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 19:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgHNRTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 13:19:30 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32129 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbgHNRT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 13:19:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597425569; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=c6OkbFrFE9FSUvSSDLfDJzkQDFb1B6VSYp6aGTWnECE=; b=TvPlIxfQASWSdEsTK6Vw2sqm+U88pmg7il1dWSK2C0zEusOfQfnETB8ev6EuSRaaOvLW+BBO
 yDpN0O2Lr++dm9Jd29DVGVMBR7Y0nbZ1x87nTb4Ht9KxcKMFHGyeJ/AG2z4wOa7plSOVBqLa
 ia8NN1YbSDqi4H3bMpoPyetMkrE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f36c79b46ed996674433307 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 17:19:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E910CC433C9; Fri, 14 Aug 2020 17:19:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CCEAC433C6;
        Fri, 14 Aug 2020 17:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CCEAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
References: <20200108031957.22308-1-wgong@codeaurora.org>
        <20200108031957.22308-2-wgong@codeaurora.org>
Date:   Fri, 14 Aug 2020 20:19:19 +0300
In-Reply-To: <20200108031957.22308-2-wgong@codeaurora.org> (Wen Gong's message
        of "Wed, 8 Jan 2020 11:19:56 +0800")
Message-ID: <87imdlkuw8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> When it has more than one restart_work queued meanwhile, the 2nd
> restart_work is very esay to break the 1st restart work and lead
> recovery fail.
>
> Add a ref count to allow only one restart work running untill
> device successfully recovered.
>
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 13 +++++++++++++
>  drivers/net/wireless/ath/ath10k/core.h |  2 ++
>  drivers/net/wireless/ath/ath10k/mac.c  |  1 +
>  3 files changed, 16 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 91f131b87efc..0e31846e6c89 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -2199,6 +2199,14 @@ static void ath10k_core_restart(struct work_struct *work)
>  {
>  	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
>  	int ret;
> +	int restart_count;
> +
> +	restart_count = atomic_add_return(1, &ar->restart_count);
> +	if (restart_count > 1) {
> +		ath10k_warn(ar, "can not restart, count: %d\n", restart_count);
> +		atomic_dec(&ar->restart_count);
> +		return;
> +	}

I have been thinking a different approach for this. I think another
option is to have a function like this:

ath10k_core_firmware_crashed()
{
        queue_work(ar->workqueue, &ar->restart_work);
}

In patch 1 we would convert all existing callers to call that
function instead of queue_work() directly.

In patch 2 we would add a new flag to enum ath10k_dev_flags, or maybe
should actually use existing ATH10K_FLAG_CRASH_FLUSH? Don't know yet
which one is better. Now the function would do:

ath10k_core_firmware_crashed()
{
        if (test_bit(flag))
                return

        set_bit(flag)                                
	queue_work(ar->workqueue, &ar->restart_work);
}

That way restart_work queue would be called only one time.

Though I'm not sure how ATH10K_STATE_WEDGED would behave after this
change, it might get broken. Ah, actually I think even this patch breaks
the WEDGED state. This firmware restart is tricky, difficult to say what
is the best approach. Michal, are you reading? :) Any ideas?

And after looking more about this patch I don't see the need for the new
ar->restart_count atomic variable. Checking for ATH10K_FLAG_CRASH_FLUSH
would do the same thing AFAICS.

And related to this, (in a separate patch) I think we should utilise
ATH10K_FLAG_CRASH_FLUSH more. For example in ath10k_wmi_cmd_send() to
not even try to send a WMI command if the flag is set. Basically all
hardware access should be disabled except what is needed to restart the
firmware.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
