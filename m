Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BCE1227E7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLQJuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 04:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfLQJuR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 04:50:17 -0500
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02C4420716;
        Tue, 17 Dec 2019 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576576216;
        bh=HJYnFYInxhLym4KmXgiXkXkMOFJnCy2PTNlWmy1546g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0qswbM04vRKIPhn0kDtfi6RU9AbrZrWaNzpVqxxIAZV8emN1OvQPH4MtAWB1+hsxJ
         W+6tFuo2tQH6qa5TzmtJDSysBQjYAAbsHdB5gecy9+3z1wc/TxP9b/Tbsq89+EiFvD
         L6sU6+V+m01WV376rjUo5kcQfRkwl1vdMpzx4ZUM=
Date:   Tue, 17 Dec 2019 10:50:11 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH v9 2/6] mt76: mt76x02: split beaconing
Message-ID: <20191217095011.GB2567@localhost.localdomain>
References: <20191126214704.27297-1-markus.theil@tu-ilmenau.de>
 <20191126214704.27297-3-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20191126214704.27297-3-markus.theil@tu-ilmenau.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Sending beacons to the hardware always happens in batches. In order to
> speed up beacon processing on usb devices, this patch splits out common
> code an calls it only once (mt76x02_mac_set_beacon_prepare,
> mt76x02_mac_set_beacon_finish).
>=20

[...]

> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x02.h  |  3 +-
>  .../wireless/mediatek/mt76/mt76x02_beacon.c   | 69 ++++++-------------
>  .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +
>  .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  5 +-
>  .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 ++
>  .../wireless/mediatek/mt76/mt76x02_usb_core.c | 14 ++--
>  6 files changed, 38 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/w=
ireless/mediatek/mt76/mt76x02.h
> index 0ca0bbfe8769..ee87c5f30e81 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
> @@ -93,8 +93,7 @@ struct mt76x02_dev {
> =20
>  	const struct mt76x02_beacon_ops *beacon_ops;
> =20
> -	struct sk_buff *beacons[8];
> -	u8 beacon_data_mask;
> +	u8 beacon_data_count;
> =20
>  	u8 tbtt_count;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_beacon.c
> index 403866496640..1c4bdf88f712 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> @@ -40,62 +40,36 @@ mt76x02_write_beacon(struct mt76x02_dev *dev, int off=
set, struct sk_buff *skb)
>  	return 0;
>  }
> =20
> -static int
> -__mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 bcn_idx,
> -			 struct sk_buff *skb)
> +void mt76x02_mac_set_beacon_prepare(struct mt76x02_dev *dev)
>  {
> -	int beacon_len =3D dev->beacon_ops->slot_size;
> -	int beacon_addr =3D MT_BEACON_BASE + (beacon_len * bcn_idx);
> -	int ret =3D 0;
> -	int i;
> -
>  	/* Prevent corrupt transmissions during update */
> -	mt76_set(dev, MT_BCN_BYPASS_MASK, BIT(bcn_idx));
> -
> -	if (skb) {
> -		ret =3D mt76x02_write_beacon(dev, beacon_addr, skb);
> -		if (!ret)
> -			dev->beacon_data_mask |=3D BIT(bcn_idx);
> -	} else {
> -		dev->beacon_data_mask &=3D ~BIT(bcn_idx);
> -	}
> -
> -	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
> +	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);
> +	dev->beacon_data_count =3D 0;

I would prefer open-coding here

> +}
> +EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_prepare);
> =20
> -	return ret;
> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
> +{
> +	mt76_wr(dev, MT_BCN_BYPASS_MASK,
> +		0xff00 | ~(0xff00 >> dev->beacon_data_count));
>  }
> +EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon_finish);

Probably better open-coding here since we just run mt76_wr()

> =20
> -int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
> +int mt76x02_mac_set_beacon(struct mt76x02_dev *dev,
>  			   struct sk_buff *skb)
>  {
> -	bool force_update =3D false;
> -	int bcn_idx =3D 0;
> -	int i;
> -
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
> -
> -		bcn_idx +=3D !!dev->beacons[i];
> -	}
> -
> -	for (i =3D bcn_idx; i < ARRAY_SIZE(dev->beacons); i++) {
> -		if (!(dev->beacon_data_mask & BIT(i)))
> -			break;
> +	int bcn_len =3D dev->beacon_ops->slot_size;
> +	int bcn_addr =3D MT_BEACON_BASE + (bcn_len * dev->beacon_data_count);
> +	int ret =3D 0;
> =20
> -		__mt76x02_mac_set_beacon(dev, i, NULL);
> +	if (skb) {
> +		ret =3D mt76x02_write_beacon(dev, bcn_addr, skb);
> +		if (!ret)
> +			dev->beacon_data_count++;
>  	}
> =20
> -	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N,
> -		       bcn_idx - 1);
> -	return 0;
> +	dev_kfree_skb(skb);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
> =20
> @@ -114,7 +88,6 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev =
*dev,
>  		dev->mt76.beacon_mask |=3D BIT(mvif->idx);
>  	} else {
>  		dev->mt76.beacon_mask &=3D ~BIT(mvif->idx);
> -		mt76x02_mac_set_beacon(dev, mvif->idx, NULL);
>  	}
> =20
>  	if (!!old_mask =3D=3D !!dev->mt76.beacon_mask)
> @@ -180,7 +153,7 @@ mt76x02_update_beacon_iter(void *priv, u8 *mac, struc=
t ieee80211_vif *vif)
>  	if (!skb)
>  		return;
> =20
> -	mt76x02_mac_set_beacon(dev, mvif->idx, skb);
> +	mt76x02_mac_set_beacon(dev, skb);
>  }
>  EXPORT_SYMBOL_GPL(mt76x02_update_beacon_iter);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/n=
et/wireless/mediatek/mt76/mt76x02_mac.c
> index 4460548f346a..285ab0f491d0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
> @@ -741,6 +741,8 @@ void mt76x02_mac_setaddr(struct mt76x02_dev *dev, con=
st u8 *addr)
>  		get_unaligned_le16(dev->mt76.macaddr + 4) |
>  		FIELD_PREP(MT_MAC_BSSID_DW1_MBSS_MODE, 3) | /* 8 APs + 8 STAs */
>  		MT_MAC_BSSID_DW1_MBSS_LOCAL_BIT);
> +	/* enable 7 additional beacon slots and control them with bypass mask */
> +	mt76_rmw_field(dev, MT_MAC_BSSID_DW1, MT_MAC_BSSID_DW1_MBEACON_N, 7);
> =20
>  	for (i =3D 0; i < 16; i++)
>  		mt76x02_mac_set_bssid(dev, i, null_addr);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76x02_mac.h
> index 7d946aa77182..f67f66f65ee0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
> @@ -201,10 +201,11 @@ void mt76x02_mac_work(struct work_struct *work);
> =20
>  void mt76x02_mac_cc_reset(struct mt76x02_dev *dev);
>  void mt76x02_mac_set_bssid(struct mt76x02_dev *dev, u8 idx, const u8 *ad=
dr);
> -int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
> -			   struct sk_buff *skb);
> +int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, struct sk_buff *skb);
>  void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
>  				   struct ieee80211_vif *vif, bool enable);
> +void mt76x02_mac_set_beacon_prepare(struct mt76x02_dev *dev);
> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev);
> =20
>  void mt76x02_edcca_init(struct mt76x02_dev *dev);
>  #endif
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_mmio.c
> index 4e2371c926d8..ae35780aaff1 100644
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
> index d03d3c8e296c..fca861f10563 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> @@ -208,6 +208,8 @@ static void mt76x02u_pre_tbtt_work(struct work_struct=
 *work)
> =20
>  	mt76x02_resync_beacon_timer(dev);
> =20
> +	mt76x02_mac_set_beacon_prepare(dev);
> +
>  	ieee80211_iterate_active_interfaces(mt76_hw(dev),
>  		IEEE80211_IFACE_ITER_RESUME_ALL,
>  		mt76x02_update_beacon_iter, dev);
> @@ -217,9 +219,11 @@ static void mt76x02u_pre_tbtt_work(struct work_struc=
t *work)
> =20
>  	for (i =3D nbeacons; i < N_BCN_SLOTS; i++) {
>  		skb =3D __skb_dequeue(&data.q);
> -		mt76x02_mac_set_beacon(dev, i, skb);
> +		mt76x02_mac_set_beacon(dev, skb);
>  	}
> =20
> +	mt76x02_mac_set_beacon_finish(dev);
> +
>  	mt76x02u_restart_pre_tbtt_timer(dev);
>  }
> =20
> @@ -244,19 +248,15 @@ static void mt76x02u_pre_tbtt_enable(struct mt76x02=
_dev *dev, bool en)
> =20
>  static void mt76x02u_beacon_enable(struct mt76x02_dev *dev, bool en)
>  {
> -	int i;
> -
>  	if (WARN_ON_ONCE(!dev->mt76.beacon_int))
>  		return;
> =20
>  	if (en) {
>  		mt76x02u_start_pre_tbtt_timer(dev);
>  	} else {
> -		/* Timer is already stopped, only clean up
> -		 * PS buffered frames if any.
> +		/* Timer is already stopped,
> +		 * nothing else to do here.
>  		 */
> -		for (i =3D 0; i < N_BCN_SLOTS; i++)
> -			mt76x02_mac_set_beacon(dev, i, NULL);
>  	}
>  }
> =20
> --=20
> 2.24.0
>=20

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXfik0QAKCRA6cBh0uS2t
rC7ZAQCpmXTmcWecawrQDrS31VHaDsU3g6S8yZxzsa6MeCkXvwD6A/NHXcBEApHD
31xR8qqbhRbIZGaA8PrHe9gHAnJLzwA=
=AWXq
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
