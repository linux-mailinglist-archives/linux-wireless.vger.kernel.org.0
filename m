Return-Path: <linux-wireless+bounces-31981-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGuoHicylmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31981-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:41:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D29815A532
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04CAB303EAAF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24893382CD;
	Wed, 18 Feb 2026 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0vKBFRD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B65D2FE575;
	Wed, 18 Feb 2026 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450616; cv=none; b=TLUCR7pWE8DBQviNsT//f6Pa0dulOoBLETa9BdVnu5INIKXRBKYNWxxSp3zj2WnXhnwWSpAGhyb9Frz3ZrVRGx9yCmD5XkJtnxM9Lcvl/cT5mJdVQI7T+3UBrYi12gn3+w+NyntjsT7zupYtSyGHJS9Vnx+JisRqmNQaIqZja1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450616; c=relaxed/simple;
	bh=LoZhuuxzNWOyrPmwe9ku8/14QhyJ8CKzIMFUQopSDgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAr++gPo9lZFRQ7KFvGlBheQrNNE2iHJcXWEpIagIEEpaOQQeLkgWjRERWq0x0rVnXCvaQz7cEhTbwBBheR9HD+QipfUm3D3ige9GpQuVbNY6J8ikNQ+xPrHC8C0lSpsVWiUjLowsdcfL/Xl3taXD7Lo0SZi57bTqoXs1OkNR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0vKBFRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F24C19421;
	Wed, 18 Feb 2026 21:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450616;
	bh=LoZhuuxzNWOyrPmwe9ku8/14QhyJ8CKzIMFUQopSDgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0vKBFRDl5TZsypRiZLNxLu+gyGyL/z7hDpq+OPPeKBKVI4VkdjUN6evSVA+WExM4
	 M5wEqlOBLmYXFkedkv22ojxpcmNWsKHhqYotwkXWhivyLdyWuXh6DpmlslLgzNfSFt
	 aV8XJw8qfD0RbGBKHO9BKzaNODK7LY0h6V+UNcn9Tj2d5U6gSQ5CAdSDgN7fKUG1yA
	 trftxnltQKqv2rFNPbkRjJNBq7qw4hrLp4KfWkfkachUqZ+60bmF1+6jsHlBZNnen9
	 DSHxYzddUtracdqj55ayRleE2P3sNmGU0zojugQw/semrjOQZHbAjbmF9g8ZNX4pwt
	 GpjaoIQ5XEixA==
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
Subject: [PATCH 10/15] smb: client: Make generate_key() return void
Date: Wed, 18 Feb 2026 13:34:56 -0800
Message-ID: <20260218213501.136844-11-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31981-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 1D29815A532
X-Rspamd-Action: no action

Since the crypto library API is now being used instead of crypto_shash,
generate_key() can no longer fail.  Make it return void and simplify the
callers accordingly.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/smb/client/smb2transport.c | 45 +++++++++++++----------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 716e58d1b1c9..0176185a1efc 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -249,12 +249,12 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 		memcpy(shdr->Signature, smb2_signature, SMB2_SIGNATURE_SIZE);
 
 	return rc;
 }
 
-static int generate_key(struct cifs_ses *ses, struct kvec label,
-			struct kvec context, __u8 *key, unsigned int key_size)
+static void generate_key(struct cifs_ses *ses, struct kvec label,
+			 struct kvec context, __u8 *key, unsigned int key_size)
 {
 	unsigned char zero = 0x0;
 	__u8 i[4] = {0, 0, 0, 1};
 	__u8 L128[4] = {0, 0, 0, 128};
 	__u8 L256[4] = {0, 0, 1, 0};
@@ -279,11 +279,10 @@ static int generate_key(struct cifs_ses *ses, struct kvec label,
 		hmac_sha256_update(&hmac_ctx, L128, 4);
 	}
 	hmac_sha256_final(&hmac_ctx, prfhash);
 
 	memcpy(key, prfhash, key_size);
-	return 0;
 }
 
 struct derivation {
 	struct kvec label;
 	struct kvec context;
@@ -298,11 +297,10 @@ struct derivation_triplet {
 static int
 generate_smb3signingkey(struct cifs_ses *ses,
 			struct TCP_Server_Info *server,
 			const struct derivation_triplet *ptriplet)
 {
-	int rc;
 	bool is_binding = false;
 	int chan_index = 0;
 
 	spin_lock(&ses->ses_lock);
 	spin_lock(&ses->chan_lock);
@@ -329,42 +327,31 @@ generate_smb3signingkey(struct cifs_ses *ses,
 	 * key and store it in the channel as to not overwrite the
 	 * master connection signing key stored in the session
 	 */
 
 	if (is_binding) {
-		rc = generate_key(ses, ptriplet->signing.label,
-				  ptriplet->signing.context,
-				  ses->chans[chan_index].signkey,
-				  SMB3_SIGN_KEY_SIZE);
-		if (rc)
-			return rc;
+		generate_key(ses, ptriplet->signing.label,
+			     ptriplet->signing.context,
+			     ses->chans[chan_index].signkey,
+			     SMB3_SIGN_KEY_SIZE);
 	} else {
-		rc = generate_key(ses, ptriplet->signing.label,
-				  ptriplet->signing.context,
-				  ses->smb3signingkey,
-				  SMB3_SIGN_KEY_SIZE);
-		if (rc)
-			return rc;
+		generate_key(ses, ptriplet->signing.label,
+			     ptriplet->signing.context,
+			     ses->smb3signingkey, SMB3_SIGN_KEY_SIZE);
 
 		/* safe to access primary channel, since it will never go away */
 		spin_lock(&ses->chan_lock);
 		memcpy(ses->chans[chan_index].signkey, ses->smb3signingkey,
 		       SMB3_SIGN_KEY_SIZE);
 		spin_unlock(&ses->chan_lock);
 
-		rc = generate_key(ses, ptriplet->encryption.label,
-				  ptriplet->encryption.context,
-				  ses->smb3encryptionkey,
-				  SMB3_ENC_DEC_KEY_SIZE);
-		if (rc)
-			return rc;
-		rc = generate_key(ses, ptriplet->decryption.label,
-				  ptriplet->decryption.context,
-				  ses->smb3decryptionkey,
-				  SMB3_ENC_DEC_KEY_SIZE);
-		if (rc)
-			return rc;
+		generate_key(ses, ptriplet->encryption.label,
+			     ptriplet->encryption.context,
+			     ses->smb3encryptionkey, SMB3_ENC_DEC_KEY_SIZE);
+		generate_key(ses, ptriplet->decryption.label,
+			     ptriplet->decryption.context,
+			     ses->smb3decryptionkey, SMB3_ENC_DEC_KEY_SIZE);
 	}
 
 #ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
 	cifs_dbg(VFS, "%s: dumping generated AES session keys\n", __func__);
 	/*
@@ -389,11 +376,11 @@ generate_smb3signingkey(struct cifs_ses *ses,
 				SMB3_GCM128_CRYPTKEY_SIZE, ses->smb3encryptionkey);
 		cifs_dbg(VFS, "ServerOut Key %*ph\n",
 				SMB3_GCM128_CRYPTKEY_SIZE, ses->smb3decryptionkey);
 	}
 #endif
-	return rc;
+	return 0;
 }
 
 int
 generate_smb30signingkey(struct cifs_ses *ses,
 			 struct TCP_Server_Info *server)
-- 
2.53.0


