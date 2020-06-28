Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9120C93D
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2020 19:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgF1RZh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jun 2020 13:25:37 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:44860 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1RZg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jun 2020 13:25:36 -0400
Received: from [192.168.254.4] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 490EC13C2B1;
        Sun, 28 Jun 2020 10:25:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 490EC13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1593365136;
        bh=RSXDKa6OlffLkH4jXYtrInoE8VFv1UeIibxEquQKUVA=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=g5yBfQ3ohwywTjkcsrBgigTKa6J72KYWtBjvZDS4YyP7bp8kbygZoAzHnCMfxz+cO
         llUWvfuV1dqO3UyY+6SjFtEpsdO3Hl2U7m7wigIRXPQ6jch1/sg1cuXab0u6MXuAVf
         hbGGVuNqEWlDTCBP0oFHUUnJ1xBofvFYkPAi2AVc=
Subject: Re: [PATCH] ath10k: Add history for tracking certain events
To:     Rakesh Pillai <pillair@codeaurora.org>, ath10k@lists.infradead.org
References: <1593238973-23237-1-git-send-email-pillair@codeaurora.org>
 <926301ed-e27f-0d8f-0177-6484bfffa40c@candelatech.com>
 <000201d64d0a$b3d39d10$1b7ad730$@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <859a8ffb-6108-81f3-b379-4a0adfa064fe@candelatech.com>
Date:   Sun, 28 Jun 2020 10:25:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <000201d64d0a$b3d39d10$1b7ad730$@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 06/27/2020 10:12 PM, Rakesh Pillai wrote:
>
>
>> -----Original Message-----
>> From: Ben Greear <greearb@candelatech.com>
>> Sent: Saturday, June 27, 2020 8:58 PM
>> To: Rakesh Pillai <pillair@codeaurora.org>; ath10k@lists.infradead.org
>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] ath10k: Add history for tracking certain events
>>
>>
>>
>> On 06/26/2020 11:22 PM, Rakesh Pillai wrote:
>>> For debugging many issues, a history of the
>>> below mentioned events can help get an idea
>>> of what exactly was going on just before any
>>> issue occurred in the system. These event
>>> history will be collected only when the host
>>> driver is run in debug mode (i.e. with the
>>> config ATH10K_DEBUG enabled).
>>
>> This should be disabled by default unless user specifically pokes some
>> debugfs
>> value to turn it on so that it does not impact performance.
>
> Hi Ben,
> This history is enabled only if the user compiles the kernel with
> ATH10K_DEBUG.
> Making it runtime, adds a lot of "if" conditions for this history record.
> Do you suggest to add support to enable/disable it runtime even in
> ATH10K_DEBUG ?

Yes, because you are adding lots of locks/unlocks.  That is way more expensive
than an if statement.  You can add an 'unlikely' to the if check as well, so
compiler will optimize for this feature not being enabled.

Thanks,
Ben

>
>>
>> Thanks,
>> Ben
>>
>>>
>>> Add history for tracking the below events
>>> - register read
>>> - register write
>>> - IRQ trigger
>>> - IRQ Enable
>>> - IRQ Disable
>>> - NAPI poll
>>> - CE service
>>> - WMI cmd
>>> - WMI event
>>> - WMI tx completion
>>>
>>> This will help in debugging any crash or any
>>> improper behaviour.
>>
>>
>> --
>> Ben Greear <greearb@candelatech.com>
>> Candela Technologies Inc  http://www.candelatech.com
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
