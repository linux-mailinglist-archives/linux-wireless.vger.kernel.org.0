Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2755525F84A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 12:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgIGK2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 06:28:12 -0400
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:42630
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbgIGK16 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 06:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599474478;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=1CMwxmjWB2IZZGpa5lLWkQ6WnBmJXHQnQxKcHtOHxqI=;
        b=ZcATHQxUV6IWJFMiyKON0Gp+qxAOPzwjD+hzx+rRrmmDDbDEtCfCJC5ZmPAdSt3u
        vn4BKDvPsuN181U4RLc/AyaqV2AxQ6oJylGkWqLP5xC14xnZgJcU52EyaiKAqPi1BIR
        ShcAXIX1ajtvzXwhs3uD6oC9qR29eZ+oz3eqjJ/Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599474478;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=1CMwxmjWB2IZZGpa5lLWkQ6WnBmJXHQnQxKcHtOHxqI=;
        b=OU781ct894PhTFB+H9WoiHUFFCGrbMHiwQsos0cDV0GdnBxykISQDSn9D6EF27kz
        bhaJO8FyJm5tGdWoeM5tc05mPdJLT/CDCnsTdIsxLh2iRge8pX9ir9+l1kElJ78T6LM
        4gC52G4R3SmS3N5I4gm4r/ClDa8xQwyZZ7/IsetM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1752C53A37
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        rmanohar@codeaurora.org
Subject: Re: [PATCH -next] ath11k: Add checked value for ath11k_ahb_remove
References: <20200621095136.7xdbzkthoxuw2qow@debian.debian-2>
Date:   Mon, 7 Sep 2020 10:27:58 +0000
In-Reply-To: <20200621095136.7xdbzkthoxuw2qow@debian.debian-2> (Bo YU's
        message of "Sun, 21 Jun 2020 17:51:40 +0800")
Message-ID: <01010174681bace8-5b83f615-4790-4722-8257-799205c9c96f-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ rajkumar

Bo YU <tsu.yubo@gmail.com> writes:

> Return value form wait_for_completion_timeout should to be checked.
>
> This is detected by Coverity,#CID:1464479 (CHECKED_RETURN)
>
> FIXES: d5c65159f2895(ath11k: driver for Qualcomm IEEE 802.11ax devices)

This should be

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")

But I can fix that.

> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -981,12 +981,16 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
> static int ath11k_ahb_remove(struct platform_device *pdev)
> {
> 	struct ath11k_base *ab = platform_get_drvdata(pdev);
> -
> +	int ret = 0;
> 	reinit_completion(&ab->driver_recovery);
>
> 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
> -		wait_for_completion_timeout(&ab->driver_recovery,
> -					    ATH11K_AHB_RECOVERY_TIMEOUT);
> +		if (!wait_for_completion_timeout(&ab->driver_recovery,
> +						 ATH11K_AHB_RECOVERY_TIMEOUT)) {
> +			ath11k_warn(ab, "fail to receive recovery response completion.\n");
> +			ret = -ETIMEDOUT;
> +		}

This is a good find. Rajkumar, can you take a look if this is ok?

>
> 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
> 	cancel_work_sync(&ab->restart_work);
> @@ -999,7 +1003,7 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
> 	ath11k_core_free(ab);
> 	platform_set_drvdata(pdev, NULL);
>
> -	return 0;
> +	return ret;
> }

Especially I wonder what happens if ath11k_ahb_remove() returns an
error. Should we just print a warning and return 0 instead?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
