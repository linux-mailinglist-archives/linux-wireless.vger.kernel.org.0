Return-Path: <linux-wireless+bounces-31898-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKwLEh14k2lu5gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31898-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:03:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A941475D9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 489CC3007BAB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BCEEED8;
	Mon, 16 Feb 2026 20:03:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074948F48
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771272219; cv=none; b=QjM+xiR6x+uLeBlH/BtvgkIPUVPVQsG39te0fhnrvGITG3PNmCvGxgVkRVwKL+ljBgzveMr/TQbgHwvi3LiXBUhWg67yaaTQ9TahY/3Hpg3Uuunz/J5LlsHGhVdysSh/qmwDrCcm8ZKBg0wrMbFMhhx8g4iDgSWwyQR0Iq2VVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771272219; c=relaxed/simple;
	bh=BnA3qFKjyrc40tFGBfjJwSgz0HfYZv/g/oDGXheIoWI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nynDBx7RhtAw10Ynmx2bHiqkRhWTFeF6mhbdrifrot6V4/0aCg5W7pGhAHp+9FFLpxibsNHqNtWSVRxu0n2je2+F8r4J8PDH3rmgOZu9GVh3sTIXqsf2coM9FCHc+z492FsmcD+02yYiXvSJkwLLlAc0EdrLQZtvQnLOoK2CD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vs4oi-001HFy-2P;
	Mon, 16 Feb 2026 20:03:35 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vs4og-00000003Q4u-0o50;
	Mon, 16 Feb 2026 21:03:34 +0100
Date: Mon, 16 Feb 2026 21:03:34 +0100
From: Ben Hutchings <benh@debian.org>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Replace M2Crypto with cryptography package
Message-ID: <aZN4FltUUWKUh6rp@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+uwxLKIdrtAFiZHR"
Content-Disposition: inline
In-Reply-To: <aZN3thlmaiBxYVQQ@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31898-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: D9A941475D9
X-Rspamd-Action: no action


--+uwxLKIdrtAFiZHR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

M2Crypto is deprecated by its maintainers in favour of the
cryptography package.  Update db2bin.py to use that for signing
regulatory.bin.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
This applies on top of the preceding fix for M2Crypto usage, but I can
squash them together if it's preferable to switch directly to
cryptography.

Ben.

--- a/db2bin.py
+++ b/db2bin.py
@@ -2,7 +2,6 @@
=20
 from io import BytesIO, open
 import struct
-import hashlib
 from dbparse import DBParser
 import sys
=20
@@ -125,19 +124,18 @@ if len(sys.argv) > 3:
     # Load RSA only now so people can use this script
     # without having those libraries installed to verify
     # their SQL changes
-    from M2Crypto import RSA
+    from cryptography.hazmat.primitives import hashes, serialization
+    from cryptography.hazmat.primitives.asymmetric import padding
=20
     # determine signature length
-    key =3D RSA.load_key(sys.argv[3])
-    hash =3D hashlib.sha1()
-    hash.update(output.getvalue())
-    sig =3D key.sign(hash.digest(), algo=3D'sha1')
+    with open(sys.argv[3], 'rb') as key_file:
+        key =3D serialization.load_pem_private_key(key_file.read(),
+                                                 password=3DNone)
+    sig =3D key.sign(output.getvalue(), padding.PKCS1v15(), hashes.SHA1())
     # write it to file
     siglen.set(len(sig))
     # sign again
-    hash =3D hashlib.sha1()
-    hash.update(output.getvalue())
-    sig =3D key.sign(hash.digest(), algo=3D'sha1')
+    sig =3D key.sign(output.getvalue(), padding.PKCS1v15(), hashes.SHA1())
=20
     output.write(sig)
 else:

--+uwxLKIdrtAFiZHR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmTeBYACgkQ57/I7JWG
EQmwUBAAsQYVWUgDmqv3A71GUQEC4GfToWFarALWU/0yTAVYeymowHPG6L+qR+Xo
sagMGKQS2dX65eVlk2ICVe8QW+dbApBPI/QjgXPW7rdP1I8BmT90x46NyG7IeQQV
ua0BruwReSyvD4RqsxRFo2gZ51OYJ7hcIqvYV3YgZ9jMWok0zHEa+uWo2Um8LDdS
A0iIdXDXob/bzcHOVTYgb21mrVXJBzOzQv4bmoxy0uO7CGgj7gOfchZblktRKym6
N6IMMBfvGxSjWsJokCVW/KnjNDbzTfr90lKoeSLYsY+6eVbNf+iclBP8VIkjkipI
eF5XIoL1wA+bAKfE7S+qVMdX73To+PQJOk+JOPau6y0tikhUzY83QM/IvvipPYjC
NDWivoZKcWWUJBXCmm+x4k6E3sY6G9lHD1mBGsWOwLetK1CYdjrDd664lnN6Z2Io
IMJ1iMG0fpanI/gIuo/rTcr/h17Qa9Qn50Vw4/EaU8u25kCixK+J+fzrPXdefudQ
EXY/DKJAId0oa5jIS0QBCWy5PU+kDJK8cZuWP2KyWvvsZZXeUO3j5o8B/a67WEso
aucCvVkC9s7KzQq9CVJJsXiWEHOUhT97yOAejYwZEdeZQHv+9iGHe1PNRU8PyVgE
KPkbZRAlA52VSfovUS/7ixM7LAUODieDiDSFtlkXN80GPPkAxbQ=
=MGXt
-----END PGP SIGNATURE-----

--+uwxLKIdrtAFiZHR--

