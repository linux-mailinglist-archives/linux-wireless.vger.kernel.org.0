Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB714BD694
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 07:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbiBUG4R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 01:56:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiBUG4R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 01:56:17 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F52AD4;
        Sun, 20 Feb 2022 22:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645426554; x=1676962554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f247xkeOdcUQ3Zk9XkWSFcO4La446ONgMI9XPSjYtFk=;
  b=XbsXhtXZwGuAzrn4rmG70X72WOpe63je9OMPIjLigcW6vnvubjBGv0dq
   4MDYvhVfbsaY2UHUfsNITikT0BcHM++GTyaqzV5yKg1E80OaBJITkL5Yc
   NbK5mNkJwIXtYt83U0hZHs0lLlHpNIrkxlW9DLC9Sd1W2daalL1XGQVX3
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Feb 2022 22:55:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 22:55:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 20 Feb 2022 22:55:53 -0800
Received: from [10.216.7.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sun, 20 Feb
 2022 22:55:51 -0800
Message-ID: <df81787b-3ad4-62b7-7a39-fdca6775bae1@quicinc.com>
Date:   Mon, 21 Feb 2022 12:25:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 05/19] ath11k: Remove core PCI references from PCI
 common code
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
 <1642337235-8618-6-git-send-email-quic_mpubbise@quicinc.com>
 <87a6fggo0h.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87a6fggo0h.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On 1/28/2022 3:50 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> Remove core PCI and ath11k PCI references(struct ath11k_pci)
>> from PCI common code. Since, PCI common code will be used
>> by hybrid bus devices, this code should be independent
>> from ATH11K PCI references and Linux core PCI references
>> like struct pci_dev.
>>
>> Since this change introduces function callbacks for bus wakeup
>> and bus release operations, wakeup_mhi HW param is no longer
>> needed and hence it is removed completely. Alternatively, bus
>> wakeup/release ops for QCA9074 are initialized to NULL as
>> QCA9704 does not need bus wakeup/release for register accesses.
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
>> @@ -651,6 +653,13 @@ struct ath11k_bus_params {
>>   	bool fixed_bdf_addr;
>>   	bool fixed_mem_region;
>>   	bool static_window_map;
>> +	struct {
>> +		void (*wakeup)(struct ath11k_base *ab);
>> +		void (*release)(struct ath11k_base *ab);
>> +		int (*get_msi_irq)(struct ath11k_base *ab, unsigned int vector);
>> +		void (*window_write32)(struct ath11k_base *ab, u32 offset, u32 value);
>> +		u32 (*window_read32)(struct ath11k_base *ab, u32 offset);
>> +	} ops;
>>   };
> 
> Please don't use bus_params for this, I'm starting to suspect that we
> actually need to remove struct ath11k_bus_params altogether. It would be
> cleaner to have separate 'struct ath11k_pci_ops' or something like that.
> 

Sure, something like 'struct ath11k_bus_ops' in ath11k_base struct would 
be appropriate.
