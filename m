Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB626B663
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 02:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgIPADj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 20:03:39 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:45190 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbgIOO3m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 10:29:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600180151; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ceGesYAEHORsiAolK47ALm71y0u08lJOj7k2tWEIcFw=; b=weh30RnBeOQKJHUP084YM9x5IQuX41dGTsa2l0inTA4MKM7Bq/t7iPMptnxCYCXYFM3oVfI0
 pXzGiFVxn4Ywj+OuLZfzhqeDAygDkUBFF1Nw+qaz5zJr2ZfJC7c9VFESOi+RqU1oT0vvBeWh
 I66GZx6HjxpbILrcvou7GJX9lHs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f60cf9dba408b30ceb9e99b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 14:28:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EFF0DC433F0; Tue, 15 Sep 2020 14:28:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36C6FC433C8;
        Tue, 15 Sep 2020 14:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36C6FC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Rakesh Pillai" <pillair@codeaurora.org>
Cc:     <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ath10k: Fixes during subsystem recovery
References: <1593197633-9014-1-git-send-email-pillair@codeaurora.org>
        <005d01d68b34$7bfc4960$73f4dc20$@codeaurora.org>
Date:   Tue, 15 Sep 2020 17:28:40 +0300
In-Reply-To: <005d01d68b34$7bfc4960$73f4dc20$@codeaurora.org> (Rakesh Pillai's
        message of "Tue, 15 Sep 2020 13:17:34 +0530")
Message-ID: <87lfhbnmg7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Rakesh Pillai" <pillair@codeaurora.org> writes:

>> -----Original Message-----
>> From: Rakesh Pillai <pillair@codeaurora.org>
>> Sent: Saturday, June 27, 2020 12:24 AM
>> To: ath10k@lists.infradead.org
>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Rakesh
>> Pillai <pillair@codeaurora.org>
>> Subject: [PATCH v2 0/2] ath10k: Fixes during subsystem recovery
>> 
>> This patch series includes some fixes when the device
>> is in recovery mode, i.e. when the firmware goes down.
>> 
>> - Pausing TX queues when FW goes down
>> - Removed unwanted/extra error logging in pkt TX path
>> - Skipping wait for FW response for delete cmds
>> - Handling the -ESHUTDOWN error code in case of SSR.
>> 
>> Rakesh Pillai (2):
>>   ath10k: Pause the tx queues when firmware is down
>>   ath10k: Skip wait for delete response if firmware is down
>> 
>>  drivers/net/wireless/ath/ath10k/core.h |  1 +
>>  drivers/net/wireless/ath/ath10k/mac.c  | 36 ++++++++++++++++++++++---
>> ---------
>>  drivers/net/wireless/ath/ath10k/snoc.c |  3 +++
>>  3 files changed, 28 insertions(+), 12 deletions(-)
>
> Hi Kalle,
> I see that this patch series is in Deferred state. Is there something
> missing or blocking this ?

Yeah, time to review it ;) I still have quite a lot of patches in
deferred state but I'm trying to go through it, albeit slowly.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
