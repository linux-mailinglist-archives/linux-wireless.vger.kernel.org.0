Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592545223EA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348883AbiEJS0c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348905AbiEJS02 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 14:26:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F627355D
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 11:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 59DE1CE206E
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 18:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BABC385A6;
        Tue, 10 May 2022 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652207182;
        bh=SzYrCJ9FKSjpUOUPccumMRvs+bI3ANNIo4BgAh5u6bo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Eh4JyYl7QYweh5gloj15TL+pVZ1LH2iYOZIIxaudhEijeTcDqSO24pEY2TlUuDN6n
         i8kxYxNJg5RUouUpyU3vpclNKgS5xjA2xhcH45GIj48DEJPJ9tgGDphN8OHM/+WRQI
         I/B11PbNMr14Pf0K8w3DUOyhp1CjtwjAS98S4x/DLBOyl4gZ6iWLqVWRv+gryMlFYn
         hxpi4ACB+Q6KndguL1uv4On3yGykpAfUlD8NXrUg6HZL8DASP2rCU3C9HVSAZQeWjH
         X9NZir0jQplLV0zyIsuh5x2aN566pUsQyKeFtq+w1Up5MbN3UMWE2uRPXt37dXrHz8
         Jl+aQOCZxQN0A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4443134E33D; Tue, 10 May 2022 20:26:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: Simplify queue selection
In-Reply-To: <13154ef7-63ee-cfe7-3ebb-a7f1120985b6@wetzel-home.de>
References: <20220510155828.9406-1-alexander@wetzel-home.de>
 <54589d98-882c-cee4-dd6d-140d50f400d0@nbd.name>
 <13154ef7-63ee-cfe7-3ebb-a7f1120985b6@wetzel-home.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 10 May 2022 20:26:20 +0200
Message-ID: <87zgjpw8fn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexander Wetzel <alexander@wetzel-home.de> writes:

> On 10.05.22 18:10, Felix Fietkau wrote:
>> On 10.05.22 17:58, Alexander Wetzel wrote:
>>> Let iTXQ drivers also register four queues in netdev and move queue
>>> assignment to ndo_select_queue(), like it's done for other drivers.
>>>
>>> This gets rid of a special case in mac80211 and also increases the
>>> chance that when we call skb_get_hash() the skb is still hot in the CPU
>>> buffers.
>>>
>>> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
>> 
>> This has the disadvantage of requiring a redundant sta lookup in the tx 
>> path for iTXQ drivers. I think the CPU cost of that one is probably 
>> higher than any potential gain from calling skb_get_hash a bit earlier.
>
> Found that one, yes. But why do we then not drop ndo_select_queue() for 
> all drivers?
>
> Or maybe just call skb_get_hash() in ndo_select_queue()... But I guess 
> then it would make more sense to move the ndo_select_queue() into 
> netdev, so all drivers get the optimization.

The reason it's an optimisation for mac80211 is that we know
skb_get_hash() will always be called later (when enqueueing into the
TXQ). This is not always the case for other drivers, so that is probably
a dubious optimisation to have in general.

-Toke
