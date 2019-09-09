Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE5ADE4A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 19:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfIIRye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 13:54:34 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:47198 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfIIRyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 13:54:33 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 019F0104F;
        Mon,  9 Sep 2019 10:54:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 019F0104F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568051673;
        bh=P87i8rDeKSGMZ4nSZ288ctogc5bMt8oYMTzCYbWpRog=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NRVfpbHVzTNjXSaCNOalGJmydRbUYDxOumjHtp9pfCWtxq8si9s7obOjrsNvKX/4b
         d8eqqyMCD0Dvslmv8ipkyBr3XdxCFVRjcT/+Ed7NjyaH1shGDyDElmvKv4P71p92BV
         /Wp7eYdd0We3GU5QYgBOw9EgfdcfCGDhB5Iz0ztg=
Subject: Re: intel AX200 crash on 5.2.7+
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <438925e0-deab-d84d-2b0a-da544d0989b3@candelatech.com>
 <2e30e4df1eb69362f00db89efb133856ec96b755.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <9eae12b1-a5da-1943-0f81-90e05308ec82@candelatech.com>
Date:   Mon, 9 Sep 2019 10:54:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2e30e4df1eb69362f00db89efb133856ec96b755.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/9/19 10:40 AM, Johannes Berg wrote:
> On Mon, 2019-09-09 at 10:03 -0700, Ben Greear wrote:
>> Hello,
>>
>> Looks like we managed to crash the AX200 firmware.  This was running 5.2.7+ kernel
>> in an apu2 platform.
>>
>> Is there a better place to report/discuss this?
> 
> This is OK for first reports, but usually we'll ask to file a bug on
> bugzilla.kernel.org (and assign to linuxwifi@intel.com if you can? Not
> sure it's possible - or add that to CC at least)
> 
>> [ 6066.180908] iwlwifi 0000:01:00.0: 0x00000942 | ADVANCED_SYSASSERT
> 
> Hmm, that's a calibration failure.
> 
> Did you do anything special in that environment?

Nothing that I'm aware of.  The person who found the crash said they had
run some throughput tests, and then the radio went away.

We put one of the radios in a more powerful system, and will continue
testing.

> 
> I guess filing a bug would be best, so we have a record for it and can
> hand it off to the firmware team or similar.

I was able to add them to CC I think, but don't think I can re-assign the bug.

https://bugzilla.kernel.org/show_bug.cgi?id=204801

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

