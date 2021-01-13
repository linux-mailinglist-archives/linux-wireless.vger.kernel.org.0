Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF112F4500
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jan 2021 08:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbhAMHM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jan 2021 02:12:56 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:25380 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbhAMHM4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jan 2021 02:12:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610521959; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=42gdzoisX6avUXZqmMiYtvEe2JgypnINF9ruZIBAmLk=; b=gDXHEzCWIGwOCHbCRAQ/gJAgPdJwrr24bgzcH6TnSLYPEMEltEp6I3JgwaW3JxzYR7e8Z7t+
 uavG2u2y9M6vXxh/f3q626J5ugNCvEw3WMocyd2WjLr8hl0QSyGuUyxZ4VcGwGPRHK/KzHgk
 skjVMugHEDUxfozH449aC/x3YUg=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ffe9d419dddba11a6e295a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Jan 2021 07:12:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C50B5C433CA; Wed, 13 Jan 2021 07:12:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C733CC433C6;
        Wed, 13 Jan 2021 07:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C733CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     benl@squareup.com, loic.poulain@linaro.org,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        shawn.guo@linaro.org
Subject: Re: [kbuild-all] Re: [PATCH 06/13] wcn36xx: Add ipv6 namespace offload in suspend
References: <20201228162839.369156-7-bryan.odonoghue@linaro.org>
        <202012290547.6ryYf96B-lkp@intel.com>
        <bcf6adbc-e03a-6f02-e55f-6e0b738806fd@linaro.org>
        <878s8zlnnc.fsf@codeaurora.org>
        <ae4b3e6f-a08c-e1ba-e5a1-494a7db7e0bd@intel.com>
        <877doitnd8.fsf@codeaurora.org>
        <851a3629-8d18-08a7-2926-67dd45cabbed@intel.com>
Date:   Wed, 13 Jan 2021 09:11:56 +0200
In-Reply-To: <851a3629-8d18-08a7-2926-67dd45cabbed@intel.com> (Rong Chen's
        message of "Wed, 13 Jan 2021 09:57:23 +0800")
Message-ID: <87czy9s43n.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rong Chen <rong.a.chen@intel.com> writes:

> On 1/12/21 7:18 PM, Kalle Valo wrote:
>> "Chen, Rong A" <rong.a.chen@intel.com> writes:
>>
>>> On 1/11/2021 7:27 PM, Kalle Valo wrote:
>>>> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
>>>>
>>>>> On 28/12/2020 21:49, kernel test robot wrote:
>>>>>> [auto build test ERROR on wireless-drivers-next/master]
>>>>> hmm
>>>>>
>>>>> works against this
>>>>>
>>>>> * 77da2c99eca0 - (tag: ath-202012180905, ath.git/master) Add
>>>>> localversion-wireless-testing-ath (11 days ago)
>>>> The bot tested only ath-next from ath.git, not the master branch:
>>> Hi,
>>>
>>> Thanks for the help, we have switched to test on master branch.
>> The bot was correctly testing the ath-next branch, as I use that branch
>> to commit the patches. Can you still change the bot back to use
>> ath-next, just as it did previously?
>>
>> Sorry for the confusion.
>>
>
> Got it, we'll still test ath-next branch.

Great, thank you. And thank you for maintaing kbuild bot, it's awesome :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
