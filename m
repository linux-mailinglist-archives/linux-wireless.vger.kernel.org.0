Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E11251466F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357301AbiD2KUi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357296AbiD2KUh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 06:20:37 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3773AC666B;
        Fri, 29 Apr 2022 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651227440; x=1682763440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jV8p+d24/N7KDNyhAMbE3UbsM26Maj+9OmdbzkL2JsM=;
  b=mR0jCrWT5TOdK7MQ/N8oE1MeKBalrFgLOeb5kwLnJj78RQvyctO4LGWs
   fViRoVzdyaOWj3jKBhOTgffRM4RiPlJmb4rAueywa85/Vfc6DRrDOE+fg
   UWskIQjC0DgDm4QIExQBrHlEKR7t9TDZp7SN30Zp1hVYPSawIsMEot7qa
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Apr 2022 03:17:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 03:17:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 03:17:19 -0700
Received: from [10.50.21.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 29 Apr
 2022 03:17:16 -0700
Message-ID: <ab4e4298-a2d6-d66b-f90f-4282dd3f1454@quicinc.com>
Date:   Fri, 29 Apr 2022 15:47:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 4/9] ath11k: Add register access logic for WCN6750
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
References: <20220427111848.9257-1-quic_mpubbise@quicinc.com>
 <20220427111848.9257-5-quic_mpubbise@quicinc.com> <87pml2g1c7.fsf@kernel.org>
 <6e607455-e42a-a591-f58b-b3b2c83ea2cc@quicinc.com>
 <87h76cdxn2.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87h76cdxn2.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/29/2022 3:22 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>>>> @@ -704,11 +718,26 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>>>>    {
>>>>    	struct ath11k_base *ab;
>>>>    	struct ath11k_pci *ab_pci;
>>>> +	const struct ath11k_bus_params *bus_params;
>>>>    	u32 soc_hw_version_major, soc_hw_version_minor, addr;
>>>>    	int ret;
>>>>    +	switch (pci_dev->device) {
>>>> +	case QCA6390_DEVICE_ID:
>>>> +	case WCN6855_DEVICE_ID:
>>>> +		bus_params = &ath11k_pci_bus_params_qca6390;
>>>> +		break;
>>>> +	case QCN9074_DEVICE_ID:
>>>> +		bus_params = &ath11k_pci_bus_params_qcn9074;
>>>> +		break;
>>>
>>> Now you are making bus_params device specific, that's not really the
>>> point of bus params. They are supposed to be _bus_ specific parameters.
>>>
>>> Can't you use hw_params like I mentioned in the review?
>>>
>>
>> Even without this patch, as of today, bus_params is already device
>> specific with QCN9074 changing the static_window_map in bus_params to
>> true in ath11k_pci_probe().
> 
> Yeah, that's a mistake which slipped in review.
> 
>> And if we have to move these device specific bus_params to hw_parmas,
>> then bus_params can be pretty much removed completely with the changes
>> that WCN6750 bring in. Any thoughts on this? I can make the changes
>> that can get along with WCN6750 series.
> 
> My original idea with bus_params was to there are bus specific
> parameters and that way we could simplify hw_params. Clearly that's not
> working and I agree with you, bus_params should be removed. So it would
> be good if you can do that in the next patchset.
> 

Sure Kalle, pls ignore V6 for now, I'll send out V7 with the bus_params 
completely removed.

Thanks,
Manikanta
