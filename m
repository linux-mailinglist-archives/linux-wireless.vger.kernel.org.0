Return-Path: <linux-wireless+bounces-20678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA3A6BFE5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D5517B309
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F88B1E3DD0;
	Fri, 21 Mar 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMN4SOVR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21C1B4F0F
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574569; cv=none; b=nhDnaJh4REFSLViaash8l8gp9VHAOouu3nODUB9AqhjGlu7LY9dEkCRQbFAQdBTgSCR0WeAZVqCo90gsmQMTvg4Ov+u22Cg7L7bcoM/0KUzOmLFZC8dAjI28HW34vafCNJlpNXmVH3QUTCyMPn7RmrsToz14Sz8cf3g8Lkk4gAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574569; c=relaxed/simple;
	bh=lmEYXsRWnmbpUxKrOWgi5Or9TPBOQ6U6vJbfix6E+zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWLci2Npd6w6onRF7+LE2ncPvUAIoF8UNrHtFvgocuvPzFGnxLGTCQAOyWnIh6wI60A8lpMWaKv4M/GZr3Vmv4Ammcy6ZTVGfwqBo7pGxuERZkQYvFYev7c1yu/feArVhBswq1Y6B8uGRvP0A8Q8boCLJ3BJ+rg6zL4PN7zq0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMN4SOVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CB4C4CEE3;
	Fri, 21 Mar 2025 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742574568;
	bh=lmEYXsRWnmbpUxKrOWgi5Or9TPBOQ6U6vJbfix6E+zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMN4SOVRtPkZTBpUD3jH+4zGB0ku7JHrFIT+vAQiL/Z4cOxXSTo9fj7afgLG+/9Jc
	 t7YZOYDkazbo6HeFzPx+9nPSuZgFAnZ9XNSa8Ii79r8wuQWtwQ6+D3hUkzPEVlkYSE
	 YVfJfnf5q95tqmpV6kQYJMQ05C8dMntDTyumnFexymmWVizlNU0tK0bdIJ6xp0668x
	 CXSZjgEN62WSJ6JghxbCfNWPuDvgAWzIc+fLj8QGVZWzOz3hsJlVvf/SOk3KoIeGC2
	 byU4XOms9w8mva5SKn7TMOXVYdr9+/YPlyftLyXU33VPqrqPUEDLkRT+uXhfGVucHc
	 Mway6Qx+BCg8Q==
Date: Fri, 21 Mar 2025 17:29:26 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shayne Chen <shayne.chen@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [bug report] wifi: mt76: Check link_conf pointer in
 mt76_connac_mcu_sta_basic_tlv()
Message-ID: <Z92T5j1zmlvG2ssG@lore-desk>
References: <868e456f-10db-4b0c-bb29-76e3c0d03cc8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hpR/nQwqSRiKRp01"
Content-Disposition: inline
In-Reply-To: <868e456f-10db-4b0c-bb29-76e3c0d03cc8@stanley.mountain>


--hpR/nQwqSRiKRp01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Shayne Chen,
>=20
> This is a semi-automatic email about new static checker warnings.
>=20
> Commit 9890624c1b39 ("wifi: mt76: Check link_conf pointer in
> mt76_connac_mcu_sta_basic_tlv()") from Mar 11, 2025, leads to the
> following Smatch complaint:
>=20
>     drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:394 mt76_connac_=
mcu_sta_basic_tlv()
>     warn: variable dereferenced before check 'link_conf' (see line 376)
>=20
> drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>    375	{
>    376		struct ieee80211_vif *vif =3D link_conf->vif;
>                                             ^^^^^^^^^^^^^^

Reviewing the codebase, it seems to me it is safe to revert 9890624c1b39 si=
nce
link_conf is always not NULL running mt76_connac_mcu_sta_basic_tlv().
@Shayne Chen: agree?

Regards,
Lorenzo

> Dereferenced.
>=20
>    377		struct sta_rec_basic *basic;
>    378		struct tlv *tlv;
>    379		int conn_type;
>    380=09
>    381		tlv =3D mt76_connac_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic=
));
>    382=09
>    383		basic =3D (struct sta_rec_basic *)tlv;
>    384		basic->extra_info =3D cpu_to_le16(EXTRA_INFO_VER);
>    385=09
>    386		if (newly && conn_state !=3D CONN_STATE_DISCONNECT)
>    387			basic->extra_info |=3D cpu_to_le16(EXTRA_INFO_NEW);
>    388		basic->conn_state =3D conn_state;
>    389=09
>    390		if (!link_sta) {
>    391			basic->conn_type =3D cpu_to_le32(CONNECTION_INFRA_BC);
>    392=09
>    393			if (vif->type =3D=3D NL80211_IFTYPE_STATION &&
>    394			    link_conf && !is_zero_ether_addr(link_conf->bssid)) {
>                             ^^^^^^^^^
> The patch adds a NULL dereference but it's too late.
>=20
>    395				memcpy(basic->peer_addr, link_conf->bssid, ETH_ALEN);
>    396				basic->aid =3D cpu_to_le16(vif->cfg.aid);
>=20
> regards,
> dan carpenter
>=20

--hpR/nQwqSRiKRp01
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ92T5gAKCRA6cBh0uS2t
rLNgAP9tC4J+M4wDG8h4ZEDM1k/jkGmC7PNmQVy7a226Rx2iygD/fxXhKmQHoksW
nmYHScqg5z/lqKE600x6/UU/2F+y9gI=
=dwUL
-----END PGP SIGNATURE-----

--hpR/nQwqSRiKRp01--

