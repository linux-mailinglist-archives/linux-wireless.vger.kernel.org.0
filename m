Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED817FEBEF
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 12:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKPLpY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 06:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfKPLpY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 06:45:24 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF591206F4;
        Sat, 16 Nov 2019 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573904722;
        bh=ntANBIfqpdrUncBDMrXIVwHHvI45f6WgayOWxvtuErA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Olr01n7dZmdIvLJJwc5TwvYxfU4+1enimm5YLslbGVwHJw334drExyQvBVMJQANfh
         /Cna+NXXwjmrrUbtIdw5bLxGdLAgqN8YWbGADFrwzjbLDf2+hWo+CHFw9i9AXbkk+K
         5OQAFu2LJmstOvWEU0uGqB8MtFCOFJ3lbIjmcZok=
Date:   Sat, 16 Nov 2019 13:45:17 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH 4/4] mt76: mt76x02: add channel switch support for usb
 interfaces
Message-ID: <20191116114517.GD20820@localhost.localdomain>
References: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
 <20191116111709.4686-5-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <20191116111709.4686-5-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This patch enables channel switch support on mt76 usb interfaces.
>=20

Hi Markus,

I was thinking about it, but since usb does not support DFS what is the pur=
pose
of CSA in this case?

Regards,
Lorenzo

> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 7 +++++++
>  drivers/net/wireless/mediatek/mt76/mt76x02_util.c     | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  | 5 +++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/driv=
ers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> index aedab4cc8d40..32e6c37aa80d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> @@ -179,6 +179,12 @@ static void mt76x02u_pre_tbtt_work(struct work_struc=
t *work)
> =20
>  	mt76x02_resync_beacon_timer(dev);
> =20
> +	mt76_csa_check(&dev->mt76);
> +	if (dev->mt76.csa_complete) {
> +		mt76_csa_finish(&dev->mt76);
> +		goto out;
> +	}
> +
>  	mt76x02_mac_set_beacon_prepare(dev);
> =20
>  	ieee80211_iterate_active_interfaces(mt76_hw(dev),
> @@ -195,6 +201,7 @@ static void mt76x02u_pre_tbtt_work(struct work_struct=
 *work)
> =20
>  	mt76x02_mac_set_beacon_finish(dev);
> =20
> +out:
>  	mt76x02u_restart_pre_tbtt_timer(dev);
>  }
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_util.c
> index 414b22399d93..3f95e5b24e1d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
> @@ -174,7 +174,6 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
>  		wiphy->reg_notifier =3D mt76x02_regd_notifier;
>  		wiphy->iface_combinations =3D mt76x02_if_comb;
>  		wiphy->n_iface_combinations =3D ARRAY_SIZE(mt76x02_if_comb);
> -		wiphy->flags |=3D WIPHY_FLAG_HAS_CHANNEL_SWITCH;
> =20
>  		/* init led callbacks */
>  		if (IS_ENABLED(CONFIG_MT76_LEDS)) {
> @@ -184,6 +183,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
>  		}
>  	}
> =20
> +	wiphy->flags |=3D WIPHY_FLAG_HAS_CHANNEL_SWITCH;
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
> =20
>  	hw->sta_data_size =3D sizeof(struct mt76x02_sta);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drive=
rs/net/wireless/mediatek/mt76/mt76x2/usb_main.c
> index eb73cb856c81..2f2c39a6a9e6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
> @@ -100,6 +100,10 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
>  	return err;
>  }
> =20
> +void mt76x2u_channel_switch_beacon(struct ieee80211_hw *hw,
> +				   struct ieee80211_vif *vif,
> +				   struct cfg80211_chan_def *chandef) {}
> +
>  const struct ieee80211_ops mt76x2u_ops =3D {
>  	.tx =3D mt76x02_tx,
>  	.start =3D mt76x2u_start,
> @@ -121,4 +125,5 @@ const struct ieee80211_ops mt76x2u_ops =3D {
>  	.get_survey =3D mt76_get_survey,
>  	.set_tim =3D mt76_set_tim,
>  	.release_buffered_frames =3D mt76_release_buffered_frames,
> +	.channel_switch_beacon =3D mt76x2u_channel_switch_beacon,
>  };
> --=20
> 2.24.0
>=20

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXc/hSQAKCRA6cBh0uS2t
rGCjAQC26tLvBN92EhWjIqqlgbrL1NUhJZTJoFe4kRlIc+xGkQD+KeUyPVeqTl2Z
eOWRx7sQIzSRUDWXbQrR9CMJZ5QXKA0=
=9b/e
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
