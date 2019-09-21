Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E595B9DC4
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437803AbfIUMMB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 08:12:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59713 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437800AbfIUMMB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 08:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569067919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7RQt9uInu36bABlUG0mwgAYjvA+rS+27DOQGd8Znwtk=;
        b=enwUnjtzTQiluuspbcv8Zc3dKXildWCDzDQL/XGFG0NA8KGJvI73CbhwtLeoR4ZgS9xfrz
        IMALxJBnIeBpx95yp787UOImzCsnVEoGdaHrpF7Hl9uNWdLlG3b3xDBtnBgqj5jMhXo/MM
        PGR3ST8X7dAz2lqZ68siBpm0Gzq1CFw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-SiLdRBjXPwKK5qo99DGdnQ-1; Sat, 21 Sep 2019 08:11:58 -0400
Received: by mail-ed1-f70.google.com with SMTP id n14so5372833edt.3
        for <linux-wireless@vger.kernel.org>; Sat, 21 Sep 2019 05:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qm2YOQ5sqzKJDhxq8JmZxpCCNt0ItCloW/5yhXOXaBE=;
        b=QYbdTtipoB5zhjHnmoJ3lSDq8+XfSaeVDDQY1gHROvrFD1XiyeN5Go185xQ4OSRYl/
         ARheRKxn96zUcveDhq3sBMZlRZRy0sajlqAu3fIDi7rS1CjXmToILoL/tcI1Q1Q4EeEB
         St91f/jPn7WzyzzeD4rt82P0O6q4xBbn0xeA7dmVFYxRu7Dtp4Jt1EoZn6SprXrQ1v96
         C9kxgvSs92xDt0YptF4HMozVo4nZPNG2p0bj1ZgLLXLeoK6k2Q0sG8EIqHhNVbdfx5aw
         v9QzRVXFTo7wCDPY+N5c4Ax/W08U7p399F6Tnp3GNDiHUmWm+E+1992991tP2tGgGih3
         uHkg==
X-Gm-Message-State: APjAAAW91S2ubheStP3ZVvE6Tfr+1cTZCitNLKbrhhaxHto1ptvScmDY
        nibeddDi3Q9C4Db25OYNlFA5/XW4Zh4JeasBtCSPgGqmkN3FWk6WaSglPJX3zPXtU4iEYUhxxwN
        HcQTawNJH3ZymmP5f4DEwTGJqIkU=
X-Received: by 2002:a17:906:1ed1:: with SMTP id m17mr22582574ejj.82.1569067914199;
        Sat, 21 Sep 2019 05:11:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBdukftE1uFzu6JtUiFa64klK19cYTZPrKV5B7+OP6LWcmE/hsc1z/EeXCAv8Le0WRdhB86Q==
X-Received: by 2002:a17:906:1ed1:: with SMTP id m17mr22582557ejj.82.1569067913936;
        Sat, 21 Sep 2019 05:11:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id f26sm981563edb.55.2019.09.21.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 05:11:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 84A1818063F; Sat, 21 Sep 2019 14:11:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <CA+iem5toLj4f-3tuJgoLx1=R2PzRUGPu+c1j7zauw7=izOUmgw@mail.gmail.com>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <20190920120639.GA6456@localhost.localdomain> <87k1a39lgt.fsf@toke.dk> <20190920130604.GB6456@localhost.localdomain> <87h8579jpj.fsf@toke.dk> <CA+iem5toLj4f-3tuJgoLx1=R2PzRUGPu+c1j7zauw7=izOUmgw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 21 Sep 2019 14:11:52 +0200
Message-ID: <87d0ft7ss7.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: SiLdRBjXPwKK5qo99DGdnQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> Hi Toke,
>
> There is an updated version of AQL in the chromiumos tree implemented
> in the mac80211 driver, instead of in the ath10k driver as the
> original version:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/=
+/1703105/7
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/=
+/1703106/6

Ah, that's awesome! Thank you for brining this up :)

> It is based on a more recent kernel (4.14) and integrated with the
> airtime fairness tx scheduler in mac80211. This version has been
> tested rather extensively. I intended to use it as the basis for my
> effort to bring AQL upstream, but get sidetracked by other things. I
> can clean it up and send a patchset next week if you think that is the
> right path.

Yes, please do! AFAICT, the main difference is that your version keeps
the airtime calculation itself in the driver, while mine passes up the
rate and lets mac80211 do the calculation of airtime. Other than that,
the differences are minor, no?

I'm not actually sure which approach is best; I suspect doing all the
accounting in mac80211 will help with integrating this into drivers that
use minstrel; we can just add a hook in that and be done with it.
Whereas if the driver has to do the accounting, we would need to add
that to each driver (mt76, iwl(?)).

But of course, doing things in mac80211 depends on stuffing even more
stuff into the already overloaded cb field; and I'm not actually
entirely sure what I've done with that will actually work. WDYT?

In any case, if you post your series we'll have something to contrast
against, which I think will be useful to help us converge on something
we can all be happy with.

Of course we'll also have to eventually integrate this with the other
series that Yibo recently re-posted (the virtual time scheduler). I
think that will be relatively straight forward, except I'm not sure your
atomic patches will work when we also have to update the rbtree. Any
thoughts on that series in general?

> Sorry for the long delay and slack off on the upstream effort.

Hehe, no worries. I only posted this because Dave finally bugged me into
doing something about this at LPC. And hey, we're making progress now,
so that's good! :)

> There is some concern in this thread regarding the accuracy of the
> estimated airtime using the last reported TX rate. It is indeed a
> rather crude method and did not include retries in the calculation.
> Besides, there are lags between firmware changing rate and host driver
> get the rate update. The 16us IFS overhead is only correct for 5G and
> it is actually 10us for 2.4 G. However, that hardly matters. The goal
> of AQL is to prevent the firmware/hardware queue from getting bloated
> or starved. There is a lot of headroom in the queue length limit (8-10
> ms) to tolerate inaccuracy in the estimate airtime. AQL doesn't
> control the fine grained TX packet scheduling. It is handled by the
> airtime fairness scheduler and ultimately firmware.

Yeah, this was basically the point I was trying to make; this limit
doesn't need to be that accurate, we just need a rough estimate. If we
want to get the latency even lower later, we're better off fiddling with
the queue limit value than trying to improve the airtime estimate.

> There are two TX airtimes in the newer version (chromiumos 4.14
> kernel): The estimated airtime for frames pending in the queue and the
> airtime reported by the firmware for the frame transmitted, which
> should be accurate as the firmware supposed to take retries and
> aggregation into account. The airtime fairness scheduler that does the
> TX packet scheduling should use the TX airtime reported by the
> firmware. That's the reason why the original implementation in the
> ChromiumOS tree tries to factor in aggregation size when estimate the
> airtime overhead and the later version doesn't even bother with that.

Yup, makes sense. Looking at the version you linked to, though, it seems
you're calling ieee80211_sta_register_airtime() with the estimated value
as well? So are you double-accounting airtime, or are you adjusting for
the accurate values somewhere else I don't see in that series?

-Toke

