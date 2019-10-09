Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE107D1C16
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 00:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfJIWow (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 18:44:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36313 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732074AbfJIWow (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 18:44:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id x80so2875936lff.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K74FSLibgRox92Ke/og8To0X7TZ2VBykrYPKh9Z5pcY=;
        b=OFzsCFUKTEmsMDknSMDxoYlbwIb7GydlLPMKg2T7ObARVcE80qslnzBR91P7DoYc3l
         LGczTTg6nnxjA5GRPpHuBcw9ZBqUEBD4tvERUHqHZ65gFMBnZ4hHilyY+F3bTFpndQa1
         ZHiNeC0+dGKGssHwt8dgOHpb4GzHA636aT7RiDrU5h+HHm1fQLCXgqFawHbCSnvGOK1R
         Z2mkd5W8/kVjsp0WyF9CFggzncP2OYg32kAH0b/nlzsRBagRmZrutVQLg1EDZV+cem3+
         S/AOygxjUKZWc/f7uf8zmHAnWq9hkQYkfT8vL5tCk8Eo/Z60MKSWEo3QBOBwAh6z0j7h
         hgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K74FSLibgRox92Ke/og8To0X7TZ2VBykrYPKh9Z5pcY=;
        b=Ex00rpgKJMUw/jTpcNznvq0zfH6oeCXHNRWuo2su4fBO49LtSIqEHpF0mTr/mC8sK+
         LWNOcKqlrTez+aU9wt4kOJcROW1oB7uUdt/e+FRgpSiP6IonESbet2U8havyIJrANchO
         a61QZSBYw4fAVh6GcN7+28dMn4UBiAnMYTk5bA+lte/fKMPtisosJSOMDZubVh/lknbu
         0ddeq+VbczAeMymQ1zQqjjaRwu9de0wl97VUTNuvOUMWPYG+9sVGmhlYwxyd0i94wno+
         crzrGy8/hwzdsR8a7njxrKeBr5fk0po2f/OZLSEb9VmnSOrjMUCdFqpanU1q3yB0nxfY
         8tKw==
X-Gm-Message-State: APjAAAW5j1iolBjBO0vM3lFWzJkJYEid77tHMVI6eG2AbikJhOh3KsV5
        Uq3gzDUe/E0yn8z/n6Knm4mcbduUmnEziKPgIAIhoOyYtHNpFw==
X-Google-Smtp-Source: APXvYqw8TxfNud+WAkN3jF6GWM7cpQopC1R+YRlW1JfifDNbx3oPxFQDYFKeZzY2DCGsB2iZqSRopVKloav1TwNXDcM=
X-Received: by 2002:a19:7b08:: with SMTP id w8mr3422573lfc.95.1570661088819;
 Wed, 09 Oct 2019 15:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191007043120.67567-1-kyan@google.com> <20191007043120.67567-2-kyan@google.com>
 <18630c07d0aa46d16cf660d013f96b3d@codeaurora.org>
In-Reply-To: <18630c07d0aa46d16cf660d013f96b3d@codeaurora.org>
From:   Kan Yan <kyan@google.com>
Date:   Wed, 9 Oct 2019 15:44:37 -0700
Message-ID: <CA+iem5tVZLoisVF=pRR7+Jx04wCGz-CJh0oLKYa6=eQbDkOTKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi  Johannes,

Thanks for the review and will address all issues you pointed out in
the next version.

Hi Yibo,
>
> I assume here the only txq in the list that does not meet AQL check will
> not be dequeued. Right? Will it affect peak throughput once there is
> only one station.

Yes, the txq won't be picked for transmitting even if it is the only
active txq if the AQL check failed.  However, this won't affect peak
throughput. The reason why there are two queue limits is address this
kind of situation. The higher queue limit ensures the hardware get
enough frames.
>
> > @@ -3748,10 +3785,10 @@ bool ieee80211_txq_may_transmit(struct
> > ieee80211_hw *hw,
> >       struct sta_info *sta;
> >       u8 ac = txq->ac;
> >
> > -     spin_lock_bh(&local->active_txq_lock[ac]);
> > -
> >       if (!txqi->txq.sta)
> > -             goto out;
> > +             return true;
>
> why return here? I think even a txq without sta info should get removed
> from list and added it back later in return_txq() if needed. No?
Yes, it should be removed from the active list. I will fix that.

Thanks,
Kan


On Wed, Oct 9, 2019 at 1:18 AM Yibo Zhao <yiboz@codeaurora.org> wrote:
>
> > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > index f13eb2f61ccf..dadb643a5498 100644
> > --- a/net/mac80211/tx.c
> > +++ b/net/mac80211/tx.c
> > @@ -3669,7 +3669,8 @@ struct ieee80211_txq *ieee80211_next_txq(struct
> > ieee80211_hw *hw, u8 ac)
> >  {
> >       struct ieee80211_local *local = hw_to_local(hw);
> >       struct ieee80211_txq *ret = NULL;
> > -     struct txq_info *txqi = NULL;
> > +     struct txq_info *txqi = NULL, *head = NULL;
> > +     bool found_eligible_txq = false;
> >
> >       spin_lock_bh(&local->active_txq_lock[ac]);
> >
> > @@ -3680,20 +3681,32 @@ struct ieee80211_txq
> > *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
> >       if (!txqi)
> >               goto out;
> >
> > +     if (txqi == head && !found_eligible_txq)
> > +             goto out;
>
> I assume here the only txq in the list that does not meet AQL check will
> not be dequeued. Right? Will it affect peak throughput once there is
> only one station.
>
> How about dequeuing it anyway regardless AQL because it is the only one
> active now so it is fine to occupy the rest bandwidth. Otherwise, I am
> afraid next_txq() will return NULL in the test only one station is
> present.
>
> > @@ -3748,10 +3785,10 @@ bool ieee80211_txq_may_transmit(struct
> > ieee80211_hw *hw,
> >       struct sta_info *sta;
> >       u8 ac = txq->ac;
> >
> > -     spin_lock_bh(&local->active_txq_lock[ac]);
> > -
> >       if (!txqi->txq.sta)
> > -             goto out;
> > +             return true;
>
> why return here? I think even a txq without sta info should get removed
> from list and added it back later in return_txq() if needed. No?
>
> > +
> > +     spin_lock_bh(&local->active_txq_lock[ac]);
> >
> >       if (list_empty(&txqi->schedule_order))
> >               goto out;
>
>
> --
> Yibo
