Return-Path: <linux-wireless+bounces-28851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A309C4EAAF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 16:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1847189AE34
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86D311583;
	Tue, 11 Nov 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="gMDeP+EE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211425C818
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873101; cv=pass; b=WDtk2Dk/XmxR74wRdNmRzw6R+VQ+5dtqIn+lwtWov9GaK16Ntd3notNuck9Aw9UDdcamAQtqYVVPxRwfNxP1Ub3Y5YCc+9fpUPGtNlb7lwfBCTa/++6BJ4Ks8bB8A2Q2VFaVFbD43plTIRVqDk143yr+NOtj+sbNttzF/79hi3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873101; c=relaxed/simple;
	bh=z1mH68aH7fNsyVhXvFphVPdCkKqcAeVKP5y7Awvd2dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb9457pEH8xON4Lf01Z+AF8jTV16pnIb8xO33AM5Wlm94hp0aAHqn+ABpKbtOfuYwWK0vBZZ/rsD8o67HW11e5mz/dmhvkSoJowUjHeWUQh0Y5V2z8my/J9cFSutKD52AzZuCFa9anXZwazPdctEbVifr5vOBCtwEAkBjpIwSkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=gMDeP+EE; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762873097; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iaDlRyLCkEALa7IVEGAxsv9hboXNIdgVA/4L9hSRRl7pWV3eyZYsY6igXmc54t+whMquom0tWYrlNNpKX0KQAsKRaRFEGmD41xUYl8L8i/lYofEDuIT9RZWpoSWYxYntB7lDVEUxCbY+jTy49yj4JgbL20U7lFzGZ/z6shb4yOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762873097; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TH9CZ+slNxgFlKsGwmBBxYRlHdWgRPiZ22hnImtV93E=; 
	b=CWQeNyaS5PybeteCCUoXa/9GlVYvsW9d/adyp/iC48jWFiSHL3PHefGCne4ESVMbv3ZwTtAqAN5hl/JH0gd/yVF6bMg+jbECY5szjelftAbkQzdvInMJQOB+sBHOi2PJ8kUQJDfnLHh3BbsZURnZiq6u4BY62eQnOwd8vPM3zLI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762873097;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TH9CZ+slNxgFlKsGwmBBxYRlHdWgRPiZ22hnImtV93E=;
	b=gMDeP+EEu13rjhF3HLiHiediT28mp0dX80CAyrZ0w4zocc4zFeIJrtjflri/VTG3
	KhmUyT4hm4NLr1z7aUOLqOGyPxwZf4LP0E33eANloZSATA4n4QEIPu6Elhw/m7vyqze
	wO0u7PfbiPKpz4de2d6zXG6wasmAVXfwzf/Vl57Y=
Received: by mx.zohomail.com with SMTPS id 1762873095719531.1311028822677;
	Tue, 11 Nov 2025 06:58:15 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3 4/5] wifi: mac80211: refactor CMAC crypt functions
Date: Tue, 11 Nov 2025 22:57:58 +0800
Message-ID: <20251111145759.111691-5-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111145759.111691-1-m@xv97.com>
References: <20251111145759.111691-1-m@xv97.com>
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

It should be noted that the refactored ieee80211_aes_cmac() permits
8 bytes output for CMAC-256 and 16 bytes output for CMAC-128. In such
cases, it would generate result correctly as expected.

All references to the refactored functions in the tree are adapted.

Signed-off-by: Chien Wong <m@xv97.com>
---
 net/mac80211/aes_cmac.c | 53 ++++++++++-------------------------------
 net/mac80211/aes_cmac.h |  4 +---
 net/mac80211/wpa.c      | 16 ++++++++-----
 3 files changed, 24 insertions(+), 49 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index 01fb8b6c5dfb..588e3c9879b3 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -16,20 +16,21 @@
 #include "key.h"
 #include "aes_cmac.h"
 
-#define CMAC_TLEN IEEE80211_CMAC_128_MIC_LEN
-#define CMAC_TLEN_256 IEEE80211_CMAC_256_MIC_LEN
 #define AAD_LEN 20
 
-static const u8 zero[CMAC_TLEN_256];
+static const u8 zero[IEEE80211_CMAC_256_MIC_LEN];
 
 int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-		       const u8 *data, size_t data_len, u8 *mic)
+		       const u8 *data, size_t data_len, u8 *mic, unsigned int mic_len)
 {
 	int err;
 	SHASH_DESC_ON_STACK(desc, tfm);
-	u8 out[AES_BLOCK_SIZE];
 	const __le16 *fc;
 
+	if (mic_len != IEEE80211_CMAC_128_MIC_LEN &&
+	    mic_len != IEEE80211_CMAC_256_MIC_LEN)
+		return -EINVAL;
+
 	desc->tfm = tfm;
 
 	err = crypto_shash_init(desc);
@@ -44,53 +45,25 @@ int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
 		err = crypto_shash_update(desc, zero, 8);
 		if (err)
 			goto out;
-		err = crypto_shash_update(desc, data + 8, data_len - 8 - CMAC_TLEN);
+		err = crypto_shash_update(desc, data + 8, data_len - 8 - mic_len);
 		if (err)
 			goto out;
 	} else {
-		err = crypto_shash_update(desc, data, data_len - CMAC_TLEN);
+		err = crypto_shash_update(desc, data, data_len - mic_len);
 		if (err)
 			goto out;
 	}
-	err = crypto_shash_finup(desc, zero, CMAC_TLEN, out);
-	if (err)
-		goto out;
-	memcpy(mic, out, CMAC_TLEN);
-out:
-	return err;
-}
 
-int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-			   const u8 *data, size_t data_len, u8 *mic)
-{
-	int err;
-	SHASH_DESC_ON_STACK(desc, tfm);
-	const __le16 *fc;
+	if (mic_len == IEEE80211_CMAC_128_MIC_LEN) {
+		u8 out[AES_BLOCK_SIZE];
 
-	desc->tfm = tfm;
-
-	err = crypto_shash_init(desc);
-	if (err)
-		goto out;
-	err = crypto_shash_update(desc, aad, AAD_LEN);
-	if (err)
-		goto out;
-	fc = (const __le16 *)aad;
-	if (ieee80211_is_beacon(*fc)) {
-		/* mask Timestamp field to zero */
-		err = crypto_shash_update(desc, zero, 8);
-		if (err)
-			goto out;
-		err = crypto_shash_update(desc, data + 8,
-					  data_len - 8 - CMAC_TLEN_256);
+		err = crypto_shash_finup(desc, zero, mic_len, out);
 		if (err)
 			goto out;
+		memcpy(mic, out, mic_len);
 	} else {
-		err = crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
-		if (err)
-			goto out;
+		err = crypto_shash_finup(desc, zero, mic_len, mic);
 	}
-	err = crypto_shash_finup(desc, zero, CMAC_TLEN_256, mic);
 out:
 	return err;
 }
diff --git a/net/mac80211/aes_cmac.h b/net/mac80211/aes_cmac.h
index f74150542142..631fc3033576 100644
--- a/net/mac80211/aes_cmac.h
+++ b/net/mac80211/aes_cmac.h
@@ -12,9 +12,7 @@
 struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
 						  size_t key_len);
 int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-		       const u8 *data, size_t data_len, u8 *mic);
-int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-			   const u8 *data, size_t data_len, u8 *mic);
+		       const u8 *data, size_t data_len, u8 *mic, unsigned int mic_len);
 void ieee80211_aes_cmac_key_free(struct crypto_shash *tfm);
 
 #endif /* AES_CMAC_H */
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index bb0fa505cdca..2c1ee4b8e205 100644
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


