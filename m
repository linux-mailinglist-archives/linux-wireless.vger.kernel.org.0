Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644751107B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 07:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357846AbiD0FZS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355695AbiD0FZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4461219026;
        Tue, 26 Apr 2022 22:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D430E612CF;
        Wed, 27 Apr 2022 05:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3460C385A7;
        Wed, 27 Apr 2022 05:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651036924;
        bh=Jf5bAmd395nAILviWn9V78VFyFC1FDEPpRKFtHfRsjw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TNSbSG5obLOcS+gl5pUIRWib5g2Glq9xlsiH5s6rtMEYYFo2OF2FE6JX4tr6tfI2X
         JMGTbyfrOYaGi56ve7uixV1hIjsfjINJik72QSsQCIRf6DVJKH8g0DVQz8VkFgWAPU
         h2mh3hpICGqRgW3REtvcegPxirRU0ZekeLICy7RI2yr38R9qJKsVaanf/jsvgmIF7Q
         FeOXyZX5eHTFCpFPXOVzITK4OBq7T/wb+Y35fy913jY+NmiWN3J7ritr7vCh/njtxE
         aFqrnC8WOUA/CUaDbrGbzpqs8+tKkx1r5uu/gizpIW6fXUQt3sYWVAeW28PYsjWUl9
         C0PmB4uqSP0Gg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
Subject: Re: [PATCH v4 02/12] ath11k: Add HW params for WCN6750
References: <20220406094107.17878-1-quic_mpubbise@quicinc.com>
        <20220406094107.17878-3-quic_mpubbise@quicinc.com>
Date:   Wed, 27 Apr 2022 08:21:56 +0300
In-Reply-To: <20220406094107.17878-3-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 6 Apr 2022 15:10:56 +0530")
Message-ID: <87k0bbhzij.fsf@kernel.org>
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

> Add HW params for WCN6750. It is similar to the HW params
> of QCA6390 with few differences wrt DP APIs and register
> offsets.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 61 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h |  1 +
>  drivers/net/wireless/ath/ath11k/qmi.h  |  2 +
>  3 files changed, 64 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index cbac1919867f..8695f999acb2 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -427,6 +427,67 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.dbr_debug_support = false,
>  		.global_reset = true,
>  	},
> +	{
> +		.name = "wcn6750 hw1.0",
> +		.hw_rev = ATH11K_HW_WCN6750_HW10,
> +		.fw = {
> +			.dir = "WCN6750/hw1.0",
> +			.board_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
> +		},
> +		.max_radios = 1,
> +		.bdf_addr = 0x4B0C0000,
> +		.ring_mask = &ath11k_hw_ring_mask_qca6390,
> +		.internal_sleep_clock = false,
> +		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_WCN6750,
> +		.host_ce_config = ath11k_host_ce_config_qca6390,
> +		.ce_count = 9,
> +		.target_ce_config = ath11k_target_ce_config_wlan_qca6390,
> +		.target_ce_count = 9,
> +		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
> +		.svc_to_ce_map_len = 14,
> +		.rfkill_pin = 0,
> +		.rfkill_cfg = 0,
> +		.rfkill_on_level = 0,
> +		.single_pdev_only = true,
> +		.rxdma1_enable = false,
> +		.num_rxmda_per_pdev = 1,
> +		.rx_mac_buf_ring = true,
> +		.vdev_start_delay = true,
> +		.htt_peer_map_v2 = false,
> +
> +		.spectral = {
> +			.fft_sz = 0,
> +			.fft_pad_sz = 0,
> +			.summary_pad_sz = 0,
> +			.fft_hdr_len = 0,
> +			.max_fft_bins = 0,
> +		},
> +
> +		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
> +					BIT(NL80211_IFTYPE_AP),
> +		.supports_monitor = false,
> +		.supports_shadow_regs = true,
> +		.idle_ps = true,
> +		.supports_sta_ps = true,
> +		.cold_boot_calib = false,
> +		.fw_mem_mode = 0,
> +		.num_vdevs = 16 + 1,
> +		.num_peers = 512,
> +		.supports_suspend = false,
> +		.supports_regdb = true,
> +		.fix_l1ss = false,
> +		.credit_flow = true,
> +		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
> +		.hal_params = &ath11k_hw_hal_params_qca6390,
> +		.supports_dynamic_smps_6ghz = false,
> +		.alloc_cacheable_memory = false,
> +		.supports_rssi_stats = true,
> +		.fw_wmi_diag_event = false,
> +		.current_cc_support = true,
> +		.dbr_debug_support = false,
> +		.global_reset = false,
> +	},

In the pending branch I added:

+               .bios_sar_capa = NULL,

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
