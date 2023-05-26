Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1977125D1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 13:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbjEZLpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 07:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbjEZLpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 07:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF713A
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 04:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C793A64E66
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 11:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C26C433D2;
        Fri, 26 May 2023 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685101552;
        bh=eLGJ7IUKjlVRda4uTh5jj6HszvyHA1EtoDaEo1TBUT4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=B4bAuXbcCvaIzLkzZQHPFE5nQ32iRUqyjxg6VV4VD74T6COWaqc+F7EopDlzf7N1+
         JYTNYorTUEP1e4sZpp0R9NcusdUccU3BrbrgKevmYv4XjLpVOJcq7p2azOaPLw6vWn
         Qi7UKHuybpvfm/gpZVBdQzlF+laTVV5JnwE38d/M3bBVQXo25uFquoateGbGcUDJ/e
         cU7UosRGX6Zjw37BA1FX5fsYQEbcP1O0nzgJiH558sP2EWCLfuGkL8CiKLPOJxIz8n
         CXToDlUZNuhaaQB+33HVJyE5JyuMSSiDnoMuPEZT+UE7qXPGL+voH6cDpmoyHM7Xr8
         9pFPHYHzdJrQg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mhi: allow MHI client drivers to provide the firmware via a pointer
References: <20230308152522.6728-1-kvalo@kernel.org>
        <20230308152522.6728-2-kvalo@kernel.org>
        <20230315081820.GD25575@thinkpad>
Date:   Fri, 26 May 2023 14:45:46 +0300
In-Reply-To: <20230315081820.GD25575@thinkpad> (Manivannan Sadhasivam's
        message of "Wed, 15 Mar 2023 13:48:20 +0530")
Message-ID: <87353jl3it.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Wed, Mar 08, 2023 at 05:25:20PM +0200, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>
> Subject prefix should be: "bus: mhi: host: ..."

Will do.

>> @@ -392,9 +390,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>>  	const struct firmware *firmware = NULL;
>>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>  	const char *fw_name;
>> +	const u8 *fw_data;
>>  	void *buf;
>>  	dma_addr_t dma_addr;
>> -	size_t size;
>> +	size_t size, fw_sz;
>>  	int i, ret;
>>  
>>  	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
>> @@ -424,6 +423,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>>  	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
>>  		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
>>  
>
> Can you please add a comment here?

Ok.

>
>> +	if (!fw_name && mhi_cntrl->fbc_download &&
>> +	    mhi_cntrl->fw_data && mhi_cntrl->fw_sz) {
>> +		size = mhi_cntrl->sbl_size;
>
> Don't you need to validate sbl_size?

Good point, I'll add that.

>> --- a/include/linux/mhi.h
>> +++ b/include/linux/mhi.h
>> @@ -299,6 +299,10 @@ struct mhi_controller_config {
>>   * @iova_start: IOMMU starting address for data (required)
>>   * @iova_stop: IOMMU stop address for data (required)
>>   * @fw_image: Firmware image name for normal booting (optional)
>> + * @fw_data: Firmware image data content for normal booting, used only
>> + *           if fw_image is NULL (optional)
>> + * @fw_sz: Firmware image data size for normal booting, used only if fw_image
>> + *         is NULL and fbc_download is true (optional)
>>   * @edl_image: Firmware image name for emergency download mode (optional)
>>   * @rddm_size: RAM dump size that host should allocate for debugging purpose
>>   * @sbl_size: SBL image size downloaded through BHIe (optional)
>> @@ -384,6 +388,8 @@ struct mhi_controller {
>>  	dma_addr_t iova_start;
>>  	dma_addr_t iova_stop;
>>  	const char *fw_image;
>> +	const u8 *fw_data;
>> +	size_t fw_sz;
>
> Even though these members are not creating holes now, shuffling the datatypes
> will create holes in the future. So I always prefer to keep the struct members
> sorted in the below order:
>
> pointer
> struct/union
> u64
> u32
> u16
> u8
> bool

I'm not sure what are suggesting here as struct mhi_controller is not
using that style. Are you saying that fw_sz should be after reg_len? So
something like this:

	const u8 *fw_data;
	const char *edl_image;
	size_t rddm_size;
	size_t sbl_size;
	size_t seg_len;
	size_t reg_len;
	size_t fw_sz;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
