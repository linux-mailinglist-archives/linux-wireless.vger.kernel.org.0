Return-Path: <linux-wireless+bounces-31980-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ENdFv8xlmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31980-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:41:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6F915A4FC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1BED309A62A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9965C337690;
	Wed, 18 Feb 2026 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bflmsHWg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B63375D5;
	Wed, 18 Feb 2026 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450615; cv=none; b=a2VD7OEc6fEyl8UV2gdLafA+biNyZHP2b7YJHp3Hq/VYK76VIkhFa3aWFLlXYzrqHQDyuoDUYvcWn8ZqElJzBI6/lsDVbah1rLVAfGAIMZzbOm6ttqrLdcg7nYNzInxJZM+A0HXqZ0FATfaxyMU/AeoOPXXdTJKdW33cX/wVSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450615; c=relaxed/simple;
	bh=5ChXT8GOxfVTVJ7ZRccEEE7TuA1oPtRqqzapCDcH3D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4GU73kt4URxRgwxRpm0ra6QrCTLeTKAAQo8b91xP3n6WaHTBb8flRC2N5YClPieJMOVKZifeP6XJzAjJdWEPedbJyPCfJxFFyHySvqyuWEjMbNrOu2iFcH9fCieabzvNppbirz4RWe1iYH8RjGqvXDBpMZP/hj9oUuntxWp8E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bflmsHWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE38BC19422;
	Wed, 18 Feb 2026 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450615;
	bh=5ChXT8GOxfVTVJ7ZRccEEE7TuA1oPtRqqzapCDcH3D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bflmsHWg+61Iok0YtQ+cSBh3ad/TVqbOLSKzj5XlqhhL0m3ThlQWUx5qsc6aSCndf
	 Z5hwiJ2HfOeSqqij4CMAM3/U7uA4N2wiOFpmTCT/9eQM/xkJ+/9oaNs8o8H9fNcN90
	 yFaG+jDh9pWhxkH62QU4P32DCvyaN2I0i9o0/G3NKiwBFMBobnJ8fvFI6DVOlvFVOJ
	 A1rGXtxWN0vrF9VV+ThVdv4qW9CAnECcPdSTUGx0VZ6wqHyxKIvdoK796X8GByXFpf
	 JOM9lYPqKCmqDd59IeNPOKyVsN1aHbp1A6XhqfAuqL0ct+zGId73+YdRqSY5aP/9Qz
	 UrCjRHHkGkwfg==
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
Subject: [PATCH 09/15] smb: client: Remove obsolete cmac(aes) allocation
Date: Wed, 18 Feb 2026 13:34:55 -0800
Message-ID: <20260218213501.136844-10-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31980-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: ED6F915A4FC
X-Rspamd-Action: no action

Since the crypto library API is now being used instead of crypto_shash,
the "cmac(aes)" crypto_shash that is being allocated and stored in
'struct cifs_secmech' is no longer used.  Remove it.

That makes the kconfig selection of CRYPTO_CMAC and the module softdep
on "cmac" unnecessary.  So remove those too.

Finally, since this removes the last use of crypto_shash from the smb
client, also remove the remaining crypto_shash-related helper functions.

Note: cifs_unicode.c was relying on <linux/unaligned.h> being included
transitively via <crypto/internal/hash.h>.  Since the latter include is
removed, make cifs_unicode.c include <linux/unaligned.h> explicitly.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/smb/client/Kconfig         |  1 -
 fs/smb/client/cifs_unicode.c  |  1 +
 fs/smb/client/cifsencrypt.c   |  2 --
 fs/smb/client/cifsfs.c        |  1 -
 fs/smb/client/cifsglob.h      |  5 +--
 fs/smb/client/cifsproto.h     |  3 --
 fs/smb/client/misc.c          | 57 -----------------------------------
 fs/smb/client/sess.c          | 11 -------
 fs/smb/client/smb2proto.h     |  1 -
 fs/smb/client/smb2transport.c | 15 ---------
 10 files changed, 2 insertions(+), 95 deletions(-)

diff --git a/fs/smb/client/Kconfig b/fs/smb/client/Kconfig
index 64afd302202f..29d7dffab51b 100644
--- a/fs/smb/client/Kconfig
+++ b/fs/smb/client/Kconfig
@@ -3,11 +3,10 @@ config CIFS
 	tristate "SMB3 and CIFS support (advanced network filesystem)"
 	depends on INET
 	select NLS
 	select NLS_UCS2_UTILS
 	select CRYPTO
-	select CRYPTO_CMAC
 	select CRYPTO_AEAD2
 	select CRYPTO_CCM
 	select CRYPTO_GCM
 	select CRYPTO_ECB
 	select CRYPTO_AES
diff --git a/fs/smb/client/cifs_unicode.c b/fs/smb/client/cifs_unicode.c
index e7891b4406f2..c6e81ba011bb 100644
--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -4,10 +4,11 @@
  *   Copyright (c) International Business Machines  Corp., 2000,2009
  *   Modified by Steve French (sfrench@us.ibm.com)
  */
 #include <linux/fs.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
 #include "cifs_fs_sb.h"
 #include "cifs_unicode.h"
 #include "cifsglob.h"
 #include "cifs_debug.h"
 
diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index f39894113821..a566ce2ae9f8 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -501,12 +501,10 @@ calc_seckey(struct cifs_ses *ses)
 }
 
 void
 cifs_crypto_secmech_release(struct TCP_Server_Info *server)
 {
-	cifs_free_hash(&server->secmech.aes_cmac);
-
 	if (server->secmech.enc) {
 		crypto_free_aead(server->secmech.enc);
 		server->secmech.enc = NULL;
 	}
 	if (server->secmech.dec) {
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index afda1d7c1ee1..46499bdcebfe 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -2142,11 +2142,10 @@ MODULE_DESCRIPTION
 	"also older servers complying with the SNIA CIFS Specification)");
 MODULE_VERSION(CIFS_VERSION);
 MODULE_SOFTDEP("ecb");
 MODULE_SOFTDEP("nls");
 MODULE_SOFTDEP("aes");
-MODULE_SOFTDEP("cmac");
 MODULE_SOFTDEP("aead2");
 MODULE_SOFTDEP("ccm");
 MODULE_SOFTDEP("gcm");
 module_init(init_cifs)
 module_exit(exit_cifs)
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 2ff43bd35c5f..24f2a367aad5 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -20,11 +20,10 @@
 #include <linux/utsname.h>
 #include <linux/sched/mm.h>
 #include <linux/netfs.h>
 #include "cifs_fs_sb.h"
 #include "cifsacl.h"
-#include <crypto/internal/hash.h>
 #include <uapi/linux/cifs/cifs_mount.h>
 #include "../common/smbglob.h"
 #include "../common/smb2pdu.h"
 #include "../common/fscc.h"
 #include "smb2pdu.h"
@@ -218,14 +217,12 @@ static inline const char *cifs_symlink_type_str(enum cifs_symlink_type type)
 struct session_key {
 	unsigned int len;
 	char *response;
 };
 
-/* crypto hashing related structure/fields, not specific to a sec mech */
+/* encryption related structure/fields, not specific to a sec mech */
 struct cifs_secmech {
-	struct shash_desc *aes_cmac; /* block-cipher based MAC function, for SMB3 signatures */
-
 	struct crypto_aead *enc; /* smb3 encryption AEAD TFM (AES-CCM and AES-GCM) */
 	struct crypto_aead *dec; /* smb3 decryption AEAD TFM (AES-CCM and AES-GCM) */
 };
 
 /* per smb session structure/fields */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 96d6b5325aa3..025db2285968 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -345,13 +345,10 @@ int __cifs_calc_signature(struct smb_rqst *rqst,
 			  struct TCP_Server_Info *server, char *signature,
 			  struct cifs_calc_sig_ctx *ctx);
 enum securityEnum cifs_select_sectype(struct TCP_Server_Info *server,
 				      enum securityEnum requested);
 
-int cifs_alloc_hash(const char *name, struct shash_desc **sdesc);
-void cifs_free_hash(struct shash_desc **sdesc);
-
 int cifs_try_adding_channels(struct cifs_ses *ses);
 int smb3_update_ses_channels(struct cifs_ses *ses,
 			     struct TCP_Server_Info *server,
 			     bool from_reconnect, bool disable_mchan);
 bool is_ses_using_iface(struct cifs_ses *ses, struct cifs_server_iface *iface);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 1773e3b471aa..d7300d224a63 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -736,67 +736,10 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		*num_of_nodes = 0;
 	}
 	return rc;
 }
 
-/**
- * cifs_alloc_hash - allocate hash and hash context together
- * @name: The name of the crypto hash algo
- * @sdesc: SHASH descriptor where to put the pointer to the hash TFM
- *
- * The caller has to make sure @sdesc is initialized to either NULL or
- * a valid context. It can be freed via cifs_free_hash().
- */
-int
-cifs_alloc_hash(const char *name, struct shash_desc **sdesc)
-{
-	int rc = 0;
-	struct crypto_shash *alg = NULL;
-
-	if (*sdesc)
-		return 0;
-
-	alg = crypto_alloc_shash(name, 0, 0);
-	if (IS_ERR(alg)) {
-		cifs_dbg(VFS, "Could not allocate shash TFM '%s'\n", name);
-		rc = PTR_ERR(alg);
-		*sdesc = NULL;
-		return rc;
-	}
-
-	*sdesc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(alg), GFP_KERNEL);
-	if (*sdesc == NULL) {
-		cifs_dbg(VFS, "no memory left to allocate shash TFM '%s'\n", name);
-		crypto_free_shash(alg);
-		return -ENOMEM;
-	}
-
-	(*sdesc)->tfm = alg;
-	return 0;
-}
-
-/**
- * cifs_free_hash - free hash and hash context together
- * @sdesc: Where to find the pointer to the hash TFM
- *
- * Freeing a NULL descriptor is safe.
- */
-void
-cifs_free_hash(struct shash_desc **sdesc)
-{
-	if (unlikely(!sdesc) || !*sdesc)
-		return;
-
-	if ((*sdesc)->tfm) {
-		crypto_free_shash((*sdesc)->tfm);
-		(*sdesc)->tfm = NULL;
-	}
-
-	kfree_sensitive(*sdesc);
-	*sdesc = NULL;
-}
-
 void extract_unc_hostname(const char *unc, const char **h, size_t *len)
 {
 	const char *end;
 
 	/* skip initial slashes */
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index d523540565ef..11a09a1d8806 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -593,21 +593,10 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 	cifs_chan_set_need_reconnect(ses, chan->server);
 
 	spin_unlock(&ses->chan_lock);
 
 	mutex_lock(&ses->session_mutex);
-	/*
-	 * We need to allocate the server crypto now as we will need
-	 * to sign packets before we generate the channel signing key
-	 * (we sign with the session key)
-	 */
-	rc = smb3_crypto_shash_allocate(chan->server);
-	if (rc) {
-		cifs_dbg(VFS, "%s: crypto alloc failed\n", __func__);
-		mutex_unlock(&ses->session_mutex);
-		goto out;
-	}
 
 	rc = cifs_negotiate_protocol(xid, ses, chan->server);
 	if (!rc)
 		rc = cifs_setup_session(xid, ses, chan->server, ses->local_nls);
 
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 881e42cf66ce..e7b35d500943 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -253,11 +253,10 @@ int smb2_validate_iov(unsigned int offset, unsigned int buffer_length,
 int smb2_validate_and_copy_iov(unsigned int offset, unsigned int buffer_length,
 			       struct kvec *iov, unsigned int minbufsize,
 			       char *data);
 void smb2_copy_fs_info_to_kstatfs(struct smb2_fs_full_size_info *pfs_inf,
 				  struct kstatfs *kst);
-int smb3_crypto_shash_allocate(struct TCP_Server_Info *server);
 void smb311_update_preauth_hash(struct cifs_ses *ses,
 				struct TCP_Server_Info *server,
 				struct kvec *iov, int nvec);
 int smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
 			     const char *path, u32 desired_access, u32 class,
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index b233e0cd9152..716e58d1b1c9 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -27,18 +27,10 @@
 #include "smb2proto.h"
 #include "cifs_debug.h"
 #include "../common/smb2status.h"
 #include "smb2glob.h"
 
-int
-smb3_crypto_shash_allocate(struct TCP_Server_Info *server)
-{
-	struct cifs_secmech *p = &server->secmech;
-
-	return cifs_alloc_hash("cmac(aes)", &p->aes_cmac);
-}
-
 static
 int smb3_get_sign_key(__u64 ses_id, struct TCP_Server_Info *server, u8 *key)
 {
 	struct cifs_chan *chan;
 	struct TCP_Server_Info *pserver;
@@ -264,24 +256,17 @@ static int generate_key(struct cifs_ses *ses, struct kvec label,
 {
 	unsigned char zero = 0x0;
 	__u8 i[4] = {0, 0, 0, 1};
 	__u8 L128[4] = {0, 0, 0, 128};
 	__u8 L256[4] = {0, 0, 1, 0};
-	int rc = 0;
 	unsigned char prfhash[SMB2_HMACSHA256_SIZE];
 	struct TCP_Server_Info *server = ses->server;
 	struct hmac_sha256_ctx hmac_ctx;
 
 	memset(prfhash, 0x0, SMB2_HMACSHA256_SIZE);
 	memset(key, 0x0, key_size);
 
-	rc = smb3_crypto_shash_allocate(server);
-	if (rc) {
-		cifs_server_dbg(VFS, "%s: crypto alloc failed\n", __func__);
-		return rc;
-	}
-
 	hmac_sha256_init_usingrawkey(&hmac_ctx, ses->auth_key.response,
 				     SMB2_NTLMV2_SESSKEY_SIZE);
 	hmac_sha256_update(&hmac_ctx, i, 4);
 	hmac_sha256_update(&hmac_ctx, label.iov_base, label.iov_len);
 	hmac_sha256_update(&hmac_ctx, &zero, 1);
-- 
2.53.0


