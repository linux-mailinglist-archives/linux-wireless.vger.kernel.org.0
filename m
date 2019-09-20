Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E44B8D02
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 10:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405200AbfITIhr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 04:37:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404933AbfITIhr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 04:37:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 09011613A3; Fri, 20 Sep 2019 08:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568968666;
        bh=Z4dsZ3wKgL3qMslROGOTlPWRLuujF5cMmxJyeuRYXLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WL/EEfu0ybiDIonKXjBQtwp7erDFShDQSeFcrdcf/eqyW1kB8m/dPPOa7uEpjZuhZ
         XaHAVffqhHn7rTU/IofX4mR5XlvDlf6oGu+Pv4ghJLkTN6kKw0l6ElrIx4G9G51AG1
         8lz/aJrn1wGHm+pzXfUGIyt68o2rJo0WkNnYfNrc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9894460850;
        Fri, 20 Sep 2019 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568968665;
        bh=Z4dsZ3wKgL3qMslROGOTlPWRLuujF5cMmxJyeuRYXLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JCV/p9tANUS4tkc5fW2LbK6Va+e06oPX+vU7gB2UQESqUFaKJG6nJ9uFbf5rJW1ql
         c8zb4rphleEK+BuJe4Csy95DbaZbfwaTK8NvxHDN2n47M4JgO+EvDGrwRm8q2UJeUF
         66/KDydrVmPDqd8UDpHArbYEoETMIKC/YwWLlSCE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 20 Sep 2019 16:37:45 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/4] mac80211: Switch to a virtual time-based airtime
 scheduler
In-Reply-To: <87ftkuip9f.fsf@toke.dk>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
 <87ftkuip9f.fsf@toke.dk>
Message-ID: <741a71abebf0ceecb2fbe440ae1c2750@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-18 05:31, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> 
>> This switches the airtime scheduler in mac80211 to use a virtual 
>> time-based
>> scheduler instead of the round-robin scheduler used before. This has a
>> couple of advantages:
>> 
>> - No need to sync up the round-robin scheduler in firmware/hardware 
>> with
>>   the round-robin airtime scheduler.
>> 
>> - If several stations are eligible for transmission we can schedule 
>> both of
>>   them; no need to hard-block the scheduling rotation until the head 
>> of the
>>   queue has used up its quantum.
>> 
>> - The check of whether a station is eligible for transmission becomes
>>   simpler (in ieee80211_txq_may_transmit()).
>> 
>> The drawback is that scheduling becomes slightly more expensive, as we 
>> need
>> to maintain an rbtree of TXQs sorted by virtual time. This means that
>> ieee80211_register_airtime() becomes O(logN) in the number of 
>> currently
>> scheduled TXQs. However, hopefully this number rarely grows too big 
>> (it's
>> only TXQs currently backlogged, not all associated stations), so it
>> shouldn't be too big of an issue.
>> 
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> I'll note that this patch still has the two issues that Felix pointed
> out when I posted the RFC version. Namely:
> 
> - The use of divisions in the fast path. I guess I need to go write 
> some
>   reciprocal-calculation code, since that is also an issue with the AQL
>   patches I linked to before.
> 
> - The fact that we don't count the airtime usage of multicast traffic,
>   which with this series means that the vif TXQ will get priority over
>   the others. I think we agreed to fix this by just adding an airtime
>   v_t to the vif as well and use that for scheduling the TXQ. Does
>   ath10k report airtime usage for multicast as well, or only for
>   stations?
> 
> 
I remember we have Felix' patches reducing the time the lock is held in 
mac80211 for DRR, do we need to integrate it into this version？
> -Toke

-- 
Yibo
