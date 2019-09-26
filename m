Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6736DBE975
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 02:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfIZA1q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 20:27:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37545 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfIZA1q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 20:27:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so318690lff.4
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2019 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SOk8Ei2vHefaSgbX3xmMLxTb+Pb7I+KXEczPThmcScw=;
        b=tS4qLH7t1hNnasUY/IlsfgSlf7es/bSIOeO+yVpDKpBVVE4U1IYWpvJ5eykzWit7rQ
         Y9yqbkuwEJgeTS3iP/ebv6MmWEFLGmRr8+WqRocy5QuN+sE3abcKXC62/3q81NXLpzTx
         kpgqdiGs7RhY6zGgU0qH8fNPNqsnwX2xj2f4BfGU1L+0yRcqLFhHiZxAdvhI/AERCcD6
         LXNUNlYmRfUDV/GpFLQmutf8y3KknvY2vpNRXVOa3OCMySUjgnQr/z2LXFhsICim342o
         4w2Fu1bJzs7KXy5r4Cte1XJmIHdtLm8Ac5t0ra5Axa9HuYhkwFYhA7Yz6PhEk9bx9ccW
         cO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SOk8Ei2vHefaSgbX3xmMLxTb+Pb7I+KXEczPThmcScw=;
        b=Gm76i3CzjZ3LA+P7cO4JXqcBZOwwDxwjTZQTPcQ9tjGNtBIpq7+i2a4Nlzx7KWs3+/
         yYcCTo/XJylwSfmvlNPTpnCqCjj0Yyory5Lvd4/cTTtoekA78YbYz6I70B/859fkFjv/
         5ALEWF3GY8h8rWRGKoWzK6QR0SHgBsFpw5esRD92Ihh/iMKbsPLK1fIeaVMSmituNAkX
         wAWX54pHNjoDoADUdXlElnRzTWAKwCxN6mECblRfnb71KpEEjFB0baTYKbs2TZ92Dfqx
         7yzvh1vwN6BMqniOJ9UYdTHD3vNdqkjNjvDNtgGJRIlVWEycNLbXj449U3g5w0oq7V8H
         ZgAA==
X-Gm-Message-State: APjAAAVmte/f0mkdSR4j5rbHkYViX60FOEC54hZnV8ubBD789a29OSTo
        h7jsnnWNjxis0o+3t3wQr9kQYzktYfZwvRGjQtjU6w==
X-Google-Smtp-Source: APXvYqxI3YcynKUrBrwIDC+HdRQ5iLb1nMTXyl1kEmmLRnezbGpxELkC38GFrvDECZI6qa4hcVgcMHYQrA21xzfbWjE=
X-Received: by 2002:a19:4912:: with SMTP id w18mr360431lfa.93.1569457662745;
 Wed, 25 Sep 2019 17:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1> <2f6b649dcb788222e070ebb5593918c7@codeaurora.org>
 <87y2yc3ieb.fsf@toke.dk> <8c5a3a011f03d4dd4165b838a2b8bc72@codeaurora.org> <87mues35d4.fsf@toke.dk>
In-Reply-To: <87mues35d4.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Wed, 25 Sep 2019 17:27:31 -0700
Message-ID: <CA+iem5sg-YpkBX4VQPzqibN0YApMxtwFsGqjK2cUUrxD_52zPw@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Yibo Zhao <yiboz@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Yes, please do! AFAICT, the main difference is that your version keeps
> the airtime calculation itself in the driver, while mine passes up the
> rate and lets mac80211 do the calculation of airtime. Other than that,
> the differences are minor, no?
> I'm not actually sure which approach is best; I suspect doing all the
> accounting in mac80211 will help with integrating this into drivers that
> use minstrel; we can just add a hook in that and be done with it.
> Whereas if the driver has to do the accounting, we would need to add
> that to each driver (mt76, iwl(?)).

Yes, they are essentially doing the same thing. I kept the airtime
estimation code in the ath10k just because it is already there. It is
better to do that in mac80211, so it doesn't have to be duplicated for
each driver and avoids the overhead of updating the estimated airtime
from host driver to mac80211.

> But of course, doing things in mac80211 depends on stuffing even more
> stuff into the already overloaded cb field; and I'm not actually
> entirely sure what I've done with that will actually work. WDYT?
Either way a field in skb cb is needed to record the estimated
airtime. The  'tx_time_est' shares the space with the codel
'enque_time' looks fine to me, as their lifetime doesn't overlap.

There is another minor difference in the ChromiumOs version, which
actually address the issue Yibo just asked:
> Meanwhile, airtime_queued will also limit the situation that we only
> have a station for transmission. Not sure if the peak throughput will be
> impacted. I believe it may work fine with 11ac in chromiumos, how about
> 11n and 11a?

My version has two AQL limits, a smaller per station limit (4ms) and a
larger per interface limit (24 ms). When the per interface limit has
not been reached, stations are allowed to transmit up to 1/3 of the
interface limits (8ms). This way it balance the needs to control
latency when there are a lot of stations and to get good throughput
benchmark numbers with a single client. In my test, I found increasing
the AQL limit to beyond 8 ms doesn't helps peak throughput on 4x4
ath10k chipset.
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
1734867/3/net/mac80211/tx.c#b3734

> Of course we'll also have to eventually integrate this with the other
> series that Yibo recently re-posted (the virtual time scheduler). I
> think that will be relatively straight forward, except I'm not sure your
> atomic patches will work when we also have to update the rbtree. Any
> thoughts on that series in general?
I do like the virtual time scheduler patchset. It makes it easier to
schedule an arbitrary tx queue and handles ath10k's firmware pulling
mode better. I will give it a try.

> Yup, makes sense. Looking at the version you linked to, though, it seems
> you're calling ieee80211_sta_register_airtime() with the estimated value
> as well? So are you double-accounting airtime, or are you adjusting for
> the accurate values somewhere else I don't see in that series?
It does not double count airtime, just both the airtime fairness
scheduler and AQL use the estimate airtime. It is on an older tree and
still doesn't have the patch that provides the fw airtime:
https://patchwork.kernel.org/patch/10684689


On Wed, Sep 25, 2019 at 5:52 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Yibo Zhao <yiboz@codeaurora.org> writes:
>
> > On 2019-09-25 16:11, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Yibo Zhao <yiboz@codeaurora.org> writes:
> >>
> >>> So if it is going to work together with virtual time based mechanism
> >>> in
> >>> the future, the Tx criteria will be met both of below conditions,
> >>>         1. Lower than g_vt
> >>>         2. Lower than IEEE80211_AIRTIME_QUEUE_LIMIT
> >>
> >>> Are we going to maintain two kinds of airtime that one is from
> >>> estimation and the other is basically from FW reporting?
> >>
> >> Yes, that was my plan. For devices that don't have FW reporting of
> >> airtime, we can fall back to the estimation; but if we do have FW
> >> reporting that is most likely going to be more accurate, so better to
> >> use that for fairness...
> >
> > Do you mean we will use airtime reported by FW to calculate
> > local->airtime_queued in case we have FW reporting airtime?
>
> No, the opposite; if the firmware can't report airtime, we can use the
> estimated values to feed into report_airtime() for the fairness
> calculation...
>
> -Toke
>
