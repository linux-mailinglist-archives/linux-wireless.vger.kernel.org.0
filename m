Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFB551F1D5
	for <lists+linux-wireless@lfdr.de>; Sun,  8 May 2022 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiEHVeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 May 2022 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiEHVdt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 May 2022 17:33:49 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7050DEDE
        for <linux-wireless@vger.kernel.org>; Sun,  8 May 2022 14:29:57 -0700 (PDT)
Message-ID: <09f7049a-9c89-58d1-22b9-3726d6d20c07@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1652045393;
        bh=iu6dA9yaKKJeGjS7PDIpDhA1oj7hNowrAsQ0HFI6JYo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RP3AZRSfpO4BjHF3sUr9ZEz4eR0IP86Q1nEHczGTh5emgNM63P0nWRYiSMh3gpUPr
         iXsPd1YAMtrR4cxx3J/lPLmmwyak1ZohTbttpn+uLzppTxXa70cMwGzPFMkfm2xH7i
         6mVwvOZU3PF13uEehu65Tr+fQDxjgzYLCIsZw0FE=
Date:   Sun, 8 May 2022 23:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mac80211: Use full queue selection code for control port
 tx
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Pierre Asselin <pa@panix.com>
References: <20220507083706.384513-1-alexander@wetzel-home.de>
 <87r1551t4c.fsf@toke.dk> <65e6897d-e1ec-ffda-5f7a-4aec37621377@nbd.name>
 <875ymf263a.fsf@toke.dk>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <875ymf263a.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>>>> Additionally I really don't get why we call skb_get_hash() on queue
>>>> assignment:
>>>> I found the commit '180ac48ee62f ("mac80211: calculate skb hash early
>>>> when using itxq")' but don't see why calculating the hash early is
>>>> useful. Any hints here are appreciated. fq_flow_idx() seems to do that
>>>> when needed and I can't find any other usage of the hash...
>>>
>>> The commit message of that commit has a hint:
>>>
>>>       This avoids flow separation issues when using software encryption.
>>>
>>> The idea being that the packet contents can change on encryption, but
>>> skb->hash is preserved, so you want it to run before encryption happens
>>> to keep flows in the same queue.
>>>
>>> However, AFAICT ieee80211_tx_h_encrypt() is called after frames are
>>> dequeued from the TXQs, so not actually sure this is needed. Adding
>>> Felix, in the hope that he can explain the reasoning behind that
>>> commit :)
>> Sorry, I don't remember the details on that one. One advantage that I
>> can think of (which isn't mentioned in the commit msg) is that it is
>> likely better for performance to calculate the hash early since there
>> is a good chance that more of the skb data is still in the CPU cache.
> 
> Right, that could be, I suppose. I don't think it'll hurt, at least;
> Alexander, did you have any particular reason for wanting to get rid of
> it?

No, not really. I just do not want to move code around I do not understand.

I'm looking into how mac80211 assigns the queues and ended up with the 
impression, that this could be simplified.

Now I'm pretty sure that the distinction between iTXQ and other drivers 
for queue selection is (nowadays?) pointless. (I'll argue the case 
hopefully soon in another patch.)

My problem was only, how to handle the calls to skb_get_hash() in my 
upcoming patch:
I could not figure out how this call helps to "avoids flow separation 
issues when using software encryption", indicating that I still may have 
a critical knowledge gap.

With the understanding that we try to get the hash calculated while the 
skb may still be in the CPU buffers that's sorted out.

In fact I've now a first draft for the "queue simplification patch" and 
will share that here after testing it with a card which actually 
supports wake_tx_queue().

Alexander
