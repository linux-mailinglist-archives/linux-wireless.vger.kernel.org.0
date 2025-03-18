Return-Path: <linux-wireless+bounces-20497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E2AA6759E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882517A714B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F020C00C;
	Tue, 18 Mar 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwCpccxa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB41AA782
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306039; cv=none; b=ZTmzT1XAjrkyf4NwxH50sg50A9hxR3LPO8M1cBWLZOILzbOSMVtEgBpLD4UcAI973GBmDQXbQpUsQSloJxalk7VcAKbl/sS6VIlpgtUdVrFjTTMogmHhIJ1OS83Sp1cqxa88MeVdQUVeEDhTTWK9/OQpeI2GR3qsuxP+KffRqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306039; c=relaxed/simple;
	bh=exq48y4UDS4CNhrlQI3l6HQBS5ES5ynXCCbVCpH1UyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfZVxKhg/TS2J/ZTe5hPLgNdbf12MKfKpkbzXyuyBYj8ig5C0qcTkRom1GcLx+E3WJFmL4yJoPRGnpyyb5rgeugYSDSAyjzmyIGDbZLjXeW5p0boWPFZ2VhfHUgLIpfkAUI0mycZr90ID5NakcJsrtZqxwTL/I453kUwKqoHjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwCpccxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806C0C4CEDD;
	Tue, 18 Mar 2025 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306038;
	bh=exq48y4UDS4CNhrlQI3l6HQBS5ES5ynXCCbVCpH1UyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwCpccxayKhI6ckfPXN6x2rcwonxpo92h9X4bC4cvlC35rhylaDyY4NQHQiaLxKN3
	 yFzyP0lKkKbhofrJk7A4HkI4snl8WCIrvztZozLJs+rbxe1jIyjBPgA3ochiQIuBvp
	 Y7groGmsKyrQt3EyPm5FigdyxV7AAeEgXM9Hs7lZYXaMwZDRMTa6W80+rylxldEWXw
	 ZArzQIr2MOYq7t6fhMSJG2UoGYsBCDqvi5ZRBybbY/B99Mgad37tDwolPLmco7OCKP
	 TAWNxQXCizYbiLoTzG5qp7F63by/HcmOpTXt2NJ2IMwrPCejd+xAfXOSvdotAkZ8OY
	 7CJzAUJqrsSQg==
Date: Tue, 18 Mar 2025 14:53:56 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 20/21] wifi: mt76: mt7996: rework mt7996_ampdu_action to
 support MLO
Message-ID: <Z9l69EeSm3ZemucG@lore-desk>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
 <20250312-b4-mt7996-mlo-p2-v1-20-015b3d6fd928@kernel.org>
 <38ab11261debaf7e0884080031412808396eea5b.camel@mediatek.com>
 <d584cae48470cf08b1029e0fef1383f92444970b.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QC7bqY7jvMPKDwHq"
Content-Disposition: inline
In-Reply-To: <d584cae48470cf08b1029e0fef1383f92444970b.camel@mediatek.com>


--QC7bqY7jvMPKDwHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> Sorry, please ignore the previous mail.
> I just aware that the deflink is now used as the primary/assoc link, so
> it should work.
>=20
> Regards,
> Shayne
>=20
> On Tue, 2025-03-18 at 14:28 +0800, Shayne Chen wrote:
> > Hi Lorenzo,
> >=20
> > On Wed, 2025-03-12 at 12:14 +0100, Lorenzo Bianconi wrote:
> > >=20
> >=20
> > Regards,
> > Shayne
>=20

ack, no worries.

Regards,
Lorenzo

--QC7bqY7jvMPKDwHq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ9l69AAKCRA6cBh0uS2t
rLYuAQDn1Wm9sdM1JI8LKfHpJi4eZ8Zos8g9Ky74NpQinqvEpAD+I9Fm1rnMWZ4Q
MzfC7A+Fb6MjgxEprXxdEli05QGIbwg=
=E1zp
-----END PGP SIGNATURE-----

--QC7bqY7jvMPKDwHq--

