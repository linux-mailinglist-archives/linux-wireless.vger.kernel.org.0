Return-Path: <linux-wireless+bounces-27258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE704B543F6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 09:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C24F4E239F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 07:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFB2D0601;
	Fri, 12 Sep 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEa+pBRi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AEB2C3251;
	Fri, 12 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662408; cv=none; b=BwaPyfNADNTHIdQp6NIyVmr2Minb7DudGPw+6fQ1MS6nm1gMGJ+GIon7bplx4qTdasTOR/9hsyszwZgaSVr1XtrPh36v+dI4IzggmN42f3huZ1cs5E3A+Dy6GqwwoAHl5hO9hpJPyISX2X5QUbF5/yIFzdlJwZX468c8S/33hXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662408; c=relaxed/simple;
	bh=NdE5KtAR7ZliEyved7DehbeG3L9Siu9U6prX+k2jfCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJc9pKHRo19Nxh0fhh+w6l03fbi3+9r7HSpS3niqQEU/PrIoEL8Cu3F1Lc0KK1PepOW7Pc/ze8iZFvu3otMQUu2T0DwsZh30pvK2mBevAg1eDMeX+1wRgtxBhJWibEH5y/hW7lVvqH/w9NPv7+cEiaF1SnMsSYKgcJY4i3Q5iTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEa+pBRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CE6C4CEF5;
	Fri, 12 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757662407;
	bh=NdE5KtAR7ZliEyved7DehbeG3L9Siu9U6prX+k2jfCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEa+pBRiWrjiLgiMU5+yCwmhHkH4SBlvGLORxHSTmk24Ou2u/ouHR1WWp1i9eXCMT
	 otnpLGlL5e+RZIXi2Ti73Irqvih47qp/nB33Jjh9lOrob+dbMZv/gipUflAhzFJzpM
	 7Mvcgrha4qWCl4x1faA6Eu3rvafKVL7+SUNtqcks+g/yJZKjxK1HgsYsJ0i+7taLzw
	 lVWEt/LXl6yr6nCAegaOPGtxdAt2WZte06cmejaHtBJhPPC1FnGeOPaKhMmSHTx6Fb
	 pFAl8n/nEkhIAmz9+E6HwnHRULibWuaSOToB1XlWDQ15D9+FrFBgZVIqewp/Wm2fqe
	 ezQ+VsCR6sX9w==
Date: Fri, 12 Sep 2025 09:33:23 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Nick <morrownr@gmail.com>
Cc: Autumn Dececco <autumndececco@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: mt76: mt7921u: Add VID/PID for
 Netgear A7500
Message-ID: <aMPMw_q8bSZtJK9-@lore-rh-laptop>
References: <CAFktD2fBPP_RQQ6OpL6NZy8rqn9jF=BCGOSiEMQNtw5c6MzwPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ciJWrHNi9IC3WZC7"
Content-Disposition: inline
In-Reply-To: <CAFktD2fBPP_RQQ6OpL6NZy8rqn9jF=BCGOSiEMQNtw5c6MzwPg@mail.gmail.com>


--ciJWrHNi9IC3WZC7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add VID/PID 0846/9065 for Netgear A7500.
>=20
> Reported-by: Autumn Dececco <autumndececco@gmail.com>
> Tested-by: Autumn Dececco <autumndececco@gmail.com>
> Signed-off-by: Nick Morrow <morrownr@gmail.com>
> Cc: stable@vger.kernel.org

Addressing the nit below, you can add:
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> index fe9751851ff7..100bdba32ba5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> @@ -21,6 +21,9 @@ static const struct usb_device_id mt7921u_device_table[=
] =3D {
>   /* Netgear, Inc. [A8000,AXE3000] */
>   { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9060, 0xff, 0xff, 0xff),
>   .driver_info =3D (kernel_ulong_t)MT7921_FIRMWARE_WM },
> + /* Netgear, Inc. A7500 */
> + { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9065, 0xff, 0xff, 0xff),

please add a tab here.

> + .driver_info =3D (kernel_ulong_t)MT7921_FIRMWARE_WM },
>   /* TP-Link TXE50UH */
>   { USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0107, 0xff, 0xff, 0xff),
>   .driver_info =3D (kernel_ulong_t)MT7921_FIRMWARE_WM },
> --=20
> 2.47.3
>=20

--ciJWrHNi9IC3WZC7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaMPMwQAKCRA6cBh0uS2t
rLZUAQCvFrbIh41Y243Tgfe6tgemxlN59aMOokMOMIVFYP9rxQD+I5H4J7ADjv+y
guO/VWfOoiZSzR1Hq2ZlyQ0wQPun8g0=
=r1P7
-----END PGP SIGNATURE-----

--ciJWrHNi9IC3WZC7--

