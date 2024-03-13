Return-Path: <linux-wireless+bounces-4714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B01887B52F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 00:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DD0284A74
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C15D72B;
	Wed, 13 Mar 2024 23:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWrMu2iM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36435D724;
	Wed, 13 Mar 2024 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372762; cv=none; b=noxz01+0mkuW3PA20nLQS61x8n6trnzx2SfIOEdEc1NeF4Y2sgA5LBg8IslOGeoncn+XtasG5XIAUWeXecmO7ncSfsCcX9ENMkz7KOeMiZMBq7SvY2CJofpanLRpB9ll+23a+g5SaCve/GJKOyZ1DbbRixV00WFqi2Tg3eKa+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372762; c=relaxed/simple;
	bh=CLi8V80P9hGMGXX8d9DNZH8U6+Ts+BP11pAd4B751Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6H5LhZp946sMR0+YDG8UEdQigr83Md20HUsboZYL8jAFFu3l0X+/lp/AEv7B/KMMd5e5C4N6LkQprmDLXTqjq6/Qbgm6OyVbuN5tQbbo+g7651EmD7pQ7H2vwdCI1mdpzovtMX3Zm2eZeYawqlrbMutrCY5Ir3g1fXH699vbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWrMu2iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A2BC433F1;
	Wed, 13 Mar 2024 23:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710372761;
	bh=CLi8V80P9hGMGXX8d9DNZH8U6+Ts+BP11pAd4B751Ws=;
	h=From:To:Cc:Subject:Date:From;
	b=bWrMu2iM+GZs6DFQF/X9Ol4Uh2UhjxFnz5Rs65DUm80Ckc45Nb/ieQHOP3dYrmsGb
	 vj/E/Oow+UYIIS3QzUSwqcj03Dj67KAk4TOeMdMvynjTb3vJUTpXo7SyBvwObLrCbe
	 VTKDilnXPV8BgwmIB1AXn8UOU8Y2kHPWNq6y3sD1xliRGq44URmlLSL2X3mDQsFEPl
	 dUs0DXuXSs0HOVSoIYmaEdunU+LSitnTJFAvO0sIuBAov/2sTJTunK4I1zo5s4rzwr
	 sBIzpMUZT5HTASsKGYO79D6cXL2a11tt0d/HtYuVKShc7cRGMYxsNhD+q5Q7wL/05g
	 Q/LphA35+NFIA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: keyrings@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	iwd@lists.linux.dev,
	James Prestwood <prestwoj@gmail.com>,
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	Karel Balej <balejk@matfyz.cz>
Subject: [PATCH] Revert "crypto: pkcs7 - remove sha1 support"
Date: Wed, 13 Mar 2024 16:32:27 -0700
Message-ID: <20240313233227.56391-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

This reverts commit 16ab7cb5825fc3425c16ad2c6e53d827f382d7c6 because it
broke iwd.  iwd uses the KEYCTL_PKEY_* UAPIs via its dependency libell,
and apparently it is relying on SHA-1 signature support.  These UAPIs
are fairly obscure, and their documentation does not mention which
algorithms they support.  iwd really should be using a properly
supported userspace crypto library instead.  Regardless, since something
broke we have to revert the change.

It may be possible that some parts of this commit can be reinstated
without breaking iwd (e.g. probably the removal of MODULE_SIG_SHA1), but
for now this just does a full revert to get things working again.

Reported-by: Karel Balej <balejk@matfyz.cz>
Closes: https://lore.kernel.org/r/CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz
Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/asymmetric_keys/mscode_parser.c    |  3 +
 crypto/asymmetric_keys/pkcs7_parser.c     |  4 ++
 crypto/asymmetric_keys/public_key.c       |  3 +-
 crypto/asymmetric_keys/signature.c        |  2 +-
 crypto/asymmetric_keys/x509_cert_parser.c |  8 +++
 crypto/testmgr.h                          | 80 +++++++++++++++++++++++
 include/linux/oid_registry.h              |  4 ++
 kernel/module/Kconfig                     |  5 ++
 8 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
index 05402ef8964e..8aecbe4637f3 100644
--- a/crypto/asymmetric_keys/mscode_parser.c
+++ b/crypto/asymmetric_keys/mscode_parser.c
@@ -73,10 +73,13 @@ int mscode_note_digest_algo(void *context, size_t hdrlen,
 	char buffer[50];
 	enum OID oid;
 
 	oid = look_up_OID(value, vlen);
 	switch (oid) {
+	case OID_sha1:
+		ctx->digest_algo = "sha1";
+		break;
 	case OID_sha256:
 		ctx->digest_algo = "sha256";
 		break;
 	case OID_sha384:
 		ctx->digest_algo = "sha384";
diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 5b08c50722d0..231ad7b3789d 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -225,10 +225,13 @@ int pkcs7_sig_note_digest_algo(void *context, size_t hdrlen,
 			       const void *value, size_t vlen)
 {
 	struct pkcs7_parse_context *ctx = context;
 
 	switch (ctx->last_oid) {
+	case OID_sha1:
+		ctx->sinfo->sig->hash_algo = "sha1";
+		break;
 	case OID_sha256:
 		ctx->sinfo->sig->hash_algo = "sha256";
 		break;
 	case OID_sha384:
 		ctx->sinfo->sig->hash_algo = "sha384";
@@ -276,10 +279,11 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
 	switch (ctx->last_oid) {
 	case OID_rsaEncryption:
 		ctx->sinfo->sig->pkey_algo = "rsa";
 		ctx->sinfo->sig->encoding = "pkcs1";
 		break;
+	case OID_id_ecdsa_with_sha1:
 	case OID_id_ecdsa_with_sha224:
 	case OID_id_ecdsa_with_sha256:
 	case OID_id_ecdsa_with_sha384:
 	case OID_id_ecdsa_with_sha512:
 	case OID_id_ecdsa_with_sha3_256:
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index e5f22691febd..e314fd57e6f8 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -113,11 +113,12 @@ software_key_determine_akcipher(const struct public_key *pkey,
 		 * Unfortunately, in practice ECDSA is used with multiple SHAs,
 		 * so we have to allow all of them and not just one.
 		 */
 		if (!hash_algo)
 			return -EINVAL;
-		if (strcmp(hash_algo, "sha224") != 0 &&
+		if (strcmp(hash_algo, "sha1") != 0 &&
+		    strcmp(hash_algo, "sha224") != 0 &&
 		    strcmp(hash_algo, "sha256") != 0 &&
 		    strcmp(hash_algo, "sha384") != 0 &&
 		    strcmp(hash_algo, "sha512") != 0 &&
 		    strcmp(hash_algo, "sha3-256") != 0 &&
 		    strcmp(hash_algo, "sha3-384") != 0 &&
diff --git a/crypto/asymmetric_keys/signature.c b/crypto/asymmetric_keys/signature.c
index 398983be77e8..2deff81f8af5 100644
--- a/crypto/asymmetric_keys/signature.c
+++ b/crypto/asymmetric_keys/signature.c
@@ -113,11 +113,11 @@ EXPORT_SYMBOL_GPL(decrypt_blob);
  * @enc: Signature buffer, length params->enc_len
  *
  * Sign the specified data blob using the private key specified by params->key.
  * The signature is wrapped in an encoding if params->encoding is specified
  * (eg. "pkcs1").  If the encoding needs to know the digest type, this can be
- * passed through params->hash_algo (eg. "sha512").
+ * passed through params->hash_algo (eg. "sha1").
  *
  * Returns the length of the data placed in the signature buffer or an error.
  */
 int create_signature(struct kernel_pkey_params *params,
 		     const void *data, void *enc)
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 487204d39426..bb0bffa271b5 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -196,10 +196,14 @@ int x509_note_sig_algo(void *context, size_t hdrlen, unsigned char tag,
 
 	switch (ctx->last_oid) {
 	default:
 		return -ENOPKG; /* Unsupported combination */
 
+	case OID_sha1WithRSAEncryption:
+		ctx->cert->sig->hash_algo = "sha1";
+		goto rsa_pkcs1;
+
 	case OID_sha256WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha256";
 		goto rsa_pkcs1;
 
 	case OID_sha384WithRSAEncryption:
@@ -212,10 +216,14 @@ int x509_note_sig_algo(void *context, size_t hdrlen, unsigned char tag,
 
 	case OID_sha224WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha224";
 		goto rsa_pkcs1;
 
+	case OID_id_ecdsa_with_sha1:
+		ctx->cert->sig->hash_algo = "sha1";
+		goto ecdsa;
+
 	case OID_id_rsassa_pkcs1_v1_5_with_sha3_256:
 		ctx->cert->sig->hash_algo = "sha3-256";
 		goto rsa_pkcs1;
 
 	case OID_id_rsassa_pkcs1_v1_5_with_sha3_384:
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 986f331a5fc2..12e1c892f366 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -651,10 +651,34 @@ static const struct akcipher_testvec rsa_tv_template[] = {
  * ECDSA test vectors.
  */
 static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	{
 	.key =
+	"\x04\xf7\x46\xf8\x2f\x15\xf6\x22\x8e\xd7\x57\x4f\xcc\xe7\xbb\xc1"
+	"\xd4\x09\x73\xcf\xea\xd0\x15\x07\x3d\xa5\x8a\x8a\x95\x43\xe4\x68"
+	"\xea\xc6\x25\xc1\xc1\x01\x25\x4c\x7e\xc3\x3c\xa6\x04\x0a\xe7\x08"
+	"\x98",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\xcd\xb9\xd2\x1c\xb7\x6f\xcd\x44\xb3\xfd\x63\xea\xa3\x66\x7f\xae"
+	"\x63\x85\xe7\x82",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c =
+	"\x30\x35\x02\x19\x00\xba\xe5\x93\x83\x6e\xb6\x3b\x63\xa0\x27\x91"
+	"\xc6\xf6\x7f\xc3\x09\xad\x59\xad\x88\x27\xd6\x92\x6b\x02\x18\x10"
+	"\x68\x01\x9d\xba\xce\x83\x08\xef\x95\x52\x7b\xa0\x0f\xe4\x18\x86"
+	"\x80\x6f\xa5\x79\x77\xda\xd0",
+	.c_size = 55,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
 	"\x04\xb6\x4b\xb1\xd1\xac\xba\x24\x8f\x65\xb2\x60\x00\x90\xbf\xbd"
 	"\x78\x05\x73\xe9\x79\x1d\x6f\x7c\x0b\xd2\xc3\x93\xa7\x28\xe1\x75"
 	"\xf7\xd5\x95\x1d\x28\x10\xc0\x75\x50\x5c\x1a\x4f\x3f\x8f\xa5\xee"
 	"\xa3",
 	.key_len = 49,
@@ -754,10 +778,36 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 };
 
 static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	{
 	.key =
+	"\x04\xb9\x7b\xbb\xd7\x17\x64\xd2\x7e\xfc\x81\x5d\x87\x06\x83\x41"
+	"\x22\xd6\x9a\xaa\x87\x17\xec\x4f\x63\x55\x2f\x94\xba\xdd\x83\xe9"
+	"\x34\x4b\xf3\xe9\x91\x13\x50\xb6\xcb\xca\x62\x08\xe7\x3b\x09\xdc"
+	"\xc3\x63\x4b\x2d\xb9\x73\x53\xe4\x45\xe6\x7c\xad\xe7\x6b\xb0\xe8"
+	"\xaf",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\xc2\x2b\x5f\x91\x78\x34\x26\x09\x42\x8d\x6f\x51\xb2\xc5\xaf\x4c"
+	"\x0b\xde\x6a\x42",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c =
+	"\x30\x46\x02\x21\x00\xf9\x25\xce\x9f\x3a\xa6\x35\x81\xcf\xd4\xe7"
+	"\xb7\xf0\x82\x56\x41\xf7\xd4\xad\x8d\x94\x5a\x69\x89\xee\xca\x6a"
+	"\x52\x0e\x48\x4d\xcc\x02\x21\x00\xd7\xe4\xef\x52\x66\xd3\x5b\x9d"
+	"\x8a\xfa\x54\x93\x29\xa7\x70\x86\xf1\x03\x03\xf3\x3b\xe2\x73\xf7"
+	"\xfb\x9d\x8b\xde\xd4\x8d\x6f\xad",
+	.c_size = 72,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
 	"\x04\x8b\x6d\xc0\x33\x8e\x2d\x8b\x67\xf5\xeb\xc4\x7f\xa0\xf5\xd9"
 	"\x7b\x03\xa5\x78\x9a\xb5\xea\x14\xe4\x23\xd0\xaf\xd7\x0e\x2e\xa0"
 	"\xc9\x8b\xdb\x95\xf8\xb3\xaf\xac\x00\x2c\x2c\x1f\x7a\xfd\x95\x88"
 	"\x43\x13\xbf\xf3\x1c\x05\x1a\x14\x18\x09\x3f\xd6\x28\x3e\xc5\xa0"
 	"\xd4",
@@ -864,10 +914,40 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	},
 };
 
 static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	{
+	.key = /* secp384r1(sha1) */
+	"\x04\x89\x25\xf3\x97\x88\xcb\xb0\x78\xc5\x72\x9a\x14\x6e\x7a\xb1"
+	"\x5a\xa5\x24\xf1\x95\x06\x9e\x28\xfb\xc4\xb9\xbe\x5a\x0d\xd9\x9f"
+	"\xf3\xd1\x4d\x2d\x07\x99\xbd\xda\xa7\x66\xec\xbb\xea\xba\x79\x42"
+	"\xc9\x34\x89\x6a\xe7\x0b\xc3\xf2\xfe\x32\x30\xbe\xba\xf9\xdf\x7e"
+	"\x4b\x6a\x07\x8e\x26\x66\x3f\x1d\xec\xa2\x57\x91\x51\xdd\x17\x0e"
+	"\x0b\x25\xd6\x80\x5c\x3b\xe6\x1a\x98\x48\x91\x45\x7a\x73\xb0\xc3"
+	"\xf1",
+	.key_len = 97,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x22",
+	.param_len = 18,
+	.m =
+	"\x12\x55\x28\xf0\x77\xd5\xb6\x21\x71\x32\x48\xcd\x28\xa8\x25\x22"
+	"\x3a\x69\xc1\x93",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c =
+	"\x30\x66\x02\x31\x00\xf5\x0f\x24\x4c\x07\x93\x6f\x21\x57\x55\x07"
+	"\x20\x43\x30\xde\xa0\x8d\x26\x8e\xae\x63\x3f\xbc\x20\x3a\xc6\xf1"
+	"\x32\x3c\xce\x70\x2b\x78\xf1\x4c\x26\xe6\x5b\x86\xcf\xec\x7c\x7e"
+	"\xd0\x87\xd7\xd7\x6e\x02\x31\x00\xcd\xbb\x7e\x81\x5d\x8f\x63\xc0"
+	"\x5f\x63\xb1\xbe\x5e\x4c\x0e\xa1\xdf\x28\x8c\x1b\xfa\xf9\x95\x88"
+	"\x74\xa0\x0f\xbf\xaf\xc3\x36\x76\x4a\xa1\x59\xf1\x1c\xa4\x58\x26"
+	"\x79\x12\x2a\xb7\xc5\x15\x92\xc5",
+	.c_size = 104,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
 	.key = /* secp384r1(sha224) */
 	"\x04\x69\x6c\xcf\x62\xee\xd0\x0d\xe5\xb5\x2f\x70\x54\xcf\x26\xa0"
 	"\xd9\x98\x8d\x92\x2a\xab\x9b\x11\xcb\x48\x18\xa1\xa9\x0d\xd5\x18"
 	"\x3e\xe8\x29\x6e\xf6\xe4\xb5\x8e\xc7\x4a\xc2\x5f\x37\x13\x99\x05"
 	"\xb6\xa4\x9d\xf9\xfb\x79\x41\xe7\xd7\x96\x9f\x73\x3b\x39\x43\xdc"
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 3921fbed0b28..51421fdbb0ba 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -15,21 +15,24 @@
  *
  * NOTE!  Do not mess with the format of each line as this is read by
  *	  build_OID_registry.pl to generate the data for look_up_OID().
  */
 enum OID {
+	OID_id_dsa_with_sha1,		/* 1.2.840.10030.4.3 */
 	OID_id_dsa,			/* 1.2.840.10040.4.1 */
 	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
 	OID_id_prime192v1,		/* 1.2.840.10045.3.1.1 */
 	OID_id_prime256v1,		/* 1.2.840.10045.3.1.7 */
+	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
 	OID_id_ecdsa_with_sha224,	/* 1.2.840.10045.4.3.1 */
 	OID_id_ecdsa_with_sha256,	/* 1.2.840.10045.4.3.2 */
 	OID_id_ecdsa_with_sha384,	/* 1.2.840.10045.4.3.3 */
 	OID_id_ecdsa_with_sha512,	/* 1.2.840.10045.4.3.4 */
 
 	/* PKCS#1 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(1)} */
 	OID_rsaEncryption,		/* 1.2.840.113549.1.1.1 */
+	OID_sha1WithRSAEncryption,	/* 1.2.840.113549.1.1.5 */
 	OID_sha256WithRSAEncryption,	/* 1.2.840.113549.1.1.11 */
 	OID_sha384WithRSAEncryption,	/* 1.2.840.113549.1.1.12 */
 	OID_sha512WithRSAEncryption,	/* 1.2.840.113549.1.1.13 */
 	OID_sha224WithRSAEncryption,	/* 1.2.840.113549.1.1.14 */
 	/* PKCS#7 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-7(7)} */
@@ -62,10 +65,11 @@ enum OID {
 
 	OID_IAKerb,			/* 1.3.6.1.5.2.5 */
 	OID_PKU2U,			/* 1.3.5.1.5.2.7 */
 	OID_Scram,			/* 1.3.6.1.5.5.14 */
 	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
+	OID_sha1,			/* 1.3.14.3.2.26 */
 	OID_id_ansip384r1,		/* 1.3.132.0.34 */
 	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
 	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
 	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
 	OID_sha224,			/* 2.16.840.1.101.3.4.2.4 */
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 0ea1b2970a23..28db5b7589eb 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -234,10 +234,14 @@ choice
 	  signature generation.  This algorithm _must_ be built into the kernel
 	  directly so that signature verification can take place.  It is not
 	  possible to load a signed module containing the algorithm to check
 	  the signature on that module.
 
+config MODULE_SIG_SHA1
+	bool "Sign modules with SHA-1"
+	select CRYPTO_SHA1
+
 config MODULE_SIG_SHA256
 	bool "Sign modules with SHA-256"
 	select CRYPTO_SHA256
 
 config MODULE_SIG_SHA384
@@ -263,10 +267,11 @@ config MODULE_SIG_SHA3_512
 endchoice
 
 config MODULE_SIG_HASH
 	string
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	default "sha1" if MODULE_SIG_SHA1
 	default "sha256" if MODULE_SIG_SHA256
 	default "sha384" if MODULE_SIG_SHA384
 	default "sha512" if MODULE_SIG_SHA512
 	default "sha3-256" if MODULE_SIG_SHA3_256
 	default "sha3-384" if MODULE_SIG_SHA3_384

base-commit: 259f7d5e2baf87fcbb4fabc46526c9c47fed1914
-- 
2.44.0


