Return-Path: <linux-wireless+bounces-29411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D53C92513
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29A5A4EB583
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF7933120D;
	Fri, 28 Nov 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="r6GOkjAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931624DCE5
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339677; cv=none; b=QLhKTK1t+D14uNgxDznVRmyuj6RXteGGlKQI00GM9mbujEIWftCYlxhqcFsRSBesiJPKEAMp4rlbjshOiAgeyB83FMgiaF9mKgnfp3X93ZCLDWQfVJzy4q2Qv9NPSqruKgkydOHgS9+XheBQk7/zGqrSHkhwIiIlIYsI9gSBaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339677; c=relaxed/simple;
	bh=+6lYwG3ZAVTWpjlYJTwxFvxgPOiydo9XrWgaixQ/0DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcBCAQgfTynUQ2tEGwbBf2YAxbnKEvLsAbN4uBVekLIY88wXl27Xt0dhDEF27B9vcpXyOktmLe8cNnL1VJeHIILyd15RqSFKVALxbFeTOzBlHreqfOMECVUq5gCBpocJqfJEw5dN941FgEnJUAB2LN8l+B13sEvWlVlvB4ZnNJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=r6GOkjAC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=P3gIj+zlpr4q8SVIpVQNii2aQXN79SCxXFa8lz3ivjA=;
	t=1764339676; x=1765549276; b=r6GOkjACUpWI323c+rj1r1DttCcayvWyMpaPdzoCwV2rMKi
	fO/19JQMs0tcywwMTEYv+SRHNH9JcFJ0/dxgFD6yF6oPTO2k1nI2LI3Ubh7M13fdG8/tqqY0wlDnB
	HKX2xg7viA2peoQQJgUeNhs9o0k7lIZcKSrh+Pk2LIzRkMIehejW31+hgSoMehew4V+AJBLzOqhzU
	20XgLDoczhaF3uUKC9yxECdV2RXo0pETUAlAitLxONnbi6ESCCY6JuMvp4YAka1M/gVBJG9OGD7Km
	onNFpzoGb7REAvZ6qApscNl3E7EV6AocWHsN6OtsGtwsTui/M1/n7AXoNSEizjnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLU-00000003926-2ilL;
	Fri, 28 Nov 2025 15:21:13 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 11/18] wifi: mac80211: add a TXQ for management frames on NAN devices
Date: Fri, 28 Nov 2025 15:15:49 +0100
Message-ID: <20251128151537.82334ed58b34.Iee95758287c276155fbd7779d3f263339308e083@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128141537.287627-20-benjamin@sipsolutions.net>
References: <20251128141537.287627-20-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Currently there is no TXQ for non-data frames. Add a new txq_mgmt for
this purpose and create one of these on NAN devices. On NAN devices,
these frames may only be transmitted during the discovery window and it
is therefore helpful to schedule them using a queue.

type=feature
ticket=none

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/iface.c   | 28 ++++++++++++++++++++++++++--
 net/mac80211/tx.c      | 16 +++++++++++++---
 net/mac80211/util.c    | 33 +++++++++++++++++++++++++--------
 4 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c2e49542626c..8874e5eeae7d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2034,6 +2034,7 @@ enum ieee80211_neg_ttlm_res {
  * @drv_priv: data area for driver use, will always be aligned to
  *	sizeof(void \*).
  * @txq: the multicast data TX queue
+ * @txq_mgmt: the mgmt frame TX queue, currently only exists for NAN devices
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
  */
@@ -2052,6 +2053,7 @@ struct ieee80211_vif {
 	u8 hw_queue[IEEE80211_NUM_ACS];
 
 	struct ieee80211_txq *txq;
+	struct ieee80211_txq *txq_mgmt;
 
 	netdev_features_t netdev_features;
 	u32 driver_flags;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4f04d95c19d4..764f8acaacd8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -678,6 +678,10 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	if (sdata->vif.txq)
 		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
 
+	if (sdata->vif.txq_mgmt)
+		ieee80211_txq_purge(sdata->local,
+				    to_txq_info(sdata->vif.txq_mgmt));
+
 	sdata->bss = NULL;
 
 	if (local->open_count == 0)
@@ -2200,10 +2204,16 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN) {
+		int size = ALIGN(sizeof(*sdata) + local->hw.vif_data_size,
+				 sizeof(void *));
 		struct wireless_dev *wdev;
+		int txq_size = 0;
+
+		if (type == NL80211_IFTYPE_NAN)
+			txq_size = sizeof(struct txq_info) +
+				   local->hw.txq_data_size;
 
-		sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size,
-				GFP_KERNEL);
+		sdata = kzalloc(size + txq_size, GFP_KERNEL);
 		if (!sdata)
 			return -ENOMEM;
 		wdev = &sdata->wdev;
@@ -2213,6 +2223,16 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 		ieee80211_assign_perm_addr(local, wdev->address, type);
 		memcpy(sdata->vif.addr, wdev->address, ETH_ALEN);
 		ether_addr_copy(sdata->vif.bss_conf.addr, sdata->vif.addr);
+
+		/*
+		 * Add a management TXQ for NAN devices which includes frames
+		 * that will only be transmitted during discovery windows (DWs)
+		 */
+		if (type == NL80211_IFTYPE_NAN) {
+			txqi = (struct txq_info *)((unsigned long)sdata + size);
+			ieee80211_txq_init(sdata, NULL, txqi,
+					   IEEE80211_NUM_TIDS);
+		}
 	} else {
 		int size = ALIGN(sizeof(*sdata) + local->hw.vif_data_size,
 				 sizeof(void *));
@@ -2363,6 +2383,10 @@ void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
 	if (sdata->vif.txq)
 		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
 
+	if (sdata->vif.txq_mgmt)
+		ieee80211_txq_purge(sdata->local,
+				    to_txq_info(sdata->vif.txq_mgmt));
+
 	synchronize_rcu();
 
 	cfg80211_unregister_wdev(&sdata->wdev);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 9d8b0a25f73c..99b4fd51e28c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1321,6 +1321,10 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 			 * opt-in hardware flag.
 			 */
 			txq = sta->sta.txq[IEEE80211_NUM_TIDS];
+		} else if ((!ieee80211_is_mgmt(hdr->frame_control) ||
+			    ieee80211_is_bufferable_mmpdu(skb)) &&
+			   !sta) {
+			txq = vif->txq_mgmt;
 		}
 	} else if (sta) {
 		u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
@@ -1513,9 +1517,15 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 	txqi->txq.vif = &sdata->vif;
 
 	if (!sta) {
-		sdata->vif.txq = &txqi->txq;
-		txqi->txq.tid = 0;
-		txqi->txq.ac = IEEE80211_AC_BE;
+		txqi->txq.tid = tid;
+
+		if (tid == IEEE80211_NUM_TIDS) {
+			sdata->vif.txq_mgmt = &txqi->txq;
+			txqi->txq.ac = IEEE80211_AC_VO;
+		} else {
+			sdata->vif.txq = &txqi->txq;
+			txqi->txq.ac = IEEE80211_AC_BE;
+		}
 
 		return;
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..ef7ea78da736 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -326,7 +326,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 	struct ieee80211_vif *vif = &sdata->vif;
 	struct fq *fq = &local->fq;
 	struct ps_data *ps = NULL;
-	struct txq_info *txqi;
+	struct txq_info *to_wake[2] = {};
 	struct sta_info *sta;
 	int i;
 
@@ -345,6 +345,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 
 		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
 			struct ieee80211_txq *txq = sta->sta.txq[i];
+			struct txq_info *txqi;
 
 			if (!txq)
 				continue;
@@ -364,18 +365,34 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 		}
 	}
 
-	if (!vif->txq)
-		goto out;
+	if (vif->txq) {
+		struct txq_info *txqi;
 
-	txqi = to_txq_info(vif->txq);
+		txqi = to_txq_info(vif->txq);
 
-	if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
-	    (ps && atomic_read(&ps->num_sta_ps)) || ac != vif->txq->ac)
-		goto out;
+		if (test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) &&
+		    !(ps && atomic_read(&ps->num_sta_ps)) &&
+		    ac == vif->txq->ac)
+			to_wake[0] = txqi;
+	}
+
+	if (vif->txq_mgmt) {
+		struct txq_info *txqi;
+
+		txqi = to_txq_info(vif->txq_mgmt);
+
+		if (test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) &&
+		    ac == vif->txq->ac)
+			to_wake[1] = txqi;
+	}
 
 	spin_unlock(&fq->lock);
 
-	drv_wake_tx_queue(local, txqi);
+	if (to_wake[0])
+		drv_wake_tx_queue(local, to_wake[0]);
+	if (to_wake[1])
+		drv_wake_tx_queue(local, to_wake[0]);
+
 	local_bh_enable();
 	return;
 out:
-- 
2.51.1


