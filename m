Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1649438C8B0
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 15:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhEUNx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 May 2021 09:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhEUNxZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 May 2021 09:53:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D58E26008E;
        Fri, 21 May 2021 13:51:56 +0000 (UTC)
Date:   Fri, 21 May 2021 19:21:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v4 4/6] ath11k: set register access length for MHI driver
Message-ID: <20210521135152.GL70095@thinkpad>
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
 <1620330705-40192-5-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620330705-40192-5-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 06, 2021 at 12:51:43PM -0700, Bhaumik Bhatt wrote:
> MHI driver requires register space length to add range checks and
> prevent memory region accesses outside of that for MMIO space.
> Set it before registering the MHI controller.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Kalle, should we do immutable branch for this patch or I can pick it up via MHI
tree (if there are no other patches expected from ath11k for this controller)?

Thanks,
Mani

> ---
>  drivers/net/wireless/ath/ath11k/mhi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> index 09858e5..c0f013c 100644
> --- a/drivers/net/wireless/ath/ath11k/mhi.c
> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> @@ -235,6 +235,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
>  	mhi_ctrl->cntrl_dev = ab->dev;
>  	mhi_ctrl->fw_image = ab_pci->amss_path;
>  	mhi_ctrl->regs = ab->mem;
> +	mhi_ctrl->reg_len = ab->mem_len;
>  
>  	ret = ath11k_mhi_get_msi(ab_pci);
>  	if (ret) {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
