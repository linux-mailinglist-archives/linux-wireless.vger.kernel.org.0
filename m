Return-Path: <linux-wireless+bounces-31150-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DlpEpSKdmkxRwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31150-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 22:26:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3982802
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 22:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7DE830038DB
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413883009E4;
	Sun, 25 Jan 2026 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Tjq6YAup"
X-Original-To: linux-wireless@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59273009C3
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376401; cv=none; b=liTKrbihAdlSGJ+7xPFNla0CzBKz7eL9dqF1Zhgj00NvieKyjMlLqipoAehIr/S2a/QSLGuwsTmwvTUNhnrRSUd5dO2Gf3MadI8cPSslqWT8mhi1bIaH73FG5lRSPCKwBM/fkx87/gPnLWSUX3nDTaMb2ZEoW5FIGNyuYR2z1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376401; c=relaxed/simple;
	bh=L21VCTs4TYrfq9uWHSVd8CZVtv3K2D+ZFKCCaf4FEuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLDVB+n9cIHIcy2flyjQKmgdTv7GHx7IaeMrdUZAkXmgJ09ezrDo8QGzxDEi+NGDAP54n2Nde1sDx3bJM9aSiJ6zHx5DaMVx60y8GWbyrXuJ8EWWO+nMBFYR9OpoMDlMMT4wdrYj3metloOamhnvmW3qeTVgUk/FlGb+O8HoFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Tjq6YAup; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=SshLZhQzifZiuzEz2HIJWPdY47YZPx5r4Q79+b43iVk=; b=Tjq6YAupEKmjpf98+i7mA36mCE
	0Wvm2qYz5bjZb+okn10w80sMLG5DACggBmC5mTr5Rg+a1L5UvnYIonOul7hySSa9g842ZUhz4HiCd
	scUyj7n6J13Zx8+veRja8WVC6yYluN2lVDu1EsPqiP+JgeoAy/Gju5jPbot28qbdgDUvyX2BKl2Vw
	CWM8ZvpI2+WJ2EPaTCdq+VCBA4nks61ZvYH0eFaTD3VOa8AZ1/XVvjz1nEgdZY93hBRPgtik/gOOD
	BERu1+fTr33zDTOiw7ZRovsXf8w/iOI9aRpN9InjMkylll6fazsqdyMEassO0sS/a7a//1xf5e5Yr
	HEY8+P6g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <bage@debian.org>)
	id 1vk7ct-00FgtB-9k; Sun, 25 Jan 2026 21:26:31 +0000
From: Bastian Germann <bage@debian.org>
To: linux-wireless@vger.kernel.org
Cc: Bastian Germann <bage@debian.org>,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Port RSA signing to cryptography lib
Date: Sun, 25 Jan 2026 22:26:19 +0100
Message-ID: <20260125212622.28370-1-bage@debian.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31150-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bage@debian.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,db2bin.py:url]
X-Rspamd-Queue-Id: 6AE3982802
X-Rspamd-Action: no action

Port the RSA signing from the deprecated M2Crypto library to the
cryptography library.

M2Crypto is no longer actively maintained. The cryptography library is
the recommended replacement, offering better maintenance.

Remove unused hashlib import.

Signed-off-by: Bastian Germann <bage@debian.org>
---
 db2bin.py | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/db2bin.py b/db2bin.py
index 29ae313..a4fa3e5 100755
--- a/db2bin.py
+++ b/db2bin.py
@@ -2,7 +2,6 @@
 
 from io import BytesIO, open
 import struct
-import hashlib
 from dbparse import DBParser
 import sys
 
@@ -125,19 +124,27 @@ if len(sys.argv) > 3:
     # Load RSA only now so people can use this script
     # without having those libraries installed to verify
     # their SQL changes
-    from M2Crypto import RSA
+    from cryptography.hazmat.primitives import hashes, serialization
+    from cryptography.hazmat.primitives.asymmetric import padding
+
+    # load the private key
+    with open(sys.argv[3], 'rb') as key_file:
+        key = serialization.load_pem_private_key(key_file.read(), password=None)
 
     # determine signature length
-    key = RSA.load_key(sys.argv[3])
-    hash = hashlib.sha1()
-    hash.update(output.getvalue())
-    sig = key.sign(hash.digest())
+    sig = key.sign(
+        output.getvalue(),
+        padding.PKCS1v15(),
+        hashes.SHA1()
+    )
     # write it to file
     siglen.set(len(sig))
     # sign again
-    hash = hashlib.sha1()
-    hash.update(output.getvalue())
-    sig = key.sign(hash.digest())
+    sig = key.sign(
+        output.getvalue(),
+        padding.PKCS1v15(),
+        hashes.SHA1()
+    )
 
     output.write(sig)
 else:

