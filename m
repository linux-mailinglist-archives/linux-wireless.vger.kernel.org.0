Return-Path: <linux-wireless+bounces-34507-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBPSEPjG1WnA9wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34507-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:09:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8763B67B4
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3809B3012AB0
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 03:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074AF34EEEE;
	Wed,  8 Apr 2026 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW82o2KT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611133F8B7;
	Wed,  8 Apr 2026 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617767; cv=none; b=JSp9pXCS8EOqVpZrHSuGxEgFDJwXRubqSoFJRDiIsRKO5ctvrIW9DpuOVElMv1EUnoDaBacKRdMDrIhIFo9dpjWAePxYMO9qH2HPJABWjSaXKokoi/aqcrFXDtpHCDfKNRF7zEBbhqV6AxHv9Me3HGD+/hH6fZanZ+5eQS0ekE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617767; c=relaxed/simple;
	bh=r1pZY4VFvrZ1/2AdNJCx5jHyxAwHtVzSGed8n5oYQXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRW2xEDx7QkJbedhE1fKSHf0sW50txwIhM50as83ktDf2IpO8sTB0Ef2UmrXHnpCxO/B+77Swgh+BFpsQv5QDQCj/LtOEe6R4QMsfsBWd5yw5nE1WPBbEMVzhjOt7JvY9UB5PxP5LRBj+ME1f9uk4WkDAghQjmj3YqJF4zLxksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW82o2KT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81929C2BCB1;
	Wed,  8 Apr 2026 03:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775617767;
	bh=r1pZY4VFvrZ1/2AdNJCx5jHyxAwHtVzSGed8n5oYQXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fW82o2KTQs1MvGq6wLqrR2EwtVSmAB3fzqyx8887qv0VZkZVG45mr18TjJmKL1DFf
	 jonEKLbroJoI7U9jIyG4dYOiy2/LoJLvOKpgvdtm29XJZb1sIbHUCDjDT7wEFYYwt4
	 YyW7pc1gcqjh7tZmgilRy9LOQn0OEBB9hqg7oNH5GkeIX+EMgqaCPhqpR1UNiCOd2u
	 MnZbSSo1Ff21JIU4qffehjzYN84gGDKehQ4a4GSbkCTr2Q8T7cdWX0wJ1J8+z0euk3
	 ZTZ3HXMM+Z+a6apHlNqK3P/WEqq7DGIG5MlHPA6ECrHag8ZX+2lXiVDzzZbOs2PYjw
	 gS6BHIqVv/ZaQ==
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH wireless-next v2 4/6] wifi: ath12k: Use michael_mic() from cfg80211
Date: Tue,  7 Apr 2026 20:06:49 -0700
Message-ID: <20260408030651.80336-5-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34507-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3E8763B67B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just use the michael_mic() function from cfg80211 instead of a local
implementation of it using the crypto_shash API.

Note: when the kernel is booted with fips=1,
crypto_alloc_shash("michael_mic", 0, 0) always returned
ERR_PTR(-ENOENT), because Michael MIC is not a "FIPS allowed" algorithm.
For now, just preserve that behavior exactly, to ensure that TKIP is not
allowed to be used in FIPS mode.  This logic actually seems to disable
the entire driver in FIPS mode and not just TKIP, but that was the
existing behavior.  Supporting this driver in FIPS mode, if anyone
actually needs it there, should be a separate commit.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/net/wireless/ath/ath12k/Kconfig       |  1 -
 drivers/net/wireless/ath/ath12k/dp.c          |  2 -
 drivers/net/wireless/ath/ath12k/dp_peer.h     |  1 -
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 55 ++-----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  4 --
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  7 +--
 6 files changed, 8 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index 1ea1af1b8f6c5..d39c075758bda 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -1,10 +1,9 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 config ATH12K
 	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
 	depends on MAC80211 && HAS_DMA && PCI
-	select CRYPTO_MICHAEL_MIC
 	select QCOM_QMI_HELPERS
 	select MHI_BUS
 	select QRTR
 	select QRTR_MHI
 	select PCI_PWRCTRL_PWRSEQ if HAVE_PWRCTRL
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 1c82d927d27b2..90802ed1aa59f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -2,11 +2,10 @@
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include <crypto/hash.h>
 #include "core.h"
 #include "dp_tx.h"
 #include "hif.h"
 #include "hal.h"
 #include "debug.h"
@@ -39,11 +38,10 @@ void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 		spin_unlock_bh(&dp->dp_lock);
 		return;
 	}
 
 	ath12k_dp_rx_peer_tid_cleanup(ar, peer);
-	crypto_free_shash(peer->dp_peer->tfm_mmic);
 	peer->dp_peer->dp_setup_done = false;
 	spin_unlock_bh(&dp->dp_lock);
 }
 
 int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index 20294ff095131..113b8040010fa 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -137,11 +137,10 @@ struct ath12k_dp_peer {
 
 	u16 sec_type_grp;
 	u16 sec_type;
 
 	/* Info used in MMIC verification of * RX fragments */
-	struct crypto_shash *tfm_mmic;
 	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
 	struct ath12k_dp_link_peer __rcu *link_peers[ATH12K_NUM_MAX_LINKS];
 	struct ath12k_reoq_buf reoq_bufs[IEEE80211_NUM_TIDS + 1];
 	struct ath12k_dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
 };
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 59088ab407d05..250459facff36 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2,14 +2,14 @@
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/fips.h>
 #include <linux/ieee80211.h>
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
-#include <crypto/hash.h>
 #include "core.h"
 #include "debug.h"
 #include "hw.h"
 #include "dp_rx.h"
 #include "dp_tx.h"
@@ -1431,92 +1431,47 @@ static void ath12k_dp_rx_frag_timer(struct timer_list *timer)
 }
 
 int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id)
 {
 	struct ath12k_base *ab = ar->ab;
-	struct crypto_shash *tfm;
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
 	int i;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
-	tfm = crypto_alloc_shash("michael_mic", 0, 0);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
+	if (fips_enabled) {
+		ath12k_warn(ab, "This driver is disabled due to FIPS\n");
+		return -ENOENT;
+	}
 
 	spin_lock_bh(&dp->dp_lock);
 
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, peer_mac);
 	if (!peer || !peer->dp_peer) {
 		spin_unlock_bh(&dp->dp_lock);
-		crypto_free_shash(tfm);
 		ath12k_warn(ab, "failed to find the peer to set up fragment info\n");
 		return -ENOENT;
 	}
 
 	if (!peer->primary_link) {
 		spin_unlock_bh(&dp->dp_lock);
-		crypto_free_shash(tfm);
 		return 0;
 	}
 
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
 		rx_tid = &peer->dp_peer->rx_tid[i];
 		rx_tid->dp = dp;
 		timer_setup(&rx_tid->frag_timer, ath12k_dp_rx_frag_timer, 0);
 		skb_queue_head_init(&rx_tid->rx_frags);
 	}
 
-	peer->dp_peer->tfm_mmic = tfm;
 	peer->dp_peer->dp_setup_done = true;
 	spin_unlock_bh(&dp->dp_lock);
 
 	return 0;
 }
 
-int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
-			       struct ieee80211_hdr *hdr, u8 *data,
-			       size_t data_len, u8 *mic)
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
-EXPORT_SYMBOL(ath12k_dp_rx_h_michael_mic);
-
 void ath12k_dp_rx_h_undecap_frag(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 				 enum hal_encrypt_type enctype, u32 flags)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ieee80211_hdr *hdr;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index bd62af0c80d46..55a31e669b3b0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -4,11 +4,10 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef ATH12K_DP_RX_H
 #define ATH12K_DP_RX_H
 
-#include <crypto/hash.h>
 #include "core.h"
 #include "debug.h"
 
 #define DP_MAX_NWIFI_HDR_LEN	30
 
@@ -202,13 +201,10 @@ u64 ath12k_dp_rx_h_get_pn(struct ath12k_dp *dp, struct sk_buff *skb);
 void ath12k_dp_rx_h_sort_frags(struct ath12k_hal *hal,
 			       struct sk_buff_head *frag_list,
 			       struct sk_buff *cur_frag);
 void ath12k_dp_rx_h_undecap_frag(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 				 enum hal_encrypt_type enctype, u32 flags);
-int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
-			       struct ieee80211_hdr *hdr, u8 *data,
-			       size_t data_len, u8 *mic);
 int ath12k_dp_rx_ampdu_start(struct ath12k *ar,
 			     struct ieee80211_ampdu_params *params,
 			     u8 link_id);
 int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 			    struct ieee80211_ampdu_params *params,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index e6a934d74e85d..945680b3ebdfc 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -981,11 +981,11 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
 	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
 	struct ieee80211_key_conf *key_conf;
 	struct ieee80211_hdr *hdr;
 	u8 mic[IEEE80211_CCMP_MIC_LEN];
-	int head_len, tail_len, ret;
+	int head_len, tail_len;
 	size_t data_len;
 	u32 hdr_len, hal_rx_desc_sz = hal->hal_desc_sz;
 	u8 *key, *data;
 	u8 key_idx;
 
@@ -1009,13 +1009,12 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 
 	data = msdu->data + head_len;
 	data_len = msdu->len - head_len - tail_len;
 	key = &key_conf->key[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY];
 
-	ret = ath12k_dp_rx_h_michael_mic(peer->tfm_mmic, key, hdr, data,
-					 data_len, mic);
-	if (ret || memcmp(mic, data + data_len, IEEE80211_CCMP_MIC_LEN))
+	michael_mic(key, hdr, data, data_len, mic);
+	if (memcmp(mic, data + data_len, IEEE80211_CCMP_MIC_LEN))
 		goto mic_fail;
 
 	return 0;
 
 mic_fail:
-- 
2.53.0


