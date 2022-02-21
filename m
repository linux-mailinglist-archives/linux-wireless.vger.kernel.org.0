Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3024BD7BD
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 09:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbiBUIEq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 03:04:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiBUIEp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 03:04:45 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D0C67;
        Mon, 21 Feb 2022 00:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645430663; x=1676966663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KCB9+fgfvX79/Zhwfz6+z0T5e6wEWBako053p3e7e2A=;
  b=ymyD8wToeWaVKWcbfvf5PfsDlL2Oc5f7kbwBeSxo6tHO/OWNiTTVWpMC
   03azO3Y5VPPliYaAaKSKYjwkFejenLeD8eZisB+LHyk2phZB+xfsc1Olo
   rcJ+6olNMjJmzmxRi7c1CYlu/08XkFlbw8Gv9sMGkLlLs0MnAtYm4jQPh
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Feb 2022 00:04:22 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:04:22 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 00:04:22 -0800
Received: from [10.216.7.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 00:04:19 -0800
Message-ID: <9acca69c-3d5d-b6b9-b5ca-c2411e206908@quicinc.com>
Date:   Mon, 21 Feb 2022 13:34:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 02/19] ath11k: Refactor PCI code to support hybrid bus
 devices
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
 <1642337235-8618-3-git-send-email-quic_mpubbise@quicinc.com>
 <87h79of470.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87h79of470.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 1/28/2022 5:43 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> Unlike other ATH11K PCIe devices which are enumerated by APSS
>> processor (Application Processor SubSystem), WCN6750 gets
>> enumerated by the WPSS Q6 processor (Wireless Processor SubSystem);
>> In simple terms, though WCN6750 is PCIe device, it is not attached
>> to the APSS processor, APSS will not know of such a device being
>> present in the system and therefore WCN6750 will be registered as
>> a platform device to the kernel core like other supported AHB
>> devices.
>>
>> WCN6750 uses both AHB and PCI APIs for it's operation, it uses
>> AHB APIs for device probe/boot and PCI APIs for device setup
>> and register accesses; Because of this nature, it is referred
>> as a hybrid bus device.
>>
>> Refactor PCI code to support hybrid bus devices like WCN6750.
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
>> --- /dev/null
>> +++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c
> 
> [...]
> 
>> +static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
>> +{
>> +	struct ath11k_base *ab = ab_pci->ab;
>> +
>> +	u32 window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, offset);
>> +
>> +	lockdep_assert_held(&ab_pci->window_lock);
>> +
>> +	if (window != ab_pci->register_window) {
>> +		iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
>> +			  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
>> +		ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
>> +		ab_pci->register_window = window;
>> +	}
>> +}
> 
> So the style used in ath11k is ath11k_<filename>_foo, so that a function
> ath11k_pci_foo() should be in pci.c. This patch is now breaking that
> style. Maybe pci_cmn.c should renamed to cpci.c, pcic.c or something
> like that? Then the function prefix could be ath11k_cpci_, ath11k_pcic_
> or similar.
> 

Makes sense, pcic.c and ath11k_pcic_* looks better, I'll make these changes.
