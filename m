Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49BB1A375B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgDIPnC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 11:43:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:63843 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728167AbgDIPnC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 11:43:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586446982; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=HXX12wmUv3R/HEJbd2SH/6l+DxGPnMH2DaiOr0PZbPs=; b=p+279hiqcaOAoo4XnXGAA8YBw9ngCYTz7T/vEvcoltCsf5PjldCTfkEd0bgGaalI+EjrHpom
 dswDp3qVbmLI9TelWBEoJrXtk3YPcZNYov3ufNZ1qQ8y2yO14lvC7MaoKZwRUmwRs5hgnVYl
 38cKtOILN3igHY2autm4yNwaTi8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8f4279.7f7ecf1c1ed8-smtp-out-n01;
 Thu, 09 Apr 2020 15:42:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 180B3C4478C; Thu,  9 Apr 2020 15:42:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A391FC432C2;
        Thu,  9 Apr 2020 15:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A391FC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ath10k: add htt TX bundle for sdio
References: <20200212080415.31265-1-wgong@codeaurora.org>
        <20200212080415.31265-4-wgong@codeaurora.org>
        <87pncgu2ba.fsf@kamboji.qca.qualcomm.com>
        <36ee3bed6f7cd200df0755209ec6bbc2@codeaurora.org>
Date:   Thu, 09 Apr 2020 18:42:41 +0300
In-Reply-To: <36ee3bed6f7cd200df0755209ec6bbc2@codeaurora.org> (Wen Gong's
        message of "Thu, 09 Apr 2020 23:29:20 +0800")
Message-ID: <87lfn4u0lq.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-04-09 23:05, Kalle Valo wrote:
>
>>> +		ep->tx_credits -= credits;
>>> +		ath10k_dbg(ar, ATH10K_DBG_HTC,
>>> +			   "htc ep %d consumed %d credits (total %d)\n",
>>
>> "htc ep %d consumed %d credits total %d\n"
>>
>> [...]
>>
>>> +	ath10k_dbg(ar, ATH10K_DBG_HTC, "bundle skb: len:%d\n",
>>> bundle_skb->len);
>>
>> "htc bundle skb len %d\n"
>>
>> In other words, start with "htc" and don't use colons or parenthesis.
>> This applies to most of debug messages in this patch.
>
> I will change the log and other log and sent v10.
> but "ath10k: disable TX complete indication of htt for sdio" and
> "ath10k: change ATH10K_SDIO_BUS_REQUEST_MAX_NUM from 64 to 1024" has
> appied to ath-next,
> so I only need to send the left 2 patches:
> "ath10k: add htt TX bundle for sdio" and "ath10k: enable alt data of
> TX path for sdio", right?

Correct, I already applied patches 1 and 2. But before you resend
patches 3-4 did you see my question about creating a new thread, is it
really necessary?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
