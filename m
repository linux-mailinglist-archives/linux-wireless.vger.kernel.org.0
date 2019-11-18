Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E7100574
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 13:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKRMSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 07:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfKRMSq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 07:18:46 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76AC6206D4;
        Mon, 18 Nov 2019 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574079524;
        bh=6xGKiENHXTbJoR/Lq2la8hvRLc4qD3zNObT7Xl5BNms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vaHkmCvRsHGIeelAhpcCXqcQ8+KoU0a4vGcyIt7HImQUFDd7pYnzTM5/tVUSdRHkI
         euNctpVejZCdID8BWZLlABhtfp4jclGpbiNRV0NDkqqpj2cU0BR3aSuuLSdSnolU/Q
         Nal4ozUJ1oRKhCS9+pQCbnTaP1zt8MYfgABhRZGo=
Date:   Mon, 18 Nov 2019 14:18:35 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH v2 2/4] mt76: mt76x02: split beaconing
Message-ID: <20191118121835.GA19790@localhost.localdomain>
References: <20191118113907.9862-1-markus.theil@tu-ilmenau.de>
 <20191118113907.9862-3-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20191118113907.9862-3-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--mYCpIKhGyMATD0i+
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

Could you please fix following checkpatch errors/warnings?

Regards,
Lorenzo

ERROR: open brace '{' following function definitions go on the next line
#58: FILE: drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c:62:
+void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev) {

ERROR: space required before the open parenthesis '('
#73: FILE: drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c:66:
+       for(i =3D 0; i < hweight8(dev->mt76.beacon_mask); ++i) {

WARNING: braces {} are not necessary for single statement blocks
#73: FILE: drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c:66:
+       for(i =3D 0; i < hweight8(dev->mt76.beacon_mask); ++i) {
                bcn_idx +=3D !!dev->beacons[i];
        }

CHECK: Please don't use multiple blank lines
#98: FILE: drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c:84:
+
+


> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  .../wireless/mediatek/mt76/mt76x02_beacon.c   | 46 +++++++------------
>  .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  1 +
>  .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  5 ++
>  .../wireless/mediatek/mt76/mt76x02_usb_core.c |  5 ++
>  4 files changed, 28 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_beacon.c
> index 403866496640..faa6de6914a3 100644
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
> @@ -60,41 +56,32 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 =
bcn_idx,
>  		dev->beacon_data_mask &=3D ~BIT(bcn_idx);
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
> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev) {
>  	int i;
> +	int bcn_idx =3D 0;
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
> -
> +	for(i =3D 0; i < hweight8(dev->mt76.beacon_mask); ++i) {
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
> @@ -115,6 +102,7 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev=
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
> index efa4ef945e35..e6e585c72f0d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
> @@ -197,6 +197,7 @@ int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u=
8 vif_idx,
>  			   struct sk_buff *skb);
>  void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
>  				   struct ieee80211_vif *vif, bool enable);
> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev);
> =20
>  void mt76x02_edcca_init(struct mt76x02_dev *dev);
>  #endif
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_mmio.c
> index dc773070481d..73c39d03b7f8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> @@ -24,10 +24,15 @@ static void mt76x02_pre_tbtt_tasklet(unsigned long ar=
g)
> =20
>  	mt76x02_resync_beacon_timer(dev);
> =20
> +	/* Prevent corrupt transmissions during update */
> +	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);
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
> index 78dfc1e7f27b..8a2a90fb5663 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> @@ -179,6 +179,9 @@ static void mt76x02u_pre_tbtt_work(struct work_struct=
 *work)
> =20
>  	mt76x02_resync_beacon_timer(dev);
> =20
> +	/* Prevent corrupt transmissions during update */
> +	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);
> +
>  	ieee80211_iterate_active_interfaces(mt76_hw(dev),
>  		IEEE80211_IFACE_ITER_RESUME_ALL,
>  		mt76x02_update_beacon_iter, dev);
> @@ -191,6 +194,8 @@ static void mt76x02u_pre_tbtt_work(struct work_struct=
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

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXdKMFwAKCRA6cBh0uS2t
rL1aAPUQYqmdYRGfo+DruTtdcmyUc+xaJqRH0i0NdLF+TTVJAQDl3ST+7whBFtnZ
6MguGkzRd2zEgO1WAIsSjbaDwx60DQ==
=deLq
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
