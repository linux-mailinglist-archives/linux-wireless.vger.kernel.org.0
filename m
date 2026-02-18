Return-Path: <linux-wireless+bounces-31983-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJRXEEcxlml5cAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31983-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:38:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE115A3FC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB9833019CAC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49AD339875;
	Wed, 18 Feb 2026 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5y8ewUh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB831C567;
	Wed, 18 Feb 2026 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450618; cv=none; b=OtIgUNr/a75eOfj+tpMboaicUReQR5y71CNiaHznY82bR1B/x0612BxTdrmW2xhqFP893aalMC7mXbE/GqNs4mrromgr27+qSC3YHh5WEbCOVwUoRXkUIRn9d3ch1yFoWElJDD9NWeSy0qWtOktTSS5/gE4T0lhx8ME6Rwhg1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450618; c=relaxed/simple;
	bh=ZYqIlQtwnbFetuVQNGe0mxtg3leOUfnKsQb3/hSGeAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sx1Bc51a+NIQilVpvuvNzjDxQZyCsv4V5EU8QltnuCy5yLSH6Ho/58vE9W7vCeRJz4+nYZwBR5o8z9udSQTZBQlE6xPBuu5G+8PCFlEUcOA5AatHp6Fx2GbYwB3+NNo/aaE1wtRx2YJtPNI9+UgxkLi0mAUayyoQodNUf2xpgAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5y8ewUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A2C2BCB6;
	Wed, 18 Feb 2026 21:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450618;
	bh=ZYqIlQtwnbFetuVQNGe0mxtg3leOUfnKsQb3/hSGeAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5y8ewUh5ElMc0r4CQ+/6110CWS7emGEDkYxi9P4CD+n9254VvFfIV7kNufM30hwW
	 DYWnPg/aakMF7QE5EbTc764kRKkbqoNWnTXXhvxFBTzDQc3r/S3/LSCEzWj8zxx/cP
	 42DvyGaBxVtDmkIXQ8Hj4n5zS/mq9DIMeiuDdnbFBo42tE2S3POe8vSu0TsUIz+Ygl
	 aJtEbzrsmsPaEEI6l+BNklX7CFr0/D4CDGtYixL5J/TZmXnTwGe8K3r9fdMXjHuDrg
	 q8gyv0iQVwjgObGvyPC4FVQjRPiLMJFyRBxL4ST0gX37y3v1WI80zhrdWMn4bcfQ7+
	 lL2Nhl8W9eMzg==
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
Subject: [PATCH 12/15] ksmbd: Use AES-CMAC library for SMB3 signature calculation
Date: Wed, 18 Feb 2026 13:34:58 -0800
Message-ID: <20260218213501.136844-13-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31983-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CFCE115A3FC
X-Rspamd-Action: no action

Now that AES-CMAC has a library API, convert ksmbd_sign_smb3_pdu() to
use it instead of a "cmac(aes)" crypto_shash.

The result is simpler and faster code.  With the library there's no need
to dynamically allocate memory, no need to handle errors, and the
AES-CMAC code is accessed directly without inefficient indirect calls
and other unnecessary API overhead.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/smb/server/Kconfig      |  2 +-
 fs/smb/server/auth.c       | 51 +++++++++------------------------
 fs/smb/server/auth.h       |  4 +--
 fs/smb/server/crypto_ctx.c | 58 --------------------------------------
 fs/smb/server/crypto_ctx.h | 12 --------
 fs/smb/server/server.c     |  1 -
 fs/smb/server/smb2pdu.c    |  8 ++----
 7 files changed, 19 insertions(+), 117 deletions(-)

diff --git a/fs/smb/server/Kconfig b/fs/smb/server/Kconfig
index 12594879cb64..eae3728cff54 100644
--- a/fs/smb/server/Kconfig
+++ b/fs/smb/server/Kconfig
@@ -6,17 +6,17 @@ config SMB_SERVER
 	select NLS
 	select NLS_UTF8
 	select NLS_UCS2_UTILS
 	select CRYPTO
 	select CRYPTO_ECB
+	select CRYPTO_LIB_AES_CBC_MACS
 	select CRYPTO_LIB_ARC4
 	select CRYPTO_LIB_DES
 	select CRYPTO_LIB_MD5
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_SHA512
 	select CRYPTO_LIB_UTILS
-	select CRYPTO_CMAC
 	select CRYPTO_AEAD2
 	select CRYPTO_CCM
 	select CRYPTO_GCM
 	select ASN1
 	select OID_REGISTRY
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index a69e8694605a..05234e5bd16e 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -9,12 +9,12 @@
 #include <linux/uaccess.h>
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
 #include <linux/uio.h>
 #include <linux/xattr.h>
-#include <crypto/hash.h>
 #include <crypto/aead.h>
+#include <crypto/aes-cbc-macs.h>
 #include <crypto/md5.h>
 #include <crypto/sha2.h>
 #include <crypto/utils.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
@@ -488,50 +488,25 @@ void ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
  * @iov:        buffer iov array
  * @n_vec:	number of iovecs
  * @sig:	signature value generated for client request packet
  *
  */
-int ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
-			int n_vec, char *sig)
+void ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
+			 int n_vec, char *sig)
 {
-	struct ksmbd_crypto_ctx *ctx;
-	int rc, i;
-
-	ctx = ksmbd_crypto_ctx_find_cmacaes();
-	if (!ctx) {
-		ksmbd_debug(AUTH, "could not crypto alloc cmac\n");
-		return -ENOMEM;
-	}
-
-	rc = crypto_shash_setkey(CRYPTO_CMACAES_TFM(ctx),
-				 key,
-				 SMB2_CMACAES_SIZE);
-	if (rc)
-		goto out;
-
-	rc = crypto_shash_init(CRYPTO_CMACAES(ctx));
-	if (rc) {
-		ksmbd_debug(AUTH, "cmaces init error %d\n", rc);
-		goto out;
-	}
+	struct aes_cmac_key cmac_key;
+	struct aes_cmac_ctx cmac_ctx;
+	int i;
 
-	for (i = 0; i < n_vec; i++) {
-		rc = crypto_shash_update(CRYPTO_CMACAES(ctx),
-					 iov[i].iov_base,
-					 iov[i].iov_len);
-		if (rc) {
-			ksmbd_debug(AUTH, "cmaces update error %d\n", rc);
-			goto out;
-		}
-	}
+	/* This cannot fail, since we always pass a valid key length. */
+	static_assert(SMB2_CMACAES_SIZE == AES_KEYSIZE_128);
+	aes_cmac_preparekey(&cmac_key, key, SMB2_CMACAES_SIZE);
 
-	rc = crypto_shash_final(CRYPTO_CMACAES(ctx), sig);
-	if (rc)
-		ksmbd_debug(AUTH, "cmaces generation error %d\n", rc);
-out:
-	ksmbd_release_crypto_ctx(ctx);
-	return rc;
+	aes_cmac_init(&cmac_ctx, &cmac_key);
+	for (i = 0; i < n_vec; i++)
+		aes_cmac_update(&cmac_ctx, iov[i].iov_base, iov[i].iov_len);
+	aes_cmac_final(&cmac_ctx, sig);
 }
 
 struct derivation {
 	struct kvec label;
 	struct kvec context;
diff --git a/fs/smb/server/auth.h b/fs/smb/server/auth.h
index 6d351d61b0e5..5767aabc63c9 100644
--- a/fs/smb/server/auth.h
+++ b/fs/smb/server/auth.h
@@ -52,12 +52,12 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 				   struct ksmbd_conn *conn);
 int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
 			    int in_len,	char *out_blob, int *out_len);
 void ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
 			 int n_vec, char *sig);
-int ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
-			int n_vec, char *sig);
+void ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
+			 int n_vec, char *sig);
 int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess,
 			       struct ksmbd_conn *conn);
 int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess,
 				struct ksmbd_conn *conn);
 void ksmbd_gen_smb30_encryptionkey(struct ksmbd_conn *conn,
diff --git a/fs/smb/server/crypto_ctx.c b/fs/smb/server/crypto_ctx.c
index fe29d186baf6..1cb0ea2042b5 100644
--- a/fs/smb/server/crypto_ctx.c
+++ b/fs/smb/server/crypto_ctx.c
@@ -26,18 +26,10 @@ static inline void free_aead(struct crypto_aead *aead)
 {
 	if (aead)
 		crypto_free_aead(aead);
 }
 
-static void free_shash(struct shash_desc *shash)
-{
-	if (shash) {
-		crypto_free_shash(shash->tfm);
-		kfree(shash);
-	}
-}
-
 static struct crypto_aead *alloc_aead(int id)
 {
 	struct crypto_aead *tfm = NULL;
 
 	switch (id) {
@@ -58,41 +50,14 @@ static struct crypto_aead *alloc_aead(int id)
 	}
 
 	return tfm;
 }
 
-static struct shash_desc *alloc_shash_desc(int id)
-{
-	struct crypto_shash *tfm = NULL;
-	struct shash_desc *shash;
-
-	switch (id) {
-	case CRYPTO_SHASH_CMACAES:
-		tfm = crypto_alloc_shash("cmac(aes)", 0, 0);
-		break;
-	default:
-		return NULL;
-	}
-
-	if (IS_ERR(tfm))
-		return NULL;
-
-	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
-			KSMBD_DEFAULT_GFP);
-	if (!shash)
-		crypto_free_shash(tfm);
-	else
-		shash->tfm = tfm;
-	return shash;
-}
-
 static void ctx_free(struct ksmbd_crypto_ctx *ctx)
 {
 	int i;
 
-	for (i = 0; i < CRYPTO_SHASH_MAX; i++)
-		free_shash(ctx->desc[i]);
 	for (i = 0; i < CRYPTO_AEAD_MAX; i++)
 		free_aead(ctx->ccmaes[i]);
 	kfree(ctx);
 }
 
@@ -151,33 +116,10 @@ void ksmbd_release_crypto_ctx(struct ksmbd_crypto_ctx *ctx)
 	ctx_list.avail_ctx--;
 	spin_unlock(&ctx_list.ctx_lock);
 	ctx_free(ctx);
 }
 
-static struct ksmbd_crypto_ctx *____crypto_shash_ctx_find(int id)
-{
-	struct ksmbd_crypto_ctx *ctx;
-
-	if (id >= CRYPTO_SHASH_MAX)
-		return NULL;
-
-	ctx = ksmbd_find_crypto_ctx();
-	if (ctx->desc[id])
-		return ctx;
-
-	ctx->desc[id] = alloc_shash_desc(id);
-	if (ctx->desc[id])
-		return ctx;
-	ksmbd_release_crypto_ctx(ctx);
-	return NULL;
-}
-
-struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_cmacaes(void)
-{
-	return ____crypto_shash_ctx_find(CRYPTO_SHASH_CMACAES);
-}
-
 static struct ksmbd_crypto_ctx *____crypto_aead_ctx_find(int id)
 {
 	struct ksmbd_crypto_ctx *ctx;
 
 	if (id >= CRYPTO_AEAD_MAX)
diff --git a/fs/smb/server/crypto_ctx.h b/fs/smb/server/crypto_ctx.h
index b9476ed520ae..02d2893665a4 100644
--- a/fs/smb/server/crypto_ctx.h
+++ b/fs/smb/server/crypto_ctx.h
@@ -4,18 +4,12 @@
  */
 
 #ifndef __CRYPTO_CTX_H__
 #define __CRYPTO_CTX_H__
 
-#include <crypto/hash.h>
 #include <crypto/aead.h>
 
-enum {
-	CRYPTO_SHASH_CMACAES	= 0,
-	CRYPTO_SHASH_MAX,
-};
-
 enum {
 	CRYPTO_AEAD_AES_GCM = 16,
 	CRYPTO_AEAD_AES_CCM,
 	CRYPTO_AEAD_MAX,
 };
@@ -26,23 +20,17 @@ enum {
 };
 
 struct ksmbd_crypto_ctx {
 	struct list_head		list;
 
-	struct shash_desc		*desc[CRYPTO_SHASH_MAX];
 	struct crypto_aead		*ccmaes[CRYPTO_AEAD_MAX];
 };
 
-#define CRYPTO_CMACAES(c)	((c)->desc[CRYPTO_SHASH_CMACAES])
-
-#define CRYPTO_CMACAES_TFM(c)	((c)->desc[CRYPTO_SHASH_CMACAES]->tfm)
-
 #define CRYPTO_GCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES_GCM])
 #define CRYPTO_CCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES_CCM])
 
 void ksmbd_release_crypto_ctx(struct ksmbd_crypto_ctx *ctx);
-struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_cmacaes(void);
 struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_gcm(void);
 struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_ccm(void);
 void ksmbd_crypto_destroy(void);
 int ksmbd_crypto_create(void);
 
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index c2c074346da1..cc15d9d8468f 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -631,11 +631,10 @@ MODULE_AUTHOR("Namjae Jeon <linkinjeon@kernel.org>");
 MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: ecb");
 MODULE_SOFTDEP("pre: nls");
 MODULE_SOFTDEP("pre: aes");
-MODULE_SOFTDEP("pre: cmac");
 MODULE_SOFTDEP("pre: aead2");
 MODULE_SOFTDEP("pre: ccm");
 MODULE_SOFTDEP("pre: gcm");
 module_init(ksmbd_server_init)
 module_exit(ksmbd_server_exit)
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7a88cf3bd29e..02bfe15edcab 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8964,12 +8964,11 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	memcpy(signature_req, hdr->Signature, SMB2_SIGNATURE_SIZE);
 	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 	iov[0].iov_base = (char *)&hdr->ProtocolId;
 	iov[0].iov_len = len;
 
-	if (ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature))
-		return 0;
+	ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature);
 
 	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
 		return 0;
 	}
@@ -9016,13 +9015,12 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 		n_vec++;
 	} else {
 		iov = &work->iov[work->iov_idx];
 	}
 
-	if (!ksmbd_sign_smb3_pdu(conn, signing_key, iov, n_vec,
-				 signature))
-		memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
+	ksmbd_sign_smb3_pdu(conn, signing_key, iov, n_vec, signature);
+	memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
 }
 
 /**
  * smb3_preauth_hash_rsp() - handler for computing preauth hash on response
  * @work:   smb work containing response buffer
-- 
2.53.0


