Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6119324CAF9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 04:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUCp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 22:45:57 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:40011 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgHUCp4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 22:45:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597977955; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=r0esNbindDVraqv5hwijMp4mn1dwY1FlZ/2BHocIwsk=;
 b=W00IYFgsUFqiER2yWks4MR7g97+LEAk8nSrUx6lO+ql1Mcwwo1UgZFRpmjgTh1kBz9cHE2oB
 i2R/Bj2fiqMzGxdDLK+MPSGWFRHqO/V9GhaPzu2Ih4TFWoN/FGD5EilWmzk9yHk6UZxL5Wqm
 gwIso85dBzb1u7ghMMQEoalZELE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f3f35428e83ed46630c834c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 02:45:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 973EDC43391; Fri, 21 Aug 2020 02:45:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C894C433CA;
        Fri, 21 Aug 2020 02:45:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Aug 2020 10:45:20 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
In-Reply-To: <c69abe52-ccd1-ac73-8691-d87f5ed8be76@candelatech.com>
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
 <dd8cb5db-f164-c235-1f39-cd78ea97f8be@candelatech.com>
 <CABPxzY+uyy_Yc0mHb7sJGxxUE5__Z8SpywodAv2YCM8D89waHw@mail.gmail.com>
 <c69abe52-ccd1-ac73-8691-d87f5ed8be76@candelatech.com>
Message-ID: <f58ad98479e54a5bbe8b6561563d8cc7@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-21 04:59, Ben Greear wrote:
> On 8/20/20 1:15 PM, Krishna Chaitanya wrote:
>> On Thu, Aug 20, 2020 at 11:23 PM Ben Greear <greearb@candelatech.com> 
>> wrote:
>>> 
>>> On 8/20/20 10:42 AM, Krishna Chaitanya wrote:
>>>> On Thu, Aug 20, 2020 at 11:11 PM Krishna Chaitanya
>>>> <chaitanya.mgit@gmail.com> wrote:
>>>>> 
>>>>> On Thu, Aug 20, 2020 at 10:38 PM Ben Greear 
>>>>> <greearb@candelatech.com> wrote:
>>>>>> 
>>>>>> On 8/20/20 10:00 AM, Krishna Chaitanya wrote:
>>>>>>> On Thu, Aug 20, 2020 at 10:02 PM Ben Greear 
>>>>>>> <greearb@candelatech.com> wrote:
>>>>>>>> 
>>>>>>>> On 8/20/20 9:08 AM, Krishna Chaitanya wrote:
>>>>>>>>> On Thu, Aug 20, 2020 at 8:07 PM Wen Gong <wgong@codeaurora.org> 
>>>>>>>>> wrote:
>>>>>>>>>> 
>>>>>>>>>> On 2020-08-20 18:52, Krishna Chaitanya wrote:
>>>>>>>>>>> On Thu, Aug 20, 2020 at 3:45 PM Wen Gong 
>>>>>>>>>>> <wgong@codeaurora.org> wrote:
>>>>>>>>>>>> 
>>>>>>>>>>>> On 2020-08-20 17:19, Krishna Chaitanya wrote:
>>>>>>>>>> ...
>>>>>>>>>>>>>> I'm not really convinced that this is the right fix, but 
>>>>>>>>>>>>>> I'm no NAPI
>>>>>>>>>>>>>> expert. Can anyone else help?
>>>>>>>>>>>>> Calling napi_disable() twice can lead to hangs, but moving 
>>>>>>>>>>>>> NAPI from
>>>>>>>>>>>>> start/stop to
>>>>>>>>>>>>> the probe isn't the right approach as the datapath is tied 
>>>>>>>>>>>>> to
>>>>>>>>>>>>> start/stop.
>>>>>>>>>>>>> 
>>>>>>>>>>>>> Maybe check the state of NAPI before disable?
>>>>>>>>>>>>> 
>>>>>>>>>>>>>      if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
>>>>>>>>>>>>>       napi_disable(&ar->napi)
>>>>>>>>>>>>> or maintain napi_state like this
>>>>>>>>>>>>> https://patchwork.kernel.org/patch/10249365/
>>>>>>>>>>>> it is better to use above link's patch.
>>>>>>>>>>>> napi.state is controlled by napi API, it is better ath10k 
>>>>>>>>>>>> not know it.
>>>>>>>>>>> Sure, but IMHO just canceling the async rx work should solve 
>>>>>>>>>>> the issue.
>>>>>>>>>> Oh no, canceling the async rx work will not solve this issue, 
>>>>>>>>>> rx worker
>>>>>>>>>> ath10k_rx_indication_async_work call napi_schedule, after 
>>>>>>>>>> napi_complete,
>>>>>>>>>> the NAPI_STATE_SCHED will clear.
>>>>>>>>>> The issue of this patch is because 2 thread called to hif_stop 
>>>>>>>>>> and
>>>>>>>>>> NAPI_STATE_SCHED not clear.
>>>>>>>>> That fix is still valid and good to have.
>>>>>>>>> 
>>>>>>>>> ndev_stop being called twice is typical scenarios (stop vs 
>>>>>>>>> rmmod), so
>>>>>>>>>      just checking the netdev_flags for IFF_UP and returning 
>>>>>>>>> from hif_Stop
>>>>>>>>> should suffice, no?
>>>>>>>> 
>>>>>>>> My approach to fix this problem was to add a boolean in ath10k 
>>>>>>>> as to whether
>>>>>>>> it had napi enabled or not, and then check that before trying to 
>>>>>>>> enable/disable
>>>>>>>> it again.  Seems to work fine, and cleaner in my mind than 
>>>>>>>> checking internal
>>>>>>>> napi flags.
>>>>>>> A much simpler approach is just to check for IFF_UP and skip NAPI 
>>>>>>> (and others)
>>>>>>> in the hif_stop no? (provided proper RTNL locking is done if 
>>>>>>> hif_stop
>>>>>>> is being called
>>>>>>> internally as well).
>>>>>>> 
>>>>>> 
>>>>>> I'm not sure, but I think the driver should be internally 
>>>>>> consistent and not
>>>>>> spend a lot of time trying to guess about interactions with 
>>>>>> objects higher
>>>>>> in the stack.
>>>>> Fair enough, the network interface state is a basic thing 
>>>>> controlled
>>>>> by the driver,
>>>>> so, should be okay to use. Anyways, the in-driver approach has more 
>>>>> control.
>>>>>> 
>>>>>> Here is my original patch to fix this, it is not complex.
>>>>>> 
>>>>>> https://patchwork.kernel.org/patch/10249363/
>>>>> Sure, I have shared your patch above :).
>>>> Sent a bit early, any idea why this wasn't upstreamed earlier?
>>> 
>>> No, one comment from Michal indicated maybe there were more problems 
>>> lurking
>>> in this area, but he seemed to be OK with the patch over all.  After 
>>> that,
>>> it was just ignored.
>>> 
>> Now might be a good time to push for it :)
>> 
> 
> It is generally a waste of time in my experience.  Kalle is the
> maintainer and should
> be seeing any of this he cares to see.  If he likes the patch, he can
> apply it or
> something similar.  If you have a reproducible test case, see if the 
> patch fixes
> things, that might help it be accepted.
I have 2 cmd, each one can reproduce the hang.
echo soft > 
/sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;sleep 
0.05;ifconfig wlan0 down
echo soft > 
/sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;rmmod 
ath10k_sdio
and with the my patch, it fix the hang. Change of my patch is similar 
with your
patch(https://patchwork.kernel.org/patch/10249365/), so it should also 
fix the hang with your patch.
> 
> Thanks,
> Ben
