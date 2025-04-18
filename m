Return-Path: <linux-wireless+bounces-21719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06020A93742
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDCD3B003A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FBC1A3168;
	Fri, 18 Apr 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAuQXFAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806722116EE
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979886; cv=none; b=O6+JEseD7zq14mIw/HuNlGOd349yM13WmTZNXVQ0OdytZZSrjWlByXzZpDNMyySBIcdY9coXDrB/gZwSXWUUEHZIS1j93t5SezAUThGIQbsiI9IBznnSvZxbXmfDf+yg4mGQYU5nXKiwJNeMKvaRzewpYygAShL1YsuyyM8UC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979886; c=relaxed/simple;
	bh=kvnuw/kQ62i/1jH6aT0IeNjwb2IFAcWwi6wLE+cyb8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQnHP8bWWQ+gGcJtF5BAfmge0Sb4rFyJQYb5KZG2r6ALvUaUa5b2XSrhilYYcBhSR8WLtha5BA9J32dxQovdfArGuUBGtE4ZJD+jo37fQ5It9j0wIJjOu3f/41uhe4mBrZpIE9K+XjiQkYYOrF9hpbSQlgOHE9uzkjNNoaAUFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAuQXFAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA41C4CEE2;
	Fri, 18 Apr 2025 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744979886;
	bh=kvnuw/kQ62i/1jH6aT0IeNjwb2IFAcWwi6wLE+cyb8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAuQXFACh+NVL2HinQcjx3xdn2mtlN+R1cAtl3UzDC33tkdyGZ3wvZxIUBvFd/SWR
	 IZ1YopObBZurFgkwmgO5s2b0maVBi/77nt58yhoioHzx9dOjMD/10ydaybmZUH+v3w
	 mrtQf7plD2GZwPPI4zMv884us9R/IfDyZ+8pDWLt06HxDATG+MVAyUUeT6iFvh3dzP
	 AEFP5T9DlAR6n+25jyvaU5/tTor5b3SdQATHqVj+unvQkXLWmd87sEc2NaWUkJxnDo
	 SHXVTUj9UGnDvWNVVIO8GQSLH7FLdLx043MC6I7Ow0r3A6hRIjLCu1VGE3RO7Y9aKU
	 6ew8kp4p8pSEw==
Date: Fri, 18 Apr 2025 14:38:03 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Henk Vergonet <henk.vergonet@gmail.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 2/2] mt76: mt76x2: Disable VHT on 0x76320044 ASIC
Message-ID: <aAJHqxIcw6J3yWoU@lore-desk>
References: <20250418002827.26806-1-henk.vergonet@gmail.com>
 <20250418002827.26806-2-henk.vergonet@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1s13qsCgJRvPDLUO"
Content-Disposition: inline
In-Reply-To: <20250418002827.26806-2-henk.vergonet@gmail.com>


--1s13qsCgJRvPDLUO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Henk Vergonet <Henk.Vergonet@gmail.com>
>=20
> VHT is not supported on ASIC revision 0x76320044
>=20
> This fixes the 5G connectibity issue on LiteOn WN4519R module
> see https://github.com/openwrt/mt76/issues/971
>=20
> And may also fix the 5G issues on the XBox One Wireless Adapter
> see https://github.com/openwrt/mt76/issues/200
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

I think this patch must be squashed with the previous one. Moreover, can you
please run checkpatch.pl? There are some coding style problems here.

>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drive=
rs/net/wireless/mediatek/mt76/mt76x2/usb_init.c
> index 33a14365ec9b..fbb337ef6b68 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
> @@ -191,6 +191,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
>  {
>  	struct ieee80211_hw *hw =3D mt76_hw(dev);
>  	struct mt76_usb *usb =3D &dev->mt76.usb;
> +	bool vht_flag;

maybe something more meaningful, like 'is_vht' or even just 'vht'.

>  	int err;
> =20
>  	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
> @@ -217,7 +218,15 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
> =20
>  	/* check hw sg support in order to enable AMSDU */
>  	hw->max_tx_fragments =3D dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
> -	err =3D mt76_register_device(&dev->mt76, true, mt76x02_rates,
> +	switch(dev->mt76.rev ) {

remove space before ')'

> +		/* these ASIC revisions do not support VHT */
> +		case 0x76320044:

are you sure this is true for all '0x76320044' ASICs?

> +			vht_flag =3D false;
> +			break;
> +		default:
> +			vht_flag =3D true;

missing break

> +	}
> +	err =3D mt76_register_device(&dev->mt76, vht_flag, mt76x02_rates,
>  				   ARRAY_SIZE(mt76x02_rates));
>  	if (err)
>  		goto fail;
> --=20
> 2.45.2
>=20

--1s13qsCgJRvPDLUO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAJHqwAKCRA6cBh0uS2t
rDwbAP9JWKnNSiKIZCd4th+Ue1HwxiBNsIbLVHph+P42eiltyAEAitxF8XZDjZTa
+g7CSACyyMQmAwKFCbLo1kZh57Je3Qc=
=1bEn
-----END PGP SIGNATURE-----

--1s13qsCgJRvPDLUO--

