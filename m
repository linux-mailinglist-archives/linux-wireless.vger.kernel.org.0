Return-Path: <linux-wireless+bounces-12851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4611497872D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 19:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA541C2233A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D873181AC6;
	Fri, 13 Sep 2024 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nyumg6wO";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ewHt1O6F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a7-50.smtp-out.eu-west-1.amazonses.com (a7-50.smtp-out.eu-west-1.amazonses.com [54.240.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E005811A;
	Fri, 13 Sep 2024 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249870; cv=none; b=YhVIh1KiLNLuYUw0YxDb0pSSUYILEg2OfGaGYRfYIDMm0rHPFfilOoB+Kx/LTNa7gFrWrNhF6d0Cw0bGsiyP4b0IObSMa5+PhyDmmbeVVtcoYME4WzuQaE26YrHraJNThWl8Wg8drtpVjOodQP1YQbFZgJDOaqa1chtnV2ngwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249870; c=relaxed/simple;
	bh=weKSgDbGfPkKlWvUEgYyQ3ih4rSsXzcdQgevS8u5uXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUITM3mn32Hf5q5uDV4FMIkaDr+P9IyakGbn79wkTxSelU/n6zUZOvaZoIFOlV0EI75lsPAy48DG+6Wz9eZVY7YG14mB1rx/NFECqXqS5LuARC0uFlptfk+s6aJgG2RbT+3XjAamHRA1HqJjqxK5RnIA0rUjRrFz5lqPg2sW+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nyumg6wO; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ewHt1O6F; arc=none smtp.client-ip=54.240.7.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726249867;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=weKSgDbGfPkKlWvUEgYyQ3ih4rSsXzcdQgevS8u5uXA=;
	b=Nyumg6wORIhuElwT3wR/skSz0PRdzPS48O9DeSzEPEeF1FovnRc71evQHZomy2Cs
	1M3VB7ex1Yjx+1M7ygNGLZ6Sxqemjlp2YBW88qFm1O1CUKX2SvrJwoSKZlnD9gLTWcv
	wTUKf6CTt+HHyWjMVJManAvCtuttNP78vRRPe0LbnhZrCC1nIK+daMX1kt6/e66ej6o
	igbqw9E3D5db9l2I9OR1sxw26nyTeo07QhqHtel/ij66Im7ppuqAXW6MzJpMHWeEhPT
	mprpBfBB0PuO50o69Wo1290ftz7cb3RhKWRdNL/s+4PvnzBe8wyW4eN4qhvAPE3uOry
	MPbR2s4j0g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726249867;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=weKSgDbGfPkKlWvUEgYyQ3ih4rSsXzcdQgevS8u5uXA=;
	b=ewHt1O6FQlJNVgK79/UEpok9L97OK1Mm5VKlxuzflS2bXsZ/8DRqw3vBgzGQnAs/
	DEA3CGNYxOB1zodJTZmJBwhEhcE7Lr/sQkDh8jfirs3uSncelaaWXikWOTJq+ifEvDM
	ZwP8+irvXoDuRn75Vwviehm5u3YlzXyC4C1ZdnRM=
Date: Fri, 13 Sep 2024 17:51:06 +0000
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	nick@khadas.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v14 1/4] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
Message-ID: <01020191ec829670-4deb0998-8f48-474f-b588-1c19509cc081-000000@eu-west-1.amazonses.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
 <20240910-wireless-mainline-v14-1-9d80fea5326d@wesion.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uedstvshx674acxy"
Content-Disposition: inline
In-Reply-To: <20240910-wireless-mainline-v14-1-9d80fea5326d@wesion.com>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.13-54.240.7.50


--uedstvshx674acxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 11:04:11AM GMT, Jacobe Zang wrote:
> It's the device id used by AP6275P which is the Wi-Fi module
> used by Rockchip's RK3588 evaluation board and also used in
> some other RK3588 boards.
>=20
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

> ---
>  Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | =
1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-=
fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fma=
c.yaml
> index e564f20d8f415..2c2093c77ec9a 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.ya=
ml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.ya=
ml
> @@ -53,6 +53,7 @@ properties:
>            - pci14e4,4488  # BCM4377
>            - pci14e4,4425  # BCM4378
>            - pci14e4,4433  # BCM4387
> +          - pci14e4,449d  # BCM43752
> =20
>    reg:
>      description: SDIO function number for the device (for most cases
>=20
> --=20
> 2.34.1
>=20
>=20

--uedstvshx674acxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbke4EACgkQ2O7X88g7
+poQoQ/7B3UguxgoIlXiLeeJrH9kR6deBlpURctMULFJ+O0AlOul6JL2us2CxqGo
1YBOTNIez5oZ5fvZsXVLMEoSdkd6mLZ4+HTpqrNCD6zU4ckSXG3ys6HGKRyyGDMp
wk5NyDsdpA/4eTlG4NhXWySas0V9PObRlxNVgel+X0wNG+HKMShD2XFXsBB5AFB7
T4L7m50OTPPslFB36jgnhCnfTtV9rQCVDwyDSZ3cjRWn/hqIpU2yX5HMLb1YoptU
sF+hLEpgRCvQk8rWPP328MYKWISOFlFmgxa9/Inp74ZsQ4FrnCarSz7CWKRh8Tie
zXdeONyGQLikzWxJC6zzoTloubbdcS/6OHzvVOxLktSQQu5e4dpoZ6HyUvt64QeD
v09NT7CSS+N/AbtQRgdWBDYCcqwzH/THWD91IpeNp1qJtD59vem8r74L8WxTxX/b
aOffL9aYwgi25Zb2knAkWnGGCpPOE89hZ3zHAbR6qbVeqKO7eNBLb/1Qs2OM75zD
0xkF+Ts/EvB2bZ4K1zF6xw2AVpcUSCBxun4gytC6xlzzOvRltrPSZwk+mB6w64Iy
cBZGv+wrtw5D0Ciio3HgAe2neQNum0pmNuPJbyoN8Rsgx0WnkPvAvxY6U4nw5kJU
nVV0K8ru0WBM5MgB4UjXcIXvKsB+No/t3bjC0k/R8SRf5YeSoCg=
=jHQ0
-----END PGP SIGNATURE-----

--uedstvshx674acxy--

