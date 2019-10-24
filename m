Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9EE2E88
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391875AbfJXKOf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 06:14:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391807AbfJXKOe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 06:14:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0809F61178; Thu, 24 Oct 2019 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571912073;
        bh=rcfSs8cIFoejkuawLusYRRabpv0SXzEfJdHxkao3oJQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=c3nWcXIqfVsWoDucmPC78r0AGl0HFH5+RELmlgwkDQVTgVYOIonaIe3DW43TlcNyo
         yiZVutyAZpzBj+t1nO2hhasVH25nCbqpvRL7h9KSTysraHbPWLufYkcGx0SSaoyV6f
         5dcXH96rYRN73MDGEfyY7iuGW/RJ4wrFL3YswEiM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52C8660EE7;
        Thu, 24 Oct 2019 10:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571912071;
        bh=rcfSs8cIFoejkuawLusYRRabpv0SXzEfJdHxkao3oJQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nv2VlTVklRB0f47dEn9xpK0n1yk5u7HJhj98WKUPFF8C8SkdRUZyarziDeQQNErfB
         ld/7vV8Y/42onlrmVhPd4K0Z/8BvXdVNotbA7rux8FS3cS721XK6jqyAeS08ERWPB+
         1T3bLNAS0LqAWpRdaWdtPKmpyVn7h5fxaU2rGpa4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52C8660EE7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ath10k: change max RX bundle size from 8 to 32 for sdio
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
        <1569402639-31720-3-git-send-email-wgong@codeaurora.org>
        <87r232sdeh.fsf@kamboji.qca.qualcomm.com>
        <c2227ffd5901b03a2874fddb98298e0d@codeaurora.org>
Date:   Thu, 24 Oct 2019 13:14:27 +0300
In-Reply-To: <c2227ffd5901b03a2874fddb98298e0d@codeaurora.org> (Wen Gong's
        message of "Thu, 24 Oct 2019 17:40:25 +0800")
Message-ID: <87d0emsb5o.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2019-10-24 17:25, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:
>>
>>> The max bundle size support by firmware is 32, change it from 8 to 32
>>> will help performance. This results in significant performance
>>> improvement on RX path.
>>>
>>> Tested with QCA6174 SDIO with firmware
>>> WLAN.RMH.4.4.1-00017-QCARMSWPZ-1
>>>
>>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>>> ---
>>>  drivers/net/wireless/ath/ath10k/htc.h  | 12 +++++++++---
>>>  drivers/net/wireless/ath/ath10k/sdio.c |  4 ++--
>>>  drivers/net/wireless/ath/ath10k/sdio.h |  4 ++--
>>>  3 files changed, 13 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath10k/htc.h
>>> b/drivers/net/wireless/ath/ath10k/htc.h
>>> index f55d3ca..7055156 100644
>>> --- a/drivers/net/wireless/ath/ath10k/htc.h
>>> +++ b/drivers/net/wireless/ath/ath10k/htc.h
>>> @@ -39,7 +39,7 @@
>>>   * 4-byte aligned.
>>>   */
>>>
>>> -#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        8
>>> +#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32
>>
>> So how do I know that this change doesn't break any other hardware? I
>> did a quick review and I think it's safe, but the commit log mentions
>> nothing about this.
>
> the real max rx bundle is decided in ath10k_htc_wait_target.
> it is the min value of HTC_HOST_MAX_MSG_PER_RX_BUNDLE and the value
> reported from firmware.
> htc->max_msgs_per_htc_bundle =
> 			min_t(u8, msg->ready_ext.max_msgs_per_htc_bundle,
> 			      HTC_HOST_MAX_MSG_PER_RX_BUNDLE);

And we assume that no other firmware than QCA6174 SDIO uses value bigger
than 8? Because if there is a such firmware using, for example, value 9
this might cause a regression.

Anyway, I added this comment to the commit log:

  The real max rx bundle is decided in ath10k_htc_wait_target(), it is
  the min value of HTC_HOST_MAX_MSG_PER_RX_BUNDLE and the value reported
  from firmware. So this change shouldn't cause any regressions with
  other hardware supported by ath10k.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
