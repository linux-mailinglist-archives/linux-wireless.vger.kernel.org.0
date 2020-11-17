Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD72B6B8D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Nov 2020 18:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgKQRRr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 12:17:47 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:56457 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbgKQRRq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 12:17:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605633465; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=asJBzxf626itj7z5VEyrbr5Efzoc3mFG5fbDkfP/Rgk=;
 b=cTaB+AcpM9lgDi6ckkhsFbSspEedIxQfti3tMsQp9G+Z3qxCbSiJu4cTebw8ADZFmg2QH3RN
 LjWRZx8H4SNA1EWXA1Lo4ZTyasEM7EDW7KfwtUEmeA49MXARcgtoEmTRyyj1D9oXP1hezVeJ
 JN18pHt8nNudxC0e2lPGoyWsR+I=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fb405a6135ce186e96f5f71 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 17:17:26
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92FF6C43462; Tue, 17 Nov 2020 17:17:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E689EC433C6;
        Tue, 17 Nov 2020 17:17:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Nov 2020 09:17:24 -0800
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kvalo=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] ath11k: use MHI provided APIs to allocate and free MHI
 controller
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <87tutozc7h.fsf@codeaurora.org>
References: <1605571300-4438-1-git-send-email-bbhatt@codeaurora.org>
 <87tutozc7h.fsf@codeaurora.org>
Message-ID: <d06eae092fcb0c3319ab793c8063a12d@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-16 11:14 PM, Kalle Valo wrote:
> Bhaumik Bhatt <bbhatt@codeaurora.org> writes:
> 
>> Use MHI provided APIs to allocate and free MHI controller to
>> improve MHI host driver handling.
> 
> How does it improve the handling?
> 
Main reason is we want to ensure the MHI controller is zero-initialized 
and
we want to mandate it as it is better to have it under our control in 
case
we also want to allocate and track peripheral data/memory related to the 
MHI
controller.
>> This also fixes a memory leak as the MHI controller was allocated but
>> never freed.
>> 
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> ---
>>  drivers/net/wireless/ath/ath11k/mhi.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> For ath11k patches please CC ath11k and linux-wireless lists so that
> patchwork sees it. So you need to resend this.
> 
> Is this a new API? I need to understand if there are any dependencies
> between mhi and ath trees, or if I can apply this directly to my 
> ath.git
> tree.

This one should be dependent on the patch [1] which exists on mainline 
and
should already part of your tree if you're on any 5.10 RC.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/bus/mhi?h=v5.10-rc4&id=f42dfbe8f712127031e7b9bc938a1c33cec2ff57

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
