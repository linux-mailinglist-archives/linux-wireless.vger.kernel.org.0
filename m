Return-Path: <linux-wireless+bounces-30474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8228CFFBF8
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 20:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 693BB30185EE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 19:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964F73358BD;
	Wed,  7 Jan 2026 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OsTB7o3r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370A33CE9B
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795827; cv=none; b=OBez9nin5VuDSMUFaCJnDfgFK/xokiO2U8+A3tLyesryhkun/+yTp4XWwoVoLIbN0fTCTYc2d8pl4uKoJTwY+kG4+bjmvASuEPA44hZ1ooCLWzOmId7/xW5qv4icJPUQhUfHqT4CN4UeWYqIxkbd/KPzEhGJMyollr9A6cGYYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795827; c=relaxed/simple;
	bh=DAluYp5ZfERN8dkq6dy8yjXs8ojviyAgtyO5LqjV/DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG/zSnjYk2lJL2qq1ZXOCXYSYXA/klkNof4cZMqbjuOZE1Jup2s73EGfg2kUtevQg6QWYMoUzoguguZ7T9+CsdaGgDw3Brw4vYoy/4OobRCLvxYpvtKaqqs5KkRnlbmiGMFkRYZOVEDjYKi1C6VWpRMZypFjzUFOL9cBbdmC4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OsTB7o3r; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Vu6tVXO7BJbqj7XDNoi/YbexwGUcJiq5wAOF5IoCOTo=;
	t=1767795825; x=1769005425; b=OsTB7o3rOdrENFxx2WlCmqewxiVrGChd1kpRZS9uwKD7fJ/
	yGs79ZQCZ4206VAREbbtUdfjg2iNN6dND1BM17VTSe6qACLgTMOjBaS1dB7+4B0KnIsZ5/ntyn24c
	hMbcW/tLF8nL5pAxSI87TLOexPga0ZlcD74XYzFw8jaOhdNh5/8SWWji/cqVp4C2Tn/yeNIgH/NXB
	mFfVha5RHVB/Go1nZ+u9/UIGytfY8rZMpltsrWPm1eTx4GuH2kL2UpjuYaO5iPf99F3hbgoY9J6B7
	HEP1RaAfYdqHfDaLH5yYFXkz5p6HOLhTCrbYMHUSKmuHs9n06Rh7eTCjI3WTBvwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURr-00000005agF-1Ynv;
	Wed, 07 Jan 2026 15:23:43 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 12/46] wifi: mac80211: add a TXQ for management frames on NAN devices
Date: Wed,  7 Jan 2026 15:22:11 +0100
Message-ID: <20260107152325.1d3abeb6d839.Iee95758287c276155fbd7779d3f263339308e083@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
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

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/iface.c   | 28 ++++++++++++++++++++++++++--
 net/mac80211/tx.c      | 20 ++++++++++++++++----
 net/mac80211/util.c    | 34 +++++++++++++++++++++++-----------
 4 files changed, 67 insertions(+), 17 deletions(-)

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
index 88a47272cffc..024fd4b17bdc 100644
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
@@ -2203,10 +2207,16 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN) {
+		int size = ALIGN(sizeof(*sdata) + local->hw.vif_data_size,
+				 sizeof(void *));
 		struct wireless_dev *wdev;
+		int txq_size = 0;
 
-		sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size,
-				GFP_KERNEL);
+		if (type == NL80211_IFTYPE_NAN)
+			txq_size = sizeof(struct txq_info) +
+				   local->hw.txq_data_size;
+
+		sdata = kzalloc(size + txq_size, GFP_KERNEL);
 		if (!sdata)
 			return -ENOMEM;
 		wdev = &sdata->wdev;
@@ -2216,6 +2226,16 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
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
@@ -2366,6 +2386,10 @@ void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
 	if (sdata->vif.txq)
 		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
 
+	if (sdata->vif.txq_mgmt)
+		ieee80211_txq_purge(sdata->local,
+				    to_txq_info(sdata->vif.txq_mgmt));
+
 	synchronize_rcu();
 
 	cfg80211_unregister_wdev(&sdata->wdev);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 9d8b0a25f73c..3382c8f12a5e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1314,13 +1314,19 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	    unlikely(!ieee80211_is_data_present(hdr->frame_control))) {
 		if ((!ieee80211_is_mgmt(hdr->frame_control) ||
 		     ieee80211_is_bufferable_mmpdu(skb) ||
-		     vif->type == NL80211_IFTYPE_STATION) &&
+		     vif->type == NL80211_IFTYPE_STATION ||
+		     vif->type == NL80211_IFTYPE_NAN ||
+		     vif->type == NL80211_IFTYPE_NAN_DATA) &&
 		    sta && sta->uploaded) {
 			/*
 			 * This will be NULL if the driver didn't set the
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
@@ -1513,9 +1519,15 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
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
index 7060269a2f4f..278af3b76268 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -326,7 +326,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 	struct ieee80211_vif *vif = &sdata->vif;
 	struct fq *fq = &local->fq;
 	struct ps_data *ps = NULL;
-	struct txq_info *txqi;
+	struct txq_info *txqi = NULL;
 	struct sta_info *sta;
 	int i;
 
@@ -345,37 +345,49 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 
 		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
 			struct ieee80211_txq *txq = sta->sta.txq[i];
+			struct txq_info *sta_txqi;
 
 			if (!txq)
 				continue;
 
-			txqi = to_txq_info(txq);
+			sta_txqi = to_txq_info(txq);
 
 			if (ac != txq->ac)
 				continue;
 
 			if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY,
-						&txqi->flags))
+						&sta_txqi->flags))
 				continue;
 
 			spin_unlock(&fq->lock);
-			drv_wake_tx_queue(local, txqi);
+			drv_wake_tx_queue(local, sta_txqi);
 			spin_lock(&fq->lock);
 		}
 	}
 
-	if (!vif->txq)
-		goto out;
+	if (vif->txq) {
+		txqi = to_txq_info(vif->txq);
 
-	txqi = to_txq_info(vif->txq);
+		/* txq and txq_mgmt are mutually exclusive */
+		WARN_ON_ONCE(vif->txq_mgmt);
 
-	if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
-	    (ps && atomic_read(&ps->num_sta_ps)) || ac != vif->txq->ac)
-		goto out;
+		if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
+		    (ps && atomic_read(&ps->num_sta_ps)) ||
+		    ac != vif->txq->ac)
+			txqi = NULL;
+	} else if (vif->txq_mgmt) {
+		txqi = to_txq_info(vif->txq_mgmt);
+
+		if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
+		    ac != vif->txq_mgmt->ac)
+			txqi = NULL;
+	}
 
 	spin_unlock(&fq->lock);
 
-	drv_wake_tx_queue(local, txqi);
+	if (txqi)
+		drv_wake_tx_queue(local, txqi);
+
 	local_bh_enable();
 	return;
 out:
-- 
2.52.0


