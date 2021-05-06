Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF0374C35
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 02:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhEFANP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 20:13:15 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17133 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhEFANP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 20:13:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620259937; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=pKhzewIExom3v+dwxtzsTkBsKL6YMTRwhAWb3ai83A4=; b=qLbGwOzWScLTgQZWK/cUmSsmB9j+9pyAqr/z0EKn/u5Dgk07gR51cHuHx2Wae4fiVlAgFFhC
 Py6HyMiDGEQnacAm53NYpze1gC0D8XcvebjBSe+NkoGgH2aqlJMTNl98PmS21JgAhw34nMEk
 LlcZ/7bS/TOTqap+dy5U1CDqnKk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6093346055b14811b42c5a97 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 00:12:16
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B820DC43460; Thu,  6 May 2021 00:12:15 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E519C433D3;
        Thu,  6 May 2021 00:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E519C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v3 6/6] bus: mhi: core: Add range checks for BHI and BHIe
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        ath11k@lists.infradead.org
References: <1620234501-30461-1-git-send-email-bbhatt@codeaurora.org>
 <1620234501-30461-7-git-send-email-bbhatt@codeaurora.org>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <4eb740c7-d95f-8962-a06e-677404ebe84d@codeaurora.org>
Date:   Wed, 5 May 2021 17:12:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1620234501-30461-7-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bhaumik,

On 5/5/21 10:08 AM, Bhaumik Bhatt wrote:
> When obtaining the BHI or BHIe offsets during the power up
> preparation phase, range checks are missing. These can help
> controller drivers avoid accessing any address outside of the
> MMIO region. Ensure that mhi_cntrl->reg_len is set before MHI
> registration as it is a required field and range checks will
> fail without it.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>   drivers/bus/mhi/core/init.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 1cc2f22..86ad06e 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -885,7 +885,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>   	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
>   	    !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
>   	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
> -	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs || !mhi_cntrl->irq)
> +	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs ||
> +	    !mhi_cntrl->irq || !mhi_cntrl->reg_len)
>   		return -EINVAL;
>   
>   	ret = parse_config(mhi_cntrl, config);
> @@ -1077,6 +1078,12 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>   		dev_err(dev, "Error getting BHI offset\n");
>   		goto error_reg_offset;
>   	}
> +
> +	if (bhi_off >= mhi_cntrl->reg_len) {
> +		dev_err(dev, "BHI offset is out of range\n");
Does is make sense to also log bhi_off and/or reg_len values in error if 
it helps in debugging
> +		ret = -EINVAL;
> +		goto error_reg_offset;
> +	}
>   	mhi_cntrl->bhi = mhi_cntrl->regs + bhi_off;
>   
>   	if (mhi_cntrl->fbc_download || mhi_cntrl->rddm_size) {
> @@ -1086,6 +1093,12 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>   			dev_err(dev, "Error getting BHIE offset\n");
>   			goto error_reg_offset;
>   		}
> +
> +		if (bhie_off >= mhi_cntrl->reg_len) {
> +			dev_err(dev, "BHIe offset is out of range\n");
Same comment as above
> +			ret = -EINVAL;
> +			goto error_reg_offset;
> +		}
>   		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
>   	}
>   
> 

Thanks,
Hemant
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
