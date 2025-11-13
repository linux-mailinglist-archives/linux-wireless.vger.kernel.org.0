Return-Path: <linux-wireless+bounces-28898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B97FFC5607A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 08:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 977154E519F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0C2C0293;
	Thu, 13 Nov 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUM+ik+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7B219E8;
	Thu, 13 Nov 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018232; cv=none; b=SBymg/AJadaAax82Mbk+T9oht3kGVJ8XLDPuN7SeypYaLIXKatFHFqvM1eUeTf98d3/Di+qX9yg65c6cjGnkt4T9YOwsRFEFOnOfF8N/crxopUG/jnkAVJPwMJ0DuA7nJswTrzE6DZMAxrpAn2g30yNOGzfDdaezL1wtnd8t+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018232; c=relaxed/simple;
	bh=AVBlLnGckxjKwnnOnUXaDm2zDGvoig0seanX4A70Bw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1JbPDCcyFAHFkWFRQkMhna298v3paA0y818kPXkebR3NTUlX6MapfukWGjNCyiFFGsEDsnuQTncTuJ4AYjz32EDmP1jZuGyJvP9KMNAqL8J7NLzEQYkhMx8nbuj+BvBgJVFejAtZ88yQsMCe4ee/86PbKgXgCu/xgN2f7I2cQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUM+ik+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55ACC4CEF5;
	Thu, 13 Nov 2025 07:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763018232;
	bh=AVBlLnGckxjKwnnOnUXaDm2zDGvoig0seanX4A70Bw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUM+ik+p6IFzpN7zZLzxa9AwLB2kyODzK7ekmsbMAzKaxleQyyuFSMVBZxXQwZCZI
	 0bj1d6pAcTkjALLuJycRZ5zkxzTOvAheE0Zdw134wk7tK5zPXv4xyDuz7GuXOTxQxP
	 qh3HvKC3YA6tn5LQEBBHadkmBBHJWKIkl/AhstES9j3lZgUvOCFjjvbC3Kxuajbr+J
	 ctw46CNizo0oqX/WPj+KZYouyD/R2SKrVl0Gzs5nTZkOtynOVORmaIUcddX97cEDwP
	 rxm6+DIXuZCKMfd7NmxjvrNnEyT1Tt6ROX8VReskblxiBMy0KpOhzBmTxaM0T5ItjQ
	 o96jkxwVdSqPA==
Date: Thu, 13 Nov 2025 08:17:09 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
	sean.wang@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net] mt76: mt7615: Fix memory leak in
 mt7615_mcu_wtbl_sta_add()
Message-ID: <aRWF9QJuwGaDlUvT@lore-desk>
References: <20251113062415.103611-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aZWRFATKm1FfpMf2"
Content-Disposition: inline
In-Reply-To: <20251113062415.103611-1-zilin@seu.edu.cn>


--aZWRFATKm1FfpMf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In mt7615_mcu_wtbl_sta_add(), an skb sskb is allocated. If the
> subsequent call to mt76_connac_mcu_alloc_wtbl_req() fails, the function
> returns an error without freeing sskb, leading to a memory leak.
>=20
> Fix this by calling dev_kfree_skb() on sskb in the error handling path
> to ensure it is properly released.
>=20
> Fixes: 99c457d902cf9 ("mt76: mt7615: move mt7615_mcu_set_bmc to mt7615_mc=
u_ops")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index 4064e193d4de..08ee2e861c4e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -874,8 +874,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, stru=
ct ieee80211_vif *vif,
>  	wtbl_hdr =3D mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
>  						  WTBL_RESET_AND_SET, NULL,
>  						  &wskb);
> -	if (IS_ERR(wtbl_hdr))
> +	if (IS_ERR(wtbl_hdr)) {
> +		dev_kfree_skb(sskb);

Hi Zilin,

I can't see how this is useful since if mt76_connac_mcu_alloc_wtbl_req retu=
rns
an error, wskb will not be allocated.

Regards,
Lorenzo

>  		return PTR_ERR(wtbl_hdr);
> +	}
> =20
>  	if (enable) {
>  		mt76_connac_mcu_wtbl_generic_tlv(&dev->mt76, wskb, vif, sta,
> --=20
> 2.34.1
>=20

--aZWRFATKm1FfpMf2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaRWF9QAKCRA6cBh0uS2t
rCxgAQCW+qnvlH5fPUCxWkj4AlWKqGylBMeUcC1chjZl+uY/UwEAhUhsrUJk7tn7
QaT4KvLwkDqdr6peuN/QcQvG50qs6wM=
=uKrq
-----END PGP SIGNATURE-----

--aZWRFATKm1FfpMf2--

