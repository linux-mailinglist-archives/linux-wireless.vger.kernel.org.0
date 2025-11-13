Return-Path: <linux-wireless+bounces-28917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0D7C57EDA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428EE4249DB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B326F2BB;
	Thu, 13 Nov 2025 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="vDjle/4a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender3-op-o15.zoho.com (sender3-op-o15.zoho.com [136.143.184.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391526E71F
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042733; cv=pass; b=mO+eqYMyjmk/pVFNTpi7gR/1zEYKb5d3oQk9qVWKE7/ibeZf6R+tn0WY/jV0acbQo7rrhWUlBuJezsiwCaeEdU/etA/WG0F1/ZtCNh4a9JvJcuOyH90MaI9getylcEymxHNbiM/LfOaAehMRVwgUoFjhF6GXdPc0cSq6fDTXdWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042733; c=relaxed/simple;
	bh=j7w0YGu6LHCZAjGVLhFcfwgDwSacochKmqTaGsmQmyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxeQtv5uCAL+Ss3y8zB4dBqHKOp2SPe1zbuHJnOZnZYSAFZORhGEJMAQDIk4ZkgcuDloL29Hq8zxC6gEr3nOFjReAbthhGNwAMgFSaEskim7zS+aBcuQnCgf+ia5AZFJZznVELPqnB0aJ5pu9dMbQIUM76trpZ+bnFrC0rjq2gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=vDjle/4a; arc=pass smtp.client-ip=136.143.184.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1763042728; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VWvo389qYCW7CRGHT/qDQRQ1e6fRu4F3C7dPznqTxSz4uf/vk2OdSw0iEhBzXxi8X5z0hQ1+N11EGb5WptkkWxyB+GBeJ4oSBuip9J8Bg3g9UygfoYWX+IkFi7jnRQCWPy0u2IlurilL5TUAlJBfGbDNbnFnxuQJbQGRvJ4EggI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763042728; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h+TGJubeifvT3+lLF+QTIOk7YjhSq97V0NproeviAl4=; 
	b=lgQU/+iOsTe1c4m6sy00aeMWx6rKMKyD7h4n1FVyNsrfFOeFNbKGrB0uDVZmv3mcFsgFT3DCd9lyLGwDog2nfe3YEBFQgtz8kLEKnxb6Z2YtVKrQ15cJspAIOMYVLAHasNVMm0a7k2UbbwvH8xF96qhsVbAm5irJ+Orfaz57Rk8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763042728;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h+TGJubeifvT3+lLF+QTIOk7YjhSq97V0NproeviAl4=;
	b=vDjle/4a9I7NF/aH3xwTMEViI7h9HXFi9RN+eA9wWHOMClQDE4dx173wWwIkyoai
	DlosHQwbnpHxwod12uoBzfKHX1B6aADEv2qsnj/yuyM3sn8bbRS+dlOQvyzzLibCXYu
	tOUNhCmcRsy9X4qGx3szP/BAS72s5RSh5rsfN3Zk=
Received: by mx.zohomail.com with SMTPS id 1763042725956226.82513218516317;
	Thu, 13 Nov 2025 06:05:25 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v4 4/5] wifi: mac80211: refactor CMAC crypt functions
Date: Thu, 13 Nov 2025 22:05:10 +0800
Message-ID: <20251113140511.48658-5-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113140511.48658-1-m@xv97.com>
References: <20251113140511.48658-1-m@xv97.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ieee80211_aes_cmac() and ieee80211_aes_cmac_256() are almost the same.
Merge them. This removes duplication.

Signed-off-by: Chien Wong <m@xv97.com>
---
 net/mac80211/aes_cmac.c | 48 ++++++-----------------------------------
 net/mac80211/aes_cmac.h |  5 ++---
 net/mac80211/wpa.c      | 16 ++++++++------
 3 files changed, 19 insertions(+), 50 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index 672ed80ee4ff..0827965455dc 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -21,7 +21,8 @@
 static const u8 zero[IEEE80211_CMAC_256_MIC_LEN];
 
 int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-		       const u8 *data, size_t data_len, u8 *mic)
+		       const u8 *data, size_t data_len, u8 *mic,
+		       unsigned int mic_len)
 {
 	int err;
 	SHASH_DESC_ON_STACK(desc, tfm);
@@ -42,58 +43,23 @@ int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
 		err = crypto_shash_update(desc, zero, 8);
 		if (err)
 			return err;
-		err = crypto_shash_update(desc, data + 8, data_len - 8 -
-					  IEEE80211_CMAC_128_MIC_LEN);
+		err = crypto_shash_update(desc, data + 8,
+					  data_len - 8 - mic_len);
 		if (err)
 			return err;
 	} else {
-		err = crypto_shash_update(desc, data, data_len -
-					  IEEE80211_CMAC_128_MIC_LEN);
+		err = crypto_shash_update(desc, data, data_len - mic_len);
 		if (err)
 			return err;
 	}
-	err = crypto_shash_finup(desc, zero, IEEE80211_CMAC_128_MIC_LEN, out);
+	err = crypto_shash_finup(desc, zero, mic_len, out);
 	if (err)
 		return err;
-	memcpy(mic, out, IEEE80211_CMAC_128_MIC_LEN);
+	memcpy(mic, out, mic_len);
 
 	return 0;
 }
 
-int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-			   const u8 *data, size_t data_len, u8 *mic)
-{
-	int err;
-	SHASH_DESC_ON_STACK(desc, tfm);
-	const __le16 *fc;
-
-	desc->tfm = tfm;
-
-	err = crypto_shash_init(desc);
-	if (err)
-		return err;
-	err = crypto_shash_update(desc, aad, AAD_LEN);
-	if (err)
-		return err;
-	fc = (const __le16 *)aad;
-	if (ieee80211_is_beacon(*fc)) {
-		/* mask Timestamp field to zero */
-		err = crypto_shash_update(desc, zero, 8);
-		if (err)
-			return err;
-		err = crypto_shash_update(desc, data + 8, data_len - 8 -
-					  IEEE80211_CMAC_256_MIC_LEN);
-		if (err)
-			return err;
-	} else {
-		err = crypto_shash_update(desc, data, data_len -
-					  IEEE80211_CMAC_256_MIC_LEN);
-		if (err)
-			return err;
-	}
-	return crypto_shash_finup(desc, zero, IEEE80211_CMAC_256_MIC_LEN, mic);
-}
-
 struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
 						  size_t key_len)
 {
diff --git a/net/mac80211/aes_cmac.h b/net/mac80211/aes_cmac.h
index f74150542142..5f971a8298cb 100644
--- a/net/mac80211/aes_cmac.h
+++ b/net/mac80211/aes_cmac.h
@@ -12,9 +12,8 @@
 struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
 						  size_t key_len);
 int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-		       const u8 *data, size_t data_len, u8 *mic);
-int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-			   const u8 *data, size_t data_len, u8 *mic);
+		       const u8 *data, size_t data_len, u8 *mic,
+		       unsigned int mic_len);
 void ieee80211_aes_cmac_key_free(struct crypto_shash *tfm);
 
 #endif /* AES_CMAC_H */
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 3d5efd8c6e2d..7431ccecd17f 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -870,7 +870,8 @@ ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx)
 	 * MIC = AES-128-CMAC(IGTK, AAD || Management Frame Body || MMIE, 64)
 	 */
 	if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-			       skb->data + 24, skb->len - 24, mmie->mic))
+			       skb->data + 24, skb->len - 24, mmie->mic,
+			       IEEE80211_CMAC_128_MIC_LEN))
 		return TX_DROP;
 
 	return TX_CONTINUE;
@@ -917,8 +918,9 @@ ieee80211_crypto_aes_cmac_256_encrypt(struct ieee80211_tx_data *tx)
 
 	/* MIC = AES-256-CMAC(IGTK, AAD || Management Frame Body || MMIE, 128)
 	 */
-	if (ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
-				   skb->data + 24, skb->len - 24, mmie->mic))
+	if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
+			       skb->data + 24, skb->len - 24, mmie->mic,
+			       IEEE80211_CMAC_256_MIC_LEN))
 		return TX_DROP;
 
 	return TX_CONTINUE;
@@ -959,7 +961,8 @@ ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx)
 		/* hardware didn't decrypt/verify MIC */
 		bip_aad(skb, aad);
 		if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-				       skb->data + 24, skb->len - 24, mic))
+				       skb->data + 24, skb->len - 24, mic,
+				       IEEE80211_CMAC_128_MIC_LEN))
 			return RX_DROP_U_DECRYPT_FAIL;
 		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_cmac.icverrors++;
@@ -1009,8 +1012,9 @@ ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx)
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
 		/* hardware didn't decrypt/verify MIC */
 		bip_aad(skb, aad);
-		if (ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
-					   skb->data + 24, skb->len - 24, mic))
+		if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
+				       skb->data + 24, skb->len - 24, mic,
+				       IEEE80211_CMAC_256_MIC_LEN))
 			return RX_DROP_U_DECRYPT_FAIL;
 		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_cmac.icverrors++;
-- 
2.51.2


