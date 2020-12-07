Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A862D152D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 16:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgLGPwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 10:52:43 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:29983 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgLGPwn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 10:52:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607356338; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=LxEd7FV8vkKUWJNPcLJ/uxeKeUmhgw1Z/p/McO8I+XU=; b=neNvh5zuaAD+RCxuXhZpsGluA/xh9nYQsZYx9k8xmrgiXa6919tit7fmY82TLH3IAWQQ491E
 EuIPnEWGEKGOg7FBp/M3MxiZqPNT+FhNFjD6mc61vU8MKKGCOnXm07CuvWw2MgXepBYcw0/N
 DBcT661Fu1m+mRSB5Crap0o9hMs=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fce4f95c0eb5c23b39b8210 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 15:51:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C1654C43461; Mon,  7 Dec 2020 15:51:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9BEAC433CA;
        Mon,  7 Dec 2020 15:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9BEAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>
Subject: Re: [PATCH] rtw88: reduce polling time of IQ calibration
References: <20201203021602.9414-1-pkshih@realtek.com>
Date:   Mon, 07 Dec 2020 17:51:44 +0200
In-Reply-To: <20201203021602.9414-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Thu, 3 Dec 2020 10:16:02 +0800")
Message-ID: <874kkxfwbz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Chin-Yen Lee <timlee@realtek.com>
>
> When 8822CE is associating with AP, driver will poll status bit of
> IQ calibration to confirm the IQ calibration is done, and then move on
> the association process. Current polling time for IQ calibration is 6
> seconds.
>
> But occasionally driver fails in polling the status bit because the status
> bit is not set after IQ calibration is done. When it happends, association
> process will be serieously delayed up to 6 seconds. To avoid it, we reduce
> polling time to 300ms, in which the IQ calibration can be done.
>
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> index 7dd3ccb73793..7661d8d494c9 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> @@ -2108,22 +2108,21 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
>  
>  static void rtw8822c_do_iqk(struct rtw_dev *rtwdev)
>  {
> +#define IQK_DONE_8822C 0xaa
> +
>  	struct rtw_iqk_para para = {0};
>  	u8 iqk_chk;
> -	int counter;
> +	int ret;

That is a bit awkward location for a define. The preferred style is to
move the define to a beginning of the file or to a .h file.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
