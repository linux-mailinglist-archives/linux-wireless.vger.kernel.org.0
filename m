Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E96666E2A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbjALJ2T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 04:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbjALJ1W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 04:27:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46159BB2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 01:19:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D93E561F7D
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 09:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53958C433F0;
        Thu, 12 Jan 2023 09:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673515164;
        bh=HYOhnv+T+iftwKLs538Ljw0Pj6fCRNz21LxLxNvbQcA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LoHoi02IfYVHDYDXF2YLK3ow7L3x8tp5xd96iP74uYzMabaZ98minm6khDeaVXUeH
         NkACXi0UMzJYufaMN6vK8po4PEsPgUsggd9C+y1IQy7J911Mm5J+VtFUjRrHHyZCKG
         Kad+uqgcNT/gZ/blvigyro3qf7C7Lg1buT4DAIkwrwyZuEJR3CQUhQUMUO6ZtabW7O
         YG+PUsFfUfYq4bZhTERISpr1FtaRjl1TjPjJr+AWG9pGE3lGmLPG08+Da44n/Qi9Dn
         BRNrOJoQ2wVXbh6Ffsk6D2MOPK2G3N3jdoHX2whipZCgYR9sA3/uHDMTUQLBXDlS27
         Lmpl8TIBuUx6A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     <mhi@lists.linux.dev>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] mhi: allow MHI client drivers to provide the firmware via a pointer
References: <20230111092547.21425-1-kvalo@kernel.org>
        <20230111092547.21425-2-kvalo@kernel.org>
        <7d692402-3fc1-3b4c-9697-25e722e94539@quicinc.com>
Date:   Thu, 12 Jan 2023 11:19:21 +0200
In-Reply-To: <7d692402-3fc1-3b4c-9697-25e722e94539@quicinc.com> (Jeffrey
        Hugo's message of "Wed, 11 Jan 2023 08:20:34 -0700")
Message-ID: <87bkn4ds9y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeffrey Hugo <quic_jhugo@quicinc.com> writes:

> On 1/11/2023 2:25 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> Currently MHI loads the firmware image from the path provided by client
>> devices. ath11k needs to support firmware image embedded along with meta data
>> (named as firmware-2.bin). So allow the client driver to request the firmware
>> file from user space on it's own and provide the firmware image data and size
>> to MHI via a pointer struct mhi_controller::fw_data.
>>
>> This is an optional feature, if fw_data is NULL MHI load the firmware using the
>> name from struct mhi_controller::fw_image string as before.
>>
>> Tested with ath11k and WCN6855 hw2.0.
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

>> @@ -478,14 +489,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>>   	 */
>>   	if (mhi_cntrl->fbc_download) {
>>   		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
>> -					   firmware->size);
>> +					   fw_sz);
>
> Minor nit, but it seems like this could be all on one line.

Will fix in v2.

>> --- a/include/linux/mhi.h
>> +++ b/include/linux/mhi.h
>> @@ -299,6 +299,10 @@ struct mhi_controller_config {
>>    * @iova_start: IOMMU starting address for data (required)
>>    * @iova_stop: IOMMU stop address for data (required)
>>    * @fw_image: Firmware image name for normal booting (optional)
>> + * @fw_data: Firmware image data content for normal booting, used only
>> + *           if fw_image is NULL (optional)
>
> The implementation requires fbc_download to be set, which is not a
> requirement for fw_image.  That is not apparent here.

Ah, I had missed that. Will mention that in v2.

>> @@ -384,6 +388,8 @@ struct mhi_controller {
>>   	dma_addr_t iova_start;
>>   	dma_addr_t iova_stop;
>>   	const char *fw_image;
>> +	const u8 *fw_data;
>> +	size_t fw_sz;
>
> Did you run pahole?  I remember this struct being well packed, and I
> think this will add a compiler hole but I have not actually verified.

I actually haven't used pahole for ages. I will run it and check how
this structure is packed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
