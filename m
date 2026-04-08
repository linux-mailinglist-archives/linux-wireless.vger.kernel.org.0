Return-Path: <linux-wireless+bounces-34508-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI2MKV7H1WnA9wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34508-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:11:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 225913B6806
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77516304CE90
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 03:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3A373C16;
	Wed,  8 Apr 2026 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkuLeyL8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EC36E49F;
	Wed,  8 Apr 2026 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617768; cv=none; b=omsCa0Su7G/eJUOpugG2pxrIjex3Tkf5ASy1La24VPHAtz02jiSBO9j7QZQW6gPrqbnq/UW6LvPfr6E2JBjRGBZxFFTEQrq7ZtWI2A6+roMG17c0xKK0nA3DVomGm25o/Xoo/WIuK5ya5wuuxBfEcp26LbG/vbUNOOzTNtDyaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617768; c=relaxed/simple;
	bh=Q1v+JpOLlfcBi2mZKAzGiUmr5p7F4seOZvQEILD4LS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbBWbTsFCUVzfvOysHdtl82IWTflefsH2NxUylmCcb+wALTL2s+Z9/PLXcrJbJ1/iaKQIE3ZnbkFTxlhNnCcEo22GOSfu80Ot9L0XTYi5LMFtnWRvuPlTvuLz/jfSTd6EcZkqHkXWUUwzBu7xrLx7f7ykbdxEXd3C3uRahH09sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkuLeyL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F7EC2BC9E;
	Wed,  8 Apr 2026 03:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775617768;
	bh=Q1v+JpOLlfcBi2mZKAzGiUmr5p7F4seOZvQEILD4LS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkuLeyL8OyVQLZQLyx9ww4s/F159lQE+PGrgLtjHlxzounK9A2SvX2pz2ozEWDbZs
	 jWt5yswhX7qMJ/mR6cVyE2Pn/4lXCasMeY87TXLPiK5848mprgQGBPP7gMOVe9uHkp
	 kB1bgnbE1sWl848Fy6e6uOd8AvBpLiW1DapsBbQ3G0SmFqAGjcjeLPkeowp0f+1kVJ
	 wuVKYJG44etv34gqw76kY7tmg6v8TODxsun3C46+b3kRAdUETo1tpz/zaXnJBm3tN1
	 N9HlBCtWCH90brLfFV6joq2SfTUNLYXBTVjcfIdmTNPqM/foFSsFKUXl2lXvjQXr/6
	 up+swzepKnR9Q==
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH wireless-next v2 5/6] wifi: ipw2x00: Use michael_mic() from cfg80211
Date: Tue,  7 Apr 2026 20:06:50 -0700
Message-ID: <20260408030651.80336-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408030651.80336-1-ebiggers@kernel.org>
References: <20260408030651.80336-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34508-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 225913B6806
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just use the michael_mic() function from cfg80211 instead of a local
implementation of it using the crypto_shash API.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/net/wireless/intel/ipw2x00/Kconfig    |   1 -
 .../intel/ipw2x00/libipw_crypto_tkip.c        | 120 +-----------------
 2 files changed, 5 insertions(+), 116 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/Kconfig b/drivers/net/wireless/intel/ipw2x00/Kconfig
index b92df91adb3a4..b508f14542d5d 100644
--- a/drivers/net/wireless/intel/ipw2x00/Kconfig
+++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
@@ -152,11 +152,10 @@ config IPW2200_DEBUG
 config LIBIPW
 	tristate
 	depends on PCI && CFG80211
 	select WIRELESS_EXT
 	select CRYPTO
-	select CRYPTO_MICHAEL_MIC
 	select CRYPTO_LIB_ARC4
 	select CRC32
 	help
 	This option enables the hardware independent IEEE 802.11
 	networking stack.  This component is deprecated in favor of the
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
index c2cd6808fd0fe..24bb28ab7a49b 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
@@ -23,12 +23,10 @@
 #include <asm/string.h>
 #include <linux/wireless.h>
 #include <linux/ieee80211.h>
 #include <net/iw_handler.h>
 #include <crypto/arc4.h>
-#include <crypto/hash.h>
-#include <linux/crypto.h>
 #include <linux/crc32.h>
 #include "libipw.h"
 
 #define TKIP_HDR_LEN 8
 
@@ -55,15 +53,10 @@ struct libipw_tkip_data {
 
 	int key_idx;
 
 	struct arc4_ctx rx_ctx_arc4;
 	struct arc4_ctx tx_ctx_arc4;
-	struct crypto_shash *rx_tfm_michael;
-	struct crypto_shash *tx_tfm_michael;
-
-	/* scratch buffers for virt_to_page() (crypto API) */
-	u8 rx_hdr[16], tx_hdr[16];
 
 	unsigned long flags;
 };
 
 static unsigned long libipw_tkip_set_flags(unsigned long flags, void *priv)
@@ -87,45 +80,18 @@ static void *libipw_tkip_init(int key_idx)
 	if (fips_enabled)
 		return NULL;
 
 	priv = kzalloc_obj(*priv, GFP_ATOMIC);
 	if (priv == NULL)
-		goto fail;
+		return priv;
 
 	priv->key_idx = key_idx;
-
-	priv->tx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
-	if (IS_ERR(priv->tx_tfm_michael)) {
-		priv->tx_tfm_michael = NULL;
-		goto fail;
-	}
-
-	priv->rx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
-	if (IS_ERR(priv->rx_tfm_michael)) {
-		priv->rx_tfm_michael = NULL;
-		goto fail;
-	}
-
 	return priv;
-
-      fail:
-	if (priv) {
-		crypto_free_shash(priv->tx_tfm_michael);
-		crypto_free_shash(priv->rx_tfm_michael);
-		kfree(priv);
-	}
-
-	return NULL;
 }
 
 static void libipw_tkip_deinit(void *priv)
 {
-	struct libipw_tkip_data *_priv = priv;
-	if (_priv) {
-		crypto_free_shash(_priv->tx_tfm_michael);
-		crypto_free_shash(_priv->rx_tfm_michael);
-	}
 	kfree_sensitive(priv);
 }
 
 static inline u16 RotR1(u16 val)
 {
@@ -462,77 +428,10 @@ static int libipw_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	skb_trim(skb, skb->len - 4);
 
 	return keyidx;
 }
 
-static int libipw_michael_mic(struct crypto_shash *tfm_michael, u8 *key, u8 *hdr,
-		       u8 *data, size_t data_len, u8 *mic)
-{
-	SHASH_DESC_ON_STACK(desc, tfm_michael);
-	int err;
-
-	if (tfm_michael == NULL) {
-		pr_warn("%s(): tfm_michael == NULL\n", __func__);
-		return -1;
-	}
-
-	desc->tfm = tfm_michael;
-
-	if (crypto_shash_setkey(tfm_michael, key, 8))
-		return -1;
-
-	err = crypto_shash_init(desc);
-	if (err)
-		goto out;
-	err = crypto_shash_update(desc, hdr, 16);
-	if (err)
-		goto out;
-	err = crypto_shash_update(desc, data, data_len);
-	if (err)
-		goto out;
-	err = crypto_shash_final(desc, mic);
-
-out:
-	shash_desc_zero(desc);
-	return err;
-}
-
-static void michael_mic_hdr(struct sk_buff *skb, u8 * hdr)
-{
-	struct ieee80211_hdr *hdr11;
-
-	hdr11 = (struct ieee80211_hdr *)skb->data;
-
-	switch (le16_to_cpu(hdr11->frame_control) &
-		(IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS)) {
-	case IEEE80211_FCTL_TODS:
-		memcpy(hdr, hdr11->addr3, ETH_ALEN);	/* DA */
-		memcpy(hdr + ETH_ALEN, hdr11->addr2, ETH_ALEN);	/* SA */
-		break;
-	case IEEE80211_FCTL_FROMDS:
-		memcpy(hdr, hdr11->addr1, ETH_ALEN);	/* DA */
-		memcpy(hdr + ETH_ALEN, hdr11->addr3, ETH_ALEN);	/* SA */
-		break;
-	case IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS:
-		memcpy(hdr, hdr11->addr3, ETH_ALEN);	/* DA */
-		memcpy(hdr + ETH_ALEN, hdr11->addr4, ETH_ALEN);	/* SA */
-		break;
-	default:
-		memcpy(hdr, hdr11->addr1, ETH_ALEN);	/* DA */
-		memcpy(hdr + ETH_ALEN, hdr11->addr2, ETH_ALEN);	/* SA */
-		break;
-	}
-
-	if (ieee80211_is_data_qos(hdr11->frame_control)) {
-		hdr[12] = le16_to_cpu(*((__le16 *)ieee80211_get_qos_ctl(hdr11)))
-			& IEEE80211_QOS_CTL_TID_MASK;
-	} else
-		hdr[12] = 0;		/* priority */
-
-	hdr[13] = hdr[14] = hdr[15] = 0;	/* reserved */
-}
-
 static int libipw_michael_mic_add(struct sk_buff *skb, int hdr_len,
 				     void *priv)
 {
 	struct libipw_tkip_data *tkey = priv;
 	u8 *pos;
@@ -542,16 +441,13 @@ static int libipw_michael_mic_add(struct sk_buff *skb, int hdr_len,
 		       "(tailroom=%d hdr_len=%d skb->len=%d)\n",
 		       skb_tailroom(skb), hdr_len, skb->len);
 		return -1;
 	}
 
-	michael_mic_hdr(skb, tkey->tx_hdr);
 	pos = skb_put(skb, 8);
-	if (libipw_michael_mic(tkey->tx_tfm_michael, &tkey->key[16], tkey->tx_hdr,
-			skb->data + hdr_len, skb->len - 8 - hdr_len, pos))
-		return -1;
-
+	michael_mic(&tkey->key[16], (struct ieee80211_hdr *)skb->data,
+		    skb->data + hdr_len, skb->len - 8 - hdr_len, pos);
 	return 0;
 }
 
 static void libipw_michael_mic_failure(struct net_device *dev,
 					  struct ieee80211_hdr *hdr,
@@ -581,14 +477,12 @@ static int libipw_michael_mic_verify(struct sk_buff *skb, int keyidx,
 	u8 mic[8];
 
 	if (!tkey->key_set)
 		return -1;
 
-	michael_mic_hdr(skb, tkey->rx_hdr);
-	if (libipw_michael_mic(tkey->rx_tfm_michael, &tkey->key[24], tkey->rx_hdr,
-			skb->data + hdr_len, skb->len - 8 - hdr_len, mic))
-		return -1;
+	michael_mic(&tkey->key[24], (struct ieee80211_hdr *)skb->data,
+		    skb->data + hdr_len, skb->len - 8 - hdr_len, mic);
 	if (memcmp(mic, skb->data + skb->len - 8, 8) != 0) {
 		struct ieee80211_hdr *hdr;
 		hdr = (struct ieee80211_hdr *)skb->data;
 		printk(KERN_DEBUG "%s: Michael MIC verification failed for "
 		       "MSDU from %pM keyidx=%d\n",
@@ -612,21 +506,17 @@ static int libipw_michael_mic_verify(struct sk_buff *skb, int keyidx,
 
 static int libipw_tkip_set_key(void *key, int len, u8 * seq, void *priv)
 {
 	struct libipw_tkip_data *tkey = priv;
 	int keyidx;
-	struct crypto_shash *tfm = tkey->tx_tfm_michael;
 	struct arc4_ctx *tfm2 = &tkey->tx_ctx_arc4;
-	struct crypto_shash *tfm3 = tkey->rx_tfm_michael;
 	struct arc4_ctx *tfm4 = &tkey->rx_ctx_arc4;
 
 	keyidx = tkey->key_idx;
 	memset(tkey, 0, sizeof(*tkey));
 	tkey->key_idx = keyidx;
-	tkey->tx_tfm_michael = tfm;
 	tkey->tx_ctx_arc4 = *tfm2;
-	tkey->rx_tfm_michael = tfm3;
 	tkey->rx_ctx_arc4 = *tfm4;
 	if (len == TKIP_KEY_LEN) {
 		memcpy(tkey->key, key, TKIP_KEY_LEN);
 		tkey->key_set = 1;
 		tkey->tx_iv16 = 1;	/* TSC is initialized to 1 */
-- 
2.53.0


