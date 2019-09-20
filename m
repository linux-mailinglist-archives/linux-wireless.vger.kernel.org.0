Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC59AB8F70
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406217AbfITMGq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 08:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404361AbfITMGq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 08:06:46 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D59DE20644;
        Fri, 20 Sep 2019 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568981205;
        bh=2XYGNCCvtnM4cTVmLEYpFx5ZPYmSB05PBq2FPJnxjjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPtumAMUW7jJSMLsu7Ps0914y5Oef15CowwRDgAmzZiO4cSBrfZjQcYkDawbdlmBA
         EeyTuK7JgezE3HDBghSfaS01ktkraSr1HS7nVQPjQfJQJ2WuPVLWpXPjZdYrSw65WN
         oZYWvR4b/Gw7zutPOCkjHw3lwFVo8wNQ605NjYhs=
Date:   Fri, 20 Sep 2019 14:06:39 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
Message-ID: <20190920120639.GA6456@localhost.localdomain>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <156889576869.191202.510507546538322707.stgit@alrua-x1>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
>=20
> Some devices have deep buffers in firmware and/or hardware which prevents
> the FQ structure in mac80211 from effectively limiting bufferbloat on the
> link. For Ethernet devices we have BQL to limit the lower-level queues, b=
ut
> this cannot be applied to mac80211 because transmit rates can vary wildly
> between packets depending on which station we are transmitting it to.
>=20
> To overcome this, we can use airtime-based queue limiting (AQL), where we
> estimate the transmission time for each packet before dequeueing it, and
> use that to limit the amount of data in-flight to the hardware. This idea
> was originally implemented as part of the out-of-tree airtime fairness
> patch to ath10k[0] in chromiumos.
>=20
> This patch ports that idea over to mac80211. The basic idea is simple
> enough: Whenever we dequeue a packet from the TXQs and send it to the
> driver, we estimate its airtime usage, based on the last recorded TX rate
> of the station that packet is destined for. We keep a running per-AC total
> of airtime queued for the whole device, and when that total climbs above 8
> ms' worth of data (corresponding to two maximum-sized aggregates), we
> simply throttle the queues until it drops down again.
>=20
> The estimated airtime for each skb is stored in the tx_info, so we can
> subtract the same amount from the running total when the skb is freed or
> recycled. The throttling mechanism relies on this accounting to be
> accurate (i.e., that we are not freeing skbs without subtracting any
> airtime they were accounted for), so we put the subtraction into
> ieee80211_report_used_skb().
>=20
> This patch does *not* include any mechanism to wake a throttled TXQ again,
> on the assumption that this will happen anyway as a side effect of whatev=
er
> freed the skb (most commonly a TX completion).
>=20
> The throttling mechanism only kicks in if the queued airtime total goes
> above the limit. Since mac80211 calculates the time based on the reported
> last_tx_time from the driver, the whole throttling mechanism only kicks in
> for drivers that actually report this value. With the exception of
> multicast, where we always calculate an estimated tx time on the assumpti=
on
> that multicast is transmitted at the lowest (6 Mbps) rate.
>=20
> The throttling added in this patch is in addition to any throttling alrea=
dy
> performed by the airtime fairness mechanism, and in principle the two
> mechanisms are orthogonal (and currently also uses two different sources =
of
> airtime). In the future, we could amend this, using the airtime estimates
> calculated by this mechanism as a fallback input to the airtime fairness
> scheduler, to enable airtime fairness even on drivers that don't have a
> hardware source of airtime usage for each station.
>=20
> [0] https://chromium-review.googlesource.com/c/chromiumos/third_party/ker=
nel/+/588190/13/drivers/net/wireless-4.2/ath/ath10k/mac.c#3845
>=20
> Signed-off-by: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> ---
>  net/mac80211/debugfs.c     |   24 ++++++++++++++++++++++++
>  net/mac80211/ieee80211_i.h |    7 +++++++
>  net/mac80211/status.c      |   22 ++++++++++++++++++++++
>  net/mac80211/tx.c          |   38 +++++++++++++++++++++++++++++++++++++-
>  4 files changed, 90 insertions(+), 1 deletion(-)

Hi Toke,

Thx a lot for working on this. Few comments inline.

Regards,
Lorenzo

>=20
> diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
> index 568b3b276931..c846c6e7f3e3 100644
> --- a/net/mac80211/debugfs.c
> +++ b/net/mac80211/debugfs.c
> @@ -148,6 +148,29 @@ static const struct file_operations aqm_ops =3D {
>  	.llseek =3D default_llseek,
>  };
> =20

[...]

> @@ -3581,8 +3591,19 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80=
211_hw *hw,
>  	tx.skb =3D skb;
>  	tx.sdata =3D vif_to_sdata(info->control.vif);
> =20
> -	if (txq->sta)
> +	pktlen =3D skb->len + 38;
> +	if (txq->sta) {
>  		tx.sta =3D container_of(txq->sta, struct sta_info, sta);
> +		if (tx.sta->last_tx_bitrate) {
> +			airtime =3D (pktlen * 8 * 1000 *
> +				   tx.sta->last_tx_bitrate_reciprocal) >> IEEE80211_RECIPROCAL_SHIFT;
> +			airtime +=3D IEEE80211_AIRTIME_OVERHEAD;

Here we are not taking into account aggregation burst size (it is done in a
rough way in chromeos implementation) and tx retries. I have not carried out
any tests so far but I think IEEE80211_AIRTIME_OVERHEAD will led to a
significant airtime overestimation. Do you think this can be improved? (..I
agree this is not a perfect world, but .. :))

Moreover, can this approach be affected by some interrupt coalescing implem=
ented
by the chipset?

> +		}
> +	} else {
> +		airtime =3D (pktlen * 8 * 1000 *
> +			   IEEE80211_AIRTIME_MINRATE_RECIPROCAL) >> IEEE80211_RECIPROCAL_SHIF=
T;
> +		airtime +=3D IEEE80211_AIRTIME_OVERHEAD;
> +	}
> =20
>  	/*
>  	 * The key can be removed while the packet was queued, so need to call
> @@ -3659,6 +3680,15 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80=
211_hw *hw,
>  	}
> =20
>  	IEEE80211_SKB_CB(skb)->control.vif =3D vif;
> +
> +	if (airtime) {
> +		info->control.tx_time_est =3D airtime;
> +
> +		spin_lock_bh(&local->active_txq_lock[ac]);
> +		local->airtime_queued[ac] +=3D airtime;
> +		spin_unlock_bh(&local->active_txq_lock[ac]);
> +	}
> +
>  	return skb;
> =20
>  out:
> @@ -3676,6 +3706,9 @@ struct ieee80211_txq *ieee80211_next_txq(struct iee=
e80211_hw *hw, u8 ac)
> =20
>  	spin_lock_bh(&local->active_txq_lock[ac]);
> =20
> +	if (local->airtime_queued[ac] > IEEE80211_AIRTIME_QUEUE_LIMIT)
> +		goto out;
> +
>   begin:
>  	txqi =3D list_first_entry_or_null(&local->active_txqs[ac],
>  					struct txq_info,
> @@ -3753,6 +3786,9 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw=
 *hw,
> =20
>  	spin_lock_bh(&local->active_txq_lock[ac]);
> =20
> +	if (local->airtime_queued[ac] > IEEE80211_AIRTIME_QUEUE_LIMIT)
> +		goto out;
> +
>  	if (!txqi->txq.sta)
>  		goto out;
> =20
>=20

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXYTAzQAKCRA6cBh0uS2t
rG9uAQDPn0iF5ivifclSzkNbWu4PQyHwygghnfa/5HdXECShWQD/VbZTc7LAqZvX
JVwANlZML1X+s2JCnpWozmJtcbG0wwY=
=WFLv
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
