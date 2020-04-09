Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D051A3791
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 17:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgDIPzd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 11:55:33 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:50937 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728287AbgDIPzc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 11:55:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586447733; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=vKQQD+LpyQn8hyW482cb70w6C2mZNVsZk6XSSGWg0b8=;
 b=fE6c9BhNhgm2Igj7rg2GYhixlG3hAkfjL12VNpoYEo/fWFdyGAiRzdI0wUNDT8bbWuUc/nh8
 UlzGpHAZHgdrVWXT0AActyPrtS16nSzA9D9BynROLvbRiZnASGoy1WK9LRvmVVE284iBP9on
 DC0ZU1vRk1/120J4j0xd2bgbWsk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8f455f.7f887a4e4ce0-smtp-out-n01;
 Thu, 09 Apr 2020 15:55:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 964ADC433BA; Thu,  9 Apr 2020 15:55:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50047C433CB;
        Thu,  9 Apr 2020 15:55:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Apr 2020 23:55:07 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ath10k: add htt TX bundle for sdio
In-Reply-To: <87lfn4u0lq.fsf@kamboji.qca.qualcomm.com>
References: <20200212080415.31265-1-wgong@codeaurora.org>
 <20200212080415.31265-4-wgong@codeaurora.org>
 <87pncgu2ba.fsf@kamboji.qca.qualcomm.com>
 <36ee3bed6f7cd200df0755209ec6bbc2@codeaurora.org>
 <87lfn4u0lq.fsf@kamboji.qca.qualcomm.com>
Message-ID: <5b90a59dad4f40333e185397b295219d@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-09 23:42, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> On 2020-04-09 23:05, Kalle Valo wrote:
>> 
>>>> +		ep->tx_credits -= credits;
>>>> +		ath10k_dbg(ar, ATH10K_DBG_HTC,
>>>> +			   "htc ep %d consumed %d credits (total %d)\n",
>>> 
>>> "htc ep %d consumed %d credits total %d\n"
>>> 
>>> [...]
>>> 
>>>> +	ath10k_dbg(ar, ATH10K_DBG_HTC, "bundle skb: len:%d\n",
>>>> bundle_skb->len);
>>> 
>>> "htc bundle skb len %d\n"
>>> 
>>> In other words, start with "htc" and don't use colons or parenthesis.
>>> This applies to most of debug messages in this patch.
>> 
>> I will change the log and other log and sent v10.
>> but "ath10k: disable TX complete indication of htt for sdio" and
>> "ath10k: change ATH10K_SDIO_BUS_REQUEST_MAX_NUM from 64 to 1024" has
>> appied to ath-next,
>> so I only need to send the left 2 patches:
>> "ath10k: add htt TX bundle for sdio" and "ath10k: enable alt data of
>> TX path for sdio", right?
> 
> Correct, I already applied patches 1 and 2. But before you resend
> patches 3-4 did you see my question about creating a new thread, is it
> really necessary?
already replied.
