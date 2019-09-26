Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2930BE98E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 02:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbfIZAeS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 20:34:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36875 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388416AbfIZAeR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so327375lff.4
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2019 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SEO1ueVCg3O11f5lw9PuDZUKcfnoP+wBegAFrHvgP5w=;
        b=q2A+5XhlFgcRvvFJ37nud7xQKo7FDvzBud+SvmizY6Q1BLEoWfqhMA6CieMRpV+32v
         lFY3WoXerOV0SVFtySUQQMEMWckZYM+DBLPjSJ64SR9GI1O3J2+7njf9ave3Ght2jnxs
         btPfb/iHtJdX60McsWalXmIcwmUxxnE0Uf7ao008YJ6A/uspVvfhk90mHHpP9uBOGyQn
         wLcKTazPbOsZlsPTwWG+QSb4sUp9xhQ9mFNNVg3s+yQZDlKQqsw12b+Fg8lcP8khCxZ6
         rwv+qKHoA6Ch/rc5vOyURRHIderztjBYEsraM9ra790CNWcF1vcrd3uFcKS9IctSCqz/
         M9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SEO1ueVCg3O11f5lw9PuDZUKcfnoP+wBegAFrHvgP5w=;
        b=quKHAcAKuWF5GGafPNmLdwClBgThmYnywcH6exygFRtfL2SceBwQ3VXEKRyNNtPXHG
         79RNjA+jwUQM6mayf551GI1TrWLRsd4GLAn39Wkkv8UBxBhJ/ZwMwyr54fbHwenE1R8D
         tz2U/8mlgruL+XF4BRPq2/wB70UanzZG85sLHi2ZxyQnDjg49IqL0Ofwvipd7FjWIxIN
         3NBHNE016pOk79a8VPqW8nlP/wEH5qPkTHnctjaX7O+04wIamFd61uNSBRI4CzZuy6LU
         LQXArsOHCavBZzE7zt/1ObgXfuN+7BaKOtiTAqZhqHGT57BEXnShNqO8S6nf4qbVwUx0
         DJpQ==
X-Gm-Message-State: APjAAAVus8g8PakWVaFdKm/+tYAMjJJ8OeoweS38hNq0QgQfZDIv2twL
        yTEv1uJqXXzRPLaHPTvQHzvZqarZJTRkv4n/IXOSAN2iow5nvg==
X-Google-Smtp-Source: APXvYqymXM37pgsRtqQmNA0sOiqUOlCbN9s8GwcvUlY7I3CFZcD/Vk1xetR7DwpaOq2dcP7dcVo1tjVgrlxi54zIgAg=
X-Received: by 2002:a19:9145:: with SMTP id y5mr403038lfj.88.1569458054696;
 Wed, 25 Sep 2019 17:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1> <2f6b649dcb788222e070ebb5593918c7@codeaurora.org>
 <87y2yc3ieb.fsf@toke.dk> <8c5a3a011f03d4dd4165b838a2b8bc72@codeaurora.org>
 <87mues35d4.fsf@toke.dk> <CA+iem5sg-YpkBX4VQPzqibN0YApMxtwFsGqjK2cUUrxD_52zPw@mail.gmail.com>
In-Reply-To: <CA+iem5sg-YpkBX4VQPzqibN0YApMxtwFsGqjK2cUUrxD_52zPw@mail.gmail.com>
From:   Kan Yan <kyan@google.com>
Date:   Wed, 25 Sep 2019 17:34:03 -0700
Message-ID: <CA+iem5uGU0mQ=37dvp-pnvyk_T9o5cp7vOpsi90U9X-rMjtZ5w@mail.gmail.com>
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

> > Do you mean we will use airtime reported by FW to calculate
>
> > local->airtime_queued in case we have FW reporting airtime?
> No, the opposite; if the firmware can't report airtime, we can use the
> estimated values to feed into report_airtime() for the fairness
> calculation...
The local->airtime_queued is the 'future' airtime for the packet
pending the queue. It can't be replaced by the after the fact airtime
reported from firmware for the frames transmitted.


On Wed, Sep 25, 2019 at 5:27 PM Kan Yan <kyan@google.com> wrote:
>
> > Yes, please do! AFAICT, the main difference is that your version keeps
> > the airtime calculation itself in the driver, while mine passes up the
> > rate and lets mac80211 do the calculation of airtime. Other than that,
> > the differences are minor, no?
> > I'm not actually sure which approach is best; I suspect doing all the
> > accounting in mac80211 will help with integrating this into drivers tha=
t
> > use minstrel; we can just add a hook in that and be done with it.
> > Whereas if the driver has to do the accounting, we would need to add
> > that to each driver (mt76, iwl(?)).
>
> Yes, they are essentially doing the same thing. I kept the airtime
> estimation code in the ath10k just because it is already there. It is
> better to do that in mac80211, so it doesn't have to be duplicated for
> each driver and avoids the overhead of updating the estimated airtime
> from host driver to mac80211.
>
> > But of course, doing things in mac80211 depends on stuffing even more
> > stuff into the already overloaded cb field; and I'm not actually
> > entirely sure what I've done with that will actually work. WDYT?
> Either way a field in skb cb is needed to record the estimated
> airtime. The  'tx_time_est' shares the space with the codel
> 'enque_time' looks fine to me, as their lifetime doesn't overlap.
>
> There is another minor difference in the ChromiumOs version, which
> actually address the issue Yibo just asked:
> > Meanwhile, airtime_queued will also limit the situation that we only
> > have a station for transmission. Not sure if the peak throughput will b=
e
> > impacted. I believe it may work fine with 11ac in chromiumos, how about
> > 11n and 11a?
>
> My version has two AQL limits, a smaller per station limit (4ms) and a
> larger per interface limit (24 ms). When the per interface limit has
> not been reached, stations are allowed to transmit up to 1/3 of the
> interface limits (8ms). This way it balance the needs to control
> latency when there are a lot of stations and to get good throughput
> benchmark numbers with a single client. In my test, I found increasing
> the AQL limit to beyond 8 ms doesn't helps peak throughput on 4x4
> ath10k chipset.
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/=
+/1734867/3/net/mac80211/tx.c#b3734
>
> > Of course we'll also have to eventually integrate this with the other
> > series that Yibo recently re-posted (the virtual time scheduler). I
> > think that will be relatively straight forward, except I'm not sure you=
r
> > atomic patches will work when we also have to update the rbtree. Any
> > thoughts on that series in general?
> I do like the virtual time scheduler patchset. It makes it easier to
> schedule an arbitrary tx queue and handles ath10k's firmware pulling
> mode better. I will give it a try.
>
> > Yup, makes sense. Looking at the version you linked to, though, it seem=
s
> > you're calling ieee80211_sta_register_airtime() with the estimated valu=
e
> > as well? So are you double-accounting airtime, or are you adjusting for
> > the accurate values somewhere else I don't see in that series?
> It does not double count airtime, just both the airtime fairness
> scheduler and AQL use the estimate airtime. It is on an older tree and
> still doesn't have the patch that provides the fw airtime:
> https://patchwork.kernel.org/patch/10684689
>
>
> On Wed, Sep 25, 2019 at 5:52 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
> >
> > Yibo Zhao <yiboz@codeaurora.org> writes:
> >
> > > On 2019-09-25 16:11, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > >> Yibo Zhao <yiboz@codeaurora.org> writes:
> > >>
> > >>> So if it is going to work together with virtual time based mechanis=
m
> > >>> in
> > >>> the future, the Tx criteria will be met both of below conditions,
> > >>>         1. Lower than g_vt
> > >>>         2. Lower than IEEE80211_AIRTIME_QUEUE_LIMIT
> > >>
> > >>> Are we going to maintain two kinds of airtime that one is from
> > >>> estimation and the other is basically from FW reporting?
> > >>
> > >> Yes, that was my plan. For devices that don't have FW reporting of
> > >> airtime, we can fall back to the estimation; but if we do have FW
> > >> reporting that is most likely going to be more accurate, so better t=
o
> > >> use that for fairness...
> > >
> > > Do you mean we will use airtime reported by FW to calculate
> > > local->airtime_queued in case we have FW reporting airtime?
> >
> > No, the opposite; if the firmware can't report airtime, we can use the
> > estimated values to feed into report_airtime() for the fairness
> > calculation...
> >
> > -Toke
> >
