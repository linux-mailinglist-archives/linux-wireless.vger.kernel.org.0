Return-Path: <linux-wireless+bounces-31978-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEhCIb0xlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31978-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:40:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F302015A488
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A673302DA30
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B44336EC6;
	Wed, 18 Feb 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS8mXGBZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F962F39B4;
	Wed, 18 Feb 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450614; cv=none; b=Ia7eueX7L3bPG5hAROmCo+U8afODD7VpsDbknsoKQ2xFCN4UkgQ4vd2gN4DKdvclY8k4zmbrmQ1Zrp0D1MdfxSMc5V26Fh4/RzXh2AHFSXznXi+AX10CKPGh9uv3mPsmAxOsDsoWMNDGloeZ/sJvMMCL6UuKVfOSyqgOF+eQc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450614; c=relaxed/simple;
	bh=rAp5p3HDmh8Bp7UNW6r+uRPuPyK59EaigYeIc+rCLB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDOPEFR+XQFxggpvgpq5VrLMaGurMfcdUk484/UkSDqU6ZhT6vZJ7jmHUGSqbMBxcVj/zUpWM9iARuZ84dI8/2LxqLRmdqUwx2TnxbMZPYR5asSM0W7/z56hDRo0Z4PAx6Q0tMR/SseBmgspBjs2ytZDyYlsI/3AoEa/herL9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS8mXGBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBBCC2BC86;
	Wed, 18 Feb 2026 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450614;
	bh=rAp5p3HDmh8Bp7UNW6r+uRPuPyK59EaigYeIc+rCLB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bS8mXGBZIZm7D0xIRb2dfANtTBm2nMQJn6ZJn7qSQafN8cLWnn0Tj4h0VgxNQmDFf
	 2zlPR/kUlg3EUQfA87QF3iw4xHUotS7vyUwK4Jzwua2Rzc/Stfkx6codz/EwHcw338
	 xoq5em8nIQnw9Nw0mHlnIE+SUx4U5hbuGRJxM7+k/tLlnsTVuBGBtE74MfMJqGqeTb
	 4d6ch0xmQPfPHj6odH2o+0FK/dZs4Yb75iBZOL2Q8WfXY++UMA/7GVcKP9XhWJG7zN
	 SauD09ZbBVfcBZCmwC8nyVrjJQ0MegCrEzksJtgY0Fz8tXfPq9BLYaLStNBWJVwLBl
	 RhYga15fgJqXA==
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
Subject: [PATCH 07/15] lib/crypto: aes: Add FIPS self-test for CMAC
Date: Wed, 18 Feb 2026 13:34:53 -0800
Message-ID: <20260218213501.136844-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218213501.136844-1-ebiggers@kernel.org>
References: <20260218213501.136844-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31978-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F302015A488
X-Rspamd-Action: no action

Add a FIPS cryptographic algorithm self-test for AES-CMAC to fulfill the
self-test requirement when this code is built into a FIPS 140
cryptographic module.  This provides parity with the traditional crypto
API, which uses crypto/testmgr.c to meet the FIPS self-test requirement.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/aes.c                    | 35 ++++++++++++++++++++++++++---
 lib/crypto/fips.h                   |  5 +++++
 scripts/crypto/gen-fips-testvecs.py | 10 +++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/lib/crypto/aes.c b/lib/crypto/aes.c
index 39deae6105c0..ca733f15b2a8 100644
--- a/lib/crypto/aes.c
+++ b/lib/crypto/aes.c
@@ -10,10 +10,11 @@
 #include <linux/cache.h>
 #include <linux/crypto.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/unaligned.h>
+#include "fips.h"
 
 static const u8 ____cacheline_aligned aes_sbox[] = {
 	0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
 	0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
 	0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
@@ -706,25 +707,53 @@ void aes_cbcmac_final(struct aes_cbcmac_ctx *ctx, u8 out[AES_BLOCK_SIZE])
 	else
 		memcpy(out, ctx->h, AES_BLOCK_SIZE);
 	memzero_explicit(ctx, sizeof(*ctx));
 }
 EXPORT_SYMBOL_NS_GPL(aes_cbcmac_final, "CRYPTO_INTERNAL");
-#endif /* CONFIG_CRYPTO_LIB_AES_CBC_MACS */
 
-#ifdef aes_mod_init_arch
+/*
+ * FIPS cryptographic algorithm self-test for AES-CMAC.  As per the FIPS 140-3
+ * Implementation Guidance, a cryptographic algorithm self-test for at least one
+ * of AES-GCM, AES-CCM, AES-CMAC, or AES-GMAC is required if any of those modes
+ * is implemented.  This fulfills that requirement via AES-CMAC.
+ *
+ * This is just for FIPS.  The full tests are in the KUnit test suite.
+ */
+static void __init aes_cmac_fips_test(void)
+{
+	struct aes_cmac_key key;
+	u8 mac[AES_BLOCK_SIZE];
+
+	if (aes_cmac_preparekey(&key, fips_test_key, sizeof(fips_test_key)) !=
+	    0)
+		panic("aes: CMAC FIPS self-test failed (preparekey)\n");
+	aes_cmac(&key, fips_test_data, sizeof(fips_test_data), mac);
+	if (memcmp(fips_test_aes_cmac_value, mac, sizeof(mac)) != 0)
+		panic("aes: CMAC FIPS self-test failed (wrong MAC)\n");
+	memzero_explicit(&key, sizeof(key));
+}
+#else /* CONFIG_CRYPTO_LIB_AES_CBC_MACS */
+static inline void aes_cmac_fips_test(void)
+{
+}
+#endif /* !CONFIG_CRYPTO_LIB_AES_CBC_MACS */
+
 static int __init aes_mod_init(void)
 {
+#ifdef aes_mod_init_arch
 	aes_mod_init_arch();
+#endif
+	if (fips_enabled)
+		aes_cmac_fips_test();
 	return 0;
 }
 subsys_initcall(aes_mod_init);
 
 static void __exit aes_mod_exit(void)
 {
 }
 module_exit(aes_mod_exit);
-#endif
 
 MODULE_DESCRIPTION("AES block cipher");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_AUTHOR("Eric Biggers <ebiggers@kernel.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/lib/crypto/fips.h b/lib/crypto/fips.h
index 023410c2e0db..9fc49747db64 100644
--- a/lib/crypto/fips.h
+++ b/lib/crypto/fips.h
@@ -41,5 +41,10 @@ static const u8 fips_test_sha3_256_value[] __initconst __maybe_unused = {
 	0x77, 0xc4, 0x8b, 0x69, 0x70, 0x5f, 0x0a, 0xb1,
 	0xb1, 0xa5, 0x82, 0x0a, 0x22, 0x2b, 0x49, 0x31,
 	0xba, 0x9b, 0xb6, 0xaa, 0x32, 0xa7, 0x97, 0x00,
 	0x98, 0xdb, 0xff, 0xe7, 0xc6, 0xde, 0xb5, 0x82,
 };
+
+static const u8 fips_test_aes_cmac_value[] __initconst __maybe_unused = {
+	0xc5, 0x88, 0x28, 0x55, 0xd7, 0x2c, 0x00, 0xb6,
+	0x6a, 0xa7, 0xfc, 0x82, 0x90, 0x81, 0xcf, 0x18,
+};
diff --git a/scripts/crypto/gen-fips-testvecs.py b/scripts/crypto/gen-fips-testvecs.py
index db873f88619a..9f18bcb97412 100755
--- a/scripts/crypto/gen-fips-testvecs.py
+++ b/scripts/crypto/gen-fips-testvecs.py
@@ -1,12 +1,16 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Script that generates lib/crypto/fips.h
 #
+# Requires that python-cryptography be installed.
+#
 # Copyright 2025 Google LLC
 
+import cryptography.hazmat.primitives.ciphers
+import cryptography.hazmat.primitives.cmac
 import hashlib
 import hmac
 
 fips_test_data = b"fips test data\0\0"
 fips_test_key = b"fips test key\0\0\0"
@@ -32,5 +36,11 @@ for alg in 'sha1', 'sha256', 'sha512':
     ctx.update(fips_test_data)
     print_static_u8_array_definition(f'fips_test_hmac_{alg}_value', ctx.digest())
 
 print_static_u8_array_definition(f'fips_test_sha3_256_value',
                                  hashlib.sha3_256(fips_test_data).digest())
+
+aes = cryptography.hazmat.primitives.ciphers.algorithms.AES(fips_test_key)
+aes_cmac = cryptography.hazmat.primitives.cmac.CMAC(aes)
+aes_cmac.update(fips_test_data)
+print_static_u8_array_definition('fips_test_aes_cmac_value',
+                                 aes_cmac.finalize())
-- 
2.53.0


