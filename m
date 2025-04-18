Return-Path: <linux-wireless+bounces-21724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA23A9387F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 16:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D930463A73
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C11552EB;
	Fri, 18 Apr 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJJOqmRC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67F8148316
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985910; cv=none; b=lXKfmjNJCY+uIyzFPbxmuOstvVzsFKlT4U0Dl5tx3bdu+tB7+CJCg32veAm84Qz5Q0zfqUNSvcRW9NWy34haHnCVtXxVNxArrmrsuCJMS1WLb0WExmegsTPyXV9LvNUc5LUw+GkzFJ85pFwmwQH8N7H4My7eTtnjO+pFWvu53eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985910; c=relaxed/simple;
	bh=5n32s9NEDQCc8cPQhDCbNjILN7zLeP20rHd95jHLwnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmISNO1Kevewr5Ou6hN71r/srvgerGASPHLGzu1TK//N+yMu4saMslMCO5mMmyxQwKp9uMsYC8MbOSHI6RDtlfEk27EBMhEgXIBpnhAHjOQxnQi/Tlp0wBVFm1THmgbN5PLCYB7pXFZEDwR4hhcphpb+RxcEU83vItjxYAETLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJJOqmRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7DFC4CEEA;
	Fri, 18 Apr 2025 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744985910;
	bh=5n32s9NEDQCc8cPQhDCbNjILN7zLeP20rHd95jHLwnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJJOqmRCQHppmp62mSsEYNCCSdwpH2PqRf4PSNiIJ8plGvdrU0S+BucbIdiTPJyNE
	 MhyC+mzX0v/CfD9PadSbUTea2/zthEn9WtRlQGkwK/VVDaMugOckxo7XVcxG2wr+WZ
	 MCo9LOqTt0vQ0jtpKNqNfXd6iKcxG53f00kjmOmqxrJrGkMeK+imLOSUnDDrL9Jv3r
	 PWOGuIYJZbw2u45E3ONB1JNaLAfnahoRuDEHpX4k53FcaUKKp7XqqJvU/mWLsnbohB
	 1ipfbIqa96cYDAV0El6E9k5oypkvzrhDtlxcX3XJCr39WUdOMz5jPY2OoJkSGTlbBK
	 O9peyd8Zw7SmA==
Date: Fri, 18 Apr 2025 16:18:27 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Henk Vergonet <henk.vergonet@gmail.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] [PATCH v2] wifi: mt76x2: Add support for LiteOn WN4516R
 and WN4519R
Message-ID: <aAJfM0vB1X8UgmAM@lore-desk>
References: <aAJHqxIcw6J3yWoU@lore-desk>
 <20250418140631.31014-1-henk.vergonet@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vrN2QJbiu0PQSr0t"
Content-Disposition: inline
In-Reply-To: <20250418140631.31014-1-henk.vergonet@gmail.com>


--vrN2QJbiu0PQSr0t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Ads support for:
>  - LiteOn WN4516R
>  - LiteOn WN4519R
>  Both use:
>  - A nonstandard USB connector
>  - Mediatek chipset MT7600U
>  - ASIC revision: 76320044
>=20
> Disabled VHT support on ASIC revision 76320044:

Just a couple of nits inline. After fixing them please add my Acked-by

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
>  This fixes the 5G connectibity issue on LiteOn WN4519R module
>  see https://github.com/openwrt/mt76/issues/971
>=20
>  And may also fix the 5G issues on the XBox One Wireless Adapter
>  see https://github.com/openwrt/mt76/issues/200
>=20
>  I have looked at the FCC info related to the MT7632U chip as mentioned i=
n here:
>  https://github.com/openwrt/mt76/issues/459
>  These confirm the chipset does not support 'ac' mode and hence VHT shoul=
d be turned of.
>=20
> Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c      |  2 ++
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt76x2/usb.c
> index 84ef80ab4afb..96cecc576a98 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
> @@ -17,6 +17,8 @@ static const struct usb_device_id mt76x2u_device_table[=
] =3D {
>  	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
>  	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
>  	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
> +	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard U=
SB connector */
> +	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard U=
SB connector */
>  	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
>  	{ USB_DEVICE(0x0846, 0x9014) },	/* Netgear WNDA3100v3 */
>  	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drive=
rs/net/wireless/mediatek/mt76/mt76x2/usb_init.c
> index 33a14365ec9b..eb5e957f2f1b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
> @@ -191,6 +191,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
>  {
>  	struct ieee80211_hw *hw =3D mt76_hw(dev);
>  	struct mt76_usb *usb =3D &dev->mt76.usb;
> +	bool vht;
>  	int err;
> =20
>  	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
> @@ -217,7 +218,16 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
> =20
>  	/* check hw sg support in order to enable AMSDU */
>  	hw->max_tx_fragments =3D dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
> -	err =3D mt76_register_device(&dev->mt76, true, mt76x02_rates,
> +	switch (dev->mt76.rev) {
> +		/* these ASIC revisions do not support VHT */

please move this comment in the proper case.

> +	case 0x76320044:
> +		vht =3D false;
> +		break;
> +	default:
> +		vht =3D true;
> +		break;
> +	}

since you are reposting, can you please add a new-line here?

> +	err =3D mt76_register_device(&dev->mt76, vht, mt76x02_rates,
>  				   ARRAY_SIZE(mt76x02_rates));
>  	if (err)
>  		goto fail;
> --=20
> 2.45.2
>=20

--vrN2QJbiu0PQSr0t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAJfMwAKCRA6cBh0uS2t
rCDhAQDJ8Fp516zUEfSZm/BUXzKWM2sQA+FWpUxo5AXbrE3mEAD+MgWO9op08QK6
UUSlEgF7N02+gvYMn6FokDW+UakdBwI=
=+KdH
-----END PGP SIGNATURE-----

--vrN2QJbiu0PQSr0t--

