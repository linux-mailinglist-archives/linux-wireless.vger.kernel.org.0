Return-Path: <linux-wireless+bounces-25968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8D0B0FE6A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 03:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961901C88596
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 01:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3094315F;
	Thu, 24 Jul 2025 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LDuaODLg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2C322A;
	Thu, 24 Jul 2025 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321572; cv=none; b=LrM9kJcORHmK8W5Ow0H32pUgVY/oCFnyUmNSzHoffLPI998+9GBYnrXH+Ydz2LnAwNAPvInn92uNWg1PmQXOiH/fbuthPvnK8yAJh3WQ/2voesx/qjmTNDrMRN/mosDgb0G6NpkVVvlmnm36iokkpGpNafiu7vjGX2rzW8vBqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321572; c=relaxed/simple;
	bh=jsYUxgEAO69vk9BPS/HTeZcBQgr2lvQnpyVORNVQFQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=d6v9+llR6etWf7N/xLFa/tamutIgYc0SHVwsH2DpT6PgVxkQI+BwBVkk4FQQNGDXEKqM17n8cMfA0/NzjWwfyifnSP0fzD0czD+z9h2TIX81gGZCrqhBUwdMkpRP278lELbk/1C9RJl9y0wmcLjftrd3IThyF9hAT0WzMVfIMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LDuaODLg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1753321386;
	bh=XgWpHiyMuqv0YlpcHsAmRkj1uS26KWifRjpZ5SuTk0g=;
	h=Date:From:To:Cc:Subject:From;
	b=LDuaODLgJjdJ+7wgX0vAJvuFem0HVqcvMYX+5IsQndVgnQWtJ+DllUdaCtbTw0PdI
	 lTcH75kWKuAgvVRuBfCV0s1uY95UcrpRLMCKnL4VlKVhsTNQS1FZ92NHi8lIuC99/o
	 X8gYqsosmr43SPuOf8r43aYympQ7VAPuRxBqWp5gNk4TDSZhPYs9pYoEfiVf4KIQZu
	 zl+IdMDqWVtZldbXMmsJsL+P/J2gru+2rVak6K7FmOHTl7XyiUbKNvA+FCuo8thCHN
	 i2yxlpI36bJTh4UusE1NYsbcPXDm2igud1Ij7eaBvqQ/qJZ/4QHlGpy+6gdz3jtQos
	 BbjKazWkTL+uw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bnYfx4bHPz4x3p;
	Thu, 24 Jul 2025 11:43:05 +1000 (AEST)
Date: Thu, 24 Jul 2025 11:45:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Berg <johannes@sipsolutions.net>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the wireless-next tree
Message-ID: <20250724114555.2894a009@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//cR9IByZinQTBaUlQdfNpna";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//cR9IByZinQTBaUlQdfNpna
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm-nonmm-unstable tree as a different
commit (but the same patch):

  6d0a67c600a6 ("wifi: brcmfmac: Fix typo "notifer"")

This is commit

  e84da36528f1 ("wifi: brcmfmac: fix typo "notifer"")

in the mm-nonmm-unstable tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//cR9IByZinQTBaUlQdfNpna
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiBkFMACgkQAVBC80lX
0Gwd3wf+J62BljLLJYBR6//R1C3J3TkbEz6Vo7Iz26S4jcRh0CFu1WsSXcx6y9uG
Spqe5FcgZZ/4+bJsQx6CTpJVNIBZwlOtiw+xMro2ZlFObKS6Wl6a9z38jQhUyVaI
zER1QYOkE6sVXEevws/evt/cCUErkRjJXRnYzfG4xah/XSlruutECoc1d98mDJzo
wU+qCEsLA2kF7mewb6Z8Epa95xnJkPyLCCG1XV0mvBpfc/bz+gnzhPQ80pwDwZuK
bmLi/leEqH2gMsM3Je08gRqddGgmYpGjwe9M2AJS/cXV45nV/wJTWCSiIq79FxcV
s2obcApfierqghAXR28Yl8CYNIBZfQ==
=M457
-----END PGP SIGNATURE-----

--Sig_//cR9IByZinQTBaUlQdfNpna--

