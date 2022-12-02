Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E097640E6B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 20:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiLBT0c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 14:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiLBT02 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 14:26:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11547F28B8
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 11:26:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6BEFB8226D
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 19:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F166C433D6;
        Fri,  2 Dec 2022 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670009184;
        bh=qgX1Ko+B7pKop1NmYhmLmS061eR4kJM7i1u5DkK9TQU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=uKPrkZeAJHo9wMaHJaoiO7+j0mHDu9PZj9mueHlSZAlgbGRt6r18A4q7cMmTjUWoF
         ZhDsiFuyrD0f63mxengm21rjxhX071JDi2G3v1ydAAtwE54c+DaYRnjGC+3uzU1D64
         p2vD44Rwnrb+Ft96DBqAja9RGP+NnrhSqDbTiaGJF+c8F5moiMUkTFnb5gLZhM3Q3L
         /UxApYE5wKaHJ+stLddO6Gfr0Iy+rv0PIf04AKroZRAqT7XC0mtOjmJD+CnyfXxlIR
         JpAGLLDUaCoVzf+qmGfJZ2fMspBaItUCayUOz7xqbsi1I4NYtQo067InenUexB0XND
         +zi1QASq2JoaQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: Re: [PATCHv2 2/8] wifi: ath11k: update hw params for IPQ5018
References: <20221122132152.17771-1-quic_kathirve@quicinc.com>
        <20221122132152.17771-3-quic_kathirve@quicinc.com>
Date:   Fri, 02 Dec 2022 21:26:21 +0200
In-Reply-To: <20221122132152.17771-3-quic_kathirve@quicinc.com> (Karthikeyan
        Kathirvel's message of "Tue, 22 Nov 2022 18:51:46 +0530")
Message-ID: <87k03938v6.fsf@kernel.org>
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

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:

> From: Sriram R <quic_srirrama@quicinc.com>
>
> Add new compatible string for IPQ5018 and add
> required hw params for IPQ5018. The hw descriptors size and
> datapath ops are similar to QCN9074, hence reuse the same.
>
> Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 70 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h |  8 +++
>  2 files changed, 78 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index edf78df9b12f..d2af175a3d93 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -604,6 +604,76 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.smp2p_wow_exit = true,
>  		.support_fw_mac_sequence = true,
>  	},
> +	{
> +		.hw_rev = ATH11K_HW_IPQ5018_HW10,
> +		.name = "ipq5018 hw1.0",
> +		.fw = {
> +			.dir = "IPQ5018/hw1.0",
> +			.board_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
> +		},
> +		.max_radios = MAX_RADIOS_5018,
> +		.bdf_addr = 0x4BA00000,
> +		/* hal_desc_sz and hw ops are similar to qcn9074 */
> +		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
> +		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074,
> +		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
> +		.credit_flow = false,
> +		.max_tx_ring = 1,
> +		.spectral = {
> +			.fft_sz = 2,
> +			.fft_pad_sz = 0,
> +			.summary_pad_sz = 16,
> +			.fft_hdr_len = 24,
> +			.max_fft_bins = 1024,
> +		},
> +		.internal_sleep_clock = false,
> +		.host_ce_config = ath11k_host_ce_config_qcn9074,
> +		.ce_count = CE_CNT_5018,
> +		.rxdma1_enable = true,
> +		.num_rxmda_per_pdev = RXDMA_PER_PDEV_5018,
> +		.rx_mac_buf_ring = false,
> +		.vdev_start_delay = false,
> +		.htt_peer_map_v2 = true,
> +		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
> +			BIT(NL80211_IFTYPE_AP) |
> +			BIT(NL80211_IFTYPE_MESH_POINT),
> +		.supports_monitor = false,
> +		.supports_sta_ps = false,
> +		.supports_shadow_regs = false,
> +		.fw_mem_mode = 0,
> +		.num_vdevs = 16 + 1,
> +		.num_peers = 512,
> +		.supports_regdb = false,
> +		.idle_ps = false,
> +		.supports_suspend = false,
> +		.hal_params = &ath11k_hw_hal_params_ipq8074,
> +		.single_pdev_only = false,
> +		.cold_boot_calib = true,
> +		.fix_l1ss = true,
> +		.supports_dynamic_smps_6ghz = false,
> +		.alloc_cacheable_memory = true,
> +		.supports_rssi_stats = false,
> +		.fw_wmi_diag_event = false,
> +		.current_cc_support = false,
> +		.dbr_debug_support = true,
> +		.global_reset = false,
> +		.bios_sar_capa = NULL,
> +		.m3_fw_support = false,
> +		.fixed_bdf_addr = true,
> +		.fixed_mem_region = true,
> +		.static_window_map = false,
> +		.hybrid_bus_type = false,
> +		.fixed_fw_mem = false,
> +		.support_off_channel_tx = false,
> +		.supports_multi_bssid = false,
> +
> +		.sram_dump = {},
> +
> +		.tcl_ring_retry = true,
> +		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
> +		.smp2p_wow_exit = false,
> +	},

support_fw_mac_sequence was missing so in the pending branch I added
that:

--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -673,6 +673,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
                .tcl_ring_retry = true,
                .tx_ring_size = DP_TCL_DATA_RING_SIZE,
                .smp2p_wow_exit = false,
+               .support_fw_mac_sequence = false,
        },
 };


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
