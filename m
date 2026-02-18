Return-Path: <linux-wireless+bounces-31982-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHFZIpIylmktcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31982-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:43:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841B15A596
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 22:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D741F30488EA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8C3338936;
	Wed, 18 Feb 2026 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmNioAnd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1B312832;
	Wed, 18 Feb 2026 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450618; cv=none; b=O7Pv8QwB9BukV7U6FHIVtAXzdVN9+8bv+y3rV/52PHNm+GwzcqhogZacRXN+XmKpmOQZt+YQL26DJcvaqDVXuF6eELPCy/1eRIaqbQbWU70aXw6IwMG89AoKDXU/jwf5fi45n5eMBUUlxmICxM4WUzp+Uj/Ba+K6Sl2+yK2Kgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450618; c=relaxed/simple;
	bh=yUsqjSnPbDX/S+rnsu/6yIO+0mII4wRuFeRbW6zNwMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZE1lrHWcMVCv2kQ7OE/oBnv7BKe3E48Van5UpK7ipFrWlEBF5nQ9nc73lAvTgq8jmrGD3JQalZKU5KeVLbmV6csmWYErnWl8tYTvwoI3us8jbrQQ626ZvaFXNxoxPmvCzSiIyKyiIgyM2GrZvsVwWHxK9061y3PLj4cOMWl/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmNioAnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE83AC2BCAF;
	Wed, 18 Feb 2026 21:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450617;
	bh=yUsqjSnPbDX/S+rnsu/6yIO+0mII4wRuFeRbW6zNwMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmNioAndIDtJqj5zX9UyQqC8ga+DPfMLGWcDMmKgmWKPeQ6Q/tAv1kutYsfIc/rdO
	 LQc6vHbw6C4wUcfk79joquORCE6pT+BwnMNBpRz35c1b2dIWQU+mUHBoeUUpHHchyi
	 vCFdheo5Gr2gOFWWh91VetqLe8BHP3ojSeB/m9Pa9pCjP7cYfZiv2M9q0O7EXkoV98
	 wmhrjyLDJijMQwri+QwicxPTllfq3HVOV4byCCYumyD6TD5KbOUoeNAzTmRzBOEBsw
	 fsl7PXcZvEXEnGPr1/zMWgIe9cTmfaW5UkU/BVNVmge+NzCT6vQT5nTuvpKkpoQSZs
	 J1hK43sD4g2ZQ==
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
Subject: [PATCH 11/15] smb: client: Drop 'allocate_crypto' arg from smb*_calc_signature()
Date: Wed, 18 Feb 2026 13:34:57 -0800
Message-ID: <20260218213501.136844-12-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31982-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 2841B15A596
X-Rspamd-Action: no action

Since the crypto library API is now being used instead of crypto_shash,
all structs for MAC computation are now just fixed-size structs
allocated on the stack; no dynamic allocations are ever required.
Besides being much more efficient, this also means that the
'allocate_crypto' argument to smb2_calc_signature() and
smb3_calc_signature() is no longer used.  Remove this unused argument.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/smb/client/smb2transport.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 0176185a1efc..41009039b4cb 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -202,12 +202,11 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, __u64 ses_id, __u32  tid)
 
 	return tcon;
 }
 
 static int
-smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
-		    bool allocate_crypto)
+smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 {
 	int rc;
 	unsigned char smb2_signature[SMB2_HMACSHA256_SIZE];
 	struct kvec *iov = rqst->rq_iov;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)iov[0].iov_base;
@@ -438,12 +437,11 @@ generate_smb311signingkey(struct cifs_ses *ses,
 
 	return generate_smb3signingkey(ses, server, &triplet);
 }
 
 static int
-smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
-		    bool allocate_crypto)
+smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 {
 	int rc;
 	unsigned char smb3_signature[SMB2_CMACAES_SIZE];
 	struct kvec *iov = rqst->rq_iov;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)iov[0].iov_base;
@@ -451,11 +449,11 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	struct aes_cmac_ctx cmac_ctx;
 	struct smb_rqst drqst;
 	u8 key[SMB3_SIGN_KEY_SIZE];
 
 	if (server->vals->protocol_id <= SMB21_PROT_ID)
-		return smb2_calc_signature(rqst, server, allocate_crypto);
+		return smb2_calc_signature(rqst, server);
 
 	rc = smb3_get_sign_key(le64_to_cpu(shdr->SessionId), server, key);
 	if (unlikely(rc)) {
 		cifs_server_dbg(FYI, "%s: Could not get signing key\n", __func__);
 		return rc;
@@ -522,11 +520,11 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 	if (!is_binding && !server->session_estab) {
 		strscpy(shdr->Signature, "BSRSPYL");
 		return 0;
 	}
 
-	return smb3_calc_signature(rqst, server, false);
+	return smb3_calc_signature(rqst, server);
 }
 
 int
 smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 {
@@ -558,11 +556,11 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 	 */
 	memcpy(server_response_sig, shdr->Signature, SMB2_SIGNATURE_SIZE);
 
 	memset(shdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 
-	rc = smb3_calc_signature(rqst, server, true);
+	rc = smb3_calc_signature(rqst, server);
 
 	if (rc)
 		return rc;
 
 	if (crypto_memneq(server_response_sig, shdr->Signature,
-- 
2.53.0


