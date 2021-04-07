Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97876356A74
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhDGKyD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 06:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237153AbhDGKx4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 06:53:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D5406139C;
        Wed,  7 Apr 2021 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617792826;
        bh=hFN/o0QEdMOAnnNIDsz27FSmPvKA2meADcDNCydIOFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3YcruaOFxI5PmqU+yUxbRtAoCq7Yf9QOU7f44t8NaRa0ANudAM8Zehh3xguPSIJi
         m9RxWKY2ZY67yh4lv9rwyVn+8XmLR67+VCJE+5N2x3N1RXwga8uG8Du3hcJwrqMDX8
         I4Q0IVbVGd8f0+OWYz8gLEDCqPkpAVlqP3D6xqzujBxmmccKESLV8pGhnnvahJnH1k
         KC0F4jwph888RmDH2B/jMgvEjPbflxaL4TXoqeOIzBoBgOPpdf+gNq73lDrobu+cpT
         w6oOB0KO3uBkuqlwivs3iXsbjShGKghz883dv5iFNqaUhvuyJ8KWHjGgL2Zx07R13G
         okKYB82oNL78g==
Date:   Wed, 7 Apr 2021 12:53:42 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: fix rx amsdu subframe processing
Message-ID: <YG2PNuope0XR1RPK@lore-desk>
References: <20210406182235.14377-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KL28bWGfPXz2IigD"
Content-Disposition: inline
In-Reply-To: <20210406182235.14377-1-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--KL28bWGfPXz2IigD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When receiving an A-MSDU containing only a single subframe, status->last_=
amsdu
> is set, but no previous head is present in the rx A-MSDU queue.
> In this case, the A-MSDU subframe will be held until the next one is rece=
ived,
> potentially causing significant extra latency.
> Fix this by releasing the frame instead of creating a new queue head if
> last_amsdu is set.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: c7fd4a5d3f75 ("mt76: mt7915: enable hw rx-amsdu de-aggregation")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/=
wireless/mediatek/mt76/mac80211.c
> index 7684a8cf00fb..0d92b658b6a6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -517,10 +517,14 @@ static void mt76_rx_release_burst(struct mt76_phy *=
phy, enum mt76_rxq_id q,
> =20
>  	/* first amsdu subframe */
>  	if (status->amsdu && !phy->rx_amsdu[q].head) {
> +		if (status->last_amsdu) {
> +			nskb =3D skb;
> +			goto reset_burst;
> +		}
>  		phy->rx_amsdu[q].tail =3D &skb_shinfo(skb)->frag_list;
>  		phy->rx_amsdu[q].seqno =3D status->seqno;
>  		phy->rx_amsdu[q].head =3D skb;
> -		goto enqueue;
> +		return;
>  	}
> =20
>  	/* ampdu or out-of-order amsdu subframes */
> @@ -543,7 +547,6 @@ static void mt76_rx_release_burst(struct mt76_phy *ph=
y, enum mt76_rxq_id q,
>  reset_burst:
>  	phy->rx_amsdu[q].head =3D NULL;
>  	phy->rx_amsdu[q].tail =3D NULL;
> -enqueue:
>  	if (nskb)
>  		__skb_queue_tail(&dev->rx_skb[q], nskb);
>  }
> --=20
> 2.30.1
>=20

--KL28bWGfPXz2IigD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYG2PMwAKCRA6cBh0uS2t
rFGHAQCGUOIRxcCL58cKnO0hR5DPQZFpakvGcVzHrjB8UHtIyAEAmyJMjfkYz3B6
ED6Yj2PxzFWuwj5GSy0hNfP26lO9LQ8=
=JTLo
-----END PGP SIGNATURE-----

--KL28bWGfPXz2IigD--
