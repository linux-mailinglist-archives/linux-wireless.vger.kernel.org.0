Return-Path: <linux-wireless+bounces-28189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B792AC014FF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDAF24FC6BB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CA30102A;
	Thu, 23 Oct 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdpJCNYP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB582DF146;
	Thu, 23 Oct 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225357; cv=none; b=DkVZHxKKrKiA49/uIgnz0m+Vg3VsNZE4TBLtTMSSPlQYnBBRABjC8tv5qw0xiB04n3kCEYVNKdBvV1DEdnPhJ51wIDGnB21EanuK69AdRw7EKa7FJpxt+deFfxnDQkQwBKxgMrz2jn39oYO4Fs/YB4iQvdTyMj+50WMemSC/Ipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225357; c=relaxed/simple;
	bh=bpK6IFKSlWyr361lsyY7cF41HPTMFf1xoUoSL8UMu8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afyK9HscA6QCWuPxbpH2MC8diff2m+XTD15j6gTJMLg20/dZUEd32gLy/lblwfDhb7jUbzBAHgbQTN5jLOe/iVLPC25NFfvXxO8lmrP3MYxqumkgttLfvbCludcGNQd6ztOwhcPAfHv1/gbFAY6km5X9tX9YxPxNRQmVeFgn6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdpJCNYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FFAC4CEE7;
	Thu, 23 Oct 2025 13:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761225356;
	bh=bpK6IFKSlWyr361lsyY7cF41HPTMFf1xoUoSL8UMu8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdpJCNYP49fX4xrvkRrTI6NYAIb2XjSMLFn4GRWD1qwY0y/P1swND08sCsrfKCZy/
	 U/QN5Fg1s3jCbQG4YTMkN4g+dAtvNf3hW+TDkL7ZmWwBtVOE/jU8l2Xudjd8Vw8w7r
	 84K8i4KH5zAKsrLxlTUqVvfG7ATeuYc6eAK4TtOUUdT1eamY0jzyFS0ZPmdxo1w1kT
	 hwuZcdtC6g4LyBtap5kiwW7hymyz4bfNCaeRbKMmuTQdnGcd2QtY+MeHpopHhuso0R
	 gdb0q8P2jdHtO+fS8WvXd1fHOTBBDjDnPZzQEaxtzTaA6kbjqevt5b7iMI5/N8PBee
	 idrwh4k7baoxw==
Date: Thu, 23 Oct 2025 15:15:54 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rex Lu <rex.lu@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, david.hunter.linux@gmail.com,
	khalid@kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] wifi: mt76: mt7996: remove redundant NULL check in
 mt7996_msdu_page_get_from_cache()
Message-ID: <aPoqiioo6kUZ0kbY@lore-desk>
References: <20251023-mt7996_mac_c-v1-1-580a3cbb2678@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n7nsxP8XhLbUIH3S"
Content-Disposition: inline
In-Reply-To: <20251023-mt7996_mac_c-v1-1-580a3cbb2678@gmail.com>


--n7nsxP8XhLbUIH3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Smatch reported a warning that the NULL check on `p` in
> `mt7996_msdu_page_get_from_cache()` is redundant:
>=20
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1651
>   mt7996_msdu_page_get_from_cache() warn: can 'p' even be NULL?
>=20
> The function first checks `list_empty(&dev->wed_rro.page_cache)` before
> calling `list_first_entry()`. When the list is not empty,
> `list_first_entry()` always returns a valid pointer and can never be NULL.
>=20
> Hence, the `if (p)` condition is unnecessary. Removing it cleans up the
> code.

Hi Rakuram,

this issue has been already fixed here:
https://patchwork.kernel.org/project/linux-wireless/patch/20251014-mt7996_m=
sdu_page_get_from_cache-remove-null-ptr-check-v1-1-fbeb7881e192@kernel.org/

Regards,
Lorenzo

>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510100155.MS0IXhzm-lkp@intel.com/
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index 9501def3e0e3e20132fdbcfe0b1f489694afdc5f..284f2eea71e5bf0a34c7fe840=
84d998164a31a05 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1681,8 +1681,7 @@ mt7996_msdu_page_get_from_cache(struct mt7996_dev *=
dev)
>  	if (!list_empty(&dev->wed_rro.page_cache)) {
>  		p =3D list_first_entry(&dev->wed_rro.page_cache,
>  				     struct mt7996_msdu_page, list);
> -		if (p)
> -			list_del(&p->list);
> +		list_del(&p->list);
>  	}
> =20
>  	spin_unlock(&dev->wed_rro.lock);
>=20
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251022-mt7996_mac_c-e10894b8bbb4
>=20
> Best regards,
> --=20
> Rakuram Eswaran <rakuram.e96@gmail.com>
>=20

--n7nsxP8XhLbUIH3S
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPoqigAKCRA6cBh0uS2t
rD8eAPwLI8YuldWd9SqIobkdRoUsWzOX3OJ2ZueswhJHmsaS9AD/S8i//U2NX4+E
xxZI8D6MmUYKGxiHF1XutDoE/AEFhgo=
=fPpm
-----END PGP SIGNATURE-----

--n7nsxP8XhLbUIH3S--

