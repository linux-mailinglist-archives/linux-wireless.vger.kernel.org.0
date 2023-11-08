Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9827E59AD
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 16:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjKHPHi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 10:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKHPHi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 10:07:38 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19D91BE4
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 07:07:35 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D1A808007D;
        Wed,  8 Nov 2023 15:07:33 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 67F6B13C2B0;
        Wed,  8 Nov 2023 07:07:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 67F6B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699456045;
        bh=2oJXfmsPoHxDXe18vjZYW3/oe7Qrx5qjrMnvAYYNz9c=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=PjapBVTfy3ZdyWmVC3lOj8fn0av6+ItySx/r6NPQSuwISE7yoEs1xyftbFMC08y+/
         qM6VFO7Yy7/nAm7mcTA3H4/nJ8zuHvRjO0ldwCUTp5lNo2QajWrjpoDYSN+/wdONt3
         NykDkfNhgYdqbai5yWDKxmvaaXIzD77QRYU1C6H0=
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
 <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
Date:   Wed, 8 Nov 2023 07:07:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1699456054-ISBOetZFELcU
X-MDID-O: us5;at1;1699456054;ISBOetZFELcU;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/23 2:31 AM, Johannes Berg wrote:
> On Tue, 2023-11-07 at 14:08 -0800, Ben Greear wrote:
>> Hello,
>>
>> I think this lockup is because iw is holding rtnl and wiphy mutex,
>> and is blocked waiting for debugfs to be closed.  Another 'cat'
>> program has debugfs file open, and is blocking on trying to acquire
>> wiphy mutex.
>>
>> I think we must not acquire wiphy mutex in debugfs methods, somehow,
>> to resolve this deadlock.  I do not know a safe way to do that.
> 
> Hmm. I almost want to say "don't do that then", but I guess you're just
> randomly accessing debugfs files.
> 
> I guess we can at least make the mutex acquisition in debugfs killable
> (or interruptible), so you can recover from this.

If we can detect that the phy is going away in debugfs, then we could
return early before attempting the lock?  That would catch most things,
I guess, but still a potential race since I guess we'd have to do that check
w/out locks.  Can we do a try-mutex-lock, if not acquired, return if wiphy-going-away,
else sleep a bit, try again?

> 
> But fundamentally this is probably not really even a new issue.
> 
> I don't know how to interrupt a specific task that's stuck in a specific
> debugfs file though, e.g. when removing them.

Or, can we grab rtnl before we even open the debugfs file, like in the .open method?

Or can we remove the debugfs files after rtnl but before we lock the wiphy mutex
in the destruction path?

I have been running similar code for...like 15 years, and haven't seen this particular
deadlock before, so I think it is at least exacerbated by the locking changes.  Or maybe
I had particularly bad luck yesterday....

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
