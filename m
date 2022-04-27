Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49904511094
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 07:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357886AbiD0FiW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbiD0FiW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:38:22 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF05632D;
        Tue, 26 Apr 2022 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651037711; x=1682573711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+NPvjvqMz0jQntnXppFMfIo7g9xIUS8A2Ir76H7o3Ns=;
  b=fV/Ozw9QLSWQF60uZsdfzgXMpyuiM9sjVaeBqnSId83/x5r5V22V65J4
   5j6v+k7XSGPNZB8fK9emht/xKFbe3823ZNfA2OO5soOKvnk9saj+IttmV
   YyQAjtaE/W6MS6sYg8Lr3kK1/rBjO14PH/iK5squzvtHe2TLOl2aV8LfA
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Apr 2022 22:35:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 22:35:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 22:35:10 -0700
Received: from [10.50.15.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 22:35:08 -0700
Message-ID: <06e5ce9c-87d0-17a0-138c-5f11f705f6c7@quicinc.com>
Date:   Wed, 27 Apr 2022 11:05:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 02/12] ath11k: Add HW params for WCN6750
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
References: <20220406094107.17878-1-quic_mpubbise@quicinc.com>
 <20220406094107.17878-3-quic_mpubbise@quicinc.com>
 <87k0bbhzij.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87k0bbhzij.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/27/2022 10:51 AM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> Add HW params for WCN6750. It is similar to the HW params
>> of QCA6390 with few differences wrt DP APIs and register
>> offsets.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/core.c | 61 ++++++++++++++++++++++++++
>>   drivers/net/wireless/ath/ath11k/core.h |  1 +
>>   drivers/net/wireless/ath/ath11k/qmi.h  |  2 +
>>   3 files changed, 64 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>> index cbac1919867f..8695f999acb2 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -427,6 +427,67 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>   		.dbr_debug_support = false,
>>   		.global_reset = true,
>>   	},
>> +	{
>> +		.name = "wcn6750 hw1.0",
>> +		.hw_rev = ATH11K_HW_WCN6750_HW10,
>> +		.fw = {
>> +			.dir = "WCN6750/hw1.0",
>> +			.board_size = 256 * 1024,
>> +			.cal_offset = 128 * 1024,
>> +		},
>> +		.max_radios = 1,
>> +		.bdf_addr = 0x4B0C0000,
>> +		.ring_mask = &ath11k_hw_ring_mask_qca6390,
>> +		.internal_sleep_clock = false,
>> +		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_WCN6750,
>> +		.host_ce_config = ath11k_host_ce_config_qca6390,
>> +		.ce_count = 9,
>> +		.target_ce_config = ath11k_target_ce_config_wlan_qca6390,
>> +		.target_ce_count = 9,
>> +		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
>> +		.svc_to_ce_map_len = 14,
>> +		.rfkill_pin = 0,
>> +		.rfkill_cfg = 0,
>> +		.rfkill_on_level = 0,
>> +		.single_pdev_only = true,
>> +		.rxdma1_enable = false,
>> +		.num_rxmda_per_pdev = 1,
>> +		.rx_mac_buf_ring = true,
>> +		.vdev_start_delay = true,
>> +		.htt_peer_map_v2 = false,
>> +
>> +		.spectral = {
>> +			.fft_sz = 0,
>> +			.fft_pad_sz = 0,
>> +			.summary_pad_sz = 0,
>> +			.fft_hdr_len = 0,
>> +			.max_fft_bins = 0,
>> +		},
>> +
>> +		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>> +					BIT(NL80211_IFTYPE_AP),
>> +		.supports_monitor = false,
>> +		.supports_shadow_regs = true,
>> +		.idle_ps = true,
>> +		.supports_sta_ps = true,
>> +		.cold_boot_calib = false,
>> +		.fw_mem_mode = 0,
>> +		.num_vdevs = 16 + 1,
>> +		.num_peers = 512,
>> +		.supports_suspend = false,
>> +		.supports_regdb = true,
>> +		.fix_l1ss = false,
>> +		.credit_flow = true,
>> +		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
>> +		.hal_params = &ath11k_hw_hal_params_qca6390,
>> +		.supports_dynamic_smps_6ghz = false,
>> +		.alloc_cacheable_memory = false,
>> +		.supports_rssi_stats = true,
>> +		.fw_wmi_diag_event = false,
>> +		.current_cc_support = true,
>> +		.dbr_debug_support = false,
>> +		.global_reset = false,
>> +	},
> 
> In the pending branch I added:
> 
> +               .bios_sar_capa = NULL,
> 

This is the only other change I had in V5, thanks for adding this.

Manikanta
