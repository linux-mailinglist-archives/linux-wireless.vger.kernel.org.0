Return-Path: <linux-wireless+bounces-23777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B450ACF51A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C002B3AC571
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13531D90DF;
	Thu,  5 Jun 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWk7p52L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D475149C7B
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143740; cv=none; b=p5eSTjDwC4D99mNsOeXU4YMZ7CcXYglH56nXLTM2YAbZnbasvb71pbnj4iRx2e+LJfl8Rx3ylYwDLOFxLEA206BpyUJehoYakpCfrD3vW4r9Nh30xHE3I3qFSi6U5HpiUnyt1yzXtMGu13KO+IF5SVFovDM8V2UjQHUaZOZjkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143740; c=relaxed/simple;
	bh=Is9PhigI+NRiop6o+N5MbVbepMB53nyr70V3V1AmBcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtvhxeHQF+byp5inW41veKtXzv/6KHuMEDxwVCMwmwEyJobG+UDUL5Bppkc8X8bS4ooBIsBYjMMmnJ7U5kOYIsRsBKZqXa5zy3sr+wPtEd610w1uw6G8fbz3rTMBidBipch0o01bdYWwINrQHXW6vbh50hWzu7QtQVuEuNtWGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWk7p52L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DD5C4CEEB;
	Thu,  5 Jun 2025 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749143740;
	bh=Is9PhigI+NRiop6o+N5MbVbepMB53nyr70V3V1AmBcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWk7p52L5i9B3e1tGaXOOuI7fK/E6do4+ncgC7RtDv/8o+jt4oXEJvRPyXbVNF6D2
	 sfwD6jLka5mR2N9F0wr5DhtAGuACgNyND4ae8KiAzhKrjmcuONw9t1dC8tZ5EcSmnZ
	 pPRGDh6l+IHBCdvU8osWphSOotyxeah+DrIyBYiqUhVybStasKvKiVHl0lD9NXQLjT
	 FzDMlfs9TW+py09tsPGEAiLIAxq29u9JAVL/WIYgvDljwSjU4Zmevhi2AKPDCaHmpX
	 1xd/r8OOcwEJersk4TC6O0shzHCcn10MB6JcF0P2XB/eubyHZk96SbRQykJ0a33lU1
	 v0kTtX/tfq4WA==
Date: Thu, 5 Jun 2025 19:15:37 +0200
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
Message-ID: <aEHQuQPuX8cuCXWY@lore-desk>
References: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
 <20250605-mt7996-sleep-while-atomic-v1-5-d46d15f9203c@kernel.org>
 <909d2ca8-8409-997a-768f-8e9be4c5168e@candelatech.com>
 <aEHMZe0_vuml8eI9@lore-desk>
 <7b381baa-61a5-2a19-1bd6-47ad4abfdf3d@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rQZh+hYhrzya4vOG"
Content-Disposition: inline
In-Reply-To: <7b381baa-61a5-2a19-1bd6-47ad4abfdf3d@candelatech.com>


--rQZh+hYhrzya4vOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 05, Ben Greear wrote:
> On 6/5/25 09:57, Lorenzo Bianconi wrote:
> > > On 6/5/25 04:14, Lorenzo Bianconi wrote:
> > > > Since mt7996_mcu_add_rate_ctrl() and mt7996_mcu_set_fixed_field() c=
an't
> > > > run in atomic context, move RCU critical section in
> > > > mt7996_mcu_add_rate_ctrl() and mt7996_mcu_set_fixed_field(). This p=
atch
> > > > fixes a 'sleep while atomic' issue in mt7996_mac_sta_rc_work().
> > > >=20
> > > > Fixes: 0762bdd30279 ("wifi: mt76: mt7996: rework mt7996_mac_sta_rc_=
work to support MLO")
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >=20
> > > Thanks for the quick fix on this, it appears to solve the problems we
> > > saw related to this.
> >=20
> > ack, thx. Can you please add your 'tested-by' tag in this case?
>=20
> Tested-by: Ben Greear <greearb@candelatech.com>

I am assuming this is for the full series ;)

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

--rQZh+hYhrzya4vOG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaEHQuQAKCRA6cBh0uS2t
rNBaAP98W+euo+7SVQvnDZx04WeqMaGZGJhO85raS5FZZID5RQD+LRozmj1RhTxO
EEnIIFxmsR18vviclCF5swGkTfZ5kQs=
=Vc0x
-----END PGP SIGNATURE-----

--rQZh+hYhrzya4vOG--

