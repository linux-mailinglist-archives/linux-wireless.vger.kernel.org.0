Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14923B2283
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 23:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFWVfi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 17:35:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43878 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhFWVff (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 17:35:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624483997; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tOGyNtlccrkAAMmGN0pd+swv2Kj8HU9UzZuPW5E+0JQ=;
 b=sPvfstCo/u1uXQTOCw0MOb3RzrFAun9YNNS7geyCoEz/HXJUcXss4eivmAzfKizJPBWqgv20
 JFyiJC4U9VPOUlC9V+/k816i2F5bvsWBoaiII/CBQqhmoK+ui1gDKb/RePpLc2nr6W4E2SHb
 c1kj9EZT5qdoJd1lc3ixAZ6nDTg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60d3a8905e3e57240b57b622 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 21:33:04
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ECB60C4338A; Wed, 23 Jun 2021 21:33:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE634C433D3;
        Wed, 23 Jun 2021 21:33:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jun 2021 14:33:02 -0700
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v4 4/6] ath11k: set register access length for MHI driver
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <87fsx8h4dx.fsf@codeaurora.org>
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
 <1620330705-40192-5-git-send-email-bbhatt@codeaurora.org>
 <20210521135152.GL70095@thinkpad> <87h7i0juxt.fsf@codeaurora.org>
 <37184e28dcc952ba9ad5ed0dc2c1a6da@codeaurora.org>
 <87fsx8h4dx.fsf@codeaurora.org>
Message-ID: <061e797fedbd1bc3dd7b86a087f6c69f@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-23 10:34 AM, Kalle Valo wrote:
> Bhaumik Bhatt <bbhatt@codeaurora.org> writes:
> 
>> Hi Kalle,
>> 
>> On 2021-06-14 09:02 AM, Kalle Valo wrote:
>>> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
>>> 
>>>> On Thu, May 06, 2021 at 12:51:43PM -0700, Bhaumik Bhatt wrote:
>>>>> MHI driver requires register space length to add range checks and
>>>>> prevent memory region accesses outside of that for MMIO space.
>>>>> Set it before registering the MHI controller.
>>>>> 
>>>>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>>>> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
>>>> 
>>>> Reviewed-by: Manivannan Sadhasivam 
>>>> <manivannan.sadhasivam@linaro.org>
>>>> 
>>>> Kalle, should we do immutable branch for this patch or I can pick
>>>> it up via MHI
>>>> tree (if there are no other patches expected from ath11k for this
>>>> controller)?
>>> 
>>> I'm not expecting any conflicts with this, and if there are, they
>>> should
>>> be easy for Stephen or Linus to fix. So it's easiest to route this 
>>> via
>>> your tree. But I'm not giving my ack yet, see below.
>>> 
>>> I'm worried that this patchset breaks bisect. Every patch in the
>>> patchset should not break existing functionality, what if only 
>>> patches
>>> 1-3 are included in the tree but not patch 4? Wouldn't ath11k be 
>>> broken
>>> then? I didn't review the whole patchset, but I suspect the fix is to
>>> include the ath11k change in the actual mhi patch which changes the
>>> functionality. So that way we would not have a separate ath11k patch 
>>> at
>>> all.
>>> 
>>> Also I'm not able to test this patchset at the moment. Can someone 
>>> else
>>> help and do a quick test with QCA6390 to verify these doesn't break
>>> ath11k?
>> 
>> I have requested someone to try and test this patch series with 
>> QCA6390.
>> 
>> I or the testers will get back to you with the test results when they
>> are available.
>> 
>> As far as your concerns go, you can choose to pick patches 1-3 and
>> that would be just fine.
>> 
>> Things will break if patchset 4 is _not_ in place with patchset 6
>> being part of the tree.
>> 
>> It would, however, be nice to pick the whole series instead and ensure
>> that the functionality MHI introduces for boot-up sanity is in place
>> for any controllers such as ath11k.
> 
> Just to be clear, this is not about me picking up any patches
> separately. I was instead making sure git-bisect works correctly, as it
> can randomly choose to test any commit in the tree. But based on your
> description everything seems to be in order in this patchset and bisect
> will work correctly.
> 
> git-bisect is an important tool for me when I'm searching the root 
> cause
> for ath11k regressions, that's why I'm so careful to make sure it 
> works.
OK. Understood.

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
