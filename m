Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291A838C8C2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhEUN4J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 May 2021 09:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231707AbhEUN4J (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 May 2021 09:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66940611AD;
        Fri, 21 May 2021 13:54:42 +0000 (UTC)
Date:   Fri, 21 May 2021 19:24:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v4 6/6] bus: mhi: core: Add range checks for BHI and BHIe
Message-ID: <20210521135437.GN70095@thinkpad>
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
 <1620330705-40192-7-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620330705-40192-7-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 06, 2021 at 12:51:45PM -0700, Bhaumik Bhatt wrote:
> When obtaining the BHI or BHIe offsets during the power up
> preparation phase, range checks are missing. These can help
> controller drivers avoid accessing any address outside of the
> MMIO region. Ensure that mhi_cntrl->reg_len is set before MHI
> registration as it is a required field and range checks will
> fail without it.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 1cc2f22..aeb1e3c 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -885,7 +885,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
>  	    !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
>  	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
> -	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs || !mhi_cntrl->irq)
> +	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs ||
> +	    !mhi_cntrl->irq || !mhi_cntrl->reg_len)
>  		return -EINVAL;
>  
>  	ret = parse_config(mhi_cntrl, config);
> @@ -1077,6 +1078,13 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>  		dev_err(dev, "Error getting BHI offset\n");
>  		goto error_reg_offset;
>  	}
> +
> +	if (bhi_off >= mhi_cntrl->reg_len) {
> +		dev_err(dev, "BHI offset: 0x%x is out of range: 0x%zx\n",
> +			bhi_off, mhi_cntrl->reg_len);
> +		ret = -EINVAL;
> +		goto error_reg_offset;
> +	}
>  	mhi_cntrl->bhi = mhi_cntrl->regs + bhi_off;
>  
>  	if (mhi_cntrl->fbc_download || mhi_cntrl->rddm_size) {
> @@ -1086,6 +1094,14 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>  			dev_err(dev, "Error getting BHIE offset\n");
>  			goto error_reg_offset;
>  		}
> +
> +		if (bhie_off >= mhi_cntrl->reg_len) {
> +			dev_err(dev,
> +				"BHIe offset: 0x%x is out of range: 0x%zx\n",
> +				bhie_off, mhi_cntrl->reg_len);
> +			ret = -EINVAL;
> +			goto error_reg_offset;
> +		}
>  		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
>  	}
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
