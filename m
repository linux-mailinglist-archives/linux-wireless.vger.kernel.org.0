Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0E7B90B1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfITNcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 09:32:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30686 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725842AbfITNcq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 09:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568986364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIMQ42Sw8Hd9uIst5uE+3wtoqBljS/4EHk2QD30OcGw=;
        b=By3Ym+/6hZ3dwqq007aTUFS/A048B79ySqtn8m3Jxx67nEpCojfASaCzTC1nLpP70Mq6b3
        vxV1vPaV/L3LGZLnwf6SqrBfhAmfYSiVmdDctddILNUliHt0W2pYUAsV4YPkSJPRDsHYAe
        GiwjLrCmO/rjKeS14dmhp3A3p3sczdM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-hOr-J5bnP9-Pu6-GMRkpyw-1; Fri, 20 Sep 2019 09:32:43 -0400
Received: by mail-ed1-f72.google.com with SMTP id k5so789126edx.13
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 06:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aw5DtyEyUsPNvcBwktctk1CLPkf90JBH40BC4AU4FLQ=;
        b=F/8lVEB2FPnBajerNxW5COvD2srJ6hDybkzPk3a4cOOA6dVeVoJ/w0vCgKm7B2Avjy
         Z59u4rkBKMGwPEyxqecWyiZnG6NFHU8rwUKqAShRWRzwtba+wZXXMfgoV/vuTrkuZQG6
         LI4teT8g0nxKijo5H+2mS6RKqdxnrTHfD0ExnhF+hfzRZwzBI85uWsGOTFoyEFhHK8fv
         N0CRSQTXY9X6Fv8KKvV/bMkLFpoZPN2/j1EnJe0yFmYbDqp8o/ovrvyX/gl6e8nOXNox
         VAC3D9afo02WIwyM7nfS8uvs4aHn6kZNrigTACSf11Eyo9O2DX74U/oGoIv2xNGWUT7w
         sJWg==
X-Gm-Message-State: APjAAAVXL4QfGvG7ojgHciHDkVg3ZBalYUoMYKChWRud9cW/Kfkch12t
        Psi4XYi/hwa7jCQFQLuw4RGah3I5rz0iGgwlel+nXQZ6NktmSyWL4dGi7sim+0Cx5+/fXmlRgCN
        RbOKcgjVCLICUlhyVamKoF29oJGI=
X-Received: by 2002:a17:906:fc2:: with SMTP id c2mr3201397ejk.261.1568986361879;
        Fri, 20 Sep 2019 06:32:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzX5AKyrhb7CoEjZB4pRdAo+/QHMDTGEsNTNfbXrC4y9p5KyLu/yEqAAYhF89iw5OWcMQw+Ew==
X-Received: by 2002:a17:906:fc2:: with SMTP id c2mr3201378ejk.261.1568986361630;
        Fri, 20 Sep 2019 06:32:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id n12sm329437edi.1.2019.09.20.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 06:32:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5B04718063E; Fri, 20 Sep 2019 15:32:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <20190920130604.GB6456@localhost.localdomain>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <20190920120639.GA6456@localhost.localdomain> <87k1a39lgt.fsf@toke.dk> <20190920130604.GB6456@localhost.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 20 Sep 2019 15:32:40 +0200
Message-ID: <87h8579jpj.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: hOr-J5bnP9-Pu6-GMRkpyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>=20
>> >> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >>=20
>> >> Some devices have deep buffers in firmware and/or hardware which prev=
ents
>> >> the FQ structure in mac80211 from effectively limiting bufferbloat on=
 the
>> >> link. For Ethernet devices we have BQL to limit the lower-level queue=
s, but
>> >> this cannot be applied to mac80211 because transmit rates can vary wi=
ldly
>> >> between packets depending on which station we are transmitting it to.
>> >>=20
>> >> To overcome this, we can use airtime-based queue limiting (AQL), wher=
e we
>> >> estimate the transmission time for each packet before dequeueing it, =
and
>> >> use that to limit the amount of data in-flight to the hardware. This =
idea
>> >> was originally implemented as part of the out-of-tree airtime fairnes=
s
>> >> patch to ath10k[0] in chromiumos.
>> >>=20
>> >> This patch ports that idea over to mac80211. The basic idea is simple
>> >> enough: Whenever we dequeue a packet from the TXQs and send it to the
>> >> driver, we estimate its airtime usage, based on the last recorded TX =
rate
>> >> of the station that packet is destined for. We keep a running per-AC =
total
>> >> of airtime queued for the whole device, and when that total climbs ab=
ove 8
>> >> ms' worth of data (corresponding to two maximum-sized aggregates), we
>> >> simply throttle the queues until it drops down again.
>> >>=20
>> >> The estimated airtime for each skb is stored in the tx_info, so we ca=
n
>> >> subtract the same amount from the running total when the skb is freed=
 or
>> >> recycled. The throttling mechanism relies on this accounting to be
>> >> accurate (i.e., that we are not freeing skbs without subtracting any
>> >> airtime they were accounted for), so we put the subtraction into
>> >> ieee80211_report_used_skb().
>> >>=20
>> >> This patch does *not* include any mechanism to wake a throttled TXQ a=
gain,
>> >> on the assumption that this will happen anyway as a side effect of wh=
atever
>> >> freed the skb (most commonly a TX completion).
>> >>=20
>> >> The throttling mechanism only kicks in if the queued airtime total go=
es
>> >> above the limit. Since mac80211 calculates the time based on the repo=
rted
>> >> last_tx_time from the driver, the whole throttling mechanism only kic=
ks in
>> >> for drivers that actually report this value. With the exception of
>> >> multicast, where we always calculate an estimated tx time on the assu=
mption
>> >> that multicast is transmitted at the lowest (6 Mbps) rate.
>> >>=20
>> >> The throttling added in this patch is in addition to any throttling a=
lready
>> >> performed by the airtime fairness mechanism, and in principle the two
>> >> mechanisms are orthogonal (and currently also uses two different sour=
ces of
>> >> airtime). In the future, we could amend this, using the airtime estim=
ates
>> >> calculated by this mechanism as a fallback input to the airtime fairn=
ess
>> >> scheduler, to enable airtime fairness even on drivers that don't have=
 a
>> >> hardware source of airtime usage for each station.
>> >>=20
>> >> [0] https://chromium-review.googlesource.com/c/chromiumos/third_party=
/kernel/+/588190/13/drivers/net/wireless-4.2/ath/ath10k/mac.c#3845
>> >>=20
>> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> ---
>> >>  net/mac80211/debugfs.c     |   24 ++++++++++++++++++++++++
>> >>  net/mac80211/ieee80211_i.h |    7 +++++++
>> >>  net/mac80211/status.c      |   22 ++++++++++++++++++++++
>> >>  net/mac80211/tx.c          |   38 ++++++++++++++++++++++++++++++++++=
+++-
>> >>  4 files changed, 90 insertions(+), 1 deletion(-)
>> >
>> > Hi Toke,
>> >
>> > Thx a lot for working on this. Few comments inline.
>> >
>> > Regards,
>> > Lorenzo
>> >
>> >>=20
>> >> diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
>> >> index 568b3b276931..c846c6e7f3e3 100644
>> >> --- a/net/mac80211/debugfs.c
>> >> +++ b/net/mac80211/debugfs.c
>> >> @@ -148,6 +148,29 @@ static const struct file_operations aqm_ops =3D =
{
>> >>  =09.llseek =3D default_llseek,
>> >>  };
>> >> =20
>> >
>> > [...]
>> >
>> >> @@ -3581,8 +3591,19 @@ struct sk_buff *ieee80211_tx_dequeue(struct ie=
ee80211_hw *hw,
>> >>  =09tx.skb =3D skb;
>> >>  =09tx.sdata =3D vif_to_sdata(info->control.vif);
>> >> =20
>> >> -=09if (txq->sta)
>> >> +=09pktlen =3D skb->len + 38;
>> >> +=09if (txq->sta) {
>> >>  =09=09tx.sta =3D container_of(txq->sta, struct sta_info, sta);
>> >> +=09=09if (tx.sta->last_tx_bitrate) {
>> >> +=09=09=09airtime =3D (pktlen * 8 * 1000 *
>> >> +=09=09=09=09   tx.sta->last_tx_bitrate_reciprocal) >> IEEE80211_RECI=
PROCAL_SHIFT;
>> >> +=09=09=09airtime +=3D IEEE80211_AIRTIME_OVERHEAD;
>> >
>> > Here we are not taking into account aggregation burst size (it is done
>> > in a rough way in chromeos implementation) and tx retries. I have not
>> > carried out any tests so far but I think IEEE80211_AIRTIME_OVERHEAD
>> > will led to a significant airtime overestimation. Do you think this
>> > can be improved? (..I agree this is not a perfect world, but .. :))
>>=20
>> Hmm, yeah, looking at this again, the way I'm going this now, I should
>> probably have used the low 16-us IFS overhead for every packet.
>>=20
>> I guess we could do something similar to what the chromeos thing is
>> doing. I.e., adding a single "large" overhead value when we think the
>> packet is the first of a burst, and using the smaller value for the
>> rest.
>>=20
>> One approach could be to couple the switch to the "scheduling rounds" we
>> already have. I.e., first packet after a call to
>> ieee8021_txq_schedule_start() will get the 100-us overhead, and every
>> subsequent one will get the low one. Not sure how this will fit with
>> what the driver actually does, though, so I guess some experimentation
>> is in order.
>>=20
>> Ultimately,  I'm not sure it matters that much whether occasionally add
>> 80 us extra to the estimate. But as you say, adding 100 us to every
>> packet is probably a bit much ;)
>
> Would it be possible to use the previous tx airtime reported by the
> driver? (not sure if it is feasible). Some drivers can report airtime
> compute in hw, the issue is it can be no not linked to the given skb
> or aggregation burst, so we should take into account burst size

That's what we do for the fairness scheduler. And yeah, if the HW can
report after-the-fact airtime usage that is bound to be more accurate,
so I think we should keep using that for fairness.

But for this AQL thing, we really need it ahead of time. However, I
don't think it's as important that it is super accurate. As long as we
have a reasonable estimate I think we'll be fine. We can solve any
inaccuracies by fiddling with the limit, I think. Similar to what BQL
does; dynamically adjusting it up and down.

So for a first pass, we can just err on the side of having the limit
higher, and then iterate from there.

>> > Moreover, can this approach be affected by some interrupt coalescing
>> > implemented by the chipset?
>>=20
>> Probably? Ultimately we don't really know what exactly the chipset is
>> doing, so we're guessing here, no?
>
> Here I mean if the hw relies on a 1:n tx interrupt/packet ratio (I
> guess most driver do), it would probably affect throughput, right?
> (e.g TCP)

Yeah, this is what I alluded to above: If we set the limit too low, were
are going to kill TCP throughput. Ideally, we want the limit to be as
low as we can get it without hurting TCP (too much), but no lower. Just
doing the conversion to airtime is a way to achieve this: This will
scale the actual queue length with the achievable throughput as long as
the tx rate estimate is reasonably accurate. If needed, we can add
another layer of dynamic tuning on top using the existing BQL logic; but
I'd like to get the basic case working first...

-Toke

