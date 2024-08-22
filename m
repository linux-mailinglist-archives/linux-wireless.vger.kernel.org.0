Return-Path: <linux-wireless+bounces-11797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F195B33C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 12:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36E1B23425
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4F714A4F1;
	Thu, 22 Aug 2024 10:53:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639117F4EC
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323995; cv=none; b=KJ2Vwa8i5kMImfUtALvL9gCuVcAoZgzWN0QLAsXXAYuKcvlKWATnTaQPAVJrHAASNHiWmUg0Gx0AmqglbkKdLScOMmWG4a0K9UwbHJ/HjzUHAm9wRLbvMrSnYt0bOFoyedRT4PduL0nU6SkY+Z3EmLyEqEVwe3bsn4C+QrZ4Cx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323995; c=relaxed/simple;
	bh=sQOdsfZF/NazDQhP/OQAo187eK9B8ObIDLTIoidHfx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWicW3RFROj/CY8mVy6/Y3cQyBkie8e/WsI7SQhj6zDTMAKdoqL1nRlIIS09157gopUFZtlP+2PJupUgOvLPBzTdeAkhrdYu2EiCNtZEGTydRq8BC5pRHPbrNFwRnNjYDQHhY+c4i2XrllVnn3+F8smtiHG4jwiRqqOi3RHQoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh5RC-0005Mn-3R; Thu, 22 Aug 2024 12:53:06 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh5RB-002ELB-AK; Thu, 22 Aug 2024 12:53:05 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 22B4C324871;
	Thu, 22 Aug 2024 10:44:35 +0000 (UTC)
Date: Thu, 22 Aug 2024 12:44:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Message-ID: <20240822-clever-caracara-of-drizzle-d56d0e-mkl@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <20240822-gay-myrtle-tarantula-bae0e0-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxmmtxri4kik5hni"
Content-Disposition: inline
In-Reply-To: <20240822-gay-myrtle-tarantula-bae0e0-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org


--lxmmtxri4kik5hni
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.08.2024 11:53:25, Marc Kleine-Budde wrote:
> On 22.08.2024 09:36:29, David Lin wrote:
> > I wonder we still need patch for indent issue here? If so I am sure we
> > will need a bunch of similar patches which I don't think really help
> > improve mwifiex quality
>=20
> mwifiex is the best mainline driver we have for these devices.
>=20
> > Actually in its successor Nxpwifi (currently under review), we have
> > cleaned up all indent, and checkpatch errors/warnings/checks.
>=20
> Public review?

Found it:
https://lore.kernel.org/all/20240809094533.1660-1-yu-hao.lin@nxp.com/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lxmmtxri4kik5hni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbHFo8ACgkQKDiiPnot
vG/bvgf8DaPnCJxuHqvkBU3lcM9WlGZEdp6nAvrrnAOZLesx1OlePO0xIxScMfAB
HUSRIyRE/mbZTCZJ9i/K/Wmw8wYXDTtJGpH++83sXE+WCCU4Gkn1YABMw6uJz0rp
eFZ4qnhTgcghpoOG9MjRv8gHRQ6ZlxIWLD6CD7eJ7Suu/uPdfZdtg76zpGUFybz/
ezG0h2txl4xTRvAK7GuXpwxldJ3vrHGrvWapO5F626ywMNIIP0gPrAqYZ9teMPb1
nrmv+0GbgpB2xVP3Pc4CqWCkk5VyiXMpXx47N70jfInwnJ6kXu4sPaEj37Pf7arR
ynKmNPJhen90Y+nHBQ9voHlslp5sNQ==
=YZ2v
-----END PGP SIGNATURE-----

--lxmmtxri4kik5hni--

