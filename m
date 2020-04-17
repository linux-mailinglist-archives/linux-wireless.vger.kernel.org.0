Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB171AD73D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgDQHRR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:17:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:30738 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728513AbgDQHRR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:17:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587107836; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=oAQXckyqS4BXJlCDtGyR722Bq/GVrhO2gw8vOQNjTTY=; b=pCa5HMe3nUD37o6d++Zo87R4hWQ7lDIRUq/DfRDgvBEtP8zGL1Z5fxC0mThK5K3uMEiGTq7J
 cyeRYVepkcEKt2SnrtF2F4IRBTffDFLTFEIKLbpXoK7gj0/4AfIpz4Nf3q21QH/8mgzXvjK1
 bcnAQ2zPdTmtDvJSIIQ6BctgNQE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9957f0.7f3fa344ece0-smtp-out-n03;
 Fri, 17 Apr 2020 07:17:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD12AC432C2; Fri, 17 Apr 2020 07:17:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DEDAC433F2;
        Fri, 17 Apr 2020 07:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DEDAC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: improve power save performance for sdio
References: <0101016ed9241282-73dd8b35-e2e5-4f37-9b50-cf2fb6524dfc-000000@us-west-2.amazonses.com>
        <877dyfr4fb.fsf@kamboji.qca.qualcomm.com>
        <b9f680d57a6fbc9ac59dc5fc281d0af3@codeaurora.org>
Date:   Fri, 17 Apr 2020 10:17:00 +0300
In-Reply-To: <b9f680d57a6fbc9ac59dc5fc281d0af3@codeaurora.org> (Wen Gong's
        message of "Fri, 17 Apr 2020 12:32:09 +0800")
Message-ID: <87y2quponn.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-04-16 20:38, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:
>>
>
>>
>>> +static inline int ath10k_hif_set_mbox_sleep(struct ath10k *ar,
>>> bool enable_sleep)
>>> +{
>>> +	if (ar->hif.ops->set_mbox_sleep)
>>> +		return ar->hif.ops->set_mbox_sleep(ar, enable_sleep);
>>> +	return 0;
>>> +}
>>
>> I don't think we need to add another hif op for this. I sent v2 which
>> uses existing op.
>
> Yes, I see it. but I see it removed ath10k_hif_set_mbox_sleep in
>ath10k_core_start, expected it will not effect the patch's power save.

So the idea is that the same functionality is still there as with your
version, the callpath is just a bit different:

ath10k_core_start()
    -> ath10k_hif_start_post()
        -> ath10k_sdio_hif_start_post()
            -> ath10k_sdio_set_mbox_sleep()

But please do double check that I didn't miss anything.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
