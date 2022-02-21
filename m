Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5FF4BE3F8
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351173AbiBUJsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 04:48:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352455AbiBUJr3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 04:47:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A6242A22;
        Mon, 21 Feb 2022 01:19:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E46AACE0E7C;
        Mon, 21 Feb 2022 09:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFEEC340EB;
        Mon, 21 Feb 2022 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645435187;
        bh=zWFf2DIgu11basYMV6UOcFEYQXmcDx6HRp6do0gP0RY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=b9ZpdI7Tz6WIjvBZ/hJiixAlZvMiaUf33cRWcYwv2XiMp5Fh0xsmlkLruN8w2b5XY
         mbDwXZ0kOTwyD9FAPI7XIsL44//pjjRs9fIpBfIcBODWE6EAZhBmJLK57xGWGkr9hk
         +lPeTzYQliz2+yKqe7Qx00bTaaVu9cOmRgwYZ9iRdQPUy1l+S2rfMi0U7QU/re3Nen
         lut8gB6X+dcL5PnQ9yAOaOAIWPQL4c3UxcJySPVMULFxUQMVYKDcSm8qmAtfy3kmLQ
         ia+OJU4m34IOxPaCJqJLZ9pjyf98tlF9dOeAa8fDmUJyxMcoCPI4pMXn1AmaC12Nkn
         gYMulX6Ptq8sQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 02/19] ath11k: Refactor PCI code to support hybrid bus devices
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-3-git-send-email-quic_mpubbise@quicinc.com>
        <87h79of470.fsf@kernel.org>
        <9acca69c-3d5d-b6b9-b5ca-c2411e206908@quicinc.com>
Date:   Mon, 21 Feb 2022 11:19:44 +0200
In-Reply-To: <9acca69c-3d5d-b6b9-b5ca-c2411e206908@quicinc.com> (Manikanta
        Pubbisetty's message of "Mon, 21 Feb 2022 13:34:14 +0530")
Message-ID: <871qzwzidr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> On 1/28/2022 5:43 PM, Kalle Valo wrote:
>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>
>>> Unlike other ATH11K PCIe devices which are enumerated by APSS
>>> processor (Application Processor SubSystem), WCN6750 gets
>>> enumerated by the WPSS Q6 processor (Wireless Processor SubSystem);
>>> In simple terms, though WCN6750 is PCIe device, it is not attached
>>> to the APSS processor, APSS will not know of such a device being
>>> present in the system and therefore WCN6750 will be registered as
>>> a platform device to the kernel core like other supported AHB
>>> devices.
>>>
>>> WCN6750 uses both AHB and PCI APIs for it's operation, it uses
>>> AHB APIs for device probe/boot and PCI APIs for device setup
>>> and register accesses; Because of this nature, it is referred
>>> as a hybrid bus device.
>>>
>>> Refactor PCI code to support hybrid bus devices like WCN6750.
>>>
>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>
>> [...]
>>
>>> --- /dev/null
>>> +++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c
>>
>> [...]
>>
>>> +static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
>>> +{
>>> +	struct ath11k_base *ab = ab_pci->ab;
>>> +
>>> +	u32 window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, offset);
>>> +
>>> +	lockdep_assert_held(&ab_pci->window_lock);
>>> +
>>> +	if (window != ab_pci->register_window) {
>>> +		iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
>>> +			  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
>>> +		ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
>>> +		ab_pci->register_window = window;
>>> +	}
>>> +}
>>
>> So the style used in ath11k is ath11k_<filename>_foo, so that a function
>> ath11k_pci_foo() should be in pci.c. This patch is now breaking that
>> style. Maybe pci_cmn.c should renamed to cpci.c, pcic.c or something
>> like that? Then the function prefix could be ath11k_cpci_, ath11k_pcic_
>> or similar.
>>
>
> Makes sense, pcic.c and ath11k_pcic_* looks better, I'll make these changes.

Of course another possiblity, which I forgot to mention in my previous
email, is to keep pci_cmn.c filename but rename the functions to
ath11k_pci_cmn_foo(). Though don't know which one is better.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
