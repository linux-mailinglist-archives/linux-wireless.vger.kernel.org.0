Return-Path: <linux-wireless+bounces-14579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015649B2209
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 02:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C31C211B7
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 01:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649412D21F;
	Mon, 28 Oct 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nPflL088"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4813B224CF;
	Mon, 28 Oct 2024 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730079389; cv=none; b=jWchw//iTKgYjxF+hvAeXzDdpJq4uIn6It0jaAxcg0MCuu43QnhghoNXktVkLR5bzYLY0G9SoRc/c18BpaddOK9fyAN7OcmxITVpP4iKMF4AcYYuDa3UqgD8pPWZK+q0a9eGLesmc9Z36X/vhCNtokEdNlkNVm1rcXym6bfTEGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730079389; c=relaxed/simple;
	bh=+KrAns4xIBfzJw7NrI3Donel4hn3Q1zrO7mZ8DL6Wv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AaXi7dk1zUAGnRSemssXGU6yRN54e2rc1U0/CEWCd/dj24oX/KietJIupgBDjDGNn0b+wQDWVcS0yIAuA2w9oxToP/0qIHfdmFTsoxyQqJVZq/GE/5K5VZ8qUHTIeYsX0h1E5/nu7Y7HAF+X2/1IC69EfeT2e278kk9p65fiOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nPflL088; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1730079381;
	bh=QOuhX/m/QddUiZqHv1JFNw12OPqKfkMdMknoJzsL0K4=;
	h=Date:From:To:Cc:Subject:From;
	b=nPflL088nzcrP0E4zxz7DgBkWJ67hQi9y7prnjzUy48bQ4GLO1JvUw4Gn2trvBkMz
	 HB7c3pXkOdhvhXkPmhAoS64AkwyqgyiY+IJniiA92L/RzKF06wA/IwihNBzRx4ht5H
	 fwTnKI74G/Qn6Rkg98Wb3myVmduy0+6Lq0ZB2uCrd+cOKyx7IYoTeOO6cAEkKMCnwg
	 p/Eo34EeBrpKJsw/dJGYDHgMBav4Xr4VYewQs/15novyu+OnidRMhi+h7ut9gAGgFo
	 3ROpImDhjN+8kSqLQJea8yfv2qjINPDFEWHKdeVdT5Qyv4K9I5fTDFRo2RbvOYMSnB
	 x5CiHEaerA1YA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XcGFJ6gbPz4x33;
	Mon, 28 Oct 2024 12:36:20 +1100 (AEDT)
Date: Mon, 28 Oct 2024 12:36:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Aditya Kumar Singh
 <quic_adisi@quicinc.com>, Johannes Berg <johannes.berg@intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20241028123621.7bbb131b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vLVLwzF/.QjQFiv7WdNs8ax";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vLVLwzF/.QjQFiv7WdNs8ax
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c

between commit:

  cbe84e9ad5e2 ("wifi: iwlwifi: mvm: really send iwl_txpower_constraints_cm=
d")

from the wireless tree and commit:

  188a1bf89432 ("wifi: mac80211: re-order assigning channel in activate lin=
ks")

from the wireless-next tree.

I fixed it up (the latter removed some code that the former moved some
other cde around - so I effectively just used the latter) and can carry
the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/vLVLwzF/.QjQFiv7WdNs8ax
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmce6pUACgkQAVBC80lX
0GxOfwgAhnaf9Qw2v3UgVoKxvr5yrEBNnGy5Rcl5VkjdwKyV9LfUeQ8EGg+UoFx9
cDq+WKknVz9UNbLwpnx2gD0q9P0ziWty6+oF0DpBs46LB7IUZJE15Q5UOd/QCjcG
tt9DYl+OzngirhQtvS1j4afkwQBJhYZJuWKCr/5pqWe/8Fg1rzSed2XPy15D0p2a
payMjQQwueMx7UIB5VKI3WOTwO8Qzlhs4d9bIOaHw55LP+XvK9/tHhCVOkGDw2cA
gsK9RSWUHkhu2tVdsjMxNQ8uc62eEdjRRCzKr5t3luz3KG9TzJAAlYmuyEtxLBA5
cZ+bbrLLIgzGnXXjI2mZCIC9/nKo1w==
=xmpr
-----END PGP SIGNATURE-----

--Sig_/vLVLwzF/.QjQFiv7WdNs8ax--

