Return-Path: <linux-wireless+bounces-3884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A089085E703
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 20:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5361C236BD
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 19:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4685C55;
	Wed, 21 Feb 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJb4n2U2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351171097B;
	Wed, 21 Feb 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542817; cv=none; b=AHEY0Tpoff+1lb9S5uW9127r3uubhmE6jwHN3wfzrPGf7DyWltiBdyUvCHzcu148DxMDXsy+zD+YvT96/IudgJZFLP874iFYCrWcSEQgJ9iudKbm1pBoDbgNzzWw460RTROG+VcxjAFVOG5SVcFzRubSi3VhlIHR8CVxxBVhZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542817; c=relaxed/simple;
	bh=QaruHLDI79GZ001Bdc61NjMdRzFiiC4zCa5MLuC+OhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+qBJ0Sl+RrYbyInT386rlTJAPzFPoukzT2MUTQxybFL3k66oXp1JrtcWuKD36IvO2xaUBo4o92HEGdirsZCVRy+J34yKBmY5hwwk+uYFGNAC9aehVEuUKjV3tB+TraRSLqoy5g3Jw5JWrELALNtOsAk+4W5tAOqF0hpZDvj134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJb4n2U2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE581C43390;
	Wed, 21 Feb 2024 19:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708542817;
	bh=QaruHLDI79GZ001Bdc61NjMdRzFiiC4zCa5MLuC+OhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJb4n2U2eZHX1cSTemhY3vzSZ8HoBtnsojjEptGF8wbso+P5TE9uhTBpMpkeL1GvI
	 Yaiyai1CRkyAo1EQ/5Pi4YpBzfy5miGL98ylum1jL/ytB5iJF5/eFlTbZ/Eq4XrcCj
	 8KfunBY3QTsx99wqY3IDBZcyOeanxitmA9sqA0me9tPOVe9k7BYwnlHha/16b7jUm/
	 oZZMlTlZa0aqrjI3LUoDtY7JAlJmj/zTfRYTOTLY5uL/UKoVpATo20M9AyHDDC3xs5
	 Ek1wiqJij6Wl8TVjb58XQdL5/rvVv01OWBcEN5miN57ilxuC66mNK8h0Gx89dLIZoN
	 6Du0hDSya4FIQ==
Date: Wed, 21 Feb 2024 19:13:28 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH] dt-bindings: net: wireless: mt76: allow all 4 interrupts
 for MT7981
Message-ID: <20240221-sanction-bunt-c109f5b590ad@spud>
References: <20240221081238.24775-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bhWJY3qBE52/XE2r"
Content-Disposition: inline
In-Reply-To: <20240221081238.24775-1-zajec5@gmail.com>


--bhWJY3qBE52/XE2r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 09:12:38AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> MT7981 (Filogic 820) is a low cost version of MT7986 (Filogic 830) with
> a similar wireless controller that also supports four interrupts.
>=20
> Cc: Peter Chiu <chui-hao.chiu@mediatek.com>
> Cc: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/net/wireless/mediatek,mt76.yaml          | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76=
=2Eyaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index 0c6835db397f..eabceb849537 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -226,6 +226,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - mediatek,mt7981-wmac
>                - mediatek,mt7986-wmac
>      then:
>        properties:
> --=20
> 2.35.3
>=20

--bhWJY3qBE52/XE2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZLWAAKCRB4tDGHoIJi
0kONAQDqsYPyk+Xh1pFriAlkVoN7c20zpvx6Y29oSQlblZCUeAEAxoXzl21csZ6Z
PWCKlnugWhjOIi8PNZCuB7zz8zEZSQ4=
=2GfW
-----END PGP SIGNATURE-----

--bhWJY3qBE52/XE2r--

