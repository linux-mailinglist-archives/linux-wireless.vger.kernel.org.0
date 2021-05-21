Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF8C38C850
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 15:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhEUNj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 May 2021 09:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236024AbhEUNjA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 May 2021 09:39:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CDE6109F;
        Fri, 21 May 2021 13:37:32 +0000 (UTC)
Date:   Fri, 21 May 2021 19:07:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v4 2/6] bus: mhi: core: Set BHI and BHIe pointers to NULL
 in clean-up
Message-ID: <20210521133728.GJ70095@thinkpad>
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
 <1620330705-40192-3-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620330705-40192-3-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 06, 2021 at 12:51:41PM -0700, Bhaumik Bhatt wrote:
> Set the BHI and BHIe pointers to NULL as part of clean-up. This
> makes sure that stale pointers are not accessed after powering
> MHI down.
> 
> Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 11c7a3d..1cc2f22 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -1132,6 +1132,9 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>  		mhi_cntrl->rddm_image = NULL;
>  	}
>  
> +	mhi_cntrl->bhi = NULL;
> +	mhi_cntrl->bhie = NULL;
> +
>  	mhi_deinit_dev_ctxt(mhi_cntrl);
>  }
>  EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
