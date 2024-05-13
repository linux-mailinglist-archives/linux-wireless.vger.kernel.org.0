Return-Path: <linux-wireless+bounces-7602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47898C44E1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 18:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31331B210A1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDA1553A6;
	Mon, 13 May 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4T9yt8z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480CA15534D
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616792; cv=none; b=Rp7Rz8ajLwlZAR5rqag1rLqc3UFKMGMfvBihl/WIEmqU+fEr2ALZ8NOZczN1jXMy8iUjBBb/ubJwCUo7gCDffASh83Wj2+JCWcT/dBTh86n1caGOvnwRDrgEeoNKYALl/rco55Diu8X8xu1tRJl11fLIyfKbJcp5wNSPbCwHgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616792; c=relaxed/simple;
	bh=9X9buD5qIepHwJgVEc7Tyvi2IGtdfBBEoBZf+F32eEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nds6tO9VH475t6mogYA/fCmafrB3ykFhmgULnQaJ3kdJnKY2NJ7XBXfv0i2wROzV9IqeWqdlDrxRJrQ+Zrv2f1pMJX4xtN/MSC96AHUIrsGZ+pSZK9rdsO+fTFm71cjnoj+vSnUtlSeNckb02V7dGnHVm4MAc16r0rtfjTCJV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4T9yt8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBA6C2BD11;
	Mon, 13 May 2024 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616792;
	bh=9X9buD5qIepHwJgVEc7Tyvi2IGtdfBBEoBZf+F32eEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4T9yt8zd7VwONxhyB9dqukJEUzFjzdKvhaeSeqHS1SazgSP6+4gca6CZSNOZZwLF
	 6AV3Gsf1pSE/BUQhM/uxyqztiDVqDanKO/8K3WjtMObBq44p9+svVN76dEdrVwHafy
	 KcSKVZTjUzaiEc9LjNyhijFGEQtsJa9nBC/Pt5Wgv5Ze4CzfWKKmbIRFlLIw40nqMh
	 OY4SL+jq1vruxkYZGruP4RxAWSC/nmL7iwW0E/U+0tETVov3iZL5eKtNK2T7FVo9NP
	 GOIxTsh4cXLnAbfC9aD3dO9ClndE+kV8tdSK8me3ZBBoUFaOCDlfd+fyql1qm3cwX3
	 A6eovMVw1wJiw==
Date: Mon, 13 May 2024 18:13:08 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sicong <congei42@163.com>
Cc: nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
	sean.wang@mediatek.com, kvalo@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1] wifi: mt76: mt7615: fix null pointer dereference bug
Message-ID: <ZkI8FPNxOQAUFeyU@lore-desk>
References: <6206228d.bdee.18f72609cf4.Coremail.congei42@163.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rp72CSPL56MRPJkI"
Content-Disposition: inline
In-Reply-To: <6206228d.bdee.18f72609cf4.Coremail.congei42@163.com>


--Rp72CSPL56MRPJkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Function mt7615_coredump_work will call vzalloc to allocate a large amount
> of memory space, the size of which is 1300KB. There should be a null
> pointer check after vzalloc. Otherwise, when the memory allocation fails
> and returns NULL, the function will cause kernel crash.
>=20
> Fixes: de791098459d ("wifi: mt76: mt7615: fix null pointer dereference bu=
g")
> Signed-off-by: Sicong Huang <congei42@163.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.c
> index 7ba789834e8d..04eb52904520 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -2341,6 +2341,9 @@ void mt7615_coredump_work(struct work_struct *work)
>  	}
> =20
>  	dump =3D vzalloc(MT76_CONNAC_COREDUMP_SZ);
> +	if(!dump)
> +		return;
> +
>  	data =3D dump;
> =20
>  	while (true) {
> --=20
> 2.34.1

I guess the kernel will not crash here since we check the dump pointer in t=
he
while loop, we will just flush the msg_list queue.

Regards,
Lorenzo

--Rp72CSPL56MRPJkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZkI8FAAKCRA6cBh0uS2t
rH1PAQC/NKiI0N81cddugxpBRaXspuRUoF19NUeJfif9gvHdsgD/VuFcYRSNEGoW
GUwuGu32v2UJhfMKmHJtcJPVj6QV9g0=
=8TYy
-----END PGP SIGNATURE-----

--Rp72CSPL56MRPJkI--

