Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123257E5A8E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjKHPzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 10:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKHPzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 10:55:20 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EEC1BC3
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 07:55:18 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 09660940089;
        Wed,  8 Nov 2023 15:55:15 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id AB3E713C2B0;
        Wed,  8 Nov 2023 07:55:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AB3E713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699458915;
        bh=dBWRk4Qek1T68soRNNrhc3O5Oyvof3OmDOorBkalVSg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b5PsXePctASxXihKb4eAgbbZeIrKHcJ2Zu3qifMXmdCCQ3gPu0vymwIwJx6qv+HCp
         QcLl+FEd7keO/ynVjdABG8AXQI/wHHD61wmDAgdCPuGFpJ2Inc962Mj3NUieueRM4C
         QE0ZhzDmK+V7NL5jmtQNsdUOE+LmsYze+tPCZvu0=
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Nicolai Stange <nicstange@gmail.com>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
 <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
 <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
 <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <dd6c7cf2-1955-4c70-fd2f-ffe2915111f4@candelatech.com>
Date:   Wed, 8 Nov 2023 07:55:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1699458916-35BXjypRjRPF
X-MDID-O: us5;at1;1699458916;35BXjypRjRPF;<greearb@candelatech.com>;ea9bd3aeb2d9945ea56a779a64e478e9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/23 7:44 AM, Johannes Berg wrote:
> On Wed, 2023-11-08 at 07:07 -0800, Ben Greear wrote:
>> On 11/8/23 2:31 AM, Johannes Berg wrote:
>>> On Tue, 2023-11-07 at 14:08 -0800, Ben Greear wrote:
>>>> Hello,
>>>>
>>>> I think this lockup is because iw is holding rtnl and wiphy mutex,
>>>> and is blocked waiting for debugfs to be closed.  Another 'cat'
>>>> program has debugfs file open, and is blocking on trying to acquire
>>>> wiphy mutex.
>>>>
>>>> I think we must not acquire wiphy mutex in debugfs methods, somehow,
>>>> to resolve this deadlock.  I do not know a safe way to do that.
>>>
>>> Hmm. I almost want to say "don't do that then", but I guess you're just
>>> randomly accessing debugfs files.
>>>
>>> I guess we can at least make the mutex acquisition in debugfs killable
>>> (or interruptible), so you can recover from this.
>>
>> If we can detect that the phy is going away in debugfs, then we could
>> return early before attempting the lock?  That would catch most things,
>> I guess,
>>
> 
> I don't think it would, it would still get locked on the mutex first.
> 
>>   but still a potential race since I guess we'd have to do that check
>> w/out locks.  Can we do a try-mutex-lock, if not acquired, return if wiphy-going-away,
>> else sleep a bit, try again?
> 
> That's kind of awful though? And it's not just the wiphy going away, a
> lot of the debugfs files can go away individually (per station, per
> link, per key even!).

 From the backtrace in the removal logic, it seems that something waits
for a debugfs file to be closed.  Maybe the logic attempting to get the
mutex in debugfs can check if file is waiting to be deleted,
combined with a try-mutex-lock logic, and bail out that way?

Thanks,
Ben

> 
> So really what you'd need is a debugfs-level infrastructure to "send a
> signal to all the things that are keeping the file open"? I suppose that
> could even be done, in theory, but not in wifi by itself.
> 
>> Or, can we grab rtnl before we even open the debugfs file, like in the .open method?
> 
> Not RTNL, but rather wiphy mutex, but the question still stands - but
> no, the open method has the same problem. If we acquire it there, it
> still goes through the proxy fops in debugfs, so it'll still wait for it
> to be done. It'll just shift the problem to another place.
> 
>> Or can we remove the debugfs files after rtnl but before we lock the wiphy mutex
>> in the destruction path?
> 
> For some maybe yes, but for a lot of them like link/sta/key removal not
> really.
> 
>> I have been running similar code for...like 15 years, and haven't seen this particular
>> deadlock before, so I think it is at least exacerbated by the locking changes.  Or maybe
>> I had particularly bad luck yesterday....
> 
> Oh, it almost certainly did get at least worse or perhaps introduced by
> (a) moving everything to a single lock and (b) moving debugfs file
> removal under the lock.
> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
