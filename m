Return-Path: <linux-wireless+bounces-17433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D169A0BFD5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F1118889BF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD31C3039;
	Mon, 13 Jan 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E45S/juY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0A1865E5;
	Mon, 13 Jan 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793132; cv=none; b=mNTMMOL3E3THEUxqjfObh3ORAIP/vJq7mSacDZ1ONkU3H5kcseZES9heeBisz8CsdCjEchBQntN8Eb4wdDs7NoDnQoJgBhejZ0afwNaim5LeGzNWd+OQu0qgXelPIymWu0k5MSZov7MtMbIM0qDhpgLNubMoHAVD7v9KevpRnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793132; c=relaxed/simple;
	bh=ChatsE/2ZwoToNESr2wfZSXK7J1h+JSx79alnmHkTEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUsUluFnw5DDJv19/sPhV0uxVXBfN4EB1VsQLXSSutA80JsATIhlne2Xug6OAipz4WXP1byue5T+N4MYrzjhnb33Qp/9p0pIoAEdEqxKhLMpvKo2l2zIjdHHTgUWCXE+zd8Z20ayq1dqpL/YYv6r6oAjkIUfDrCPC0H3dCQKnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E45S/juY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA22C4CED6;
	Mon, 13 Jan 2025 18:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793131;
	bh=ChatsE/2ZwoToNESr2wfZSXK7J1h+JSx79alnmHkTEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E45S/juYtSzPs6KuAbowE5vvW5IMM44ewkoQDCk4T+EG9Gy9nzL/iJMZdsjaBWG2V
	 pJu1+oOG+Kvw08ZSDDzpcL/DxGZv0E89O7EXR9qOC7T6oJpSzAfXRpoaPngqG5X4aP
	 lbC1CmEz+s6cYt0sJK7E/+Gr+/qj5nhkzdcjDQbOKkaZrOJrRJuohhu/mCk6HGwuEW
	 hF3WKnQfg757d/5KV62NkqZal3lhKdf+PgWwbPh737zRa7HyC/UXyepz2bEs5HwWRY
	 rW8wqfvc+VHywt7G8RGBZZgyI8K/jFgwZ6Xmy1Mf5xKVUz/Q0obMUyEdPoQ/4y1T3n
	 wg04yEdcaQLGQ==
Date: Mon, 13 Jan 2025 18:32:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	m.felsch@pengutronix.de, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: rfkill-gpio: enable
 booting in blocked state
Message-ID: <20250113-skater-surrogate-4c72df770dbf@spud>
References: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dt87A4u3Gm4vB2U0"
Content-Disposition: inline
In-Reply-To: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>


--Dt87A4u3Gm4vB2U0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 09:19:01AM +0100, Catalin Popescu wrote:
> By default, rfkill state is set to unblocked. Sometimes, we want to boot
> in blocked state and let the application unblock the rfkill.
>=20
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  Documentation/devicetree/bindings/net/rfkill-gpio.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml b/Doc=
umentation/devicetree/bindings/net/rfkill-gpio.yaml
> index 9630c8466fac..22f26f1a3856 100644
> --- a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
> +++ b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
> @@ -32,6 +32,10 @@ properties:
>    shutdown-gpios:
>      maxItems: 1
> =20
> +  default-blocked:
> +    description: configure rfkill state as blocked at boot
> +    type: boolean

type here should be flag, not boolean.

> +
>  required:
>    - compatible
>    - radio-type
> @@ -48,4 +52,5 @@ examples:
>          label =3D "rfkill-pcie-wlan";
>          radio-type =3D "wlan";
>          shutdown-gpios =3D <&gpio2 25 GPIO_ACTIVE_HIGH>;
> +        default-blocked;
>      };
>=20
> base-commit: 25cc469d6d344f5772e9fb6a5cf9d82a690afe68
> prerequisite-patch-id: 0000000000000000000000000000000000000000
> --=20
> 2.34.1
>=20
>=20

--Dt87A4u3Gm4vB2U0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ4VcJgAKCRB4tDGHoIJi
0rF3AQCM/r9pxHi+so72DkY+Xwx5EGfUKpRnJ7wVsCHV1iYzzwEA+m9whbZwaGtp
wE3gnhkwa6VfYNEMn9om0jw4Y93S2Aw=
=uxlE
-----END PGP SIGNATURE-----

--Dt87A4u3Gm4vB2U0--

