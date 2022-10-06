Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE065F6BF5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiJFQmx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 12:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiJFQmw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 12:42:52 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44558A5980
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 09:42:51 -0700 (PDT)
Message-ID: <147787be-2a36-be70-92fd-b9d7f26f57cf@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1665074570;
        bh=9gd2i9kQxBIP+htIkxEn/YZtk+n1mrsFCUqK4bGtQ/o=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=BTRT4fKQIskfZNVBba9mmh3ezqRGtZ1u3fZufC2eKgFegAf6LW0/SJmdjRZofj3id
         bQ+YErmdYTqHQLVkPX7skB8lVY8Tky29KwUx5ZdispKBk7qvMx2KOU1zZtTJrH7I+k
         rPCRuhd09QrxW6vTwcwcR8TQ+mK0ZyxFoQOU8zmQ=
Date:   Thu, 6 Oct 2022 18:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20220926161303.13035-1-alexander@wetzel-home.de>
 <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
 <875ygyihhm.fsf@toke.dk>
 <bf6f9d8707021dc6017c7cb17805d63edea63333.camel@sipsolutions.net>
 <87r0zmgwli.fsf@toke.dk>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <87r0zmgwli.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05.10.22 16:43, Toke Høiland-Jørgensen wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
>> On Wed, 2022-10-05 at 14:26 +0200, Toke Høiland-Jørgensen wrote:
>>
>>>> void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
>>>> 				    struct ieee80211_txq *txq)
>>>> {
>>>> 	... *local = from_hw(hw);
>>>> 	... *sdata = from_vif(txq->vif);
>>>>
>>>> 	wake_tx_push_queue(local, sdata, txq);
>>>> }
>>>>
>>>> Actually ... I wonder why you'd here - in waking a single TXQ - use
>>>> ieee80211_next_txq() at all, Toke, what do you think?
>>>
>>> Well, this patch does almost exactly the same as the ath9k driver does,

ath9k was indeed the "template" I used. Mentioned that in the RFC but 
dropped that in the final patch.

>>> for instance. Really, the wake_tx_queue() is a signal to the driver to
>>> start transmitting on the *hardware* queue that the txq points to. For
>>> some drivers (like Intel, right?) that's a 1-to-1 mapping, for others
>>> there are multiple TXQs being scheduled on the same HW-TXQ. So I think
>>> it's probably the right thing to do to just call next_txq(); if there's
>>> only a single TXQ scheduled it should be pretty cheap to do so.
>>
>> Oh OK. So then the logic Alexander had makes sense.
> 
> Yup, I think so :)
> 

As mentioned I initially just cloned the logic from ath9k but my 
reasoning why it's done that way is a bit different: By calling 
ieee80211_next_txq() we are making sure that we indeed are starting TX 
on the highest prio iTXQ for that AC.

>>>
>>> This logic has implications for putting "urgent" frames (like PS(?)) on
>>> TXQs as well, of course, but that needs to be handled somehow anyway...
>>
>> But that probably then anyway needs to be handled in next_txq()?
> 
> Yeah, just meant that comment as an "for future reference", it doesn't
> impact this patch series (I think?)
> 

So far my PS on iTXQ patch is just adding a fallback queue I'm using as 
replacement for the push path. Idea then is, skip the iTXQs with PS 
frames (vif.txq and all sta.txq[]) on the wake_tx_queue calls till they 
are listening. When a driver wants to dequeue MPDUs early they still can 
do that via the existing functions.

I have the skeleton for that and at least my notebook still has 
connectivity with it there are multiple areas needing more work prior to 
even think about testing it...

I'll keep you posted.


> -Toke

Alexander
