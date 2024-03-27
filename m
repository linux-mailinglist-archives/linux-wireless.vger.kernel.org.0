Return-Path: <linux-wireless+bounces-5360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563A88E80B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 16:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17792A4139
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AAB4F61C;
	Wed, 27 Mar 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIzgh/K3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2812BEA5
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550287; cv=none; b=pzy9DoXi2lCKL7lNTWXLSAxq6FewVmskWGLYAu2AZQrYAzfqXgTzb+YX6JEhNDVu7kI49ljn9R/yywSF3GA6BME8eEQk799DmO3ZPEJTCu68mEzjGhfO6mIhstqaQoWRJV2AF3CUS9FNZ1XKvSBiPeWCEC3p9uYYfKX+B2E16oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550287; c=relaxed/simple;
	bh=8eBBb3NhnHd0Ef5+13qlGLMidqLoEapTCjvqOcOPZSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7TSPW6+63XiSzeIds0FtKSzegQgluVnytbx++0Om9l6i7CwrfqWqUtiHRq9ChePVS8mIMvawAE3/juAzBYTfJ91ODet3DxOVpjKwoiEKCI6FnzYNOkvWBJU/eXGHSrjJHJy6qXkhKPZztyTBp0PGowWMpdpweB9W+xy8RYzURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIzgh/K3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BDEC433F1;
	Wed, 27 Mar 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711550286;
	bh=8eBBb3NhnHd0Ef5+13qlGLMidqLoEapTCjvqOcOPZSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uIzgh/K3Iy2tAyxyj/8CdKgKq8VNJT8HZteHfa9Giw8aTPJHUGx8oO+q8zAwmCy/N
	 YBbjxqeXaARFn+TZIyqrO+lTpd1Bz8Xxbovl8G08QVmJxchT2Ly9d7iLZ+ei/S9IKe
	 sUGiewy9MCFaHfh1kX42QpWEE7wMBySkqFcTDSZmdSqtwV09XZA1FzUidTu770a9Fg
	 TBtbzjozHtyOyFkPjv/2o9whMN0LaswvTWROa+DTR+XKlcY/fhTDzj2MvhFUtxDHAf
	 /Q/oQjUU3HN/g0EHRttljwz2P/VPOFr0Tl5QzfaYvLI4oBc+mCENVpuPYGZSExmmNA
	 hHZGQ+pbHxkgw==
Date: Wed, 27 Mar 2024 15:38:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: nbd@nbd.name, lorenzo.bianconi@redhat.com,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: mt7915: workaround dubious x | !y warning
Message-ID: <ZgQvSfUZWFv-M4gk@lore-rh-laptop>
References: <20240325155838.1558680-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qJHP70e4fn2gEJ5N"
Content-Disposition: inline
In-Reply-To: <20240325155838.1558680-1-kvalo@kernel.org>


--qJHP70e4fn2gEJ5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Sparse warns:
>=20
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:526:9: warning: dubio=
us: x | !y
>=20
> Workaround it by using the '?' operator. Compile tested only.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> ---
> v2:
>=20
> * use parenthesis
>=20
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index 450f4d221184..578013884e43 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -523,7 +523,8 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
> =20
>  	/* WM CPU info record control */
>  	mt76_clear(dev, MT_CPU_UTIL_CTRL, BIT(0));
> -	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | !dev->fw.debug_wm);
> +	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) |
> +		(dev->fw.debug_wm ? 0 : BIT(0)));
>  	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR, BIT(5));
>  	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_SOFT_ADDR, BIT(5));
> =20
> --=20
> 2.39.2
>=20
>=20

--qJHP70e4fn2gEJ5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZgQvRwAKCRA6cBh0uS2t
rNjXAQCzC/9/TA4UHhHYicEvu3HZYtugq0+KIcj7diJpoI4A2gD/YeKqb6Tbsr18
DiWSa4w2iXFvC90naP31zhYo0Bu5FQA=
=w8wz
-----END PGP SIGNATURE-----

--qJHP70e4fn2gEJ5N--

