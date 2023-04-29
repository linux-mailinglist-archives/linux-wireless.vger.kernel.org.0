Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199DD6F239B
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjD2Hgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Apr 2023 03:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjD2Hgm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Apr 2023 03:36:42 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F8FE1BDC
        for <linux-wireless@vger.kernel.org>; Sat, 29 Apr 2023 00:36:40 -0700 (PDT)
Message-ID: <1f5e0a66-e68e-a673-feea-d2a3baaf54d4@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1682753797;
        bh=3zEWMzvpRO6mmn5H8AbYdS5EKoN9JntNQVO2PtllDxU=;
        h=Date:Subject:From:To:References:Cc:In-Reply-To;
        b=p/85jjhle/A0R75AnUoLZ30nGcJfI+rEFOheil1gyWaIvRsEm//EN9bU9EA9rknRh
         aKrRx+5hULM2aL0C7UpO6tT/mjQs0cHK5q0OtJKri4dUtHo2VHXatmC9mQY5yEFLkB
         gcz7AimFckRlxL8bSL31GLdf6xqDKkkItxsNxgUc=
Date:   Sat, 29 Apr 2023 09:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Performance degradation with "wifi: mac80211: Drop support for TX
 push path"
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
To:     Maxime Bizon <mbizon@freebox.fr>
References: <ZEwBXkj7nwXY2cF+@sakura>
 <140bdbc3-8cb3-e7bd-13ee-fdacdf3b20da@wetzel-home.de>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
In-Reply-To: <140bdbc3-8cb3-e7bd-13ee-fdacdf3b20da@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding linux-wireless to the discussion:

On 28.04.23 22:08, Alexander Wetzel wrote:
> On 28.04.23 19:24, Maxime Bizon wrote:
>>
>> Hello Alexander,
>>
> 
> I would like to keep linux-wireless in the loop for discussions.
> When that's ok for you, just add linux-wireless@vger.kernel.org when you 
> reply...
> 
>> First I would like to thank you for the cleanups you are doing in
>> mac80211, as a driver writer [1] I used to scratch my head to
>> understand the internals.
>>
>> I work for a french ISP called Free, and actively maintain the
>> software of all router/gateway devices (couple millions deployed)
>>
>> We have a very large number of old devices deployed that are >10 years
>> old but on which we manage to run a mainline kernel. Those are ARM
>> Kirkwook (armv5 1Ghz) based devices, wifi is Marvell 11n 2.4Ghz (mwl8k
>> based) + QCA 11ac 5ghz (QCA998X/ath10k).
>>
>> The CPU was always a bit underpowered for the 11ac card, but I could
>> reach ~400Mbit/s in a routing test between WAN and Wifi, 100% CPU usage.
>>
>> Since work started in 2019 on ath10k debloat, I applied that patch [2]
>> to avoid performance degration.
>>
>> Since "wifi: mac80211: Drop support for TX push path", it's not
>> possible to do that anymore, so I did a benchmark to see the impact,
>> the same routing test caps at 250Mbit/s. I suppose some openwrt users
>> will be affected also.
> 
> Well, I guess calling wake_tx_queue and then transmitting (mostly) one 
> packet is probably causing that. Now there are some ideas to improve 
> that by using a kthreads. It's hidden in the discussion here:
> https://lore.kernel.org/all/82d5623b-8d21-a8c1-e835-e446adf96cde@wetzel-home.de/
> 
> My problem with doing that *now* is, that I'm working on a invasive 
> patch set in mac80211. Which will really clean up the old logic and not 
> just tweak some simple things.
> It's mostly sorted out and written, only a few issue left till I can try 
> it out. But I'm not getting around to wrap that up for work/private 
> reasons for quite some weeks (really months...) now. Rebasing and then 
> testing the already working patches for a wake_tx_queue implementation 
> using kthreads is something I'm hoping to avoid:-)
> 
> Now, I've more or less already decided to add the kthread patch to that 
> series, once I get it stabilized at its current level.
> I have some hopes, that I can reuse the reworked PS mechanism to even 
> simplify such an patch.
> 
> But it's hard to even estimate when I'll have that patch set together, 
> so I would have something for you to test.
> (Should at least be this year. Originally I was aiming for 6.4. But that 
> was weeks ago and I've found no time to work on that till then...)
> 
> Getting the push path operational in >= 6.2 will be non-trival. You 
> basically would have to revert drivers/mac80211 to 6.1 and maintain your 
> own tree. Looks like a very bad idea...
> 
> When you need a fix in the near future and you have time to work on that 
> I would look into using a kthread for wake_tx_queue. Seems to be the 
> most promising way to solve the issue.. (Maybe I'm to optimistic, but 
> that could even be faster...)
> 
> Of course some people on the list may have other - simpler to implement? 
> - ideas why it's so much slower for you to use wake_tx_queue.
> 
> 
>>
>> I don't want to hinder progress of course, and I can still revert it
>> (for now at least), but if you had an idea to keep a simpler
>> alternative tx path without too much maintenance burden, I'd be
>> willing to put the effort into it.
>>
> 
> I don't think that we'll ever bring the push path back.
> We'll have to figure out how to change wake_tx_queue, so you get the 
> same - or better - performance.
> 
> 
>> Thanks,
>>
>> [1] https://marc.info/?l=linux-wireless&m=158862152015048&w=2
>> [2] 
>> https://patchwork.kernel.org/project/ath10k/patch/1467201146-6844-1-git-send-email-michal.kazior@tieto.com/
>>
> 

