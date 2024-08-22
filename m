Return-Path: <linux-wireless+bounces-11803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAD595B4E0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 14:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710AE1C20DB0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392B1C9458;
	Thu, 22 Aug 2024 12:20:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A137143
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329220; cv=none; b=WtoH/rr1+nPO3JnEX1s1E9NdhGOSx5gR7/LL0Eam48RWCbDcxaZbsF91XshtaDKM/fm4ANayabL3VrnUrVj4DlqLQ9WkH7whNtBZ8chzlp61fKSrCP6IPbbdKcsdAxRwXHKaVJKojWjEpiFe9v1OzF6gcjcaAU0ln6PyUl0yhYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329220; c=relaxed/simple;
	bh=BUaGhDKugO8KmJcMu6yG5efX9QIwQvWnMGEzBPRTyGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNPcSrlFRbObBInTUBLWwI/109qaA4vRNUCn19VmrpI6afvWDzlLmC1PuPrfJKiO6nguniYXcPNOhE9uDkqtkSooLH2CGOE14ohfj1NF970kb3BsZRWqPn0Tg8WV5SfVQmqvN0KlstCq0wugmSgbViS+YyU18mRRdEp8/fKXJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh6nU-0001ow-0R; Thu, 22 Aug 2024 14:20:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh6nT-002FNW-6r; Thu, 22 Aug 2024 14:20:11 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D93CA3249CC;
	Thu, 22 Aug 2024 12:20:10 +0000 (UTC)
Date: Thu, 22 Aug 2024 14:20:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: RE: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Message-ID: <20240822-attentive-solemn-rat-13a85e-mkl@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <20240822-gay-myrtle-tarantula-bae0e0-mkl@pengutronix.de>
 <PA4PR04MB9638C8D68F0F71C17E903DDAD18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <20240822-brainy-liberal-toucan-bc498c-mkl@pengutronix.de>
 <PA4PR04MB963813C76F476449A5003FFCD18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stabsaq2vdo4glry"
Content-Disposition: inline
In-Reply-To: <PA4PR04MB963813C76F476449A5003FFCD18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org


--stabsaq2vdo4glry
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.08.2024 12:11:15, David Lin wrote:
> > Why do you think 2 drivers are easier to handle/support/maintain/...
> > than 1 driver, especially given the low available review bandwidth?
> >=20
>=20
> Nxpwifi is used to support new NXP WiFi chips. You can check the commit m=
essage of Nxpwifi to
> know the reason why we need a new driver to support new NXP WiFi chips.

FTR:

https://lore.kernel.org/all/20240809094533.1660-1-yu-hao.lin@nxp.com/

>> [1] We had considered adding IW61x to mwifiex driver, however due to
>>     FW architecture, host command interface and supported features are
>>     significantly different, we have to create the new nxpwifi driver.
>>     Subsequent NXP chipsets will be added and sustained in this new driv=
er.

Thanks for the clarification.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--stabsaq2vdo4glry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbHLPcACgkQKDiiPnot
vG+J4gf+IEXO+QAQVMqrjhoe6SJq11AT5ZT+0VfCWfc/cnKSt5J/qPyINKQSpNFX
y/ONVGx388jCSpujPpcmuyHgzyZRx1phYBSIoGPKCq3ZnPZ4pgLvQLgnwJP22rET
nMkY48c+8CcaAvDuVpwUtcIsWXtGlb3qUNwf8HixneB/rnqiKG5B41H+1rYt6D+B
K69MwkOvNcnCZWARkw4M8Wp7drUHyabXdi1e/l+ugRrwJMRgKqzXi+tBvNNEdI6E
giMDbn7C6aZJPagFWSuQ/FRA7eHLqZahrUy7CX+E8JdcRJxj6IhVkXLS8f4jjecs
RULd3GGaTRPqab+zERzlY6VUzV35vg==
=Ej8p
-----END PGP SIGNATURE-----

--stabsaq2vdo4glry--

