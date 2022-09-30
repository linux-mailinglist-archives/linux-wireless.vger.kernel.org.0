Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5361D5F0730
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 11:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiI3JIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 05:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiI3JIc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 05:08:32 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1E9AB7EF
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 02:08:30 -0700 (PDT)
Message-ID: <79161904-1e56-3046-b381-705e4af11e84@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1664528909;
        bh=kpQyWe+m1Vw6hDhWHmGqMasYzPTI1KJFR+0mA6QKfA0=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=Pr4rlxKSTU2Pk4NnU0jX7X+iNg/Z6fkjqapw0DsYRaw6RVHjC8jxHPVXw96b1pzyB
         oBP9gL1h/JcHlRBO1+SaH+jUbDlHmxIYlCdr/AskzCGBtDTb7RbxBVMAgmTqWYniTy
         9noeuglT4Ed2BkdHiAPaxeDpZ0ahyGimZnMsJa2s=
Date:   Fri, 30 Sep 2022 11:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20220926161303.13035-1-alexander@wetzel-home.de>
 <da810136f6cf0608167cc8297ce73d11b83974d6.camel@sipsolutions.net>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <da810136f6cf0608167cc8297ce73d11b83974d6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 29.09.22 22:40, Johannes Berg wrote:
> Thanks for doing this!
> 
> It's a bit bad timing right now, so I'll only have a chance to look at
> this in the next couple of weeks, but that also doesn't matter that much
> since 6.0 release is imminent (will likely be Sunday).
> 

Thanks for the warning. I'll then send a v2 to correct skb_get_hash() 
handling in the next days.

> Just wanted to comment on this one thing for now:
> 
> On Mon, 2022-09-26 at 18:13 +0200, Alexander Wetzel wrote:
>> A short look at the in-tree drivers seems to confirm, that mac80211
>> drivers are indeed not directly calling netif_stop_queue(). Which is no
>> longer undesired but outright wrong after this patch.
>> So I *think* we should be fine on that front, too.
>>
> 
> They really couldn't, they don't have (easy) access to the netdev. There
> are ways of getting to the netdev, but they're (intentionally) difficult
> and doing that would've been wrong even previously since mac80211 has
> its own reasons for stopping netdev queues sometimes.
> 
> So unless a driver is already broken, this can't be an issue.
> 
>> I did not try very hard to identify now obsolete code fragments and
>> kept this as simple as possible.
> 
> That's nice enough for now, do you want to do follow-ups to clean up
> more?
> 

The general plan so far is, to move everything to iTXQ first and then 
see what we an throw out. I'll prepare a patch cleaning up that a bit 
more. Don't think that will be much at this stage, so maybe I just add 
that into the v2 of the patch...

I'm basically working with the plan you outlined some years ago:
https://lore.kernel.org/linux-wireless/1507217947.2387.60.camel@sipsolutions.net/

It just turned out to be simpler to start with unifying the TX paths.

>> I've also have a rough draft to move PS (multicast and unicast) to iTXQ
>> we should look at later. That seems to be way more invasive than what we
>> do here. But once PS also has been sorted out moving everything to iTXQ
>> should be straight forward.
> 
> Ohhh! I'm excited about this :-)
>  > johannes

Alexander
