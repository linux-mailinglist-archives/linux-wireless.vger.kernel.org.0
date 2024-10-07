Return-Path: <linux-wireless+bounces-13576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D4992320
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 05:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E481F22763
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 03:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE512E4A;
	Mon,  7 Oct 2024 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9hBeSZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB5FC11
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272294; cv=none; b=dxqAIPfZ/LC8m5THCggZFaLq7wFWTa/zA6YvPPNrkwCmR+gqksRKCcii7YXJaXCEu9PX8NoOxT8tncenDNjhsqhJTBTw5+wxShBua6+6UTYq1qSX45y7EWQrlR+WJPnWo26aqA16RUwf2A/cQeEu08JM5WzBQxq4UqM3yloc6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272294; c=relaxed/simple;
	bh=t/ZuAZDvw8PeuV3Jy/ZNsWnPhod3ylZpUO6KHDk+E0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mf3KBLQhhG9yuSz6oj2Wpxc1L842AwRcn1Qqh94Vx0XqDfyBwHWkXg1B+MFuyncsz3RCK1uoOAHWHf4PReXizeDPztklzmKrvYl7Q+mUOrytbWF0miiEmhON4i/6f+m6GSGcnGWucMt09fqu58Lx/VJr3qyyeYe+Ax2XlVITWjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9hBeSZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA2AC4CEC6;
	Mon,  7 Oct 2024 03:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728272294;
	bh=t/ZuAZDvw8PeuV3Jy/ZNsWnPhod3ylZpUO6KHDk+E0c=;
	h=Date:From:To:Cc:Subject:From;
	b=A9hBeSZBRWPf6KMUP6xoGdFPm+uW84Rb4RvTZOvOzdmulmNnWXJs/Iw9JYKCOwn4e
	 OGTD5D+FLrjpbrqtLoJ2258Ak+x77niumrYFVnomI8CIGFjcmMG1PoG/XtmovHxPqv
	 SFpw/PlAAcdrUjh5arV/moS88vGomMR+M0pUaiyfg6SqiOg/nPvswUc//ZpoBc6D7V
	 9U3dv8vdVQ2RDJ2a19kR+Mx5QEBBDcjcQ8l8yuEyATsRA5pCod++BcqNqQdUAkUftu
	 Hg3J6aQUWr1n268RSOhDsRs9mYTREReUHZThMsIlVh19cAIDmWACl/JkteTMMtWM+M
	 vu+GHaQ5GivBQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 69EAE5FA0C; Mon,  7 Oct 2024 11:38:11 +0800 (CST)
Date: Mon, 7 Oct 2024 11:38:11 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: wireless-regdb@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2024-10-07
Message-ID: <ZwNXo23LR-zCMSYw@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Gab4obQgOyeVzc2"
Content-Disposition: inline


--8Gab4obQgOyeVzc2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A new release of wireless-regdb (master-2024-10-07) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2=
024.10.07.tar.xz

The short log of changes since the master-2024-07-04 release is below.

--

Chen-Yu Tsai (1):
      wireless-regdb: update regulatory database based on preceding changes

Gacel Perfinian (1):
      wireless-regdb: Update regulatory info for Philippines (PH) on 6GHz

Jiaxun Yang (3):
      wireless-regdb: Correct regulatory rules for China (CN)
      wireless-regdb: Update .gitignore
      wireless-regdb: Add .b4-config

Ping-Ke Shih (17):
      wireless-regdb: Update regulatory info for Qatar (QA) on 6GHz
      wireless-regdb: Update regulatory info for New Zealand (NZ) for 2022
      wireless-regdb: Update regulatory info for Peru (PE) on 6GHz
      wireless-regdb: Update regulatory info for El Salvador (SV) on 6GHz
      wireless-regdb: Update regulatory info for Togo (TG) for 2022
      wireless-regdb: Add regulatory info for Namibia (NA) for 2023
      wireless-regdb: Update regulatory info for Bahrain (BH) for 2024
      wireless-regdb: Update regulatory info for Guatemala (GT) for 2020
      wireless-regdb: Update regulatory info for Serbia (SR) for 2024
      wireless-regdb: Update regulatory info for Kuwait (KW) for 2022
      wireless-regdb: Update regulatory info for Israel (IL) for 2021
      wireless-regdb: Update regulatory info for Honduras (HN) for 2023
      wireless-regdb: Correct regulatory rules of 6GHz frequency for T=FCrk=
iye (TR)
      Revert "wireless-regdb: Update regulatory info for Serbia (SR) for 20=
24"
      wireless-regdb: Update regulatory info for Serbia (RS) for 2024
      wireless-regdb: Update regulatory info for Pakistan (PK) for 2024
      wireless-regdb: Update regulatory info for Tanzania (TZ) for 2024


--8Gab4obQgOyeVzc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAmcDV6MACgkQOJpUIZwP
JDACAg//Uqnu/+8Q6UyT5DN81U0L3BVz3b/Epccq8ii3D0VwuShGch97Kdy4lT1s
qKZs4h5uuDrD4aG4AjBb1PgEJ5Btx9X1oZCzul8sscYW8UWEk5sYTebHpSCgULE6
gYeW7/LTtnq15vrkqE0DnEWGA9QNOcboxeIUzy19nUV++keaSJuQLCuAc9Z1LWyC
C4VItmLB31XusAXySevV4srRov4eFpNsPfVh5984UFDi8WvLdmeF0lPw4TwGXzM/
4XikRaa098PPtUo/txhaJTkkpv0FnypXe4SHMhvkqZ9A2UWRt0uAeGWcF3xd71oL
tgRTW/aw7CIRCtpGtI4iH066HGG+Pmz+676T0bOxpxMt9+u/t1Jdp7IhZqBp8kIk
QYDM0sOPXFaDPuE3bupBRXxfo8663ZlhEHpE9bRUtAycI2L9EGqQJAne3bhWv0De
+RUmXOGZ+nC1Z+FRv4UpWyMCAHe76t5n1IAJL3YELTDMPDpyXRTzqHRDvtLp3VOO
HjyZo9JRa1lGLZLblyi7TKzHuWtnRPDcGfeuHB8MWkw20L+cYdkGDJ36KfYW1Z+3
3VTWshu6z5XTqNxfWXdisq6FDt+YXjio4cDo1XHiD4yiuTA0vzJSVJcqZufeO1+L
G4jbpOinjfwnDEy0Kxzf41GsEWBxziEYWAQf19tZ2fmEco6sDr4=
=ShB4
-----END PGP SIGNATURE-----

--8Gab4obQgOyeVzc2--

