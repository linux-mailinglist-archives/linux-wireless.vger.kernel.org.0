Return-Path: <linux-wireless+bounces-31979-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIZmLtwxlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31979-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:40:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34915A4C8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01FFE308B41A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD643370FF;
	Wed, 18 Feb 2026 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su8jtnhs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C13370F3;
	Wed, 18 Feb 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450614; cv=none; b=AqHclAmbAOGasS300cPp6WOfHldXAaieVPIJhiyy/XZMPutzI+cbzbWNr8inPBI38Odi96jsyoP4DNZijehOkP+lzYFyrbs8o0Tnv0EtRrla/azctTNBoPen9FUZ2UTxLceZ7vNx1weyFqlz9Fqo96EoT3NAWLkF/2jwGRjX7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450614; c=relaxed/simple;
	bh=RfXKwO9L3mlz5kqOurMbNRJCV4vYWaJHp6x9x+hkRPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0UHcHA61SGJE2C5eVFWkFMYdJDF387/UaaSS1jP09yiWbR5fag1UtF3CO5RKTmre37sjM5ycjyI9UVabGbJOTCuZQTFZOlzNp/D/Zc3sQ0qzagthLDpaF1zVIWwdx8qgEYf1PO7HJTDL2g3QH6TUAcNr3355FaTqrwF2PKUjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su8jtnhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D2CC2BCB2;
	Wed, 18 Feb 2026 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450614;
	bh=RfXKwO9L3mlz5kqOurMbNRJCV4vYWaJHp6x9x+hkRPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Su8jtnhsciBt1sckGun8RAAdjFMXTLnvoRdF+ZZ7Tf+YPetiXSfdMtWA+QCrq/xuZ
	 LC+tZUeX5QgxkAU1DH9WFTtxMlERcAAtnUJwHX8FpeXH9lx/jmbjWTbjl3ooJ98GFd
	 NkvmtcEfxgccMdgMGT4QwVMtCQvvxh3sHqP41VWdfhD6g+QpIzYSyGbKRvfPuX+AFs
	 i+ny6LvBf9MroUEPF8hCY5B1qpRdzypyCee0GTJ2phCjowvtvZaBl/Ox1dd991a22j
	 YabktEmIWGaQVTKjgRCGGUqVbTdhWXQ1IPRxinbAfHwrnFlg4FVLKiLYhgy3wSlbID
	 oeGNcXA04Nsww==
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
Subject: [PATCH 08/15] smb: client: Use AES-CMAC library for SMB3 signature calculation
Date: Wed, 18 Feb 2026 13:34:54 -0800
Message-ID: <20260218213501.136844-9-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31979-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 3E34915A4C8
X-Rspamd-Action: no action

Convert smb3_calc_signature() to use the AES-CMAC library instead of a
"cmac(aes)" crypto_shash.

The result is simpler and faster code.  With the library there's no need
to allocate memory, no need to handle errors except for key preparation,
and the AES-CMAC code is accessed directly without inefficient indirect
calls and other unnecessary API overhead.

For now a "cmac(aes)" crypto_shash is still being allocated in
'struct cifs_secmech'.  Later commits will remove that, simplifying the
code even further.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/smb/client/Kconfig         |  1 +
 fs/smb/client/cifsencrypt.c   | 60 ++++++++++++-----------------------
 fs/smb/client/cifsglob.h      |  2 +-
 fs/smb/client/smb2transport.c | 41 +++++-------------------
 4 files changed, 30 insertions(+), 74 deletions(-)

diff --git a/fs/smb/client/Kconfig b/fs/smb/client/Kconfig
index 17bd368574e9..64afd302202f 100644
--- a/fs/smb/client/Kconfig
+++ b/fs/smb/client/Kconfig
@@ -9,10 +9,11 @@ config CIFS
 	select CRYPTO_AEAD2
 	select CRYPTO_CCM
 	select CRYPTO_GCM
 	select CRYPTO_ECB
 	select CRYPTO_AES
+	select CRYPTO_LIB_AES_CBC_MACS
 	select CRYPTO_LIB_ARC4
 	select CRYPTO_LIB_MD5
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_SHA512
 	select KEYS
diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 50b7ec39053c..f39894113821 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -20,66 +20,49 @@
 #include <linux/random.h>
 #include <linux/highmem.h>
 #include <linux/fips.h>
 #include <linux/iov_iter.h>
 #include <crypto/aead.h>
+#include <crypto/aes-cbc-macs.h>
 #include <crypto/arc4.h>
 #include <crypto/md5.h>
 #include <crypto/sha2.h>
 
-static int cifs_sig_update(struct cifs_calc_sig_ctx *ctx,
-			   const u8 *data, size_t len)
+static size_t cifs_sig_step(void *iter_base, size_t progress, size_t len,
+			    void *priv, void *priv2)
 {
-	if (ctx->md5) {
-		md5_update(ctx->md5, data, len);
-		return 0;
-	}
-	if (ctx->hmac) {
-		hmac_sha256_update(ctx->hmac, data, len);
-		return 0;
-	}
-	return crypto_shash_update(ctx->shash, data, len);
+	struct cifs_calc_sig_ctx *ctx = priv;
+
+	if (ctx->md5)
+		md5_update(ctx->md5, iter_base, len);
+	else if (ctx->hmac)
+		hmac_sha256_update(ctx->hmac, iter_base, len);
+	else
+		aes_cmac_update(ctx->cmac, iter_base, len);
+	return 0; /* Return value is length *not* processed, i.e. 0. */
 }
 
-static int cifs_sig_final(struct cifs_calc_sig_ctx *ctx, u8 *out)
+static void cifs_sig_final(struct cifs_calc_sig_ctx *ctx, u8 *out)
 {
-	if (ctx->md5) {
+	if (ctx->md5)
 		md5_final(ctx->md5, out);
-		return 0;
-	}
-	if (ctx->hmac) {
+	else if (ctx->hmac)
 		hmac_sha256_final(ctx->hmac, out);
-		return 0;
-	}
-	return crypto_shash_final(ctx->shash, out);
-}
-
-static size_t cifs_sig_step(void *iter_base, size_t progress, size_t len,
-			    void *priv, void *priv2)
-{
-	struct cifs_calc_sig_ctx *ctx = priv;
-	int ret, *pret = priv2;
-
-	ret = cifs_sig_update(ctx, iter_base, len);
-	if (ret < 0) {
-		*pret = ret;
-		return len;
-	}
-	return 0;
+	else
+		aes_cmac_final(ctx->cmac, out);
 }
 
 /*
  * Pass the data from an iterator into a hash.
  */
 static int cifs_sig_iter(const struct iov_iter *iter, size_t maxsize,
 			 struct cifs_calc_sig_ctx *ctx)
 {
 	struct iov_iter tmp_iter = *iter;
 	size_t did;
-	int err;
 
-	did = iterate_and_advance_kernel(&tmp_iter, maxsize, ctx, &err,
+	did = iterate_and_advance_kernel(&tmp_iter, maxsize, ctx, NULL,
 					 cifs_sig_step);
 	if (did != maxsize)
 		return smb_EIO2(smb_eio_trace_sig_iter, did, maxsize);
 	return 0;
 }
@@ -106,15 +89,12 @@ int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 
 	rc = cifs_sig_iter(&rqst->rq_iter, iov_iter_count(&rqst->rq_iter), ctx);
 	if (rc < 0)
 		return rc;
 
-	rc = cifs_sig_final(ctx, signature);
-	if (rc)
-		cifs_dbg(VFS, "%s: Could not generate hash\n", __func__);
-
-	return rc;
+	cifs_sig_final(ctx, signature);
+	return 0;
 }
 
 /* Build a proper attribute value/target info pairs blob.
  * Fill in netbios and dns domain name and workstation name
  * and client time (total five av pairs and + one end of fields indicator.
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 080ea601c209..2ff43bd35c5f 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2285,11 +2285,11 @@ static inline void mid_execute_callback(struct TCP_Server_Info *server,
 	  FILE_SUPPORTS_REPARSE_POINTS))
 
 struct cifs_calc_sig_ctx {
 	struct md5_ctx *md5;
 	struct hmac_sha256_ctx *hmac;
-	struct shash_desc *shash;
+	struct aes_cmac_ctx *cmac;
 };
 
 #define CIFS_RECONN_DELAY_SECS	30
 #define CIFS_MAX_RECONN_DELAY	(4 * CIFS_RECONN_DELAY_SECS)
 
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 81be2b226e26..b233e0cd9152 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -17,10 +17,11 @@
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 #include <linux/mempool.h>
 #include <linux/highmem.h>
 #include <crypto/aead.h>
+#include <crypto/aes-cbc-macs.h>
 #include <crypto/sha2.h>
 #include <crypto/utils.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "smb2proto.h"
@@ -472,11 +473,12 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 {
 	int rc;
 	unsigned char smb3_signature[SMB2_CMACAES_SIZE];
 	struct kvec *iov = rqst->rq_iov;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)iov[0].iov_base;
-	struct shash_desc *shash = NULL;
+	struct aes_cmac_key cmac_key;
+	struct aes_cmac_ctx cmac_ctx;
 	struct smb_rqst drqst;
 	u8 key[SMB3_SIGN_KEY_SIZE];
 
 	if (server->vals->protocol_id <= SMB21_PROT_ID)
 		return smb2_calc_signature(rqst, server, allocate_crypto);
@@ -485,67 +487,40 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	if (unlikely(rc)) {
 		cifs_server_dbg(FYI, "%s: Could not get signing key\n", __func__);
 		return rc;
 	}
 
-	if (allocate_crypto) {
-		rc = cifs_alloc_hash("cmac(aes)", &shash);
-		if (rc)
-			return rc;
-	} else {
-		shash = server->secmech.aes_cmac;
-	}
-
 	memset(smb3_signature, 0x0, SMB2_CMACAES_SIZE);
 	memset(shdr->Signature, 0x0, SMB2_SIGNATURE_SIZE);
 
-	rc = crypto_shash_setkey(shash->tfm, key, SMB2_CMACAES_SIZE);
+	rc = aes_cmac_preparekey(&cmac_key, key, SMB2_CMACAES_SIZE);
 	if (rc) {
 		cifs_server_dbg(VFS, "%s: Could not set key for cmac aes\n", __func__);
-		goto out;
+		return rc;
 	}
 
-	/*
-	 * we already allocate aes_cmac when we init smb3 signing key,
-	 * so unlike smb2 case we do not have to check here if secmech are
-	 * initialized
-	 */
-	rc = crypto_shash_init(shash);
-	if (rc) {
-		cifs_server_dbg(VFS, "%s: Could not init cmac aes\n", __func__);
-		goto out;
-	}
+	aes_cmac_init(&cmac_ctx, &cmac_key);
 
 	/*
 	 * For SMB2+, __cifs_calc_signature() expects to sign only the actual
 	 * data, that is, iov[0] should not contain a rfc1002 length.
 	 *
 	 * Sign the rfc1002 length prior to passing the data (iov[1-N]) down to
 	 * __cifs_calc_signature().
 	 */
 	drqst = *rqst;
 	if (drqst.rq_nvec >= 2 && iov[0].iov_len == 4) {
-		rc = crypto_shash_update(shash, iov[0].iov_base,
-					 iov[0].iov_len);
-		if (rc) {
-			cifs_server_dbg(VFS, "%s: Could not update with payload\n",
-				 __func__);
-			goto out;
-		}
+		aes_cmac_update(&cmac_ctx, iov[0].iov_base, iov[0].iov_len);
 		drqst.rq_iov++;
 		drqst.rq_nvec--;
 	}
 
 	rc = __cifs_calc_signature(
 		&drqst, server, smb3_signature,
-		&(struct cifs_calc_sig_ctx){ .shash = shash });
+		&(struct cifs_calc_sig_ctx){ .cmac = &cmac_ctx });
 	if (!rc)
 		memcpy(shdr->Signature, smb3_signature, SMB2_SIGNATURE_SIZE);
-
-out:
-	if (allocate_crypto)
-		cifs_free_hash(&shash);
 	return rc;
 }
 
 /* must be called with server->srv_mutex held */
 static int
-- 
2.53.0


