Return-Path: <linux-wireless+bounces-20203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF32A5D484
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 03:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BD03B49BA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 02:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68518D643;
	Wed, 12 Mar 2025 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jHvZ/WIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5B7E107;
	Wed, 12 Mar 2025 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747993; cv=none; b=djFkl1pcfwRc2yXCa166xLehOwDbyWRa1TGbf0qvtZb48Tqiwwxn16jE6KWYhHAeK8PKRE3wwnUOz14YQ8GA4VL8hik1mCJVJThC7cvgIjnqDQJbyy28yToq/5c7o4RJDmtz3e/LzRLraE3qTh1FrySKBhGi/sVH1ScKr0YMxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747993; c=relaxed/simple;
	bh=mGmp/6rLQXNQ7sV5BTurEpkMGQe9WfCi9GE2Knd3SNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Lwfq1cBBgCm2XRG3nM7D1WS0ny1LNvSzoc8Td4g1Z1+EkIqAs7ZvJ0e8RHkydCrpA4xwseeKtlEjl9VHzZsc3EAtzXI8YldWpf722QklZm5fesN1ev7r8L9n60KFD1oQbJtNg2W+O4j89HYgfZw+XETNXSCQbb8OresG9NeS1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jHvZ/WIX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1741747987;
	bh=ocD8+DIcFrFjovCogZxWvHcJ/XR+gJFJJkV27YdINP4=;
	h=Date:From:To:Cc:Subject:From;
	b=jHvZ/WIXI1d7OSUuwkGPxzvetRINzrGfSbTNRXaTijUEirV9NEzoNCLcKu8gxQBDz
	 xVf7kvBTV+GMykJjGZTQVYUzx+YMm424he6aLKKvhNrrDhwanPA2JZeNeb6hT6U4ND
	 QrsNOtFYPIUMiCrJwyzIdpnE1f1jydWRyFMtsrFxJhOw3U4XrdWwdtcs8dFF4+1Liv
	 0NNaPh8/SWJ/D/QjOxtq6h61bvEeHetWlQBCNt2sW9MttU4T5K7P9oD8gvEO5YZwjK
	 kThja3vO2UazkFq4awpxtmkLEsEJAbXSio8u9FWCvoVlCUVfzXjyIQoRrz++vy5PX7
	 VRGicuy6orZlQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZCFYZ6tn9z4wgp;
	Wed, 12 Mar 2025 13:53:06 +1100 (AEDT)
Date: Wed, 12 Mar 2025 13:53:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>, Wireless
 <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Subject: linux-next: manual merge of the wireless-next tree with Linus' and
 the wireless trees
Message-ID: <20250312135306.2cd270b3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CODNmu9F1CFzIxmj5c1pl7o";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CODNmu9F1CFzIxmj5c1pl7o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  net/wireless/nl80211.c

between commits:

  1f860eb4cdda ("wifi: nl80211: disable multi-link reconfiguration")

from Linus' tree and

  2e85829ac7fb ("wifi: nl80211: fix assoc link handling")

from the wireless tree and commits:

  a096a8602f4f ("wifi: cfg80211: move link reconfig parameters into a struc=
t")
  969241371f06 ("wifi: cfg80211: allow setting extended MLD capa/ops")

from the wireless-next tree.

I fixed it up (see below and I used the latter for the later hunk) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/wireless/nl80211.c
index 34c0dfeeb7fc,aee49d43cf86..000000000000
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@@ -16512,10 -16518,7 +16524,10 @@@ static int nl80211_assoc_ml_reconf(stru
 =20
  	add_links =3D 0;
  	if (info->attrs[NL80211_ATTR_MLO_LINKS]) {
- 		err =3D nl80211_process_links(rdev, links,
 -		err =3D nl80211_process_links(rdev, req.add_links, NULL, 0, info);
++		err =3D nl80211_process_links(rdev, req.add_links,
 +					    /* mark as MLO, but not assoc */
 +					    IEEE80211_MLD_MAX_NUM_LINKS,
 +					    NULL, 0, info);
  		if (err)
  			return err;
 =20

--Sig_/CODNmu9F1CFzIxmj5c1pl7o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfQ9xIACgkQAVBC80lX
0GwhVwf/WeQFTELYbJ3He6NlIHLV6eD/IsbKmQiY5CMKHzY2tjMwfrjE4ll5EUyr
3GKAd64sdd1d9MdqYP83GYmNnJfwd2cM0yXSPJzTcB3tn/ufqbUsFydD+qrK7i0K
q+EnvL0K8L/GiO3CLPInIQfTUtfSRq8Q3YOUbxkS1oauw7INuhzpuhaxOvhDMH4j
+dml7bRPkIKyUsv53zpaBcgI5FKp/U63fgB3sNHU9bBXhVE7r1zdQikacjhmFO3k
RMhDKv2ZoLSVSIHLM1MXJCGQucfINuzWlsyzoElRGOmXZlq6ySWxGdvyya5NPAKf
btXMM/+KWrotydtYo2XyThqTD6jE6Q==
=3IZd
-----END PGP SIGNATURE-----

--Sig_/CODNmu9F1CFzIxmj5c1pl7o--

