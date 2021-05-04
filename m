Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449D737329F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 01:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhEDXFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 19:05:17 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:20881 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhEDXFQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 19:05:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620169461; h=Message-ID: References: In-Reply-To: Reply-To:
 Subject: Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=n8UfbbC1ipgkRcc5b6HF51NbS+0PW0JqK6XaicMOO5Y=;
 b=izrUNSk4YvFgUjQvPWH0aaupjms4biALTjfNdPLEyjcTUuUvWHcDYwLn08bNG4nBn21lnuVM
 2ho/CySVQAYf3EEjPpG/67HuIXLwuT25vl+rvNMV4RiMw7jcfLZeKVgCNAKSV6BvKgYmpJS3
 1EqE5+32ersagwK0FzQlkz7f2TM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6091d2ee8807bcde1d87d2cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 May 2021 23:04:14
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC60EC433F1; Tue,  4 May 2021 23:04:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A1CBC433D3;
        Tue,  4 May 2021 23:04:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 May 2021 16:04:12 -0700
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v1 3/6] bus: mhi: Add MMIO region length to controller
 structure
Organization: Qualcomm Innovation Center, Inc.
Reply-To: bbhatt@codeaurora.org
Mail-Reply-To: bbhatt@codeaurora.org
In-Reply-To: <83589a09-e1a0-4611-a844-0ea52ca036b9@quicinc.com>
References: <1618598825-18629-1-git-send-email-bbhatt@codeaurora.org>
 <1618598825-18629-4-git-send-email-bbhatt@codeaurora.org>
 <83589a09-e1a0-4611-a844-0ea52ca036b9@quicinc.com>
Message-ID: <928a29dca0d2b141d4e21b7878c1c42e@codeaurora.org>
X-Sender: bbhatt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jeff,

On 2021-05-04 10:28 AM, Jeffrey Hugo wrote:
> On 4/16/2021 12:47 PM, Bhaumik Bhatt wrote:
>> Make controller driver specify the MMIO register region length
>> for range checking of BHI or BHIe space. This can help validate
>> that offsets are in acceptable memory region or not and avoid any
>> boot-up issues due to BHI or BHIe memory accesses.
>> 
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> ---
>>   include/linux/mhi.h | 2 ++
>>   1 file changed, 2 insertions(+)
>> 
>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>> index 944aa3a..ad53b24 100644
>> --- a/include/linux/mhi.h
>> +++ b/include/linux/mhi.h
>> @@ -293,6 +293,7 @@ struct mhi_controller_config {
>>    * @mhi_dev: MHI device instance for the controller
>>    * @debugfs_dentry: MHI controller debugfs directory
>>    * @regs: Base address of MHI MMIO register space (required)
>> + * @reg_len: Length of the MHI MMIO region (required)
>>    * @bhi: Points to base of MHI BHI register space
>>    * @bhie: Points to base of MHI BHIe register space
>>    * @wake_db: MHI WAKE doorbell register address
>> @@ -375,6 +376,7 @@ struct mhi_controller {
>>   	struct mhi_device *mhi_dev;
>>   	struct dentry *debugfs_dentry;
>>   	void __iomem *regs;
>> +	size_t reg_len;
> 
> Didn't Mani make sure this struct was packed using pahole when things
> were first upstreamed?  Feels like sticking this in the middle of a
> bunch of void * entries will add some padding.  Am I wrong?
> 
OK. I missed out on this detail. I can move this size_t entry in v2.
>>   	void __iomem *bhi;
>>   	void __iomem *bhie;
>>   	void __iomem *wake_db;
>> 

Thanks,
Bhaumik
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
