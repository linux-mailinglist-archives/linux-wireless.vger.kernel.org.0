Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB138C860
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbhEUNkA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 May 2021 09:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236157AbhEUNjq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 May 2021 09:39:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 962636109F;
        Fri, 21 May 2021 13:38:17 +0000 (UTC)
Date:   Fri, 21 May 2021 19:08:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v4 3/6] bus: mhi: Add MMIO region length to controller
 structure
Message-ID: <20210521133812.GK70095@thinkpad>
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
 <1620330705-40192-4-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620330705-40192-4-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 06, 2021 at 12:51:42PM -0700, Bhaumik Bhatt wrote:
> Make controller driver specify the MMIO register region length
> for range checking of BHI or BHIe space. This can help validate
> that offsets are in acceptable memory region or not and avoid any
> boot-up issues due to BHI or BHIe memory accesses.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  include/linux/mhi.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 944aa3a..9c347f5 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -303,6 +303,7 @@ struct mhi_controller_config {
>   * @rddm_size: RAM dump size that host should allocate for debugging purpose
>   * @sbl_size: SBL image size downloaded through BHIe (optional)
>   * @seg_len: BHIe vector size (optional)
> + * @reg_len: Length of the MHI MMIO region (required)
>   * @fbc_image: Points to firmware image buffer
>   * @rddm_image: Points to RAM dump buffer
>   * @mhi_chan: Points to the channel configuration table
> @@ -386,6 +387,7 @@ struct mhi_controller {
>  	size_t rddm_size;
>  	size_t sbl_size;
>  	size_t seg_len;
> +	size_t reg_len;
>  	struct image_info *fbc_image;
>  	struct image_info *rddm_image;
>  	struct mhi_chan *mhi_chan;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
