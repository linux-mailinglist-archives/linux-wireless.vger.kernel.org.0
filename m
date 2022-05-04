Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAAF519786
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 08:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbiEDGqN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 02:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiEDGqL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 02:46:11 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F31A04D
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 23:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651646556; x=1683182556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MNV4tPKjw+sU2P/KHe9Zp17alX1Ngr43TpGbZuOl74g=;
  b=XH6mnT/T+JK5UDQ5X4Wg/CFQB44krw0FqDy0BQSbcowc+luLhCjo0f38
   58Bb0K64vNlVlub8g/s8/cymt/GkyO7K/v1QF4AgQPgC+SIbc843lt0BK
   PSXJpIxTaEPeqc/E9PhD3IkdcWPXVrXie41HUjvYDQdE9N4YHs6jNUCm8
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 May 2022 23:42:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 23:42:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 23:42:35 -0700
Received: from [10.50.12.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 3 May 2022
 23:42:33 -0700
Message-ID: <b126ba5d-035c-3218-2847-5ac86063ebd6@quicinc.com>
Date:   Wed, 4 May 2022 12:12:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] ath11k: Fix RX de-fragmentation issue on WCN6750
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220328061947.28813-1-quic_mpubbise@quicinc.com>
 <87bkwgau67.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87bkwgau67.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/2/2022 7:55 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> The offset of REO register where the RX fragment destination ring
>> is configured is different in WCN6750 as compared to WCN6855.
>> Due to this differnce in offsets, on WCN6750, fragment destination
>> ring will be configured incorrectly, leading to RX fragments not
>> getting delivered to the driver. Fix this by defining HW specific
>> offset for the REO MISC CTL register.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> [...]
> 
>> @@ -2229,6 +2229,9 @@ const struct ath11k_hw_regs wcn6855_regs = {
>>   
>>   	/* Shadow register area */
>>   	.hal_shadow_base_addr = 0x000008fc,
>> +
>> +	/* REO MISC CTRL */
>> +	.hal_reo1_misc_ctl = 0x00000630,
>>   };
> 
> I don't really see the benefit from the comment, it doesn't bring any
> extra information.
> 

You are right, let me check if I can add any info or I'll remove the 
comment.

>>   const struct ath11k_hw_regs wcn6750_regs = {
>> @@ -2311,6 +2314,9 @@ const struct ath11k_hw_regs wcn6750_regs = {
>>   
>>   	/* Shadow register area */
>>   	.hal_shadow_base_addr = 0x00000504,
>> +
>> +	/* REO MISC CTRL */
>> +	.hal_reo1_misc_ctl = 0x000005d8,
> 
> Ditto.
> 
> What about other ath11k_hw_regs tables:
> 
> <global>[1906]                 const struct ath11k_hw_regs ipq8074_regs = {
> <global>[1988]                 const struct ath11k_hw_regs qca6390_regs = {
> <global>[2070]                 const struct ath11k_hw_regs qcn9074_regs = {
> 
> You don't mention anything about those in the commit log. If they don't
> use this register (didn't check) we should at least initialise the
> fields to zero, deadbeef or something to make it clear they are unused.
> 

Let me make the changes to initialize the register to 0(zero) for other 
unsupported hardware.

Thanks,
Manikanta
