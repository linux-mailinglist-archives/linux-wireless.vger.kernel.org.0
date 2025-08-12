Return-Path: <linux-wireless+bounces-26287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5787B21C4F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 06:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4B1685757
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 04:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7A2E03E0;
	Tue, 12 Aug 2025 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t14BuTRS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D629405;
	Tue, 12 Aug 2025 04:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974083; cv=none; b=JSVqW1ZbdRQTWafgDkRlS4EZG9IxFBIGLRnEAcetoGvfeui0sjbELvTbZIDLS5oqYC/imQkk0cYlTtlUSHLpn/4jbVE1aoFEMMrNs/aXer8ipWGmYN3CfCQJaV5CO2cTXjqO+IfqokRO6ZdlPCnTeB2H88xF6ZHhS3ZAETuzx+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974083; c=relaxed/simple;
	bh=L8L/AG5G7UAoXL1PYS/u6Nnpj1wCsKju5KEwMHdal5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1jCrqFGswuNgxhdTZCwYWltO6HRnz6nY3JTB1A2/f4vlCq5IE6tv5qPgkAN4O3Jk6U/u2RA5Pe9IOe5Xk/b9YbblQLXN99svuqbNPBZ/1C1hYiKUV7c+X9EToDN6fdw7V5Ab6Ev4ZKvw9oUDclm7C4in6Sg5ZLIvHBt0StJzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t14BuTRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578E4C4CEF5;
	Tue, 12 Aug 2025 04:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754974081;
	bh=L8L/AG5G7UAoXL1PYS/u6Nnpj1wCsKju5KEwMHdal5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t14BuTRSKl7Vt728N9usBcoblwvlD2/EKJKXoCuYFngh0woOOWAanrRi9rKD2m7zA
	 oggmfQDUn9MAKQ9frbyl2aUe+Ahz38AU85z9QIUvDlinAgkVgvZAdJcv3e7DTuHrXO
	 7lwb/cMnclDw1apnuZZPNJQF5lHA/R3MiMUXaF5NUqTxm2XOdtuQ0h6tH5tK1hb3C6
	 bRLXHjBtpqXDKMiDqVyGt2BPFRG8ErTumatjseTugpO05MpP90Q+It0EiD58FKS8L0
	 DI84EiQMM3wkLk9uDUp8rtLxms6LjgdR7S2evdjDfO2NTOcm7lOG8IwPsLifmZGTNG
	 S42SlpPaDbYNw==
Date: Tue, 12 Aug 2025 06:47:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
	Rex Lu <rex.lu@mediatek.com>
Subject: Re: [PATCH net-next v2] net: mediatek: wed: Introduce MT7992 WED
 support to MT7988 SoC
Message-ID: <aJrHfUo5QFs-MmM7@lore-rh-laptop>
References: <20250811-mt7992-wed-support-v2-1-e43024c05305@kernel.org>
 <aJoK7e4aEKR96V4h@lore-rh-laptop>
 <20250811084414.6089720d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N1vBIlflFVXeQRN6"
Content-Disposition: inline
In-Reply-To: <20250811084414.6089720d@kernel.org>


--N1vBIlflFVXeQRN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 11 Aug 2025 17:23:25 +0200 Lorenzo Bianconi wrote:
> > > Introduce the second WDMA RX ring in WED driver for MT7988 SoC since =
the
> > > Mediatek MT7992 WiFi chipset supports two separated WDMA rings.
> > > Add missing MT7988 configurations to properly support WED for MT7992 =
in
> > > MT76 driver. =20
> >=20
> > I sent this email twice wrongly. Please ignore this one.
>=20
> patchwork decided to ignore the other one.
> Are they identical?

Yes, they are identical. I will repost v3.

Regards,
Lorenzo

--N1vBIlflFVXeQRN6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaJrHegAKCRA6cBh0uS2t
rAn9AP0bWrDJy2M1CQQq6ydQl8W40coUDAJ2wAj0bRJ3LjVQZQD/Skw/G0OSM9++
iqiVRAF7bNmVxGzHSAF1T0D3HNVL1gk=
=PIXt
-----END PGP SIGNATURE-----

--N1vBIlflFVXeQRN6--

