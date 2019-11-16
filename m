Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11909FEA3D
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 03:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfKPCWL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 21:22:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38617 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKPCWK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 21:22:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id v8so12662636ljh.5
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 18:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hGU8vg18c8rykU4X+f/twEM1FcyACBPR6hxaYpz2ycI=;
        b=haU6P4NnkHLAULTq1MlP4/cQUVT8uZPmA02AsE89LVyEYZDnUKZnYO17kKmq5kJY3i
         sk+tw06YePIuTVqNwKnzeD/dAy3N9hk4P/cDAcMfWMfKhDYzb7quzmq37y83lGbKOjvp
         fAXxW2mynCyAP+qtdJw5ayq2EnbHMtct8WIKpfkhSzuljHzoiQ+1PDeEGmgWz+WN2uV1
         7BfC7omO3BB8lTX2rqB9HeFaeBhOVObsQn8UdJLkFA2xl57mMb9L/hvNeDtUHp3p2euF
         ov/N3Jk6mdhaHmhiYNx8sREayhl+xNhrDe9Ar++nnSS6QA9AaAGNvaUMMd8sN+erd2n5
         5e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hGU8vg18c8rykU4X+f/twEM1FcyACBPR6hxaYpz2ycI=;
        b=YCgiV87/6Jp16RmPQlrRYvIjh16c+RHUEBgS2FZZZf37Q1emHFQESFwHn5r7chR+hc
         Sze/lTLof2y8x/cjYiqk0CnvL6nUGcTKXAtRVecpaOWj+eRuHjhmTQNojF05MpWRdpOw
         kNY/mll25WKU7ukdACPv0Jz251ma/tmrymqrBbrao+eYg44N0+O44xlgBd5Jeb+PnVyx
         Pfq7dbrE9vqtnU/oLeNy/LkIJeAFt5CaB6WqUhLOBpPjqrkoGbBYU7xLZAX3mCb+ppSb
         BaYNAOpVkeFDk4fvKexkfwn3MfvrmXByewQCs0RHH8DMtidUFMeUvoUARhxzuWxnzo5N
         3Qew==
X-Gm-Message-State: APjAAAWtocFYnst2dztdqa9vp9Cc99mQ79WhQKo1XS+7xTZMoOWSMduq
        q/ciwwf6tmhrVzn+6g5wdkGNRmqhpx/5JJODERCi+w==
X-Google-Smtp-Source: APXvYqx8G4+RGf76UqHpeCtjAp76KchAOEGDtObnaGI+4ErQc6JS5aHwHZtSHWi0I0LQV+1FHzxm8UsJqKits+jEKzs=
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr1808659ljj.114.1573870927439;
 Fri, 15 Nov 2019 18:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20191115014846.126007-1-kyan@google.com> <20191115014846.126007-3-kyan@google.com>
 <87k181mh7f.fsf@toke.dk>
In-Reply-To: <87k181mh7f.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Fri, 15 Nov 2019 18:21:55 -0800
Message-ID: <CA+iem5vnp7Sd6jUqhbBiijCDFygSt+g=fh5y43pN9Rp+gegCeA@mail.gmail.com>
Subject: Re: [v8 PATCH 2/2] mac80211: Implement Airtime-based Queue Limit (AQL)
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Felix Fietkau <nbd@nbd.name>, Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > +     if (sta) {
> > +             atomic_sub(tx_airtime, &sta->airtime[ac].aql_tx_pending);
> > +             tx_pending =3D atomic_read(&sta->airtime[ac].aql_tx_pendi=
ng);
> This is still racy, since you're splitting it over two calls; you'll
> need to use atomic_sub_return() instead.
> I figure we've converged now to the point where it actually makes sense
> to collect everything back into a single series; so I can just fix this
> and re-send the full series.

Thanks for help fixing this. Yes, atomic_sub_return() is better.

>
>
> > +             if (WARN_ONCE(tx_pending < 0,
> > +                           "STA %pM AC %d txq pending airtime underflo=
w: %u, %u",
> > +                           sta->addr, ac, tx_pending, tx_airtime))
> > +                     atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending,
> > +                                    tx_pending, 0);
> This could still fail if there's a concurrent modification (and you're
> not checking the return of the cmpxchg). But at least it won't clobber
> any updated value, so I guess that is acceptable since we're in "should
> never happen" territory here :)

I did this on purpose since I really don't like adding a loop to retry
here. If aql_tx_pending indeed goes negative (should never happens and
we got WARN_ONCE() to catch it) and the subsequent atomic_cmpxchg()
failed (rare racing occasions), it is still ok. In this case,
aql_tx_pending carries a negative offset and will be reset in one of
the calls to ieee80211_sta_update_pending_airtime() later.
aql_tx_pending being negative doesn't have much side-effects, such as
causing txq stuck.

On Fri, Nov 15, 2019 at 4:56 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Kan Yan <kyan@google.com> writes:
>
> > In order for the Fq_CoDel algorithm integrated in mac80211 layer to ope=
rate
> > effectively to control excessive queueing latency, the CoDel algorithm
> > requires an accurate measure of how long packets stays in the queue, AK=
A
> > sojourn time. The sojourn time measured at the mac80211 layer doesn't
> > include queueing latency in the lower layer (firmware/hardware) and CoD=
el
> > expects lower layer to have a short queue. However, most 802.11ac chips=
ets
> > offload tasks such TX aggregation to firmware or hardware, thus have a =
deep
> > lower layer queue.
> >
> > Without a mechanism to control the lower layer queue size, packets only
> > stay in mac80211 layer transiently before being sent to firmware queue.
> > As a result, the sojourn time measured by CoDel in the mac80211 layer i=
s
> > almost always lower than the CoDel latency target, hence CoDel does lit=
tle
> > to control the latency, even when the lower layer queue causes excessiv=
e
> > latency.
> >
> > The Byte Queue Limits (BQL) mechanism is commonly used to address the
> > similar issue with wired network interface. However, this method cannot=
 be
> > applied directly to the wireless network interface. "Bytes" is not a
> > suitable measure of queue depth in the wireless network, as the data ra=
te
> > can vary dramatically from station to station in the same network, from=
 a
> > few Mbps to over Gbps.
> >
> > This patch implements an Airtime-based Queue Limit (AQL) to make CoDel =
work
> > effectively with wireless drivers that utilized firmware/hardware
> > offloading. AQL allows each txq to release just enough packets to the l=
ower
> > layer to form 1-2 large aggregations to keep hardware fully utilized an=
d
> > retains the rest of the frames in mac80211 layer to be controlled by th=
e
> > CoDel algorithm.
> >
> > Signed-off-by: Kan Yan <kyan@google.com>
> > [ Toke: Keep API to set pending airtime internal, fix nits in commit ms=
g ]
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > ---
> [...]
>
> > +     if (sta) {
> > +             atomic_sub(tx_airtime, &sta->airtime[ac].aql_tx_pending);
> > +             tx_pending =3D atomic_read(&sta->airtime[ac].aql_tx_pendi=
ng);
>
> This is still racy, since you're splitting it over two calls; you'll
> need to use atomic_sub_return() instead.
>
> I figure we've converged now to the point where it actually makes sense
> to collect everything back into a single series; so I can just fix this
> and re-send the full series.
>
> > +             if (WARN_ONCE(tx_pending < 0,
> > +                           "STA %pM AC %d txq pending airtime underflo=
w: %u, %u",
> > +                           sta->addr, ac, tx_pending, tx_airtime))
> > +                     atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending,
> > +                                    tx_pending, 0);
>
> This could still fail if there's a concurrent modification (and you're
> not checking the return of the cmpxchg). But at least it won't clobber
> any updated value, so I guess that is acceptable since we're in "should
> never happen" territory here :)
>
> -Toke
>
