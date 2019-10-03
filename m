Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45757CADA2
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2019 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfJCRvY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Oct 2019 13:51:24 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:39146 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbfJCRvY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Oct 2019 13:51:24 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 87449103B;
        Thu,  3 Oct 2019 10:51:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 87449103B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1570125083;
        bh=PmHutI3e/us50pZHVkp4RIm1Xo5Sn1V7Csy21XIK2e4=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=bEa80CGmMQXMgCyipFIlkYNKefYInYvlY1Lp5k2VMQOqSBDADtjLGlMYAYqYdrDYn
         /hq8VJSHMbwt1LO0RdM4GhDE87FQ8eedA26LY5JnT/aMxHa/jSTG78QoaQZ2ctVraf
         9AMRSZgFuwTRgcF6EXW+sB+PnvdlmnKn6VhMSijA=
Subject: Re: intel AX200 crash on 5.2.7+
From:   Ben Greear <greearb@candelatech.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Luca Coelho <luca@coelho.fi>
References: <438925e0-deab-d84d-2b0a-da544d0989b3@candelatech.com>
 <2e30e4df1eb69362f00db89efb133856ec96b755.camel@sipsolutions.net>
 <9eae12b1-a5da-1943-0f81-90e05308ec82@candelatech.com>
Organization: Candela Technologies
Message-ID: <d7815da8-29eb-0f3b-0fab-9a512d9c8d53@candelatech.com>
Date:   Thu, 3 Oct 2019 10:51:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9eae12b1-a5da-1943-0f81-90e05308ec82@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/9/19 10:54 AM, Ben Greear wrote:
> On 9/9/19 10:40 AM, Johannes Berg wrote:
>> On Mon, 2019-09-09 at 10:03 -0700, Ben Greear wrote:
>>> Hello,
>>>
>>> Looks like we managed to crash the AX200 firmware.  This was running 5.2.7+ kernel
>>> in an apu2 platform.
>>>
>>> Is there a better place to report/discuss this?
>>
>> This is OK for first reports, but usually we'll ask to file a bug on
>> bugzilla.kernel.org (and assign to linuxwifi@intel.com if you can? Not
>> sure it's possible - or add that to CC at least)
>>
>>> [ 6066.180908] iwlwifi 0000:01:00.0: 0x00000942 | ADVANCED_SYSASSERT
>>
>> Hmm, that's a calibration failure.
>>
>> Did you do anything special in that environment?
> 
> Nothing that I'm aware of.  The person who found the crash said they had
> run some throughput tests, and then the radio went away.
> 
> We put one of the radios in a more powerful system, and will continue
> testing.

Hello,

We have been capturing the firmware crash binary files from the AX200, I guess
it uses the same API as ath10k, so something just worked for once.

They are about 5MB each.  Is this something you can use to further debug
this?  I'll be happy to send them to whoever can make use of them.

It seems pretty easy to reproduce these transmit bugs, at least...maybe you
can just as easily reproduce it yourself?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

