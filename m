Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E55A56344B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiGANYg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 09:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGANYf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 09:24:35 -0400
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 06:24:34 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9C65D72
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 06:24:34 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C452A37D4D
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 13:18:27 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.135])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2A41B1C0088;
        Fri,  1 Jul 2022 13:18:16 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F11674C009C;
        Fri,  1 Jul 2022 13:18:15 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.36.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 38B5513C2B0;
        Fri,  1 Jul 2022 06:18:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 38B5513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1656681495;
        bh=QunzSG9TUvAQOJ35bSQuGo+fMQMTC8yYnqUpkhao4Bc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=b4a6MdJJS/G5tIsdtNlUqxDVtaAc8JVEgpk5EnQIBWw74RzynRjFazCXBsAA6mg2K
         m+m2LEbZtuGPW3dHtZa49afpPAyFkTnYHSNfNzZFnlUGv3RAaY2LTKOlmtcj6riivM
         +jUJWgSOt2wMTXDHZ7ftHCxetYFwvzDiXDjPqtE0=
Subject: Re: [PATCH] mac80211: report per-chain signal values through ethtool.
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20220329210228.8137-1-greearb@candelatech.com>
 <8542c3eac729563fef1bc78d28c740453fba88bd.camel@sipsolutions.net>
 <c7ee84a4-2be5-4176-2701-8c2e691a85fe@candelatech.com>
 <d383ef715a7186cb382ff9450878747b8384dd0f.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <72db23af-3d04-252c-c728-0c71fab8dbcb@candelatech.com>
Date:   Fri, 1 Jul 2022 06:18:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d383ef715a7186cb382ff9450878747b8384dd0f.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1656681496-u33nT_0FY7Zd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/1/22 6:08 AM, Johannes Berg wrote:
> On Fri, 2022-07-01 at 06:05 -0700, Ben Greear wrote:
>> On 7/1/22 2:55 AM, Johannes Berg wrote:
>>> On Tue, 2022-03-29 at 14:02 -0700, greearb@candelatech.com wrote:
>>>> From: Ben Greear <greearb@candelatech.com>
>>>>
>>>> Combine them into a u64, each byte is one chain.
>>>
>>> This only works up to 4 chains, but the specs at least support 8. I
>>> don't think we have any drivers for that, but ...
>>
>> u64 gives 8 bytes, so the ethtool part can support 8 chains.
>> The mac80211 part only supports up to 4 chains currently though.
> 
> Oops, right, sorry.
> 
> Still, I'm not sure I like munging it all up into one value - the value
> itself then doesn't mean anything, and the normal ethtool APIs userspace
> tools would be pretty much useless for it?

A human looking at the value would be confused, but a program easily deals
with it.  In a lot of ways, ethtool is way more straight forward to program
against than netlink, and it works well with non-wifi drivers, so one
chunk of stats-gathering code for all network devices.

> 
>>> We're reporting these through nl80211 anyway though, no? Why should we
>>> prefer ethtool, which fundamentally limits to a single value for the AP
>>> rather than giving the full per-station view.
>>
>> I already gather ethtool stats for STA vdevs, so adding another stat is
>> basically free as far as performance is concerned.  That is important
>> to me.  I do not currently program much against netlink API (just scrape
>> existing tools output).
> 
> Well I guess then I think you probably should program against the
> netlink API :)

I've managed to mostly dodge it for 20 years....there is hope to make it another 20!

> 
>>>> Re-work the way that APs averaged stats to be more
>>>> efficient.
>>>
>>> Isn't that completely unrelated?
>>
>> At least somewhat unrelated.
>>
> 
> Fair enough. Maybe send that separately? I guess that's something I'd
> understand a bit more and improving the existing code is an easier sell
> than adding a whole new thing there :)

Ok, I'll add that to my list and will plan to do it next time I rebase on
a newer upstream kernel.

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
