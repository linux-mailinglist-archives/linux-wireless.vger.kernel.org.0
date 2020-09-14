Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921BD268695
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgINHzP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Sep 2020 03:55:15 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:16665 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbgINHzP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Sep 2020 03:55:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600070115; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=UoPnJyxLwAu55InvWh+7ZqhM53gZYTMP9jGy10nQ5IA=; b=MyuB37pR1yJmk/hmHa3WWsdAM5EpLfibcAbrYd53rOAcAk+lkZ6PNL0y24n5nm7/brKuuaCE
 LTfuXPo5kr2Mk+hldS8PHmUplkL2TV3FQ/vHD4QpVjU/RsXVLvPQzW4dF7hdiR9ZxFV040D+
 W+dp/LZZRF2jSHVumwVtScV1+AI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f5f21e1252c522440b45c2c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 07:55:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4FDFC433C6; Mon, 14 Sep 2020 07:55:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B78C5C433CA;
        Mon, 14 Sep 2020 07:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B78C5C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 04/11] mt76: add utility functions for deferring work to a kernel thread
References: <20200908211756.15998-1-nbd@nbd.name>
        <20200908211756.15998-4-nbd@nbd.name>
        <010101747c3b747d-09af9fc1-2e74-400f-89f5-fae71b7d163b-000000@us-west-2.amazonses.com>
        <7e2b25d9-c6cc-1c78-a96f-e60604408578@nbd.name>
Date:   Mon, 14 Sep 2020 10:55:08 +0300
In-Reply-To: <7e2b25d9-c6cc-1c78-a96f-e60604408578@nbd.name> (Felix Fietkau's
        message of "Sat, 12 Sep 2020 07:05:59 +0200")
Message-ID: <87363kpzc3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-09-11 10:15, Kalle Valo wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>> 
>>> In order to avoid keeping work like tx scheduling pinned to the CPU it was
>>> scheduled from, it makes sense to switch from tasklets to kernel threads.
>>>
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> 
>> [...]
>> 
>>> --- a/drivers/net/wireless/mediatek/mt76/util.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/util.c
>>> @@ -110,4 +110,32 @@ int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy)
>>>  }
>>>  EXPORT_SYMBOL_GPL(mt76_get_min_avg_rssi);
>>>  
>>> +int __mt76_worker_fn(void *ptr)
>>> +{
>>> +	struct mt76_worker *w = ptr;
>>> +
>>> +	while (!kthread_should_stop()) {
>>> +		set_current_state(TASK_INTERRUPTIBLE);
>>> +
>>> +		if (kthread_should_park()) {
>>> +			kthread_parkme();
>>> +			continue;
>>> +		}
>>> +
>>> +		if (!test_and_clear_bit(MT76_WORKER_SCHEDULED, &w->state)) {
>>> +			schedule();
>>> +			continue;
>>> +		}
>>> +
>>> +		set_bit(MT76_WORKER_RUNNING, &w->state);
>>> +		set_current_state(TASK_RUNNING);
>>> +		w->fn(w);
>>> +		cond_resched();
>>> +		clear_bit(MT76_WORKER_RUNNING, &w->state);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(__mt76_worker_fn);
>> 
>> So how is this better than, for example,
>> create_singlethread_workqueue()? And if this is better, shouldn't it be
>> part of workqueue.h instead of every driver reinventing the wheel?
>
> Unlike a workqueue, this one only allows one fixed worker function to be
> executed by the worker thread. Because of that, there is less locking
> and less code for scheduling involved.
> In fact, the function that schedules the worker is small enough that
> it's just a simple inline function.
> The difference matters in this case, because the tx worker is scheduled
> very often in a hot path.
> I don't think it fits into workqueue.h (because of the lack of
> separation between workqueue and work struct), and I don't know if other
> drivers need this, so let's keep it in mt76 and only move to a generic
> API if we find another user for it.

Ok, fair enough. But please add this info to the commit log so the
reasoning is properly documented.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
