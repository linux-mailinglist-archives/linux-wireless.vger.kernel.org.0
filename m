Return-Path: <linux-wireless+bounces-8334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFDE8D58B0
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 04:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A74A1C23137
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 02:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB978283;
	Fri, 31 May 2024 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N4jFDKVy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A992594;
	Fri, 31 May 2024 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123462; cv=none; b=Lhhwm60TnHKSyoW7ddo9KunSy5F7Hcuf12uJWooB9I+NY36DZoG1mjJ7ff0h6I5ovGJZxjrtTAMQzavIznujUeje4l3veDGnR8iaELpf33Fr5jP61e8kBMhvWg1Dslg2dIcd02dBVhB3Z5dcbTZU46kyWpjNVdDjavV4+7tmsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123462; c=relaxed/simple;
	bh=l8VmNTJPiwZqWIgn2cv7NUGYgElm1KcKVT861XhvKiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qLO/6PhQz+WIqwtr3sHBX1QUPKGxY0QRdrPRUgKAJH4/GK5mRRzKlcp6volvPWP8XR8OJydMi775K3+JXrN1bepE0gd+FseJ06fW6GIt9qpIkO3seglytql6urRe0iyGWNxOw3peItqMo7v+0N+Q7Xo0bc0Bw8IMqtqnP5qI9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=N4jFDKVy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1717123457;
	bh=aR1yvLQuxElZ8NfNhoJ1MpMwxcPJ8QdRDR6NUS+hnpc=;
	h=Date:From:To:Cc:Subject:From;
	b=N4jFDKVyLSZHrLRrADOLG0gsliB9bhohmu8bhYIcjK3hxQjv4lJkHow1hf0jEGGl6
	 J/o3cnh8liaDPpdL5Kch54YnQO2tFYABQgEzNok0smdbAbcTWjoA6i/r8jcakHsR5x
	 32cSnp0TOTWpDo8smJKQMG6oavl7XRX6eGN1UIw8zDbsLGUg+hP7Gh347RAMDt3Nyp
	 fXTCB+TS5Ewh1WrdMzIHjfh/ta5ErCKCo1FiQYlv0GzwvjO40Nrrb+I/UqnvNStrke
	 P4DQB1wdj0celiCKxl4luPe6HMXUcl2L7e4dtP3/y/dYqdkv/gng1+2NVOnrvip9ew
	 mmJRffCFRGzSg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vr6rw0jjwz4x2v;
	Fri, 31 May 2024 12:44:16 +1000 (AEST)
Date: Fri, 31 May 2024 12:44:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Wireless <linux-wireless@vger.kernel.org>, Aditya Kumar Singh
 <quic_adisi@quicinc.com>, Johannes Berg <johannes.berg@intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20240531124415.05b25e7a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e8WJ.=ctS7b1q7BH3npLeZH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/e8WJ.=ctS7b1q7BH3npLeZH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  net/mac80211/cfg.c

between commit:

  8ecc4d7a7cd3 ("wifi: mac80211: pass proper link id for channel switch sta=
rted notification")

from the wireless tree and commit:

  344d18cec231 ("wifi: mac80211: collect some CSA data into sub-structs")

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
index 83ad6c9709fe,62119e957cd8..000000000000
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@@ -4028,7 -4028,7 +4029,7 @@@ __ieee80211_channel_switch(struct wiph
  	}
 =20
  	cfg80211_ch_switch_started_notify(sdata->dev,
- 					  &link_data->csa_chanreq.oper, link_id,
 -					  &link_data->csa.chanreq.oper, 0,
++					  &link_data->csa.chanreq.oper, link_id,
  					  params->count, params->block_tx);
 =20
  	if (changed) {

--Sig_/e8WJ.=ctS7b1q7BH3npLeZH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZZOX8ACgkQAVBC80lX
0GyP5gf7BCjJnkS0kwsZ+SARJZQmoABPkxmaBd/FTavGeL48R7KDEXrnaVnyb7+S
Kgv6+hE9NtRw8hln1NxKWHrGhj6ded7WCpBpzSk9XUmeDjtLKWauYRLzW8rWsbw1
aVwJG5EwktUgJtuviRVMLXhDLuTjV69KMvn/0ggoCZTcPt8AXH2uDZbO4TEnPw+i
NHKGB2ghbL1cQpiX9I6OPffqTnRtPACP3Jivzz0PEb8rrSO3i3y/HbgtcbMBM7DM
BWdiFvNml2uCbfoqp1oEsbYyeVYP+5pBnenl8snMAHdcVe84dUSVmdrhRFIC0enu
d4JoHiE0uDqh5NJ1wOPNo3FVbSbB2Q==
=WfFO
-----END PGP SIGNATURE-----

--Sig_/e8WJ.=ctS7b1q7BH3npLeZH--

