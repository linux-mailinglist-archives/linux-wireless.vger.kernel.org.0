Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987AF2D15C0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 17:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLGQN3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 11:13:29 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:22651 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLGQN2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 11:13:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607357589; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KBadcv3HX0ZnNLrZaWWM+MlOQr/0v7i1c6cDBo5uKaI=; b=qdGI/cd9UffesPpTxC6pVxVrizad7/Lvyz6hNvi9aEfo1jhL9r4iKG/h+XymfWeH4VEd9WrJ
 Vu93RRRrCbYhrnPipb6gtVOYDB9bxawV23oNmbBFUakCCIQlh7awlYo80ctFpEKs/B145BT9
 fqZTjnQXbYRgic/xw3A9rfoNWII=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fce547af06acf11ab122161 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 16:12:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 999A1C433CA; Mon,  7 Dec 2020 16:12:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7D05C433C6;
        Mon,  7 Dec 2020 16:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7D05C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Youghandhar Chintala <youghand@codeaurora.org>,
        kuabhs@chromium.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Doug Anderson <dianders@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: Re: [PATCH v2] ath10k: skip the wait for completion to recovery in shutdown path
References: <20201126171553.2097-1-youghand@codeaurora.org>
        <CA+ASDXOvnfETrKs2ZbayZsRkUEpUbaeMGRkZNRCXa=M28HHE-w@mail.gmail.com>
Date:   Mon, 07 Dec 2020 18:12:38 +0200
In-Reply-To: <CA+ASDXOvnfETrKs2ZbayZsRkUEpUbaeMGRkZNRCXa=M28HHE-w@mail.gmail.com>
        (Brian Norris's message of "Tue, 1 Dec 2020 11:35:44 -0800")
Message-ID: <87y2i9egsp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Thu, Nov 26, 2020 at 9:16 AM Youghandhar Chintala
> <youghand@codeaurora.org> wrote:
>> --- a/drivers/net/wireless/ath/ath10k/snoc.c
>> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
>> @@ -1790,9 +1790,6 @@ static int ath10k_snoc_remove(struct platform_device *pdev)
>>
>>         reinit_completion(&ar->driver_recovery);
>>
>> -       if (test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
>> -               wait_for_completion_timeout(&ar->driver_recovery, 3 * HZ);
>
> Hmm, this is the only instance of waiting for this completion, which
> means that after this patch, 'ar->driver_recovery' is doing exactly
> nothing. Should you instead just remove it completely?
>
> Also, if your patch is correct, it seems like the completion was never
> needed in the first place. You should probably address such a claim in
> the commit message; is there truly no need to wait here? Or was there
> some purpose here, but that purpose was accomplished some other way?
> Or was there a purpose, and that purpose was misguided? It feels to me
> like it is indeed correct to remove this (shutdown should be performed
> promptly; we don't need to delay it just to try to "finish
> recovering"), but it's your job to convince the reader.

Exactly what I was thinking as well. To me this patch was just looks
racy and all the commit log says that it's "unwanted delay".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
