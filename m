Return-Path: <linux-wireless+bounces-28852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86BBC4EAB2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 16:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E1E18C3FE1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20825325716;
	Tue, 11 Nov 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="rW5aNt/F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender3-op-o15.zoho.com (sender3-op-o15.zoho.com [136.143.184.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03982FBE0E
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873105; cv=pass; b=Y/JpvPAZDZCUv8B/ytpaxUVQgZJCrN8+1i5k6xPTtqqn5mfrmr71uX4sbx8tyz8uDjJSXq8xBrLbHQDdeJkrHA0k4CS2V+r/CY8kYwaYYrD1vAAlloiuRsme9MUiyrDLFa8pXRVG0sipKDptlArDjrw7fbdt83WNmOu8pjKi+xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873105; c=relaxed/simple;
	bh=lKRHFDsWeXJ4vjCqISmf3bG5qDyT4YRUW3Hm4JDesSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrOHoNAwRdN4iUOZpPfGKgE99Ctux7305pmvlJLvMzRaAeh+d1u7ZFa9SdnAMlr8FStydZiYmMhQP0AVEZphSdUkgEfvqZGXqkflTdr75SbM8EVYRHyC/re1U8k7uJ2olcdNQU+sXlCv7ZIO6QRk3TV8aEbni5HtIUy7TIGuRj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=rW5aNt/F; arc=pass smtp.client-ip=136.143.184.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762873099; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YNpiUz/4Lz8rFQHsvaSL4uOoyMrlb4Z304tURFZhzHj97/4Y8V8w/HFzMBujhP1BxiDoYzn0f5CP2RAgh1YBbJ+qdbtKEWDcwKtSKrBXVbvpXq/srzW8O0oClpHU4dnCCMU/LlXPU7XlKFqyUK82QsQP9oo9KnbDCP3fyNp+nYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762873099; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oTf0oy9zPAi7CyP+270ZpoElz7HLT709wnCLXa1A45E=; 
	b=MhWra50s+gzlrn7oE2Ypt1apTruTt2LpQekOYrx4Ql5Zadq1W25i0L1isfiXelIURU0IM5r8gazRwiurEuUqKBsmWchih1puPmNBWveS+KUnSH20TACKZZqavbgfN1IWORDaqslIocqG+14LZRJUZFkfMthZCsfJpAEtvMppnEc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762873099;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oTf0oy9zPAi7CyP+270ZpoElz7HLT709wnCLXa1A45E=;
	b=rW5aNt/FKnk4+b87Jd4CeUdzXj61aMp2L57yo3EhEwRwNfVrPEuGXHqCOJVTcx/G
	PHuIhU2dFoK9g5TtDP+wl2+usvK1UOdDit2WyRxDbM33z3HyT1Pao0RdrbIT5QEv5U5
	XG6ZsNV/F3kafPVf/KZX+B4/QzhixMDGzcrWYV0w=
Received: by mx.zohomail.com with SMTPS id 1762873098124210.50658522108142;
	Tue, 11 Nov 2025 06:58:18 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3 5/5] wifi: mac80211: refactor CMAC packet handlers
Date: Tue, 11 Nov 2025 22:57:59 +0800
Message-ID: <20251111145759.111691-6-m@xv97.com>
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

Merge CMAC-128 and CMAC-256 handlers since they are almost the same.
This removes duplication.
All references to the refactored functions in the tree are adapted.

The comment 'MIC = AES-128-CMAC(IGTK, AAD ...' is out-dated since CMAC
is also used with BIGTK, as is the comment for CMAC-256. Simply remove
the comments.

Tested-on: mac80211_hwsim

Signed-off-by: Chien Wong <m@xv97.com>
---
 net/mac80211/rx.c  |   6 +-
 net/mac80211/tx.c  |   6 +-
 net/mac80211/wpa.c | 144 ++++++++-------------------------------------
 net/mac80211/wpa.h |  10 ++--
 4 files changed, 35 insertions(+), 131 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 80067ed1da2f..4c1b649b844a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2215,10 +2215,12 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 			rx, IEEE80211_CCMP_256_MIC_LEN);
 		break;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		result = ieee80211_crypto_aes_cmac_decrypt(rx);
+		result = ieee80211_crypto_aes_cmac_decrypt(
+			rx, IEEE80211_CMAC_128_MIC_LEN);
 		break;
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		result = ieee80211_crypto_aes_cmac_256_decrypt(rx);
+		result = ieee80211_crypto_aes_cmac_decrypt(
+			rx, IEEE80211_CMAC_256_MIC_LEN);
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e7b141c55f7a..9d8b0a25f73c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1062,9 +1062,11 @@ ieee80211_tx_h_encrypt(struct ieee80211_tx_data *tx)
 		return ieee80211_crypto_ccmp_encrypt(
 			tx, IEEE80211_CCMP_256_MIC_LEN);
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		return ieee80211_crypto_aes_cmac_encrypt(tx);
+		return ieee80211_crypto_aes_cmac_encrypt(
+			tx, IEEE80211_CMAC_128_MIC_LEN);
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		return ieee80211_crypto_aes_cmac_256_encrypt(tx);
+		return ieee80211_crypto_aes_cmac_encrypt(
+			tx, IEEE80211_CMAC_256_MIC_LEN);
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 		return ieee80211_crypto_aes_gmac_encrypt(tx);
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 2c1ee4b8e205..2f8bd5216542 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -828,12 +828,14 @@ static inline void bip_ipn_swap(u8 *d, const u8 *s)
 
 
 ieee80211_tx_result
-ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx)
+ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx,
+				  unsigned int mic_len)
 {
 	struct sk_buff *skb;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_key *key = tx->key;
-	struct ieee80211_mmie *mmie;
+	struct ieee80211_mmie_var *mmie;
+	size_t mmie_len;
 	u8 aad[20];
 	u64 pn64;
 
@@ -848,62 +850,14 @@ ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx)
 	    !(key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_MMIE))
 		return TX_CONTINUE;
 
-	if (WARN_ON(skb_tailroom(skb) < sizeof(*mmie)))
-		return TX_DROP;
-
-	mmie = skb_put(skb, sizeof(*mmie));
-	mmie->element_id = WLAN_EID_MMIE;
-	mmie->length = sizeof(*mmie) - 2;
-	mmie->key_id = cpu_to_le16(key->conf.keyidx);
+	mmie_len = sizeof(*mmie) + mic_len;
 
-	/* PN = PN + 1 */
-	pn64 = atomic64_inc_return(&key->conf.tx_pn);
-
-	bip_ipn_set64(mmie->sequence_number, pn64);
-
-	if (info->control.hw_key)
-		return TX_CONTINUE;
-
-	bip_aad(skb, aad);
-
-	/*
-	 * MIC = AES-128-CMAC(IGTK, AAD || Management Frame Body || MMIE, 64)
-	 */
-	if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-			       skb->data + 24, skb->len - 24, mmie->mic,
-			       IEEE80211_CMAC_128_MIC_LEN))
+	if (WARN_ON(skb_tailroom(skb) < mmie_len))
 		return TX_DROP;
 
-	return TX_CONTINUE;
-}
-
-ieee80211_tx_result
-ieee80211_crypto_aes_cmac_256_encrypt(struct ieee80211_tx_data *tx)
-{
-	struct sk_buff *skb;
-	struct ieee80211_tx_info *info;
-	struct ieee80211_key *key = tx->key;
-	struct ieee80211_mmie_16 *mmie;
-	u8 aad[20];
-	u64 pn64;
-
-	if (WARN_ON(skb_queue_len(&tx->skbs) != 1))
-		return TX_DROP;
-
-	skb = skb_peek(&tx->skbs);
-
-	info = IEEE80211_SKB_CB(skb);
-
-	if (info->control.hw_key &&
-	    !(key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_MMIE))
-		return TX_CONTINUE;
-
-	if (WARN_ON(skb_tailroom(skb) < sizeof(*mmie)))
-		return TX_DROP;
-
-	mmie = skb_put(skb, sizeof(*mmie));
+	mmie = skb_put(skb, mmie_len);
 	mmie->element_id = WLAN_EID_MMIE;
-	mmie->length = sizeof(*mmie) - 2;
+	mmie->length = mmie_len - 2;
 	mmie->key_id = cpu_to_le16(key->conf.keyidx);
 
 	/* PN = PN + 1 */
@@ -916,90 +870,39 @@ ieee80211_crypto_aes_cmac_256_encrypt(struct ieee80211_tx_data *tx)
 
 	bip_aad(skb, aad);
 
-	/* MIC = AES-256-CMAC(IGTK, AAD || Management Frame Body || MMIE, 128)
-	 */
 	if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-			       skb->data + 24, skb->len - 24, mmie->mic,
-			       IEEE80211_CMAC_256_MIC_LEN))
+			       skb->data + 24, skb->len - 24, mmie->mic, mic_len))
 		return TX_DROP;
 
 	return TX_CONTINUE;
 }
 
 ieee80211_rx_result
-ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx)
+ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx,
+				  unsigned int mic_len)
 {
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_key *key = rx->key;
-	struct ieee80211_mmie *mmie;
-	u8 aad[20], mic[8], ipn[6];
+	struct ieee80211_mmie_var *mmie;
+	size_t mmie_len;
+	u8 aad[20], mic[IEEE80211_CMAC_256_MIC_LEN], ipn[6];
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 
 	if (!ieee80211_is_mgmt(hdr->frame_control))
 		return RX_CONTINUE;
 
-	/* management frames are already linear */
-
-	if (skb->len < 24 + sizeof(*mmie))
-		return RX_DROP_U_SHORT_CMAC;
-
-	mmie = (struct ieee80211_mmie *)
-		(skb->data + skb->len - sizeof(*mmie));
-	if (mmie->element_id != WLAN_EID_MMIE ||
-	    mmie->length != sizeof(*mmie) - 2)
-		return RX_DROP_U_BAD_MMIE; /* Invalid MMIE */
-
-	bip_ipn_swap(ipn, mmie->sequence_number);
-
-	if (memcmp(ipn, key->u.aes_cmac.rx_pn, 6) <= 0) {
-		key->u.aes_cmac.replays++;
-		return RX_DROP_U_REPLAY;
-	}
-
-	if (!(status->flag & RX_FLAG_DECRYPTED)) {
-		/* hardware didn't decrypt/verify MIC */
-		bip_aad(skb, aad);
-		if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-				       skb->data + 24, skb->len - 24, mic,
-				       IEEE80211_CMAC_128_MIC_LEN))
-			return RX_DROP_U_DECRYPT_FAIL;
-		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
-			key->u.aes_cmac.icverrors++;
-			return RX_DROP_U_MIC_FAIL;
-		}
-	}
-
-	memcpy(key->u.aes_cmac.rx_pn, ipn, 6);
-
-	/* Remove MMIE */
-	skb_trim(skb, skb->len - sizeof(*mmie));
-
-	return RX_CONTINUE;
-}
-
-ieee80211_rx_result
-ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx)
-{
-	struct sk_buff *skb = rx->skb;
-	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-	struct ieee80211_key *key = rx->key;
-	struct ieee80211_mmie_16 *mmie;
-	u8 aad[20], mic[16], ipn[6];
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-
-	if (!ieee80211_is_mgmt(hdr->frame_control))
-		return RX_CONTINUE;
+	mmie_len = sizeof(*mmie) + mic_len;
 
 	/* management frames are already linear */
 
-	if (skb->len < 24 + sizeof(*mmie))
-		return RX_DROP_U_SHORT_CMAC256;
+	if (skb->len < 24 + mmie_len)
+		return mic_len == IEEE80211_CMAC_128_MIC_LEN ?
+				  RX_DROP_U_SHORT_CMAC : RX_DROP_U_SHORT_CMAC256;
 
-	mmie = (struct ieee80211_mmie_16 *)
-		(skb->data + skb->len - sizeof(*mmie));
+	mmie = (struct ieee80211_mmie_var *)(skb->data + skb->len - mmie_len);
 	if (mmie->element_id != WLAN_EID_MMIE ||
-	    mmie->length != sizeof(*mmie) - 2)
+	    mmie->length != mmie_len - 2)
 		return RX_DROP_U_BAD_MMIE; /* Invalid MMIE */
 
 	bip_ipn_swap(ipn, mmie->sequence_number);
@@ -1013,10 +916,9 @@ ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx)
 		/* hardware didn't decrypt/verify MIC */
 		bip_aad(skb, aad);
 		if (ieee80211_aes_cmac(key->u.aes_cmac.tfm, aad,
-				       skb->data + 24, skb->len - 24, mic,
-				       IEEE80211_CMAC_256_MIC_LEN))
+				       skb->data + 24, skb->len - 24, mic, mic_len))
 			return RX_DROP_U_DECRYPT_FAIL;
-		if (crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
+		if (crypto_memneq(mic, mmie->mic, mic_len)) {
 			key->u.aes_cmac.icverrors++;
 			return RX_DROP_U_MIC_FAIL;
 		}
@@ -1025,7 +927,7 @@ ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx)
 	memcpy(key->u.aes_cmac.rx_pn, ipn, 6);
 
 	/* Remove MMIE */
-	skb_trim(skb, skb->len - sizeof(*mmie));
+	skb_trim(skb, skb->len - mmie_len);
 
 	return RX_CONTINUE;
 }
diff --git a/net/mac80211/wpa.h b/net/mac80211/wpa.h
index a9a81abb5479..6e8846dfe710 100644
--- a/net/mac80211/wpa.h
+++ b/net/mac80211/wpa.h
@@ -29,13 +29,11 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 			      unsigned int mic_len);
 
 ieee80211_tx_result
-ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx);
-ieee80211_tx_result
-ieee80211_crypto_aes_cmac_256_encrypt(struct ieee80211_tx_data *tx);
-ieee80211_rx_result
-ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx);
+ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx,
+				  unsigned int mic_len);
 ieee80211_rx_result
-ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx);
+ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx,
+				  unsigned int mic_len);
 ieee80211_tx_result
 ieee80211_crypto_aes_gmac_encrypt(struct ieee80211_tx_data *tx);
 ieee80211_rx_result
-- 
2.51.2


