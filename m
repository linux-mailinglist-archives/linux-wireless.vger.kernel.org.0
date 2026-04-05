Return-Path: <linux-wireless+bounces-34353-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNkZEjPz0WlYRgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34353-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:29:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB639D5F4
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DCFD300646F
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2026 05:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E634D38B;
	Sun,  5 Apr 2026 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PInL7lxk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AC34CFAD;
	Sun,  5 Apr 2026 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775366954; cv=none; b=lA5tawP/NzPwUMLhOvpduC+KfO7Y/hQ5tLtTUk1BwhkLCRVyx1e5b/8cHbVXUoFtQgeGUAFhRx6pFoPdWvY3rnizuhfsBP2cWplz+tjs8sDcyResTTm2aYM1xdKGOpg1/IcyX6XyxbeTnRFLPzLK0mWHRjTlafGhMyw9zWtqvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775366954; c=relaxed/simple;
	bh=eRxUnQMseAOoYSK3bx4LLgXCdFNIL6YsBJvi65Ofb9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXkwzeBZB963LKWasD6Y/4hNymd3vCA8iKzKMQ+5c/h7hMPhXyL/rFZiWM4+AlygsO9Inq5RhCvcefn/vmM5KA8nU6TGU5jbbezg1Vfulz/diCmdP1WUNjbnrqtUVv8GTu813csbq2VFpHA6FDT6HlGu+dOuJkt1wRNcz1FOADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PInL7lxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35308C116C6;
	Sun,  5 Apr 2026 05:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775366954;
	bh=eRxUnQMseAOoYSK3bx4LLgXCdFNIL6YsBJvi65Ofb9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PInL7lxkoct0ccO3CBxA9kvQBerpcKdfIx2MuvLtrZ6M+iTJAtQlJ3y6hYTvN0Ose
	 EQL7OAFke7p0pOtDXpZYoiNRu21r9zazBRtDZlEC2zpqasngbMcPsLIIe6EawX9MWt
	 fRqtFKzUdmqbMg1vEMOwqTRDVW0XLOH6z5L2MdHlrYQ6mdVajhtFe2VWUlw0nhh4Wo
	 vsraIeJIqhCCxFdgJWgSExgZID+o22IbeKERvUtjn7ycxGElUxLl6zd9EMXsgXmXSX
	 At7I2YQDNsOziL26TLFCTwHElLHHnwLqASawGJkU1IxM0LKGg563niIEsgnYgrULEs
	 uHmvf78iHKO5A==
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH wireless-next 2/6] wifi: ath11k: Use michael_mic() from mac80211
Date: Sat,  4 Apr 2026 22:27:30 -0700
Message-ID: <20260405052734.130368-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405052734.130368-1-ebiggers@kernel.org>
References: <20260405052734.130368-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34353-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DEDB639D5F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just use the michael_mic() function from mac80211 instead of a local
implementation of it on top of the crypto_shash API.

Preserve the check for fips_enabled which was present implicitly in the
crypto_shash-based code.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/net/wireless/ath/ath11k/Kconfig |  1 -
 drivers/net/wireless/ath/ath11k/dp.c    |  2 -
 drivers/net/wireless/ath/ath11k/dp_rx.c | 60 +++----------------------
 drivers/net/wireless/ath/ath11k/peer.h  |  1 -
 4 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 47dfd39caa89a..385513cfdc30e 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -1,10 +1,9 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 config ATH11K
 	tristate "Qualcomm Technologies 802.11ax chipset support"
 	depends on MAC80211 && HAS_DMA
-	select CRYPTO_MICHAEL_MIC
 	select ATH_COMMON
 	select QCOM_QMI_HELPERS
 	help
 	  This module adds support for Qualcomm Technologies 802.11ax family of
 	  chipsets.
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index c940de285276d..bbb86f1651419 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -3,11 +3,10 @@
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include <crypto/hash.h>
 #include <linux/export.h>
 #include "core.h"
 #include "dp_tx.h"
 #include "hal_tx.h"
 #include "hif.h"
@@ -37,11 +36,10 @@ void ath11k_dp_peer_cleanup(struct ath11k *ar, int vdev_id, const u8 *addr)
 		return;
 	}
 
 	ath11k_peer_rx_tid_cleanup(ar, peer);
 	peer->dp_setup_done = false;
-	crypto_free_shash(peer->tfm_mmic);
 	spin_unlock_bh(&ab->base_lock);
 }
 
 int ath11k_dp_peer_setup(struct ath11k *ar, int vdev_id, const u8 *addr)
 {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 49d959b2e1480..00df93e41fa80 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2,14 +2,14 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/fips.h>
 #include <linux/ieee80211.h>
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
-#include <crypto/hash.h>
 #include "core.h"
 #include "debug.h"
 #include "debugfs_htt_stats.h"
 #include "debugfs_sta.h"
 #include "hal_desc.h"
@@ -3181,96 +3181,50 @@ static void ath11k_dp_rx_frag_timer(struct timer_list *timer)
 }
 
 int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct crypto_shash *tfm;
 	struct ath11k_peer *peer;
 	struct dp_rx_tid *rx_tid;
 	int i;
 
-	tfm = crypto_alloc_shash("michael_mic", 0, 0);
-	if (IS_ERR(tfm)) {
-		ath11k_warn(ab, "failed to allocate michael_mic shash: %ld\n",
-			    PTR_ERR(tfm));
-		return PTR_ERR(tfm);
+	if (fips_enabled) {
+		ath11k_warn(ab, "Michael MIC is not FIPS-allowed");
+		return -ENOENT;
 	}
 
 	spin_lock_bh(&ab->base_lock);
 
 	peer = ath11k_peer_find(ab, vdev_id, peer_mac);
 	if (!peer) {
 		ath11k_warn(ab, "failed to find the peer to set up fragment info\n");
 		spin_unlock_bh(&ab->base_lock);
-		crypto_free_shash(tfm);
 		return -ENOENT;
 	}
 
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
 		rx_tid = &peer->rx_tid[i];
 		rx_tid->ab = ab;
 		timer_setup(&rx_tid->frag_timer, ath11k_dp_rx_frag_timer, 0);
 		skb_queue_head_init(&rx_tid->rx_frags);
 	}
 
-	peer->tfm_mmic = tfm;
 	peer->dp_setup_done = true;
 	spin_unlock_bh(&ab->base_lock);
 
 	return 0;
 }
 
-static int ath11k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
-				      struct ieee80211_hdr *hdr, u8 *data,
-				      size_t data_len, u8 *mic)
-{
-	SHASH_DESC_ON_STACK(desc, tfm);
-	u8 mic_hdr[16] = {};
-	u8 tid = 0;
-	int ret;
-
-	if (!tfm)
-		return -EINVAL;
-
-	desc->tfm = tfm;
-
-	ret = crypto_shash_setkey(tfm, key, 8);
-	if (ret)
-		goto out;
-
-	ret = crypto_shash_init(desc);
-	if (ret)
-		goto out;
-
-	/* TKIP MIC header */
-	memcpy(mic_hdr, ieee80211_get_DA(hdr), ETH_ALEN);
-	memcpy(mic_hdr + ETH_ALEN, ieee80211_get_SA(hdr), ETH_ALEN);
-	if (ieee80211_is_data_qos(hdr->frame_control))
-		tid = ieee80211_get_tid(hdr);
-	mic_hdr[12] = tid;
-
-	ret = crypto_shash_update(desc, mic_hdr, 16);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(desc, data, data_len);
-	if (ret)
-		goto out;
-	ret = crypto_shash_final(desc, mic);
-out:
-	shash_desc_zero(desc);
-	return ret;
-}
-
 static int ath11k_dp_rx_h_verify_tkip_mic(struct ath11k *ar, struct ath11k_peer *peer,
 					  struct sk_buff *msdu)
 {
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
 	struct ieee80211_key_conf *key_conf;
 	struct ieee80211_hdr *hdr;
 	u8 mic[IEEE80211_CCMP_MIC_LEN];
-	int head_len, tail_len, ret;
+	int head_len, tail_len;
 	size_t data_len;
 	u32 hdr_len, hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
 	u8 *key, *data;
 	u8 key_idx;
 
@@ -3292,12 +3246,12 @@ static int ath11k_dp_rx_h_verify_tkip_mic(struct ath11k *ar, struct ath11k_peer
 
 	data = msdu->data + head_len;
 	data_len = msdu->len - head_len - tail_len;
 	key = &key_conf->key[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY];
 
-	ret = ath11k_dp_rx_h_michael_mic(peer->tfm_mmic, key, hdr, data, data_len, mic);
-	if (ret || memcmp(mic, data + data_len, IEEE80211_CCMP_MIC_LEN))
+	michael_mic(key, hdr, data, data_len, mic);
+	if (memcmp(mic, data + data_len, IEEE80211_CCMP_MIC_LEN))
 		goto mic_fail;
 
 	return 0;
 
 mic_fail:
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 3ad2f3355b14f..f5ef1a27f8f25 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -27,11 +27,10 @@ struct ath11k_peer {
 	struct rhash_head rhash_addr;
 
 	/* Info used in MMIC verification of
 	 * RX fragments
 	 */
-	struct crypto_shash *tfm_mmic;
 	u8 mcast_keyidx;
 	u8 ucast_keyidx;
 	u16 sec_type;
 	u16 sec_type_grp;
 	bool is_authorized;
-- 
2.53.0


