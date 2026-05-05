Return-Path: <linux-wireless+bounces-35955-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKP/J9xe+mm3OAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35955-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 23:19:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B244D3DBC
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 23:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E38303028F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 21:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF33D48B39B;
	Tue,  5 May 2026 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bcshBVOb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF1175A70;
	Tue,  5 May 2026 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015930; cv=none; b=ZwaK9f2P7YlnSoCtZqGJD2MEZTMc9lW27LB8Qv4LsV2xdYGc5OAa0FS6QMulKNiuBI1WJTT4PbNmCBWAxHlKOWweyW6pWonMQnR2N+91t0XND4fQIRdxPyB2BB7RDA/S1PfcsCo9bF71K0c/RWX6X51lkJCqb2xOKesmkxy2Z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015930; c=relaxed/simple;
	bh=oJW8j66BM2CrIgu4L7aQb6rMKIiXEjjBD/acmn2cu3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNftuJvznvfbAHZ3ld6lvyStvnPnDSgxqXhVgUrU90Asz9+npPGHQGberuyvWI0v24hQziM/3dvQvkzhm88oVTDGVxQWzIg6NIT+x0DcivEhxDBfLFeSLnlA2gunjsGBtRJv6dStE+frJahwBa0lSVcf7fF5f2ky5l8E640aWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bcshBVOb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ivgSBsqOknYt6ReD8RplNcTpclgyeL6PhD1OAo2NG58=;
	t=1778015929; x=1779225529; b=bcshBVObgtfhWHPBXBRs9xUkLVi4btnnk7/KBehaAK5V4Cw
	2Z8h2V1weAjlQ4DHpfwZkYHsXFEVhxwJzcqAjQFU1e1xXeKG1r1MInkyeV4l8bcqo8hfq6DCKqo4K
	UFbzXP1oiAyoy2jHuLhH80zMrk9OmRJKS9f6dYZr2aWmRDxnhqJ7XNUrX58VNR/rdnZ5SIyhPoH5o
	E8pVzqGz+Q9O6+Ves27txlAorq3JKUK8Mci6je2LMkqG5L261XoAvrQgoyVeVO67LY+gRxFfxinCA
	mcfva8WgWKOWM65FMQRpVd9NpXRdxM02FerZtHsump+qi+NZJ5OIKMw9Rm2FJflg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKNAE-0000000H1AH-1gLo;
	Tue, 05 May 2026 23:18:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: use gf128hash library
Date: Tue,  5 May 2026 23:18:39 +0200
Message-ID: <20260505231841.74a227c74411.I8a9f93e81e6a5ebff417c8a94ae157ea5ad04de9@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505211841.669767-3-johannes@sipsolutions.net>
References: <20260505211841.669767-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 07B244D3DBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-35955-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

From: Johannes Berg <johannes.berg@intel.com>

Just like the previous conversion of aesgcm, it's simpler,
faster and avoids extra allocations, especially one in the
actual packet processing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/Kconfig    |  1 +
 net/mac80211/aes_gmac.c | 90 +++++++++++++++--------------------------
 net/mac80211/aes_gmac.h | 14 ++++---
 net/mac80211/key.c      | 11 ++---
 net/mac80211/key.h      |  2 +-
 net/mac80211/wpa.c      | 15 +++----
 6 files changed, 52 insertions(+), 81 deletions(-)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index b51050257c01..ada7078db4cd 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -6,6 +6,7 @@ config MAC80211
 	select CRYPTO_LIB_AES_CBC_MACS
 	select CRYPTO_LIB_ARC4
 	select CRYPTO_LIB_AESGCM
+	select CRYPTO_LIB_GF128MUL
 	select CRYPTO_AES
 	select CRYPTO_CCM
 	select CRC32
diff --git a/net/mac80211/aes_gmac.c b/net/mac80211/aes_gmac.c
index 811a83d8d525..c6bb5761cc63 100644
--- a/net/mac80211/aes_gmac.c
+++ b/net/mac80211/aes_gmac.c
@@ -7,88 +7,62 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/err.h>
-#include <crypto/aead.h>
-#include <crypto/aes.h>
+#include <crypto/gf128hash.h>
+#include <crypto/utils.h>
 
 #include <net/mac80211.h>
 #include "key.h"
 #include "aes_gmac.h"
 
-int ieee80211_aes_gmac(struct crypto_aead *tfm, const u8 *aad, u8 *nonce,
+int ieee80211_aes_gmac(struct aesgcm_ctx *ctx, const u8 *aad, u8 *nonce,
 		       const u8 *data, size_t data_len, u8 *mic)
 {
-	struct scatterlist sg[5];
-	u8 *zero, *__aad, iv[AES_BLOCK_SIZE];
-	struct aead_request *aead_req;
-	int reqsize = sizeof(*aead_req) + crypto_aead_reqsize(tfm);
+	static const u8 zero[GHASH_BLOCK_SIZE];
+	struct ghash_ctx ghash;
+	u8 iv[AES_BLOCK_SIZE];
+	size_t total_len = GMAC_AAD_LEN + data_len;
+	__be64 tail[2] = {
+		cpu_to_be64((u64)total_len * 8),
+		0, /* no data since it's just GMAC */
+	};
+	u8 ghash_out[AES_BLOCK_SIZE];
+	u8 enc_ctr[AES_BLOCK_SIZE];
 	const __le16 *fc;
-	int ret;
 
 	if (data_len < IEEE80211_GMAC_MIC_LEN)
 		return -EINVAL;
 
-	aead_req = kzalloc(reqsize + IEEE80211_GMAC_MIC_LEN + GMAC_AAD_LEN,
-			   GFP_ATOMIC);
-	if (!aead_req)
-		return -ENOMEM;
+	ghash_init(&ghash, &ctx->ghash_key);
 
-	zero = (u8 *)aead_req + reqsize;
-	__aad = zero + IEEE80211_GMAC_MIC_LEN;
-	memcpy(__aad, aad, GMAC_AAD_LEN);
+	ghash_update(&ghash, aad, GMAC_AAD_LEN);
 
 	fc = (const __le16 *)aad;
 	if (ieee80211_is_beacon(*fc)) {
 		/* mask Timestamp field to zero */
-		sg_init_table(sg, 5);
-		sg_set_buf(&sg[0], __aad, GMAC_AAD_LEN);
-		sg_set_buf(&sg[1], zero, 8);
-		sg_set_buf(&sg[2], data + 8,
-			   data_len - 8 - IEEE80211_GMAC_MIC_LEN);
-		sg_set_buf(&sg[3], zero, IEEE80211_GMAC_MIC_LEN);
-		sg_set_buf(&sg[4], mic, IEEE80211_GMAC_MIC_LEN);
+		ghash_update(&ghash, zero, 8);
+		ghash_update(&ghash, data + 8, data_len - 8 - IEEE80211_GMAC_MIC_LEN);
 	} else {
-		sg_init_table(sg, 4);
-		sg_set_buf(&sg[0], __aad, GMAC_AAD_LEN);
-		sg_set_buf(&sg[1], data, data_len - IEEE80211_GMAC_MIC_LEN);
-		sg_set_buf(&sg[2], zero, IEEE80211_GMAC_MIC_LEN);
-		sg_set_buf(&sg[3], mic, IEEE80211_GMAC_MIC_LEN);
+		ghash_update(&ghash, data, data_len - IEEE80211_GMAC_MIC_LEN);
 	}
 
+	/* set MIC value to zero */
+	ghash_update(&ghash, zero, IEEE80211_GMAC_MIC_LEN);
+	/* pad */
+	ghash_update(&ghash, zero, -total_len & (GHASH_BLOCK_SIZE - 1));
+
+	ghash_update(&ghash, (const u8 *)&tail, sizeof(tail));
+
+	ghash_final(&ghash, ghash_out);
+
 	memcpy(iv, nonce, GMAC_NONCE_LEN);
 	memset(iv + GMAC_NONCE_LEN, 0, sizeof(iv) - GMAC_NONCE_LEN);
 	iv[AES_BLOCK_SIZE - 1] = 0x01;
 
-	aead_request_set_tfm(aead_req, tfm);
-	aead_request_set_crypt(aead_req, sg, sg, 0, iv);
-	aead_request_set_ad(aead_req, GMAC_AAD_LEN + data_len);
+	aes_encrypt(&ctx->aes_key, enc_ctr, (const u8 *)iv);
+	crypto_xor_cpy(mic, ghash_out, enc_ctr, IEEE80211_GMAC_MIC_LEN);
 
-	ret = crypto_aead_encrypt(aead_req);
-	kfree_sensitive(aead_req);
+	memzero_explicit(ghash_out, sizeof(ghash_out));
+	memzero_explicit(enc_ctr, sizeof(enc_ctr));
 
-	return ret;
-}
-
-struct crypto_aead *ieee80211_aes_gmac_key_setup(const u8 key[],
-						 size_t key_len)
-{
-	struct crypto_aead *tfm;
-	int err;
-
-	tfm = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return tfm;
-
-	err = crypto_aead_setkey(tfm, key, key_len);
-	if (!err)
-		err = crypto_aead_setauthsize(tfm, IEEE80211_GMAC_MIC_LEN);
-	if (!err)
-		return tfm;
-
-	crypto_free_aead(tfm);
-	return ERR_PTR(err);
-}
-
-void ieee80211_aes_gmac_key_free(struct crypto_aead *tfm)
-{
-	crypto_free_aead(tfm);
+	return 0;
 }
diff --git a/net/mac80211/aes_gmac.h b/net/mac80211/aes_gmac.h
index 206136b60bca..e1db4a47fc9c 100644
--- a/net/mac80211/aes_gmac.h
+++ b/net/mac80211/aes_gmac.h
@@ -6,15 +6,19 @@
 #ifndef AES_GMAC_H
 #define AES_GMAC_H
 
-#include <linux/crypto.h>
+#include <crypto/gcm.h>
 
 #define GMAC_AAD_LEN	20
 #define GMAC_NONCE_LEN	12
 
-struct crypto_aead *ieee80211_aes_gmac_key_setup(const u8 key[],
-						 size_t key_len);
-int ieee80211_aes_gmac(struct crypto_aead *tfm, const u8 *aad, u8 *nonce,
+static inline int
+ieee80211_aes_gmac_key_setup(struct aesgcm_ctx *ctx,
+			     const u8 key[], size_t key_len)
+{
+	return aesgcm_expandkey(ctx, key, key_len, IEEE80211_GCMP_MIC_LEN);
+}
+
+int ieee80211_aes_gmac(struct aesgcm_ctx *ctx, const u8 *aad, u8 *nonce,
 		       const u8 *data, size_t data_len, u8 *mic);
-void ieee80211_aes_gmac_key_free(struct crypto_aead *tfm);
 
 #endif /* AES_GMAC_H */
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 1a2092aebaf6..71cbd7a8b818 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -708,10 +708,9 @@ ieee80211_key_alloc(u32 cipher, int idx, size_t key_len,
 		/* Initialize AES key state here as an optimization so that
 		 * it does not need to be initialized for every packet.
 		 */
-		key->u.aes_gmac.tfm =
-			ieee80211_aes_gmac_key_setup(key_data, key_len);
-		if (IS_ERR(key->u.aes_gmac.tfm)) {
-			err = PTR_ERR(key->u.aes_gmac.tfm);
+		err = ieee80211_aes_gmac_key_setup(&key->u.aes_gmac.ctx,
+						   key_data, key_len);
+		if (err) {
 			kfree(key);
 			return ERR_PTR(err);
 		}
@@ -748,10 +747,6 @@ static void ieee80211_key_free_common(struct ieee80211_key *key)
 	case WLAN_CIPHER_SUITE_CCMP_256:
 		ieee80211_aes_key_free(key->u.ccmp.tfm);
 		break;
-	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		ieee80211_aes_gmac_key_free(key->u.aes_gmac.tfm);
-		break;
 	}
 	kfree_sensitive(key);
 }
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index 65450d3474bb..0ee0548e02ed 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -101,7 +101,7 @@ struct ieee80211_key {
 		} aes_cmac;
 		struct {
 			u8 rx_pn[IEEE80211_GMAC_PN_LEN];
-			struct crypto_aead *tfm;
+			struct aesgcm_ctx ctx;
 			u32 replays; /* dot11RSNAStatsCMACReplays */
 			u32 icverrors; /* dot11RSNAStatsCMACICVErrors */
 		} aes_gmac;
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 4440e09c5f80..0a55de4bc853 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -1008,8 +1008,8 @@ ieee80211_crypto_aes_gmac_encrypt(struct ieee80211_tx_data *tx)
 	bip_ipn_swap(nonce + ETH_ALEN, mmie->sequence_number);
 
 	/* MIC = AES-GMAC(IGTK, AAD || Management Frame Body || MMIE, 128) */
-	if (ieee80211_aes_gmac(key->u.aes_gmac.tfm, aad, nonce,
-			       skb->data + 24, skb->len - 24, mmie->mic) < 0)
+	if (ieee80211_aes_gmac(&key->u.aes_gmac.ctx, aad, nonce,
+			       skb->data + 24, skb->len - 24, mmie->mic))
 		return TX_DROP;
 
 	return TX_CONTINUE;
@@ -1022,7 +1022,7 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_key *key = rx->key;
 	struct ieee80211_mmie_16 *mmie;
-	u8 aad[GMAC_AAD_LEN], *mic, ipn[6], nonce[GMAC_NONCE_LEN];
+	u8 aad[GMAC_AAD_LEN], ipn[6], nonce[GMAC_NONCE_LEN];
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	if (!ieee80211_is_mgmt(hdr->frame_control))
@@ -1047,24 +1047,21 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 	}
 
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
+		u8 mic[IEEE80211_GMAC_MIC_LEN];
+
 		/* hardware didn't decrypt/verify MIC */
 		bip_aad(skb, aad);
 
 		memcpy(nonce, hdr->addr2, ETH_ALEN);
 		memcpy(nonce + ETH_ALEN, ipn, 6);
 
-		mic = kmalloc(IEEE80211_GMAC_MIC_LEN, GFP_ATOMIC);
-		if (!mic)
-			return RX_DROP_U_OOM;
-		if (ieee80211_aes_gmac(key->u.aes_gmac.tfm, aad, nonce,
+		if (ieee80211_aes_gmac(&key->u.aes_gmac.ctx, aad, nonce,
 				       skb->data + 24, skb->len - 24,
 				       mic) < 0 ||
 		    crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_gmac.icverrors++;
-			kfree(mic);
 			return RX_DROP_U_MIC_FAIL;
 		}
-		kfree(mic);
 	}
 
 	memcpy(key->u.aes_gmac.rx_pn, ipn, 6);
-- 
2.53.0


