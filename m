Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68264511072
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 07:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357810AbiD0FTy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiD0FTx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AE7D5E8E;
        Tue, 26 Apr 2022 22:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 771D761278;
        Wed, 27 Apr 2022 05:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7469AC385A9;
        Wed, 27 Apr 2022 05:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651036602;
        bh=GNJYWTfJK0r0lr51apbm0Gqnm/Ghi+1O5dXKynJGFTE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KZOpL+rtS2+OTSiIsv2WpMqn3hx6JtcHzSxbtL3BB3YNAEJyJKWeVxVXg6tj6N1mz
         lBsFmm9ReNLhh2L0GwzYhU74QDKcHdGsYCtArSNe07w3lQY1FmBOVkK/7MsMQ6KZBk
         QM5IrtzBv6WSV/mJGzojqbFrzKDx2IQCdHhVCJsDxVJT3aDcvuPw42siKRldBGFwn/
         S4Sv/c2Q1lz0u/7WgOEPfwk6X6PT3vDVhLX+mlKtF2FfxALvbcne5JNFAJf039Kp+O
         c4AqpFeUb80waGwgj/tOWko85Fmkw5Zms0OMBaHUoud1f0eBb0vCQbtG+sLWwrLOmd
         WSVZiQh68LQWQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
Subject: Re: [PATCH v5 00/12] add support for WCN6750
References: <20220426145456.8055-1-quic_mpubbise@quicinc.com>
        <87v8uvhzuk.fsf@kernel.org>
Date:   Wed, 27 Apr 2022 08:16:38 +0300
In-Reply-To: <87v8uvhzuk.fsf@kernel.org> (Kalle Valo's message of "Wed, 27 Apr
        2022 08:14:43 +0300")
Message-ID: <87o80nhzrd.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

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
>> An important point to note is that though WCN6750 is a PCIe device,
>> it cannot be attached to any other platform except on Qualcomm
>> Snapdragon SoCs due to the aforementioned reasons.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>
>> Manikanta Pubbisetty (12):
>>   dt: bindings: net: add bindings of WCN6750 for ath11k
>>   ath11k: Add HW params for WCN6750
>>   ath11k: Add bus params for WCN6750
>>   ath11k: Add register access logic for WCN6750
>>   ath11k: Fetch device information via QMI for WCN6750
>>   ath11k: Add QMI changes for WCN6750
>>   ath11k: HAL changes to support WCN6750
>>   ath11k: Datapath changes to support WCN6750
>>   ath11k: Do not put HW in DBS mode for WCN6750
>>   ath11k: WMI changes to support WCN6750
>>   ath11k: Update WBM idle ring HP after FW mode on
>>   ath11k: Add support for WCN6750 device
>> ---
>> V5:
>>  - Rebased on ToT SHAID: 01be26cde012478db958d9bde530877c46031e76
>
> I already had v4 applied to the pending branch so I'm going to drop v5
> and look at v4 instead.

I see that you also added Rob's reviewed-by to patch 1. Please include
ALL changes in the changes list, otherwise review is difficult as we
don't know what you changed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
