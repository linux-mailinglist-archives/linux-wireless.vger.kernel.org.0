Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8CD211F15
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgGBInc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 04:43:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41952 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGBInc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 04:43:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593679411; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Gt6gtySvQvf4hvmvslOeFNuAum0rAOJn0h3FMcdMzrM=; b=w/wjJUXQmkzHaJmRDyn2fDoZpQglHHWVsJMvRMNUhnQsK+jfiwXN82bVp1z4yeWSb/rGSzmO
 O0thby7StSaCZUsLS3gZXVH61VdNoe2ibp4MC0QBQB6MSDfqEGaJ916HDedXKdPqz7+VKe0E
 nnUN0SAV9ikoN7ZSn0yAwa4dAd4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5efd9e21567385e8e72e65ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 08:43:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4196AC4339C; Thu,  2 Jul 2020 08:43:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D3BDC433C8;
        Thu,  2 Jul 2020 08:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D3BDC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH] wilc1000: move wilc driver out of staging
References: <20200625123712.14156-1-ajay.kathat@microchip.com>
        <875zb6e6zr.fsf@tynnyri.adurom.net>
        <a09157e8-6464-9d48-5d5d-fc168e1b85dc@microchip.com>
Date:   Thu, 02 Jul 2020 11:43:07 +0300
In-Reply-To: <a09157e8-6464-9d48-5d5d-fc168e1b85dc@microchip.com> (Ajay
        Kathat's message of "Thu, 2 Jul 2020 07:30:31 +0000")
Message-ID: <875zb6b944.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> On 02/07/20 12:30 pm, Kalle Valo wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>> 
>> <Ajay.Kathat@microchip.com> writes:
>> 
>>> From: Ajay Singh <ajay.kathat@microchip.com>
>>>
>>> WILC1000 is an IEEE 802.11 b/g/n IoT link controller module. The
>>> WILC1000 connects to Microchip AVR/SMART MCUs, SMART MPUs, and other
>>> processors with minimal resource requirements with a simple
>>> SPI/SDIO-to-Wi-Fi interface.
>>>
>>> WILC1000 driver has been part of staging for few years. With
>>> contributions from the community, it has improved significantly. Full
>>> driver review has helped in achieving the current state.
>>> The details for those reviews are captured in 1 & 2.
>>>
>>> [1].
>>> https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
>>> [2].
>>> https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
>>>
>>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>>> ---
>>>
>>> As suggested, keeping all the changes in single commit with file rename
>>> so it's easy to move out of staging [3].
>>>
>>> Please choose whichever option you prefer between the git mv or patch series
>>> sent last Tuesday. The resulting driver is the same as no patch has been
>>> queued in between.
>>>
>>> [3].
>>> https://lore.kernel.org/linux-wireless/20200623110000.31559-1-ajay.kathat@microchip.com/
>> 
>> As discussed with Greg I created an immutable branch for this and merged
>> the branch to wireless-drivers-next:
>
> Thanks Kalle.
>
> If my understanding is correct, we have to use 'wireless-driver-next'
> master branch to submit new patches for wilc1000. right?

Correct. And I also suggest to get familiar with the linux-wireless
patchwork to follow patch status, more info in the link below.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
