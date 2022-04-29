Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D285144EE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356184AbiD2JAy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356068AbiD2JAy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 05:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A2D985A6;
        Fri, 29 Apr 2022 01:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 896C7621DF;
        Fri, 29 Apr 2022 08:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910DAC385A4;
        Fri, 29 Apr 2022 08:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651222656;
        bh=G+F4MHPC3gx10dTFgiEJr2YE94YbxB3UX1Lblg+1WzM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hDXcu90eqSpCmOFcOynumu4/Wht0U5igvFoEz74Ca1xLPNFRge+ZuuYY12essSgfP
         /P8YWT/wShcPCFHU0TDhFFkIdZteZXUZG5ZZaelM3e4GfT7Y3BrrBIXbg2qJTMPWr/
         tHoax26SmAUW/xTC/YMuoFh4mNfsJqxUqgsMhGVk6qCQxLBBb9bW8ziYnSpNaAuYUu
         Sag7EQYypipun+xKyTnhYPi9V+cPWpIXX5kEYSuXbLCgSFF4TzQvO4E+YQM0Q4T5AC
         Bh54l0/1PPMu6XnS0qcOasmuwSX63YY+ayJEKWNNRrNm12DNrXFIbm1tltq3wsVZzE
         1n2oPVZxzquig==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
Subject: Re: [PATCH v4 04/12] ath11k: Add register access logic for WCN6750
References: <20220406094107.17878-1-quic_mpubbise@quicinc.com>
        <20220406094107.17878-5-quic_mpubbise@quicinc.com>
        <87czh3gjuq.fsf@kernel.org>
        <2a18a4d3-254b-727e-e96d-90deec61571c@quicinc.com>
Date:   Fri, 29 Apr 2022 11:57:32 +0300
In-Reply-To: <2a18a4d3-254b-727e-e96d-90deec61571c@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 27 Apr 2022 11:23:52 +0530")
Message-ID: <87levoe077.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> On 4/27/2022 11:15 AM, Kalle Valo wrote:
>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>
>>> WCN6750 uses static window mapping to access the HW registers.
>>> Unlike QCN9074 which uses 2nd window for CE and 3rd window
>>> for UMAC register accesses, WCN6750 uses 1st window for UMAC
>>> and 2nd window for CE registers.
>>>
>>> Code is refactored so that WCN6750 can use the existing
>>> ath11k_pci_read/write() APIs for accessing the registers.
>>>
>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>> ---
>>>   drivers/net/wireless/ath/ath11k/ahb.c  |  3 ++
>>>   drivers/net/wireless/ath/ath11k/core.h |  2 +
>>>   drivers/net/wireless/ath/ath11k/pci.c  |  4 ++
>>>   drivers/net/wireless/ath/ath11k/pcic.c | 53 +++++++++-----------------
>>>   4 files changed, 28 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
>>> index d73643e3e8dd..d27fc7276977 100644
>>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>>> @@ -42,6 +42,9 @@ const struct ath11k_bus_params ath11k_ahb_hybrid_bus_params = {
>>>   	.fixed_bdf_addr = false,
>>>   	.fixed_mem_region = false,
>>>   	.hybrid_bus_type = true,
>>> +	.static_window_map = true,
>>> +	.dp_window_idx = 1,
>>> +	.ce_window_idx = 2,
>>>   };
>>
>> Even if the values are zero, please initialise the new fields in every
>> bus_params structure:
>>
>> ahb.c:31:static const struct ath11k_bus_params ath11k_ahb_bus_params = {
>> pci.c:118:static const struct ath11k_bus_params ath11k_pci_bus_params = {
>>
>
> Makes sense, should I send another series addressing these?

Please fix that already in this patchset.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
