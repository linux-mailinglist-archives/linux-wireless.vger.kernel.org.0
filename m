Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9390511738
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 14:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiD0M3G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiD0M2s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 08:28:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90F13D1B;
        Wed, 27 Apr 2022 05:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC214B824E7;
        Wed, 27 Apr 2022 12:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B406C385A9;
        Wed, 27 Apr 2022 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651062334;
        bh=viH9HrpEjudlC+s+Gw6A65xi/FPxOC8IPbCj+JuLc8Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hGN7T5T66vDe8+HYglSqO0dSYsKgdEbfnNwn0Wf31bKf4Nu5GhCWwV0tvc2xYAcEF
         OekDCKMKPs9HUm9beFh82Mo6bKXHYijjSPta5ygf3f2U7nRusfW/Ua+w0ZPlWNWzuE
         AhM1/MSaZz8aIG1ij8Ob2FrUDTBFeOdJOMS8pvo/kSqyWmAqEeH18o3ccD3b5iXo4w
         8v4U0+80IHJ9DwOIQvxn7YgTNetL6nrktxCivk5V6TVdD4CyGTlfh+XCT6hDRQv0/z
         dQp/WhYnNFMlkl1V5+S3/JN+ZOzrjI6qbOmlnp/dET6dl/0GfEMlqfkm5++m3E8uVX
         +Sj+3mI82nwWw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
Subject: Re: [PATCH v6 4/9] ath11k: Add register access logic for WCN6750
References: <20220427111848.9257-1-quic_mpubbise@quicinc.com>
        <20220427111848.9257-5-quic_mpubbise@quicinc.com>
Date:   Wed, 27 Apr 2022 15:25:28 +0300
In-Reply-To: <20220427111848.9257-5-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 27 Apr 2022 16:48:43 +0530")
Message-ID: <87pml2g1c7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

> WCN6750 uses static window mapping to access the HW registers.
> Unlike QCN9074 which uses 2nd window for CE and 3rd window
> for UMAC register accesses, WCN6750 uses 1st window for UMAC
> and 2nd window for CE registers.
>
> Code is refactored so that WCN6750 can use the existing
> ath11k_pci_read/write() APIs for accessing the registers.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c  |  6 +++
>  drivers/net/wireless/ath/ath11k/core.h |  2 +
>  drivers/net/wireless/ath/ath11k/pci.c  | 34 ++++++++++++++--
>  drivers/net/wireless/ath/ath11k/pcic.c | 54 +++++++++-----------------
>  4 files changed, 58 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index cfdd415f0203..fa12e50f32f4 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -34,7 +34,10 @@ static const struct ath11k_bus_params ath11k_ahb_bus_params = {
>  	.m3_fw_support = false,
>  	.fixed_bdf_addr = true,
>  	.fixed_mem_region = true,
> +	.static_window_map = false,
>  	.hybrid_bus_type = false,
> +	.dp_window_idx = 0,
> +	.ce_window_idx = 0,
>  };
>  
>  const struct ath11k_bus_params ath11k_ahb_hybrid_bus_params = {
> @@ -42,7 +45,10 @@ const struct ath11k_bus_params ath11k_ahb_hybrid_bus_params = {
>  	.m3_fw_support = false,
>  	.fixed_bdf_addr = false,
>  	.fixed_mem_region = false,
> +	.static_window_map = true,
>  	.hybrid_bus_type = true,
> +	.dp_window_idx = 1,
> +	.ce_window_idx = 2,
>  };
>  
>  #define ATH11K_IRQ_CE0_OFFSET 4
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 51f313dd7f26..ee0ad93d5843 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -756,6 +756,8 @@ struct ath11k_bus_params {
>  	bool fixed_mem_region;
>  	bool static_window_map;
>  	bool hybrid_bus_type;
> +	u8 dp_window_idx;
> +	u8 ce_window_idx;
>  };
>  
>  struct ath11k_pci_ops {
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index ddd1e2de6a2e..9184cb893bd4 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -115,12 +115,26 @@ static const struct ath11k_pci_ops ath11k_pci_ops_qcn9074 = {
>  	.window_read32 = ath11k_pci_window_read32,
>  };
>  
> -static const struct ath11k_bus_params ath11k_pci_bus_params = {
> +static const struct ath11k_bus_params ath11k_pci_bus_params_qca6390 = {
>  	.mhi_support = true,
>  	.m3_fw_support = true,
>  	.fixed_bdf_addr = false,
>  	.fixed_mem_region = false,
> +	.static_window_map = false,
>  	.hybrid_bus_type = false,
> +	.dp_window_idx = 0,
> +	.ce_window_idx = 0,
> +};
> +
> +static const struct ath11k_bus_params ath11k_pci_bus_params_qcn9074 = {
> +	.mhi_support = true,
> +	.m3_fw_support = true,
> +	.fixed_bdf_addr = false,
> +	.fixed_mem_region = false,
> +	.static_window_map = true,
> +	.hybrid_bus_type = false,
> +	.dp_window_idx = 3,
> +	.ce_window_idx = 2,
>  };
>  
>  static const struct ath11k_msi_config msi_config_one_msi = {
> @@ -704,11 +718,26 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>  {
>  	struct ath11k_base *ab;
>  	struct ath11k_pci *ab_pci;
> +	const struct ath11k_bus_params *bus_params;
>  	u32 soc_hw_version_major, soc_hw_version_minor, addr;
>  	int ret;
>  
> +	switch (pci_dev->device) {
> +	case QCA6390_DEVICE_ID:
> +	case WCN6855_DEVICE_ID:
> +		bus_params = &ath11k_pci_bus_params_qca6390;
> +		break;
> +	case QCN9074_DEVICE_ID:
> +		bus_params = &ath11k_pci_bus_params_qcn9074;
> +		break;

Now you are making bus_params device specific, that's not really the
point of bus params. They are supposed to be _bus_ specific parameters.

Can't you use hw_params like I mentioned in the review?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
