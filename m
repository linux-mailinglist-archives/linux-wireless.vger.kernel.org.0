Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1641202B82
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2020 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgFUQBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jun 2020 12:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbgFUQBb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jun 2020 12:01:31 -0400
Received: from localhost (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C6523139;
        Sun, 21 Jun 2020 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592755290;
        bh=9rbsbYXfjR4c+doRDPxNOftGyq/9aVLD08CaMVg0hFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMWQbpm/MEwuZ9YF4A9+nJ0tJkgjbzfUk+lbSnRsQaxcrKZgorrbohmlyn+Setw+M
         pf37ssO7d3ba0BrCvBI7gcbnCEtHCAeQn/2cA8/PC9v38O4FMKSM1XCvIaONZR8NLA
         uo4vA3lNOrQCDNsCx2j1y7ivE8rVrhY66kiYrNmo=
Date:   Sun, 21 Jun 2020 18:01:25 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: mt7663u: fix memory leaks in
 mt7663u_probe
Message-ID: <20200621160125.GA271428@localhost.localdomain>
References: <f649a8c804e436a86f5482cca450a94b8ed86441.1592754254.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <f649a8c804e436a86f5482cca450a94b8ed86441.1592754254.git.lorenzo@kernel.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix the two following memory leaks in mt7663u_probe:
> 1- if device power-own times out, remove ieee80211 hw device.
> 2- if mt76u queues allocation fails, remove pending urbs.

Hi Kalle,

please drop this version since I spotted an issue, I am sending a v2.

Regards,
Lorenzo

>=20
> Fixes: eb99cc95c3b65 ("mt76: mt7615: introduce mt7663u support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/usb.c   | 10 ++++-----
>  drivers/net/wireless/mediatek/mt76/usb.c      | 22 ++++++++++++++-----
>  2 files changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/usb.c
> index a50077eb24d7..18a4dd59b7e4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
> @@ -329,25 +329,25 @@ static int mt7663u_probe(struct usb_interface *usb_=
intf,
>  	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_PWR_ON,
>  			    FW_STATE_PWR_ON << 1, 500)) {
>  		dev_err(dev->mt76.dev, "Timeout for power on\n");
> -		return -EIO;
> +		goto error;
>  	}
> =20
>  alloc_queues:
>  	ret =3D mt76u_alloc_mcu_queue(&dev->mt76);
>  	if (ret)
> -		goto error;
> +		goto error_free_q;
> =20
>  	ret =3D mt76u_alloc_queues(&dev->mt76);
>  	if (ret)
> -		goto error;
> +		goto error_free_q;
> =20
>  	ret =3D mt7663u_register_device(dev);
>  	if (ret)
> -		goto error_freeq;
> +		goto error_free_q;
> =20
>  	return 0;
> =20
> -error_freeq:
> +error_free_q:
>  	mt76u_queues_deinit(&dev->mt76);
>  error:
>  	mt76u_deinit(&dev->mt76);
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wirel=
ess/mediatek/mt76/usb.c
> index fb97ea25b4d4..2e89b0514ff6 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -1066,11 +1066,16 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
> =20
>  static void mt76u_free_tx(struct mt76_dev *dev)
>  {
> -	struct mt76_queue *q;
> -	int i, j;
> +	int i;
> =20
>  	for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
> +		struct mt76_queue *q;
> +		int j;
> +
>  		q =3D dev->q_tx[i].q;
> +		if (!q)
> +			continue;
> +
>  		for (j =3D 0; j < q->ndesc; j++)
>  			usb_free_urb(q->entry[j].urb);
>  	}
> @@ -1078,17 +1083,22 @@ static void mt76u_free_tx(struct mt76_dev *dev)
> =20
>  void mt76u_stop_tx(struct mt76_dev *dev)
>  {
> -	struct mt76_queue_entry entry;
> -	struct mt76_queue *q;
> -	int i, j, ret;
> +	int ret;
> =20
>  	ret =3D wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(&dev->phy=
),
>  				 HZ / 5);
>  	if (!ret) {
> +		struct mt76_queue_entry entry;
> +		struct mt76_queue *q;
> +		int i, j;
> +
>  		dev_err(dev->dev, "timed out waiting for pending tx\n");
> =20
>  		for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
>  			q =3D dev->q_tx[i].q;
> +			if (!q)
> +				continue;
> +
>  			for (j =3D 0; j < q->ndesc; j++)
>  				usb_kill_urb(q->entry[j].urb);
>  		}
> @@ -1100,6 +1110,8 @@ void mt76u_stop_tx(struct mt76_dev *dev)
>  		 */
>  		for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
>  			q =3D dev->q_tx[i].q;
> +			if (!q)
> +				continue;
> =20
>  			/* Assure we are in sync with killed tasklet. */
>  			spin_lock_bh(&q->lock);
> --=20
> 2.26.2
>=20

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXu+EUwAKCRA6cBh0uS2t
rCpdAP48wlDcFKgbHIQngxXbrY6RXOjQZXNtNTScMlWkwAbcJAD+ITmFL0YxbiEa
dEruDdM0VN1ay9R3e+yksnGprtR6zgY=
=9SeN
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
