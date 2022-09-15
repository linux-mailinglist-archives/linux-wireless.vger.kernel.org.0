Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B265BA1AD
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 21:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIOT7i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 15:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIOT7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 15:59:33 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3952E2BC0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 12:59:31 -0700 (PDT)
Message-ID: <9e36f219-14a6-8960-a5fd-cb9f708237ed@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1663271968;
        bh=3oa5pKx1ERRbpxo+mvIkSRt+ZadthXn0ikneQ88LL2I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Xvd2fGvKi5TpzoqBAum5JX9t2ECCZUIvqyH8KZco9WVdbfMEgyeSvfo7AjMUqvra3
         PAJBRJ4eE2sY1VfsIh3DCumVsnXvRk/pCkjCDETm9cosZ4vEo1xru1zPDR610hGK/Z
         7mJA3EVFxscaumezAgCQ1bCK5YNKErz6QNnSu58s=
Date:   Thu, 15 Sep 2022 21:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] mac80211: Ensure vif queues are operational after start
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
References: <20220915130946.302803-1-alexander@wetzel-home.de>
 <26e9ae91-8e13-df45-815c-cb45c1911032@nbd.name>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <26e9ae91-8e13-df45-815c-cb45c1911032@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 15.09.22 18:18, Felix Fietkau wrote:
> 
> On 15.09.22 15:09, Alexander Wetzel wrote:
>> Make sure local->queue_stop_reasons and vif.txqs_stopped stay in sync.
>>
>> When a new vif is created the queues may end up in an inconsistent state
>> and be inoperable:
>> Communication not using iTXQ will work, allowing to e.g. complete the
>> association. But the 4-way handshake will time out. The sta will not
>> send out any skbs queued in iTXQs.
>>
>> All normal attempts to start the queues will fail when reaching this
>> state.
>> local->queue_stop_reasons will have marked all queues as operational but
>> vif.txqs_stopped will still be set, creating an inconsistent internal
>> state.
>>
>> In reality this seems to be race between the mac80211 function
>> ieee80211_do_open() setting SDATA_STATE_RUNNING and the 
>> wake_txqs_tasklet:
>> Depending on the driver and the timing the queues may end up to be
>> operational or not.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: f856373e2f31 ("wifi: mac80211: do not wake queues on a vif that 
>> is being stopped")
>> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
> 
> Acked-by: Felix Fietkau <nbd@nbd.name>
> 

I've got some doubts that my fix is correct...
While it fixes the problem in my tests it looks like we'll need another 
queue restart to get the queues working again.

After all IEEE80211_TXQ_STOP_NETIF_TX will not be cleared when it has 
been set by __ieee80211_stop_queue().

I'll update the patch and skip setting vif.txqs_stopped when 
SDATA_STATE_RUNNING is not set. Not having IEEE80211_TXQ_STOP_NETIF_TX 
set looks harmless, having it set when it should less problematic...

Alexander


