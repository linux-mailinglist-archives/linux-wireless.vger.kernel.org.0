Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3D575F2D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jul 2022 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiGOKLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jul 2022 06:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiGOKKu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jul 2022 06:10:50 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC0B83F27
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jul 2022 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657879847; x=1689415847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zaz6vbeXxvTcf5zTVCLQSdqT3qWiYkU2GcDd51eyZcg=;
  b=mbyj5aVq0LEIOuDsmm8Uznp3YJcfrviHep/3jqh+MlHaMMbXLnlqYDNM
   xbLKhVo187eCeLYKZx7x5xCuVvbawdj/lpurkO2kp7xhhd0SSapcI02qa
   sASKhiJNknFSOyRnNUBgm4RQCMEial56gR3Iax5XqmOVJu/f33vktCAEa
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jul 2022 03:10:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:10:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 03:10:46 -0700
Received: from [10.216.42.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Jul
 2022 03:10:44 -0700
Message-ID: <fc902e10-9d99-d272-84bf-87450678982a@quicinc.com>
Date:   Fri, 15 Jul 2022 15:40:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ath11k: Fix register write failure on QCN9074
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Maxime Bizon" <mbizon@freebox.fr>
References: <20220608062954.27792-1-quic_mpubbise@quicinc.com>
 <87wncesne8.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87wncesne8.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/15/2022 3:33 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> Commit 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
>> regressed QCN9074. With the above mentioned commit, writes are failing
>> for some registers on QCN9074 although the device seems to work
>> normally.
>>
>> ath11k_pci 0000:03:00.0: failed to set pcie link register0x01e0e0a8: 0xffffffff != 0x00000010
>> ath11k_pci 0000:03:00.0: failed to set sysclk: -110
>>
>> PCIe devices in ath11k (QCA6390, WCN6855, QCN9074, WCN6750) use window
>> concept for register accesses. There are two schemes, dynamic & static
>> window.
>>
>> In dynamic window scheme, a single window(region in the BAR) is mapped
>> either to CE or DP register windows at any give time. QCA6390 & WCN6855
>> follow this scheme for register accesses.
>>
>> In static window scheme, CE & DP register windows are statically mapped
>> to separate regions with in the BAR so that there is no switching of
>> register windows between CE & DP register accesses. QCN9074 & WCN6750
>> follow this scheme although the window start offsets are different for
>> QCN9074 & WCN6750.
>>
>> QCN9074 uses 3rd & 2nd window for DP & CE register accesses respectively
>> whereas WCN6750 uses 1st & 2nd window for DP & CE. In QCN9074, along with
>> 2nd & 3rd windows, 1st window is also used for certain configurations
>> which commit 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
>> did not account for and hence the regression.
>>
>> Fix this by going back to the original way of accessing the registers on
>> QCN9074. Since this diverges from WCN6750 way of accessing registers, it
>> is required to register window_read32/window_write32() pci_ops for WCN6750.
>> We can also get rid of dp_window_idx & ce_window_idx members in hw_params,
>> so remove them.
>>
>> Also add a new API ath11k_pcic_register_pci_ops() for registering pci_ops
>> to the ath11k core. This API checks for mandatory pci_ops() and reports
>> error if those are missing. Also initialize unused pci_ops to NULL.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
>> Reported-by: Maxime Bizon <mbizon@freebox.fr>
>> Tested-by: Maxime Bizon <mbizon@freebox.fr>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> [...]
> 
>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>> @@ -50,6 +50,23 @@ static void ath11k_pci_bus_release(struct ath11k_base *ab)
>>   	mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
>>   }
>>   
>> +static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab, u32 offset)
>> +{
>> +	u32 window_start;
>> +
>> +	/* If offset lies within DP register range, use 3rd window */
>> +	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
>> +		window_start = 3 * ATH11K_PCI_WINDOW_START;
>> +	/* If offset lies within CE register range, use 2nd window */
>> +	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
>> +		 ATH11K_PCI_WINDOW_RANGE_MASK)
>> +		window_start = 2 * ATH11K_PCI_WINDOW_START;
>> +	else
>> +		window_start = ATH11K_PCI_WINDOW_START;
>> +
>> +	return window_start;
>> +}
>> +
>>   static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
>>   {
>>   	struct ath11k_base *ab = ab_pci->ab;
>> @@ -70,13 +87,23 @@ static void
>>   ath11k_pci_window_write32(struct ath11k_base *ab, u32 offset, u32 value)
>>   {
>>   	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
>> -	u32 window_start = ATH11K_PCI_WINDOW_START;
>> +	u32 window_start;
>>   
>> -	spin_lock_bh(&ab_pci->window_lock);
>> -	ath11k_pci_select_window(ab_pci, offset);
>> -	iowrite32(value, ab->mem + window_start +
>> -		  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
>> -	spin_unlock_bh(&ab_pci->window_lock);
>> +	if (ab->hw_params.static_window_map)
>> +		window_start = ath11k_pci_get_window_start(ab, offset);
>> +	else
>> +		window_start = ATH11K_PCI_WINDOW_START;
>> +
>> +	if (window_start == ATH11K_PCI_WINDOW_START) {
>> +		spin_lock_bh(&ab_pci->window_lock);
>> +		ath11k_pci_select_window(ab_pci, offset);
>> +		iowrite32(value, ab->mem + window_start +
>> +			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
>> +		spin_unlock_bh(&ab_pci->window_lock);
>> +	} else {
>> +		iowrite32(value, ab->mem + window_start +
>> +			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
>> +	}
>>   }
> 
> I refactored ath11k_pci_get_window_start() a bit, please check my
> changes here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=95094045d7f467aa8928307ea538d1fd9d15a239
> 

Refactored code looks okay to me. Just one comment though, you may 
probably remove initialization of "u32 window_start = 
ATH11K_PCI_WINDOW_START;" in ath11k_pci_window_read32? It is removed in 
ath11k_pci_window_write32.

Thanks,
Manikanta
