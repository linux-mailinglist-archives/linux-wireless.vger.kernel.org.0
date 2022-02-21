Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77824BE72D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbiBUKsC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 05:48:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355320AbiBUKrm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 05:47:42 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC6054BFD;
        Mon, 21 Feb 2022 02:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645438123; x=1676974123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IllAWlnl/SYaMR8rAmC0CK5PLIeHha4xbUrs57x67pE=;
  b=MmfPgWfg1PIAGJleVVv56onNwHgKUFWrL/0AuQ7hsRmbkw58pEN5f4/W
   brOGmLW0BlZYVixllUaEkrweINX4DceYr8IGFKiRRQYsv95vzWqBQDCJc
   vGVFu5t795fdF6rM9T60w1PsuK6HBWr2BPYAEjPyxPxitaVZ/LEuRDmah
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Feb 2022 02:08:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 02:08:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 02:08:41 -0800
Received: from [10.216.7.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 02:08:37 -0800
Message-ID: <04138c2c-7dff-3378-ffd7-cfb0c146a763@quicinc.com>
Date:   Mon, 21 Feb 2022 15:38:31 +0530
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
 <df81787b-3ad4-62b7-7a39-fdca6775bae1@quicinc.com>
 <875yp8zihm.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <875yp8zihm.fsf@kernel.org>
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



On 2/21/2022 2:47 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> On 1/28/2022 3:50 PM, Kalle Valo wrote:
>>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>>
>>>> Remove core PCI and ath11k PCI references(struct ath11k_pci)
>>>> from PCI common code. Since, PCI common code will be used
>>>> by hybrid bus devices, this code should be independent
>>>> from ATH11K PCI references and Linux core PCI references
>>>> like struct pci_dev.
>>>>
>>>> Since this change introduces function callbacks for bus wakeup
>>>> and bus release operations, wakeup_mhi HW param is no longer
>>>> needed and hence it is removed completely. Alternatively, bus
>>>> wakeup/release ops for QCA9074 are initialized to NULL as
>>>> QCA9704 does not need bus wakeup/release for register accesses.
>>>>
>>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>>
>>> [...]
>>>
>>>> @@ -651,6 +653,13 @@ struct ath11k_bus_params {
>>>>    	bool fixed_bdf_addr;
>>>>    	bool fixed_mem_region;
>>>>    	bool static_window_map;
>>>> +	struct {
>>>> +		void (*wakeup)(struct ath11k_base *ab);
>>>> +		void (*release)(struct ath11k_base *ab);
>>>> +		int (*get_msi_irq)(struct ath11k_base *ab, unsigned int vector);
>>>> +		void (*window_write32)(struct ath11k_base *ab, u32 offset, u32 value);
>>>> +		u32 (*window_read32)(struct ath11k_base *ab, u32 offset);
>>>> +	} ops;
>>>>    };
>>>
>>> Please don't use bus_params for this, I'm starting to suspect that we
>>> actually need to remove struct ath11k_bus_params altogether. It would be
>>> cleaner to have separate 'struct ath11k_pci_ops' or something like that.
>>>
>>
>> Sure, something like 'struct ath11k_bus_ops' in ath11k_base struct
>> would be appropriate.
> 
> But we have 'struct ath11k_hif_ops' already, and that's basically
> ath11k_bus_ops with a confusing name :) (IIRC HIF means Host InterFace,
> or something like that.) So having both ath11k_bus_ops and
> ath11k_hif_ops would become even more confusing.
> 
> You are basically abstracting out PCI functionality, that's why I
> suggested ath11k_pci_ops. But yeah, naming is hard :)
> 

Hmmm, makes sense :)
