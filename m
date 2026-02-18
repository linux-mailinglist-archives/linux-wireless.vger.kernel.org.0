Return-Path: <linux-wireless+bounces-31971-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPeWJvUwlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31971-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:36:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF015A324
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB0E730097EB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298592EB860;
	Wed, 18 Feb 2026 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZieEykj7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE32E8B64;
	Wed, 18 Feb 2026 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450610; cv=none; b=gEzYcqeC46U75AX5Isd9aWrBEwnKW/3uf80RpjsBJ1HjqvAv7dV8G+tbdIF4H60F84f6gH9kpQJAVvlQQgiIBEl5MHoyrMDgYIH8yhfRJ+9kZMyaSJzCtk/bho2A33w7igPizpFcMkITusx+82uZkBonYMGR2a3RHxwxqX9yh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450610; c=relaxed/simple;
	bh=wf8/GUqvoI3GfA7MCp1kWAe/s3LxP5yqBgsjAILj20U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5zuYkU56z6el7+tjL773hyWXTl5ftgXG3ulpukRS3uv2KvOwR9fHVa/hnvSPqrDUqx76li2kSj0otAc4Y7m39Bvray/VMFkkudnqYMsdT/tmCv/fxG1OjjPcMOEURTWfGo9Ffwfpzw32JNC6cDdmVJnPgCA7stN++jxwKKzASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZieEykj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65688C19421;
	Wed, 18 Feb 2026 21:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450609;
	bh=wf8/GUqvoI3GfA7MCp1kWAe/s3LxP5yqBgsjAILj20U=;
	h=From:To:Cc:Subject:Date:From;
	b=ZieEykj75bB8BK4FB/0RkIiO554XHDyNUfjzIEXtza8cRLodsTCv0sVmUGbwZE2Bb
	 TTsymEYxdfgkxxSQPoULk5eT1oyszXBfuLr/w+iFz6uENOOlE/c9bLlEHwFmpy/t/w
	 CbopT4u9KznPzJ65+1qUN0MGNREaS9QjjIFanVQbVBKNSSbdd+5E4KNe7xT9mDqwDF
	 cMRQh2LQormCJUd6riFfvUJmQUKK826D45RR92WfsCHpEmSczUmK8m4pa9ggTQ1kNk
	 NlI/zKSetmtqB8MVwi0BthwVzDJkTTAga9Xfjel0zlhqukUyy8Eo7kwp8QhE5f0zQg
	 WJchilasLghsg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 00/15] AES-CMAC library
Date: Wed, 18 Feb 2026 13:34:46 -0800
Message-ID: <20260218213501.136844-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31971-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 03BF015A324
X-Rspamd-Action: no action

This series can also be retrieved from:

    git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git aes-cmac-v1

This series adds support for AES CBC-based MACs to the crypto library,
specifically AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC.  The
implementation is fully optimized with the existing
architecture-optimized AES code, either single-block AES en/decryption
or arm64's neon_aes_mac_update() and ce_aes_mac_update().  As usual,
optimizations are now enabled by default as well.

AES-CMAC support will be useful for at least the SMB client and server,
and the bluetooth and mac80211 drivers.  Patches 8-15 convert these
users to use the crypto library API instead of crypto_shash, though
these patches will likely go in via subsystem trees later.  They result
in some significant simplifications and performance improvements.

As usual, a KUnit test suite, FIPS self-test, and traditional crypto API
wrapper algorithms are included as well.

Note that I'm also planning to add additional AES modes to the library.
This is just an initial set of AES modes to get things started.
Notably, with the SMB client and server already using the SHA* and MD5
libraries, "cmac(aes)" was the only remaining use of crypto_shash there.
So it makes sense to take care of that.

Eric Biggers (15):
  lib/crypto: aes: Add support for CBC-based MACs
  crypto: aes - Add cmac, xcbc, and cbcmac algorithms using library
  crypto: arm64/aes - Fix 32-bit aes_mac_update() arg treated as 64-bit
  lib/crypto: arm64/aes: Move assembly code for AES modes into libaes
  lib/crypto: arm64/aes: Migrate optimized CBC-based MACs into library
  lib/crypto: tests: Add KUnit tests for CBC-based MACs
  lib/crypto: aes: Add FIPS self-test for CMAC
  smb: client: Use AES-CMAC library for SMB3 signature calculation
  smb: client: Remove obsolete cmac(aes) allocation
  smb: client: Make generate_key() return void
  smb: client: Drop 'allocate_crypto' arg from smb*_calc_signature()
  ksmbd: Use AES-CMAC library for SMB3 signature calculation
  Bluetooth: SMP: Use AES-CMAC library API
  wifi: mac80211: Use AES-CMAC library in ieee80211_aes_cmac()
  wifi: mac80211: Use AES-CMAC library in aes_s2v()

 arch/arm64/crypto/Kconfig                     |   2 +-
 arch/arm64/crypto/Makefile                    |   4 +-
 arch/arm64/crypto/aes-ce-ccm-glue.c           |   4 -
 arch/arm64/crypto/aes-glue.c                  | 260 +-----------------
 arch/arm64/crypto/aes-neonbs-glue.c           |  15 +-
 crypto/Kconfig                                |   2 +
 crypto/aes.c                                  | 183 +++++++++++-
 crypto/testmgr.c                              |  10 +-
 drivers/crypto/starfive/jh7110-aes.c          |   2 +-
 fs/smb/client/Kconfig                         |   2 +-
 fs/smb/client/cifs_unicode.c                  |   1 +
 fs/smb/client/cifsencrypt.c                   |  62 ++---
 fs/smb/client/cifsfs.c                        |   1 -
 fs/smb/client/cifsglob.h                      |   7 +-
 fs/smb/client/cifsproto.h                     |   3 -
 fs/smb/client/misc.c                          |  57 ----
 fs/smb/client/sess.c                          |  11 -
 fs/smb/client/smb2proto.h                     |   1 -
 fs/smb/client/smb2transport.c                 | 113 ++------
 fs/smb/server/Kconfig                         |   2 +-
 fs/smb/server/auth.c                          |  51 +---
 fs/smb/server/auth.h                          |   4 +-
 fs/smb/server/crypto_ctx.c                    |  58 ----
 fs/smb/server/crypto_ctx.h                    |  12 -
 fs/smb/server/server.c                        |   1 -
 fs/smb/server/smb2pdu.c                       |   8 +-
 include/crypto/aes-cbc-macs.h                 | 154 +++++++++++
 include/crypto/aes.h                          |  66 +++++
 lib/crypto/Kconfig                            |  10 +
 lib/crypto/Makefile                           |   4 +-
 lib/crypto/aes.c                              | 231 +++++++++++++++-
 .../crypto => lib/crypto/arm64}/aes-ce.S      |   0
 .../crypto => lib/crypto/arm64}/aes-modes.S   |  23 +-
 .../crypto => lib/crypto/arm64}/aes-neon.S    |   0
 lib/crypto/arm64/aes.h                        |  76 ++++-
 lib/crypto/fips.h                             |   5 +
 lib/crypto/tests/Kconfig                      |  10 +
 lib/crypto/tests/Makefile                     |   1 +
 lib/crypto/tests/aes-cmac-testvecs.h          | 181 ++++++++++++
 lib/crypto/tests/aes_cbc_macs_kunit.c         | 228 +++++++++++++++
 net/bluetooth/Kconfig                         |   3 +-
 net/bluetooth/smp.c                           | 180 +++++-------
 net/mac80211/Kconfig                          |   2 +-
 net/mac80211/aes_cmac.c                       |  65 +----
 net/mac80211/aes_cmac.h                       |  12 +-
 net/mac80211/fils_aead.c                      |  48 ++--
 net/mac80211/key.c                            |  11 +-
 net/mac80211/key.h                            |   3 +-
 net/mac80211/wpa.c                            |  13 +-
 scripts/crypto/gen-fips-testvecs.py           |  10 +
 scripts/crypto/gen-hash-testvecs.py           |  31 ++-
 51 files changed, 1388 insertions(+), 855 deletions(-)
 create mode 100644 include/crypto/aes-cbc-macs.h
 rename {arch/arm64/crypto => lib/crypto/arm64}/aes-ce.S (100%)
 rename {arch/arm64/crypto => lib/crypto/arm64}/aes-modes.S (98%)
 rename {arch/arm64/crypto => lib/crypto/arm64}/aes-neon.S (100%)
 create mode 100644 lib/crypto/tests/aes-cmac-testvecs.h
 create mode 100644 lib/crypto/tests/aes_cbc_macs_kunit.c


base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122
prerequisite-patch-id: 8eccdd31739fb317dfda9dddbfc5c3cd64e77331
prerequisite-patch-id: ca782470cef2467042fbe8f0166933d7fa292628
-- 
2.53.0


