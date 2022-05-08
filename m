Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ACB51EFD7
	for <lists+linux-wireless@lfdr.de>; Sun,  8 May 2022 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiEHTRY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 May 2022 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiEHTOy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 May 2022 15:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618435F87
        for <linux-wireless@vger.kernel.org>; Sun,  8 May 2022 12:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1031C612C4
        for <linux-wireless@vger.kernel.org>; Sun,  8 May 2022 19:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA81C385A4;
        Sun,  8 May 2022 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652037036;
        bh=+kivmqc76TVizhAwoHN2hGQURqtlfvgbtT7waiwXYfk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hv+7iTsd9GqNwEwT2j0sTjW8+To0yGptzW3xCMc4M6hy6sUerchLg0xUQsVcgBSRO
         I5ruOFyHCENwE6OHqRPs/raE5AVwbUxwB9MDhMPjnaiWFvICORK4uvl+Msclj1BPxc
         goDwXEQmQ3edHgwXkSghAbFWpDsOewWEc9SvdRbgVgzbBICyLhHVFwuzRv9XKJwlIA
         L+CXLwnsqID4BGIraEqTzhM31EkXhaW56Ae3GnWzIVtdEziPh7NXvmsyO5F8Wtq9/m
         4fd5c4NnUmm6S9F67nQroiEVTFx4CDhczDz8+yI+1KcRs6Z/BTgvLsVANTrY7TOaYy
         xm8TQJsNrfrKQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 79BB434DB7B; Sun,  8 May 2022 21:10:33 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Pierre Asselin <pa@panix.com>
Subject: Re: [PATCH] mac80211: Use full queue selection code for control
 port tx
In-Reply-To: <65e6897d-e1ec-ffda-5f7a-4aec37621377@nbd.name>
References: <20220507083706.384513-1-alexander@wetzel-home.de>
 <87r1551t4c.fsf@toke.dk> <65e6897d-e1ec-ffda-5f7a-4aec37621377@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 08 May 2022 21:10:33 +0200
Message-ID: <875ymf263a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 07.05.22 13:26, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Alexander Wetzel <alexander@wetzel-home.de> writes:
>>=20
>>> Calling only __ieee80211_select_queue() for control port TX exposes
>>> drivers which do not support QoS to non-zero values in
>>> skb->queue_mapping and even can assign not available queues to
>>> info->hw_queue.
>>> This can cause issues for drivers like we did e.g. see in
>>> '746285cf81dc ("rtl818x: Prevent using not initialized queues")'.
>>>
>>> This also prevents a redundant call to __ieee80211_select_queue() when
>>> using control port TX with iTXQ (pull path).
>>> And it starts to prioritize 802.11 preauthentication frames
>>> (ETH_P_PREAUTH) on all TX paths.
>>>
>>> Pierre Asselin confirmed that this patch indeed prevents crashing his
>>> system without '746285cf81dc ("rtl818x: Prevent using not initialized
>>> queues")'.
>>>
>>> Tested-by: Pierre Asselin <pa@panix.com>
>>> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
>>> ---
>>>
>>> Starting to prioritize ETH_P_PREAUTH was just added since I noticed that
>>> contradictory to at least my expectations control port does accept
>>> ETH_P_PREAUTH but handles these like a normal frame for the priority.
>>> That can be broken out or even drop, when needed.
>>>
>>> While looking at the code I also tripped over multiple other questions
>>> and I'll probably propose a much more invasive change how to handle
>>> the queue assignment. (End2end we seem to do some quite stupid things.)
>>>
>>> Additionally I really don't get why we call skb_get_hash() on queue
>>> assignment:
>>> I found the commit '180ac48ee62f ("mac80211: calculate skb hash early
>>> when using itxq")' but don't see why calculating the hash early is
>>> useful. Any hints here are appreciated. fq_flow_idx() seems to do that
>>> when needed and I can't find any other usage of the hash...
>>=20
>> The commit message of that commit has a hint:
>>=20
>>      This avoids flow separation issues when using software encryption.
>>=20
>> The idea being that the packet contents can change on encryption, but
>> skb->hash is preserved, so you want it to run before encryption happens
>> to keep flows in the same queue.
>>=20
>> However, AFAICT ieee80211_tx_h_encrypt() is called after frames are
>> dequeued from the TXQs, so not actually sure this is needed. Adding
>> Felix, in the hope that he can explain the reasoning behind that
>> commit :)
> Sorry, I don't remember the details on that one. One advantage that I
> can think of (which isn't mentioned in the commit msg) is that it is
> likely better for performance to calculate the hash early since there
> is a good chance that more of the skb data is still in the CPU cache.

Right, that could be, I suppose. I don't think it'll hurt, at least;
Alexander, did you have any particular reason for wanting to get rid of
it?

-Toke
