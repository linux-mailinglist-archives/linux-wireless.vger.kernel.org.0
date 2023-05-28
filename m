Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793A5713A3C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 May 2023 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjE1O52 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 May 2023 10:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1O51 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 May 2023 10:57:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F79B
        for <linux-wireless@vger.kernel.org>; Sun, 28 May 2023 07:57:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b039168ba0so4577765ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 28 May 2023 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685285845; x=1687877845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bg4yP6JQUstw/bz5fFj0XL84ZF9tW/DTkJgQGvQnFs8=;
        b=dIWuteu9Fhf3vaicbIowU+wrrOTZL/zRcMlF/jKSKQNochrLf3vP78/5cUEgmYfa8V
         G3YQjMGayZchpuC2i+weXCmjd1RcuBm1hVZa8L5S97r06XjLz/3aSCFuoATNalUGLa43
         6bgdIu6NRfZb/yxZ1JsEJyCwnXGyro+aC2KcgO4kVib1Ps+hAzNSVJYXbYTN5bNjFQ3f
         Ys9V5oecLhPOuMBPLNaRbrk3cbkJbvSjmFavV67us8z+mwQdnzWhUhOaxBjJ/BxlGnPX
         z9ji/dXt9P9NN2mVrZpHBfjQWruESvQi4WpGJL/oH785dwK1AtDdyt5RevFUC9Ce+ZqN
         TtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685285845; x=1687877845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg4yP6JQUstw/bz5fFj0XL84ZF9tW/DTkJgQGvQnFs8=;
        b=aqUdgORTKBqV8nWrjtfF4rITuKBizMFp5ZpIu7jVhHbveJ6urE+6vl8fAWCmxEIUKW
         PFNBxW2gZ3pYJcd+xp8OUNn47HFqTsi5+6Z1lq5RpfR/xqt1QRBG04TH+F6ap5DzC5cU
         BRHLX2HvjTp4KfgeCOPeNahmxdk3LzpnHinJKo1JVgHGTA3CODPgQrkrIaaDcijOlGWt
         +dY/+mGEcq2b19fgFC1ymo6g9JzpPEEIjrXkWM0U4igLzKKiGobH+OQHCSYRDtEE9sDE
         d1DMi7jCe9bhvtz95awiA7+StBQ0uo6D5g+s2g5vOuz16ejIw5loTcRTob4buW7IIJbq
         Mhjw==
X-Gm-Message-State: AC+VfDyDEhhp/TO6uckhOhfHSfdNPXoCrHkMkVIvu4Wzquqg2jhqiTWW
        yV6lqgZC5gHCl7Fsm4lGbui1
X-Google-Smtp-Source: ACHHUZ6yrBb/7PjUZzsTRpSciXH9EHy45Kbam/bdUmU0L6LbzwZ1LEy+e8SNaqJrDSUo8RFhrjF78w==
X-Received: by 2002:a17:902:a50d:b0:1a2:6257:36b9 with SMTP id s13-20020a170902a50d00b001a2625736b9mr7729161plq.31.1685285845626;
        Sun, 28 May 2023 07:57:25 -0700 (PDT)
Received: from thinkpad ([117.248.1.157])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001ae59169f05sm6406643plg.182.2023.05.28.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:57:25 -0700 (PDT)
Date:   Sun, 28 May 2023 20:27:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     mhi@lists.linux.dev, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mhi: allow MHI client drivers to provide the
 firmware via a pointer
Message-ID: <20230528145721.GE2814@thinkpad>
References: <20230308152522.6728-1-kvalo@kernel.org>
 <20230308152522.6728-2-kvalo@kernel.org>
 <20230315081820.GD25575@thinkpad>
 <87353jl3it.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87353jl3it.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 26, 2023 at 02:45:46PM +0300, Kalle Valo wrote:
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > On Wed, Mar 08, 2023 at 05:25:20PM +0200, Kalle Valo wrote:
> >> From: Kalle Valo <quic_kvalo@quicinc.com>
> >> 
> >
> > Subject prefix should be: "bus: mhi: host: ..."
> 
> Will do.
> 
> >> @@ -392,9 +390,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
> >>  	const struct firmware *firmware = NULL;
> >>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> >>  	const char *fw_name;
> >> +	const u8 *fw_data;
> >>  	void *buf;
> >>  	dma_addr_t dma_addr;
> >> -	size_t size;
> >> +	size_t size, fw_sz;
> >>  	int i, ret;
> >>  
> >>  	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
> >> @@ -424,6 +423,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
> >>  	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
> >>  		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
> >>  
> >
> > Can you please add a comment here?
> 
> Ok.
> 
> >
> >> +	if (!fw_name && mhi_cntrl->fbc_download &&
> >> +	    mhi_cntrl->fw_data && mhi_cntrl->fw_sz) {
> >> +		size = mhi_cntrl->sbl_size;
> >
> > Don't you need to validate sbl_size?
> 
> Good point, I'll add that.
> 
> >> --- a/include/linux/mhi.h
> >> +++ b/include/linux/mhi.h
> >> @@ -299,6 +299,10 @@ struct mhi_controller_config {
> >>   * @iova_start: IOMMU starting address for data (required)
> >>   * @iova_stop: IOMMU stop address for data (required)
> >>   * @fw_image: Firmware image name for normal booting (optional)
> >> + * @fw_data: Firmware image data content for normal booting, used only
> >> + *           if fw_image is NULL (optional)
> >> + * @fw_sz: Firmware image data size for normal booting, used only if fw_image
> >> + *         is NULL and fbc_download is true (optional)
> >>   * @edl_image: Firmware image name for emergency download mode (optional)
> >>   * @rddm_size: RAM dump size that host should allocate for debugging purpose
> >>   * @sbl_size: SBL image size downloaded through BHIe (optional)
> >> @@ -384,6 +388,8 @@ struct mhi_controller {
> >>  	dma_addr_t iova_start;
> >>  	dma_addr_t iova_stop;
> >>  	const char *fw_image;
> >> +	const u8 *fw_data;
> >> +	size_t fw_sz;
> >
> > Even though these members are not creating holes now, shuffling the datatypes
> > will create holes in the future. So I always prefer to keep the struct members
> > sorted in the below order:
> >
> > pointer
> > struct/union
> > u64
> > u32
> > u16
> > u8
> > bool
> 
> I'm not sure what are suggesting here as struct mhi_controller is not
> using that style. Are you saying that fw_sz should be after reg_len? So
> something like this:
> 
> 	const u8 *fw_data;
> 	const char *edl_image;
> 	size_t rddm_size;
> 	size_t sbl_size;
> 	size_t seg_len;
> 	size_t reg_len;
> 	size_t fw_sz;
> 

Ah, I thought I already sorted them up but apparently not. Keep it as it is,
I'll sort this and other structs later.

- Mani

> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

-- 
மணிவண்ணன் சதாசிவம்
