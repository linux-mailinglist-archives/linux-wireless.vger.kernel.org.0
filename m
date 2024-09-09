Return-Path: <linux-wireless+bounces-12645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0026971241
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE78B22107
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813121B14F1;
	Mon,  9 Sep 2024 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aD57UxtP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA211B1414;
	Mon,  9 Sep 2024 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871171; cv=none; b=FZgAhv40TeZ8cn1OlMoT20BynQp3RbsaEJszxaFU/hVB08UeYTM6IhXsd0CwKJba4gpI5BDOgyQabceppAb5Xnt6sJcFz6bhk4bjhJJ6VAep+wb9XfzatsLNjPjGdaO9MNQyfO93mYeb3W5BkBjilIB8iWmpF6JkVpp9dnmcXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871171; c=relaxed/simple;
	bh=W5lvT/fkeySOA/tNKWMqBzIOP7+vTqXe51weN99lwy4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RIAtNjagpPlVX4MXzpcWJk945MuNcm2OybFL7hx2FFwjkgfvEXbqA5ZITFEVA1UCkAeyEyAJTqmh8yDKYHmTOG3CFqw1xr7pvz7+naCt5OdlTm83pWJBXV8Xbrtz2hzQwJSf6Tsw6Sr2IlcOx5b4RY61edKYRy2wvYNsPQLKUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=aD57UxtP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1725871165;
	bh=4B+cdiEHxTvVXPeIOLSbixTGwuQueagrqLiDHLS9JPw=;
	h=Date:From:To:Cc:Subject:From;
	b=aD57UxtPsWz8paA2NsrRr6+8erjXru+JorHPxDMDoRupAEWWlmEilq6UocMedOfhR
	 vtwN5M5fTuS4VgKZYuaZTy03xSaZ8G7Rf3PBHFZmB1sd3ZGAPMPb5Gq+fpbaze4WaL
	 TlhwCM56M1pevl6l/r+IqteUWLGV0TnXXVpu9So2umFbKPjxRU5McE87msYJhM1fqm
	 KwXhnhWd6a6z4R3pLrOHpPSbzR+NwEqB+sl5aLDB8GObGLFGx31I2TVO3ZEOEXf8fo
	 FSO+T9fYnwP5roAHKaylpw7CfBIBC5hE+tge1Fyzldl+k+5JeTM23MHc18hgrQ3n/l
	 e0j1wSOE6l4EA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2Ky51x0Kz4wcl;
	Mon,  9 Sep 2024 18:39:25 +1000 (AEST)
Date: Mon, 9 Sep 2024 18:39:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Aditya Kumar Singh <quic_adisi@quicinc.com>, Johannes Berg
 <johannes.berg@intel.com>, Wireless <linux-wireless@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the wireless-next tree
Message-ID: <20240909183924.73c3c91d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ABm/tvU4o.Nv1V23ohif_DS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ABm/tvU4o.Nv1V23ohif_DS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced these warnings:

next/Documentation/driver-api/80211/cfg80211:14: next/include/net/cfg80211.=
h:6219: WARNING: Inline strong start-string without end-string.
next/Documentation/driver-api/80211/cfg80211:14: next/include/net/cfg80211.=
h:6219: WARNING: Inline strong start-string without end-string.
next/Documentation/driver-api/80211/cfg80211:14: next/include/net/cfg80211.=
h:6219: WARNING: Inline strong start-string without end-string.

Introduced by commit

  62c16f219a73 ("wifi: cfg80211: move DFS related members to links[] in wir=
eless_dev")

--=20
Cheers,
Stephen Rothwell

--Sig_/ABm/tvU4o.Nv1V23ohif_DS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbetDwACgkQAVBC80lX
0GxgQwf8Cm+koPfixGsrR2Mo0epDBHtYEGtKZOFBzC7lBP6klr+fg7fs1uM8MKp3
JAFN//HWplRCdCKd0m3BPx2N38wajrUP4TkGoxRbBmdLi7NV/8CJWetFDpUx0xCA
gyLFjJxkEBA5uyzp5ViWYfMLvRtAdbwHoEzJRMz3Hu2JgicWpKggkTD+RLVYKURs
OksS/v366aOhcqj0qhSPVm2Klf1xEX0kUDabO1HP+xiOkXjltVFV8Jx+kXvHrS1d
hJ/Ux1lvtNGSE0B4eDwvgbyRquTtWxJl8n6+0rUYlq9h1t4yd7HAzMoL6MIvR8Yn
UDurP7mU7vpLyYk11HyQDi6f8BOJHA==
=ulDd
-----END PGP SIGNATURE-----

--Sig_/ABm/tvU4o.Nv1V23ohif_DS--

