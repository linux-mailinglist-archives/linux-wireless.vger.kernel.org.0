Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926BB1BF737
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 13:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD3L4U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 07:56:20 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:11149 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgD3L4U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 07:56:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588247779; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=tJ4JgWyPwmFBBimyB4V6WntBXAK2a9Mg4G1zSTwXOKQ=; b=sQovhtp4dNkhmrQHsg4J5pr/VcXQ8EE7Bq7ZMQcFL3pBIlVAEs6QPGy2Nig9X9kFCt7g3PiG
 uNZ9i/5fjKwfgmkibHSjSXJxIDCA3QucK8xL/4mQMsQlvOc9axov5p7h5rGGPn4Edqp8c9t3
 rdP7oWIm3y8kGG4l3/JSAPHKFnM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaabcd2.7fd1bee0cdc0-smtp-out-n05;
 Thu, 30 Apr 2020 11:56:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6014EC433F2; Thu, 30 Apr 2020 11:56:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43B74C433CB;
        Thu, 30 Apr 2020 11:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43B74C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     yhchuang@realtek.com, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
Subject: Re: [PATCH v3 5/8] rtw88: 8723d: 11N chips don't support LDPC
References: <20200429095656.19315-1-yhchuang@realtek.com>
        <20200429095656.19315-6-yhchuang@realtek.com>
        <20200430105418.v3s5obb3skhv4732@linutronix.de>
Date:   Thu, 30 Apr 2020 14:55:56 +0300
In-Reply-To: <20200430105418.v3s5obb3skhv4732@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Thu, 30 Apr 2020 12:54:18 +0200")
Message-ID: <877dxxkx0z.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2020-04-29 17:56:53 [+0800], yhchuang@realtek.com wrote:
>> --- a/drivers/net/wireless/realtek/rtw88/main.c
>> +++ b/drivers/net/wireless/realtek/rtw88/main.c
>> @@ -933,7 +933,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
>>  	ht_cap->cap = 0;
>>  	ht_cap->cap |= IEEE80211_HT_CAP_SGI_20 |
>>  			IEEE80211_HT_CAP_MAX_AMSDU |
>> -			IEEE80211_HT_CAP_LDPC_CODING |
>> +			(rtw_chip_wcpu_11ac(rtwdev) ? IEEE80211_HT_CAP_LDPC_CODING : 0) |
>>  			(1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
>
> What about
>
>  	ht_cap->cap = IEEE80211_HT_CAP_SGI_20 |
>  			IEEE80211_HT_CAP_MAX_AMSDU |
>  			(1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
> 	if (rtw_chip_wcpu_11ac(rtwdev))
> 			ht_cap->cap |= IEEE80211_HT_CAP_LDPC_CODING;
> instead?

Yes, that's much better. I even missed the '?' operator in my own review
as it was not that visible.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
