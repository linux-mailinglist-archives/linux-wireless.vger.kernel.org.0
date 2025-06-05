Return-Path: <linux-wireless+bounces-23774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72211ACF4D5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 18:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF1D3ACF2E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4118E025;
	Thu,  5 Jun 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEW/DkBw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C115FEE6
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142632; cv=none; b=C9fTImFtHuhfD2zdd3GVSh2aeVnPi4zkJVbK0b7IhrL2x39SikbCLDAlgKyR8kmSOhGto0fPDkWTeTkGlY2vVbUX5alIXUKKqMvDh8wQYea768qBH9UmTUgPqkqP6KaKGjtvvyTRxAix/hqqHRwtqulW6NFRfOLy/3dxSFNOyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142632; c=relaxed/simple;
	bh=uWq41XjmaBPeNaNo0Twmva32kiVlfQyvpWdJh2HxoW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmaUOl52QGC7rNgNiK+dTGrEYi9Yk5khSyIrVzFImBN2t367CUniWhlqsZ1jbrGCYeUO3ButJtXurBqN9bs+lulqCK4UmOyMSitqdN6v4yQlQ8fxELUOuFRxbjkQNhSmxAau/nTfc5X0Qqzoqhp5fSpa3zIew81iYR56JrBFeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEW/DkBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C677C4CEE7;
	Thu,  5 Jun 2025 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749142631;
	bh=uWq41XjmaBPeNaNo0Twmva32kiVlfQyvpWdJh2HxoW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEW/DkBw2lWryrvdZAxurWAqS5vJ3gpkNuBoRSWCh/SwHFmTJzYQh6yBsfbk5Uqtq
	 MzCBTKkwIYhEtvhJ21OOUTeYVMWiU75SuyilBVymrJP533mpXdDoflSafA6cBYtVvz
	 Tbh+q09my85GQzBiotHxEy3y22UpjYEfsp2Ebi06likhlL3VjNeiMBQQB+xiCwkKWZ
	 pDa6WhtU7Jid9nAdR6eLD1jrhhm8QmKMmWm/W9URrPnZLis9IEIc2i2yvEU1uPLA5t
	 eoS8P9F9PuhCeWZAzLQVAmnrnbGOc8Umd4HL3SU40NwQRaJ8MO8jj1UnG34SIw+Vfb
	 OT1UTMdT3+aKQ==
Date: Thu, 5 Jun 2025 18:57:09 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH mt76 5/5] wifi: mt76: Remove RCU section in
 mt7996_mac_sta_rc_work()
Message-ID: <aEHMZe0_vuml8eI9@lore-desk>
References: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
 <20250605-mt7996-sleep-while-atomic-v1-5-d46d15f9203c@kernel.org>
 <909d2ca8-8409-997a-768f-8e9be4c5168e@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X71w9KW41lasa3QR"
Content-Disposition: inline
In-Reply-To: <909d2ca8-8409-997a-768f-8e9be4c5168e@candelatech.com>


--X71w9KW41lasa3QR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 6/5/25 04:14, Lorenzo Bianconi wrote:
> > Since mt7996_mcu_add_rate_ctrl() and mt7996_mcu_set_fixed_field() can't
> > run in atomic context, move RCU critical section in
> > mt7996_mcu_add_rate_ctrl() and mt7996_mcu_set_fixed_field(). This patch
> > fixes a 'sleep while atomic' issue in mt7996_mac_sta_rc_work().
> >=20
> > Fixes: 0762bdd30279 ("wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work=
 to support MLO")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Thanks for the quick fix on this, it appears to solve the problems we
> saw related to this.

ack, thx. Can you please add your 'tested-by' tag in this case?

Regards,
Lorenzo

>=20
> Thanks,
> Ben
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>=20
>=20

--X71w9KW41lasa3QR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaEHMZAAKCRA6cBh0uS2t
rPSwAQC/WKz8QxMEL+41maplaE+rUaOHZFrptyyd5B5oIoW7JAEA0M1Ih8nwvA2X
H0mMs8QIq+Oq5TX55w8vnReI92NFQQw=
=h9y9
-----END PGP SIGNATURE-----

--X71w9KW41lasa3QR--

