Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5083AA28D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jun 2021 19:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFPRkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Jun 2021 13:40:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41517 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhFPRkQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Jun 2021 13:40:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623865090; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TABrvwCzw7wuTAokLpE+jbKeoDKxrwFh4qxRG/wt1+U=;
 b=HX9rHcKSuyj7Oe506E3JJV57y5JVWbgdxA+SWyKzZMTPKo++yMZtaMu3EqwM4gzExZ51zQP9
 uzOOHtPRMp/q19HEOQ+1dQUeJ0CecLqbUmr6zr1J3ch/4NoyCAXK9pxhFMryDk7Jqs/he/z9
 BADzhDfTb+tNAYfOYzy6/rlr5I8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60ca36fbe27c0cc77f2596de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Jun 2021 17:38:03
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51D22C43217; Wed, 16 Jun 2021 17:38:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55446C433F1;
        Wed, 16 Jun 2021 17:38:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Jun 2021 10:38:01 -0700
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, bbhatt=codeaurora.org@codeaurora.org,
        lilic@codeaurora.org, kangxu@codeaurora.org
Subject: Re: [PATCH v4 4/6] ath11k: set register access length for MHI driver
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <37184e28dcc952ba9ad5ed0dc2c1a6da@codeaurora.org>
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
 <1620330705-40192-5-git-send-email-bbhatt@codeaurora.org>
 <20210521135152.GL70095@thinkpad> <87h7i0juxt.fsf@codeaurora.org>
 <37184e28dcc952ba9ad5ed0dc2c1a6da@codeaurora.org>
Message-ID: <6ed9fe90f40e5f8151d3a028abf0acd1@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle/Mani,

On 2021-06-14 10:49 AM, Bhaumik Bhatt wrote:
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
>>> Kalle, should we do immutable branch for this patch or I can pick it 
>>> up via MHI
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
>> 1-3 are included in the tree but not patch 4? Wouldn't ath11k be 
>> broken
>> then? I didn't review the whole patchset, but I suspect the fix is to
>> include the ath11k change in the actual mhi patch which changes the
>> functionality. So that way we would not have a separate ath11k patch 
>> at
>> all.
>> 
>> Also I'm not able to test this patchset at the moment. Can someone 
>> else
>> help and do a quick test with QCA6390 to verify these doesn't break
>> ath11k?
> 
> I have requested someone to try and test this patch series with 
> QCA6390.
> 
> I or the testers will get back to you with the test results when they 
> are
> available.
> 
> As far as your concerns go, you can choose to pick patches 1-3 and that 
> would
> be just fine.
> 
> Things will break if patchset 4 is _not_ in place with patchset 6 being 
> part of
> the tree.
> 
> It would, however, be nice to pick the whole series instead and ensure 
> that
> the functionality MHI introduces for boot-up sanity is in place for any
> controllers such as ath11k.
> 
> Thanks,
> Bhaumik
> ---
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
> Forum,
> a Linux Foundation Collaborative Project

Just got confirmation that the whole patch series was tested for 
functional sanity on
Dell E7590 + QCA6390 with Ubuntu18.04 and patch 4/6 is also good to go.

Can you please ACK and pick up this series?

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
