Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988D15144EA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356177AbiD2JAR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356176AbiD2JAP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 05:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9712C12DE;
        Fri, 29 Apr 2022 01:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50F5061F38;
        Fri, 29 Apr 2022 08:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911CDC385A4;
        Fri, 29 Apr 2022 08:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651222616;
        bh=6d6nB68RER/KEqDI3K1SemCxTzjGArif2Q6UeQcHHIQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QXxGlSu9zcBdhwptMLcVEmvmko0yj9jWMTqH4cxu9kIsYbRKFrqqbgC4WKDkVtK/S
         XGh1PFtogCFkALjsvOg2VfCcTfet+yV4L0eXc4aG1inaBot4ICnO5PJBUNy+DMZ483
         Xl00aHPtw1ylT45R0isLsJ1a9PbVRetf8GSnObAYHjYORdwg2CwHuGJ+vySU26n418
         8/+vRuzH7AAEu6kkU02AZb+qeZ36zuFIXmlHOhuaVZmCNkgWkJbmMuQPGfeAcO9ejI
         wQubVj1jzU2r0bF6Ey0sVN8f30udBXu+3Sjp0x7FWQdnWRC/v7dl3sTBhj7uR9RP/i
         h6fWTxWqWvMxw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 12/19] ath11k: Datapath changes to support WCN6750
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-13-git-send-email-quic_mpubbise@quicinc.com>
        <87ilqvgkgo.fsf@kernel.org>
        <bd125d43-2f0c-f791-7bbe-f4333896722b@quicinc.com>
        <878rrrgjpb.fsf@kernel.org>
        <d377a595-c816-30f6-0386-442e10a81b9e@quicinc.com>
Date:   Fri, 29 Apr 2022 11:56:51 +0300
In-Reply-To: <d377a595-c816-30f6-0386-442e10a81b9e@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 27 Apr 2022 11:26:41 +0530")
Message-ID: <87pml0e08c.fsf@kernel.org>
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

> On 4/27/2022 11:18 AM, Kalle Valo wrote:
>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>
>>> On 4/27/2022 11:02 AM, Kalle Valo wrote:
>>>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>>>
>>>>> HAL RX descriptor for WCN6750 is same as QCN9074, so use
>>>>> the DP APIs of QCN9074 for WCN6750. There is one change
>>>>> wrt to REO configuration though, REO configuration for
>>>>> WCN6750 is same as WCN6855; Therefore, use reo_setup()
>>>>> of WCN6855 for WCN6750.
>>>>>
>>>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>>>>
>>>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>>>> ---
>>>>>    drivers/net/wireless/ath/ath11k/core.c |  1 +
>>>>>    drivers/net/wireless/ath/ath11k/hw.c   | 31 +++++++++++++++++++++++++++++++
>>>>>    2 files changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>>>> index 347131a..f65347c 100644
>>>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>>>> @@ -458,6 +458,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>>>>    		.num_vdevs = 16 + 1,
>>>>>    		.num_peers = 512,
>>>>>    		.supports_suspend = false,
>>>>> +		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
>>>>
>>>> You mention nothing about this change in the commit log, I'll add that.
>>>>
>>>
>>> I did mention that "HAL RX descriptor for WCN6750 is same as QCN9074",
>>> you were looking at something specific?
>>
>> If I'm understanding correctly, by accident hal_desc_sz was not
>> initialised for qcn9074. If that's the case, it would be good to mention
>> that in the commit log.
>>
>
> If I understand your comment correctly, since HAL RX descriptor is
> related to data path, I thought of adding it as part of the data path
> patch.

Ah, now I understand better. I thought you were setting hal_desc_sz for
qcn9074, but now I checked it and you were actually setting it for
wcn6750. It would be better to set hal_desc_sz in patch "ath11k: Add HW
params for WCN6750".

Actually I would prefer that _all_ existing hw_params fields for wcn6750
would be initialised in patch "ath11k: Add HW params for WCN6750", even
if just set to null or invalid values. That way it's easier to track
that we are not missing any fields and makes it easier to review other
patches. But this is getting more to nitpicking so definitely not a hard
requirement.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
