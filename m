Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8F8511774
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 14:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiD0MiZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 08:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiD0MiY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 08:38:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3DB52E57;
        Wed, 27 Apr 2022 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651062911; x=1682598911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wabwfxq2ea3ScsaUrS8rkQH3XWlo//81jSwv8ow+8jU=;
  b=r2kbkJRKz8HFzOeF8WxDXR4LZW/2+zgaVtS2fBJHU0voZAWkLfzUjNvB
   v9PWHEw/A8dLZ4n9k2+nklDdblnbR/+NJVEN8dNQQLaAgXVK2dU7ew7I8
   +3b1YbzNzqA6dOjUEdwY6IyixFXWAMSwORFXCOBQk+whXSZlItHmCLGp5
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 05:35:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 05:35:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 05:35:09 -0700
Received: from [10.50.15.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 05:35:07 -0700
Message-ID: <86da868b-c1d5-0494-ba43-45067c436904@quicinc.com>
Date:   Wed, 27 Apr 2022 18:05:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 4/9] ath11k: Add register access logic for WCN6750
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
References: <20220427111848.9257-1-quic_mpubbise@quicinc.com>
 <20220427111848.9257-5-quic_mpubbise@quicinc.com> <87pml2g1c7.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87pml2g1c7.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/27/2022 5:55 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> WCN6750 uses static window mapping to access the HW registers.
>> Unlike QCN9074 which uses 2nd window for CE and 3rd window
>> for UMAC register accesses, WCN6750 uses 1st window for UMAC
>> and 2nd window for CE registers.
>>
>> Code is refactored so that WCN6750 can use the existing
>> ath11k_pci_read/write() APIs for accessing the registers.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/ahb.c  |  6 +++
>>   drivers/net/wireless/ath/ath11k/core.h |  2 +
>>   drivers/net/wireless/ath/ath11k/pci.c  | 34 ++++++++++++++--
>>   drivers/net/wireless/ath/ath11k/pcic.c | 54 +++++++++-----------------
>>   4 files changed, 58 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
>> index cfdd415f0203..fa12e50f32f4 100644
>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>> @@ -34,7 +34,10 @@ static const struct ath11k_bus_params ath11k_ahb_bus_params = {
>>   	.m3_fw_support = false,
>>   	.fixed_bdf_addr = true,
>>   	.fixed_mem_region = true,
>> +	.static_window_map = false,
>>   	.hybrid_bus_type = false,
>> +	.dp_window_idx = 0,
>> +	.ce_window_idx = 0,
>>   };
>>   
>>   const struct ath11k_bus_params ath11k_ahb_hybrid_bus_params = {
>> @@ -42,7 +45,10 @@ const struct ath11k_bus_params ath11k_ahb_hybrid_bus_params = {
>>   	.m3_fw_support = false,
>>   	.fixed_bdf_addr = false,
>>   	.fixed_mem_region = false,
>> +	.static_window_map = true,
>>   	.hybrid_bus_type = true,
>> +	.dp_window_idx = 1,
>> +	.ce_window_idx = 2,
>>   };
>>   
>>   #define ATH11K_IRQ_CE0_OFFSET 4
>> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
>> index 51f313dd7f26..ee0ad93d5843 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.h
>> +++ b/drivers/net/wireless/ath/ath11k/core.h
>> @@ -756,6 +756,8 @@ struct ath11k_bus_params {
>>   	bool fixed_mem_region;
>>   	bool static_window_map;
>>   	bool hybrid_bus_type;
>> +	u8 dp_window_idx;
>> +	u8 ce_window_idx;
>>   };
>>   
>>   struct ath11k_pci_ops {
>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
>> index ddd1e2de6a2e..9184cb893bd4 100644
>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>> @@ -115,12 +115,26 @@ static const struct ath11k_pci_ops ath11k_pci_ops_qcn9074 = {
>>   	.window_read32 = ath11k_pci_window_read32,
>>   };
>>   
>> -static const struct ath11k_bus_params ath11k_pci_bus_params = {
>> +static const struct ath11k_bus_params ath11k_pci_bus_params_qca6390 = {
>>   	.mhi_support = true,
>>   	.m3_fw_support = true,
>>   	.fixed_bdf_addr = false,
>>   	.fixed_mem_region = false,
>> +	.static_window_map = false,
>>   	.hybrid_bus_type = false,
>> +	.dp_window_idx = 0,
>> +	.ce_window_idx = 0,
>> +};
>> +
>> +static const struct ath11k_bus_params ath11k_pci_bus_params_qcn9074 = {
>> +	.mhi_support = true,
>> +	.m3_fw_support = true,
>> +	.fixed_bdf_addr = false,
>> +	.fixed_mem_region = false,
>> +	.static_window_map = true,
>> +	.hybrid_bus_type = false,
>> +	.dp_window_idx = 3,
>> +	.ce_window_idx = 2,
>>   };
>>   
>>   static const struct ath11k_msi_config msi_config_one_msi = {
>> @@ -704,11 +718,26 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>>   {
>>   	struct ath11k_base *ab;
>>   	struct ath11k_pci *ab_pci;
>> +	const struct ath11k_bus_params *bus_params;
>>   	u32 soc_hw_version_major, soc_hw_version_minor, addr;
>>   	int ret;
>>   
>> +	switch (pci_dev->device) {
>> +	case QCA6390_DEVICE_ID:
>> +	case WCN6855_DEVICE_ID:
>> +		bus_params = &ath11k_pci_bus_params_qca6390;
>> +		break;
>> +	case QCN9074_DEVICE_ID:
>> +		bus_params = &ath11k_pci_bus_params_qcn9074;
>> +		break;
> 
> Now you are making bus_params device specific, that's not really the
> point of bus params. They are supposed to be _bus_ specific parameters.
> 
> Can't you use hw_params like I mentioned in the review?
> 

I'm totally confused now, CE & DP window indices are specifics that come 
in to play when we access the bus registers and they are closely tied to 
static_window_map variable which is already in bus_params, I'm not sure 
if it is a good to have them in hw_params. If at all we decide to move 
them to hw_params, then we can move pretty much everything to hw_params 
and remove bus_params completely.

I prefer to keep them in bus_params and make bus_params device specific,
If you feel it otherwise, then I can move it to hw_params.

Thanks,
Manikanta
