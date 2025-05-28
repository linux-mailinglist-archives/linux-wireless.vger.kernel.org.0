Return-Path: <linux-wireless+bounces-23451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B12AC613C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 07:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9443B60C1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795E20012B;
	Wed, 28 May 2025 05:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Oedzqhe1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B301FFC5C;
	Wed, 28 May 2025 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748410022; cv=pass; b=lmIPy/VVvExrM0H0jad0grnFm48znBvkGxlfCnizZsZ1sysJX0X4TjRFfoVlGWYl7+tWzJcTrRjBYgZxYHue1B9GI0iScJbNcGsl/CK7EsAlyJNfvUMFaNXIbfrQwkjdOnv4ngsEbpzN5EJvu45PaSJ78+i0Q+x1WMdOLzKZ9to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748410022; c=relaxed/simple;
	bh=BNNA0KlFqvK9JBZs3xUD+sBgeZhwZnPFvPtQtjsYQyk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hzaYv+kvsNhvZAZEc+NTIFWyfvcVwZHpwrsXDr8+yBcmZWLFeiKy6fKb9IChMuyemBqeqQCDIUZhDCanY5JwEYXg48B4E0vRSa97N8lXCMm2vK3lEQko5gjOityjsRAumaN/2v4Tb7H/B3d3Vi4vL0Vy/zM5zwLBM60P+CYHgZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Oedzqhe1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748409973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kISV225uerBQYDxJGvC2gFdYWteZbXRg2Jih6RVyio+dCh4o3wZDBBI1eZVzXlMXE9xFgVXuXHPMBMVGYrXLePZzzCq3NZp3s590sT1SuOnCqk/SYj8gZWc7TPOBT56BxsZzDLT9jkX8/MU6vnZhYA4loAZ4k/31O4dBMGZUvjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748409973; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nXpnKLzemS+hWAH6rg60RoGOFsXGoeHL9S1e6MhsnzM=; 
	b=XoWIK8QiF+HJJj5WdU+wKEPofQgxp1WkYgZj+LZr24A5c9g7QAZK7m7PrdpImgTUCAgXT9qkYnEYk4veH3Dph1Q1m9sbNbhVRHFlCTD6+u+ZRb2ctx4cWK2LFu1Wp6ZtlQVF+a+brVMS18aLxaFGuXz3/bHz0W+wAdGDt7w48Es=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748409973;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nXpnKLzemS+hWAH6rg60RoGOFsXGoeHL9S1e6MhsnzM=;
	b=Oedzqhe1ruZM/1R1BmC264P0HchB2wBTwN3tN4kWAQAfntpTwKkz+A7lShNYCqvF
	yi/egGpqak6zM5Lv8UdASGH9Q7x3Q3u9k/jHHo0WFk9voWOVsCenKn0RCYAkCaBNght
	80vsuyuQLgfZQeqyIe9kCbT0cj7NOywBfA8Tw3Z0=
Received: by mx.zohomail.com with SMTPS id 1748409971508258.3869752597926;
	Tue, 27 May 2025 22:26:11 -0700 (PDT)
Message-ID: <819f15f9-1b16-4b96-8273-3f95c1e071bb@collabora.com>
Date: Wed, 28 May 2025 10:25:59 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com,
 sebastian.reichel@collabora.com, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Baochen Qiang <quic_bqiang@quicinc.com>,
 Sumit Garg <sumit.garg@kernel.org>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Youssef Samir <quic_yabdulra@quicinc.com>,
 Matthew Leung <quic_mattleun@quicinc.com>,
 Carl Vanderlip <quic_carlv@quicinc.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Troy Hanson <quic_thanson@quicinc.com>, Alex Elder <elder@kernel.org>,
 Yan Zhen <yanzhen@vivo.com>, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH v6] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20250516184952.878726-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250516184952.878726-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Soft reminder

On 5/16/25 11:49 PM, Muhammad Usama Anjum wrote:
> Fix dma_direct_alloc() failure at resume time during bhie_table
> allocation because of memory pressure. There is a report where at
> resume time, the memory from the dma doesn't get allocated and MHI
> fails to re-initialize.
> 
> To fix it, don't free the memory at power down during suspend /
> hibernation. Instead, use the same allocated memory again after every
> resume / hibernation. This patch has been tested with resume and
> hibernation both.
> 
> Optimize the rddm and fbc bhie allocations. The rddm is of constant
> size for a given hardware. While the fbc_image size depends on the
> firmware. If the firmware changes, we'll free and allocate new memory
> for it. This patch is motivated from the ath12k [1] and ath11k [2]
> patches. They don't free the memory and reuse the same memory if new
> size is same. The firmware caching hasn't been implemented for the
> drivers other than in the nouveau. (The changing of firmware isn't
> tested/supported for wireless drivers. But let's follow the example
> patches here.)
> 
> [1] https://lore.kernel.org/all/20240419034034.2842-1-quic_bqiang@quicinc.com/
> [2] https://lore.kernel.org/all/20220506141448.10340-1-quic_akolli@quicinc.com/
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Tested-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Don't free bhie tables during suspend/hibernation only
> - Handle fbc_image changed size correctly
> - Remove fbc_image getting set to NULL in *free_bhie_table()
> 
> Changes since v2:
> - Remove the new mhi_partial_unprepare_after_power_down() and instead
>   update mhi_power_down_keep_dev() to use
>   mhi_power_down_unprepare_keep_dev() as suggested by Mani
> - Update all users of this API such as ath12k (previously only ath11k
>   was updated)
> - Define prev_fw_sz in docs
> - Do better alignment of comments
> 
> Changes since v3:
> - Fix state machine of ath12k by setting ATH12K_MHI_DEINIT with
>   ATH12K_MHI_POWER_OFF_KEEP_DEV state (Thanks Sebastian for testing and
>   finding the problem)
> - Use static with mhi_power_down_unprepare_keep_dev()
> - Remove crash log as it was showing that kworker wasn't able to
>   allocate memory.
> 
> Changes since v4:
> - Update description
> - Use __mhi_power_down_unprepare_keep_dev() in
>   mhi_unprepare_after_power_down()
> 
> Changes since v5:
> - Update description to don't give an impression that all bhie
>   allocations are being fixed. mhi_load_image_bhie() doesn't require
>   this optimization.
> 
> This patch doesn't have fixes tag as we are avoiding error in case of
> memory pressure. We are just making this driver more robust by not
> freeing the memory and using the same after resuming.
> ---
>  drivers/bus/mhi/host/boot.c           | 15 +++++++++++----
>  drivers/bus/mhi/host/init.c           | 18 ++++++++++++------
>  drivers/bus/mhi/host/internal.h       |  2 ++
>  drivers/bus/mhi/host/pm.c             |  1 +
>  drivers/net/wireless/ath/ath11k/mhi.c |  8 ++++----
>  drivers/net/wireless/ath/ath12k/mhi.c | 14 ++++++++++----
>  include/linux/mhi.h                   |  2 ++
>  7 files changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index efa3b6dddf4d2..bc8459798bbee 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -584,10 +584,17 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	 * device transitioning into MHI READY state
>  	 */
>  	if (fw_load_type == MHI_FW_LOAD_FBC) {
> -		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
> -		if (ret) {
> -			release_firmware(firmware);
> -			goto error_fw_load;
> +		if (mhi_cntrl->fbc_image && fw_sz != mhi_cntrl->prev_fw_sz) {
> +			mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
> +			mhi_cntrl->fbc_image = NULL;
> +		}
> +		if (!mhi_cntrl->fbc_image) {
> +			ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
> +			if (ret) {
> +				release_firmware(firmware);
> +				goto error_fw_load;
> +			}
> +			mhi_cntrl->prev_fw_sz = fw_sz;
>  		}
>  
>  		/* Load the firmware into BHIE vec table */
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 13e7a55f54ff4..8419ea8a5419b 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -1173,8 +1173,9 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>  		/*
>  		 * Allocate RDDM table for debugging purpose if specified
>  		 */
> -		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
> -				     mhi_cntrl->rddm_size);
> +		if (!mhi_cntrl->rddm_image)
> +			mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
> +					     mhi_cntrl->rddm_size);
>  		if (mhi_cntrl->rddm_image) {
>  			ret = mhi_rddm_prepare(mhi_cntrl,
>  					       mhi_cntrl->rddm_image);
> @@ -1200,6 +1201,14 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>  }
>  EXPORT_SYMBOL_GPL(mhi_prepare_for_power_up);
>  
> +void __mhi_unprepare_keep_dev(struct mhi_controller *mhi_cntrl)
> +{
> +	mhi_cntrl->bhi = NULL;
> +	mhi_cntrl->bhie = NULL;
> +
> +	mhi_deinit_dev_ctxt(mhi_cntrl);
> +}
> +
>  void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>  {
>  	if (mhi_cntrl->fbc_image) {
> @@ -1212,10 +1221,7 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>  		mhi_cntrl->rddm_image = NULL;
>  	}
>  
> -	mhi_cntrl->bhi = NULL;
> -	mhi_cntrl->bhie = NULL;
> -
> -	mhi_deinit_dev_ctxt(mhi_cntrl);
> +	__mhi_unprepare_keep_dev(mhi_cntrl);
>  }
>  EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>  
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index ce566f7d2e924..41b3fb835880b 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -427,4 +427,6 @@ void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
>  void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
>  			     struct mhi_buf_info *buf_info);
>  
> +void __mhi_unprepare_keep_dev(struct mhi_controller *mhi_cntrl);
> +
>  #endif /* _MHI_INT_H */
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index e6c3ff62bab1d..c2c09c308b9b7 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -1263,6 +1263,7 @@ void mhi_power_down_keep_dev(struct mhi_controller *mhi_cntrl,
>  			       bool graceful)
>  {
>  	__mhi_power_down(mhi_cntrl, graceful, false);
> +	__mhi_unprepare_keep_dev(mhi_cntrl);
>  }
>  EXPORT_SYMBOL_GPL(mhi_power_down_keep_dev);
>  
> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> index acd76e9392d31..c5dc776b23643 100644
> --- a/drivers/net/wireless/ath/ath11k/mhi.c
> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> @@ -460,12 +460,12 @@ void ath11k_mhi_stop(struct ath11k_pci *ab_pci, bool is_suspend)
>  	 * workaround, otherwise ath11k_core_resume() will timeout
>  	 * during resume.
>  	 */
> -	if (is_suspend)
> +	if (is_suspend) {
>  		mhi_power_down_keep_dev(ab_pci->mhi_ctrl, true);
> -	else
> +	} else {
>  		mhi_power_down(ab_pci->mhi_ctrl, true);
> -
> -	mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
> +		mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
> +	}
>  }
>  
>  int ath11k_mhi_suspend(struct ath11k_pci *ab_pci)
> diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
> index 08f44baf182a5..3af524ccf4a5a 100644
> --- a/drivers/net/wireless/ath/ath12k/mhi.c
> +++ b/drivers/net/wireless/ath/ath12k/mhi.c
> @@ -601,6 +601,12 @@ static int ath12k_mhi_set_state(struct ath12k_pci *ab_pci,
>  
>  	ath12k_mhi_set_state_bit(ab_pci, mhi_state);
>  
> +	/* mhi_power_down_keep_dev() has been updated to DEINIT without
> +	 * freeing bhie tables
> +	 */
> +	if (mhi_state == ATH12K_MHI_POWER_OFF_KEEP_DEV)
> +		ath12k_mhi_set_state_bit(ab_pci, ATH12K_MHI_DEINIT);
> +
>  	return 0;
>  
>  out:
> @@ -635,12 +641,12 @@ void ath12k_mhi_stop(struct ath12k_pci *ab_pci, bool is_suspend)
>  	 * workaround, otherwise ath12k_core_resume() will timeout
>  	 * during resume.
>  	 */
> -	if (is_suspend)
> +	if (is_suspend) {
>  		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF_KEEP_DEV);
> -	else
> +	} else {
>  		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF);
> -
> -	ath12k_mhi_set_state(ab_pci, ATH12K_MHI_DEINIT);
> +		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_DEINIT);
> +	}
>  }
>  
>  void ath12k_mhi_suspend(struct ath12k_pci *ab_pci)
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index dd372b0123a6d..6fd218a877855 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -306,6 +306,7 @@ struct mhi_controller_config {
>   *           if fw_image is NULL and fbc_download is true (optional)
>   * @fw_sz: Firmware image data size for normal booting, used only if fw_image
>   *         is NULL and fbc_download is true (optional)
> + * @prev_fw_sz: Previous firmware image data size, when fbc_download is true
>   * @edl_image: Firmware image name for emergency download mode (optional)
>   * @rddm_size: RAM dump size that host should allocate for debugging purpose
>   * @sbl_size: SBL image size downloaded through BHIe (optional)
> @@ -382,6 +383,7 @@ struct mhi_controller {
>  	const char *fw_image;
>  	const u8 *fw_data;
>  	size_t fw_sz;
> +	size_t prev_fw_sz;
>  	const char *edl_image;
>  	size_t rddm_size;
>  	size_t sbl_size;


-- 
Regards,
Usama

