Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A755524C4DD
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHTRyA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 13:54:00 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:42092 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHTRyA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 13:54:00 -0400
Received: from [192.168.254.6] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 82E3F13C2B4;
        Thu, 20 Aug 2020 10:53:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 82E3F13C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1597946037;
        bh=xWR1uMXAzDeVjdUtBaw86VomjagIw+Si6RkL4cZ7xiU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RizPuKDeh7PxIq7TPAbJ/4W36aDq40reVnJZ6pKAgrY3boNKbLbhFU639cE67rLgz
         dN8l6iX8PWI4mb4mwB1cFtSj00YoFfoYAVM9d6AuuUSS3I+YEK1CCS109qgt3KzMj6
         7WBrmHK3h4UruZgIqEekr7KK2cNcAmrNE+7xARPM=
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Wen Gong <wgong@codeaurora.org>, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
References: <20200214035555.24762-1-wgong@codeaurora.org>
 <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
 <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org>
 <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
 <dcc45384935dca14ac6ab31ec1123414@codeaurora.org>
 <CABPxzYLu_81h+aWWeNKRyH=CJ=+waB3zmT41BTZ9Mo733PqErQ@mail.gmail.com>
 <acb2bd58-2f95-e09c-9575-b45c0e2aeb70@candelatech.com>
 <CABPxzY+tPos8ByT76hU1ngoxwYcBHaRpFMCKGQJcc_ssoqGNSw@mail.gmail.com>
 <47c1b1e0-afc4-b9b4-5fc0-4636d8b3b981@candelatech.com>
 <CABPxzYLD-M5wpWF6r=K=8YTosSfjctmaaBPCyBP72q-mY0PTcw@mail.gmail.com>
 <CABPxzYLOZf9Fu5O3Rt_mVcXeFLuuFAsqyvd7jiCVvJ0x2BN-+g@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <dd8cb5db-f164-c235-1f39-cd78ea97f8be@candelatech.com>
Date:   Thu, 20 Aug 2020 10:53:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABPxzYLOZf9Fu5O3Rt_mVcXeFLuuFAsqyvd7jiCVvJ0x2BN-+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/20/20 10:42 AM, Krishna Chaitanya wrote:
> On Thu, Aug 20, 2020 at 11:11 PM Krishna Chaitanya
> <chaitanya.mgit@gmail.com> wrote:
>>
>> On Thu, Aug 20, 2020 at 10:38 PM Ben Greear <greearb@candelatech.com> wrote:
>>>
>>> On 8/20/20 10:00 AM, Krishna Chaitanya wrote:
>>>> On Thu, Aug 20, 2020 at 10:02 PM Ben Greear <greearb@candelatech.com> wrote:
>>>>>
>>>>> On 8/20/20 9:08 AM, Krishna Chaitanya wrote:
>>>>>> On Thu, Aug 20, 2020 at 8:07 PM Wen Gong <wgong@codeaurora.org> wrote:
>>>>>>>
>>>>>>> On 2020-08-20 18:52, Krishna Chaitanya wrote:
>>>>>>>> On Thu, Aug 20, 2020 at 3:45 PM Wen Gong <wgong@codeaurora.org> wrote:
>>>>>>>>>
>>>>>>>>> On 2020-08-20 17:19, Krishna Chaitanya wrote:
>>>>>>> ...
>>>>>>>>>>> I'm not really convinced that this is the right fix, but I'm no NAPI
>>>>>>>>>>> expert. Can anyone else help?
>>>>>>>>>> Calling napi_disable() twice can lead to hangs, but moving NAPI from
>>>>>>>>>> start/stop to
>>>>>>>>>> the probe isn't the right approach as the datapath is tied to
>>>>>>>>>> start/stop.
>>>>>>>>>>
>>>>>>>>>> Maybe check the state of NAPI before disable?
>>>>>>>>>>
>>>>>>>>>>     if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
>>>>>>>>>>      napi_disable(&ar->napi)
>>>>>>>>>> or maintain napi_state like this
>>>>>>>>>> https://patchwork.kernel.org/patch/10249365/
>>>>>>>>> it is better to use above link's patch.
>>>>>>>>> napi.state is controlled by napi API, it is better ath10k not know it.
>>>>>>>> Sure, but IMHO just canceling the async rx work should solve the issue.
>>>>>>> Oh no, canceling the async rx work will not solve this issue, rx worker
>>>>>>> ath10k_rx_indication_async_work call napi_schedule, after napi_complete,
>>>>>>> the NAPI_STATE_SCHED will clear.
>>>>>>> The issue of this patch is because 2 thread called to hif_stop and
>>>>>>> NAPI_STATE_SCHED not clear.
>>>>>> That fix is still valid and good to have.
>>>>>>
>>>>>> ndev_stop being called twice is typical scenarios (stop vs rmmod), so
>>>>>>     just checking the netdev_flags for IFF_UP and returning from hif_Stop
>>>>>> should suffice, no?
>>>>>
>>>>> My approach to fix this problem was to add a boolean in ath10k as to whether
>>>>> it had napi enabled or not, and then check that before trying to enable/disable
>>>>> it again.  Seems to work fine, and cleaner in my mind than checking internal
>>>>> napi flags.
>>>> A much simpler approach is just to check for IFF_UP and skip NAPI (and others)
>>>> in the hif_stop no? (provided proper RTNL locking is done if hif_stop
>>>> is being called
>>>> internally as well).
>>>>
>>>
>>> I'm not sure, but I think the driver should be internally consistent and not
>>> spend a lot of time trying to guess about interactions with objects higher
>>> in the stack.
>> Fair enough, the network interface state is a basic thing controlled
>> by the driver,
>> so, should be okay to use. Anyways, the in-driver approach has more control.
>>>
>>> Here is my original patch to fix this, it is not complex.
>>>
>>> https://patchwork.kernel.org/patch/10249363/
>> Sure, I have shared your patch above :).
> Sent a bit early, any idea why this wasn't upstreamed earlier?

No, one comment from Michal indicated maybe there were more problems lurking
in this area, but he seemed to be OK with the patch over all.  After that,
it was just ignored.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
