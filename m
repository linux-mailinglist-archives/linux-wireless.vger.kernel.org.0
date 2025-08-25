Return-Path: <linux-wireless+bounces-26587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91EB347AC
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 18:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57D11B25188
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2617930102C;
	Mon, 25 Aug 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvnR5H60"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4B2FF679;
	Mon, 25 Aug 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139891; cv=none; b=fWIZmkSN+rkkdLWTUc04US8vmLhaep0/UuO6v2slcccgcG4m0ttssWb+kEk5BRR+3NsbAcr9vNxLg2YUaSc/KhuA5BX7N7lcrCY1+sYVMhwT3oecSkqS96DizA3Ve61LBym+v8ENHUdVfL/AhabqoJGaDpHua/6iCFEVrVzdHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139891; c=relaxed/simple;
	bh=7mUfLSCBWD1MYuo9l2/63RIC4KDlYG3k8tkDoDPvm+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0JToLVmoGMzBoXLDYfHaW2c9PbicjrVoLPaxqN8u6/4/hlIwat3kJmnYzn4mGpWk0LhV8RWx0klkfQnHsGbU6GmwyaJOYjWPER4p1wy5SOwXu3CedIsEYJV+U6MreQGux4iuZAdP8324G52WyD3cB4FSrz+W2gZYCvtjF1Lf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvnR5H60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FDDC4CEF4;
	Mon, 25 Aug 2025 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139889;
	bh=7mUfLSCBWD1MYuo9l2/63RIC4KDlYG3k8tkDoDPvm+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvnR5H60h7Dcgutnxpo7XwBGj4oNctv73q49/qCnXDp++WJXzJDi1tXxGgOj2DTIy
	 so4UN3/c1f1C6Ok3vNmb4Lf7kshciuw2DxYRt2lzFAD9eNH8wihf4xS8eQ50S9qtsV
	 nG76piztgjNx0xktbtXUkXO1NkBxFzwsyA7PnPsG8MOtAQX/h3BaFIj3CuHlo6bOgp
	 8D18OLVXit4dHV1i2d6yi5tlK5TAkLQnyQh6jnCDUlBMlSOnMPDsTG9QVY/fljU8JB
	 yvqqNimn2dPzLx4mwQIDFs7xTnzxxwwWsG/IfABmQYm02QE/lneQC0xIbNTGVK3+CE
	 d1l4qkJf/VRLA==
Date: Mon, 25 Aug 2025 17:38:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCHv3 1/3] dt-bindings: net: wireless: ath9k: add led bindings
Message-ID: <20250825-clobber-disdain-9e50d85ab1df@spud>
References: <20250825044812.1575524-1-rosenp@gmail.com>
 <20250825044812.1575524-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YPv8OWfa8zOWcG/s"
Content-Disposition: inline
In-Reply-To: <20250825044812.1575524-2-rosenp@gmail.com>


--YPv8OWfa8zOWcG/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 09:48:10PM -0700, Rosen Penev wrote:
> The ath9k driver has various pin GPIO numbers for different chipsets
> which are not always correct for every device.
>=20
> Add bindings to specify the correct number and if it should be
> active-low.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yam=
l b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> index d16ca8e0a25d..bbac017d34d0 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> @@ -50,6 +50,18 @@ properties:
> =20
>    ieee80211-freq-limit: true
> =20
> +  led:
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      led-active-low:

How come you are not including leds/common.yaml and making use of the
active-low property defined there? Seems to be in use by mediatek,mt76.yaml

> +        description:
> +          LED is enabled with ground signal.
> +        type: boolean
> +
>    qca,no-eeprom:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> @@ -102,5 +114,9 @@ examples:
>          compatible =3D "qca,ar9130-wifi";
>          reg =3D <0x180c0000 0x230000>;
>          interrupts =3D <2>;
> +        led {
> +          reg =3D <0>;
> +          led-active-low;
> +        };
>        };
>      };
> --=20
> 2.50.1
>=20

--YPv8OWfa8zOWcG/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKyRbAAKCRB4tDGHoIJi
0h0OAQDBDEKhftnhXHMEgMiA2H6dYxbbIb9PD9NTgTYltTOXTQD7B7ABSRADWj+2
Mp6Di5eAoBYNGf9BdPi+mxjQdkskXgk=
=DUs8
-----END PGP SIGNATURE-----

--YPv8OWfa8zOWcG/s--

