Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE42F265B42
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 10:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbgIKIPK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 04:15:10 -0400
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:33432
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgIKIPG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 04:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599812105;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=N9fxCc5NW0Ti9oo755ftCoAbiGuKOsIm79KqZGSYUQ4=;
        b=k71otVRCDW7r9HGYv00Cige9iaFAguYBszjfblGeuzHk/nYHFAyMYR1tgnUDJ2ve
        N18pCpprXR9cdA8bE6+zQqd97/DwjTaj/J1lNPAicIyA/sZZho73IMNZtlNd0bMUTbb
        IDrASypERoJEAUIE3PBCM8LdPnLUM9PUMBGSYzmc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599812105;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=N9fxCc5NW0Ti9oo755ftCoAbiGuKOsIm79KqZGSYUQ4=;
        b=Mgt5ysOYhjhtZaMtVEU2Ha3iY0pLfw6dJYCHwPtRUbM6b89n+yILaRaMvY2gwIFn
        XjH8LAFzqEgdbnNNzhyx+tovdJ9bP+lBubPexv1hC9Lk9dsPk6tbNi+OLirTC98UeYP
        Ud1vU3hknvfl8NwACujATwQ+5s3z3isBXjz8glK0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA31AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 04/11] mt76: add utility functions for deferring work to a kernel thread
References: <20200908211756.15998-1-nbd@nbd.name>
        <20200908211756.15998-4-nbd@nbd.name>
Date:   Fri, 11 Sep 2020 08:15:05 +0000
In-Reply-To: <20200908211756.15998-4-nbd@nbd.name> (Felix Fietkau's message of
        "Tue, 8 Sep 2020 23:17:49 +0200")
Message-ID: <010101747c3b7518-86af82e8-24bd-41f9-b7e3-8fb181e9d926-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.11-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> In order to avoid keeping work like tx scheduling pinned to the CPU it was
> scheduled from, it makes sense to switch from tasklets to kernel threads.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

[...]

> --- a/drivers/net/wireless/mediatek/mt76/util.c
> +++ b/drivers/net/wireless/mediatek/mt76/util.c
> @@ -110,4 +110,32 @@ int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy)
>  }
>  EXPORT_SYMBOL_GPL(mt76_get_min_avg_rssi);
>  
> +int __mt76_worker_fn(void *ptr)
> +{
> +	struct mt76_worker *w = ptr;
> +
> +	while (!kthread_should_stop()) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		if (kthread_should_park()) {
> +			kthread_parkme();
> +			continue;
> +		}
> +
> +		if (!test_and_clear_bit(MT76_WORKER_SCHEDULED, &w->state)) {
> +			schedule();
> +			continue;
> +		}
> +
> +		set_bit(MT76_WORKER_RUNNING, &w->state);
> +		set_current_state(TASK_RUNNING);
> +		w->fn(w);
> +		cond_resched();
> +		clear_bit(MT76_WORKER_RUNNING, &w->state);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(__mt76_worker_fn);

So how is this better than, for example,
create_singlethread_workqueue()? And if this is better, shouldn't it be
part of workqueue.h instead of every driver reinventing the wheel?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
