Return-Path: <linux-wireless+bounces-31977-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBvWNJ8xlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31977-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:39:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4BD15A462
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D7C3073F7D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7DD3358B9;
	Wed, 18 Feb 2026 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPwtpcM4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EF3358A6;
	Wed, 18 Feb 2026 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450613; cv=none; b=IVhjOdt9eChYodWmaD0u3R6GUjE8qQHEZMx24xN9c5ZCkLp4jmm2YNajiXZ4S4K/NpcBjrhd41cVvCHd9gwVXJQRp922VyLEoaJTUXIUyQmycdkfDCDJCZZizD9alXeM9EUdCIAa7HNOZ2mLoNkOvk9X26vzWopC5Uf5bGD04dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450613; c=relaxed/simple;
	bh=WsEqvASqnfKYvYAsnz2LEtDg1yiW7NveNu+mk7c4JE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D84zCcpiqjYrIMrPFUGTBs5/70BR11jwvQPwSmvAF9UqN9UTsqE33vePyrFStTv6vm9DxlfCp+nlCxLd9ZahkXbmZJfVhAl5JsEuWDP9Efc1cRzn/P48ZJ8x7tLcqShoeTqNfxqz4t/EqCvTT61Y61yEDzFva0S7vR76+V+oWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPwtpcM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE09C2BCAF;
	Wed, 18 Feb 2026 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450613;
	bh=WsEqvASqnfKYvYAsnz2LEtDg1yiW7NveNu+mk7c4JE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPwtpcM4GMCYsfw00sGC/0Nbr6RO+bXz7y8PSeuDxJ/8iWe9dCU6q1Ldei6lNxaky
	 h1k/vnVu1H7L3wVLQJ8ReOkR+5KmzPKLyIQn/Q/gTFS9YBqAB4M/DlGRsRnP66IcYa
	 yGiWuieGWT1r8kmtTn3MU+DT/NlQrkC1fTxw7wo5tMz860tv8DvCy7TpYuxResQX9M
	 7ajbWg1UUYr+WAc+c3bDpXayUHXx86yV8X4U8soJmWkl5R4gyCmiPmTTKWsIz4fBEi
	 NsBdFac05w3fqpoxe6DotFcIxXY5xs8iJ8yiCg1qzY/bwC/NdzDgKC8aYUPF+l/hyI
	 lPhS6jBREfGog==
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
Subject: [PATCH 06/15] lib/crypto: tests: Add KUnit tests for CBC-based MACs
Date: Wed, 18 Feb 2026 13:34:52 -0800
Message-ID: <20260218213501.136844-7-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31977-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 7B4BD15A462
X-Rspamd-Action: no action

Add a KUnit test suite for the AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC
library functions.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/tests/Kconfig              |  10 ++
 lib/crypto/tests/Makefile             |   1 +
 lib/crypto/tests/aes-cmac-testvecs.h  | 181 ++++++++++++++++++++
 lib/crypto/tests/aes_cbc_macs_kunit.c | 228 ++++++++++++++++++++++++++
 scripts/crypto/gen-hash-testvecs.py   |  31 +++-
 5 files changed, 448 insertions(+), 3 deletions(-)
 create mode 100644 lib/crypto/tests/aes-cmac-testvecs.h
 create mode 100644 lib/crypto/tests/aes_cbc_macs_kunit.c

diff --git a/lib/crypto/tests/Kconfig b/lib/crypto/tests/Kconfig
index 4970463ea0aa..2433b988bc5b 100644
--- a/lib/crypto/tests/Kconfig
+++ b/lib/crypto/tests/Kconfig
@@ -1,7 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+config CRYPTO_LIB_AES_CBC_MACS_KUNIT_TEST
+	tristate "KUnit tests for AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
+	select CRYPTO_LIB_BENCHMARK_VISIBLE
+	select CRYPTO_LIB_AES_CBC_MACS
+	help
+	  KUnit tests for the AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC message
+	  authentication codes.
+
 config CRYPTO_LIB_BLAKE2B_KUNIT_TEST
 	tristate "KUnit tests for BLAKE2b" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
diff --git a/lib/crypto/tests/Makefile b/lib/crypto/tests/Makefile
index f4262379f56c..f864e0ffbee4 100644
--- a/lib/crypto/tests/Makefile
+++ b/lib/crypto/tests/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+obj-$(CONFIG_CRYPTO_LIB_AES_CBC_MACS_KUNIT_TEST) += aes_cbc_macs_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_BLAKE2B_KUNIT_TEST) += blake2b_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_BLAKE2S_KUNIT_TEST) += blake2s_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_CURVE25519_KUNIT_TEST) += curve25519_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_MD5_KUNIT_TEST) += md5_kunit.o
 obj-$(CONFIG_CRYPTO_LIB_MLDSA_KUNIT_TEST) += mldsa_kunit.o
diff --git a/lib/crypto/tests/aes-cmac-testvecs.h b/lib/crypto/tests/aes-cmac-testvecs.h
new file mode 100644
index 000000000000..8177862ba5a3
--- /dev/null
+++ b/lib/crypto/tests/aes-cmac-testvecs.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* This file was generated by: ./scripts/crypto/gen-hash-testvecs.py aes-cmac */
+
+static const struct {
+	size_t data_len;
+	u8 digest[AES_BLOCK_SIZE];
+} hash_testvecs[] = {
+	{
+		.data_len = 0,
+		.digest = {
+			0x9a, 0xeb, 0x94, 0xc1, 0xe9, 0xc1, 0x57, 0x49,
+			0x7e, 0xba, 0x66, 0x47, 0x9f, 0x03, 0x2c, 0x5b,
+		},
+	},
+	{
+		.data_len = 1,
+		.digest = {
+			0x52, 0xef, 0x65, 0xda, 0x7b, 0x92, 0x0c, 0x0f,
+			0xdd, 0xd6, 0xb9, 0x68, 0x3f, 0xcc, 0x5f, 0xea,
+		},
+	},
+	{
+		.data_len = 2,
+		.digest = {
+			0xc3, 0x95, 0x15, 0xea, 0x16, 0x33, 0xbe, 0x5a,
+			0xd4, 0x2c, 0x25, 0x06, 0x15, 0xc6, 0x10, 0x19,
+		},
+	},
+	{
+		.data_len = 3,
+		.digest = {
+			0x82, 0x41, 0x41, 0xd5, 0x33, 0x26, 0x0b, 0xb6,
+			0xc8, 0xf7, 0x8d, 0x76, 0x8a, 0xfc, 0x0e, 0xe4,
+		},
+	},
+	{
+		.data_len = 16,
+		.digest = {
+			0x94, 0x09, 0x80, 0x07, 0xba, 0x7c, 0xed, 0xd2,
+			0x74, 0x72, 0x30, 0x26, 0xb5, 0x11, 0x64, 0xc1,
+		},
+	},
+	{
+		.data_len = 32,
+		.digest = {
+			0xeb, 0xcf, 0x1e, 0x67, 0x21, 0x64, 0x93, 0xa0,
+			0xea, 0xc4, 0xb9, 0x2d, 0x55, 0xc8, 0xac, 0x99,
+		},
+	},
+	{
+		.data_len = 48,
+		.digest = {
+			0xd0, 0xd6, 0xdb, 0xe2, 0x45, 0x98, 0x6a, 0x7a,
+			0x5f, 0xd6, 0xcd, 0x9d, 0x12, 0x26, 0x20, 0x87,
+		},
+	},
+	{
+		.data_len = 49,
+		.digest = {
+			0x63, 0x25, 0x3c, 0xe2, 0x2a, 0xfa, 0xe3, 0x1e,
+			0x54, 0x10, 0x18, 0x28, 0xc6, 0xb8, 0xcb, 0x58,
+		},
+	},
+	{
+		.data_len = 63,
+		.digest = {
+			0x4d, 0xab, 0xae, 0x99, 0x90, 0x13, 0x3f, 0x4f,
+			0x42, 0x0f, 0x19, 0x94, 0xa2, 0x52, 0xfd, 0xaf,
+		},
+	},
+	{
+		.data_len = 64,
+		.digest = {
+			0xf7, 0x49, 0xb9, 0xa7, 0xf9, 0x3e, 0xa0, 0xca,
+			0xb2, 0x6c, 0xd7, 0x87, 0x7d, 0x1e, 0xd2, 0xcb,
+		},
+	},
+	{
+		.data_len = 65,
+		.digest = {
+			0x27, 0x2c, 0xb7, 0xc8, 0xdd, 0x26, 0xa9, 0xfe,
+			0x37, 0x64, 0x84, 0x38, 0xa5, 0x7e, 0xbc, 0x04,
+		},
+	},
+	{
+		.data_len = 127,
+		.digest = {
+			0xfd, 0x1f, 0x01, 0xa4, 0xea, 0x9b, 0xbd, 0xef,
+			0x09, 0x97, 0x57, 0x60, 0x95, 0x23, 0xcc, 0x71,
+		},
+	},
+	{
+		.data_len = 128,
+		.digest = {
+			0x28, 0x21, 0xee, 0x56, 0x9f, 0x38, 0xd6, 0x0e,
+			0xe3, 0x22, 0x06, 0x20, 0xad, 0xd8, 0x33, 0x74,
+		},
+	},
+	{
+		.data_len = 129,
+		.digest = {
+			0x07, 0x28, 0x4a, 0x2a, 0xd3, 0x85, 0xa6, 0x87,
+			0x5c, 0x01, 0x8c, 0xb9, 0xd3, 0x4b, 0xce, 0x20,
+		},
+	},
+	{
+		.data_len = 256,
+		.digest = {
+			0xe6, 0x12, 0x25, 0x6b, 0xf9, 0x69, 0x4d, 0x5a,
+			0x1a, 0xb0, 0xe6, 0x11, 0x46, 0x24, 0x08, 0xdf,
+		},
+	},
+	{
+		.data_len = 511,
+		.digest = {
+			0xce, 0x28, 0x1f, 0x14, 0xb9, 0xcc, 0x7e, 0x1f,
+			0xb5, 0x13, 0x2b, 0x45, 0x04, 0x54, 0xe9, 0x5f,
+		},
+	},
+	{
+		.data_len = 513,
+		.digest = {
+			0x63, 0x12, 0xbd, 0x85, 0x60, 0x1b, 0x99, 0x7e,
+			0x0a, 0xf7, 0x0f, 0xc1, 0xb5, 0x66, 0xf8, 0x9a,
+		},
+	},
+	{
+		.data_len = 1000,
+		.digest = {
+			0xbd, 0x49, 0x5e, 0x21, 0xc6, 0x58, 0x74, 0x6b,
+			0x21, 0xc2, 0x62, 0x6a, 0x15, 0xca, 0x1d, 0x8a,
+		},
+	},
+	{
+		.data_len = 3333,
+		.digest = {
+			0xfe, 0x6b, 0xfa, 0xfc, 0x4c, 0x0b, 0x63, 0x0d,
+			0x41, 0x7f, 0xa9, 0xd8, 0xba, 0xe3, 0xce, 0xce,
+		},
+	},
+	{
+		.data_len = 4096,
+		.digest = {
+			0x41, 0x7c, 0xbc, 0x2e, 0x2f, 0xff, 0xdf, 0x09,
+			0x31, 0xc5, 0x79, 0x0a, 0x1d, 0x6e, 0x46, 0xec,
+		},
+	},
+	{
+		.data_len = 4128,
+		.digest = {
+			0x6a, 0x9d, 0x86, 0xa8, 0xab, 0xa5, 0xc1, 0xc5,
+			0x0d, 0x54, 0xf3, 0x51, 0x10, 0x46, 0x25, 0x5a,
+		},
+	},
+	{
+		.data_len = 4160,
+		.digest = {
+			0x4c, 0x50, 0xff, 0x2a, 0xe9, 0xca, 0x9e, 0x07,
+			0x8a, 0x86, 0x67, 0x5e, 0xe5, 0x0a, 0xfd, 0x69,
+		},
+	},
+	{
+		.data_len = 4224,
+		.digest = {
+			0x3a, 0xfa, 0x80, 0x9d, 0x80, 0xe3, 0x1e, 0x95,
+			0x53, 0x93, 0x39, 0x17, 0xd3, 0xda, 0x49, 0x15,
+		},
+	},
+	{
+		.data_len = 16384,
+		.digest = {
+			0x48, 0xf4, 0x4f, 0x2d, 0x5d, 0xf2, 0x02, 0xcf,
+			0x51, 0x3c, 0x1b, 0x12, 0x80, 0x8f, 0xb0, 0xd6,
+		},
+	},
+};
+
+static const u8 hash_testvec_consolidated[AES_BLOCK_SIZE] = {
+	0x41, 0xad, 0x25, 0xa1, 0xeb, 0xce, 0x6b, 0x9c,
+	0x06, 0xdf, 0x47, 0xc4, 0x3a, 0x59, 0x50, 0x07,
+};
diff --git a/lib/crypto/tests/aes_cbc_macs_kunit.c b/lib/crypto/tests/aes_cbc_macs_kunit.c
new file mode 100644
index 000000000000..ae3745212f03
--- /dev/null
+++ b/lib/crypto/tests/aes_cbc_macs_kunit.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Google LLC
+ */
+#include <crypto/aes-cbc-macs.h>
+#include "aes-cmac-testvecs.h"
+
+/*
+ * A fixed key used when presenting AES-CMAC as an unkeyed hash function in
+ * order to reuse hash-test-template.h.  At the beginning of the test suite,
+ * this is initialized to a key prepared from bytes generated from a fixed seed.
+ */
+static struct aes_cmac_key test_key;
+
+static void aes_cmac_init_withtestkey(struct aes_cmac_ctx *ctx)
+{
+	aes_cmac_init(ctx, &test_key);
+}
+
+static void aes_cmac_withtestkey(const u8 *data, size_t data_len,
+				 u8 out[AES_BLOCK_SIZE])
+{
+	aes_cmac(&test_key, data, data_len, out);
+}
+
+#define HASH aes_cmac_withtestkey
+#define HASH_CTX aes_cmac_ctx
+#define HASH_SIZE AES_BLOCK_SIZE
+#define HASH_INIT aes_cmac_init_withtestkey
+#define HASH_UPDATE aes_cmac_update
+#define HASH_FINAL aes_cmac_final
+#include "hash-test-template.h"
+
+static int aes_cbc_macs_suite_init(struct kunit_suite *suite)
+{
+	u8 raw_key[AES_KEYSIZE_256];
+	int err;
+
+	rand_bytes_seeded_from_len(raw_key, sizeof(raw_key));
+	err = aes_cmac_preparekey(&test_key, raw_key, sizeof(raw_key));
+	if (err)
+		return err;
+	return hash_suite_init(suite);
+}
+
+static void aes_cbc_macs_suite_exit(struct kunit_suite *suite)
+{
+	hash_suite_exit(suite);
+}
+
+/* Verify compatibility of the AES-CMAC implementation with RFC 4493. */
+static void test_aes_cmac_rfc4493(struct kunit *test)
+{
+	static const u8 raw_key[AES_KEYSIZE_128] = {
+		0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
+		0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c,
+	};
+	static const struct {
+		size_t data_len;
+		const u8 data[40];
+		const u8 mac[AES_BLOCK_SIZE];
+	} testvecs[] = {
+		{
+			/* Example 1 from RFC 4493 */
+			.data_len = 0,
+			.mac = {
+				0xbb, 0x1d, 0x69, 0x29, 0xe9, 0x59, 0x37, 0x28,
+				0x7f, 0xa3, 0x7d, 0x12, 0x9b, 0x75, 0x67, 0x46,
+			},
+
+		},
+		{
+			/* Example 2 from RFC 4493 */
+			.data = {
+				0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96,
+				0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a,
+			},
+			.data_len = 16,
+			.mac = {
+				0x07, 0x0a, 0x16, 0xb4, 0x6b, 0x4d, 0x41, 0x44,
+				0xf7, 0x9b, 0xdd, 0x9d, 0xd0, 0x4a, 0x28, 0x7c,
+			},
+		},
+		{
+			/* Example 3 from RFC 4493 */
+			.data = {
+				0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96,
+				0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a,
+				0xae, 0x2d, 0x8a, 0x57, 0x1e, 0x03, 0xac, 0x9c,
+				0x9e, 0xb7, 0x6f, 0xac, 0x45, 0xaf, 0x8e, 0x51,
+				0x30, 0xc8, 0x1c, 0x46, 0xa3, 0x5c, 0xe4, 0x11,
+			},
+			.data_len = 40,
+			.mac = {
+				0xdf, 0xa6, 0x67, 0x47, 0xde, 0x9a, 0xe6, 0x30,
+				0x30, 0xca, 0x32, 0x61, 0x14, 0x97, 0xc8, 0x27,
+			},
+		},
+	};
+	struct aes_cmac_key key;
+	int err;
+
+	err = aes_cmac_preparekey(&key, raw_key, sizeof(raw_key));
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	for (size_t i = 0; i < ARRAY_SIZE(testvecs); i++) {
+		u8 mac[AES_BLOCK_SIZE];
+
+		aes_cmac(&key, testvecs[i].data, testvecs[i].data_len, mac);
+		KUNIT_ASSERT_MEMEQ(test, mac, testvecs[i].mac, AES_BLOCK_SIZE);
+	}
+}
+
+/*
+ * Verify compatibility of the AES-XCBC-MAC implementation with RFC 3566.
+ *
+ * Additional AES-XCBC-MAC tests are not necessary, since the AES-XCBC-MAC
+ * implementation is well covered by the AES-CMAC tests already.  Only the key
+ * preparation function differs; the rest of the code is shared.
+ */
+static void test_aes_xcbcmac_rfc3566(struct kunit *test)
+{
+	struct aes_cmac_key key;
+	/* AES-XCBC-MAC Test Case #4 from RFC 3566 */
+	static const u8 raw_key[AES_KEYSIZE_128] = {
+		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	};
+	static const u8 message[20] = {
+		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
+		0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13,
+	};
+	static const u8 expected_mac[AES_BLOCK_SIZE] = {
+		0x47, 0xf5, 0x1b, 0x45, 0x64, 0x96, 0x62, 0x15,
+		0xb8, 0x98, 0x5c, 0x63, 0x05, 0x5e, 0xd3, 0x08,
+	};
+	u8 actual_mac[AES_BLOCK_SIZE];
+
+	aes_xcbcmac_preparekey(&key, raw_key);
+	aes_cmac(&key, message, sizeof(message), actual_mac);
+	KUNIT_ASSERT_MEMEQ(test, actual_mac, expected_mac, AES_BLOCK_SIZE);
+}
+
+static void test_aes_cbcmac_rfc3610(struct kunit *test)
+{
+	/*
+	 * The following AES-CBC-MAC test vector is extracted from RFC 3610
+	 * Packet Vector #11.  It required some rearrangement to get the actual
+	 * input to AES-CBC-MAC from the values given.
+	 */
+	static const u8 raw_key[AES_KEYSIZE_128] = {
+		0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+		0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
+	};
+	const size_t unpadded_data_len = 52;
+	static const u8 data[64] = {
+		/* clang-format off */
+		/* CCM header */
+		0x61, 0x00, 0x00, 0x00, 0x0d, 0x0c, 0x0b, 0x0a,
+		0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0x00, 0x14,
+		/* CCM additional authentication blocks */
+		0x00, 0x0c, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
+		0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x00, 0x00,
+		/* CCM message blocks */
+		0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13,
+		0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b,
+		0x1c, 0x1d, 0x1e, 0x1f, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		/* clang-format on */
+	};
+	static const u8 expected_mac[AES_BLOCK_SIZE] = {
+		0x6b, 0x5e, 0x24, 0x34, 0x12, 0xcc, 0xc2, 0xad,
+		0x6f, 0x1b, 0x11, 0xc3, 0xa1, 0xa9, 0xd8, 0xbc,
+	};
+	struct aes_enckey key;
+	struct aes_cbcmac_ctx ctx;
+	u8 actual_mac[AES_BLOCK_SIZE];
+	int err;
+
+	err = aes_prepareenckey(&key, raw_key, sizeof(raw_key));
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/*
+	 * Trailing zeroes should not affect the CBC-MAC value, up to the next
+	 * AES block boundary.
+	 */
+	for (size_t data_len = unpadded_data_len; data_len <= sizeof(data);
+	     data_len++) {
+		aes_cbcmac_init(&ctx, &key);
+		aes_cbcmac_update(&ctx, data, data_len);
+		aes_cbcmac_final(&ctx, actual_mac);
+		KUNIT_ASSERT_MEMEQ(test, actual_mac, expected_mac,
+				   AES_BLOCK_SIZE);
+
+		/* Incremental computations should produce the same result. */
+		for (size_t part1_len = 0; part1_len <= data_len; part1_len++) {
+			aes_cbcmac_init(&ctx, &key);
+			aes_cbcmac_update(&ctx, data, part1_len);
+			aes_cbcmac_update(&ctx, &data[part1_len],
+					  data_len - part1_len);
+			aes_cbcmac_final(&ctx, actual_mac);
+			KUNIT_ASSERT_MEMEQ(test, actual_mac, expected_mac,
+					   AES_BLOCK_SIZE);
+		}
+	}
+}
+
+static struct kunit_case aes_cbc_macs_test_cases[] = {
+	HASH_KUNIT_CASES,
+	KUNIT_CASE(test_aes_cmac_rfc4493),
+	KUNIT_CASE(test_aes_xcbcmac_rfc3566),
+	KUNIT_CASE(test_aes_cbcmac_rfc3610),
+	KUNIT_CASE(benchmark_hash),
+	{},
+};
+
+static struct kunit_suite aes_cbc_macs_test_suite = {
+	.name = "aes_cbc_macs",
+	.test_cases = aes_cbc_macs_test_cases,
+	.suite_init = aes_cbc_macs_suite_init,
+	.suite_exit = aes_cbc_macs_suite_exit,
+};
+kunit_test_suite(aes_cbc_macs_test_suite);
+
+MODULE_DESCRIPTION(
+	"KUnit tests and benchmark for AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC");
+MODULE_IMPORT_NS("CRYPTO_INTERNAL");
+MODULE_LICENSE("GPL");
diff --git a/scripts/crypto/gen-hash-testvecs.py b/scripts/crypto/gen-hash-testvecs.py
index 8eeb650fcada..34b7c48f3456 100755
--- a/scripts/crypto/gen-hash-testvecs.py
+++ b/scripts/crypto/gen-hash-testvecs.py
@@ -1,12 +1,16 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Script that generates test vectors for the given hash function.
 #
+# Requires that python-cryptography be installed.
+#
 # Copyright 2025 Google LLC
 
+import cryptography.hazmat.primitives.ciphers
+import cryptography.hazmat.primitives.cmac
 import hashlib
 import hmac
 import sys
 
 DATA_LENS = [0, 1, 2, 3, 16, 32, 48, 49, 63, 64, 65, 127, 128, 129, 256, 511,
@@ -22,10 +26,24 @@ def rand_bytes(length):
     for _ in range(length):
         seed = (seed * 25214903917 + 11) % 2**48
         out.append((seed >> 16) % 256)
     return bytes(out)
 
+AES_256_KEY_SIZE = 32
+
+# AES-CMAC.  Just wraps the implementation from python-cryptography.
+class AesCmac:
+    def __init__(self, key):
+        aes = cryptography.hazmat.primitives.ciphers.algorithms.AES(key)
+        self.cmac = cryptography.hazmat.primitives.cmac.CMAC(aes)
+
+    def update(self, data):
+        self.cmac.update(data)
+
+    def digest(self):
+        return self.cmac.finalize()
+
 POLY1305_KEY_SIZE = 32
 
 # A straightforward, unoptimized implementation of Poly1305.
 # Reference: https://cr.yp.to/mac/poly1305-20050329.pdf
 class Poly1305:
@@ -78,13 +96,16 @@ class Polyval:
 
     def digest(self):
         return self.acc.to_bytes(16, byteorder='little')
 
 def hash_init(alg):
+    # The keyed hash functions are assigned a fixed random key here, to present
+    # them as unkeyed hash functions.  This allows all the test cases for
+    # unkeyed hash functions to work on them.
+    if alg == 'aes-cmac':
+        return AesCmac(rand_bytes(AES_256_KEY_SIZE))
     if alg == 'poly1305':
-        # Use a fixed random key here, to present Poly1305 as an unkeyed hash.
-        # This allows all the test cases for unkeyed hashes to work on Poly1305.
         return Poly1305(rand_bytes(POLY1305_KEY_SIZE))
     if alg == 'polyval':
         return Polyval(rand_bytes(POLYVAL_BLOCK_SIZE))
     return hashlib.new(alg)
 
@@ -114,10 +135,12 @@ def print_c_struct_u8_array_field(name, value):
     print(f'\t\t.{name} = {{')
     print_bytes('\t\t\t', value, 8)
     print('\t\t},')
 
 def alg_digest_size_const(alg):
+    if alg == 'aes-cmac':
+        return 'AES_BLOCK_SIZE'
     if alg.startswith('blake2'):
         return f'{alg.upper()}_HASH_SIZE'
     return f"{alg.upper().replace('-', '_')}_DIGEST_SIZE"
 
 def gen_unkeyed_testvecs(alg):
@@ -250,11 +273,13 @@ if len(sys.argv) != 2:
     sys.exit(1)
 
 alg = sys.argv[1]
 print('/* SPDX-License-Identifier: GPL-2.0-or-later */')
 print(f'/* This file was generated by: {sys.argv[0]} {" ".join(sys.argv[1:])} */')
-if alg.startswith('blake2'):
+if alg == 'aes-cmac':
+    gen_unkeyed_testvecs(alg)
+elif alg.startswith('blake2'):
     gen_unkeyed_testvecs(alg)
     gen_additional_blake2_testvecs(alg)
 elif alg == 'nh':
     gen_nh_testvecs()
 elif alg == 'poly1305':
-- 
2.53.0


