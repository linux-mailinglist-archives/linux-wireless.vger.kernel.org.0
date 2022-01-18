Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A140491907
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 03:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbiARCtS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 21:49:18 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:6157 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346273AbiARCnW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 21:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642473802; x=1674009802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PrVHd6y6YErrdCOb2kmQgfctxSWLBf4UHgiQ5pCMqD4=;
  b=MP1uvhvLp6whWaFbdFUNZdZNuP/tMn9bew6wTStrO88jODgs2yfY3aXR
   ylvlYbYAdqlObRcxnTrgcRxhHNEOqbtpQmB4A1RYCRM6SmAweMDKqVQKW
   eCXjnKvWuMGtPrK8qZIODF7GndOr7fHz9FIb2DenSD5lZLdzLK5pIfFzq
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Jan 2022 18:43:21 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 18:43:21 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 17 Jan 2022 18:43:20 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 17 Jan
 2022 18:43:19 -0800
Message-ID: <6ac56fa1-b369-831f-2b1d-9a188b7cbacc@quicinc.com>
Date:   Tue, 18 Jan 2022 10:43:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] ath11k: set WMI_PEER_40MHZ while peer assoc for 6 GHz
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220113023145.14292-1-quic_wgong@quicinc.com>
 <164242492251.16331.2627237965817574376.kvalo@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <164242492251.16331.2627237965817574376.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/17/2022 9:08 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> wrote:
>
>> When station connect to AP of 6 GHz with 40 MHz bandwidth, the TX is
>> always stay 20 MHz, it is because the flag WMI_PEER_40MHZ is not set
>> while peer assoc. Add the flag if remote peer is 40 MHz bandwidth.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Fixes tag
>
>    Fixes: 2cdf2b3cdf54 ("ath11k: add 6ghz params in peer assoc command")
>
> has these problem(s):
>
>    - Target SHA1 does not exist
>
> Did you mean:
>
> Fixes: c3a7d7eb4c98 ("ath11k: add 6 GHz params in peer assoc command")

Thanks.

yes, it is.

I see you have already changed it in master-pending.

