Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E696272583
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgIUN1y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 09:27:54 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:24558 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgIUN1x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 09:27:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600694873; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=C53ue0U8/k0fuC8DXorjXPpqPEUUSnVbCeTh+Io7v/U=; b=eNefw6O8rmg53pwQiefbTE+swntG30gsZQzdnyDEouQ32BBtVZZakw1pfB+gzWN6bkhyKs3Q
 O+QhNVgmXt5shXwiiKMjfRwFsXo+cj/7TcAZXxsS5uI9QiEQMQWewj+mM0UAA3Si0w9nkUM8
 OtC1MIpplo2u4Lb4KmXhictcCO4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f68aa4a2131f7663a9775bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 13:27:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75A49C433F1; Mon, 21 Sep 2020 13:27:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 679DFC433A1;
        Mon, 21 Sep 2020 13:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 679DFC433A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     rmanohar@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, kuba@kernel.org, davem@davemloft.net
Subject: Re: [PATCH -next] ath11k: Add checked value for ath11k_ahb_remove
References: <20200621095136.7xdbzkthoxuw2qow@debian.debian-2>
        <01010174681bb751-308defb0-0333-43ee-99ef-7f1d1ee3358b-000000@us-west-2.amazonses.com>
Date:   Mon, 21 Sep 2020 16:27:32 +0300
In-Reply-To: <01010174681bb751-308defb0-0333-43ee-99ef-7f1d1ee3358b-000000@us-west-2.amazonses.com>
        (Kalle Valo's message of "Mon, 7 Sep 2020 10:28:01 +0000")
Message-ID: <874knr5kfv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> + rajkumar
>
> Bo YU <tsu.yubo@gmail.com> writes:
>
>> Return value form wait_for_completion_timeout should to be checked.
>>
>> This is detected by Coverity,#CID:1464479 (CHECKED_RETURN)
>>
>> FIXES: d5c65159f2895(ath11k: driver for Qualcomm IEEE 802.11ax devices)
>
> This should be
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>
> But I can fix that.
>
>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>> @@ -981,12 +981,16 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>> static int ath11k_ahb_remove(struct platform_device *pdev)
>> {
>> 	struct ath11k_base *ab = platform_get_drvdata(pdev);
>> -
>> +	int ret = 0;
>> 	reinit_completion(&ab->driver_recovery);
>>
>> 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
>> -		wait_for_completion_timeout(&ab->driver_recovery,
>> -					    ATH11K_AHB_RECOVERY_TIMEOUT);
>> +		if (!wait_for_completion_timeout(&ab->driver_recovery,
>> +						 ATH11K_AHB_RECOVERY_TIMEOUT)) {
>> + ath11k_warn(ab, "fail to receive recovery response
>> completion.\n");
>> +			ret = -ETIMEDOUT;
>> +		}
>
> This is a good find. Rajkumar, can you take a look if this is ok?
>
>>
>> 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
>> 	cancel_work_sync(&ab->restart_work);
>> @@ -999,7 +1003,7 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
>> 	ath11k_core_free(ab);
>> 	platform_set_drvdata(pdev, NULL);
>>
>> -	return 0;
>> +	return ret;
>> }
>
> Especially I wonder what happens if ath11k_ahb_remove() returns an
> error. Should we just print a warning and return 0 instead?

I changed this patch so that we return 0 even if timeout happens, just
to be on the safe side. The patch is now in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
