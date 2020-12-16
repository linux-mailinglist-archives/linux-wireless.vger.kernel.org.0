Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9C2DBF16
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 11:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgLPK67 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 05:58:59 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:28750 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgLPK67 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 05:58:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608116318; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0FNXkK/0eYrucpVLRwqyEYUTMzSbXCYyPyWuo10BsXI=; b=L8gXOsWmSCzlazleQfEEFzBUhsArmjA35fuXpF4qTG5ZAv4B7QogfPWqkxgRBn4k6R/n03DP
 nWmc00g8D/OJh+Qj5cyMPshEAybEFXgjSXK1CFhCuOuMg5/jjy0vQkWn6F7ktid31YTefZRI
 YYqMa+3fj2lKpVm4qFlyoP74oGE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fd9e83b031793dcb4864fe9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Dec 2020 10:58:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D26B2C43461; Wed, 16 Dec 2020 10:58:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA165C433C6;
        Wed, 16 Dec 2020 10:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA165C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-wireless@vger.kernel.org,
        Carl Huang <cjhuang@codeaurora.org>,
        kernel-janitors@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 1/2] ath11k: Fix error code in ath11k_core_suspend()
References: <X9nF17L2/EKOSbn/@mwanda> <87h7omxgqs.fsf@codeaurora.org>
Date:   Wed, 16 Dec 2020 12:57:58 +0200
In-Reply-To: <87h7omxgqs.fsf@codeaurora.org> (Kalle Valo's message of "Wed, 16
        Dec 2020 11:06:03 +0200")
Message-ID: <87czzaxbk9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Dan Carpenter <dan.carpenter@oracle.com> writes:
>
>> The "if (!ret)" condition is inverted and it should be "if (ret)".  It
>> means that we return success when we had intended to return an error
>> code.
>>
>> Fixes: d1b0c33850d2 ("ath11k: implement suspend for QCA6390 PCI devices")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>> index b97c38b9a270..350b7913622c 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -185,7 +185,7 @@ int ath11k_core_suspend(struct ath11k_base *ab)
>>  	ath11k_hif_ce_irq_disable(ab);
>>  
>>  	ret = ath11k_hif_suspend(ab);
>> -	if (!ret) {
>> +	if (ret) {
>>  		ath11k_warn(ab, "failed to suspend hif: %d\n", ret);
>>  		return ret;
>>  	}
>
> I suspect I created these bugs while cleaning up the patches. But I
> don't get how I missed them in testing, that's a mystery to me.

The warning was there:

[  297.186612] ath11k_pci 0000:06:00.0: failed to suspend hif: 0

But I had missed that because suspend was still working due to
ath11k_core_suspend() returning 0. I'll update the commit log and
mention about that spurious warning.

Thank you Dan, this was a very good catch! In the future I'll grep my
logs more carefully, updated my scripts already.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
