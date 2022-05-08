Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC651EBEE
	for <lists+linux-wireless@lfdr.de>; Sun,  8 May 2022 07:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiEHFsQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 May 2022 01:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiEHFsN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 May 2022 01:48:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8673FE010
        for <linux-wireless@vger.kernel.org>; Sat,  7 May 2022 22:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZYRzWLQJwALtz+6jjDAO6kxk/VQyyf63jq9MF8B8euY=; b=lp+XPVhkQEXa9P11e7AmI5lb3N
        4MjJck1Uorns71x78ieWwbbtHwj9N2OGkhE0ZyD5lrlHYEex5JElIEE8ZjC+7IH9/C6bOVmg/uyGf
        4d4lKZ/zSFkWSDXTQ6kcplEVdeGt9RabuNhovYsudZaAaZguQFxgN37Ck/qvEWsZqFSE=;
Received: from p200300daa70ef20064df27b80c0ef847.dip0.t-ipconnect.de ([2003:da:a70e:f200:64df:27b8:c0e:f847] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nnZiJ-0001Ha-Aj; Sun, 08 May 2022 07:44:15 +0200
Message-ID: <65e6897d-e1ec-ffda-5f7a-4aec37621377@nbd.name>
Date:   Sun, 8 May 2022 07:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] mac80211: Use full queue selection code for control port
 tx
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Pierre Asselin <pa@panix.com>
References: <20220507083706.384513-1-alexander@wetzel-home.de>
 <87r1551t4c.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <87r1551t4c.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 07.05.22 13:26, Toke Høiland-Jørgensen wrote:
> Alexander Wetzel <alexander@wetzel-home.de> writes:
> 
>> Calling only __ieee80211_select_queue() for control port TX exposes
>> drivers which do not support QoS to non-zero values in
>> skb->queue_mapping and even can assign not available queues to
>> info->hw_queue.
>> This can cause issues for drivers like we did e.g. see in
>> '746285cf81dc ("rtl818x: Prevent using not initialized queues")'.
>>
>> This also prevents a redundant call to __ieee80211_select_queue() when
>> using control port TX with iTXQ (pull path).
>> And it starts to prioritize 802.11 preauthentication frames
>> (ETH_P_PREAUTH) on all TX paths.
>>
>> Pierre Asselin confirmed that this patch indeed prevents crashing his
>> system without '746285cf81dc ("rtl818x: Prevent using not initialized
>> queues")'.
>>
>> Tested-by: Pierre Asselin <pa@panix.com>
>> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
>> ---
>>
>> Starting to prioritize ETH_P_PREAUTH was just added since I noticed that
>> contradictory to at least my expectations control port does accept
>> ETH_P_PREAUTH but handles these like a normal frame for the priority.
>> That can be broken out or even drop, when needed.
>>
>> While looking at the code I also tripped over multiple other questions
>> and I'll probably propose a much more invasive change how to handle
>> the queue assignment. (End2end we seem to do some quite stupid things.)
>>
>> Additionally I really don't get why we call skb_get_hash() on queue
>> assignment:
>> I found the commit '180ac48ee62f ("mac80211: calculate skb hash early
>> when using itxq")' but don't see why calculating the hash early is
>> useful. Any hints here are appreciated. fq_flow_idx() seems to do that
>> when needed and I can't find any other usage of the hash...
> 
> The commit message of that commit has a hint:
> 
>      This avoids flow separation issues when using software encryption.
> 
> The idea being that the packet contents can change on encryption, but
> skb->hash is preserved, so you want it to run before encryption happens
> to keep flows in the same queue.
> 
> However, AFAICT ieee80211_tx_h_encrypt() is called after frames are
> dequeued from the TXQs, so not actually sure this is needed. Adding
> Felix, in the hope that he can explain the reasoning behind that commit :)Sorry, I don't remember the details on that one. One advantage that I 
can think of (which isn't mentioned in the commit msg) is that it is 
likely better for performance to calculate the hash early since there is 
a good chance that more of the skb data is still in the CPU cache.

- Felix
