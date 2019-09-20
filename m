Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C713CB99DC
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 00:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406835AbfITWzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 18:55:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46673 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406782AbfITWzo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 18:55:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so6070837lfc.13
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nxWfgSHA4ZpIahWJEBH0bv66GEkrs1z/BISLSC7/wbE=;
        b=BML0ggTLzPlyVUfHbLLkqRSvUADUPVqj+LtoYU2UwkPs6AtKYA2ck36hc13Z+Cy6Ti
         GBowv6V+rItApuQRFRTna7TtJVzL5FjXF1JXhtIQ2oxO7XIXpvMG+9ez9XXJeG9m4/PM
         XP2Oj/wmTi7S6thoO1LjByHs9fO/ehRZGXEdspudXTnXnffnJ8L4ES/6yN4re17SbvGe
         dy7byV1o2B08DB/RkN1zNffqyKcRT5WsN+s1sDwiXxOicdVbTst0qurXeL1Z2VaKK639
         I7zRRW6QXROnPdWp5AMrwDI1iXafA/Q3pSSYIKPgT27JFdDCXnSJFcD2utqZ9GUu4Yy0
         29Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nxWfgSHA4ZpIahWJEBH0bv66GEkrs1z/BISLSC7/wbE=;
        b=qmNrCosjTTcPdVyfwbnDnibPwxYpsOkFaHcwFOvhVaEsbRCNhjEwYeuztKuoXhGfEH
         1Yc2HMVI8jk/K3WzVHnA6eTmZnzQ07R/un4oNtjh1kFZ15069DUWeEp9S0Aguc6eKlr7
         9hfJzJd1rxcvyqCmrD55twD0R8OPU2fVIG+oJTRfNzxdHDnqBv2gpMSTWpj9mfTukzYy
         mSioCzdXoc7ccITVxUXFjrTA/dg46KRcOJjwuby2AftNHsHQMjw4zXzDTVdHdbnIRfoA
         Iz3tMLlGYX5x5fKhDSbvPIYHwcplQH1hPbn5cnG/J3/SgW8D+SsqZoumnQbdnH+3IKk4
         syzw==
X-Gm-Message-State: APjAAAUxIbi6lfX8bUdT9NqgvZCz4v8xSGA6jtFTZeVnUWs3+gJZ7eLg
        MrgZTm+jA1qd5DVt7xeOonD3gpmofPAqILbpmTG29A==
X-Google-Smtp-Source: APXvYqzhtxIhhA/LAKYNU+3p/KG4TbbdbUK8dZsjvcyIOizB6v+dvwoWwulF4IP+gGnJ7qLAyWMQPAIlJUrTFKo51UI=
X-Received: by 2002:a19:4912:: with SMTP id w18mr9855227lfa.93.1569020142115;
 Fri, 20 Sep 2019 15:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1> <20190920120639.GA6456@localhost.localdomain>
 <87k1a39lgt.fsf@toke.dk> <20190920130604.GB6456@localhost.localdomain> <87h8579jpj.fsf@toke.dk>
In-Reply-To: <87h8579jpj.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Fri, 20 Sep 2019 15:55:30 -0700
Message-ID: <CA+iem5toLj4f-3tuJgoLx1=R2PzRUGPu+c1j7zauw7=izOUmgw@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Toke,

There is an updated version of AQL in the chromiumos tree implemented
in the mac80211 driver, instead of in the ath10k driver as the
original version:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
1703105/7
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
1703106/6

It is based on a more recent kernel (4.14) and integrated with the
airtime fairness tx scheduler in mac80211. This version has been
tested rather extensively.  I intended to use it as the basis for my
effort to bring AQL upstream, but get sidetracked by other things. I
can clean it up and send a patchset next week if you think that is the
right path. Sorry for the long delay and slack off on the upstream
effort.

There is some concern in this thread regarding the accuracy of the
estimated airtime using the last reported TX rate. It is indeed a
rather crude method and did not include retries in the calculation.
Besides, there are lags between firmware changing rate and host driver
get the rate update. The 16us IFS overhead is only correct for 5G and
it is actually 10us for 2.4 G. However, that hardly matters. The goal
of AQL is to prevent the firmware/hardware queue from getting bloated
or starved. There is a lot of headroom in the queue length limit (8-10
ms) to tolerate inaccuracy in the estimate airtime. AQL doesn't
control the fine grained TX packet scheduling. It is handled by the
airtime fairness scheduler and ultimately firmware.

There are two TX airtimes in the newer version (chromiumos 4.14
kernel): The estimated airtime for frames pending in the queue and the
airtime reported by the firmware for the frame transmitted, which
should be accurate as the firmware supposed to take retries and
aggregation into account. The airtime fairness scheduler that does the
TX packet scheduling should use the TX airtime reported by the
firmware. That's the reason why the original implementation in the
ChromiumOS tree tries to factor in aggregation size when estimate the
airtime overhead and the later version doesn't even bother with that.

Regards,
Kan


On Fri, Sep 20, 2019 at 6:32 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>
> >> >> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> >>
> >> >> Some devices have deep buffers in firmware and/or hardware which pr=
events
> >> >> the FQ structure in mac80211 from effectively limiting bufferbloat =
on the
> >> >> link. For Ethernet devices we have BQL to limit the lower-level que=
ues, but
> >> >> this cannot be applied to mac80211 because transmit rates can vary =
wildly
> >> >> between packets depending on which station we are transmitting it t=
o.
> >> >>
> >> >> To overcome this, we can use airtime-based queue limiting (AQL), wh=
ere we
> >> >> estimate the transmission time for each packet before dequeueing it=
, and
> >> >> use that to limit the amount of data in-flight to the hardware. Thi=
s idea
> >> >> was originally implemented as part of the out-of-tree airtime fairn=
ess
> >> >> patch to ath10k[0] in chromiumos.
> >> >>
> >> >> This patch ports that idea over to mac80211. The basic idea is simp=
le
> >> >> enough: Whenever we dequeue a packet from the TXQs and send it to t=
he
> >> >> driver, we estimate its airtime usage, based on the last recorded T=
X rate
> >> >> of the station that packet is destined for. We keep a running per-A=
C total
> >> >> of airtime queued for the whole device, and when that total climbs =
above 8
> >> >> ms' worth of data (corresponding to two maximum-sized aggregates), =
we
> >> >> simply throttle the queues until it drops down again.
> >> >>
> >> >> The estimated airtime for each skb is stored in the tx_info, so we =
can
> >> >> subtract the same amount from the running total when the skb is fre=
ed or
> >> >> recycled. The throttling mechanism relies on this accounting to be
> >> >> accurate (i.e., that we are not freeing skbs without subtracting an=
y
> >> >> airtime they were accounted for), so we put the subtraction into
> >> >> ieee80211_report_used_skb().
> >> >>
> >> >> This patch does *not* include any mechanism to wake a throttled TXQ=
 again,
> >> >> on the assumption that this will happen anyway as a side effect of =
whatever
> >> >> freed the skb (most commonly a TX completion).
> >> >>
> >> >> The throttling mechanism only kicks in if the queued airtime total =
goes
> >> >> above the limit. Since mac80211 calculates the time based on the re=
ported
> >> >> last_tx_time from the driver, the whole throttling mechanism only k=
icks in
> >> >> for drivers that actually report this value. With the exception of
> >> >> multicast, where we always calculate an estimated tx time on the as=
sumption
> >> >> that multicast is transmitted at the lowest (6 Mbps) rate.
> >> >>
> >> >> The throttling added in this patch is in addition to any throttling=
 already
> >> >> performed by the airtime fairness mechanism, and in principle the t=
wo
> >> >> mechanisms are orthogonal (and currently also uses two different so=
urces of
> >> >> airtime). In the future, we could amend this, using the airtime est=
imates
> >> >> calculated by this mechanism as a fallback input to the airtime fai=
rness
> >> >> scheduler, to enable airtime fairness even on drivers that don't ha=
ve a
> >> >> hardware source of airtime usage for each station.
> >> >>
> >> >> [0] https://chromium-review.googlesource.com/c/chromiumos/third_par=
ty/kernel/+/588190/13/drivers/net/wireless-4.2/ath/ath10k/mac.c#3845
> >> >>
> >> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> >> ---
> >> >>  net/mac80211/debugfs.c     |   24 ++++++++++++++++++++++++
> >> >>  net/mac80211/ieee80211_i.h |    7 +++++++
> >> >>  net/mac80211/status.c      |   22 ++++++++++++++++++++++
> >> >>  net/mac80211/tx.c          |   38 ++++++++++++++++++++++++++++++++=
+++++-
> >> >>  4 files changed, 90 insertions(+), 1 deletion(-)
> >> >
> >> > Hi Toke,
> >> >
> >> > Thx a lot for working on this. Few comments inline.
> >> >
> >> > Regards,
> >> > Lorenzo
> >> >
> >> >>
> >> >> diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
> >> >> index 568b3b276931..c846c6e7f3e3 100644
> >> >> --- a/net/mac80211/debugfs.c
> >> >> +++ b/net/mac80211/debugfs.c
> >> >> @@ -148,6 +148,29 @@ static const struct file_operations aqm_ops =
=3D {
> >> >>   .llseek =3D default_llseek,
> >> >>  };
> >> >>
> >> >
> >> > [...]
> >> >
> >> >> @@ -3581,8 +3591,19 @@ struct sk_buff *ieee80211_tx_dequeue(struct =
ieee80211_hw *hw,
> >> >>   tx.skb =3D skb;
> >> >>   tx.sdata =3D vif_to_sdata(info->control.vif);
> >> >>
> >> >> - if (txq->sta)
> >> >> + pktlen =3D skb->len + 38;
> >> >> + if (txq->sta) {
> >> >>           tx.sta =3D container_of(txq->sta, struct sta_info, sta);
> >> >> +         if (tx.sta->last_tx_bitrate) {
> >> >> +                 airtime =3D (pktlen * 8 * 1000 *
> >> >> +                            tx.sta->last_tx_bitrate_reciprocal) >>=
 IEEE80211_RECIPROCAL_SHIFT;
> >> >> +                 airtime +=3D IEEE80211_AIRTIME_OVERHEAD;
> >> >
> >> > Here we are not taking into account aggregation burst size (it is do=
ne
> >> > in a rough way in chromeos implementation) and tx retries. I have no=
t
> >> > carried out any tests so far but I think IEEE80211_AIRTIME_OVERHEAD
> >> > will led to a significant airtime overestimation. Do you think this
> >> > can be improved? (..I agree this is not a perfect world, but .. :))
> >>
> >> Hmm, yeah, looking at this again, the way I'm going this now, I should
> >> probably have used the low 16-us IFS overhead for every packet.
> >>
> >> I guess we could do something similar to what the chromeos thing is
> >> doing. I.e., adding a single "large" overhead value when we think the
> >> packet is the first of a burst, and using the smaller value for the
> >> rest.
> >>
> >> One approach could be to couple the switch to the "scheduling rounds" =
we
> >> already have. I.e., first packet after a call to
> >> ieee8021_txq_schedule_start() will get the 100-us overhead, and every
> >> subsequent one will get the low one. Not sure how this will fit with
> >> what the driver actually does, though, so I guess some experimentation
> >> is in order.
> >>
> >> Ultimately,  I'm not sure it matters that much whether occasionally ad=
d
> >> 80 us extra to the estimate. But as you say, adding 100 us to every
> >> packet is probably a bit much ;)
> >
> > Would it be possible to use the previous tx airtime reported by the
> > driver? (not sure if it is feasible). Some drivers can report airtime
> > compute in hw, the issue is it can be no not linked to the given skb
> > or aggregation burst, so we should take into account burst size
>
> That's what we do for the fairness scheduler. And yeah, if the HW can
> report after-the-fact airtime usage that is bound to be more accurate,
> so I think we should keep using that for fairness.
>
> But for this AQL thing, we really need it ahead of time. However, I
> don't think it's as important that it is super accurate. As long as we
> have a reasonable estimate I think we'll be fine. We can solve any
> inaccuracies by fiddling with the limit, I think. Similar to what BQL
> does; dynamically adjusting it up and down.
>
> So for a first pass, we can just err on the side of having the limit
> higher, and then iterate from there.
>
> >> > Moreover, can this approach be affected by some interrupt coalescing
> >> > implemented by the chipset?
> >>
> >> Probably? Ultimately we don't really know what exactly the chipset is
> >> doing, so we're guessing here, no?
> >
> > Here I mean if the hw relies on a 1:n tx interrupt/packet ratio (I
> > guess most driver do), it would probably affect throughput, right?
> > (e.g TCP)
>
> Yeah, this is what I alluded to above: If we set the limit too low, were
> are going to kill TCP throughput. Ideally, we want the limit to be as
> low as we can get it without hurting TCP (too much), but no lower. Just
> doing the conversion to airtime is a way to achieve this: This will
> scale the actual queue length with the achievable throughput as long as
> the tx rate estimate is reasonably accurate. If needed, we can add
> another layer of dynamic tuning on top using the existing BQL logic; but
> I'd like to get the basic case working first...
>
> -Toke
>
