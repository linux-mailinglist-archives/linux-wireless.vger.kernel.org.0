Return-Path: <linux-wireless+bounces-28574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E85C350E7
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C58C74E46BB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6CE2FE07E;
	Wed,  5 Nov 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFufbgau"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64A2FE580
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337707; cv=none; b=et1RlwQOMBhsdb6O4/6zWt18YJ3F+ZexcewlsqVM0ge4hmno3zit8JsVBcMkTze06ypiI79rSkHdZhQj6qotjqb3zuTZ4ITYEOkeRu8vEm3p9yqaswBFye2Qim7FVMzokUB2anGFskvo5/TWPGQWV57fnCe9KI7tkyMPvBynxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337707; c=relaxed/simple;
	bh=eJLJW2lFSOIlMRJyBNTFsuHhvlrpBvyGpayql7faRpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgx3VPxWt6m+utuHeXjSEm60iqXC7Zwdn2cezsmJIdYVeB4pnO6n9BIRolDIxRSMLD2mQZsLXa0LKYJ3XWLz59HhLG6pgTIiB8P4Ey8x4AmK9JxwrZE+71FIszX8gnWDBTtfKs9sy7ninU6oTTafBSxJq7WCf0zTz/Yk0uW1xYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFufbgau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C097C4CEFB;
	Wed,  5 Nov 2025 10:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337706;
	bh=eJLJW2lFSOIlMRJyBNTFsuHhvlrpBvyGpayql7faRpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFufbgauSv2Xg7+Y36A2bMYwjpAJ2rmpLk19C/M/GDCXeh0pv6vIiNHlm2h9fs4dz
	 YV0dkWHzsw6T89TX6hsdbuDtXOwblQTHZaeNB6gTrxK37TPe2l9zrKIWdD+JYhKZFY
	 4zQdmNfj6bbyW3ZT4r8bRxV6aupKbEMdEe7wWqrh7kcZZcn0Rqiso92GaL8JEkL+hh
	 hAzIbftt84gMpZTX008meXyz3h24Tfz7ZXpmh+tGo0JbpwTEbdsjWNK93seEO1uyjO
	 lNsTJCJUnoKtfiSjHrmcs0AEIrUZlZt9b+MCqQETH9LlTofm1nGRVXhKaSJODlQz25
	 CFpjA20KOgdlw==
Date: Wed, 5 Nov 2025 11:15:04 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH mt76 07/12] wifi: mt76: mt7996: set link_valid field when
 initializing wcid
Message-ID: <aQsjqEkRRkNvYuua@lore-desk>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
 <20251105093100.541408-7-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b841FnmXDNlkKh5U"
Content-Disposition: inline
In-Reply-To: <20251105093100.541408-7-shayne.chen@mediatek.com>


--b841FnmXDNlkKh5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This ensures the upper layer uses the correct link ID during packet
> processing.
>=20
> Fixes: dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_=
add/sta_remove callbacks")
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index 685be98b9f27..c26f8f49ce44 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -343,6 +343,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct=
 ieee80211_vif *vif,
>  	INIT_LIST_HEAD(&msta_link->rc_list);
>  	msta_link->wcid.idx =3D idx;
>  	msta_link->wcid.link_id =3D link_conf->link_id;
> +	msta_link->wcid.link_valid =3D ieee80211_vif_is_mld(vif);
>  	msta_link->wcid.tx_info |=3D MT_WCID_TX_INFO_SET;
>  	mt76_wcid_init(&msta_link->wcid, band_idx);
> =20
> @@ -984,6 +985,7 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
>  	msta_link->wcid.sta =3D 1;
>  	msta_link->wcid.idx =3D idx;
>  	msta_link->wcid.link_id =3D link_id;
> +	msta_link->wcid.link_valid =3D !!sta->valid_links;
>  	msta_link->wcid.def_wcid =3D &msta->deflink.wcid;
> =20
>  	ewma_avg_signal_init(&msta_link->avg_ack_signal);
> --=20
> 2.51.0
>=20

--b841FnmXDNlkKh5U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQsjpwAKCRA6cBh0uS2t
rJ6nAP9q8oJl5eRH8fIUDlJxCf30l0iHrklHGnsCCk4RCMwALwEA31eWJ7DDCqFu
BWeWDZPxzQD+9MhogPfBUaxNt/dK0gM=
=yQM9
-----END PGP SIGNATURE-----

--b841FnmXDNlkKh5U--

