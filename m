Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871B025FD94
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgIGPwh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 11:52:37 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:48674
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730104AbgIGPwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 11:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599493948;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=/hBWlJ/vk5LVkSF2BVHJysOCmqjI/pTOub9fv+qQCzg=;
        b=SZBqRKnQEpuffgIG58enhZLw9cjSkEFf2eLjEd347EkGOohPb0dZq/61FwJ97XWN
        7ANe1XQnhICSBppaB2GFdhUlgLCf5Pl5LPEi4AHX7EhwWePzBSkLBDaIgYlKaqT59FC
        +TJPeAccZLH82q2RtkkZPJONbRWBgSl7QspDiySw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599493948;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=/hBWlJ/vk5LVkSF2BVHJysOCmqjI/pTOub9fv+qQCzg=;
        b=AfDqCcBKUlsM5XtPFy0vxKR3ZW5e5Ar28GUZxUAFhPig0Zl+qIq3vCoefn/bG1hT
        TnG45vdxl0aT8/pS3mwctstHDSs3WsXdlOG03LOgjGvyEsEDoUsq8zpBEuits9W2RF9
        lR5f+QWBw0J9p/Wi8zUTMwSQewB7HXKyGiausiXA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74E93C4B549
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
References: <20200108031957.22308-1-wgong@codeaurora.org>
        <20200108031957.22308-2-wgong@codeaurora.org>
        <87imdlkuw8.fsf@codeaurora.org>
        <b5a894f46ce01d89a0887d63296fd139@codeaurora.org>
Date:   Mon, 7 Sep 2020 15:52:28 +0000
In-Reply-To: <b5a894f46ce01d89a0887d63296fd139@codeaurora.org> (Wen Gong's
        message of "Tue, 18 Aug 2020 16:39:04 +0800")
Message-ID: <010101746944c413-e974ab5a-a202-4a7d-a689-e30a629459a9-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-08-15 01:19, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:
>>
> ...
>>> diff --git a/drivers/net/wireless/ath/ath10k/core.c
>>> b/drivers/net/wireless/ath/ath10k/core.c
>>> index 91f131b87efc..0e31846e6c89 100644
>>> --- a/drivers/net/wireless/ath/ath10k/core.c
>>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>>> @@ -2199,6 +2199,14 @@ static void ath10k_core_restart(struct
>>> work_struct *work)
>>>  {
>>>  	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
>>>  	int ret;
>>> +	int restart_count;
>>> +
>>> +	restart_count = atomic_add_return(1, &ar->restart_count);
>>> +	if (restart_count > 1) {
>>> +		ath10k_warn(ar, "can not restart, count: %d\n", restart_count);
>>> +		atomic_dec(&ar->restart_count);
>>> +		return;
>>> +	}
>>
>> I have been thinking a different approach for this. I think another
>> option is to have a function like this:
>>
>> ath10k_core_firmware_crashed()
>> {
>>         queue_work(ar->workqueue, &ar->restart_work);
>> }
>>
>> In patch 1 we would convert all existing callers to call that
>> function instead of queue_work() directly.
>>
>> In patch 2 we would add a new flag to enum ath10k_dev_flags, or maybe
>> should actually use existing ATH10K_FLAG_CRASH_FLUSH? Don't know yet
>> which one is better. Now the function would do:
>>
>> ath10k_core_firmware_crashed()
>> {
>>         if (test_bit(flag))
>>                 return
>>
>>         set_bit(flag)
>> 	queue_work(ar->workqueue, &ar->restart_work);
>> }
>>
>> That way restart_work queue would be called only one time.
>
> This is not muti-thread-safe, for example, if 2 thread entered to the
> test_bit(flag) meanwhile and both check pass, then it will have 2
> restart.

Good point, this was racy. And I see that you found test_and_set_bit()
already to fix the race.

> atomic_add_return is muti-thread-safe, if 2 thread entered it, only 1
> thread can pass the check, another will fail and return.

I'm not going to add new state variables unless the justification is
REALLY strong and sound. This firmware restart is complicated as is
already, there's no reason to complicate it even more.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
