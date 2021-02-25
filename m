Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF8324C04
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 09:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhBYI0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 03:26:12 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:12834 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232601AbhBYI0K (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 03:26:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614241549; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PWifz4vP84bLxvHlPCRAiwUEUR2nSG6Gn0QA9RDeupU=; b=vruLJRXkvjeTwPjQtaJvqT9f2ggJTC5tVRauXH+UfEZG5pcj7K11PA5xVHVYMGi5bW4BKqMX
 Rsn5X6ubYaJ7U63oEeUrSW9XvyuZCc8AsOk/iiVoHbedfJ2GWXNjBTWlWlVMXRaLBzfb47Db
 f5blklhHzqVPZXX9FRICW7bNeXw=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60375ef0a27401dc65ed5d62 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Feb 2021 08:25:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 32DE1C433C6; Thu, 25 Feb 2021 08:25:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF5D8C433ED;
        Thu, 25 Feb 2021 08:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF5D8C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <davidm@egauge.net>, <linux-wireless@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
References: <20210224055135.1509200-1-davidm@egauge.net>
        <20210224055135.1509200-4-davidm@egauge.net>
        <a4261e8e-3693-2aa0-e23a-3bd3c6eb5686@microchip.com>
        <33012e779ee172e688cac2e710fa1ddab68fc611.camel@egauge.net>
        <56ff1617-8d39-9dbd-0055-b3cee6d458ff@microchip.com>
Date:   Thu, 25 Feb 2021 10:25:17 +0200
In-Reply-To: <56ff1617-8d39-9dbd-0055-b3cee6d458ff@microchip.com> (Ajay
        Kathat's message of "Thu, 25 Feb 2021 04:58:59 +0000")
Message-ID: <87im6geeqa.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> Hi David,
>
> On 24/02/21 9:17 pm, David Mosberger-Tang wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> Ajay,
>> 
>> On Wed, 2021-02-24 at 13:35 +0000, Ajay.Kathat@microchip.com wrote:
>>>
>>> One more observation.
>>> I am not clear if the below block is really needed. Have you faced any
>>> issue here and did the below logic of skipping data helped to come out
>>> of it. Also checking the limit of 16384(2*8KB) byte looks odd when the
>>> max limit for data packet is around 8KB. Am I missing something here.
>>>
>>>> +
>>>> +                               {
>>>> +                                       u8 byte;
>>>> +                                       int i;
>>>> +
>>>> +                                       for (i = 0; i < 16384; ++i) {
>>>> +                                               byte = 0;
>>>> +                                               wilc_spi_rx(wilc, &byte, 1);
>>>> +                                               if (!byte)
>>>> +                                                       break;
>>>> +                                       }
>>>> +                               }
>> 
>> Ouch, that's definitely not supposed to be there!  It's left-over debug
>> code from when I was tracking down the power-save issue.  Not sure how
>> I missed that.  Thanks for catching it and being so gentle about it!
>> 
>> How do I fix this best?  Do I resend the entire patch series or is it
>> OK to create a V2 of just this last patch?
>> 
>
> It's better to resubmit the complete patch series v2, as it would be
> convenient for Kalle to apply the patches in order.

Correct. This is also documented in the wiki, see the link below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
