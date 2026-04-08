Return-Path: <linux-wireless+bounces-34509-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC3eJ2/H1WnA9wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34509-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:11:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C93B6815
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80AE83054F4B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 03:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD5B374E69;
	Wed,  8 Apr 2026 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn2zXZ0H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7B372684;
	Wed,  8 Apr 2026 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617768; cv=none; b=fpPyCo9U2MpMx9VMtk+UGHnzgm+Yp92RVX4bF8BNZOs/7aBszZvyUV/4XahtH6boy80Vlk7sDWUtHf7h7Y+LTuEQSoUQH5LNEUjQQ7jWO/OEgd+xpxo52v4hjGSldrDTYYfbJspJep+xz4DmbgVXRSl1Bf0HVYasfoCaWZK7c3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617768; c=relaxed/simple;
	bh=A5cbxr6QBNRbgHHeeZO1R6NqNKl6wTVienGx6o4PoDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHFONkAOjljrauc+ECz67EbpTEIlIQncCsw3YEYvR5PanSG+v9hHV2Z9r5nQkdwyHuOEg1L6J9rEz30QPgQjp9rsseDuBVvZzgTFifQmK4KPhzH22ztifia6bdkyozKLiTiNiHK54dD4vw0sRfWGLyDxxNGUE7cQG3QEQfa9G1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn2zXZ0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5E6C19424;
	Wed,  8 Apr 2026 03:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775617768;
	bh=A5cbxr6QBNRbgHHeeZO1R6NqNKl6wTVienGx6o4PoDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jn2zXZ0H55WmOeEV9XksEKMRQQjqk7WZFy9Svh+6w6j1L6Yj/kZpvkUWclAEUNmfR
	 aRqNTvhjPnoc7w2xS1gzwvYyKqx+d7e6kHj4HbM3CxnWFpvHNSzTgKmVrDoiY/XB3n
	 Jq79MFtbDpx1nRfx+kD4ocsJjkrI20qs6PRWpMENUC5LV8ZN0dPBRBx0N6Npjk9D8z
	 as4RJJERIysVjf10CAYAv2JTkGPDujUyHIAUc/ICgnaiqNxI5LiVECodzIg4iQ654W
	 MNWfzzX8evpzXIl9KRa2Gg8SFtVA11yliMv8J5+awYhFo3pSX2TlAsu/utSIMOj6Ax
	 U3Jq2/wJ3zIrQ==
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH wireless-next v2 6/6] crypto: Remove michael_mic from crypto_shash API
Date: Tue,  7 Apr 2026 20:06:51 -0700
Message-ID: <20260408030651.80336-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408030651.80336-1-ebiggers@kernel.org>
References: <20260408030651.80336-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34509-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2D6C93B6815
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the "michael_mic" crypto_shash algorithm, since it's no longer
used.  Its only users were wireless drivers, which have now been
converted to use the michael_mic() function instead.

It makes sense that no other users ever appeared: Michael MIC is an
insecure algorithm that is specific to WPA TKIP, which itself was an
interim security solution to replace the broken WEP standard.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/arm/configs/omap2plus_defconfig        |   1 -
 arch/arm/configs/spitz_defconfig            |   1 -
 arch/arm64/configs/defconfig                |   1 -
 arch/m68k/configs/amiga_defconfig           |   1 -
 arch/m68k/configs/apollo_defconfig          |   1 -
 arch/m68k/configs/atari_defconfig           |   1 -
 arch/m68k/configs/bvme6000_defconfig        |   1 -
 arch/m68k/configs/hp300_defconfig           |   1 -
 arch/m68k/configs/mac_defconfig             |   1 -
 arch/m68k/configs/multi_defconfig           |   1 -
 arch/m68k/configs/mvme147_defconfig         |   1 -
 arch/m68k/configs/mvme16x_defconfig         |   1 -
 arch/m68k/configs/q40_defconfig             |   1 -
 arch/m68k/configs/sun3_defconfig            |   1 -
 arch/m68k/configs/sun3x_defconfig           |   1 -
 arch/mips/configs/bigsur_defconfig          |   1 -
 arch/mips/configs/decstation_64_defconfig   |   1 -
 arch/mips/configs/decstation_defconfig      |   1 -
 arch/mips/configs/decstation_r4k_defconfig  |   1 -
 arch/mips/configs/gpr_defconfig             |   1 -
 arch/mips/configs/ip32_defconfig            |   1 -
 arch/mips/configs/lemote2f_defconfig        |   1 -
 arch/mips/configs/malta_qemu_32r6_defconfig |   1 -
 arch/mips/configs/maltaaprp_defconfig       |   1 -
 arch/mips/configs/maltasmvp_defconfig       |   1 -
 arch/mips/configs/maltasmvp_eva_defconfig   |   1 -
 arch/mips/configs/maltaup_defconfig         |   1 -
 arch/mips/configs/mtx1_defconfig            |   1 -
 arch/mips/configs/rm200_defconfig           |   1 -
 arch/mips/configs/sb1250_swarm_defconfig    |   1 -
 arch/parisc/configs/generic-32bit_defconfig |   1 -
 arch/parisc/configs/generic-64bit_defconfig |   1 -
 arch/powerpc/configs/g5_defconfig           |   1 -
 arch/powerpc/configs/linkstation_defconfig  |   1 -
 arch/powerpc/configs/mvme5100_defconfig     |   1 -
 arch/powerpc/configs/powernv_defconfig      |   1 -
 arch/powerpc/configs/ppc64_defconfig        |   1 -
 arch/powerpc/configs/ppc64e_defconfig       |   1 -
 arch/powerpc/configs/ppc6xx_defconfig       |   1 -
 arch/powerpc/configs/ps3_defconfig          |   1 -
 arch/s390/configs/debug_defconfig           |   1 -
 arch/s390/configs/defconfig                 |   1 -
 arch/sh/configs/sh2007_defconfig            |   1 -
 arch/sh/configs/titan_defconfig             |   1 -
 arch/sh/configs/ul2_defconfig               |   1 -
 arch/sparc/configs/sparc32_defconfig        |   1 -
 arch/sparc/configs/sparc64_defconfig        |   1 -
 crypto/Kconfig                              |  12 --
 crypto/Makefile                             |   1 -
 crypto/michael_mic.c                        | 176 --------------------
 crypto/tcrypt.c                             |   4 -
 crypto/testmgr.c                            |   6 -
 crypto/testmgr.h                            |  50 ------
 53 files changed, 296 deletions(-)
 delete mode 100644 crypto/michael_mic.c

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 0464f6552169b..ae2883d3ff0ea 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -702,11 +702,10 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
-CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_DEV_OMAP=m
 CONFIG_CRYPTO_DEV_OMAP_SHAM=m
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index c130af6d44d48..f116a01c3f5f1 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -228,11 +228,10 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0651a771f5c18..8b23430484653 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1912,11 +1912,10 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_USER=y
 CONFIG_CRYPTO_CHACHA20=m
 CONFIG_CRYPTO_BENCHMARK=m
 CONFIG_CRYPTO_ECHAINIV=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_GHASH_ARM64_CE=y
 CONFIG_CRYPTO_SM3_ARM64_CE=m
 CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index c8b936bb702fe..510e16f253182 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -536,11 +536,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index fc1792495bbcb..d1d8f02b4d968 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -493,11 +493,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index e440c596e60be..2e207af4add24 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -513,11 +513,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 7aa352d143630..d754652898984 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -485,11 +485,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 0baaf2a82c611..c2011a749e108 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -495,11 +495,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 0cbbfe5aeaecf..e377443c56d41 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -512,11 +512,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 2b96f90e1a4dd..cdd0449f71413 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -599,11 +599,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index b49264cec9116..4e78ff8d793e8 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -485,11 +485,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 96a974b0a7662..9fc30a3236e18 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -486,11 +486,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index e533615843936..c3b5fdabfe160 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -502,11 +502,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index af89287c10931..ea40f990eb22a 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -483,11 +483,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index af210e8b77f90..e20b6a9d26cdf 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -483,11 +483,10 @@ CONFIG_CRYPTO_HCTR2=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 349e9e0b4f547..3b64e151e187f 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -220,11 +220,10 @@ CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/decstation_64_defconfig b/arch/mips/configs/decstation_64_defconfig
index dad98c5752928..7c43352fac6bd 100644
--- a/arch/mips/configs/decstation_64_defconfig
+++ b/arch/mips/configs/decstation_64_defconfig
@@ -178,11 +178,10 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_CMAC=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_CRC32=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_ARC4=m
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 4e1b51a4ad900..aee10274f0488 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -173,11 +173,10 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_CMAC=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_CRC32=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_ARC4=m
diff --git a/arch/mips/configs/decstation_r4k_defconfig b/arch/mips/configs/decstation_r4k_defconfig
index 4e550dffc23df..a1698049aa7a7 100644
--- a/arch/mips/configs/decstation_r4k_defconfig
+++ b/arch/mips/configs/decstation_r4k_defconfig
@@ -173,11 +173,10 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_CMAC=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_CRC32=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_ARC4=m
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 437ef6dc0b4c2..fdd28a89e3369 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -273,11 +273,10 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_CRYPTO_AUTHENC=m
 CONFIG_CRYPTO_BENCHMARK=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 7568838eb08b2..68558d0d3f52c 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -157,11 +157,10 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_WP512=y
 CONFIG_CRYPTO_ANUBIS=y
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 8d3f20ed19b56..eb3565a3f292c 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -306,11 +306,10 @@ CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_DEFLATE=m
diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index accb471a1d93f..46a69e8984c5a 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -165,11 +165,10 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index 6bda67c5f68f8..74a0e5f6a8860 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -166,11 +166,10 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index e4082537f80fb..873bfc59623b8 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -167,11 +167,10 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 58f5af45fa983..c9230b2c4ea8d 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -169,11 +169,10 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 9bfef7de0d1cf..79fd3ccab3393 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -165,11 +165,10 @@ CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index 77050ae3945fc..930c0178cc670 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -661,11 +661,10 @@ CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 CONFIG_CRYPTO_BENCHMARK=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index b507dc4dddd48..b1e67ff0c4f08 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -380,11 +380,10 @@ CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index ae2afff00e01a..4a25b8d3e5078 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -83,11 +83,10 @@ CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST5=m
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 5444ce6405f3a..a2cb2a7a02db8 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -257,11 +257,10 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_FONTS=y
 CONFIG_PRINTK_TIME=y
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index ce91f9d1fdbfb..4dd6cf6a2cb9b 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -285,11 +285,10 @@ CONFIG_NLS_UTF8=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_DEFLATE=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_STRIP_ASM_SYMS=y
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 428f17b455132..466f196ee8b29 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -236,11 +236,10 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_CRYPTO_BENCHMARK=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index b564f9e33a0df..31f84d08b6efe 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -127,11 +127,10 @@ CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index fa2b3b9c59452..c82754c14e15e 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -113,11 +113,10 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=20
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 9ac746cfb4be3..675462b783200 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -317,11 +317,10 @@ CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
 CONFIG_CRYPTO_BENCHMARK=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 2b0720f2753bc..e3e1cad668d9a 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -380,11 +380,10 @@ CONFIG_CRYPTO_BENCHMARK=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRYPTO_AES_GCM_P10=m
 CONFIG_CRYPTO_DEV_NX=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 90247b2a0ab0c..e877598fe3562 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -223,11 +223,10 @@ CONFIG_XMON=y
 CONFIG_CRYPTO_BENCHMARK=m
 CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 3c08f46f3d41f..27d4350e8fdbe 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1075,11 +1075,10 @@ CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 0b48d2b776c44..7cfae0b7b2f35 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -144,11 +144,10 @@ CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MEMORY_INIT=y
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 98fd0a2f51c6a..b74f96eec4658 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -792,11 +792,10 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 0f4cedcab3cef..0c831481e43fd 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -776,11 +776,10 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_AEGIS128=m
 CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA3=m
 CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index e32d2ce72699f..5d90804994857 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -168,11 +168,10 @@ CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_XTS=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_TGR192=y
 CONFIG_CRYPTO_WP512=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index 896e980d04e14..00863ecb228e8 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -244,11 +244,10 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
diff --git a/arch/sh/configs/ul2_defconfig b/arch/sh/configs/ul2_defconfig
index 0d1c858754dbb..00a37944b043c 100644
--- a/arch/sh/configs/ul2_defconfig
+++ b/arch/sh/configs/ul2_defconfig
@@ -77,6 +77,5 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_CRYPTO_MICHAEL_MIC=y
diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index e021ecfb5a771..48d834acafb4a 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -80,11 +80,10 @@ CONFIG_KGDB=y
 CONFIG_KGDB_TESTS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 9f3f41246ae6d..632081a262bae 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -208,11 +208,10 @@ CONFIG_CRYPTO_BENCHMARK=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=m
diff --git a/crypto/Kconfig b/crypto/Kconfig
index b4bb85e8e2261..769aef52a7851 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -914,22 +914,10 @@ config CRYPTO_MD5
 	select CRYPTO_HASH
 	select CRYPTO_LIB_MD5
 	help
 	  MD5 message digest algorithm (RFC1321), including HMAC support.
 
-config CRYPTO_MICHAEL_MIC
-	tristate "Michael MIC"
-	select CRYPTO_HASH
-	help
-	  Michael MIC (Message Integrity Code) (IEEE 802.11i)
-
-	  Defined by the IEEE 802.11i TKIP (Temporal Key Integrity Protocol),
-	  known as WPA (Wif-Fi Protected Access).
-
-	  This algorithm is required for TKIP, but it should not be used for
-	  other purposes because of the weakness of the algorithm.
-
 config CRYPTO_RMD160
 	tristate "RIPEMD-160"
 	select CRYPTO_HASH
 	help
 	  RIPEMD-160 hash function (ISO/IEC 10118-3)
diff --git a/crypto/Makefile b/crypto/Makefile
index 04e269117589a..aa35ba03222f7 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -148,11 +148,10 @@ obj-$(CONFIG_CRYPTO_ANUBIS) += anubis.o
 obj-$(CONFIG_CRYPTO_SEED) += seed.o
 obj-$(CONFIG_CRYPTO_ARIA) += aria_generic.o
 obj-$(CONFIG_CRYPTO_CHACHA20) += chacha.o
 CFLAGS_chacha.o += -DARCH=$(ARCH)
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
-obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c-cryptoapi.o
 crc32c-cryptoapi-y := crc32c.o
 obj-$(CONFIG_CRYPTO_CRC32) += crc32-cryptoapi.o
 crc32-cryptoapi-y := crc32.o
 obj-$(CONFIG_CRYPTO_AUTHENC) += authenc.o authencesn.o
diff --git a/crypto/michael_mic.c b/crypto/michael_mic.c
deleted file mode 100644
index 69ad35f524d7b..0000000000000
--- a/crypto/michael_mic.c
+++ /dev/null
@@ -1,176 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Cryptographic API
- *
- * Michael MIC (IEEE 802.11i/TKIP) keyed digest
- *
- * Copyright (c) 2004 Jouni Malinen <j@w1.fi>
- */
-#include <crypto/internal/hash.h>
-#include <linux/unaligned.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/types.h>
-
-
-struct michael_mic_ctx {
-	u32 l, r;
-};
-
-struct michael_mic_desc_ctx {
-	__le32 pending;
-	size_t pending_len;
-
-	u32 l, r;
-};
-
-static inline u32 xswap(u32 val)
-{
-	return ((val & 0x00ff00ff) << 8) | ((val & 0xff00ff00) >> 8);
-}
-
-
-#define michael_block(l, r)	\
-do {				\
-	r ^= rol32(l, 17);	\
-	l += r;			\
-	r ^= xswap(l);		\
-	l += r;			\
-	r ^= rol32(l, 3);	\
-	l += r;			\
-	r ^= ror32(l, 2);	\
-	l += r;			\
-} while (0)
-
-
-static int michael_init(struct shash_desc *desc)
-{
-	struct michael_mic_desc_ctx *mctx = shash_desc_ctx(desc);
-	struct michael_mic_ctx *ctx = crypto_shash_ctx(desc->tfm);
-	mctx->pending_len = 0;
-	mctx->l = ctx->l;
-	mctx->r = ctx->r;
-
-	return 0;
-}
-
-
-static int michael_update(struct shash_desc *desc, const u8 *data,
-			   unsigned int len)
-{
-	struct michael_mic_desc_ctx *mctx = shash_desc_ctx(desc);
-
-	if (mctx->pending_len) {
-		int flen = 4 - mctx->pending_len;
-		if (flen > len)
-			flen = len;
-		memcpy((u8 *)&mctx->pending + mctx->pending_len, data, flen);
-		mctx->pending_len += flen;
-		data += flen;
-		len -= flen;
-
-		if (mctx->pending_len < 4)
-			return 0;
-
-		mctx->l ^= le32_to_cpu(mctx->pending);
-		michael_block(mctx->l, mctx->r);
-		mctx->pending_len = 0;
-	}
-
-	while (len >= 4) {
-		mctx->l ^= get_unaligned_le32(data);
-		michael_block(mctx->l, mctx->r);
-		data += 4;
-		len -= 4;
-	}
-
-	if (len > 0) {
-		mctx->pending_len = len;
-		memcpy(&mctx->pending, data, len);
-	}
-
-	return 0;
-}
-
-
-static int michael_final(struct shash_desc *desc, u8 *out)
-{
-	struct michael_mic_desc_ctx *mctx = shash_desc_ctx(desc);
-	u8 *data = (u8 *)&mctx->pending;
-
-	/* Last block and padding (0x5a, 4..7 x 0) */
-	switch (mctx->pending_len) {
-	case 0:
-		mctx->l ^= 0x5a;
-		break;
-	case 1:
-		mctx->l ^= data[0] | 0x5a00;
-		break;
-	case 2:
-		mctx->l ^= data[0] | (data[1] << 8) | 0x5a0000;
-		break;
-	case 3:
-		mctx->l ^= data[0] | (data[1] << 8) | (data[2] << 16) |
-			0x5a000000;
-		break;
-	}
-	michael_block(mctx->l, mctx->r);
-	/* l ^= 0; */
-	michael_block(mctx->l, mctx->r);
-
-	put_unaligned_le32(mctx->l, out);
-	put_unaligned_le32(mctx->r, out + 4);
-
-	return 0;
-}
-
-
-static int michael_setkey(struct crypto_shash *tfm, const u8 *key,
-			  unsigned int keylen)
-{
-	struct michael_mic_ctx *mctx = crypto_shash_ctx(tfm);
-
-	if (keylen != 8)
-		return -EINVAL;
-
-	mctx->l = get_unaligned_le32(key);
-	mctx->r = get_unaligned_le32(key + 4);
-	return 0;
-}
-
-static struct shash_alg alg = {
-	.digestsize		=	8,
-	.setkey			=	michael_setkey,
-	.init			=	michael_init,
-	.update			=	michael_update,
-	.final			=	michael_final,
-	.descsize		=	sizeof(struct michael_mic_desc_ctx),
-	.base			=	{
-		.cra_name		=	"michael_mic",
-		.cra_driver_name	=	"michael_mic-generic",
-		.cra_blocksize		=	8,
-		.cra_ctxsize		=	sizeof(struct michael_mic_ctx),
-		.cra_module		=	THIS_MODULE,
-	}
-};
-
-static int __init michael_mic_init(void)
-{
-	return crypto_register_shash(&alg);
-}
-
-
-static void __exit michael_mic_exit(void)
-{
-	crypto_unregister_shash(&alg);
-}
-
-
-module_init(michael_mic_init);
-module_exit(michael_mic_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Michael MIC");
-MODULE_AUTHOR("Jouni Malinen <j@w1.fi>");
-MODULE_ALIAS_CRYPTO("michael_mic");
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index aded375461374..24f0ccc767961 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1555,14 +1555,10 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 
 	case 16:
 		ret = min(ret, tcrypt_test("ecb(arc4)"));
 		break;
 
-	case 17:
-		ret = min(ret, tcrypt_test("michael_mic"));
-		break;
-
 	case 18:
 		ret = min(ret, tcrypt_test("crc32c"));
 		break;
 
 	case 19:
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 4985411dedaec..d5c38683bf46f 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5195,16 +5195,10 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.generic_driver = "md5-lib",
 		.test = alg_test_hash,
 		.suite = {
 			.hash = __VECS(md5_tv_template)
 		}
-	}, {
-		.alg = "michael_mic",
-		.test = alg_test_hash,
-		.suite = {
-			.hash = __VECS(michael_mic_tv_template)
-		}
 	}, {
 		.alg = "p1363(ecdsa-nist-p192)",
 		.test = alg_test_null,
 	}, {
 		.alg = "p1363(ecdsa-nist-p256)",
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 1c69c11c0cdb4..11911bff5f793 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -32806,60 +32806,10 @@ static const struct comp_testvec lzorle_decomp_tv_template[] = {
 		.output	= "Join us now and share the software "
 			"Join us now and share the software ",
 	},
 };
 
-/*
- * Michael MIC test vectors from IEEE 802.11i
- */
-#define MICHAEL_MIC_TEST_VECTORS 6
-
-static const struct hash_testvec michael_mic_tv_template[] = {
-	{
-		.key = "\x00\x00\x00\x00\x00\x00\x00\x00",
-		.ksize = 8,
-		.plaintext = zeroed_string,
-		.psize = 0,
-		.digest = "\x82\x92\x5c\x1c\xa1\xd1\x30\xb8",
-	},
-	{
-		.key = "\x82\x92\x5c\x1c\xa1\xd1\x30\xb8",
-		.ksize = 8,
-		.plaintext = "M",
-		.psize = 1,
-		.digest = "\x43\x47\x21\xca\x40\x63\x9b\x3f",
-	},
-	{
-		.key = "\x43\x47\x21\xca\x40\x63\x9b\x3f",
-		.ksize = 8,
-		.plaintext = "Mi",
-		.psize = 2,
-		.digest = "\xe8\xf9\xbe\xca\xe9\x7e\x5d\x29",
-	},
-	{
-		.key = "\xe8\xf9\xbe\xca\xe9\x7e\x5d\x29",
-		.ksize = 8,
-		.plaintext = "Mic",
-		.psize = 3,
-		.digest = "\x90\x03\x8f\xc6\xcf\x13\xc1\xdb",
-	},
-	{
-		.key = "\x90\x03\x8f\xc6\xcf\x13\xc1\xdb",
-		.ksize = 8,
-		.plaintext = "Mich",
-		.psize = 4,
-		.digest = "\xd5\x5e\x10\x05\x10\x12\x89\x86",
-	},
-	{
-		.key = "\xd5\x5e\x10\x05\x10\x12\x89\x86",
-		.ksize = 8,
-		.plaintext = "Michael",
-		.psize = 7,
-		.digest = "\x0a\x94\x2b\x12\x4e\xca\xa5\x46",
-	}
-};
-
 /*
  * CRC32 test vectors
  */
 static const struct hash_testvec crc32_tv_template[] = {
 	{
-- 
2.53.0


