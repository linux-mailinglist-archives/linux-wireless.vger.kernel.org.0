Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811774BD688
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 07:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbiBUGaH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 01:30:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiBUGaG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 01:30:06 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BAD4163D;
        Sun, 20 Feb 2022 22:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645424984; x=1676960984;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dXYD8eWi1+Io0cIGkxMhaeSzOKmEOR73lAviKQy1nXM=;
  b=g2fKnk3lBUyQX30vC3Ox2sx9tX0mv9SRjdjLEP++CcNprrCZc4jLNW8t
   UkD86g6mhCOoQnwqt/Z0IqwtyeSN4Earfbbi4INmywpyoSvR3vM0dpugD
   2CZvJDSQDlK+yW3zqXbHewGYm2kd88S/hongPCAlOoaEdbiHk7tIN3UwB
   0=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Feb 2022 22:29:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 22:29:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 20 Feb 2022 22:29:41 -0800
Received: from [10.216.7.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sun, 20 Feb
 2022 22:29:38 -0800
Message-ID: <f3704567-f269-c836-2880-e953c4abb872@quicinc.com>
Date:   Mon, 21 Feb 2022 11:59:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 00/19] add support for WCN6750
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
 <87ilu4gomd.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87ilu4gomd.fsf@kernel.org>
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

On 1/28/2022 3:37 PM, Kalle Valo wrote:

> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>
>> WCN6750 is non-DBS 2x2 11AX chipset. Unlike QCA6390/WCN6855 which
>> are DBS (dual band simultaneous) solutions (2 LMACs), WCN6750 has a
>> single LMAC supporting 2G, 5G and 6G bands. It can be operated only
>> on one band at any given point.
>>
>> WCN6750 is a PCIe device. Unlike other supported ATH11K PCIe devices
>> which are directly attached to APSS (Application Processor SubSystem),
>> WCN6750 is not attached to APSS, it is attached to the WPSS
>> (Wireless Processor SubSystem) Q6 processor, the FW which runs on the
>> Q6 processor will enumerate the PCIe device. Since APSS is unaware of
>> such a device, it has to be registered as a platform device(AHB) to the
>> kernel for device probing. Like other AHB devices, remoteproc APIs are
>> used to boot up or shutdown of WCN6750.
>>
>> WCN6750 uses both AHB and PCIe ATH11K APIs for it's operation.
>> It uses AHB APIs for device probe and booting of the remote processor.
>> Once device is booted up, it uses ATH11K PCIe APIs for initialization
>> and register access. Hence, it is referred as hybrid bus device in
>> the rest of this series.
>>
>> Since the chip is enumerated by WPSS Q6, device information like
>> BAR and BAR size is not known to the APSS processor. A new QMI message
>> called device info QMI request will be sent to the target for fetching
>> these details.
>>
>> STA and AP modes are supported; Basic connectivity and ping are
>> verified in both the modes.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>
>> Note:
>> *	Remoteproc driver changes for WCN6750 which takes care of
>> 	downloading the FW and booting of Q6 processor are under
>> 	upstream review.
>> 	Link: https://patchwork.kernel.org/project/linux-remoteproc/list/?series=582475
> This is a very good overview, thanks for that. But I think something
> which is not clearly mentioned here is that this only works on Qualcomm
> Snapdragon SoC, right?

You are absolutely right.

>   So even though WCN6750 is a PCI device, it cannot
> be attached to any platform. It would be good to emphasise that.

I'll add this detail in the next revision.

>> Manikanta Pubbisetty (19):
>>    ath11k: PCI changes to support WCN6750
>>    ath11k: Refactor PCI code to support hybrid bus devices
>>    ath11k: Choose MSI config based on HW revision
>>    ath11k: Refactor MSI logic
>>    ath11k: Remove core PCI references from PCI common code
>>    ath11k: Add HW params for WCN6750
>>    ath11k: Add bus params for WCN6750
>>    ath11k: Add register access logic for WCN6750
>>    ath11k: Fetch device information via QMI for WCN6750
>>    ath11k: Add QMI changes for WCN6750
>>    ath11k: HAL changes to support WCN6750
>>    ath11k: Datapath changes to support WCN6750
>>    ath11k: Fix RX de-fragmentation issue on WCN6750
>>    ath11k: Do not put HW in DBS mode for WCN6750
>>    ath11k: WMI changes to support WCN6750
>>    ath11k: Update WBM idle ring HP after FW mode on
>>    ath11k: Add support for WCN6750 device
>>    ath11k: Add support for targets without trustzone
>>    dt: bindings: net: add bindings of WCN6750 for ath11k
> 19 patches is a lot to chew on in one go, my recommendation is to have
> max 10-12 patches per set.
>
> In this case having three patchsets would make it a lot easier for
> reviewers, but not sure how to split them. Maybe you could submit these
> patches separate for preparing WCN6750 support, after a quick look they
> seem pretty independent:
>
>    ath11k: Fetch device information via QMI for WCN6750
>    ath11k: HAL changes to support WCN6750
>    ath11k: Fix RX de-fragmentation issue on WCN6750
>    ath11k: Do not put HW in DBS mode for WCN6750
>    ath11k: WMI changes to support WCN6750
Sure, I'll logically split the series in the next revisions.
