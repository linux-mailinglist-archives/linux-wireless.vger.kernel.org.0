Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0CC3B1F97
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFWRg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 13:36:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:62839 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFWRgz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 13:36:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624469678; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=IIQCwdK7TFh8FgtUV+3MnvrVYUHcl6vu82d9dovgdYY=; b=iuMOXjUT3FeWQ0Lv8uoppXSZHVqnBmlgjOHzu6wxwfrbkzIUBVTKF0WOybvdJzFfd4aBLnSp
 +OZ1SZ1vBpkpxV5h0ngfX1wi4M2WdeuT/GrSLIGpKZw/Jl94xRZzeDrUEXgP1+w6TkWHORs1
 b38K7XiDHz8f6y2GJyvDMCS7evo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60d3708fd2559fe392e00866 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 17:34:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88512C43145; Wed, 23 Jun 2021 17:34:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E217C43217;
        Wed, 23 Jun 2021 17:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E217C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v4 4/6] ath11k: set register access length for MHI driver
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
        <1620330705-40192-5-git-send-email-bbhatt@codeaurora.org>
        <20210521135152.GL70095@thinkpad> <87h7i0juxt.fsf@codeaurora.org>
        <37184e28dcc952ba9ad5ed0dc2c1a6da@codeaurora.org>
Date:   Wed, 23 Jun 2021 20:34:02 +0300
In-Reply-To: <37184e28dcc952ba9ad5ed0dc2c1a6da@codeaurora.org> (Bhaumik
        Bhatt's message of "Mon, 14 Jun 2021 10:49:51 -0700")
Message-ID: <87fsx8h4dx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bhaumik Bhatt <bbhatt@codeaurora.org> writes:

> Hi Kalle,
>
> On 2021-06-14 09:02 AM, Kalle Valo wrote:
>> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
>>
>>> On Thu, May 06, 2021 at 12:51:43PM -0700, Bhaumik Bhatt wrote:
>>>> MHI driver requires register space length to add range checks and
>>>> prevent memory region accesses outside of that for MMIO space.
>>>> Set it before registering the MHI controller.
>>>>
>>>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>>> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
>>>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>
>>> Kalle, should we do immutable branch for this patch or I can pick
>>> it up via MHI
>>> tree (if there are no other patches expected from ath11k for this
>>> controller)?
>>
>> I'm not expecting any conflicts with this, and if there are, they
>> should
>> be easy for Stephen or Linus to fix. So it's easiest to route this via
>> your tree. But I'm not giving my ack yet, see below.
>>
>> I'm worried that this patchset breaks bisect. Every patch in the
>> patchset should not break existing functionality, what if only patches
>> 1-3 are included in the tree but not patch 4? Wouldn't ath11k be broken
>> then? I didn't review the whole patchset, but I suspect the fix is to
>> include the ath11k change in the actual mhi patch which changes the
>> functionality. So that way we would not have a separate ath11k patch at
>> all.
>>
>> Also I'm not able to test this patchset at the moment. Can someone else
>> help and do a quick test with QCA6390 to verify these doesn't break
>> ath11k?
>
> I have requested someone to try and test this patch series with QCA6390.
>
> I or the testers will get back to you with the test results when they
> are available.
>
> As far as your concerns go, you can choose to pick patches 1-3 and
> that would be just fine.
>
> Things will break if patchset 4 is _not_ in place with patchset 6
> being part of the tree.
>
> It would, however, be nice to pick the whole series instead and ensure
> that the functionality MHI introduces for boot-up sanity is in place
> for any controllers such as ath11k.

Just to be clear, this is not about me picking up any patches
separately. I was instead making sure git-bisect works correctly, as it
can randomly choose to test any commit in the tree. But based on your
description everything seems to be in order in this patchset and bisect
will work correctly.

git-bisect is an important tool for me when I'm searching the root cause
for ath11k regressions, that's why I'm so careful to make sure it works.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
