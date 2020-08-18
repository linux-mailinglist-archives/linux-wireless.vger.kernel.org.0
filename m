Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3F2480D2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 10:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHRIj3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 04:39:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:36981 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgHRIjZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 04:39:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597739965; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uCxO75HwbTxmh20SjzlZ8aAq4VEYPabT1FTw1sV7X20=;
 b=jqE+v/P5so+xYWyeMz7ZUb5DLHCXE0IYI4Xne2JBuCly3M6bwSqbLkQpDHXlKu6m3ue0kQ5N
 INYZZYNfubMiJcBfvh2sZMFdvxRxzZvJNA+dpwKNAPZazfEn4GBWSINMsWQkw3AOWG+YgmDM
 0WKSMuxOkNeCJdX+h24oSk55g7g=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f3b93aa61f1d418345648f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 08:39:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1099C43391; Tue, 18 Aug 2020 08:39:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 227F8C43387;
        Tue, 18 Aug 2020 08:39:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Aug 2020 16:39:04 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
In-Reply-To: <87imdlkuw8.fsf@codeaurora.org>
References: <20200108031957.22308-1-wgong@codeaurora.org>
 <20200108031957.22308-2-wgong@codeaurora.org>
 <87imdlkuw8.fsf@codeaurora.org>
Message-ID: <b5a894f46ce01d89a0887d63296fd139@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-15 01:19, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
...
>> diff --git a/drivers/net/wireless/ath/ath10k/core.c 
>> b/drivers/net/wireless/ath/ath10k/core.c
>> index 91f131b87efc..0e31846e6c89 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.c
>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>> @@ -2199,6 +2199,14 @@ static void ath10k_core_restart(struct 
>> work_struct *work)
>>  {
>>  	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
>>  	int ret;
>> +	int restart_count;
>> +
>> +	restart_count = atomic_add_return(1, &ar->restart_count);
>> +	if (restart_count > 1) {
>> +		ath10k_warn(ar, "can not restart, count: %d\n", restart_count);
>> +		atomic_dec(&ar->restart_count);
>> +		return;
>> +	}
> 
> I have been thinking a different approach for this. I think another
> option is to have a function like this:
> 
> ath10k_core_firmware_crashed()
> {
>         queue_work(ar->workqueue, &ar->restart_work);
> }
> 
> In patch 1 we would convert all existing callers to call that
> function instead of queue_work() directly.
> 
> In patch 2 we would add a new flag to enum ath10k_dev_flags, or maybe
> should actually use existing ATH10K_FLAG_CRASH_FLUSH? Don't know yet
> which one is better. Now the function would do:
> 
> ath10k_core_firmware_crashed()
> {
>         if (test_bit(flag))
>                 return
> 
>         set_bit(flag)
> 	queue_work(ar->workqueue, &ar->restart_work);
> }
> 
> That way restart_work queue would be called only one time.
> 
This is not muti-thread-safe, for example, if 2 thread entered to the 
test_bit(flag) meanwhile
and both check pass, then it will have 2 restart.

atomic_add_return is muti-thread-safe, if 2 thread entered it, only 1 
thread can pass
the check, another will fail and return.

The "payload length exceeds max htc length for sdio" happened many times 
in a very short time,
so I add this check for it.

> Though I'm not sure how ATH10K_STATE_WEDGED would behave after this
> change, it might get broken. Ah, actually I think even this patch 
> breaks
> the WEDGED state. This firmware restart is tricky, difficult to say 
> what
> is the best approach. Michal, are you reading? :) Any ideas?
> 
> And after looking more about this patch I don't see the need for the 
> new
> ar->restart_count atomic variable. Checking for ATH10K_FLAG_CRASH_FLUSH
> would do the same thing AFAICS.
> 
> And related to this, (in a separate patch) I think we should utilise
> ATH10K_FLAG_CRASH_FLUSH more. For example in ath10k_wmi_cmd_send() to
> not even try to send a WMI command if the flag is set. Basically all
> hardware access should be disabled except what is needed to restart the
> firmware.
