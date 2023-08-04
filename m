Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55E876FA4A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 08:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjHDGld (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 02:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjHDGlJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 02:41:09 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF884697
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 23:41:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54290603887so971248a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 03 Aug 2023 23:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691131260; x=1691736060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTvrtGm9omTNndYE3JOrnTDMBnw5b0qfWu1gksrG4sA=;
        b=bi7VaxN6DhwhtQXB/TUpFTkTl/gRFZNdenaA1nos0nIyhzVvWqdrCXIf8JnqyCM+54
         zliSb7mshRlVtYLM3aNiPlxjGICBivz6AQG8HZzoD6qQJZY9QM1mhXmWtzXnze0RSSuo
         Q2U76NLVfTSFoeKq9o+l7B2HYlFJraukN68XFfwK63rAz4MqdHeGba4JPQqSNbyblkHt
         ibC0/HTZ/Zq/o4uoN+6bNaC8E2IoFXTAxcfrRxjm/hZS8nglIdQST/Ku1DCclKsiskNZ
         dPeqiDTYFI6AQ+YAGDCD9NpepafmJbljY0upahkUafdVxgsKPT5h2TiqaEYXOiKT1mey
         Rqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691131260; x=1691736060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTvrtGm9omTNndYE3JOrnTDMBnw5b0qfWu1gksrG4sA=;
        b=DtenvhWsFj1x2UEMth3o46cHTQb6PVIYWZUazz4cNZumj32NYdU/EZzIpuFKI1ewYo
         FWM2szUVqYvfbngxvfGOuXX2xhL/CwY43pUAdrqJW+lwjMQ1k5G2I13ywJr4JfxKq1vF
         7s3K767UkqFwywtV+fXRhYMaNCQJicEGpZDQNMt5yxFjuRJ06bjzR2Yj+LRfJB5Q04gN
         qlDMKfaGSmslk3AVW3mqmbZjECNE0h9vIV8avF0UGO3/4InwSDgbvMLgQ+hdIiY9kex5
         rh5mH8MOCxFLKid7CEAtoQYEKvUiQvBjUse3h6od3SSyJpKFRnQidEviNIGOUaf7tF/c
         pW4Q==
X-Gm-Message-State: AOJu0YwCHf/n1+HBHUoqzWdAjpjt4jvksDMVTR7GrjBPqC8TG8qnNmyZ
        DkaEDWxKVCa+oFP4SpdkhNxbiz9RMYEROP0mwA==
X-Google-Smtp-Source: AGHT+IHc+yUaZUEKBeCJBB+ETgv1hAlQDqN5i4J03Rw8pg812GZIs+szUUub60VQdRC6HXKVjM+SNQ==
X-Received: by 2002:a17:902:b70e:b0:1b8:a812:7bc2 with SMTP id d14-20020a170902b70e00b001b8a8127bc2mr745947pls.8.1691131260198;
        Thu, 03 Aug 2023 23:41:00 -0700 (PDT)
Received: from thinkpad ([103.28.246.156])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c3c300b001b9cf6342e2sm936473plj.42.2023.08.03.23.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 23:40:59 -0700 (PDT)
Date:   Fri, 4 Aug 2023 12:10:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     mhi@lists.linux.dev, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/3] bus: mhi: host: allow MHI client drivers to
 provide the firmware via a pointer
Message-ID: <20230804064056.GA24883@thinkpad>
References: <20230727100430.3603551-1-kvalo@kernel.org>
 <20230727100430.3603551-2-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230727100430.3603551-2-kvalo@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 27, 2023 at 01:04:28PM +0300, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Currently MHI loads the firmware image from the path provided by client
> devices. ath11k needs to support firmware image embedded along with meta data
> (named as firmware-2.bin). So allow the client driver to request the firmware
> file from user space on it's own and provide the firmware image data and size
> to MHI via a pointer struct mhi_controller::fw_data.
> 
> This is an optional feature, if fw_data is NULL MHI load the firmware using the
> name from struct mhi_controller::fw_image string as before.
> 
> Tested with ath11k and WCN6855 hw2.0.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/host/boot.c | 34 +++++++++++++++++++++++++---------
>  include/linux/mhi.h         |  6 ++++++
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index d2a19b07ccb8..edc0ec5a0933 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -365,12 +365,10 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
>  }
>  
>  static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
> -			      const struct firmware *firmware,
> +			      const u8 *buf, size_t remainder,
>  			      struct image_info *img_info)
>  {
> -	size_t remainder = firmware->size;
>  	size_t to_cpy;
> -	const u8 *buf = firmware->data;
>  	struct mhi_buf *mhi_buf = img_info->mhi_buf;
>  	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
>  
> @@ -393,9 +391,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	enum mhi_pm_state new_state;
>  	const char *fw_name;
> +	const u8 *fw_data;
>  	void *buf;
>  	dma_addr_t dma_addr;
> -	size_t size;
> +	size_t size, fw_sz;
>  	int i, ret;
>  
>  	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
> @@ -425,6 +424,20 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
>  		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
>  
> +	/* check if the driver has already provided the firmware data */
> +	if (!fw_name && mhi_cntrl->fbc_download &&
> +	    mhi_cntrl->fw_data && mhi_cntrl->fw_sz) {
> +		if (!mhi_cntrl->sbl_size) {
> +			dev_err(dev, "fw_data provided but no sbl_size\n");
> +			goto error_fw_load;
> +		}
> +
> +		size = mhi_cntrl->sbl_size;
> +		fw_data = mhi_cntrl->fw_data;
> +		fw_sz = mhi_cntrl->fw_sz;
> +		goto skip_req_fw;
> +	}
> +
>  	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
>  						     !mhi_cntrl->seg_len))) {
>  		dev_err(dev,
> @@ -444,6 +457,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	if (size > firmware->size)
>  		size = firmware->size;
>  
> +	fw_data = firmware->data;
> +	fw_sz = firmware->size;
> +
> +skip_req_fw:
>  	buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, size, &dma_addr,
>  				 GFP_KERNEL);
>  	if (!buf) {
> @@ -452,7 +469,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	}
>  
>  	/* Download image using BHI */
> -	memcpy(buf, firmware->data, size);
> +	memcpy(buf, fw_data, size);
>  	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
>  	dma_free_coherent(mhi_cntrl->cntrl_dev, size, buf, dma_addr);
>  
> @@ -464,7 +481,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	}
>  
>  	/* Wait for ready since EDL image was loaded */
> -	if (fw_name == mhi_cntrl->edl_image) {
> +	if (fw_name && fw_name == mhi_cntrl->edl_image) {
>  		release_firmware(firmware);
>  		goto fw_load_ready_state;
>  	}
> @@ -478,15 +495,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	 * device transitioning into MHI READY state
>  	 */
>  	if (mhi_cntrl->fbc_download) {
> -		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
> -					   firmware->size);
> +		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
>  		if (ret) {
>  			release_firmware(firmware);
>  			goto error_fw_load;
>  		}
>  
>  		/* Load the firmware into BHIE vec table */
> -		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
> +		mhi_firmware_copy(mhi_cntrl, fw_data, fw_sz, mhi_cntrl->fbc_image);
>  	}
>  
>  	release_firmware(firmware);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index f6de4b6ecfc7..039943ec4d4e 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -299,6 +299,10 @@ struct mhi_controller_config {
>   * @iova_start: IOMMU starting address for data (required)
>   * @iova_stop: IOMMU stop address for data (required)
>   * @fw_image: Firmware image name for normal booting (optional)
> + * @fw_data: Firmware image data content for normal booting, used only
> + *           if fw_image is NULL and fbc_download is true (optional)
> + * @fw_sz: Firmware image data size for normal booting, used only if fw_image
> + *         is NULL and fbc_download is true (optional)
>   * @edl_image: Firmware image name for emergency download mode (optional)
>   * @rddm_size: RAM dump size that host should allocate for debugging purpose
>   * @sbl_size: SBL image size downloaded through BHIe (optional)
> @@ -384,6 +388,8 @@ struct mhi_controller {
>  	dma_addr_t iova_start;
>  	dma_addr_t iova_stop;
>  	const char *fw_image;
> +	const u8 *fw_data;
> +	size_t fw_sz;
>  	const char *edl_image;
>  	size_t rddm_size;
>  	size_t sbl_size;
> -- 
> 2.39.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
