Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C38374C3B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 02:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEFAPW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 20:15:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12050 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhEFAPW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 20:15:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620260065; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=5fwKcjHax50dfp3M7rm8cG/FTAK0v0ueeXfFMFBGvSw=; b=tIKZ7BbsvijAgA7WFMFAiuUI4Lsey7RVFHWVxrKlucrCteqoL76/1hl5pOexexeNgnh12h+w
 EqOQ9apz7d1lb2iiaWc0boGN3Oqu04yW3KmY/MOqRn9wwAiAFaiB3nEDmH8b0mJjoTlWR8C4
 62+iC4D5BcyPV8x1anK/1Js6C8U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 609334dc87ce1fbb56178f1c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 00:14:20
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 53B0DC43460; Thu,  6 May 2021 00:14:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.46.162.249] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 457B6C433D3;
        Thu,  6 May 2021 00:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 457B6C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v3 5/6] bus: mhi: pci_generic: Set register access length
 for MHI driver
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        ath11k@lists.infradead.org
References: <1620234501-30461-1-git-send-email-bbhatt@codeaurora.org>
 <1620234501-30461-6-git-send-email-bbhatt@codeaurora.org>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <eb0ead5a-94e6-d5c5-4450-04e4515b59b8@codeaurora.org>
Date:   Wed, 5 May 2021 17:14:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1620234501-30461-6-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/5/21 10:08 AM, Bhaumik Bhatt wrote:
> MHI driver requires register space length to add range checks and
> prevent memory region accesses outside of that for MMIO space.
> Set it from the PCI generic controller driver before registering
> the MHI controller.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
