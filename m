Return-Path: <linux-wireless+bounces-11794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846F95B269
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 11:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C971F24A98
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 09:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F517E8EA;
	Thu, 22 Aug 2024 09:53:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471717E00A
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320416; cv=none; b=T0JUOr3xUIBVrmYlxyD8NAk2Trw8BB7Gtwwn475XAmV1BxkyL6pXnUHIhG9RF86F75bphEXV1nXn3DacQNWMleHFQFiYSVO30ZTFG/YMx/yhVyZL9PSEv8oigkOOof55PcErIB8sD7rmvn7g1cCjTRKUQw4lFVv6ywfIMjp2y3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320416; c=relaxed/simple;
	bh=H91w8kLXLCbNh3zV0BgTbMDdbQa4ZHAV5Rw3uan0CRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR8S1UO48AoLVJEe3LmXFi309Q8brn105AF8jtRlYHyANl6ZnpTYeyLdYztAYcDU/4uHKl9dADeOEl1KhvRIiCddE5HEsYfP7qwXePHqTgfLnqYNuFJcswHQ7Tf3pxAugXyfiuHJdfyZy0QXekWaKv7DxSHAwX5Sul1UDu1Ix7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh4VS-00009v-SZ; Thu, 22 Aug 2024 11:53:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh4VS-002Det-4m; Thu, 22 Aug 2024 11:53:26 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CB2E6323702;
	Thu, 22 Aug 2024 09:53:25 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:53:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Message-ID: <20240822-gay-myrtle-tarantula-bae0e0-mkl@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nibdz654ztaxzimx"
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org


--nibdz654ztaxzimx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.08.2024 09:36:29, David Lin wrote:
> I wonder we still need patch for indent issue here? If so I am sure we
> will need a bunch of similar patches which I don't think really help
> improve mwifiex quality

mwifiex is the best mainline driver we have for these devices.

> Actually in its successor Nxpwifi (currently under review), we have
> cleaned up all indent, and checkpatch errors/warnings/checks.

Public review?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nibdz654ztaxzimx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbHCpIACgkQKDiiPnot
vG9cPAf4hXOva7w9uM737RBhcL4kCh2Ip++yRPZvGdQbepbwtWJBzVMjjqNfiSb6
BepLO8Y7dwM7NeLcfQpcT0sJbgD5ZkfHsHKfayf+VrAB9p2atuwVZ1fiTrsUg8tb
Lyk/r9i/IUHGbIB9utbqQ3mIY6rW7w5a0MCPLDAXYNsWTmAYuJlomKkpbnR40XvJ
l52sU6OE+HyygrrnABgZh1w6lTaKbLnRvosXKkMEOkGW3FvXe1Fuv96ONbxjewFS
IFluZF2fADEPiQyZa+4M3t1cCHcOxiuH1rVa6zvM90A4e3rLtsxllPb9gMTcjCMd
V3S01dn0a5M8KYdRJMlz4+iqFqNd
=lOZk
-----END PGP SIGNATURE-----

--nibdz654ztaxzimx--

