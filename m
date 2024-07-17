Return-Path: <linux-wireless+bounces-10312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F6934244
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 20:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64B01F22821
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38F7183083;
	Wed, 17 Jul 2024 18:29:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B061822D7;
	Wed, 17 Jul 2024 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240943; cv=none; b=dgVpPWAreeY7SBKoksoCa7Dy4t5c2PNEJCGRDxXdSxc8fOkc4QyoQgIWillyLG+KGpWqW8sxxCx9uLHNTW7fdSpejMuq39y4BwZgcWm4csEhfleBLWmuP34abKY6FYMsWG4GEeCKORfOFJmE34KFZW35CrqQfQnDoPoZRpr2m/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240943; c=relaxed/simple;
	bh=f82nsMSv9TQtJVIdFkG6Ne5dWtX+2ztlfDLZSmEpaCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/zB5d4Uk6Qb4g/FxfdzK7oaLGaZNnr2PKyfjdg6I8SLoYy5OU1/K+dArh6jaie9AJy67YO8opZ4DHZJbYS0oHTXL6fxzD2D2LfxUZn3ALnpHOVAIo7wBfUFkH2bj5aAT9l3cCgYvNuYRo4NJvyxlZT28Qa3igPUtlF4gZXHUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1sU8um-0007OE-25;
	Wed, 17 Jul 2024 19:58:06 +0200
Date: Wed, 17 Jul 2024 19:57:43 +0200
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org
Subject: Re: [PATCH] wifi: b43: Constify struct lpphy_tx_gain_table_entry
Message-ID: <20240717195743.31bdb01d@barney>
In-Reply-To: <38528f48c8069187823b774a6b2a53088f6c9599.1721161231.git.christophe.jaillet@wanadoo.fr>
References: <38528f48c8069187823b774a6b2a53088f6c9599.1721161231.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_1L7b6zKYTmbBsNJwFixW/C";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/_1L7b6zKYTmbBsNJwFixW/C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jul 2024 22:21:13 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

>  static void lpphy_rev0_1_write_gain_table(struct b43_wldev *dev, int off=
set,
> -				struct lpphy_tx_gain_table_entry data)
> +				const struct lpphy_tx_gain_table_entry data)
>  {
>  	u32 tmp;
> =20
> @@ -2356,7 +2356,7 @@ static void lpphy_rev0_1_write_gain_table(struct b4=
3_wldev *dev, int offset,
>  }
> =20
>  static void lpphy_rev2plus_write_gain_table(struct b43_wldev *dev, int o=
ffset,
> -				struct lpphy_tx_gain_table_entry data)
> +				const struct lpphy_tx_gain_table_entry data)
>  {
>  	u32 tmp;
> =20
> @@ -2383,7 +2383,7 @@ static void lpphy_rev2plus_write_gain_table(struct =
b43_wldev *dev, int offset,
>  }
> =20
>  void lpphy_write_gain_table(struct b43_wldev *dev, int offset,
> -			    struct lpphy_tx_gain_table_entry data)
> +			    const struct lpphy_tx_gain_table_entry data)
>  {
>  	if (dev->phy.rev >=3D 2)
>  		lpphy_rev2plus_write_gain_table(dev, offset, data);
> @@ -2392,7 +2392,7 @@ void lpphy_write_gain_table(struct b43_wldev *dev, =
int offset,
>  }

These three changes look like they are not necessary.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/_1L7b6zKYTmbBsNJwFixW/C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmaYBhcACgkQ9TK+HZCN
iw5bBxAArMV5z7DK4ihRk2DaDq4XdBhLERO3rXRBSQthMrWcbAq7Iqzyd/dPLKzF
NkDVf5Ids2daRDsmZIczjXb8L6IrGnkfrEvZ8x/No4OchgV9osiellRq1yVOOZCx
z7wvlylhgupjCkJ2tT4dZS4uKWlqRj6kh7eo+p48xgH4sxfHXpAWSTd9PtJIbJe0
I2a8QGgwLXzxKePsnpdt+OeH/UoFblhKtPvBYoBqzc4wl3FCQ4stZS+o0gumRakw
bZNP06PapMtVW/+fjby+iD8/21XQIEQoSCmeGizKYkiKhO6eXK9DxO7ETeVEO/y/
1lrvKf0dRh1MzgMq53LP1/XpLc3Cd71et7z8xwYCDI/mZuCfU7bhVEGRVNll2Y3V
Y7XQaz4WqdNeVQc9fctLr09rwB2o5Y3XNi/7pZ8phVTmKEUBgTH/Uaj83hoTDHwd
2c1OGKXhrMXMre4GFjyxREA7PhWovAkJmSxGmeaQk98yOZTuKGkFW8glq2l/6wYs
avXU/aGcAtF/+7/a56Hu3M1SSau7S1NlKiWM88wX/guHfzmY6bQE9YsjVOkkyoao
h/gADABg2SZsXoYXyvxV0KVGaXj5dXiLXhZ9agLBYKMG/yCE4NyvNgbE1VMjT89p
VKFSAFnXj/kzSfgi+2wLt2kZKZVa011PxsFerUVhFNGnUdFrEe8=
=J7sR
-----END PGP SIGNATURE-----

--Sig_/_1L7b6zKYTmbBsNJwFixW/C--

