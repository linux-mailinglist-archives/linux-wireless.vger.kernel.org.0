Return-Path: <linux-wireless+bounces-25506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D287B06C79
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 05:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE921C2063C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06882211A35;
	Wed, 16 Jul 2025 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lLOt6Lkw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54085260;
	Wed, 16 Jul 2025 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637985; cv=none; b=J+yVXFMPeaF5kdtEqQALuYuc7SeQraZEgtaKSja60u63YYwAyiM7emU1Ew4uMBD7wT+Et6iBxdUKLj/NvlJvELJZKGvUMy6YyzZIxTY+2/XY7yRJjjEZIT+dY/L7CAbzuCOfFEnW4ioN2aWsDP4CIFzmdZwNjg31U8HlYuM5MGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637985; c=relaxed/simple;
	bh=wKviDJaUhwcPeyyBJley7NJLnHl6b9lnkgrlqJufIew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eeryFKaQVnQNy7Xl495bRyh6OeIdRRRMZQkE+nT4seodV3iyE6j1/wMNbHNx6lpekPuH7nOfTocgUU9rm+Q+crMm3F9A5OOU4BDb4pg546RVv6LummyV71u9GvYM7CXgkEVHjrppl5GzAKZWNsaTKbk9qIsHAthvhzjWi8uHtBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lLOt6Lkw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1752637859;
	bh=Ub4h9md7p7jPwt4hSAWgAYYr57hqxFEi68rIRktKU4w=;
	h=Date:From:To:Cc:Subject:From;
	b=lLOt6LkwLgwFa8cGbCdzIP4SepTRG8tTi8Is46bcQ6yVzkUJdoRYsvb1bby5a8pIC
	 da+wgMatZQn0wCKfYfeURhigHaDrRQ3XgxutXqiSP7U4HkzjLJIY3/tE7WLG5pdykI
	 ebu/E3scy3oOgPAHtgGrojjg54O9wIPrL3oan3j83WACVhFiETKO61CUGQWsBvJAqg
	 +DJTgKugdw7QUtB+SGsvqCtzqLEhOXe6CH/6PjtGBa5H+gs9aSIGAdvxZ8/0JBDkZA
	 CsJhun1LpjzOZRS7rkqLQ1aPuBtIH6Frm/HF8upPk4dPLNFqYHUGE+Uh7hvq572k4p
	 0DxX0FEE33vCA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bhhtB401yz4w2Q;
	Wed, 16 Jul 2025 13:50:58 +1000 (AEST)
Date: Wed, 16 Jul 2025 13:52:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Pagadala Yesu Anjaneyulu
 <pagadala.yesu.anjaneyulu@intel.com>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20250716135252.51125baa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qWN88ZmnacKbcZLOTiM6ycI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qWN88ZmnacKbcZLOTiM6ycI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got conflicts in:

  drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
  drivers/net/wireless/intel/iwlwifi/mld/regulatory.c

between commit:

  5fde0fcbd760 ("wifi: iwlwifi: mask reserved bits in chan_state_active_bit=
map")

from the wireless tree and commit:

  ea045a0de3b9 ("wifi: iwlwifi: add support for accepting raw DSM tables by=
 firmware")

from the wireless-next tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/qWN88ZmnacKbcZLOTiM6ycI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmh3IhQACgkQAVBC80lX
0GwLVwf8CQdLbg6guGTW4brIedUGd6PhjLkj+0rD33A9mEMi2xAw6y+GATY5APG2
8tMx/XyWDdIQtdu1ELMxNLxxWfETqdchlDOai8oWgPi/MEQOkWYL95tlB4C15v6b
i2lAgz5eP/TN/Eub9a5ebnOPyuVHybn0XR194yyraGcu3jkFHoFJ27SuXHFq8WgN
f0KXvfcWlSas0PIcfPLli4QZb0BVbtlNGUCuZxNBXluun7FNM/LzK8U7sWjMhkW3
pN7ze8YIuYBMrC+oJW6lxdW6RkPI+pJe9e1JxFfNixyu9pSZVIyEkY7pVr2cTpaT
E9DwUMpdey/bEt3ZMV9ZLxvCozv5HQ==
=jwVi
-----END PGP SIGNATURE-----

--Sig_/qWN88ZmnacKbcZLOTiM6ycI--

