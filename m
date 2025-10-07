Return-Path: <linux-wireless+bounces-27845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E2BC07DA
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 09:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F352D3C7143
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53274253F13;
	Tue,  7 Oct 2025 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4wHZ37W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C767253B42
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 07:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759821618; cv=none; b=YAGXv0IYMN00gEQw+1YAr35XuYwjsGb34ej5rG2XdTInjPFdYKUXe4ahztnUA3QG2CMc8YTtcvSHOMRxgdP1dFJ1BJqRII7eqyMHtfOjI/VYOpnduBif/S4Q5VFrP8EfFVsuVuXAuvz2+94WLAntLnGVgYzl8zQu3tkkuVSwpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759821618; c=relaxed/simple;
	bh=ANg0JlzvM8aqpGXDQUgx61IIZukUkjaqnEBViP3JT3s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ak+V+zBftIZ+kq8/9bUJ3X6cmmuG7NtZ1jzm34VGakliTlgNvgO9ZWPzeApOA1jc7JHIJ24kzH+yDSgst7VzxRPF+xetO8wdx9nC8MUpszXaur5ZLDcG39k7E4SosdewV6/s/RbuSZUOVaT+oxGPPeRQETx/cS9gpVuQTn7O7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4wHZ37W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93799C113D0;
	Tue,  7 Oct 2025 07:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759821616;
	bh=ANg0JlzvM8aqpGXDQUgx61IIZukUkjaqnEBViP3JT3s=;
	h=Date:From:To:Subject:From;
	b=K4wHZ37WRQ6+QPRd4wKllLdoQK+uiU0csBjZB1UT/MIgbdQ4nYVSyaWV7zmRfD8oE
	 d1LpCRMVT2wIUMuQgSf5ru3PPwUkkG13GidRnzsTLeLtfarHTsRdYStHdGg7Hj5CGL
	 vSJ1qU6v5hRm7H7zjxelEDTmRznkO9t0yJ4fNDFRWjq50E1M5Q5yu6m/m9HNSWXOZV
	 T+DeN0Ynz7OyM1tivH/CF3ugLsvAMhiRxQXKvyStSHai+6RDvpWWgZViomRGP9OoRw
	 w0Nd2YIkMPufofPk9zgN+FzH4s01OvnlVCPvzTE3lGMTersqZdjPLKcOCmEkkzuIwG
	 K+Gwn/hGkR53g==
Received: by wens.tw (Postfix, from userid 1000)
	id 3AB095F755; Tue, 07 Oct 2025 15:20:14 +0800 (CST)
Date: Tue, 7 Oct 2025 15:20:14 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2025-10-07
Message-ID: <aOS_LlZy1h4CqkBl@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwttxwilbA3n93td"
Content-Disposition: inline


--cwttxwilbA3n93td
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A new release of wireless-regdb (master-2025-10-07) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2025.10.07.tar.xz

The short log of changes since the master-2025-07-10 release is below.

--

Chen-Yu Tsai (2):
      wireless-regdb: Permit lower 6 GHz band for Kazakhstan (KZ)
      wireless-regdb: update regulatory database based on preceding changes

Ping-Ke Shih (3):
      wireless-regdb: update regulatory rules for Botswana (BW) for 2022
      wireless-regdb: update regulatory rules for Sint Marteen (SX) for 2018
      wireless-regdb: Update regulatory info including bandwidth for Costa Rica (CR) for 2023


--cwttxwilbA3n93td
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAmjkvysACgkQOJpUIZwP
JDB+FA/9GT8D1vgALZJ8did8nSnmhJh8EfkuyFIxspX52ZpKyYJxa80mVzMb61pA
UPW3GEZvL7tEUAAHTlzlNiG9WQwyg4W3mgXyZUCLG5FUbkL9t+uWiuGekoom62kF
YdKWblkBlsKTo/Q7z+ITagr11xdlCO5zwcxO60r+v0+AATCMbbszwJI+cPq2Zbbz
asF5gJQhpkQSv3wgCb0qeD+aDbqhsnFXrAAav34ItaNC6LlaorGb8JnQSf5sZGZG
cobwxUe54cXQLJOsemMaMGGagYVPKD6nRGzUtpXxUYYKfMmLjzzCiXTrR3mXzCTv
ihCSqJDEXVkbSzZ3yWyPpzFprhIVV4xNxkYgirtaDSzcUd0lMIXhNQuHubS5btiK
a6UjtTjgCJkHwPUmiiRb8vvZXD/qwDqgH3+az10i745QtN3bBnve+BG6g7E0IjjM
Tt/bJb9q/UgzpL3peFxo/e17/G2ISBDxo63SE/NWVL40VO8FI7auxhGYuPj8XaBy
xkATEPiWVipUoiFubHaMz/b3Al9+uVy3AquJKrmvxUiPDMvXnzvPflfrE5xp8psV
3S010wrzeRVbxFg153L49vY248f+ApHkXOYYk1MMBrgb4DTwDQXWb9EibqiLqCT0
t4k1nw/u0rvPwMubzleSdkFTBp56oA7E4saJLPZn9OoEANp1nFY=
=eKmU
-----END PGP SIGNATURE-----

--cwttxwilbA3n93td--

