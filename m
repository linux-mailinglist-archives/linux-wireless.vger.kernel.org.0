Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52955C2CB4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 06:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJAErd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 00:47:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37483 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfJAErc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 00:47:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so11852824lje.4
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2019 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JHQkAiHVzplCQNOguqdKc7eWlycFDXP/ryC23H4Nkww=;
        b=JsZJ4R7B0/0ow+5u7gyfyNAvbMYwrarKWczuQfRRL7p3w08ZQELjZP0eiJsxFLBOe6
         NiMDVbwYWaJYApjOtRKZT2C+7cosLi0DZt0+wm5wqwtvbStLvFity/XTiSywSWe2CDT2
         VZ6OGHAnKBSn5iIidq5dqKv794rIWbHdpNkMzbV1Cn9sICSAyKGayKzY2LrF6zTjsO0p
         ymoP/BMpuf4IYQaqioq//o6fcrVYYjEwg+hSJG5MmHq5c/QP1bgDRVxCbuKL47cCPalQ
         1WHNvnoI74y2Q4Nh5brGs6sG4iPzgXY0s0D351+flALll/giSui+dvHTQpsdxhrl6U5b
         rmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JHQkAiHVzplCQNOguqdKc7eWlycFDXP/ryC23H4Nkww=;
        b=BNOPB4drDO1JGpeFiMoLHw20GqO4WimiAxCgdgINpFvynD6dkjb7Nh2/vy1aKH8BeU
         LE11aelv1HGO2g3rAQoZmWFD58c7i7vXKoiGp0N7JjqHjfAvK0jx6KdZpgjkejyJ0k2I
         pEilAltglqgXLnxDjZVjGkxIh9ET2QvFM72FAg0mYjH48GNI8A4c3vObtWMG7Hfrtev9
         YUiaK9A3yYGcn9oXQgsrshgl/woJq9YG83bt/YoRrzmiFy6YojndcVixutMyX/P/x50R
         rjm/awkRSX1/EyJCLEClRIbaUBhC/iDqhTze8CTbL5ljzE8sCMEX2UBNXTByuGCLvR2o
         PRgg==
X-Gm-Message-State: APjAAAUzZ4P63jUysTOBssHi53M14FzRJhQQJA/ugQGDjjC1WNujTdz/
        yems1wSxcw/YtZLqI5AQ5iO+k5bt1lNF/WfNnbRtYw==
X-Google-Smtp-Source: APXvYqzr4kRTFSCZNf4/0ac6IWGTEIww2OSi4IHxmlJrElUV0rU/KOOl1b9x/3CYoEfTvltRJwDP3qhXu5US/QAFHdM=
X-Received: by 2002:a2e:9a03:: with SMTP id o3mr12593946lji.51.1569905249764;
 Mon, 30 Sep 2019 21:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1> <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name>
 <87wodv19jl.fsf@toke.dk> <b0239b81-e3db-1f10-22cb-ad06536b97a8@nbd.name>
 <87tv8z13wv.fsf@toke.dk> <CA+iem5uir8GOq2psAVuUParY3MimsGhvdefUopiwHov128CQQA@mail.gmail.com>
 <87r2421d4f.fsf@toke.dk> <ed46699c32cd3d8d8bcc9bce1375ba04@codeaurora.org>
 <CA+iem5sGkRQy4B=Mz-C90sfqgFmuywa=W7Yjy2CDd8hfppQkvQ@mail.gmail.com> <87muemykqn.fsf@toke.dk>
In-Reply-To: <87muemykqn.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Mon, 30 Sep 2019 21:47:18 -0700
Message-ID: <CA+iem5tDU9RYdUJ5y1E3E1iFRsSX_rA8dbDjaviGBxKyMS_3kA@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Yibo Zhao <yiboz@codeaurora.org>, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> I guess the risk is lower when with a 24ms per-iface limit; but with
> enough stations I guess it could still happen, no? So we should probably
> handle this case...
Each txq (per sta, per tid) is allowed to release at least the lower
AQL limit amount of packet (default 4ms), which is not affected by
other station's PS behavior and 4ms should be sufficient for most use
cases.
The 24ms per-interface limit is an optimization to get good benchmark
score in peak performance test, which usually only involve 1-2
stations. The higher limit probably won't matter anymore when there
are many stations. I haven't noticed side effects due to PS behavior
in the ChromiumOS version. Still, it is better to be able to take
frames in PS queue in to account,

> Cool. Are you going to submit a ported version of your implementation?
> Then we can work from the two submissions and see if we can't converge
> on something...
Working on porting, should have something ready before the end of this week=
.


On Sun, Sep 29, 2019 at 12:18 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> Kan Yan <kyan@google.com> writes:
>
> >> No, ath10k would continue to do what it was always doing. Drivers that
> >> can report after-the-fact airtime usage per-frame (like ath9k) will
> >> continue to do that. In both of those cases, the airtime estimate is
> >> only used to throttle the queue, not to schedule for fairness.
> > You are right, I didn't realize ath9k reports per frame airtime usage.
> >
> >> Yeah, I was wondering about that. Makes sense. Why 24ms, exactly?
> > The per interface 24 ms queue limit is an empirical number that works
> > well for both achieve low latency when there is a lot of stations and
> > get high throughput when there is only 1-2 stations.  We could make it
> > configurable.
>
> Right. "Found by trial and error" is a fine answer as far as I'm
> concerned :)
>
> But yeah, this should probably be configurable, like BQL is.
>
> >> BTW, I think Felix' concern about powersave was in relation to AQL: If
> >> we don't handle power save in that, we can end up in a situation where
> >>the budget for packets allowed to be queued in the firmware is taken up
> >> entirely by stations that are currently in powersave mode; which would
> >> throttle the device completely. So we should take that into account fo=
r
> >> AQL; for the fairness scheduler, stations in powersave are already
> >> unscheduled, so that should be fine.
> > I think the accounting for the airtime of frames in the power saving
> > queue could affect both the fairness scheduler and AQL.
> > For chipset with firmware offload, PS handling is mostly done by
> > firmware, so host driver's knowledge of PS state could be slightly
> > out-of-dated. The power save behavior also make it harder to the
> > airtime_weight correct for the fairness scheduler.
>
> Hmm, maybe. I'm not sure how significant this effect would be, but I
> guess we'll need to find out :)
>
>
> > Powersave mode's impact to AQL is much smaller. The lower per station
> > queue limit is not impacted by other stations PS behavior, since the
> > estimated future airtime is not weighted for other stations and a
> > station won't get blocked due to others stations in PS mode.
> > Station in PS mode do affects AQL's higher per interface limit, but in
> > an inconsequential way. The per interface AQL queue limit is quite
> > large (24 ms), hence airtime from packets in PS queue is unlikely to
> > have a significant impact on it. Still, it will be better if the
> > packet in power saving queue can be taken into account.
>
> I guess the risk is lower when with a 24ms per-iface limit; but with
> enough stations I guess it could still happen, no? So we should probably
> handle this case...
>
> >> > make it easier to schedule multiple stations, I think it has some me=
rit
> >> > that makes it worth trying out. We should probably get the AQL stuff
> >> > done first, though, and try the virtual time scheduler on top of tha=
t.
> >> Agree that we should get the AQL stuff done first since I believe it
> >> will help to fix the issue mentioned above.
> > That sounds like a good plan. The virtual time scheduler is more
> > involved and will take more work to get it right. It make sense to get
> > AQL done first.
>
> Cool. Are you going to submit a ported version of your implementation?
> Then we can work from the two submissions and see if we can't converge
> on something...
>
> -Toke
>
