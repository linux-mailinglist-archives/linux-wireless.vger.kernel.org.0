Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA825FEC55
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 13:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfKPMvJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 07:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbfKPMvJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 07:51:09 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F76E206E6;
        Sat, 16 Nov 2019 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573908668;
        bh=efptjQYpiJn/kBolfVMz0jJ6KVAYNij/ucb6qSAq4lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=av0YQWrEiklgw1HTH/bGWV/56MTdQz0kQ9Zfwk5KmnwzvxB2pQKYOBarQ33N/uYnG
         /ILB3oAEIBn5g6K9VXyApG+LJUhptrlZdE2TYihKu6+AolwssiSltJmPoU8jHCoZq9
         Yi5Z9QPE7vCrCFgF6d0t6PkujyDENmLDbwBT+/BA=
Date:   Sat, 16 Nov 2019 14:51:02 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH 2/4] mt76: mt76x02: split beaconing
Message-ID: <20191116125102.GF20820@localhost.localdomain>
References: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
 <20191116111709.4686-3-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <20191116111709.4686-3-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Sending beacons to the hardware always happens in batches. In order to
> speed up beacon processing on usb devices, this patch splits out common
> code an calls it only once (mt76x02_mac_set_beacon_prepare,
> mt76x02_mac_set_beacon_finish). Making this split breaks beacon
> enabling/disabling per vif. This is fixed by adding a call to set the
> bypass mask, if beaconing should be disabled for a vif. Otherwise the
> beacon is send after the next beacon interval.
>=20
> The code is also adapted for the mmio part of the driver, but should not
> have any performance implication there.
>=20
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  .../wireless/mediatek/mt76/mt76x02_beacon.c   | 53 +++++++++----------
>  .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  2 +
>  .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 ++
>  .../wireless/mediatek/mt76/mt76x02_usb_core.c |  4 ++
>  4 files changed, 34 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_beacon.c
> index 54fe449f01c9..47207b790bf9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> @@ -47,10 +47,6 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 b=
cn_idx,
>  	int beacon_len =3D dev->beacon_ops->slot_size;
>  	int beacon_addr =3D MT_BEACON_BASE + (beacon_len * bcn_idx);
>  	int ret =3D 0;
> -	int i;
> -
> -	/* Prevent corrupt transmissions during update */
> -	mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(bcn_idx));
> =20
>  	if (skb) {
>  		ret =3D mt76x02_write_beacon(dev, beacon_addr, skb);
> @@ -58,41 +54,39 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 =
bcn_idx,
>  			dev->beacon_data_mask |=3D BIT(bcn_idx);
>  	}
> =20
> -	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
> -
>  	return ret;
>  }
> =20
> -int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
> -			   struct sk_buff *skb)
> -{
> -	bool force_update =3D false;
> -	int bcn_idx =3D 0;
> -	int i;
> +void mt76x02_mac_set_beacon_prepare(struct mt76x02_dev *dev) {
> +	/* Prevent corrupt transmissions during update */
> +	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);

Do we really need it? I guess just call mt76_set(dev, MT_BCN_BYPASS_MASK, 0=
xffff)
directly

> +}
> +EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_prepare);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(dev->beacons); i++) {
> -		if (vif_idx =3D=3D i) {
> -			force_update =3D !!dev->beacons[i] ^ !!skb;
> -			dev_kfree_skb(dev->beacons[i]);
> -			dev->beacons[i] =3D skb;
> -			__mt76x02_mac_set_beacon(dev, bcn_idx, skb);
> -		} else if (force_update && dev->beacons[i]) {
> -			__mt76x02_mac_set_beacon(dev, bcn_idx,
> -						 dev->beacons[i]);
> -		}
> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev) {
> +	int i;
> +	int bcn_idx =3D 0;
> +	int nbeacons =3D hweight8(dev->mt76.beacon_mask);
> =20
> +	for(i =3D 0; i < nbeacons; ++i) {

	for (i =3D 0; i < hweight8(dev->mt76.beacon_mask); i++)
		bcn_idx +=3D !!dev->beacons[i];

>  		bcn_idx +=3D !!dev->beacons[i];
>  	}
> =20
> -	for (i =3D bcn_idx; i < ARRAY_SIZE(dev->beacons); i++) {
> -		if (!(dev->beacon_data_mask & BIT(i)))
> -			break;
> -
> -		__mt76x02_mac_set_beacon(dev, i, NULL);
> -	}
> -
>  	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
>  		       bcn_idx - 1);
> +
> +	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
> +}
> +EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_finish);
> +
> +int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
> +			   struct sk_buff *skb)
> +{
> +	dev_kfree_skb(dev->beacons[vif_idx]);
> +	dev->beacons[vif_idx] =3D skb;
> +	__mt76x02_mac_set_beacon(dev, vif_idx, skb);
> +
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
> @@ -113,6 +107,7 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev=
 *dev,
>  	} else {
>  		dev->mt76.beacon_mask &=3D ~BIT(mvif->idx);
>  		mt76x02_mac_set_beacon(dev, mvif->idx, NULL);
> +		mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(mvif->idx));
>  	}
> =20
>  	if (!!old_mask =3D=3D !!dev->mt76.beacon_mask)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76x02_mac.h
> index efa4ef945e35..4e717640eef6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
> @@ -197,6 +197,8 @@ int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u=
8 vif_idx,
>  			   struct sk_buff *skb);
>  void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
>  				   struct ieee80211_vif *vif, bool enable);
> +void mt76x02_mac_set_beacon_prepare(struct mt76x02_dev *dev);
> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev);
> =20
>  void mt76x02_edcca_init(struct mt76x02_dev *dev);
>  #endif
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_mmio.c
> index dc773070481d..b8b4c6a67d39 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> @@ -24,10 +24,14 @@ static void mt76x02_pre_tbtt_tasklet(unsigned long ar=
g)
> =20
>  	mt76x02_resync_beacon_timer(dev);
> =20
> +	mt76x02_mac_set_beacon_prepare(dev);
> +
>  	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
>  		IEEE80211_IFACE_ITER_RESUME_ALL,
>  		mt76x02_update_beacon_iter, dev);
> =20
> +	mt76x02_mac_set_beacon_finish(dev);
> +
>  	mt76_csa_check(&dev->mt76);
> =20
>  	if (dev->mt76.csa_complete)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/driv=
ers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> index 78dfc1e7f27b..aedab4cc8d40 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> @@ -179,6 +179,8 @@ static void mt76x02u_pre_tbtt_work(struct work_struct=
 *work)
> =20
>  	mt76x02_resync_beacon_timer(dev);
> =20
> +	mt76x02_mac_set_beacon_prepare(dev);
> +
>  	ieee80211_iterate_active_interfaces(mt76_hw(dev),
>  		IEEE80211_IFACE_ITER_RESUME_ALL,
>  		mt76x02_update_beacon_iter, dev);
> @@ -191,6 +193,8 @@ static void mt76x02u_pre_tbtt_work(struct work_struct=
 *work)
>  		mt76x02_mac_set_beacon(dev, i, skb);
>  	}
> =20
> +	mt76x02_mac_set_beacon_finish(dev);
> +
>  	mt76x02u_restart_pre_tbtt_timer(dev);
>  }
> =20
> --=20
> 2.24.0
>=20

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXc/wswAKCRA6cBh0uS2t
rCs7AQDxH72PPQU+sVAd0n0zr01VXzcjQ8Z4hxKoROHZUnZYMwEAhN8YGRfOdncb
uDa9je1jf5DiUPmYGc+k0V69tbwPogA=
=LfOq
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
