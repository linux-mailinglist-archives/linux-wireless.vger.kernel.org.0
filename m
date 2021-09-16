Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B240D2DF
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 07:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhIPFag (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 01:30:36 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60258 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhIPFaf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 01:30:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631770156; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=fOhYzZ+UiFCYWAUStU6MsbEzNyurKGfmDelClbmSdhU=; b=FS1W+DhFwS2ud5j7JwSPzVrCBNQmUTyQ9UZvRn4HKKIA9AD6XLg6qm6VI6o3oZ7pZ8jd3+hm
 pIG0Vt+/bRlZtI4PHsceeD1PFe/6XhIRwQolEts/mXjAveeE+XQ0JpI45hFduQv8EJAd/pBZ
 YujNAj2L7IRiGAC+ZsDLgu9GWqM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6142d61ad914b051824fd7ef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 05:28:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25DDBC43616; Thu, 16 Sep 2021 05:28:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 945DEC4338F;
        Thu, 16 Sep 2021 05:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 945DEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5] bus: mhi: core: Add support for processing priority of event ring
References: <1624641728-3886-1-git-send-email-bbhatt@codeaurora.org>
        <20210716114926.GH3323@workstation>
        <9300cf49a498521f471d6106131bd675@codeaurora.org>
        <9561c5a41e1707d694b1c872fea399de@codeaurora.org>
Date:   Thu, 16 Sep 2021 08:28:50 +0300
In-Reply-To: <9561c5a41e1707d694b1c872fea399de@codeaurora.org> (Bhaumik
        Bhatt's message of "Wed, 28 Jul 2021 17:06:24 -0700")
Message-ID: <87bl4t1431.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bhaumik,

Bhaumik Bhatt <bbhatt@codeaurora.org> writes:

> On 2021-07-16 11:22 AM, Bhaumik Bhatt wrote:
>> Hi Mani,
>>
>> On 2021-07-16 04:49 AM, Manivannan Sadhasivam wrote:
>>> On Fri, Jun 25, 2021 at 10:22:08AM -0700, Bhaumik Bhatt wrote:
>>>> From: Hemant Kumar <hemantk@codeaurora.org>
>>>>
>>>> Event ring priorities are currently set to 1 and are unused.
>>>> Default processing priority for event rings is set to regular
>>>> tasklet. Controllers can choose to use high priority tasklet
>>>> scheduling for certain event rings critical for processing such
>>>> as ones transporting control information if they wish to avoid
>>>> system scheduling delays for those packets. In order to support
>>>> these use cases, allow controllers to set event ring priority to
>>>> high.
>>>>
>>>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>
>>> Just curious, what are the event rings you are going to make as high
>>> priority? If you are going to do that for existing controllers, please
>>> submit a patch now itself.
>>>
>>> Thanks,
>>> Mani
>>>
>> Idea for this patch came from 914b72a6948b ("bus: mhi: Wait for M2
>> state during system resume").
>>
>> If WLAN ath11k controller driver wants to avoid the scenario
>> mentioned in
>> the above patch, it will help them to have a high priority for their
>> dedicated
>> control events ring.
>>
>> I would defer to Kalle and others in ath11k, whether or not they are
>> OK to take that route.
>> as an update to priority will just help return from resume faster.
>> It will also depend on system load/reproducibility rate of the
>> scenario.
>>
>> I can provide a patch for them to review/test since I do not have the
>> setup for it.
>>
> Would you like to try this patch out? It basically increases the
> priority
> at which the control events for M0/M1/M3 state changes are handled.
>
> Let me know if you have any questions.

At the moment I'm seriously lagging with patches so I don't really have
any free time. Can some other ath11k developer help here?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
