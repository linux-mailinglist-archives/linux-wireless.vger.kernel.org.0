Return-Path: <linux-wireless+bounces-28916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8DFC57D5E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 15:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11DE74E5DA6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2626D4EF;
	Thu, 13 Nov 2025 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="WZQfzm+V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D8271A71
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042730; cv=pass; b=KXsc4OrzYKp5tLI9lbkH1/QE+4OjAmxTzvFzZexSK4g9/9W7SY56ZwU8looopzapoXIUV2f5qZqbzaK3ZFysIJZ7bAWSC1QaJLbBQwCuKhErq4rSBXu154249ShXBKZvk+IFd7cuoaOmhvfp7WBvyxQXJwFbEzhUi2+QOqn2QKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042730; c=relaxed/simple;
	bh=v/49+4FAABpzMIbjoB706n9sUGznErVzEJV4VvX21/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpPJjTvyazO8AFsT55+NY8vVDKeR7d/+7bwTzBt4UGFk4VonN5yeSztKhef+321y2QoClpE4hhRyAifnZeu4RYE7OrB0PEP9yd9IYLeTt0RFf4VMRqgGflNAoyF9oMBpMQEopIhf/EZuvaSqEDyu0FOzjv3gblnDCGsavOhvAno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=WZQfzm+V; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1763042726; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=na2Gt/xKBDP6Es5qOCyNTLRYp+Mc01iidFoeGbk0gnBkzaSk7mNBLBX7vYLmI9Y0nUXzIr37PRxmqZIjZ7wUUkmP8BnST6LDiTyuSf/AcQX2EEsN9Wdck5/xhPcTbc110x/rTz3iGdohEd7p+flKhIjqCJLEFZNfrJkMSHdVdfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763042726; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3Bz70c5ShNmdcZIqjFMTipT0ENhM+pnhoXp2SNrLA70=; 
	b=EuuNLy+ZsGjtpxJ/Ka3+ANZUDMSoPNpV57SOWtl3N1ZFadtaF0lOLgRQxJdKOBuXNDMOhvkRnGJ9JeX+vFN07pYPSaDQ4q7jO1Xm7f6WnHLX3mbdSXTyaRIF2Piq92dimRXpSOjRJvAkAFgs9qtQXnse7WCNnsxKILxo45bmZTo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763042726;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3Bz70c5ShNmdcZIqjFMTipT0ENhM+pnhoXp2SNrLA70=;
	b=WZQfzm+Va/CO5zlc1RMeYK5I0zYSP5ARJFCx5JFwXlXNXMXUxMxJwQElw1cL9od1
	vwtkzFxOo1EuoEUbNw67dwg1QjyGB6sn1HOaITGVf6HxGO5C7ubY+oUbIOIecbnhdI9
	QVNTkzhRKaxyc6c504HoqoLhhGLYQmUE15oTFzXs=
Received: by mx.zohomail.com with SMTPS id 1763042724302244.83613262850577;
	Thu, 13 Nov 2025 06:05:24 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v4 3/5] wifi: mac80211: utilize the newly defined CMAC constants
Date: Thu, 13 Nov 2025 22:05:09 +0800
Message-ID: <20251113140511.48658-4-m@xv97.com>
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

Make use of the added constants to reduce duplication.

Signed-off-by: Chien Wong <m@xv97.com>
---
 net/mac80211/aes_cmac.c | 25 ++++++++++++-------------
 net/mac80211/aes_gmac.c | 22 ++++++++++++----------
 net/mac80211/aes_gmac.h |  1 -
 net/mac80211/wpa.c      |  2 +-
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index 65989c7dfc68..672ed80ee4ff 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -16,11 +16,9 @@
 #include "key.h"
 #include "aes_cmac.h"
 
-#define CMAC_TLEN 8 /* CMAC TLen = 64 bits (8 octets) */
-#define CMAC_TLEN_256 16 /* CMAC TLen = 128 bits (16 octets) */
 #define AAD_LEN 20
 
-static const u8 zero[CMAC_TLEN_256];
+static const u8 zero[IEEE80211_CMAC_256_MIC_LEN];
 
 int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
 		       const u8 *data, size_t data_len, u8 *mic)
@@ -44,20 +42,20 @@ int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
 		err = crypto_shash_update(desc, zero, 8);
 		if (err)
 			return err;
-		err = crypto_shash_update(desc, data + 8,
-					  data_len - 8 - CMAC_TLEN);
+		err = crypto_shash_update(desc, data + 8, data_len - 8 -
+					  IEEE80211_CMAC_128_MIC_LEN);
 		if (err)
 			return err;
 	} else {
-		err = crypto_shash_update(desc, data,
-					  data_len - CMAC_TLEN);
+		err = crypto_shash_update(desc, data, data_len -
+					  IEEE80211_CMAC_128_MIC_LEN);
 		if (err)
 			return err;
 	}
-	err = crypto_shash_finup(desc, zero, CMAC_TLEN, out);
+	err = crypto_shash_finup(desc, zero, IEEE80211_CMAC_128_MIC_LEN, out);
 	if (err)
 		return err;
-	memcpy(mic, out, CMAC_TLEN);
+	memcpy(mic, out, IEEE80211_CMAC_128_MIC_LEN);
 
 	return 0;
 }
@@ -83,16 +81,17 @@ int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
 		err = crypto_shash_update(desc, zero, 8);
 		if (err)
 			return err;
-		err = crypto_shash_update(desc, data + 8,
-					  data_len - 8 - CMAC_TLEN_256);
+		err = crypto_shash_update(desc, data + 8, data_len - 8 -
+					  IEEE80211_CMAC_256_MIC_LEN);
 		if (err)
 			return err;
 	} else {
-		err = crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
+		err = crypto_shash_update(desc, data, data_len -
+					  IEEE80211_CMAC_256_MIC_LEN);
 		if (err)
 			return err;
 	}
-	return crypto_shash_finup(desc, zero, CMAC_TLEN_256, mic);
+	return crypto_shash_finup(desc, zero, IEEE80211_CMAC_256_MIC_LEN, mic);
 }
 
 struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
diff --git a/net/mac80211/aes_gmac.c b/net/mac80211/aes_gmac.c
index 512cab073f2e..811a83d8d525 100644
--- a/net/mac80211/aes_gmac.c
+++ b/net/mac80211/aes_gmac.c
@@ -24,15 +24,16 @@ int ieee80211_aes_gmac(struct crypto_aead *tfm, const u8 *aad, u8 *nonce,
 	const __le16 *fc;
 	int ret;
 
-	if (data_len < GMAC_MIC_LEN)
+	if (data_len < IEEE80211_GMAC_MIC_LEN)
 		return -EINVAL;
 
-	aead_req = kzalloc(reqsize + GMAC_MIC_LEN + GMAC_AAD_LEN, GFP_ATOMIC);
+	aead_req = kzalloc(reqsize + IEEE80211_GMAC_MIC_LEN + GMAC_AAD_LEN,
+			   GFP_ATOMIC);
 	if (!aead_req)
 		return -ENOMEM;
 
 	zero = (u8 *)aead_req + reqsize;
-	__aad = zero + GMAC_MIC_LEN;
+	__aad = zero + IEEE80211_GMAC_MIC_LEN;
 	memcpy(__aad, aad, GMAC_AAD_LEN);
 
 	fc = (const __le16 *)aad;
@@ -41,15 +42,16 @@ int ieee80211_aes_gmac(struct crypto_aead *tfm, const u8 *aad, u8 *nonce,
 		sg_init_table(sg, 5);
 		sg_set_buf(&sg[0], __aad, GMAC_AAD_LEN);
 		sg_set_buf(&sg[1], zero, 8);
-		sg_set_buf(&sg[2], data + 8, data_len - 8 - GMAC_MIC_LEN);
-		sg_set_buf(&sg[3], zero, GMAC_MIC_LEN);
-		sg_set_buf(&sg[4], mic, GMAC_MIC_LEN);
+		sg_set_buf(&sg[2], data + 8,
+			   data_len - 8 - IEEE80211_GMAC_MIC_LEN);
+		sg_set_buf(&sg[3], zero, IEEE80211_GMAC_MIC_LEN);
+		sg_set_buf(&sg[4], mic, IEEE80211_GMAC_MIC_LEN);
 	} else {
 		sg_init_table(sg, 4);
 		sg_set_buf(&sg[0], __aad, GMAC_AAD_LEN);
-		sg_set_buf(&sg[1], data, data_len - GMAC_MIC_LEN);
-		sg_set_buf(&sg[2], zero, GMAC_MIC_LEN);
-		sg_set_buf(&sg[3], mic, GMAC_MIC_LEN);
+		sg_set_buf(&sg[1], data, data_len - IEEE80211_GMAC_MIC_LEN);
+		sg_set_buf(&sg[2], zero, IEEE80211_GMAC_MIC_LEN);
+		sg_set_buf(&sg[3], mic, IEEE80211_GMAC_MIC_LEN);
 	}
 
 	memcpy(iv, nonce, GMAC_NONCE_LEN);
@@ -78,7 +80,7 @@ struct crypto_aead *ieee80211_aes_gmac_key_setup(const u8 key[],
 
 	err = crypto_aead_setkey(tfm, key, key_len);
 	if (!err)
-		err = crypto_aead_setauthsize(tfm, GMAC_MIC_LEN);
+		err = crypto_aead_setauthsize(tfm, IEEE80211_GMAC_MIC_LEN);
 	if (!err)
 		return tfm;
 
diff --git a/net/mac80211/aes_gmac.h b/net/mac80211/aes_gmac.h
index c739356bae2a..206136b60bca 100644
--- a/net/mac80211/aes_gmac.h
+++ b/net/mac80211/aes_gmac.h
@@ -9,7 +9,6 @@
 #include <linux/crypto.h>
 
 #define GMAC_AAD_LEN	20
-#define GMAC_MIC_LEN	16
 #define GMAC_NONCE_LEN	12
 
 struct crypto_aead *ieee80211_aes_gmac_key_setup(const u8 key[],
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index bb0fa505cdca..3d5efd8c6e2d 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -1117,7 +1117,7 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 		memcpy(nonce, hdr->addr2, ETH_ALEN);
 		memcpy(nonce + ETH_ALEN, ipn, 6);
 
-		mic = kmalloc(GMAC_MIC_LEN, GFP_ATOMIC);
+		mic = kmalloc(IEEE80211_GMAC_MIC_LEN, GFP_ATOMIC);
 		if (!mic)
 			return RX_DROP_U_OOM;
 		if (ieee80211_aes_gmac(key->u.aes_gmac.tfm, aad, nonce,
-- 
2.51.2


