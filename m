Return-Path: <linux-wireless+bounces-14440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CFF9AD90B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 02:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF8D1C2193E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 00:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10F5223;
	Thu, 24 Oct 2024 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J+KR9HM4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B81BC41;
	Thu, 24 Oct 2024 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731330; cv=none; b=XhmL3PCZDgJ3/IJdwBRok1DMj8P+fMM2WCU9Ujpaf6c6FmUqxAGDHaC5FmBDpIq32VKe2Kgzw7Qwu37Baz8/GxpAWip+2uy36eBzr/1cnuQ0pJQvFkrkiecQB2C55DPrqIlluXP6bn8OK7g7jZWrfDhbhVdM0e7fyFl7L6rbY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731330; c=relaxed/simple;
	bh=ve7awyesf+L2FQP5aITjBG5N/MbRQhV2+bWQg/HIrv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EjX6UjXuV/Lx8sxPrJpgn36AJRWtdnnW7Ic2ciJUDL/WzXn4K/c/imr/azaN0jWk9QTKOOU/UB2WyA65pbnCykGJTbnq4R02llbZ1QutDHJbSncqSeMxb6uByhWvXUv5/7a7KXrZlEegiv5WnPCXHBfjqQOStsOqZRXQ/qPiZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=J+KR9HM4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1729731323;
	bh=INF+v9OTMCWoYD6UjquXwU45gu5BOm53e7zA3Gi0bMs=;
	h=Date:From:To:Cc:Subject:From;
	b=J+KR9HM4l9G9vfJHh16cm82r+SpBc9Y7wer5O8GrQwIoP6qE/12iiB1lP//H9yeS/
	 xUsQf2fjWQd1htwTquciIwp7xtL1HyC77PxTMIKWooZcfzMSifGjCfDMRcQCw92Qjb
	 2J94IXVOknnBDBQ/NO1TZyEeW5xoRw+TXJOxSddHMsgfXzgCwcRvaBARZr+TQUAwKl
	 z2NAm5YhV7RSm6CkDffxtOBVF4jqj5Cs0EYX23qezETt/G1+UcBUNkTgJHZrHBo01u
	 6Ke2cKV4a18Hd+whwVWAsw//Bu3MJByclkswVof7XVlMrkBcnZx+H311eAcHBIf4Hq
	 KdBSEvSaS+AsQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XYnWt5xmYz4w2R;
	Thu, 24 Oct 2024 11:55:22 +1100 (AEDT)
Date: Thu, 24 Oct 2024 11:55:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Ben Greear <greearb@candelatech.com>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, Johannes Berg <johannes.berg@intel.com>,
 Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20241024115523.4cd35dde@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wRwc9EsvMoDoJdweKTHRfR=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/wRwc9EsvMoDoJdweKTHRfR=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  net/mac80211/cfg.c

between commit:

  8dd0498983ee ("wifi: mac80211: Fix setting txpower with emulate_chanctx")

from the wireless tree and commit:

  c4382d5ca1af ("wifi: mac80211: update the right link for tx power")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/mac80211/cfg.c
index 6dfc61a9acd4,6c0b228523cb..000000000000
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@@ -3046,7 -3070,7 +3070,8 @@@ static int ieee80211_set_tx_power(struc
  	enum nl80211_tx_power_setting txp_type =3D type;
  	bool update_txp_type =3D false;
  	bool has_monitor =3D false;
 +	int old_power =3D local->user_power_level;
+ 	int user_power_level;
 =20
  	lockdep_assert_wiphy(local->hw.wiphy);
 =20

--Sig_/wRwc9EsvMoDoJdweKTHRfR=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcZmvsACgkQAVBC80lX
0GyWEAf/WYW2gIK9rSU6Os4+LTBytJGSrY21OVGZNc7sogfQ+Of3UMxc1wxaQ/Jx
XNnf5Uuhi6fe/BgsGbF3nHstkHgXtioHSwfAhfgg/ecuFdT4e2z79JWZhFnaCpnK
WTWw32T8Cnqm7lP2/bUYTB2jxiX53FmYYEYEFNh0Oxen+GoC8tMtdexfGn7eE5X1
bMjwRHvTFYdyHJq7VZ7Qwt9JEasm1KEVv/Oo/Uh/f5DS2QJAuljV+SzkVfxJGU3X
EixNuaIZuCLEgbzmjp78pOQw+lDiu2q2xaYoDjAvgn+yHd/7zncSoaIgvTAzAkx5
uvQhVmznkMpSHdj+oTzwt9pdeadq3g==
=cioX
-----END PGP SIGNATURE-----

--Sig_/wRwc9EsvMoDoJdweKTHRfR=--

