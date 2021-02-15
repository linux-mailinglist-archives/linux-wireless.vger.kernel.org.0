Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8561C31B642
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Feb 2021 10:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhBOJNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Feb 2021 04:13:23 -0500
Received: from z11.mailgun.us ([104.130.96.11]:61708 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhBOJNV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Feb 2021 04:13:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613380376; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=W2sk+Gk5BTxcdo7/vBuLPXm/MInjWkd57U6nnxHUMTk=; b=BV2rQEuH5kwUM3PrwZ/HPax1vjuOrTaLhFML7lHy4IO8V51x+7qlLmGXjqcBYqLjnkoPp20Q
 PQDqJHZq9T5PgQeUQG1L4SjtBmZW7oqTRx1i4siiMTWCa4ioS7ifNsXi80/kTYtcUxuodzw5
 aigDptJoEc1OEwEGaeFHgz0+j84=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 602a3aebd5a7a3baaeb05793 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Feb 2021 09:12:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60186C433CA; Mon, 15 Feb 2021 09:12:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EDE0C433ED;
        Mon, 15 Feb 2021 09:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EDE0C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, hurricos@gmail.com
Subject: Re: [PATCH] ath9k: fix transmitting to stations in dynamic SMPS mode
References: <20210214184911.96702-1-nbd@nbd.name>
        <8735xyrkvy.fsf@codeaurora.org>
        <d668f30a-f911-921f-d329-f6ac872d0bcc@nbd.name>
Date:   Mon, 15 Feb 2021 11:12:06 +0200
In-Reply-To: <d668f30a-f911-921f-d329-f6ac872d0bcc@nbd.name> (Felix Fietkau's
        message of "Mon, 15 Feb 2021 08:20:04 +0100")
Message-ID: <87y2fpr8yh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2021-02-15 05:54, Kalle Valo wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>> 
>>> When transmitting to a receiver in dynamic SMPS mode, all transmissions that
>>> use multiple spatial streams need to be sent using CTS-to-self or RTS/CTS to
>>> give the receiver's extra chains some time to wake up.
>>> This fixes the tx rate getting stuck at <= MCS7 for some clients, especially
>>> Intel ones, which make aggressive use of SMPS.
>>>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Martin Kennedy <hurricos@gmail.com>
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> 
>> No Fixes tag so I assume this is not a regression?
>> 
>> Should this go to v5.12 or -next? I guess that depends how much testing
>> this patch has got.
>
> I'd prefer v5.12. I got confirmation that the patch makes a big
> difference in throughput with Intel clients (makes tx with MCS > 7
> work), and I think there is very little potential for regressions.

Good, I'll queue this to v5.12 then. And we have plenty of time to fix
any regressions anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
