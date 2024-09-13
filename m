Return-Path: <linux-wireless+bounces-12852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A0978734
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 19:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC9B26324
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688D127E37;
	Fri, 13 Sep 2024 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AhZ3vRpg";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HL/MG13b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a7-28.smtp-out.eu-west-1.amazonses.com (a7-28.smtp-out.eu-west-1.amazonses.com [54.240.7.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DC126BEA;
	Fri, 13 Sep 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249900; cv=none; b=n5UezTAdDhSevzuuJDpHLV7olWZWsjXxHSoXwwiVtBTDdvfgMVs3akMR8m2UQOu+eSKfLuk7Nkuypyhovg0S771x80gwQAMmT8iOdAJvjc7ZzfLdkxs+uyPAg6nTH6jMxJaNWtIAcwcLLP/Eba1nPptEHrbH0TZKu8Liwox4paw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249900; c=relaxed/simple;
	bh=nAKsmdD6r85wt9ceBf++Qmy88QaaHoRP5gInR6BtYy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMInY7ifhs/f8dABHcnO3lcp59y9UzHNSN/OVeoxiXAp96seqb/UvA4GGWPUZJiA2l/GAG/+kQGWpFkVYqmWRCdEa6AFZk0NDLgGgPnkwyfDOM8QU1YQv6cfyQTo6xKshpuN1Cf7LGLDnVtgioB26iTsLQHiwB+uwXgK6dZV4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AhZ3vRpg; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=HL/MG13b; arc=none smtp.client-ip=54.240.7.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726249896;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=nAKsmdD6r85wt9ceBf++Qmy88QaaHoRP5gInR6BtYy8=;
	b=AhZ3vRpgBCdhX/f6W9wkI0ofAtptR9zYy+DH7MXPPkaB0ECIxyK5qVwymU4isHTs
	m4sPOifIJsfSmwOrrNp9q8RI7pEuxnXCnInYShSdGswEMy4v3+erpbo4PWXuP5TQo4K
	hqKobaYvgChQFYo3YK3QPyYUiii24OJJ01CMoa0+FBXW/DAeMIEUFDruL9g+tT1+RaW
	G6t6BDuWd4NBzj+uYpcDH8ErfGv9PEQLx2ZNxybjgJWYhkyaKg5o3tmwHerQTgPGrIG
	LhnZ5JeUVttNdE3viz6MORVg68FD5TNgjpBDabayh4Omp5bYuxMd+GCSn0BaYsM5maO
	dCjnIr7bgA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726249896;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=nAKsmdD6r85wt9ceBf++Qmy88QaaHoRP5gInR6BtYy8=;
	b=HL/MG13bHKHA4YtJqXn1UltnDhxirzBAfPDhnpsgYm6nVWenB+fNRQrL8Fl4evQd
	vZeECa5o8hhQRdUqq6BaomHd/Ow8forCMszGEC5vaK6nQxZRgzTMIrG/l5sg+mMjxB5
	XMrItX4shZUrimCa/xOmvGg2QuCTu9YjhYIDAM3c=
Date: Fri, 13 Sep 2024 17:51:36 +0000
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
Subject: Re: [PATCH v14 2/4] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P
Message-ID: <01020191ec830aa1-a14314cd-0f8e-4a58-bfbf-d600cca51138-000000@eu-west-1.amazonses.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
 <20240910-wireless-mainline-v14-2-9d80fea5326d@wesion.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="biy6e4crx5uq3gf6"
Content-Disposition: inline
In-Reply-To: <20240910-wireless-mainline-v14-2-9d80fea5326d@wesion.com>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.13-54.240.7.28


--biy6e4crx5uq3gf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 11:04:12AM GMT, Jacobe Zang wrote:
> Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
> external low power clock input. In DTS the clock as an optional choice in
> the absence of an internal clock.
>=20
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml       | 8 ++=
++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-=
fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fma=
c.yaml
> index 2c2093c77ec9a..a3607d55ef367 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.ya=
ml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.ya=
ml
> @@ -122,6 +122,14 @@ properties:
>        NVRAM. This would normally be filled in by the bootloader from pla=
tform
>        configuration data.
> =20
> +  clocks:
> +    items:
> +      - description: External Low Power Clock input (32.768KHz)
> +
> +  clock-names:
> +    items:
> +      - const: lpo
> +
>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.34.1
>=20
>=20

--biy6e4crx5uq3gf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbke6YACgkQ2O7X88g7
+prmig/+Iqh8uRsuHHmV82uwDc36+BB6uu5F7/f2GMiK4HCpavIhW2/ZnnMOvKUB
svIpJtnxC3ZaGgsXkJVd9b0qjtgFEhVHUmhtZLzmFgUdlPxKkxbgCNFHjotbAJ8I
0glPXbZnZl1lo++RX0+f8mkAeb+YJNkPVpapIT9r5YPaQkRkKJ6CFURcW8DjAKNX
fKdbM+WQ0D24PM7LnuVF7WanTwFZIpql6nv1pmEsT+7c14R309wxZux8tAlVqqqr
A1AoMz+F2VBpMk7O2jgJgGoogF5tO4ivcYk+WHfz0i99VXYHdyihJLvhrYO/yOoW
5evtRc95kAYd7ZDFwbxQxzgr+LkG7F0I5b3z+e/ZWXJ2PZQo02bb6Uu5ghLrtiHj
nirGGa51ZSxpwwt0bq/O2wbrzHUcNX7hel2yNNrm7UBAtfmVkdB5NUdSdVnNawHh
5lbOU5cIO+x+8VGz59KZKvdbr1/8j5XkS3eO6GQ+5O0BPd0WBRJgSZtj0nWkAEKk
L9ftW0LBFXCCAueCcU17LI5f0KHWPeDcTlsNKCQd9M9Qk5IgXDVRnsrT78RcMY8F
MOn8e6nk+fwudwdt7nC1HPh+bEgPa58H3Jw7r0C3JGZsJIsj256zNaX1ePZZmnIz
a3LwSZX9DTywv8+DWRcgsl7RzTX3AJSKet7X3e5iCK/mi85AAAM=
=3AKE
-----END PGP SIGNATURE-----

--biy6e4crx5uq3gf6--

