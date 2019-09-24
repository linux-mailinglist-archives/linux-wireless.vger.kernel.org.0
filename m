Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19306BC400
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409447AbfIXIWq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 04:22:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409445AbfIXIWp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 04:22:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5886B602F2; Tue, 24 Sep 2019 08:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569313364;
        bh=32NmNmKKduEVdtULZjfuI+1nlnbYAGk25UhmZpR6+74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JoFZ3bv06iThmtbrQ24T6AZyC7WYie0uxNAikBSG6CeQFHhWaDh1qlbYq8cMOF3lL
         A1zDQ4MWFGwNxXoItlrjYXgaB28hmkoqJunQkdm8eU4gb4CD+vUNe9Rkp8Vpuvp8iT
         P3Lt3TbTUmss+xHx/ELdBnfuluh+C+FBh+1/0Ues=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 92DEE601D4;
        Tue, 24 Sep 2019 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569313363;
        bh=32NmNmKKduEVdtULZjfuI+1nlnbYAGk25UhmZpR6+74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dd9HOt1ntIEFGIccv3r62hjZeD2S0Z0kqnyKFeOYnHGqoijNhrALiUciaxN1bk4wI
         EHLR0QPUfMu5j/EeetpECV3zmyLMHvk8Ncru1esQv8N8X5eAYPGQLPi4C+q/v/gqrg
         YSSd4ntmxdd4/epjjHBcCokzBL1c9+ou4BnTyDk0=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 24 Sep 2019 16:22:43 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 3/4] mac80211: fix low throughput in multi-clients
 situation
In-Reply-To: <87impj5lkm.fsf@toke.dk>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org>
 <1569223201-1490-4-git-send-email-yiboz@codeaurora.org>
 <87impj5lkm.fsf@toke.dk>
Message-ID: <2aab0bd944ee34751304a5f92b885113@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-23 18:55, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>> Not long after the start of multi-clients test, not a single station 
>> is
>> an eligible candidate for transmission since global virtual time(g_vt) 
>> is
>> smaller than the virtual airtime(s_vt) of all the stations. As a 
>> result,
>> the Tx has been blocked and throughput is quite low.
>> 
>> This may mainly due to sync mechanism and accumulative deviation from 
>> the
>> devision calculation of g_vt.
>> 
>> For example:
>> Suppose we have 50 clients in first round.
>> Round 1:
>> STA	weight	Tx_time_round  wt_sum	s_vt	g_vt  valid_for_next_Tx
>> 1	256	2048		12800	2048	2000	N
>> 2	256	2048			2048		N
>> .	.	.			.		.
>> .	.	.			.		.
>> .	.	.			.		.
>> 50	256	2048			2048		N
>> 
>> After this round, all the stations are not valid for next transmission 
>> due to
>> accumulative deviation.
>> 
>> And if we add a new #51,
>> STA	weight	Tx_time_round  wt_sum	s_vt	g_vt  valid_for_next_Tx
>> 1	256	2048		13056	2048	2020	N
>> 2	256	2048			2048		N
>> .	.	.			.
>> .	.	.			.
>> .	.	.			.
>> 50	256	2048			2048		N
>> 51	256	1024			2524		N
> 
> That's better :)
> 
>> Sync is done by:
>> max(g_vt of last round - grace period, s_vt)
>> and s_vt of #51 = max(2000 - 500, 0) + 1024 = 2524, and it is more 
>> than the final
>> g_vt of this round.
>> 
>> After this round, no more station is valid for transmission.
>> 
>> The real situation can be more complicate, above is one of the 
>> extremely case.
>> 
>> To avoid this situation to occur, the new proposal is:
>> 
>> - Increase the airtime grace period a little more to reduce the
>>   unexpected sync
>> 
>> - If global virtual time is less than the virtual airtime of any 
>> station,
>>   sync it to the airtime of first station in the red-black tree
>> 
>> - Round the division result
> 
> I can see why we need the second part (basically, this happens because 
> I
> forgot to add a check for "no eligible stations" in may_transmit(), 
> like
> the one in next_txq()). And rounding up the division result doesn't
> hurt, I guess. But why does it help to change the grace period if we're
> doing all the other stuff?
In multi-clients case, it is possible a TXQ sometimes gets drained due 
to FW has deep queue and few packets in TXQ at that time. So the TXQ is 
removed from the rbtree after dequeuing. When it is about to added back 
very soon after the removal, the g_vt might have gone a little far away 
from sta vt where sync is needed. With this sync, the station is forced 
to catch up with the g_vt, however, its chance for transmission has been 
reduced. I think 500us is quite a short period in multi-clients case.
> 
> -Toke

-- 
Yibo
