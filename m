Return-Path: <linux-wireless+bounces-13749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE9995C9F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 03:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723B21F24F36
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 01:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC081A288;
	Wed,  9 Oct 2024 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HENBb+Tv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5218EA2;
	Wed,  9 Oct 2024 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435902; cv=none; b=U/TR2X9OMbmPJ/uenDOwf4i5JUgedELCwte6P/NazvqDAQy3mQs6R6l8HX/qR3IigT+2jLlJAx4TLdWOIjIf5d2iUwUC6E+nZxk+VaFsmi68hFYRMjvn8O3rVluB1PtexlWGt99yxzHkOpyWT4SEnwKQLvbf3hemxXYNGAdhzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435902; c=relaxed/simple;
	bh=81lkfRSXN90AHUj37kdA3eB/32XiUOUh/H1F66bbIaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H30tNm4CFMu19ctdB7RBgdNeC7yTHmUHsCey6yW+4rB8DIn94nExr+Ny/2QeY5/d5dJVB1Kr3VAMFwb5MaXbFzobQ3QxSdRoWfsIv065jJ/bkPPnaLjwfO/+DoZJPLCPo/oX2o4N7EcEGk9wRF5fwuaFasaNDBnvxoNPc442JzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=HENBb+Tv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1728435897;
	bh=tmJ2vN1V5w2qXUTPFlUceiygPAXDPWg0BrGys1co0LI=;
	h=Date:From:To:Cc:Subject:From;
	b=HENBb+TvyLM5kmBYblhg8eOou8/mTOqnfOgqDzsp8iEpN62uVvPaWrV44qdbMx/VJ
	 1nt1uaEcfBj0QswwpA6NDYPL62kedDfmb+2Vn3QqSV6sDUvo8dhLWe+26zJCfZ5kSE
	 Tnr7GWomK9bthe+sG/apP98hiG4rabc8OoTKla0lukAV7vLi5OEz0U5XuUxiQGDZV7
	 gyt/B+XC7S/o5Y7BPkmLaRRQ3/hDljt2So+nPnsEVwjFFHTnlG+Z8ESXOuT2QXmZB5
	 zLA0Z0cxkmvbflKz3IpXCM/gz1EIZ5+/ULfJSpcojxPlStMBCuLcWhudy649sBBiPb
	 ZBY2HUj2cg/3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XNZRr6Y5wz4wxm;
	Wed,  9 Oct 2024 12:04:56 +1100 (AEDT)
Date: Wed, 9 Oct 2024 12:04:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>, Wireless
 <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the wireless-next tree
Message-ID: <20241009120457.4bcebe8e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8QMFo0XJLd0E+cBFd3awETn";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8QMFo0XJLd0E+cBFd3awETn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "wireless_nlevent_flush" [net/wireless/cfg80211.ko] undefin=
ed!

Caused by commit

  aee809aaa2d1 ("wifi: cfg80211: unexport wireless_nlevent_flush()")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/8QMFo0XJLd0E+cBFd3awETn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcF1rkACgkQAVBC80lX
0GxdiQf7BmLXGNVrsjjCj9MbsIR+OIbkqD9M0DeJZ8lrobYGhsflDt3cR8tsObT4
CQWnZPmu/lNpbAfW7vx/uJwIDxjI5f5t1GTCXK/j5wK/ipVwZBRmBN1k8PnCO3y6
gAbSEKe/D/H3IdqMw7slCjxQW00/bX9klidyyJUomE0pZ/maIz4sytnn7iIvAfUf
wBeO6PgL0sQyrK4FPsGmgxm6iSuBMdR0CjeNjE0MmpBjhZxopH4/1aHtBJQUhZYI
+uo8Lic3nw4TnXAKyfAGiKImERDknVAtmBnYtE07ZPShVDEpKJu1bng3GPUI7s0H
B8gC9gjn4839gNQzfelXWLx+/7DP3Q==
=MNv/
-----END PGP SIGNATURE-----

--Sig_/8QMFo0XJLd0E+cBFd3awETn--

