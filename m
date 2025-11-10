Return-Path: <linux-wireless+bounces-28795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 177ECC474EF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFF174EC2BD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08089757EA;
	Mon, 10 Nov 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="f+Yc7tcA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8F313E3F
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785960; cv=pass; b=lxUcbxBPnG5Ux+LDFumm3LXBUnJk9kUrIlPSZ49qNIk6NOFjuLOKB6o7ZOUAkcFtFsSCxkR10KzAwOHSO7YlVajnvKSWbRGU6lFZRy7Xr6HS1PWNxcv/tFHitHmAHLcUagmd0EzhNRluUItyuuQMANwbBrYVFkJ/3q4okthKTIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785960; c=relaxed/simple;
	bh=f9hZg/uSbI2BU6kqi4X53yhI8ddK9Tmb3IxJ+ztTtHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhQNCXLW3R2C0O/twQltz46FKtlVjoCEof05UoNYfOt1l0VDhFXhlACuEra/vB2n67o7QiBehTQvLI6m7/xiCqtDpFhYMt8cjQVb3bgQMlgvspTEaRyrv4cy1DHcQEDHsUY2T9GD3BprnenVN/xDo6MQJUHRfWYvPpT4uxtp5cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=f+Yc7tcA; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762785956; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U2/znx8gFvNmX5f4IsY2R2yw6LoXmmaiL2f1LAFBgE3d3qpZ3xlTulmwSaDoNrWM6zLDjqJPdCN3IfFRyMr1S2t2DTmQu1WsvjzVdLw8ohh8OhOB2n6IMVRW+yZCCgl9IAZJ31++kgphCDcfeJ8NHyInsTiLY9KCrV32SgeYSvs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762785956; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JowTK4lttWPzc/rURR3um6OQCM+D8makcEW4WbvnBsA=; 
	b=MP8nBQHvkOnj3++NtSDZu+y9Q5t4TJR+E2qM3TFWb+cy23fT4iy7s5QGih5jWLR42BAiEOF+7YzgphfkgwaHjAuxQaXYgZCqBuILAwRnKmK6+rSfkEXFib1vb/puBxPs28MGdJNXJnqp44kE0YlyG8bLVxsnurUSczZ1w+q/VFQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762785956;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JowTK4lttWPzc/rURR3um6OQCM+D8makcEW4WbvnBsA=;
	b=f+Yc7tcAE2bw35xxlTK33rx9yZBVHsKMWMFuOJK+rOKXQgLvfdutjRlrEXO4syqg
	jWbYWIoXGj9QG5+FrkVccZi1sFR5HONJlnV+LpnmVbAfH5b0p5IYfV/EQeb9bBHUlPl
	Wb5ISq2AW2KJIswDXiPamvfZh6q6bNmv97yKDbNs=
Received: by mx.zohomail.com with SMTPS id 1762785954948614.4310517229773;
	Mon, 10 Nov 2025 06:45:54 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/6] wifi: mac80211: fix CMAC functions not handling errors
Date: Mon, 10 Nov 2025 22:45:41 +0800
Message-ID: <20251110144545.15149-3-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110144545.15149-1-m@xv97.com>
References: <20251110144545.15149-1-m@xv97.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The called hash functions could fail thus we should check return values.
All references to the changed functions in the tree are adapted.

Fixes: 26717828b75d ("mac80211: aes-cmac: switch to shash CMAC driver")
Signed-off-by: Chien Wong <m@xv97.com>
---
 net/mac80211/aes_cmac.c | 60 +++++++++++++++++++++++++++++------------
 net/mac80211/aes_cmac.h |  8 +++---
 net/mac80211/wpa.c      | 20 ++++++++------
 3 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index a9a5b2396096..d7d1117f1313 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -22,47 +22,73 @@
 
 static const u8 zero[CMAC_TLEN_256];
 
-void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-			const u8 *data, size_t data_len, u8 *mic)
+int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
+		       const u8 *data, size_t data_len, u8 *mic)
 {
+	int err;
 	SHASH_DESC_ON_STACK(desc, tfm);
 	const __le16 *fc;
 
 	desc->tfm = tfm;
 
-	crypto_shash_init(desc);
-	crypto_shash_update(desc, aad, AAD_LEN);
+	err = crypto_shash_init(desc);
+	if (err)
+		goto out;
+	err = crypto_shash_update(desc, aad, AAD_LEN);
+	if (err)
+		goto out;
 	fc = (const __le16 *)aad;
 	if (ieee80211_is_beacon(*fc)) {
 		/* mask Timestamp field to zero */
-		crypto_shash_update(desc, zero, 8);
-		crypto_shash_update(desc, data + 8, data_len - 8 - CMAC_TLEN);
+		err = crypto_shash_update(desc, zero, 8);
+		if (err)
+			goto out;
+		err = crypto_shash_update(desc, data + 8, data_len - 8 - CMAC_TLEN);
+		if (err)
+			goto out;
 	} else {
-		crypto_shash_update(desc, data, data_len - CMAC_TLEN);
+		err = crypto_shash_update(desc, data, data_len - CMAC_TLEN);
+		if (err)
+			goto out;
 	}
-	crypto_shash_finup(desc, zero, CMAC_TLEN, mic);
+	err = crypto_shash_finup(desc, zero, CMAC_TLEN, mic);
+out:
+	return err;
 }
 
-void ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-			    const u8 *data, size_t data_len, u8 *mic)
+int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
+			   const u8 *data, size_t data_len, u8 *mic)
 {
+	int err;
 	SHASH_DESC_ON_STACK(desc, tfm);
 	const __le16 *fc;
 
 	desc->tfm = tfm;
 
-	crypto_shash_init(desc);
-	crypto_shash_update(desc, aad, AAD_LEN);
+	err = crypto_shash_init(desc);
+	if (err)
+		goto out;
+	err = crypto_shash_update(desc, aad, AAD_LEN);
+	if (err)
+		goto out;
 	fc = (const __le16 *)aad;
 	if (ieee80211_is_beacon(*fc)) {
 		/* mask Timestamp field to zero */
-		crypto_shash_update(desc, zero, 8);
-		crypto_shash_update(desc, data + 8,
-				    data_len - 8 - CMAC_TLEN_256);
+		err = crypto_shash_update(desc, zero, 8);
+		if (err)
+			goto out;
+		err = crypto_shash_update(desc, data + 8,
+					  data_len - 8 - CMAC_TLEN_256);
+		if (err)
+			goto out;
 	} else {
-		crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
+		err = crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
+		if (err)
+			goto out;
 	}
-	crypto_shash_finup(desc, zero, CMAC_TLEN_256, mic);
+	err = crypto_shash_finup(desc, zero, CMAC_TLEN_256, mic);
+out:
+	return err;
 }
 
 struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
diff --git a/net/mac80211/aes_cmac.h b/net/mac80211/aes_cmac.h
index 76817446fb83..f74150542142 100644
--- a/net/mac80211/aes_cmac.h
+++ b/net/mac80211/aes_cmac.h
@@ -11,10 +11,10 @@
 
 struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
 						  size_t key_len);
-void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
-			const u8 *data, size_t data_len, u8 *mic);
-void ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-			    const u8 *data, size_t data_len, u8 *mic);
+int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
+		       const u8 *data, size_t data_len, u8 *mic);
+int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
+			   const u8 *data, size_t data_len, u8 *mic);
 void ieee80211_aes_cmac_key_free(struct crypto_shash *tfm);
 
 #endif /* AES_CMAC_H */
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 40d5d9e48479..bb0fa505cdca 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -869,8 +869,9 @@ ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx)
 	/*
 	 * MIC = AES-128-CMAC(IGTK, AAD || Management Frame Body || MMIE, 64)
 	 */
-	ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-			   skb->data + 24, skb->len - 24, mmie->mic);
+	if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
+			       skb->data + 24, skb->len - 24, mmie->mic))
+		return TX_DROP;
 
 	return TX_CONTINUE;
 }
@@ -916,8 +917,9 @@ ieee80211_crypto_aes_cmac_256_encrypt(struct ieee80211_tx_data *tx)
 
 	/* MIC = AES-256-CMAC(IGTK, AAD || Management Frame Body || MMIE, 128)
 	 */
-	ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
-			       skb->data + 24, skb->len - 24, mmie->mic);
+	if (ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
+				   skb->data + 24, skb->len - 24, mmie->mic))
+		return TX_DROP;
 
 	return TX_CONTINUE;
 }
@@ -956,8 +958,9 @@ ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx)
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
 		/* hardware didn't decrypt/verify MIC */
 		bip_aad(skb, aad);
-		ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-				   skb->data + 24, skb->len - 24, mic);
+		if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
+				       skb->data + 24, skb->len - 24, mic))
+			return RX_DROP_U_DECRYPT_FAIL;
 		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_cmac.icverrors++;
 			return RX_DROP_U_MIC_FAIL;
@@ -1006,8 +1009,9 @@ ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx)
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
 		/* hardware didn't decrypt/verify MIC */
 		bip_aad(skb, aad);
-		ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
-				       skb->data + 24, skb->len - 24, mic);
+		if (ieee80211_aes_cmac_256(key->u.aes_cmac.tfm, aad,
+					   skb->data + 24, skb->len - 24, mic))
+			return RX_DROP_U_DECRYPT_FAIL;
 		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_cmac.icverrors++;
 			return RX_DROP_U_MIC_FAIL;
-- 
2.51.2


