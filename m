Return-Path: <linux-wireless+bounces-28577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085ACC35319
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326C61924A8D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DFE30BF7F;
	Wed,  5 Nov 2025 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQLu417k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CB2FF14C
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339537; cv=none; b=PcJDn56cS7YqXdLaFV7V7q80a5veDzl5Q26tq959GsINntZVb67kuqptaPwOEaJC9+lHOD/EQaXhOCqjNhhp1XZNz+5cgWmsiPf63ZhA5pJlU3M8fN7QjjCuo0K2397ebbHO2VgJCbZW0yKBQbdK9I4fnR5T/BGC5esMSkO5SKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339537; c=relaxed/simple;
	bh=XUxQkFzm2ntfKhAKsIXF1wgtxzoKKB7QpKNwXNOR/Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BySQAsIInfA4vUju2BiH9OXHMy6irwnaGeHvR+VfSkCLSeCpO6igMd0rSjkYNACiEjbBxdzQMHtBW82B6AEMfg/i8dkRPLOkbxVhvRLRNxzHqEdS5y1MDjjuzeh2UbiZ6plokFodi/0fXt0wq2De1MVmGhKANmkGLF/kwQUp464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQLu417k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E790BC4CEF8;
	Wed,  5 Nov 2025 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762339537;
	bh=XUxQkFzm2ntfKhAKsIXF1wgtxzoKKB7QpKNwXNOR/Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQLu417kS68EBBg8JZ5dJhq9aQkfkD9JzLbFaV6K7wUGx5AKSCxGoYbegiiu24KbO
	 0sRJARx0voSfhR/zPY27my7V3BLgpYzJ0fvKLc3kM4RllM0ZC5XObtmJIXJE/Fa8nz
	 9wfoLbDoResYAUmgzVR4IWG7N9mia64L0t2SMXIY5OoMNVvQm1iVl5tL6TbIlKs6pP
	 nIhrygISomL/SNnIAgbjFgfAlzLGEDGBtg0et7U65nAeyILjDxh6BjREmSv6pOuCmA
	 dpbCn4oXnM/o+H0kmTPaOmUa53IXhEn+5KrYKZqwh12reulAm8WCGJScvC7j8a6nbE
	 iVso2FuQZ1CXg==
Date: Wed, 5 Nov 2025 11:45:35 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH mt76 11/12] wifi: mt76: mt7996: fix using wrong phy to
 start in mt7996_mac_restart()
Message-ID: <aQsqz00YLrpa3O7d@lore-desk>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
 <20251105093100.541408-11-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s5qeNP2oqWG8e4B/"
Content-Disposition: inline
In-Reply-To: <20251105093100.541408-11-shayne.chen@mediatek.com>


--s5qeNP2oqWG8e4B/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Pass the correct mt7996_phy to mt7996_run().
>=20
> Fixes: 0a5df0ec47f7 ("wifi: mt76: mt7996: remove redundant per-phy mac802=
11 calls during restart")
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index c1f2938d1f21..2c869f710193 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -2368,7 +2368,7 @@ mt7996_mac_restart(struct mt7996_dev *dev)
>  		if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
>  			continue;
> =20
> -		ret =3D mt7996_run(&dev->phy);
> +		ret =3D mt7996_run(phy);
>  		if (ret)
>  			goto out;
>  	}
> --=20
> 2.51.0
>=20

--s5qeNP2oqWG8e4B/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQsqzwAKCRA6cBh0uS2t
rByDAP4uofMqJn2ESt9OTfVLD0eRuRjXZgQDi7W3g9D/LQUNywEAqar7wDUleGkP
uQjEdRU4xKhvJv9UUhJvzKJ0TEjHRAM=
=noBq
-----END PGP SIGNATURE-----

--s5qeNP2oqWG8e4B/--

