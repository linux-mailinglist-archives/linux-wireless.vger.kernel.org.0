Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CB6274A79
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIVU6A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 16:58:00 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:48292 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVU56 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 16:57:58 -0400
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E26B013C2B1;
        Tue, 22 Sep 2020 13:57:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E26B013C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600808277;
        bh=fK1jUHftaaJuplbD63eSAjwYbSZPP1pPOtRPCJotsuk=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=J31XYHpCHtAzlduTpXsZmAU+EtGgEWCLtFjqB6WD2j7du+BZmQeavxhQ0bKboKFwM
         oo19LOQvuctg++uc80rrDq9wRwU37833ABky6P+fuF8pKtVuFnCyWBZ/4AeXWjY1/v
         kWYKKsPaYv3dne/g/P5oc8/qptgzp5xzNuFwyyL8=
Subject: Re: ax200, fw crashes, and sdata-in-driver
From:   Ben Greear <greearb@candelatech.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <bb23b798-f347-7559-b3dc-d8f713899d26@candelatech.com>
 <c9525845a8a8b7291988c92b9f427c64e8eef6c4.camel@sipsolutions.net>
 <024147cd-75ed-bacb-fb7a-e97104886751@candelatech.com>
Organization: Candela Technologies
Message-ID: <e8335394-b6a1-0806-b604-9b429c951c7d@candelatech.com>
Date:   Tue, 22 Sep 2020 13:57:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <024147cd-75ed-bacb-fb7a-e97104886751@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/30/20 5:58 AM, Ben Greear wrote:
> On 7/30/20 5:30 AM, Johannes Berg wrote:
>> Hi,
>>
>>> I larded up my 5.4 kernel with KASAN and lockdep, and ran some tests.  This is with my
>>> patch that keeps from busy-spinning forever (see previous ignored patch).
>>
>> Right, sorry, hadn't gotten to patches in a while.
>>
>>> After a few restarts and FW crashes, the ax200 could not recover firmware.  There
>>> were lots of sdata-in-driver errors, and then KASAN hit a use-after-free issue
>>> related to ax200 accessing sta object that was previously deleted.
>>>
>>> Now, I think I know why:
>>>
>>> In the ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
>>> method, it will clear the SDATA_IN_DRIVER flag, and according to comments,
>>> this is run when firmware cannot be recovered.  But, just because FW is
>>> dead does not mean that the driver itself has cleaned up its state.
>>>
>>> So question is, should ax200 (and all drivers) be responsible for cleaning
>>> up all state when FW cannot be recovered, or should instead mac80211 do cleanup
>>> in this case by, among other things, not clearing that flag (and probably
>>> not doing the ctx->driver_present = false; config as well)?
>>
>> I think it should be the driver. It's not clear _why_ the driver failed,
>> after all. If the firmware is still alive and just rejected something
>> then perhaps rolling things back will work. But if the firmware just
>> died again, that will just cause even more trouble.
> 
> The current code clears state without actually notifying the driver, so it
> is causing mac80211 to be out of sync with the driver.  I can't see how that
> is a good idea.  This is root cause of the issue that causes the busy-spin
> related to sdata-in-driver / EIO as far as I can tell.

Hello,

As far as I can tell, no work has gone into the driver(s) to resolve the use-after-free
issue.

So, maybe worth considering my earlier patch to clean everything up in mac80211
instead of depending on the drivers to get this correctly cleaned up in all cases?

I'll repost it, freshly rebased against latest linus tree....

Thanks,
Ben

