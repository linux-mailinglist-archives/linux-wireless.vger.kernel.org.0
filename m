Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4592730CB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgIURVi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 13:21:38 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:63572 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgIURVi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 13:21:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600708897; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=GOiYdKkL6pQhYvPForA4ru+Y20EDP8bWi1QFA5o0p1Y=;
 b=qcQKZKt0QlgdHoDypi67NSA6gLhiad+6qdZKzPEEyP894upyNce7Q2AQmL2jL0xQJYYe6JUC
 BSdkOYdd0xc1UaKHMQTCI/htnTbFLADbLVSQ/hv6Q44fFLu9ml8oZ0GdKnYHBM5pVgVTWXkX
 FAXVfRLoMdHWNQVvS4HbaMMgfVA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f68e11fea858627d5dab382 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 17:21:35
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2053EC433F1; Mon, 21 Sep 2020 17:21:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 485B2C433CB;
        Mon, 21 Sep 2020 17:21:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Sep 2020 10:21:34 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bo YU <tsu.yubo@gmail.com>, kuba@kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        davem@davemloft.net
Subject: Re: [PATCH -next] ath11k: Add checked value for ath11k_ahb_remove
In-Reply-To: <874knr5kfv.fsf@codeaurora.org>
References: <20200621095136.7xdbzkthoxuw2qow@debian.debian-2>
 <01010174681bb751-308defb0-0333-43ee-99ef-7f1d1ee3358b-000000@us-west-2.amazonses.com>
 <874knr5kfv.fsf@codeaurora.org>
Message-ID: <4cc760ca8f79f1ce9df3aaf9dffe53b3@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-21 06:27, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
>> + rajkumar
>> 
>> Bo YU <tsu.yubo@gmail.com> writes:
>> 
>>> Return value form wait_for_completion_timeout should to be checked.
>>> 
>>> This is detected by Coverity,#CID:1464479 (CHECKED_RETURN)
>>> 
>>> FIXES: d5c65159f2895(ath11k: driver for Qualcomm IEEE 802.11ax 
>>> devices)
>> 
>> This should be
>> 
>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax 
>> devices")
>> 
>> But I can fix that.
>> 
>>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>>> @@ -981,12 +981,16 @@ static int ath11k_ahb_probe(struct 
>>> platform_device *pdev)
>>> static int ath11k_ahb_remove(struct platform_device *pdev)
>>> {
>>> 	struct ath11k_base *ab = platform_get_drvdata(pdev);
>>> -
>>> +	int ret = 0;
>>> 	reinit_completion(&ab->driver_recovery);
>>> 
>>> 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
>>> -		wait_for_completion_timeout(&ab->driver_recovery,
>>> -					    ATH11K_AHB_RECOVERY_TIMEOUT);
>>> +		if (!wait_for_completion_timeout(&ab->driver_recovery,
>>> +						 ATH11K_AHB_RECOVERY_TIMEOUT)) {
>>> + ath11k_warn(ab, "fail to receive recovery response
>>> completion.\n");
> 

>>> +			ret = -ETIMEDOUT;
>>> +		}
>> 
>> This is a good find. Rajkumar, can you take a look if this is ok?
> 
Sorry for the delay. wait_for_completion status check LGTM. But return 0 
is
intentional as it is required to complete platform deinit properly. 
Better
to improve the logging message.

>>> 
>>> 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
>>> 	cancel_work_sync(&ab->restart_work);
>>> @@ -999,7 +1003,7 @@ static int ath11k_ahb_remove(struct 
>>> platform_device *pdev)
>>> 	ath11k_core_free(ab);
>>> 	platform_set_drvdata(pdev, NULL);
>>> 
>>> -	return 0;
>>> +	return ret;
>>> }
>> 
>> Especially I wonder what happens if ath11k_ahb_remove() returns an
>> error. Should we just print a warning and return 0 instead?
> 
> I changed this patch so that we return 0 even if timeout happens, just
> to be on the safe side. The patch is now in the pending branch.
> 

Thanks for taking care of this.

Rajkumar
