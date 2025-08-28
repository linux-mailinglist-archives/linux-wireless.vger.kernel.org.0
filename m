Return-Path: <linux-wireless+bounces-26841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A49B3AE8D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 01:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E4B985D5D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 23:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B56213254;
	Thu, 28 Aug 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="B7ELupAr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0230CD97;
	Thu, 28 Aug 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424832; cv=none; b=Vtf+PNkiJGJhTUGkDh48Sy/simZXLQ0sUoZSix3/Sx1DWeXImnMDEWMl424XRMh3UvPUoMVZb17lZPiUhV/sqM2gMCsnhZTCdnoDPXYXGP6NVUKVlG+vKCy1nBjQa0kcuxQmVeRhYzMEhx9qL1q4t/2JwYL2g84KCH9JnuDZqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424832; c=relaxed/simple;
	bh=BsEN8UgnSRnC54hyugAZq3MA4oNkwONDTLwPrpc9iWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=a29ajee0IKYO76zWksrdWUmgTFtMFyx3l2u0cxolBKAWQHIKJ+1MhqULVt1nbvXTvWjxA4jEJ0kGAkbX7grF8aBrkBXLdbvnOm2rfJZc1qINHa1Tas1Rl5DFb+dMk3X21tFZreu3S0xF/RGnePTSU4wHrAexUKtGSBMrfkBnuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=B7ELupAr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1756424823;
	bh=tqp61Xp/VmzahPjqeUlvuv+wJj91AzItOpzxIJS6qr4=;
	h=Date:From:To:Cc:Subject:From;
	b=B7ELupAr+qQW/B+pllPAP0/j2ozL70BS5JA2j7iMBlkEEVJqs2vf8C4b5jntTiB6w
	 jo8mly5cZS/eGtQ+oBz9zDCvfpRZWcMyAFNle20ECWl0ybVZYrxDeCVeMA6Bg6ntxV
	 GliYifWCL3srTp2EedDo83q12ooKqUz+7WpXRsPEHhhxHuDuaLJl+o5vxdywLySsNH
	 f+4r2lyx+nySTwSAD0jJ+wECb1jkxw5wqR4dnAbVkJaUwIvYe/2fXYJ9+tzIofYUP2
	 VlC71eVlJ92Wu2s0vJkFEl3xTluxNxdbVSofq8CFboQOajIOu4CsB1IlXdDl/fl9SJ
	 45cy2bB6OSJPw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4cCdNR3S1kz4w2Q;
	Fri, 29 Aug 2025 09:47:03 +1000 (AEST)
Date: Fri, 29 Aug 2025 09:47:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>, Johannes
 Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the iwlwifi tree
Message-ID: <20250829094702.06190e41@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dX1wuoFy/v.YmJZoHoIwDsH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dX1wuoFy/v.YmJZoHoIwDsH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the wireless tree as different commits
(but the same patches):

  fdd3773a24c3 ("wifi: iwlwifi: cfg: add back more lost PCI IDs")
  fd3f2b2d9355 ("wifi: iwlwifi: fix byte count table for old devices")
  2e426ca67ea3 ("wifi: iwlwifi: cfg: restore some 1000 series configs")

These are commits

  019f71a6760a ("wifi: iwlwifi: cfg: add back more lost PCI IDs")
  586e3cb33ba6 ("wifi: iwlwifi: fix byte count table for old devices")
  22e6bdb129ec ("wifi: iwlwifi: cfg: restore some 1000 series configs")

in the wireless tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/dX1wuoFy/v.YmJZoHoIwDsH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiw6nYACgkQAVBC80lX
0Gwhdgf9HgepI6GbVOb4cK7PVBcE692M/cNqh5/8PEfxs/6mniIF0xBuDQ9T6Yme
oecSh5ms8kxS6UikDMgKe/FpAT3xn5YxBu6czgc05iI+Fu9HhgdQpFMbye404/kS
XFfRDMPrLtjlzj+IYnbQcEzV2ftfld34SclQYbjz59WZK3r5FJH301gAPnAt2VDh
veHM6mVXhHt3wzDuxCVAhNTqw3iX1bqqOJ9BXmqvXV4EJWQChC3brIAYY/VkN4Q7
gvjl4y3afjpuZwRuWXjYAvwSGw8g7kjRcs0dS7Lq5bt3OZBnZlEdGiw2Pxtzfx0d
XC7VjOhW6zOgoPTtAwGfooNeueA/EA==
=WQ6c
-----END PGP SIGNATURE-----

--Sig_/dX1wuoFy/v.YmJZoHoIwDsH--

