Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F016AD1E18
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbfJJB5c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 21:57:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbfJJBzc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 21:55:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B71260B19; Thu, 10 Oct 2019 01:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570672531;
        bh=8X9/B1SXX/94iuvPRxzlqMLz6NyPOca2b6qzOAj4lCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oJ08tR5J4Ju2GcguNKv9K5Rn/sCNJNaKaRFE/W40stSvAI4UqrxRCJQ0Xndim1d+M
         h3CGsSz/M0HH8XWErv74K/1NJPUyCa7Nz5D16zgKaw5A0ZrHWLn+oezSyFwQO7bft1
         DArTLGnVWnlevZnflMBIeMIXrcl4JCljFXYTXEUE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A256F60B19;
        Thu, 10 Oct 2019 01:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570672530;
        bh=8X9/B1SXX/94iuvPRxzlqMLz6NyPOca2b6qzOAj4lCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hRaPxARVxrkPA5z96oPFcgRoU7t+bdKmeY7AvTi9ibTrD42N+Nafa0vngq1X97mWK
         C46rGfpeKKxvq6TxwpC6JunQUPJ55buVRlIKM8cOro76qZYFYIX3wQfZlZQgxWwsPc
         qMHOTpNztx2NiptRxWT6NpIuEdT75o9z4i5UOpao=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Oct 2019 09:55:30 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mac80211: Implement Airtime-based Queue Limit
 (AQL)
In-Reply-To: <CA+iem5tVZLoisVF=pRR7+Jx04wCGz-CJh0oLKYa6=eQbDkOTKw@mail.gmail.com>
References: <20191007043120.67567-1-kyan@google.com>
 <20191007043120.67567-2-kyan@google.com>
 <18630c07d0aa46d16cf660d013f96b3d@codeaurora.org>
 <CA+iem5tVZLoisVF=pRR7+Jx04wCGz-CJh0oLKYa6=eQbDkOTKw@mail.gmail.com>
Message-ID: <77ae70dfa49414f8fc1c56f007a21f7f@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-10 06:44, Kan Yan wrote:
> Hi  Johannes,
> 
> Thanks for the review and will address all issues you pointed out in
> the next version.
> 
> Hi Yibo,
>> 
>> I assume here the only txq in the list that does not meet AQL check 
>> will
>> not be dequeued. Right? Will it affect peak throughput once there is
>> only one station.
> 
> Yes, the txq won't be picked for transmitting even if it is the only
> active txq if the AQL check failed.  However, this won't affect peak
> throughput. The reason why there are two queue limits is address this
> kind of situation. The higher queue limit ensures the hardware get
> enough frames.

I see, higher queue limit keeps hardware from starvation.
>> 
>> > @@ -3748,10 +3785,10 @@ bool ieee80211_txq_may_transmit(struct
>> > ieee80211_hw *hw,
>> >       struct sta_info *sta;
>> >       u8 ac = txq->ac;
>> >
>> > -     spin_lock_bh(&local->active_txq_lock[ac]);
>> > -
>> >       if (!txqi->txq.sta)
>> > -             goto out;
>> > +             return true;
>> 
>> why return here? I think even a txq without sta info should get 
>> removed
>> from list and added it back later in return_txq() if needed. No?
> Yes, it should be removed from the active list. I will fix that.
> 
> Thanks,
> Kan
> 
> 
> On Wed, Oct 9, 2019 at 1:18 AM Yibo Zhao <yiboz@codeaurora.org> wrote:
>> 
>> > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>> > index f13eb2f61ccf..dadb643a5498 100644
>> > --- a/net/mac80211/tx.c
>> > +++ b/net/mac80211/tx.c
>> > @@ -3669,7 +3669,8 @@ struct ieee80211_txq *ieee80211_next_txq(struct
>> > ieee80211_hw *hw, u8 ac)
>> >  {
>> >       struct ieee80211_local *local = hw_to_local(hw);
>> >       struct ieee80211_txq *ret = NULL;
>> > -     struct txq_info *txqi = NULL;
>> > +     struct txq_info *txqi = NULL, *head = NULL;
>> > +     bool found_eligible_txq = false;
>> >
>> >       spin_lock_bh(&local->active_txq_lock[ac]);
>> >
>> > @@ -3680,20 +3681,32 @@ struct ieee80211_txq
>> > *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
>> >       if (!txqi)
>> >               goto out;
>> >
>> > +     if (txqi == head && !found_eligible_txq)
>> > +             goto out;
>> 
>> I assume here the only txq in the list that does not meet AQL check 
>> will
>> not be dequeued. Right? Will it affect peak throughput once there is
>> only one station.
>> 
>> How about dequeuing it anyway regardless AQL because it is the only 
>> one
>> active now so it is fine to occupy the rest bandwidth. Otherwise, I am
>> afraid next_txq() will return NULL in the test only one station is
>> present.
>> 
>> > @@ -3748,10 +3785,10 @@ bool ieee80211_txq_may_transmit(struct
>> > ieee80211_hw *hw,
>> >       struct sta_info *sta;
>> >       u8 ac = txq->ac;
>> >
>> > -     spin_lock_bh(&local->active_txq_lock[ac]);
>> > -
>> >       if (!txqi->txq.sta)
>> > -             goto out;
>> > +             return true;
>> 
>> why return here? I think even a txq without sta info should get 
>> removed
>> from list and added it back later in return_txq() if needed. No?
>> 
>> > +
>> > +     spin_lock_bh(&local->active_txq_lock[ac]);
>> >
>> >       if (list_empty(&txqi->schedule_order))
>> >               goto out;
>> 
>> 
>> --
>> Yibo

-- 
Yibo
