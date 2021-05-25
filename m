Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE70438FBE9
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhEYHmZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 03:42:25 -0400
Received: from saphodev.broadcom.com ([192.19.11.229]:55556 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231689AbhEYHmX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 03:42:23 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 927253CB60;
        Tue, 25 May 2021 00:40:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 927253CB60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1621928453;
        bh=7xm/RkE6Ce5AbMaS15J3ThCuCwbe8vxsawPWO2gXNn0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QUmQ9sBDcOzf+JmXN7XEgl0Ohe23IKCsAt8rrSlthrzQogmRfkE5TF4yqRGv9DSLF
         fM4xqPEVHvZ0ni/MOqfuSBaF6r7HuZ+Iq9SOkHiO2MomEZXShmExOKBfVmO/Gonwbf
         /u6PNniPuGQQ6uQNu2SHi5Gvm7tHzKSCLgO/LcVU=
Received: from [10.230.41.88] (unknown [10.230.41.88])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 6223A1874BE;
        Tue, 25 May 2021 00:40:52 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 5.4 39/52] brcmfmac: properly check for bus
 register errors
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
References: <20210524144903.2498518-1-sashal@kernel.org>
 <20210524144903.2498518-39-sashal@kernel.org>
 <437445ee-a360-597f-f058-3b913984e064@broadcom.com>
 <YKycgrI+zh4seh7U@kroah.com>
 <81b5dc11-4dfe-76d6-f822-0adcfb3a9e30@broadcom.com>
 <b074fa60-f184-ff21-e3e1-c64d7b848c27@broadcom.com>
 <YKymp3lo1XcIJYGB@kroah.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <41690617-ea4f-f6d1-977c-dc995c0773dc@broadcom.com>
Date:   Tue, 25 May 2021 09:40:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKymp3lo1XcIJYGB@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/25/2021 9:26 AM, Greg Kroah-Hartman wrote:
> On Tue, May 25, 2021 at 09:23:41AM +0200, Arend van Spriel wrote:
>> Resending without disclaimer
>>
>> On 5/25/2021 9:04 AM, Arend Van Spriel wrote:
>>>
>>>
>>> On 5/25/2021 8:43 AM, Greg Kroah-Hartman wrote:
>>>> On Tue, May 25, 2021 at 08:38:34AM +0200, Arend van Spriel wrote:
>>>>> On 5/24/2021 4:48 PM, Sasha Levin wrote:
>>>>>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>
>>>>>> [ Upstream commit 419b4a142a7ece36cebcd434f8ce2af59ef94b85 ]
>>>>>>
>>>>>> The brcmfmac driver ignores any errors on initialization with the
>>>>>> different busses by deferring the initialization to a workqueue and
>>>>>> ignoring all possible errors that might happen.  Fix up all of this by
>>>>>> only allowing the module to load if all bus registering
>>>>>> worked properly.
>>>>>
>>>>> Hi Greg,
>>>>>
>>>>> Saw this one flying by for stable kernel. Actually the first
>>>>> time I saw this
>>>>> patch, because I don't follow LKML as much as linux-wireless.
>>>>> The patch is
>>>>> fine, but wanted to give some context on the workqueue approach. It was
>>>>> there for historic reasons. Back then we had the UMH to provide firmware
>>>>> loading and because we request firmware during driver probe we
>>>>> could cause
>>>>> kernel boot to show significant delay when driver was built-in.
>>>>> Hence the
>>>>> workqueue which allowed kernel boot to proceed and driver probe
>>>>> was running
>>>>> in another thread context. These days we have direct firmware
>>>>> loading from
>>>>> the kernel and brcmfmac uses the asynchronous firmware loading
>>>>> API so there
>>>>> is indeed no longer a need for the workqueue.
>>>>>
>>>>> Just for my understanding could you explain the motivation behind this
>>>>> change. In the preceding revert patch I saw this remark:
>>>>>
>>>>> """
>>>>> The original commit here did nothing to actually help if usb_register()
>>>>> failed, so it gives a "false sense of security" when there is none.  The
>>>>> correct solution is to correctly unwind from this error.
>>>>> """
>>>>>
>>>>> Does this mean the patch is addressing some security issue. Before your
>>>>> patch the module would remain loaded despite a bus register
>>>>> failure. I guess
>>>>> there is a story behind this that I am curious about.
>>>>
>>>> The module would remain loaded, yes, but nothing would work, and so no
>>>> one would have any idea that something went wrong.  The original commit
>>>> was wrong, it did not actually solve anything.
>>>
>>> Agree.
>>>
>>>> This commit properly propagates any error that happens back to the user,
>>>> like any other module being loaded.
>>>
>>> I understand, but this might cause a regression for the user. For
>>> instance if the usb_register() fails, but the other driver registrations
>>> succeed and the user has a wireless PCIe device. Before this change the
>>> user would have a functioning wifi device, but with this change it does
>>> not?
> 
> If registering one of those other busses fails, you have major system
> problems that need to be resolved and lots of other things will also
> break.

Right.

> You shouldn't just "eat error messages" and ignore them, as that's what
> is what was happening here, you could have had errors and never knew it.

As said earlier I agree with the patch. I just thought I might learn 
something today, because there was more to it than I could find in the 
commit message. :-p

Regards,
Arend
