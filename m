Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204C5B9050
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 15:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfITNGL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 09:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbfITNGK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 09:06:10 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF62D20640;
        Fri, 20 Sep 2019 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568984769;
        bh=GnmfxUKTZ9Dlj/gpKRaAkOJXf8fPPArs8jqh6pbVNrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sxcd/VE3SvHckD3S2Gv0AbTl1SQaTyOfbhr8HaEbxndyA6dIeUzrXZwWTVPY+gGru
         LekQ7ECQVFbrg+feZUV0F3/MmCe6wE0ua7bx9qxfMPh6qFqQkB0MW7J8x3mQTpVNvt
         nejyb1wQGoVq+x3utoVIOtq/nVMp6RhAT3yRTtzM=
Date:   Fri, 20 Sep 2019 15:06:04 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
Message-ID: <20190920130604.GB6456@localhost.localdomain>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
 <20190920120639.GA6456@localhost.localdomain>
 <87k1a39lgt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <87k1a39lgt.fsf@toke.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> From: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> >>=20
> >> Some devices have deep buffers in firmware and/or hardware which preve=
nts
> >> the FQ structure in mac80211 from effectively limiting bufferbloat on =
the
> >> link. For Ethernet devices we have BQL to limit the lower-level queues=
, but
> >> this cannot be applied to mac80211 because transmit rates can vary wil=
dly
> >> between packets depending on which station we are transmitting it to.
> >>=20
> >> To overcome this, we can use airtime-based queue limiting (AQL), where=
 we
> >> estimate the transmission time for each packet before dequeueing it, a=
nd
> >> use that to limit the amount of data in-flight to the hardware. This i=
dea
> >> was originally implemented as part of the out-of-tree airtime fairness
> >> patch to ath10k[0] in chromiumos.
> >>=20
> >> This patch ports that idea over to mac80211. The basic idea is simple
> >> enough: Whenever we dequeue a packet from the TXQs and send it to the
> >> driver, we estimate its airtime usage, based on the last recorded TX r=
ate
> >> of the station that packet is destined for. We keep a running per-AC t=
otal
> >> of airtime queued for the whole device, and when that total climbs abo=
ve 8
> >> ms' worth of data (corresponding to two maximum-sized aggregates), we
> >> simply throttle the queues until it drops down again.
> >>=20
> >> The estimated airtime for each skb is stored in the tx_info, so we can
> >> subtract the same amount from the running total when the skb is freed =
or
> >> recycled. The throttling mechanism relies on this accounting to be
> >> accurate (i.e., that we are not freeing skbs without subtracting any
> >> airtime they were accounted for), so we put the subtraction into
> >> ieee80211_report_used_skb().
> >>=20
> >> This patch does *not* include any mechanism to wake a throttled TXQ ag=
ain,
> >> on the assumption that this will happen anyway as a side effect of wha=
tever
> >> freed the skb (most commonly a TX completion).
> >>=20
> >> The throttling mechanism only kicks in if the queued airtime total goes
> >> above the limit. Since mac80211 calculates the time based on the repor=
ted
> >> last_tx_time from the driver, the whole throttling mechanism only kick=
s in
> >> for drivers that actually report this value. With the exception of
> >> multicast, where we always calculate an estimated tx time on the assum=
ption
> >> that multicast is transmitted at the lowest (6 Mbps) rate.
> >>=20
> >> The throttling added in this patch is in addition to any throttling al=
ready
> >> performed by the airtime fairness mechanism, and in principle the two
> >> mechanisms are orthogonal (and currently also uses two different sourc=
es of
> >> airtime). In the future, we could amend this, using the airtime estima=
tes
> >> calculated by this mechanism as a fallback input to the airtime fairne=
ss
> >> scheduler, to enable airtime fairness even on drivers that don't have a
> >> hardware source of airtime usage for each station.
> >>=20
> >> [0] https://chromium-review.googlesource.com/c/chromiumos/third_party/=
kernel/+/588190/13/drivers/net/wireless-4.2/ath/ath10k/mac.c#3845
> >>=20
> >> Signed-off-by: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> >> ---
> >>  net/mac80211/debugfs.c     |   24 ++++++++++++++++++++++++
> >>  net/mac80211/ieee80211_i.h |    7 +++++++
> >>  net/mac80211/status.c      |   22 ++++++++++++++++++++++
> >>  net/mac80211/tx.c          |   38 +++++++++++++++++++++++++++++++++++=
++-
> >>  4 files changed, 90 insertions(+), 1 deletion(-)
> >
> > Hi Toke,
> >
> > Thx a lot for working on this. Few comments inline.
> >
> > Regards,
> > Lorenzo
> >
> >>=20
> >> diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
> >> index 568b3b276931..c846c6e7f3e3 100644
> >> --- a/net/mac80211/debugfs.c
> >> +++ b/net/mac80211/debugfs.c
> >> @@ -148,6 +148,29 @@ static const struct file_operations aqm_ops =3D {
> >>  	.llseek =3D default_llseek,
> >>  };
> >> =20
> >
> > [...]
> >
> >> @@ -3581,8 +3591,19 @@ struct sk_buff *ieee80211_tx_dequeue(struct iee=
e80211_hw *hw,
> >>  	tx.skb =3D skb;
> >>  	tx.sdata =3D vif_to_sdata(info->control.vif);
> >> =20
> >> -	if (txq->sta)
> >> +	pktlen =3D skb->len + 38;
> >> +	if (txq->sta) {
> >>  		tx.sta =3D container_of(txq->sta, struct sta_info, sta);
> >> +		if (tx.sta->last_tx_bitrate) {
> >> +			airtime =3D (pktlen * 8 * 1000 *
> >> +				   tx.sta->last_tx_bitrate_reciprocal) >> IEEE80211_RECIPROCAL_SH=
IFT;
> >> +			airtime +=3D IEEE80211_AIRTIME_OVERHEAD;
> >
> > Here we are not taking into account aggregation burst size (it is done
> > in a rough way in chromeos implementation) and tx retries. I have not
> > carried out any tests so far but I think IEEE80211_AIRTIME_OVERHEAD
> > will led to a significant airtime overestimation. Do you think this
> > can be improved? (..I agree this is not a perfect world, but .. :))
>=20
> Hmm, yeah, looking at this again, the way I'm going this now, I should
> probably have used the low 16-us IFS overhead for every packet.
>=20
> I guess we could do something similar to what the chromeos thing is
> doing. I.e., adding a single "large" overhead value when we think the
> packet is the first of a burst, and using the smaller value for the
> rest.
>=20
> One approach could be to couple the switch to the "scheduling rounds" we
> already have. I.e., first packet after a call to
> ieee8021_txq_schedule_start() will get the 100-us overhead, and every
> subsequent one will get the low one. Not sure how this will fit with
> what the driver actually does, though, so I guess some experimentation
> is in order.
>=20
> Ultimately,  I'm not sure it matters that much whether occasionally add
> 80 us extra to the estimate. But as you say, adding 100 us to every
> packet is probably a bit much ;)

Would it be possible to use the previous tx airtime reported by the driver?
(not sure if it is feasible). Some drivers can report airtime compute in hw,
the issue is it can be no not linked to the given skb or aggregation burst,=
 so
we should take into account burst size

>=20
> > Moreover, can this approach be affected by some interrupt coalescing
> > implemented by the chipset?
>=20
> Probably? Ultimately we don't really know what exactly the chipset is
> doing, so we're guessing here, no?

Here I mean if the hw relies on a 1:n tx interrupt/packet ratio (I guess mo=
st
driver do), it would probably affect throughput, right? (e.g TCP)

Regards,
Lorenzo

>=20
> -Toke
>=20

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXYTOuQAKCRA6cBh0uS2t
rLQAAQD8Vlm6rVWV5WKrPjRFK3eroxCu5PFp1FFND8/6RRGXxQD/QbVlp9J/PuFS
1Vss+Kv0UC1KeWUwI9xcaTPzGKYUwgk=
=jPvI
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
