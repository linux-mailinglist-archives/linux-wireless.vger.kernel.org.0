Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644B01A758A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 10:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407014AbgDNIKQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 04:10:16 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45913 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407020AbgDNIKF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 04:10:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586851804; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=mH6XaDcfkoGIlx6sWlVoVi2ojh5SGgfx8XJaLqJqEac=; b=Kn6Zi6q0KcZw/jC5plZYn/4HDHnd8pkIPDR4bbESzbpm1XYSuKM+W03uRr0qJ2m/clwLKzVI
 hi3X2zNWQs9NbTaloXhtaCnT03rS2Q5r1py8V2xXEO0EL4NQiBN4HSHysnXoPjWNQkaSry/j
 OFrvyYuEdZPWL+MD1y7QK5nbbE4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e956fdc.7fc2ff5bf4c8-smtp-out-n04;
 Tue, 14 Apr 2020 08:10:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B141C433CB; Tue, 14 Apr 2020 08:10:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B4D9C433F2;
        Tue, 14 Apr 2020 08:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B4D9C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ath10k: add htt TX bundle for sdio
References: <20200212080415.31265-1-wgong@codeaurora.org>
        <20200212080415.31265-4-wgong@codeaurora.org>
        <87tv1su2vq.fsf@kamboji.qca.qualcomm.com>
        <185d31c2e6f8792beb240f2c74d26463@codeaurora.org>
Date:   Tue, 14 Apr 2020 11:10:00 +0300
In-Reply-To: <185d31c2e6f8792beb240f2c74d26463@codeaurora.org> (Wen Gong's
        message of "Thu, 09 Apr 2020 23:40:41 +0800")
Message-ID: <87h7xmtrmv.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-04-09 22:53, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:
>>
>>> +	ar->workqueue_tx_complete =
>>> +		create_singlethread_workqueue("ath10k_tx_complete_wq");
>>> +	if (!ar->workqueue_tx_complete)
>>> +		goto err_free_aux_wq;
>>
>> We already have three threads:
>>
>> ath/ath10k/core.c:      ar->workqueue =
>> create_singlethread_workqueue("ath10k_wq");
>> ath/ath10k/core.c:      ar->workqueue_aux =
>> create_singlethread_workqueue("ath10k_aux_wq");
>> ath/ath10k/sdio.c:      ar_sdio->workqueue =
>> create_singlethread_workqueue("ath10k_sdio_wq");
>>
>> Do we really need a fourth one? For example, why can't we use
>> ar->workqueue_aux?
>
> For tcp test, it has 4 thread work meanwhile:
> tx_bundle_skbs(ar->workqueue),
> rx_indication(ar->workqueue_aux),
> sdio_async_tx_request(ar_sdio->workqueue),
> tx_bundle_complete(ar->workqueue_tx_complete)
>
> It has 4+ cpu/core in system, if reduced to 3 threads, then tcp
> throughput will drop. only when it only has 1/2/3 cpu/core in system,
> then reduced to 3 threads will not drop.

How much does it drop? Please add the justification (with numbers) for
the new thread to the commit log, so that the reason is properly
documented.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
