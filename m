Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4366A5110A7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 07:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357930AbiD0FwF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbiD0FwE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E421804;
        Tue, 26 Apr 2022 22:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC6061676;
        Wed, 27 Apr 2022 05:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2F3C385A7;
        Wed, 27 Apr 2022 05:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651038534;
        bh=YJikARyQpyzsiI/zGqFigsGB6nxfUX79srTEf7Pf2dw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WM+i3ZIfB79+TxqsRBjfVDlwsn9rKHjGGwFnRWuGqAwLjO9hiRrmyZGm2/N8MaO5b
         Ve3R4ZlgvJ6QAsL3P9pGN1Yvuy9JIcix4tlYXpaq8HsXIlqriGpNHQC/EiDnm239WQ
         QB6x2bkT2MGJzh7jjKIas0XRz+e9sX3UEyhbHl7Yte14C82mufA4mnPgRtaaUcqd9T
         gu0nbN/466m2DaBEPbTsnxQGOQ7m/QMSyb/wjzwGekXkCTwI6/eOf2Sj6cUcRP/QxF
         HmjLbe/bMt8C5k5d25Z1yLeojGhx1MI2sto14mZ/UisUzZsJ+kmod9EPLJ3JeG6zFV
         yj0sZI7tOWw9A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 12/19] ath11k: Datapath changes to support WCN6750
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-13-git-send-email-quic_mpubbise@quicinc.com>
        <87ilqvgkgo.fsf@kernel.org>
        <bd125d43-2f0c-f791-7bbe-f4333896722b@quicinc.com>
Date:   Wed, 27 Apr 2022 08:48:48 +0300
In-Reply-To: <bd125d43-2f0c-f791-7bbe-f4333896722b@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 27 Apr 2022 11:07:17 +0530")
Message-ID: <878rrrgjpb.fsf@kernel.org>
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

> On 4/27/2022 11:02 AM, Kalle Valo wrote:
>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>
>>> HAL RX descriptor for WCN6750 is same as QCN9074, so use
>>> the DP APIs of QCN9074 for WCN6750. There is one change
>>> wrt to REO configuration though, REO configuration for
>>> WCN6750 is same as WCN6855; Therefore, use reo_setup()
>>> of WCN6855 for WCN6750.
>>>
>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>> ---
>>>   drivers/net/wireless/ath/ath11k/core.c |  1 +
>>>   drivers/net/wireless/ath/ath11k/hw.c   | 31 +++++++++++++++++++++++++++++++
>>>   2 files changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>> index 347131a..f65347c 100644
>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>> @@ -458,6 +458,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>>   		.num_vdevs = 16 + 1,
>>>   		.num_peers = 512,
>>>   		.supports_suspend = false,
>>> +		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
>>
>> You mention nothing about this change in the commit log, I'll add that.
>>
>
> I did mention that "HAL RX descriptor for WCN6750 is same as QCN9074",
> you were looking at something specific?

If I'm understanding correctly, by accident hal_desc_sz was not
initialised for qcn9074. If that's the case, it would be good to mention
that in the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
