Return-Path: <linux-wireless+bounces-20496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2BA6759D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F6717027D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4406520D516;
	Tue, 18 Mar 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwm1AgIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65120D50F
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305989; cv=none; b=fsrbWdR8IS0dAx/hCFNA8B5dwI2bA+Kg1iO8w8zYIOqhL0nubWSAFWGV56SbgqTSAcDQVISNdyZbAbKqHqXx45v5C3pZZwls0TkZ8TCyaw2TeGQfmZt+0EaXNMTs0p5QSGaRgTfH7XdzRfy61YQbPNyAPEEiqh+1jB2P+5t7B4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305989; c=relaxed/simple;
	bh=JPDR0w/YOEw1Llnb5VuhVxqbXWyVgpVHr44qHu0QbSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpYNvWVgiIEgf0E0UoqXfoy6Secxmtomls5sSWa1dT24jPdr18GyLOKAFUG39Q6v4euWDJEXGFC3GtNytbLuiIGfDewW+7xkA4w6V8liIWoYHlwGMepgK5AjEf0esREcTdszswhCHCjgbNKrv9D9l/eh5+Wqrc7MTFXNuV7TU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwm1AgIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13131C4CEF1;
	Tue, 18 Mar 2025 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742305988;
	bh=JPDR0w/YOEw1Llnb5VuhVxqbXWyVgpVHr44qHu0QbSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwm1AgIt9fYXFQOGLZbDqLKc0zA7MQmSCDZfYZSv66mjMeVIOUmgQvR7ELKU9mjkT
	 PJNlhF6ICeEMz5rbCgzcfqtSW0MrlfTcFj2Z/hfLajg4NobWokz7XnNQekteaOaphS
	 n8WyWgoOnIvv4ikITjfp79lQcj5mLy4wYeDgSuRvG2o+guBNTg6DzAfsWdmSqoTOfY
	 motBfd9/kTwCRklxwgdJAy3XfZBBUtspRGo2qKW/VOiPoSltM/bCtO8HOF/q5jxSg3
	 dV6WbTurGrFtnDbuRaMKd6Pi4nUNHwGrYmSrqx7klo5UZjBTdFcdzOIvgK8bY8kKZ5
	 o7Hn5i+QayETg==
Date: Tue, 18 Mar 2025 14:53:06 +0100
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>
Cc: Sean Wang <Sean.Wang@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Bo Jiao =?utf-8?B?KOeEpuazoik=?= <Bo.Jiao@mediatek.com>,
	Chui-hao Chiu =?utf-8?B?KOmCseWegua1qSk=?= <Chui-hao.Chiu@mediatek.com>
Subject: Re: [PATCH 02/21] wifi: mt76: mt7996: Add
 mt7996_mcu_sta_mld_setup_tlv() and mt7996_mcu_sta_eht_mld_tlv()
Message-ID: <Z9l6woY4TYKe2olT@lore-desk>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
 <20250312-b4-mt7996-mlo-p2-v1-2-015b3d6fd928@kernel.org>
 <9efb42f0948b23cc127dc5c5d9e31791f80219ef.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S+U/CWieHPnttq0l"
Content-Disposition: inline
In-Reply-To: <9efb42f0948b23cc127dc5c5d9e31791f80219ef.camel@mediatek.com>


--S+U/CWieHPnttq0l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > link_sta);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (sta->mlo && conn_state =
!=3D CONN_STATE_DISCONNECT)
>=20
> The latter check seems already to be handled by:
> if (conn_state =3D=3D CONN_STATE_DISCONNECT)
>     goto out;

ack, I will fix it.

Regards,
Lorenzo

>=20
> > {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mt7=
996_mcu_sta_mld_setup_tlv(dev, skb, sta);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mt7=
996_mcu_sta_eht_mld_tlv(dev, skb, sta);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > =A0=A0=A0=A0=A0=A0=A0 }
> >=20
> > =A0=A0=A0=A0=A0=A0=A0 ret =3D mt7996_mcu_add_group(dev, link_conf->vif,=
 sta);
> >=20
>=20

--S+U/CWieHPnttq0l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ9l6wgAKCRA6cBh0uS2t
rPt9AQDihoHV63IGKsFzYLkd0lQwgYU6Bnkt/voMu9V/EK0mAAEArLSYGDDloAlr
f1S4dgIRZVeLcDjQ4bfrWoXfBjaBvQI=
=+rQ0
-----END PGP SIGNATURE-----

--S+U/CWieHPnttq0l--

