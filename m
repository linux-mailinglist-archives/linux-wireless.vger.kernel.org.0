Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29F1AC136
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 14:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635356AbgDPM1x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 08:27:53 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:24370 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439151AbgDPM1v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 08:27:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587040070; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=k7W4GgWYMJ6R5M6bMBdI/LAF5r7KyT9fmFnm3V4dJXE=; b=FY1i6bhG3et2WmQZNeed1dnlMyQ0AAiOG116WBvA4KuoIpDgzbD7m2Ayb95IABhtJt9iU47e
 L59KztMD56NgkFxQC8X7b8GTi472jDUko7mhBwitbZXxQFiJ4bOTCHr9JgkGExA8mi+h7U+0
 sBuwuitxhs3qPgT0lfuLv50vG1I=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e984f37.7ff1f685d618-smtp-out-n05;
 Thu, 16 Apr 2020 12:27:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BB148C433BA; Thu, 16 Apr 2020 12:27:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A4C1C433CB;
        Thu, 16 Apr 2020 12:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A4C1C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v9 3/4] ath10k: add htt TX bundle for sdio
References: <20200212080415.31265-1-wgong@codeaurora.org>
        <20200212080415.31265-4-wgong@codeaurora.org>
        <87tv1su2vq.fsf@kamboji.qca.qualcomm.com>
        <185d31c2e6f8792beb240f2c74d26463@codeaurora.org>
        <87h7xmtrmv.fsf@kamboji.qca.qualcomm.com>
Date:   Thu, 16 Apr 2020 15:27:30 +0300
In-Reply-To: <87h7xmtrmv.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Tue, 14 Apr 2020 11:10:00 +0300")
Message-ID: <87o8rrr4y5.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Wen Gong <wgong@codeaurora.org> writes:
>
>> On 2020-04-09 22:53, Kalle Valo wrote:
>>> Wen Gong <wgong@codeaurora.org> writes:
>>>
>>>> +	ar->workqueue_tx_complete =
>>>> +		create_singlethread_workqueue("ath10k_tx_complete_wq");
>>>> +	if (!ar->workqueue_tx_complete)
>>>> +		goto err_free_aux_wq;
>>>
>>> We already have three threads:
>>>
>>> ath/ath10k/core.c:      ar->workqueue =
>>> create_singlethread_workqueue("ath10k_wq");
>>> ath/ath10k/core.c:      ar->workqueue_aux =
>>> create_singlethread_workqueue("ath10k_aux_wq");
>>> ath/ath10k/sdio.c:      ar_sdio->workqueue =
>>> create_singlethread_workqueue("ath10k_sdio_wq");
>>>
>>> Do we really need a fourth one? For example, why can't we use
>>> ar->workqueue_aux?
>>
>> For tcp test, it has 4 thread work meanwhile:
>> tx_bundle_skbs(ar->workqueue),
>> rx_indication(ar->workqueue_aux),
>> sdio_async_tx_request(ar_sdio->workqueue),
>> tx_bundle_complete(ar->workqueue_tx_complete)
>>
>> It has 4+ cpu/core in system, if reduced to 3 threads, then tcp
>> throughput will drop. only when it only has 1/2/3 cpu/core in system,
>> then reduced to 3 threads will not drop.
>
> How much does it drop? Please add the justification (with numbers) for
> the new thread to the commit log, so that the reason is properly
> documented.

I see that you already submitted v10. If you can give the numbers I can
add them to the commit log.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
