Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055E830876
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaGXW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 02:23:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55066 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGXV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 02:23:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A62CF6087B; Fri, 31 May 2019 06:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559283799;
        bh=YFl5Adn4Q54WhWdAWUtBlxfjLjZ86CIlmjmIa+WgNP4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TAc5y9sUJquXt0zC5qymlRamViOhRPBD8g1ih/oFMw4vfZHb6UjvxOe8pLaF/z4ia
         XiS03Wyn8fXr5lWCgh4ZarZHLT4bjtWrYKOhurFUS/Rmd9+NcUpuKGLFeVbIp8U1+y
         ZLTRV3O/4JtpDqJ55XXQrhANszhUF0XGwkLhRDng=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED96160588;
        Fri, 31 May 2019 06:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559283798;
        bh=YFl5Adn4Q54WhWdAWUtBlxfjLjZ86CIlmjmIa+WgNP4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ACk7+UmkuiVL+MqW9hlDIi9BIAw6Ucmyu+bypEkubhNtt742XrYBD1IAZAh2464k0
         EYjmxMAsKkO4RbggbQ4wVJiOGzrSOi7O3iAQlvc8WX+nAOTs/4lJks3uVHLiQhmYKk
         cG+TT8THeoPWOv3ScNBUMWNi+RkHU3vnPAqCe6SE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED96160588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 00/16] wilc1000: move out of staging
References: <1549696298-9795-1-git-send-email-ajay.kathat@microchip.com>
        <5ac9d9bb-08e4-c46f-ce0a-40630e1d958e@microchip.com>
        <871s30pevc.fsf@codeaurora.org>
        <2ba91fc2-af3a-b235-5cb0-2ba06444ea30@microchip.com>
        <87sgt5cl8q.fsf@kamboji.qca.qualcomm.com>
        <fb17fb6b-08d2-6871-d214-2fbcc1da73fb@microchip.com>
        <8e227b89-6068-266c-f41d-1c45664d57d1@microchip.com>
Date:   Fri, 31 May 2019 09:23:14 +0300
In-Reply-To: <8e227b89-6068-266c-f41d-1c45664d57d1@microchip.com> (Ajay
        Kathat's message of "Fri, 31 May 2019 04:53:35 +0000")
Message-ID: <87zhn3ywfh.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> Hi Kalle,
>
> On 5/23/2019 10:15 PM, Ajay.Kathat@microchip.com wrote:
>> Hi Kalle,
>> 
>> On 5/23/2019 7:43 PM, Kalle Valo wrote:
>>> <Ajay.Kathat@microchip.com> writes:
>>>
>>>> Hi Kalle,
>>>>
>>>> On 3/21/2019 6:24 PM, Kalle Valo wrote:
>>>>>
>>>>> <Ajay.Kathat@microchip.com> writes:
>>>>>
>>>>>> Hi Kalle/Johannes,
>>>>>>
>>>>>> On 2/9/2019 12:42 PM, Ajay Kathat - I15481 wrote:
>>>>>>> From: Ajay Singh <ajay.kathat@microchip.com>
>>>>>>>
>>>>>>> This patch series is to review and move wilc1000 driver out of staging.
>>>>>>> Implemented the initial received review comments[1] and submitting the
>>>>>>> driver again. During this cleanup deleted around 3.3k lines of code.
>>>>>>>
>>>>>>> Below are the major items fixed in recent cleanup:
>>>>>>>  - remove use of shadow buffer to keep scan result.
>>>>>>>  - remove internal messaging flow to handle cfg80211_ops.
>>>>>>>  - make use of cfg80211 provided API.
>>>>>>>  - use structure for packing firmware commands.
>>>>>>>  - make use of kernel provided API and macros.
>>>>>>>  - remove unnecessary logs messages.
>>>>>>>
>>>>>>> Pending action item:
>>>>>>>  - dynamically add/remove p2p interface.
>>>>>>>
>>>>>>>  This item will take some time, we are planning to take it up after
>>>>>>>  mainline.
>>>>>>>
>>>>>>>  We hope it can be move out staging in v5.1.
>>>>>>>  Please review and confirm if it is good to move out.
>>>>>>
>>>>>> Do you have any update for this series. Please provide your inputs for
>>>>>> next step.
>>>>>
>>>>> rtw88 is taking priority in the new drivers "queue" so I doubt I can
>>>>> take a look at this in the next few weeks.
>>>>>
>>>>
>>>> Is there any update for wilc1000 driver review. Please let me know your
>>>> inputs.
>>>
>>> So is the driver in good shape now? I really do not want to use a lot of
>>> time reviewing it just to find out that there's a lot of work to do. For
>>> example, has someone else reviewed it?
>>>
>> 
>> The first series for complete driver review was submitted earlier [1].
>> It was reviewed by Johannes and he looked into driver integration with
>> the cfg80211 stack part. We worked on the review comments and submitted
>> the changes to staging.
>> 
>> We need further review to identify if there is any blocker to move to
>> mainline.
>> 
>> [1]. https://www.spinics.net/lists/linux-wireless/msg177878.html
>> 
>
> Just a gentle mail to check if wilc1000 driver is picked-up for review
> and what is the next step.

Please be patient, getting a driver upstream is not a simple task. What
this driver needs now is reviews and people saying that the driver is
ready for upstream, I have not seen any of that yet. Maybe you could
submit a new version, hopefully that triggers people to review this?
Also I'll try to find time for review but, as usual, I'm really busy.

-- 
Kalle Valo
