Return-Path: <linux-wireless+bounces-25164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4317AAFF810
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B9F7BA1F7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953424728C;
	Thu, 10 Jul 2025 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgPWifM9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A71236A73
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121720; cv=none; b=se+EYC6gMbte+S3W163seIDt1BDEkr3F1rWBxsFnxKG5GDKy3yJqK+KnDxHjG748vdcB01dxDFgHHWoW1lyL/tOWiXuOcQQyMAzUvzjCj87F4j/m8P4LEaL6EvbyUxJkAt+stCEBJIWYYNmMrcRU0W6Lxq7fcT5tyVBIEi8uS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121720; c=relaxed/simple;
	bh=ZsaUnOyYFhyMD3db3mLl5l9dFCIMZhZptm61KDEnSh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y6qZ2dztbDudLNxuYMhUcze7xxM0/OlTcESHL1d0b6q8jxXDnrSvtivZiyrxJoebtE+u/ihRScLdZ96tXmReMDLyjJ8w3ATXgSK/zNThaxkFUO/V41GBXRSt9bIuOp9vZ5Jr6kp8ONFhrcfd0r+xSnKACtGwLEhAcMjdjr6tt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgPWifM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3109EC4CEE3;
	Thu, 10 Jul 2025 04:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752121720;
	bh=ZsaUnOyYFhyMD3db3mLl5l9dFCIMZhZptm61KDEnSh4=;
	h=Date:From:To:Cc:Subject:From;
	b=fgPWifM9LItlDM3wQ7BEKEYA9bDssbaAsersw3sSKJZ5mBJva6gl7STJVj4ey7jzr
	 OA66OojbzM4Qu1Y7JsAp3RvIW8iQU9E3XTmzADPCh5JimJp8wXUETaDY2LP2IX8/fo
	 otpiU+HGtq24Dxp9gloYHbxnUkuiC3U3IGqlKqjvuDxwlKgXsm9b691gAPVDEgDsCP
	 mKA/CIRadednj3f6uySlJhDmRQCGBzYKOmMDKRtmMEzByAgqaFWONRwCcBGY6Otw17
	 yu8jvCgn9/7T2rkSFL4TcrIwTDa++mvZoqMPkjI703VIvToCMjGZyYQH2dW1BPEXJC
	 kT7qegbkDDsTw==
Received: by wens.tw (Postfix, from userid 1000)
	id 18F3C5F87F; Thu, 10 Jul 2025 12:28:37 +0800 (CST)
Date: Thu, 10 Jul 2025 12:28:36 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: wireless-regdb@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2025-07-10
Message-ID: <aG9BdH1fxJBk-5ka@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w+jTzmT9zPeuLXzS"
Content-Disposition: inline


--w+jTzmT9zPeuLXzS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A new release of wireless-regdb (master-2025-07-10) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2=
025.07.10.tar.xz

The short log of changes since the master-2025-02-20 release is below.

--

Chen-Yu Tsai (1):
      wireless-regdb: update regulatory database based on preceding changes

Duy Hoang (1):
      wireless-regdb: Update regulatory info for Vietnam (VN) for 2025

Emily (1):
      wireless-regdb: Permit 320 MHz bandwidth in 6 GHz band for GB

Marcos Alano (1):
      wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz

Ping-Ke Shih (5):
      wireless-regdb: Update regulatory info for Indonesia (ID) for 2025
      wireless-regdb: Update regulatory info for Egypt (EG) for 2024
      wireless-regdb: update regulatory rules for Paraguay (PY) on 6 GHz fo=
r 2025
      wireless-regdb: Update regulatory info for CEPT countries for 6GHz li=
sted by WiFi Alliance
      wireless-regdb: update regulatory rules for Bosnia and Herzegovina (B=
A) for 6 GHz

Taavi Eom=E4e (1):
      wireless-regdb: Update regulatory info for Estonia (EE) for 2024


--w+jTzmT9zPeuLXzS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAmhvQXIACgkQOJpUIZwP
JDAK+w//e7nnUlMACU7fZEB7VoNwmCveXuXzb3LscC5RqtZ5h+3qo+YgkNyUW4qV
2uNOljo6EDbHnhqVfI60YwoQL/xKhPj1OfXExtYmPoO+7ZTkTPlWayTA1uLd7IX6
HM09WWNb7vQU4EIv55sVw1M8a5/WbC6iF07Xb1Z/BjDW0n/hVSinatUT8WMeZWNg
DcyyhcMdXVY6Az4Zrpq641/Vb8RP2fruHEz2HXMcDGnUWJjp6doDVopQW0TA8dpp
0IaX64d7a2RWBK8NwGW+5oN65mCx1eF22sz/Oy1z/6+eq+M1+Vscf6xgJoowPYtv
V4v6EUVx20nQdItkH+tlEg+NXslz4Nhh4UPgYCEcksq7txBtQtN6U8J/a5rF8imS
RM55TjFNVVx+XOUFdqRvic3RgmIknwmzaKy576yeFlJitISGU77D39j83wu4VCLA
zmSscdLKK945E4okwgdO6das3BZw9YbNmcecdztoVMw40gFVITeyWvNVKZgSTMar
CPfiPSYnkknNahliOllb/5PG2F/tFS89CM0ZGbvnidrH4FxB/+zfoXfF60Q1FeOr
RWdK8whF+9J1uQvTSQdrV0CHWd/RxNnIu5xR1/OmcVOJ1hFfBBG5Y19wkw3sj3Ze
VYh8sEtbz5fMYuGhU6TaIl7pWX6sGjUZjK8MaEGuKwbe0OwUJ6I=
=8zUb
-----END PGP SIGNATURE-----

--w+jTzmT9zPeuLXzS--

