Return-Path: <linux-wireless+bounces-11800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B295B49D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 14:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC01B23FAA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1C1C9DDC;
	Thu, 22 Aug 2024 12:05:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D351C9429
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328330; cv=none; b=LtIUVBUeXmpTQXg0REOTDddTzXaQ9A1MAJjWmfWy4nxrHqtLOt+AOwgwznZIW7hv5wt+Q/RWDjgO/Cv10dm+OgxlWG6X5DmGJWwRsNThOi9/xXTzaU1encSMEyFppGJTWqNnk68VZdvZojupYVlSE6xZag+vNZ8np6aWQfqkUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328330; c=relaxed/simple;
	bh=sRjg4Hbw8XmUSTcUYKi2RffU9tTcSQR2LO9nIL6UDis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6y+UYjVUwI7H7fzhNSyBOG9oQhjr2pchb+DjEADHP+uKphKCF6CLmz0kfseFP5x4P8YVs0ahVF9QPIRrB89hgHgodfraCa5UKCJAEIKlZwGiesLzDKgJQAn45XhC7rctDeehz3KBV4n3qZWgQILgrADv1RpKE5jy2Fev7JoKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh6Z9-0007no-Pi; Thu, 22 Aug 2024 14:05:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh6Z8-002F62-Sx; Thu, 22 Aug 2024 14:05:22 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8AFA432497E;
	Thu, 22 Aug 2024 12:05:22 +0000 (UTC)
Date: Thu, 22 Aug 2024 14:05:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Message-ID: <20240822-brainy-liberal-toucan-bc498c-mkl@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <20240822-gay-myrtle-tarantula-bae0e0-mkl@pengutronix.de>
 <PA4PR04MB9638C8D68F0F71C17E903DDAD18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stss5vizbnrqvxu3"
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638C8D68F0F71C17E903DDAD18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org


--stss5vizbnrqvxu3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.08.2024 11:59:55, David Lin wrote:
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Sent: Thursday, August 22, 2024 5:53 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>; Brian Norris
> > <briannorris@chromium.org>; Francesco Dolcini <francesco@dolcini.it>;
> > Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > Subject: Re: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
> >=20
> > On 22.08.2024 09:36:29, David Lin wrote:
> > > I wonder we still need patch for indent issue here? If so I am sure we
> > > will need a bunch of similar patches which I don't think really help
> > > improve mwifiex quality
> >=20
> > mwifiex is the best mainline driver we have for these devices.
> >=20
>=20
> Yes, we will continue to fix bugs of mwifiex just like we added the
> WPA3 support for it.

Why do you think 2 drivers are easier to handle/support/maintain/...
than 1 driver, especially given the low available review bandwidth?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--stss5vizbnrqvxu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbHKX8ACgkQKDiiPnot
vG9wkQf9F6vKJT0xmAB+kOkKNUxB3qVf8c29av7suMe7+KvnkDeltCpn+UD0mxjx
meC6xia2OwT0eIRu3M6/ErqYW+vX7ssLmO16RQ3OlX6z2xrjLzLONYuQ0WthgI+P
n1BgJCcu8+wqAUnhgqA6BWYm83/Br79nmeF/0nX6AnZ+gNQeZ4iGLgxIRqOUoEtJ
eiEmwuN29EwQKV/tetQ1hpKAS8dVB9CTqu0pCY5KP07s0tHg2bQp8h+dhu67Vx05
mtf46VNfuS85hpNcCWAMwm2xahzdmmJ2zLwTvJDdjjTVd43CWF7fFlhzW5/cK5po
r4WjkJB5jHgzmvI4C2tN2F6GDCJpHQ==
=P8Gx
-----END PGP SIGNATURE-----

--stss5vizbnrqvxu3--

