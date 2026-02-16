Return-Path: <linux-wireless+bounces-31897-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sWDZAsB3k2lu5gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31897-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:02:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB21475B9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55580301A7E2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5930219A8A;
	Mon, 16 Feb 2026 20:02:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C38F48
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771272123; cv=none; b=tSpWRunBZ7LLLcbKXy0kXKtc/SSWvU1RRd/3QUNVwdYdgf1N3JKeMNmEpqSs17f8wCDuUr1k5MjI9ezF88wwE+oC6PHVAQwT0A51KitF7z8WBsZkRPbK0L1O3tzUSGoyk/fWxOKjEvi4VZSnUMFsCFuAjO1SPVUqHeFGGzD3pLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771272123; c=relaxed/simple;
	bh=+p803/pJtcoHOc2P9WyoDz2hN39uPvw3OcTrLbHMiTs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NsLSV9TL/ixrQaQdwyh+sb6xgLwDGeSKJrr3LUm0hI+IA8H4c0z1OC22z2eKdH6drm2dIk3qh6uSej0QBCz2vH2eLVMl4hR6jLhDtaq70L/WBZWEqQep2wQvWngOPQynvxZx1e/8VImCJksry1d5cLPTynkn8+8Ci1V4vDpMu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vs4nA-001HF4-0u;
	Mon, 16 Feb 2026 20:01:59 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vs4n8-00000003Q2e-2kMu;
	Mon, 16 Feb 2026 21:01:58 +0100
Date: Mon, 16 Feb 2026 21:01:58 +0100
From: Ben Hutchings <benh@debian.org>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Fix regulatory.bin signing with new M2Crypto
Message-ID: <aZN3thlmaiBxYVQQ@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5r5QcnSAucTjZbio"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31897-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 68BB21475B9
X-Rspamd-Action: no action


--5r5QcnSAucTjZbio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In M2Crypto version 0.45.1, the default hash algorithm for
M2Crypto.RSA.sign() changed from SHA-1 to SHA-256.  Since the
signature on regulatory.bin uses a SHA-1 hash, db2bin.py generates
invalid signatures for regulatory.bin if a recent version of M2Crypto
is installed.

I reported this incompatible change as
<https://todo.sr.ht/~mcepl/m2crypto/389>.

There is an obvious workaround, which is to add an explicit
algo=3D'sha1' parameter.  This works with old and new versions of
M2Crypto.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
Re-sending this with the [PATCH] prefix.

Ben.

--- a/db2bin.py
+++ b/db2bin.py
@@ -131,13 +131,13 @@ if len(sys.argv) > 3:
     key =3D RSA.load_key(sys.argv[3])
     hash =3D hashlib.sha1()
     hash.update(output.getvalue())
-    sig =3D key.sign(hash.digest())
+    sig =3D key.sign(hash.digest(), algo=3D'sha1')
     # write it to file
     siglen.set(len(sig))
     # sign again
     hash =3D hashlib.sha1()
     hash.update(output.getvalue())
-    sig =3D key.sign(hash.digest())
+    sig =3D key.sign(hash.digest(), algo=3D'sha1')
=20
     output.write(sig)
 else:

--5r5QcnSAucTjZbio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmTd7YACgkQ57/I7JWG
EQniPA//dMMMws8QwuObClbXfPCje2N15jnPK9yl7uX6gDzjhiXiBiy1sUUSFewv
hNBoPa5IRl7SkT/3X6xCmQJNKx0hxS4pekzPIn2Kzd1OrktSCQHtqV5qpnW7FG74
ACWULiu3bXT5Cmh5euItHSWO0154XytXKhON7YM8jkkZfzormDycOHlON50syGyF
/YCJv19w3feZ5TNXW5PwUtjDSh5DNCSSCmvVqxQgEUQ+uDLFftmibnCcRqMKFa+p
dPlyxAngH0vS5f3LZMrxwXzS9IXGXidlK6mfaa1NVVH6IHniyWFje5JokYiKexRA
U9s+Zeyxr+RFwi++so5L1JXe5moq72KLsuTBipqkATsC/qmYN89Sk3/A1CjxUgD5
yVArwWk+CtMd3u/01UZDC+OLLdbN2jQ0YHx19ErQ9WDxeDYAC2V3RUMAq1gnoIim
94IeV0mDFR3pBb5VWZ4i1m/wvtdjH8GZiKIFKTUyin0nT8xWEeGBoDGmc9GJOdc2
1LLX5gOGbXXc4nuW6SJK4ffqp8WqbzAL1hWalialc1P3taYgNi+ft6NL+zs8Drvz
Ie3NIwtCrRzL3X77QT2mCG+rpMaZWSnlyZgX+cQzA2FF4MHJn9X5QXhZnV6ZnB3t
hf4T4Z8AVRzg5+QkeF3LauxG5O9osX9XdUCbJ29Kf55SjSTgRqI=
=BLpy
-----END PGP SIGNATURE-----

--5r5QcnSAucTjZbio--

