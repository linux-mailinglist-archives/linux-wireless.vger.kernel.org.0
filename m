Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6842A534961
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 05:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiEZDnA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 23:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiEZDm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 23:42:57 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F3BC6DB;
        Wed, 25 May 2022 20:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653536575; x=1685072575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qz/KHqk3byoT6h2h00AP8qTrIFo+MV2teTZS41oryWs=;
  b=a1jwuKeslxl0es02+zKYRc1pCTQsTpomT7/NJmPmR70lTfXnYtTkCVr5
   9PnepPpTTM7hFahJGAhwHruMmyC5xgj51JEVR6wnB+WG9rkvjSv/NPI2C
   bPsSxQFluW9zlWeJMzHdrqrtPkFsf92gpzP7ropnd10lZbsbJBuY0m9NT
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 May 2022 20:42:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 20:42:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 20:42:54 -0700
Received: from [10.50.35.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 25 May
 2022 20:42:51 -0700
Message-ID: <c57e8791-b6ce-0752-52ca-a1cb938187d7@quicinc.com>
Date:   Thu, 26 May 2022 09:12:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 4/9] ath11k: Add register access logic for WCN6750
Content-Language: en-US
To:     <mbizon@freebox.fr>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <mka@chromium.org>
References: <20220429170502.20080-1-quic_mpubbise@quicinc.com>
 <20220429170502.20080-5-quic_mpubbise@quicinc.com>
 <bd6d97a4cc6665d0ee632444f75e3480160387ec.camel@freebox.fr>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <bd6d97a4cc6665d0ee632444f75e3480160387ec.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/26/2022 12:16 AM, Maxime Bizon wrote:
> 
> On Fri, 2022-04-29 at 22:34 +0530, Manikanta Pubbisetty wrote:
> 
> Hello Manikanta,
> 
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-
>> QCAHKSWPL_SILICONZ-1
> 
> Nope your patch breaks QCN9074:
> 
> [   13.660963] ath11k_pci 0000:03:00.0: failed to set pcie link register 0x01e0e0a8: 0xffffffff != 0x00000010
> [   13.675994] ath11k_pci 0000:03:00.0: failed to set sysclk: -110
> 
> device still seem to work though

Thanks for letting me know about this, IIRC I don't remember 
encountering this problem in my testing. Just for my understanding, have 
you reverted this change and confirmed that these errors go away ?

> 
>> @@ -134,16 +134,13 @@ EXPORT_SYMBOL(ath11k_pcic_init_msi_config);
>>   static inline u32 ath11k_pcic_get_window_start(struct ath11k_base *ab,
>>   					       u32 offset)
>>   {
>> -	u32 window_start;
>> +	u32 window_start = 0;
>>   
>> -	/* If offset lies within DP register range, use 3rd window */
>>   	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
>> -		window_start = 3 * ATH11K_PCI_WINDOW_START;
>> -	/* If offset lies within CE register range, use 2nd window */
>> -	else if ((offset ^ HAL_CE_WFSS_CE_REG_BASE) < ATH11K_PCI_WINDOW_RANGE_MASK)
>> -		window_start = 2 * ATH11K_PCI_WINDOW_START;
>> -	else
>> -		window_start = ATH11K_PCI_WINDOW_START;
>> +		window_start = ab->hw_params.dp_window_idx * ATH11K_PCI_WINDOW_START;
>> +	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
>> +		 ATH11K_PCI_WINDOW_RANGE_MASK)
>> +		window_start = ab->hw_params.ce_window_idx * ATH11K_PCI_WINDOW_START;
>>   
>>   	return window_start;
>>   }
> 
> 
> for some offsets, previous code could return ATH11K_PCI_WINDOW_START,
> whereas new code now returns 0
> 
> 
>> @@ -162,19 +159,12 @@ void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
>>   
>>   	if (offset < ATH11K_PCI_WINDOW_START) {
>>   		iowrite32(value, ab->mem  + offset);
>> -	} else {
>> -		if (ab->hw_params.static_window_map)
>> -			window_start = ath11k_pcic_get_window_start(ab, offset);
>> -		else
>> -			window_start = ATH11K_PCI_WINDOW_START;
>> -
>> -		if (window_start == ATH11K_PCI_WINDOW_START &&
>> -		    ab->pci.ops->window_write32) {
>> -			ab->pci.ops->window_write32(ab, offset, value);
>> -		} else {
>> -			iowrite32(value, ab->mem + window_start +
>> -				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
>> -		}
>> +	} else if (ab->hw_params.static_window_map) {
>> +		window_start = ath11k_pcic_get_window_start(ab, offset);
>> +		iowrite32(value, ab->mem + window_start +
>> +			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
>> +	} else if (ab->pci.ops->window_write32) {
>> +		ab->pci.ops->window_write32(ab, offset, value);
>>   	}
>>
> 
> with previous code on QCN9074, when ath11k_pcic_get_window_start()
> returned ATH11K_PCI_WINDOW_START, then it would call window_write32()
> 
> with new code on QCN9074, static_window_map is true, so window_write32
> will never be called.
> 
>>   u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
> 
> ditto here
> 

If you could please confirm that reverting this change helps, I can send 
a patch to fix this.

Thanks,
Manikanta
