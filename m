Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2675110B6
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 07:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357885AbiD0F76 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiD0F75 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:59:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EA32B1B4;
        Tue, 26 Apr 2022 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651039007; x=1682575007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g7QfMsSD24xuQB98/BEJJRRc0HDLtJCNhPGgrCcWoT4=;
  b=t20+tASFPxlTPJkLiVD+FTOugpGIGbngoyUK/ytXJVJkFdRmbubGvgAo
   1BnYpUnb2IVDEYX7Cy3OTFVZNaBDftgaRmxT2pUG31nesXV6jvMAgjs9q
   cdGelvTxzqYwJNXTkTjxb4a271EXWdtzut6tOmR7lonuRnymxWAvJuoFI
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Apr 2022 22:56:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 22:56:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 22:56:47 -0700
Received: from [10.50.15.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 22:56:44 -0700
Message-ID: <d377a595-c816-30f6-0386-442e10a81b9e@quicinc.com>
Date:   Wed, 27 Apr 2022 11:26:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 12/19] ath11k: Datapath changes to support WCN6750
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
 <1642337235-8618-13-git-send-email-quic_mpubbise@quicinc.com>
 <87ilqvgkgo.fsf@kernel.org>
 <bd125d43-2f0c-f791-7bbe-f4333896722b@quicinc.com>
 <878rrrgjpb.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <878rrrgjpb.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/27/2022 11:18 AM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> On 4/27/2022 11:02 AM, Kalle Valo wrote:
>>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>>
>>>> HAL RX descriptor for WCN6750 is same as QCN9074, so use
>>>> the DP APIs of QCN9074 for WCN6750. There is one change
>>>> wrt to REO configuration though, REO configuration for
>>>> WCN6750 is same as WCN6855; Therefore, use reo_setup()
>>>> of WCN6855 for WCN6750.
>>>>
>>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>>> ---
>>>>    drivers/net/wireless/ath/ath11k/core.c |  1 +
>>>>    drivers/net/wireless/ath/ath11k/hw.c   | 31 +++++++++++++++++++++++++++++++
>>>>    2 files changed, 32 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>>> index 347131a..f65347c 100644
>>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>>> @@ -458,6 +458,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>>>>    		.num_vdevs = 16 + 1,
>>>>    		.num_peers = 512,
>>>>    		.supports_suspend = false,
>>>> +		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
>>>
>>> You mention nothing about this change in the commit log, I'll add that.
>>>
>>
>> I did mention that "HAL RX descriptor for WCN6750 is same as QCN9074",
>> you were looking at something specific?
> 
> If I'm understanding correctly, by accident hal_desc_sz was not
> initialised for qcn9074. If that's the case, it would be good to mention
> that in the commit log.
> 

If I understand your comment correctly, since HAL RX descriptor is 
related to data path, I thought of adding it as part of the data path
patch.

Thanks,
Manikanta
