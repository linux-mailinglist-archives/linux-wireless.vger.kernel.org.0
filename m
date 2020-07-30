Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28DD23327C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgG3M62 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 08:58:28 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:53762 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3M62 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 08:58:28 -0400
Received: from [192.168.254.5] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 16D1513C2B1;
        Thu, 30 Jul 2020 05:58:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 16D1513C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1596113907;
        bh=1QkZjmzMTa/vlbM9g6lQgzMQz7IF0iW3Ca3KnCgt1EM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=fG1jI05umvDGZ452h9X06D8sIK+auFA9Hj6c2uI58QZe8p5SBw+hRHNkbZ1F4SvF2
         y/FWy8NHKDVs3eZBJRl1dbhO0saNpxrmneGSCHBiH5PmBhg4MuA3oMgYhHnNzxvbzj
         5RvZEJkJLQIuHHtRSUvLpN+Qn67TtkGIJd3gfZJM=
Subject: Re: ax200, fw crashes, and sdata-in-driver
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <bb23b798-f347-7559-b3dc-d8f713899d26@candelatech.com>
 <c9525845a8a8b7291988c92b9f427c64e8eef6c4.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <024147cd-75ed-bacb-fb7a-e97104886751@candelatech.com>
Date:   Thu, 30 Jul 2020 05:58:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c9525845a8a8b7291988c92b9f427c64e8eef6c4.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/30/20 5:30 AM, Johannes Berg wrote:
> Hi,
> 
>> I larded up my 5.4 kernel with KASAN and lockdep, and ran some tests.  This is with my
>> patch that keeps from busy-spinning forever (see previous ignored patch).
> 
> Right, sorry, hadn't gotten to patches in a while.
> 
>> After a few restarts and FW crashes, the ax200 could not recover firmware.  There
>> were lots of sdata-in-driver errors, and then KASAN hit a use-after-free issue
>> related to ax200 accessing sta object that was previously deleted.
>>
>> Now, I think I know why:
>>
>> In the ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
>> method, it will clear the SDATA_IN_DRIVER flag, and according to comments,
>> this is run when firmware cannot be recovered.  But, just because FW is
>> dead does not mean that the driver itself has cleaned up its state.
>>
>> So question is, should ax200 (and all drivers) be responsible for cleaning
>> up all state when FW cannot be recovered, or should instead mac80211 do cleanup
>> in this case by, among other things, not clearing that flag (and probably
>> not doing the ctx->driver_present = false; config as well)?
> 
> I think it should be the driver. It's not clear _why_ the driver failed,
> after all. If the firmware is still alive and just rejected something
> then perhaps rolling things back will work. But if the firmware just
> died again, that will just cause even more trouble.

The current code clears state without actually notifying the driver, so it
is causing mac80211 to be out of sync with the driver.  I can't see how that
is a good idea.  This is root cause of the issue that causes the busy-spin
related to sdata-in-driver / EIO as far as I can tell.

When we get to the state where the driver cannot properly recover from
a fW crash, which is what this code is about, then we just need to keep
from killing the rest of the system with busy-spins and memory corruption errors
and hope it can limp on.

Some day, we should notify user-space that a radio is unrecoverable
(short of rmmod/modprobe perhaps), and that it should take appropriate
action.  If this is an AP on a pole, for instance, the WDT should be triggered
and system rebooted most likely.

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
