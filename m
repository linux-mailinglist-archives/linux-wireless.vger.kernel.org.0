Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201AA45B5D7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 08:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbhKXHvT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 02:51:19 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:59091 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238609AbhKXHvS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 02:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637740089; x=1669276089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sf/A5/EKWlm3h8AkjLrcNw6H2o9Qz4tmsjQ0iHqtdbI=;
  b=DwfZxvPqFBlTwCY2eXCUVUSZYTfqmgmtveeVWaybxdl8RvpBzPgYFw/Z
   uV+A9WH4hwpx7tSzL4F7lAWKs4u9WHbiKVUA51u67aZiOzdJKCnn/3YYW
   wyWr0ox+s31YvDAbYtNmdAsG4tq8ejCAlPkNFu5Ymm21FAz0/Ml8Grwc7
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2021 23:48:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 23:48:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 23:48:08 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 23 Nov
 2021 23:48:06 -0800
Message-ID: <5929130a-7824-acd1-0182-da8fa304c576@quicinc.com>
Date:   Wed, 24 Nov 2021 15:48:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 2/3] ath11k: Refactor update channel list function
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     P Praneesh <ppranees@codeaurora.org>, <ath11k@lists.infradead.org>,
        <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        "Karthikeyan Periyasamy" <periyasa@codeaurora.org>
References: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
 <1634906227-22028-3-git-send-email-ppranees@codeaurora.org>
 <0fb4fec3-4fd0-6e92-b1d9-5bffc0958e97@quicinc.com>
 <87pmqq6lyx.fsf@codeaurora.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87pmqq6lyx.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/24/2021 3:39 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> On 10/22/2021 8:37 PM, P Praneesh wrote:
>>
>> ...
>>
>>> ---
>>> ...
>>> -			ch->maxpower = channel->max_power * 2;
>>> -			ch->maxregpower = channel->max_reg_power * 2;
>>> -			ch->antennamax = channel->max_antenna_gain * 2;
>>> ...
>>>    +int ath11k_wmi_update_scan_chan_list(struct ath11k *ar,
>>> +				     struct scan_req_params *arg)
>>> ...
>>> +			ch->maxpower = channel->max_power;
>>> +			ch->maxregpower = channel->max_reg_power;
>>> +			ch->antennamax = channel->max_antenna_gain;
>>> +
>>> ...
>> I see it also have another patch to remove the "*2" for power.
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=9212c1b9e80a869e732769a4fe7f82d392b219be
>>
>> ath11k: send proper txpower and maxregpower values to firmware.
>>
>> so are you the same reason to remove "*2" ?
> I'm not quite getting what you are saying, can you elaborate more? Did
> this patch break something?

Oh. Not see break anything.

I just want to know why remove the "*2". Did you see any issue if NOT 
remove "*2"?

>
