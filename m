Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42F3B1F7D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 19:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFWRcb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 13:32:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29732 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFWRc1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 13:32:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624469410; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=s5Bz0eZCymv18Oj3WyVC1yQjpxs4Dm1dYfaMS7UGc5M=; b=GYLTM7TW4z1YGgiCdiYH24T5FKrEFtPgH4ZRjTx6/cMmBW2/esnDMEquCeptlarrVOZiH4US
 2o3wWHVAQa+BbRadicdRd2RF3of23xCX0Qs2cZWqMn7cM+KXj9+KK/sDVF+rjCQ7IOehUfF9
 21gRWNs9br0t2FHAs6u/epMxPss=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60d36f86dc4628fe7e629aa7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 17:29:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64760C43460; Wed, 23 Jun 2021 17:29:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C26C3C433D3;
        Wed, 23 Jun 2021 17:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C26C3C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, bbhatt=codeaurora.org@codeaurora.org,
        lilic@codeaurora.org, kangxu@codeaurora.org
Subject: Re: [PATCH v4 4/6] ath11k: set register access length for MHI driver
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
        <1620330705-40192-5-git-send-email-bbhatt@codeaurora.org>
        <20210521135152.GL70095@thinkpad> <87h7i0juxt.fsf@codeaurora.org>
        <37184e28dcc952ba9ad5ed0dc2c1a6da@codeaurora.org>
        <6ed9fe90f40e5f8151d3a028abf0acd1@codeaurora.org>
        <20210618064514.GM3682@workstation>
Date:   Wed, 23 Jun 2021 20:29:26 +0300
In-Reply-To: <20210618064514.GM3682@workstation> (Manivannan Sadhasivam's
        message of "Fri, 18 Jun 2021 12:15:14 +0530")
Message-ID: <87k0mkh4ll.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Wed, Jun 16, 2021 at 10:38:01AM -0700, Bhaumik Bhatt wrote:
>> Hi Kalle/Mani,
>> 
>> On 2021-06-14 10:49 AM, Bhaumik Bhatt wrote:
>> Just got confirmation that the whole patch series was tested for functional
>> sanity on
>> Dell E7590 + QCA6390 with Ubuntu18.04 and patch 4/6 is also good to go.
>> 
>> Can you please ACK and pick up this series?
>> 
>
> I can pick the series but I need an Ack from Kalle since it contains
> ath11k changes. Kalle, can you please Ack this patch?
>
> I'm planning to send the PR by this weekend.

Sorry for the late reply. Yes, as this now tested with ath11k driver
please take this ath11k patch via the mhi tree:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
