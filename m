Return-Path: <linux-wireless+bounces-20801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C20A70301
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 14:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9FB3B421A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C672571A8;
	Tue, 25 Mar 2025 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WegDjGZ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5A255E34
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910298; cv=none; b=db2OrgDfxg8Imaj7rVXSG11pgHF5i8JSyG7VnnV7vXYle/A+xIMZxQN9XSCeeFnNWnMF6W+HXiNk5EYzQYKCOwDmiE2pvqmYdK5MUNxtUDLghdpEom+gsNr7TaicggYZ02XlbdX46CAyHzwkrbAtajyEv1KV8ePAxB7IvdaLtvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910298; c=relaxed/simple;
	bh=ZIRDBVEUAGIljq0aPjGWp621DHonEetHh7ohc2xczug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tet3F9nBMOUJ9c8bLaeoEjzkfVKx0mKthM5RvmnBJtX9tzhvXSg3HPlBt8HmcuSMcAYREMXGKlLd2tpqCBg51gLG5s1C2xjYAhQs2t0SwCjKIwBir0zWLrH+pk9VOKR9pWUw1O5zqbF2D6xRsXuJRwXbxSECntZQCfjHB14WwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WegDjGZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705E3C4CEED;
	Tue, 25 Mar 2025 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742910297;
	bh=ZIRDBVEUAGIljq0aPjGWp621DHonEetHh7ohc2xczug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WegDjGZ9qzX+poXATaDPIlEn+NVbEPRBHjMy9ZsePHAMDsgFqhLzhNW4SUdF27l5I
	 Cusj7b0Bt2x/ibPyAJzSsOhnFC4GY41QLTl+LnE69V9FRNOzG0egDBLXvmI6vj7NrX
	 oOZwkzrG4D7oa49v/fSw0uMoF5/BZhs7hAQeKjwnqud92rGeUJj46pUCigfjEmH4YQ
	 R8a+Da/YIauYgkyOT62IEfvSxUwFO17MJciNFh8sd2skFlA7qGNh68tBw+cKiQ3PSY
	 dVpYZqyVxlnncyv1YMyvefMC+Vt9CgnKaum5DjVzi4E6y5t2ZRK0YgtJWdwOzeH1bt
	 sGPCwScJjlMwg==
Date: Tue, 25 Mar 2025 14:44:51 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [bug report] wifi: mt76: Check link_conf pointer in
 mt76_connac_mcu_sta_basic_tlv()
Message-ID: <Z-KzU800Z54V0AHS@lore-rh-laptop>
References: <868e456f-10db-4b0c-bb29-76e3c0d03cc8@stanley.mountain>
 <Z92T5j1zmlvG2ssG@lore-desk>
 <960af30b800baf02d51333a5bf52de93d2966e2a.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cFx5hHH7a4dMTqZJ"
Content-Disposition: inline
In-Reply-To: <960af30b800baf02d51333a5bf52de93d2966e2a.camel@mediatek.com>


--cFx5hHH7a4dMTqZJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 24, Shayne Chen wrote:
> On Fri, 2025-03-21 at 17:29 +0100, Lorenzo Bianconi wrote:
> > > Hello Shayne Chen,
> > >=20
> > > This is a semi-automatic email about new static checker warnings.
> > >=20
> > > Commit 9890624c1b39 ("wifi: mt76: Check link_conf pointer in
> > > mt76_connac_mcu_sta_basic_tlv()") from Mar 11, 2025, leads to the
> > > following Smatch complaint:
> > >=20
> > > =A0=A0=A0 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:394
> > > mt76_connac_mcu_sta_basic_tlv()
> > > =A0=A0=A0 warn: variable dereferenced before check 'link_conf' (see l=
ine
> > > 376)
> > >=20
> > > drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > > =A0=A0 375	{
> > > =A0=A0 376		struct ieee80211_vif *vif =3D link_conf->vif;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^^^^^^^^^^^^^^
> >=20
> > Reviewing the codebase, it seems to me it is safe to revert
> > 9890624c1b39 since
> > link_conf is always not NULL running mt76_connac_mcu_sta_basic_tlv().
> > @Shayne Chen: agree?
> >=20
> link_conf won't be NULL in this function at the moment, but it could be
> NULL after adding "MLO reconfiguration" support. So in our internal
> tree, we directly pass struct ieee80211_vif to this function.

ack, but at the moment in mt76_connac_mcu_sta_basic_tlv() assumes link_conf=
 is
not NULL since we dereference it to get vif pointer.

>=20
> Both methods are fine to me, what do you think?

I would prefer the revert for the moment and modify the signature when it is
necessary.

Regards,
Lorenzo

>=20
> Regards,
> Shayne
>=20
> > Regards,
> > Lorenzo
> >=20
> > > Dereferenced.
> > >=20
> > > =A0=A0 377		struct sta_rec_basic *basic;
> > > =A0=A0 378		struct tlv *tlv;
> > > =A0=A0 379		int conn_type;
> > > =A0=A0 380=09
> > > =A0=A0 381		tlv =3D mt76_connac_mcu_add_tlv(skb, STA_REC_BASIC,
> > > sizeof(*basic));
> > > =A0=A0 382=09
> > > =A0=A0 383		basic =3D (struct sta_rec_basic *)tlv;
> > > =A0=A0 384		basic->extra_info =3D cpu_to_le16(EXTRA_INFO_VER);
> > > =A0=A0 385=09
> > > =A0=A0 386		if (newly && conn_state !=3D CONN_STATE_DISCONNECT)
> > > =A0=A0 387			basic->extra_info |=3D
> > > cpu_to_le16(EXTRA_INFO_NEW);
> > > =A0=A0 388		basic->conn_state =3D conn_state;
> > > =A0=A0 389=09
> > > =A0=A0 390		if (!link_sta) {
> > > =A0=A0 391			basic->conn_type =3D
> > > cpu_to_le32(CONNECTION_INFRA_BC);
> > > =A0=A0 392=09
> > > =A0=A0 393			if (vif->type =3D=3D NL80211_IFTYPE_STATION &&
> > > =A0=A0 394			=A0=A0=A0 link_conf &&
> > > !is_zero_ether_addr(link_conf->bssid)) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 ^^^^^^^^^
> > > The patch adds a NULL dereference but it's too late.
> > >=20
> > > =A0=A0 395				memcpy(basic->peer_addr,
> > > link_conf->bssid, ETH_ALEN);
> > > =A0=A0 396				basic->aid =3D cpu_to_le16(vif-
> > > >cfg.aid);
> > >=20
> > > regards,
> > > dan carpenter
> > >=20
>=20

--cFx5hHH7a4dMTqZJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ+KzUAAKCRA6cBh0uS2t
rF2wAP40z1Ue/HXLiGDlI1mFYq4wDsaZpo9bk8gxKvEB+mNqcAD/SFH3klxi6wWf
6yyieSY52LJZ697WCVTb2RCtp7r9eAI=
=p0NB
-----END PGP SIGNATURE-----

--cFx5hHH7a4dMTqZJ--

