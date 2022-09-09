Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9585B3587
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 12:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIIKt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 06:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIIKtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 06:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B6C5A813
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 03:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E2D61E9B
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 10:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EDBC433C1;
        Fri,  9 Sep 2022 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662720525;
        bh=MPB2MpKsKoq0ff58+3zvmZDUBpn/GVOzh050VKZS92c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aatlCnTKqisWuIyWp3VO8EZI3cwpdvsljfxh8XUkODtY69DP0c+yqCiPqstnoAaDm
         FsqpOhi81DyqzDwfQ5TLfgtpyx7JE0ZDtF/Sxet9ZzysHpsNUjQoFN1CB1eyOr3kQn
         S8lVNO4L87iRchrZxP18YrdInGumzL+5EBEkxSyO9oS2bq28fOrvNtPInCPoBkFuNX
         K5wvK4nj0gOFZl86WtPVoO88gEdqO03P0mnCmn7WcPdPIzB77ouu5fm07HSKBhY5Sq
         muaXRMhidkDIdsWBOKBAhp9/RoSCtbulpW0G9OhYbj4LWJB2S2vMJUkUjFT1RrhwEb
         SVf2rLHf0WNOw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] wifi: ath11k: Implement sram dump interface
References: <20220802075533.1744-1-quic_bqiang@quicinc.com>
        <20220802075533.1744-3-quic_bqiang@quicinc.com>
Date:   Fri, 09 Sep 2022 13:48:41 +0300
In-Reply-To: <20220802075533.1744-3-quic_bqiang@quicinc.com> (Baochen Qiang's
        message of "Tue, 2 Aug 2022 15:55:33 +0800")
Message-ID: <87fsh0962e.fsf@kernel.org>
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

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Currently this feature is enabled for QCA6390/WCN6855.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

I did quite a few changes to this patch in the pending branch, please
check my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=074477aacb419493da6fb4d96fa9d12390c3b40e

I improved the commit log.

> --- a/drivers/net/wireless/ath/ath11k/hw.h
> +++ b/drivers/net/wireless/ath/ath11k/hw.h
> @@ -126,6 +126,11 @@ struct ath11k_hw_hal_params {
>  	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
>  };
>  
> +struct ath11k_hw_sram_dump {
> +	u32 start;
> +	u32 end;
> +};
> +
>  struct ath11k_hw_params {
>  	const char *name;
>  	u16 hw_rev;
> @@ -200,6 +205,7 @@ struct ath11k_hw_params {
>  	bool hybrid_bus_type;
>  	bool fixed_fw_mem;
>  	bool support_off_channel_tx;
> +	const struct ath11k_hw_sram_dump *sram_dump;
>  };

Instead of separate structures I used inline structures:

		.sram_dump = {
			.start = 0x01400000,
			.end = 0x0177ffff,
		},

> --- a/drivers/net/wireless/ath/ath11k/pcic.c
> +++ b/drivers/net/wireless/ath/ath11k/pcic.c
> @@ -203,6 +203,35 @@ u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
>  }
>  EXPORT_SYMBOL(ath11k_pcic_read32);
>  
> +int ath11k_pcic_dump_sram(struct ath11k_base *ab, u8 *buf,
> +			  u32 start, u32 end)
> +{
> +	int ret = 0;
> +	bool wakeup_required;
> +	u32 *data = (u32 *)buf;

I changed buf to a void pointer, then the cast is not needed.

> +	u32 i;
> +
> +	/* for offset beyond BAR + 4K - 32, may
> +	 * need to wakeup the device to access.
> +	 */
> +	wakeup_required = test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
> +			  end >= ATH11K_PCI_ACCESS_ALWAYS_OFF;
> +	if (wakeup_required && ab->pci.ops->wakeup) {
> +		ret = ab->pci.ops->wakeup(ab);
> +		if (ret)
> +			ath11k_warn(ab, "%s: failed to do wakeup: %d\n", __func__, ret);
> +	}

I changed the error handling so that if wakeup() fails we do not
continue and just return an error.

> +	for (i = start; i < end + 1; i += 4)
> +		*data++ = ath11k_pcic_do_read32(ab, i);
> +
> +	if (wakeup_required && !ret && ab->pci.ops->release)
> +		ab->pci.ops->release(ab);

At the same time I removed the ret check here.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ath11k_pcic_dump_sram);

I renamed this to ath11k_pcic_read() as I feel it's more descriptive
what the function really does. It's not really care is this for sram
dump or something else.

I also renamed hif.h interface to ath11k_hif_read().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
