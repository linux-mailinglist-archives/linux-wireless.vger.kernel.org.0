Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F067D375ED7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 May 2021 04:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhEGCeX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 22:34:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:36434 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbhEGCeV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 22:34:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620354803; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=8laHLxpGeb7o6Scw5WGknuXL88+X8velIbUvuC+eLbs=; b=NIuCncq92KrkmQWbYB+qpHwB8WYioIpBlFwbP3Nm6KMrdu40S+cyjluxqg6eiAPSYk+tJHq+
 LkrV0aWUnAwC2JebNGO5ir3z4dbt3sHlZnVJx9ljqFJTHxkIiW9hNE5ICYTt/sw+jG+MKJOu
 eUK8UwFN8HO1ntWB2Kung3jRi8w=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6094a6f1e0e9c9a6b601e82e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 07 May 2021 02:33:21
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3EA25C433D3; Fri,  7 May 2021 02:33:21 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EEFEC433D3;
        Fri,  7 May 2021 02:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EEFEC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v4 6/6] bus: mhi: core: Add range checks for BHI and BHIe
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        ath11k@lists.infradead.org
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
 <1620330705-40192-7-git-send-email-bbhatt@codeaurora.org>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <860e3d9d-91dc-7fd6-68f6-e8f099cc4555@codeaurora.org>
Date:   Thu, 6 May 2021 19:33:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1620330705-40192-7-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/6/21 12:51 PM, Bhaumik Bhatt wrote:
> When obtaining the BHI or BHIe offsets during the power up
> preparation phase, range checks are missing. These can help
> controller drivers avoid accessing any address outside of the
> MMIO region. Ensure that mhi_cntrl->reg_len is set before MHI
> registration as it is a required field and range checks will
> fail without it.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
