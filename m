Return-Path: <linux-wireless+bounces-31896-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DcsfDQl3k2lc5gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31896-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 20:59:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE451475AE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 20:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472F2301A513
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AD62D949F;
	Mon, 16 Feb 2026 19:59:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71902D59FA
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771271940; cv=none; b=LBr0Mw2ZFBcCkCTIh2SGtMHYG1p6goZTeroE27H6RRIZ3EsJUqs1e8w6s660ErSrgm/Fw49GJy62nYcw+10n0RukKhAIiOOffbfGtI18rQgP3K3AoJfYy/pcKX8gLQtSwol6MQnjSLtK08h7/MvEp4ydYbPp0ofCXR+/ni0FmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771271940; c=relaxed/simple;
	bh=Lb77ePkw6aJosjAzHOI2ci2yeizqy8TDeuUttWkDq+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nqa1iX/HIx3kq8fOzoEhaHNoIXuInIW02psrsZ3pxYjVF1EtE5mBr9vRhxAJxuAMl/kEdl/H2+kko04r5F6uGGolr1n8j0lMTsRqsw+bemk43btqGWaw4vFtQ+na4NuSGzRhzh8NTlUC06hOIFpdyRnexmsh0FXrImsA0/uwDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vs4k5-001HC7-2d;
	Mon, 16 Feb 2026 19:58:48 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vs4k3-00000003Q0C-20nf;
	Mon, 16 Feb 2026 20:58:47 +0100
Date: Mon, 16 Feb 2026 20:58:47 +0100
From: Ben Hutchings <benh@debian.org>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: wireless-regdb: Fix regulatory.bin signing with new M2Crypto
Message-ID: <aZN29_ghakDPwhFG@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uNzBFFrzIRlQrca1"
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
	TAGGED_FROM(0.00)[bounces-31896-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 9DE451475AE
X-Rspamd-Action: no action


--uNzBFFrzIRlQrca1
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

--uNzBFFrzIRlQrca1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmTdvIACgkQ57/I7JWG
EQkZyA/9FkM2E1/bNCioIRzrNJn2krbNJADmYPYVC/VOVMUgaksQr9YTBmx8amMf
fsZlIP3vLH5OTNylhy4DowK4jgsoJrH8lexnE6qfjJ6PjfKKhmZpXn0tnb1JAcD2
owEDoFy5zaLhbsF+1zNXaxAgh288ZDo8OQbcpAr/KelPltvu0WcwVlT5QmM8PNT0
iFBb8OVbsZxVnQdMG6yax6q0OnzyrNDeZJvXnWJQwv0WfLHahO4Yhv29d1IfVZJ/
prWOQFjFZSi9k7exOYK5So35jlw0xKAsTE5Je4j6DD6kWNLfsXXDD5eelMWSF0T9
e7cFE3+oenS6YrMoxCTrbwSkIUaDBspGH8DE6jpQ5YgpsUgX2t2xuBpwBrMK1GKa
NokpapAHa91Lj8t4ZyqeXagVQlbIeSNgZNOC6NCvP3hJnPm/9fh6C1WD6WlUa7Ag
XtVh23sQUpbFxpD57R1vSRGoGN35OseW4c5L2i9dB9O9Gn90bCmGNWhx02G9C/QI
JE4lHrRidAAY+NVHn21wCymr+ucCyW/Q9WRTrAd+GzVgusGCJQfeyfg0vbDSHJQ1
Urq+yLBa82FAiElmf/aMPKru6lUfYrW2BT/rn3LfeTjQQZk+iFfGb3torxiPOGMY
HWimOkEmqUcKvIBsqPv8X5mUFrJeNwI0dMFBSFQqFH1gsqqXA9c=
=+UIr
-----END PGP SIGNATURE-----

--uNzBFFrzIRlQrca1--

