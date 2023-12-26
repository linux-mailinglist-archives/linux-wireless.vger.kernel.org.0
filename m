Return-Path: <linux-wireless+bounces-1285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A57A81E853
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Dec 2023 17:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B393C1C21F33
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Dec 2023 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF54F5F3;
	Tue, 26 Dec 2023 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT/wHAtk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE94F5EF;
	Tue, 26 Dec 2023 16:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5515CC433C8;
	Tue, 26 Dec 2023 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703607514;
	bh=cD61w0kfXh0Ip7/OJuf71M+hh2M00ji19TmDtOw9nt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eT/wHAtkqLxJfSdvk16x3D65Hf+KIwe8DTj9NpBTnWFJ6NOwSr0etOREEmETpwn4+
	 XMyksFzOmqHt6JLTKf8JXOfk6PfLEBMNOYOU6wSQoFTMmJtWRgfdTVQjMKNsPtqFmY
	 4fCJsBXj8Rea+W/n5V2rU7b/2eFZ2U6kTKGeXLGwCOV7FV/eNKQqy+eRg8y9dNpWjk
	 jL5JtH15buHSsvaWHmnVxLqgaDEv9xKuyMRp8MBtNPjvkSsPSUasFT9f7rqgjcFMVj
	 ReFnM9qy9hU4xXB85I6WoMULi+vsSrIVSo9uI5fiF8WyPoSw+rWERrHj3ma/QtTDf1
	 eUnJ5R9dPpnUQ==
Date: Tue, 26 Dec 2023 17:18:28 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dacio Romero <dacioromero@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt76x2u: add netgear wdna3100v3 to device
 table
Message-ID: <ZYr81OGPby-sZbhP@lore-rh-laptop>
References: <20231223063711.487002-1-dacioromero@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fiRpbVuCs5o8SpDL"
Content-Disposition: inline
In-Reply-To: <20231223063711.487002-1-dacioromero@gmail.com>


--fiRpbVuCs5o8SpDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Netgear WDNA3100v3 has a chipset that's compatible with the mt76x2u drive=
r and works without modification with the mainline kernel by writing to sys=
fs.
>=20
> Signed-off-by: Dacio Romero <dacioromero@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt76x2/usb.c
> index 55068f3252ef..e0643b0dfdc5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
> @@ -18,6 +18,7 @@ static const struct usb_device_id mt76x2u_device_table[=
] =3D {
>  	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
>  	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
>  	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
> +	{ USB_DEVICE(0x0846, 0x9014) },	/* Netgear WNDA3100v3 */
>  	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
>  	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
>  	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
> --
> 2.42.0
>=20

--fiRpbVuCs5o8SpDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZYr80QAKCRA6cBh0uS2t
rG7jAP44JkwPefhH5QCnZ98/fOIu6d6BvRkvglgHPguaZajI2wEA9PoupYMSL+j+
Ez9tdmXyGKwFFVq6CVUV2DnhT7BLBQ4=
=hGaY
-----END PGP SIGNATURE-----

--fiRpbVuCs5o8SpDL--

