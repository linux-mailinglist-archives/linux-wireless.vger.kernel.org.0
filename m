Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC872F2DC2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jan 2021 12:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbhALLTG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jan 2021 06:19:06 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:39235 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbhALLTE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jan 2021 06:19:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610450325; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=BUNlSIBwn5Wu/ZxqpLBwFcJqTkVjVgHJ8+YrUS/IfOo=; b=h1hiEo/BXI3vhsdw2B4oAz7ElsQR1S0SkTD3bylEdBeEEUd86TPKrRJUtdVmyAy85coV6b02
 7+Oc1lKqiRKgsU4RuI2Kb0Npc+JdsMxm5wPGpek8Rq/cdLzNZD3CMvEmwz9WS/LsReCR83q4
 RvD1ea/V1XxYM8Fn6HmbpKqP7uk=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5ffd857946a6c7cde7076c52 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Jan 2021 11:18:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D88BC43464; Tue, 12 Jan 2021 11:18:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5317CC433C6;
        Tue, 12 Jan 2021 11:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5317CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Chen\, Rong A" <rong.a.chen@intel.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kernel test robot <lkp@intel.com>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        kbuild-all@lists.01.org, shawn.guo@linaro.org, benl@squareup.com,
        loic.poulain@linaro.org
Subject: Re: [kbuild-all] Re: [PATCH 06/13] wcn36xx: Add ipv6 namespace offload in suspend
References: <20201228162839.369156-7-bryan.odonoghue@linaro.org>
        <202012290547.6ryYf96B-lkp@intel.com>
        <bcf6adbc-e03a-6f02-e55f-6e0b738806fd@linaro.org>
        <878s8zlnnc.fsf@codeaurora.org>
        <ae4b3e6f-a08c-e1ba-e5a1-494a7db7e0bd@intel.com>
Date:   Tue, 12 Jan 2021 13:18:11 +0200
In-Reply-To: <ae4b3e6f-a08c-e1ba-e5a1-494a7db7e0bd@intel.com> (Rong A. Chen's
        message of "Tue, 12 Jan 2021 18:51:23 +0800")
Message-ID: <877doitnd8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Chen, Rong A" <rong.a.chen@intel.com> writes:

> On 1/11/2021 7:27 PM, Kalle Valo wrote:
>> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
>>
>>> On 28/12/2020 21:49, kernel test robot wrote:
>>>> [auto build test ERROR on wireless-drivers-next/master]
>>>
>>> hmm
>>>
>>> works against this
>>>
>>> * 77da2c99eca0 - (tag: ath-202012180905, ath.git/master) Add
>>> localversion-wireless-testing-ath (11 days ago)
>>
>> The bot tested only ath-next from ath.git, not the master branch:
>
> Hi,
>
> Thanks for the help, we have switched to test on master branch.

The bot was correctly testing the ath-next branch, as I use that branch
to commit the patches. Can you still change the bot back to use
ath-next, just as it did previously?

Sorry for the confusion.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
