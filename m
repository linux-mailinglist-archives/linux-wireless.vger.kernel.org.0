Return-Path: <linux-wireless+bounces-13740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC7995C58
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6555C2865DA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFF6FB6;
	Wed,  9 Oct 2024 00:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cwjtu7tt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE152F29;
	Wed,  9 Oct 2024 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434295; cv=none; b=CEdiQR4Il3MMzQJ17VbmNY9hJ/JmloG1P4OeSEk8xuY1wWQTC0kiTsKQ/SbMJSspsNa09MoxmPdiZ0u5P6p9GertDWoazPGeo+xzqMN38jP49ky+y2qD83vmRZUBUus6pkqdUS3UvVkAxGMaehYvFcCVYZJLSvoduB7iopfEmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434295; c=relaxed/simple;
	bh=cFg1g/et9BU8Qj45SQLrUl9ATZqm04ySlBfiOZbGGjI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ivzp/Y6QHdHOVfTUelzFbUshEWkUKnUxCbKIuKUK0fs6+2jCEoedttAi3uTTa14TPT3TKhsdtRqO3vUkr6qVXGaSvcGh832P5lmGMKA4+nb9ZZTK7EBstozBb+QW+AnYwZOEotN2TnSIxaRx1eLw+TRS8+60wyEiUk9uGZpEjk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Cwjtu7tt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1728434291;
	bh=HDu01CeWqVR+Il/yZAdEBNfJ3edcScmEJNEt9NKBZL0=;
	h=Date:From:To:Cc:Subject:From;
	b=Cwjtu7ttC8W+wsOI7TI+P7wwn9DMbTZ/3CoJsCte/AiT4M+Zu7vy8QoV+W4bJa2UC
	 l6b15HEPJ21BE+ls7uTUH8LA3Tw0H422e0RgkuYN/YOGCQtDCuqOT6lSmavkCVs3sb
	 yazKt+fXwmjlpnhV/GDJX3C16eUFq4bJMEuGCCbZcbFR37+tbdGkuRU+L4DyZ4M1un
	 JbM/1F+mzBC/NqPjAMxzSKAezOjnhBJYbohkqZcCDUWL0+29hR+13NvLcIzrD/nsG8
	 56WxUw/eQOC4LY2BsQH0wNunucCcsfg7USWiLYaseEBGu1fwvpGL+96CYNZ3h6MAgx
	 HErPbEu8bcAWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XNYrz0J8Rz4wc1;
	Wed,  9 Oct 2024 11:38:11 +1100 (AEDT)
Date: Wed, 9 Oct 2024 11:38:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johannes Berg
 <johannes.berg@intel.com>, Wireless <linux-wireless@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Philipp Hortmann
 <philipp.g.hortmann@gmail.com>
Subject: linux-next: manual merge of the wireless-next tree with Linus' tree
Message-ID: <20241009113811.1e84de60@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rn0UiJTZ=aoPi81aK7YpV_t";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Rn0UiJTZ=aoPi81aK7YpV_t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  drivers/staging/ks7010/TODO

between commit:

  d93e795b8621 ("staging: ks7010: Remove unused driver")

from Linus' tree and commit:

  4991d2e7ad38 ("staging: don't recommend using lib80211")

from the wireless-next tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Rn0UiJTZ=aoPi81aK7YpV_t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcF0HMACgkQAVBC80lX
0GxnqQf6AoOvxR0AXUsgmbJqzWtGQrpNiqt/Puq0zzPOIwX8/B2OH/ycd7iCgW1z
l+lYAPxQmPror/1aggEMB9p4vrAWM/dLtkE29ZmKSJRhcqYsVzJ3V9draReXXwx5
XOs8CHj9qk22lUzkEj00yL2IEOiRrb6Uzy98T4R0RrbKI4pB85Jun3hrWvjs5oJR
Jkgq6s8yDmWdisDjjhFkswfjfx4FifW9EwutTF3TeU/iKK1A1acSSnQxzzN3geAK
3QjULXqhosc9NpGi5m+QNOxm4nQoikr/ZmeR9fGGMMbjy6965yio01dWdVPTdfyy
ESHl7mqU1dYEvoS85FFN8P6nqAnYyQ==
=7D4S
-----END PGP SIGNATURE-----

--Sig_/Rn0UiJTZ=aoPi81aK7YpV_t--

