Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC1575EEF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jul 2022 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiGOKEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jul 2022 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiGOKEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jul 2022 06:04:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0721E1C
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jul 2022 03:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3101B82B5F
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jul 2022 10:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5D7C34115;
        Fri, 15 Jul 2022 10:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657879443;
        bh=ZcDZyE0COk55jsJHm1e18Qr2sZ94ugA8Z9fnKkbfzsg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VBE+2Q4Ax916BllcbFpJK/x+6PV6ZTYeNUWD1zYgWrptTQYNZvsocuh0iPA3+Tptu
         dObhP6wOsDmjgsRKFWEVd1rl3joo4wSlGF3XBLQB/+zFr2QCl/MPj7dBkILQAVGEX0
         oTKFOR4KDs5gwM9vi0BNHV5p4Fua5MUTLluMeTh1hzJH20VKCjb/xitzLCYm+hNYlD
         QujpIoCUqrNTaH6bMyuyKjlzQqxCbXr1SjbS+ES6Bm68lzn1ylYxeJveUf/78GXOaJ
         U1YIznhhBb31zbEQ8mkL3kGjEZ+g9cZ+IEGzwoZnxa/KQFyLNo0YUkTlqPGOFWKaOe
         9XZ7a8skW7Awg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH] ath11k: Fix register write failure on QCN9074
In-Reply-To: <20220608062954.27792-1-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 8 Jun 2022 11:59:54 +0530")
References: <20220608062954.27792-1-quic_mpubbise@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 15 Jul 2022 13:03:59 +0300
Message-ID: <87wncesne8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Commit 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
> regressed QCN9074. With the above mentioned commit, writes are failing
> for some registers on QCN9074 although the device seems to work
> normally.
>
> ath11k_pci 0000:03:00.0: failed to set pcie link register0x01e0e0a8: 0xffffffff != 0x00000010
> ath11k_pci 0000:03:00.0: failed to set sysclk: -110
>
> PCIe devices in ath11k (QCA6390, WCN6855, QCN9074, WCN6750) use window
> concept for register accesses. There are two schemes, dynamic & static
> window.
>
> In dynamic window scheme, a single window(region in the BAR) is mapped
> either to CE or DP register windows at any give time. QCA6390 & WCN6855
> follow this scheme for register accesses.
>
> In static window scheme, CE & DP register windows are statically mapped
> to separate regions with in the BAR so that there is no switching of
> register windows between CE & DP register accesses. QCN9074 & WCN6750
> follow this scheme although the window start offsets are different for
> QCN9074 & WCN6750.
>
> QCN9074 uses 3rd & 2nd window for DP & CE register accesses respectively
> whereas WCN6750 uses 1st & 2nd window for DP & CE. In QCN9074, along with
> 2nd & 3rd windows, 1st window is also used for certain configurations
> which commit 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
> did not account for and hence the regression.
>
> Fix this by going back to the original way of accessing the registers on
> QCN9074. Since this diverges from WCN6750 way of accessing registers, it
> is required to register window_read32/window_write32() pci_ops for WCN6750.
> We can also get rid of dp_window_idx & ce_window_idx members in hw_params,
> so remove them.
>
> Also add a new API ath11k_pcic_register_pci_ops() for registering pci_ops
> to the ath11k core. This API checks for mandatory pci_ops() and reports
> error if those are missing. Also initialize unused pci_ops to NULL.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
>
> Fixes: 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
> Reported-by: Maxime Bizon <mbizon@freebox.fr>
> Tested-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -50,6 +50,23 @@ static void ath11k_pci_bus_release(struct ath11k_base *ab)
>  	mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
>  }
>  
> +static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab, u32 offset)
> +{
> +	u32 window_start;
> +
> +	/* If offset lies within DP register range, use 3rd window */
> +	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
> +		window_start = 3 * ATH11K_PCI_WINDOW_START;
> +	/* If offset lies within CE register range, use 2nd window */
> +	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
> +		 ATH11K_PCI_WINDOW_RANGE_MASK)
> +		window_start = 2 * ATH11K_PCI_WINDOW_START;
> +	else
> +		window_start = ATH11K_PCI_WINDOW_START;
> +
> +	return window_start;
> +}
> +
>  static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
>  {
>  	struct ath11k_base *ab = ab_pci->ab;
> @@ -70,13 +87,23 @@ static void
>  ath11k_pci_window_write32(struct ath11k_base *ab, u32 offset, u32 value)
>  {
>  	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
> -	u32 window_start = ATH11K_PCI_WINDOW_START;
> +	u32 window_start;
>  
> -	spin_lock_bh(&ab_pci->window_lock);
> -	ath11k_pci_select_window(ab_pci, offset);
> -	iowrite32(value, ab->mem + window_start +
> -		  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
> -	spin_unlock_bh(&ab_pci->window_lock);
> +	if (ab->hw_params.static_window_map)
> +		window_start = ath11k_pci_get_window_start(ab, offset);
> +	else
> +		window_start = ATH11K_PCI_WINDOW_START;
> +
> +	if (window_start == ATH11K_PCI_WINDOW_START) {
> +		spin_lock_bh(&ab_pci->window_lock);
> +		ath11k_pci_select_window(ab_pci, offset);
> +		iowrite32(value, ab->mem + window_start +
> +			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
> +		spin_unlock_bh(&ab_pci->window_lock);
> +	} else {
> +		iowrite32(value, ab->mem + window_start +
> +			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
> +	}
>  }

I refactored ath11k_pci_get_window_start() a bit, please check my
changes here:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=95094045d7f467aa8928307ea538d1fd9d15a239

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
