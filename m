Return-Path: <linux-wireless+bounces-28797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822EAC474F2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2F1188FAA0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460E30F945;
	Mon, 10 Nov 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="HBNk/DaK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA0757EA
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785968; cv=pass; b=th6aE/bphCfe5/jKNrMqFNFzJPBV4WnD6ecuHzKavU8udqLaGV6EzC7aWeRBM9Xxk5mdHCFVLlJBdUfrZc8oxx3fQERQY37m16uZd78d3Vlqa/I3vDOwXuTl4ryWEFrOv7YA6OWwq6lzwhfHNS7myHV41GDYDEKn5bIIzHC9YyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785968; c=relaxed/simple;
	bh=mHikLFqo480QOqbrWXqU8+BoZ9xbQuCFQHgxIn/jpNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwxjbO6dKeXT/BtKboVJ5FUUmoiOWI34d+NSXV1bC03azc1IM75HV7ijQjg3aS/NNLSu/RTfa5++AXFsLOxOuWJB7av97Mdgh36zyab7Tno2kXfYQUXrhTrX/zX/t8apa5QRODNPnr8TvfbGOg3b+ZKtXE3kFHjHI3gv3rgUofw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=HBNk/DaK; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762785962; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eQc8JLsFy9PjyEL8rNqckIgdmtt89iWlCwGqx8gIpwxzeAp1wSxgV6i7Zpb5BFTtXV+tHESdDPSiuo5x3s0i709vJ2lXemY7BJCkpRxeOr9ch5VdQ17DzAUmZvueH1T8iW5Q4m3dbNwSANVnYX4/pOz4Ha+0jNolOcYZ2YFyPo8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762785962; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V33zX0Ri3YMpgO5clYPZMiJIEI0wCJdVCo6F7i4kZYw=; 
	b=GEdy2HzearyaHcEmsydvsGmt34NMXb+OaG1JPMua/kvLk7AWQCnKWAHyfxpNGTqNqP+LHX638f7m30Jefb8E0hFVWL4rUnbfxD0xrOOdJZROfh4fgrJ9Yvx7Cy98MQV6cwlcDXooI15aahhqNJvOsURwKzqvqpYbDxjEpQfZuyo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762785962;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=V33zX0Ri3YMpgO5clYPZMiJIEI0wCJdVCo6F7i4kZYw=;
	b=HBNk/DaKPiFiFxC6RNPk7Hjy0AFTEob06jzwmIGb8fqpqFVH76n7rPk7CqCmE6WC
	26XDCeGRRrrsUA0Dkuk6/cvmLuQpc4hQELEAkvWxPlyQN0G90SMj7viTEyxAUsyka04
	gkE97yKiyEM97JV9nTu12bFOUEKENIrLpMqcKGec=
Received: by mx.zohomail.com with SMTPS id 1762785961367278.8062645233297;
	Mon, 10 Nov 2025 06:46:01 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 5/6] wifi: mac80211: refactor CMAC crypt functions
Date: Mon, 10 Nov 2025 22:45:44 +0800
Message-ID: <20251110144545.15149-6-m@xv97.com>
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

ieee80211_aes_cmac() and ieee80211_aes_cmac_256() are almost the same.
Merge them. This removes duplication.
All references to the refactored functions in the tree are adapted.

Signed-off-by: Chien Wong <m@xv97.com>
---
 net/mac80211/aes_cmac.c | 49 +++++++----------------------------------
 net/mac80211/aes_cmac.h |  4 +---
 net/mac80211/wpa.c      | 16 +++++++++-----
 3 files changed, 19 insertions(+), 50 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index 2c2d15c50b65..a44dda08aaa4 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -16,52 +16,20 @@
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
 	const __le16 *fc;
 
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
-		err = crypto_shash_update(desc, data + 8, data_len - 8 - CMAC_TLEN);
-		if (err)
-			goto out;
-	} else {
-		err = crypto_shash_update(desc, data, data_len - CMAC_TLEN);
-		if (err)
-			goto out;
-	}
-	err = crypto_shash_finup(desc, zero, CMAC_TLEN, mic);
-out:
-	return err;
-}
-
-int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-			   const u8 *data, size_t data_len, u8 *mic)
-{
-	int err;
-	SHASH_DESC_ON_STACK(desc, tfm);
-	const __le16 *fc;
+	if (mic_len != IEEE80211_CMAC_128_MIC_LEN &&
+	    mic_len != IEEE80211_CMAC_256_MIC_LEN)
+		return -EINVAL;
 
 	desc->tfm = tfm;
 
@@ -77,16 +45,15 @@ int ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
 		err = crypto_shash_update(desc, zero, 8);
 		if (err)
 			goto out;
-		err = crypto_shash_update(desc, data + 8,
-					  data_len - 8 - CMAC_TLEN_256);
+		err = crypto_shash_update(desc, data + 8, data_len - 8 - mic_len);
 		if (err)
 			goto out;
 	} else {
-		err = crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
+		err = crypto_shash_update(desc, data, data_len - mic_len);
 		if (err)
 			goto out;
 	}
-	err = crypto_shash_finup(desc, zero, CMAC_TLEN_256, mic);
+	err = crypto_shash_finup(desc, zero, mic_len, mic);
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


