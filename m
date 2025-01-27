Return-Path: <linux-wireless+bounces-18029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6414A1DA8A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432FB3A84B3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48227158DC5;
	Mon, 27 Jan 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="NkmSar4E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C891581E0
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995310; cv=none; b=rW/7HNuoACWZDVLUqLdbiapL1eqYBuEYEZW+YQ2dwoycdcJDpP1UbyIpicMgOZvCyP8bpGyP610jaEG+bMN0qDc2lXWs6W23lcCsltn4VNjsHv8SaglcQL/lBHJoQfElInLEWHWaqb+uHtWY/xs6IdAisPWBHe1sUu1pQZGpcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995310; c=relaxed/simple;
	bh=jyWRkI7gZpVh6dEPjf/9l49zMY2tOn8tJIhC8fjqiMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTkiZcvWohKe3mKuxyAdUenyDzG/4gTIduI20ViNF1ckYTFwH4sNYtlsJU0FEEi9T0JvQO58f1F0WzpJO3FUf18SsAG9IaKyiyf1amvjh6iz0hNK0qt0BXUfJNlQaF1vkuTyeS2OEeHAFucss7QeQa+JBqsXQjRXsPeEAiRs0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=NkmSar4E; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1737995297;
	bh=jyWRkI7gZpVh6dEPjf/9l49zMY2tOn8tJIhC8fjqiMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NkmSar4EerbznuKd6+pNvanfF5zSQQK3ksmo7e4uLZPw80YsJlUe9YbKONA4aKNoj
	 7Dba6KkVKtclIYtFHnSVAeFtQ/SyESWKxphc9zmgqLIg15CTjvRQpuujnXsxtUp+dD
	 gZs1z1VkFM04IMN1NvNikPzwelGLkrg4Ax4GYPSM=
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Alexander Wetzel <alexander@wetzel-home.de>
Subject: [RFC PATCH 06/13] wifi: mac80211: Add new TX queues to replace legacy TX
Date: Mon, 27 Jan 2025 17:26:18 +0100
Message-ID: <20250127162625.20747-7-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127162625.20747-1-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Wetzel <alexander@wetzel-home.de>

Add new mac80211 internal TX queues (TXQs) for cases which can't be
handled with the existing queues:

1) per-vif fallback queue for all non-bufferable frames
2) per-vif "noqueue" helper queue
3) per-sta "noqueue" helper queue for sta

The "noqueue" queues are intended for frames which can't be queued but
still use the queue/dequeue functions to prepare the frames. This is
intended to be used for offchannel, disassoc and null-func PS frames in
another patch. For now these frames continue to use the legacy TX path.

All other frames previously using the legacy TX path are switched over
to the new per-vif fallback queue, including TX on monitor interfaces.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 include/net/mac80211.h        |  34 ++++++--
 net/mac80211/debugfs_netdev.c |  46 ++++++-----
 net/mac80211/driver-ops.h     |  29 +++++--
 net/mac80211/ieee80211_i.h    |  19 +++++
 net/mac80211/iface.c          | 146 ++++++++++++++++++++++------------
 net/mac80211/tx.c             | 115 +++++++++++++-------------
 net/mac80211/util.c           |  64 ++++++++-------
 7 files changed, 282 insertions(+), 171 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c3cd62dc63e0..41d91d69d61f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -97,9 +97,14 @@
  * linking it to ieee80211_handle_wake_tx_queue() or implementing a custom
  * handler.
  *
- * Intermediate queues (struct ieee80211_txq) are kept per-sta per-tid, with
- * another per-sta for non-data/non-mgmt and bufferable management frames, and
- * a single per-vif queue for multicast data frames.
+ * Intermediate queues (struct ieee80211_txq) are kept for:
+ *  - per-sta per-tid
+ *  - per-sta for non-data/non-mgmt and bufferable management frames
+ *  - per-sta "noqueue" helper queue for sta (mac80211 internal only)
+ *  - per-vif queue for broadcast/multicast data frames
+ *  - per-vif fallback queue (mac80211 internal only)
+ *  - per-vif "noqueue" helper queue (mac80211 internal only)
+ * The "mac80211 internal only" queues must be ignored by drivers.
  *
  * The driver is expected to initialize its private per-queue data for stations
  * and interfaces in the .add_interface and .sta_add ops.
@@ -1965,9 +1970,18 @@ enum ieee80211_neg_ttlm_res {
  * enum ieee80211_vif_txq - per-vif intermediate queues (txqi)
  *
  * @IEEE80211_VIF_TXQ_MULTICAST: queue for broadcast/multicast data frames.
+ * @IEEE80211_VIF_TXQ_FALLBACK: last resort queue for frames unable to use any
+ *	other queue.
+ * @IEEE80211_VIF_TXQ_NOQUEUE: "queue" for non-sta frames which must be
+ *	send out immediately, like  offchannel, null-func and disassoc frames.
+ *	(Queued frames will be transmitted by the queueing process and not wait
+ *	for a queue run like normal iTXQs.)
+ *
  */
 enum ieee80211_vif_txq {
 	IEEE80211_VIF_TXQ_MULTICAST,
+	IEEE80211_VIF_TXQ_FALLBACK,
+	IEEE80211_VIF_TXQ_NOQUEUE,
 	IEEE80211_VIF_TXQ_NUM,
 };
 
@@ -2457,6 +2471,12 @@ struct ieee80211_link_sta {
 	struct ieee80211_sta_txpwr txpwr;
 };
 
+/* To identify the NOQUEUE iTXQs vif->txq[IEEE80211_VIF_TXQ_NOQUEUE] and
+ * sta->txq[IEEE80211_TXQ_NOQUEUE] we set the tid for these queues to
+ * IEEE80211_TXQ_NOQUEUE (IEEE80211_NUM_TIDS + 1)
+ */
+#define IEEE80211_TXQ_NOQUEUE	(IEEE80211_NUM_TIDS + 1)
+
 /**
  * struct ieee80211_sta - station table entry
  *
@@ -2495,8 +2515,10 @@ struct ieee80211_link_sta {
  *	For non MLO STA it will point to the deflink data. For MLO STA
  *	ieee80211_sta_recalc_aggregates() must be called to update it.
  * @support_p2p_ps: indicates whether the STA supports P2P PS mechanism or not.
- * @txq: per-TID data TX queues; note that the last entry (%IEEE80211_NUM_TIDS)
- *	is used for non-data frames
+ * @txq: per-TID data TX queues; note that the last two queues are not for TIDs:
+ *	%IEEE80211_NUM_TIDS is used for non-data frames and
+ *	%IEEE80211_TXQ_NOQUEUE is for frames which can't wait in any of the
+ *	other queues and must be send out immediately.
  * @deflink: This holds the default link STA information, for non MLO STA all link
  *	specific STA information is accessed through @deflink or through
  *	link[0] which points to address of @deflink. For MLO Link STA
@@ -2530,7 +2552,7 @@ struct ieee80211_sta {
 
 	bool support_p2p_ps;
 
-	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
+	struct ieee80211_txq *txq[IEEE80211_TXQ_NOQUEUE + 1];
 
 	u16 valid_links;
 	struct ieee80211_link_sta deflink;
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index e3541e29b879..c86fcb179582 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -619,28 +619,38 @@ static ssize_t ieee80211_if_fmt_aqm(
 	struct txq_info *txqi;
 	int len;
 
-	if (!sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST])
-		return 0;
-
-	txqi = to_txq_info(sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST]);
+	len = scnprintf(buf,
+			buflen,
+			"id ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets flags\n");
 
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
-	len = scnprintf(buf,
-			buflen,
-			"ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets\n"
-			"%u %u %u %u %u %u %u %u %u %u\n",
-			txqi->txq.ac,
-			txqi->tin.backlog_bytes,
-			txqi->tin.backlog_packets,
-			txqi->tin.flows,
-			txqi->cstats.drop_count,
-			txqi->cstats.ecn_mark,
-			txqi->tin.overlimit,
-			txqi->tin.collisions,
-			txqi->tin.tx_bytes,
-			txqi->tin.tx_packets);
+	for (int i = 0; i < IEEE80211_VIF_TXQ_NUM; i++) {
+		if (!sdata->vif.txq[i])
+			break;
+
+		txqi = to_txq_info(sdata->vif.txq[i]);
+		len += scnprintf(buf + len,
+				 buflen - len,
+				 "%u %u %u %u %u %u %u %u %u %u %u 0x%lx(%s%s%s%s)\n",
+				 txqi->txq.tid,
+				 txqi->txq.ac,
+				 txqi->tin.backlog_bytes,
+				 txqi->tin.backlog_packets,
+				 txqi->tin.flows,
+				 txqi->cstats.drop_count,
+				 txqi->cstats.ecn_mark,
+				 txqi->tin.overlimit,
+				 txqi->tin.collisions,
+				 txqi->tin.tx_bytes,
+				 txqi->tin.tx_packets,
+				 txqi->flags,
+				 test_bit(IEEE80211_TXQ_STOP, &txqi->flags) ? "STOP" : "RUN",
+				 test_bit(IEEE80211_TXQ_AMPDU, &txqi->flags) ? " AMPDU" : "",
+				 test_bit(IEEE80211_TXQ_NO_AMSDU, &txqi->flags) ? " NO-AMSDU" : "",
+				 test_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ? " DIRTY" : "");
+	}
 
 	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index bf3393340fb9..3a7980b5a00a 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1356,18 +1356,31 @@ static inline void drv_wake_tx_queue(struct ieee80211_local *local,
 		return;
 	}
 
-	if (!check_sdata_in_driver(sdata))
+	if (unlikely(sdata->vif.type == NL80211_IFTYPE_MONITOR)) {
+		if (local->monitor_sdata) {
+			sdata = local->monitor_sdata;
+			if (!check_sdata_in_driver(sdata))
+				return;
+		}
+	} else if (!check_sdata_in_driver(sdata)) {
 		return;
+	}
 
 	trace_drv_wake_tx_queue(local, sdata, txq);
 
-	/* Driver support for MPDU txqi support is optional */
-	if (unlikely(txq->txq.tid == IEEE80211_NUM_TIDS &&
-		     ((sdata->vif.type == NL80211_IFTYPE_STATION &&
-		       !ieee80211_hw_check(&sdata->local->hw, STA_MMPDU_TXQ)) ||
-		      (sdata->vif.type != NL80211_IFTYPE_STATION &&
-		       !ieee80211_hw_check(&sdata->local->hw,
-					   BUFF_MMPDU_TXQ))))) {
+	/*
+	 * Driver support for MPDU txqi support is optional.
+	 * IEEE80211_TXQ_NOQUEUE's txqi's are mac80211 internal and not
+	 * intended to be handled by the drivers.
+	 */
+	if (unlikely(WARN_ON(txq->txq.tid == IEEE80211_TXQ_NOQUEUE) ||
+		     (txq->txq.tid == IEEE80211_NUM_TIDS &&
+		      (!txq->txq.sta ||
+		       (sdata->vif.type == NL80211_IFTYPE_STATION &&
+			!ieee80211_hw_check(&sdata->local->hw, STA_MMPDU_TXQ)) ||
+		       (sdata->vif.type != NL80211_IFTYPE_STATION &&
+			!ieee80211_hw_check(&sdata->local->hw,
+					    BUFF_MMPDU_TXQ)))))) {
 		ieee80211_handle_wake_tx_queue(&local->hw, &txq->txq);
 		return;
 	}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8aceec18ffaf..25fdc8ce8644 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1623,6 +1623,25 @@ IEEE80211_WDEV_TO_SUB_IF(struct wireless_dev *wdev)
 	return container_of(wdev, struct ieee80211_sub_if_data, wdev);
 }
 
+static inline struct ieee80211_sub_if_data *
+ieee80211_get_tx_sdata(struct ieee80211_sub_if_data *sdata)
+{
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		sdata = container_of(sdata->bss,
+				     struct ieee80211_sub_if_data, u.ap);
+	/*
+	 * local->monitor_sdata can only be set without
+	 * %IEEE80211_HW_NO_VIRTUAL_MONITOR, no need to check it here.
+	 */
+	else if (unlikely(sdata->vif.type == NL80211_IFTYPE_MONITOR) &&
+		 sdata->local->monitor_sdata &&
+		 !(sdata->u.mntr.flags & (MONITOR_FLAG_ACTIVE |
+					  MONITOR_FLAG_COOK_FRAMES)))
+		sdata = rcu_dereference(sdata->local->monitor_sdata);
+
+	return sdata;
+}
+
 static inline struct ieee80211_supported_band *
 ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
 {
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6b29bcc40a88..9b2d0b3ae132 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1124,11 +1124,63 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 	 * MLD connection, we get a separate allocation for it.
 	 */
 	ieee80211_link_init(sdata, -1, &sdata->deflink, &sdata->vif.bss_conf);
+
+	for (int i = 0; i < NUM_NL80211_BANDS; i++) {
+		struct ieee80211_supported_band *sband;
+
+		sband = local->hw.wiphy->bands[i];
+		sdata->rc_rateidx_mask[i] =
+			sband ? (1 << sband->n_bitrates) - 1 : 0;
+		if (sband) {
+			__le16 cap;
+			u16 *vht_rate_mask;
+
+			memcpy(sdata->rc_rateidx_mcs_mask[i],
+			       sband->ht_cap.mcs.rx_mask,
+			       sizeof(sdata->rc_rateidx_mcs_mask[i]));
+
+			cap = sband->vht_cap.vht_mcs.rx_mcs_map;
+			vht_rate_mask = sdata->rc_rateidx_vht_mcs_mask[i];
+			ieee80211_get_vht_mask_from_cap(cap, vht_rate_mask);
+		} else {
+			memset(sdata->rc_rateidx_mcs_mask[i], 0,
+			       sizeof(sdata->rc_rateidx_mcs_mask[i]));
+			memset(sdata->rc_rateidx_vht_mcs_mask[i], 0,
+			       sizeof(sdata->rc_rateidx_vht_mcs_mask[i]));
+		}
+	}
+}
+
+static void ieee80211_vif_txq_init(struct ieee80211_sub_if_data *sdata,
+				   int txq_offset, int txq_size, int num_queues)
+{
+	void *buffer = (char *)sdata + txq_offset;
+
+	/* Fallback queue */
+	ieee80211_txq_init(sdata, NULL, buffer, IEEE80211_NUM_TIDS);
+
+	if (num_queues == 1)
+		return;
+
+	/* Immediate TX helper queue */
+	buffer += txq_size;
+	ieee80211_txq_init(sdata, NULL, buffer, IEEE80211_TXQ_NOQUEUE);
+
+	if (num_queues == 2)
+		return;
+
+	/* Multicast queue */
+	buffer += txq_size;
+	ieee80211_txq_init(sdata, NULL, buffer, 0);
 }
 
 int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
+	int size = ALIGN(sizeof(*sdata) + local->hw.vif_data_size,
+			 sizeof(void *));
+	int txq_size = ALIGN(sizeof(struct txq_info) + local->hw.txq_data_size,
+			     sizeof(void *));
 	int ret;
 
 	ASSERT_RTNL();
@@ -1138,7 +1190,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	    WARN_ON(ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)))
 		return 0;
 
-	sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size, GFP_KERNEL);
+	sdata = kzalloc(size + txq_size, GFP_KERNEL);
 	if (!sdata)
 		return -ENOMEM;
 
@@ -1150,7 +1202,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	sdata->wdev.wiphy = local->hw.wiphy;
 
 	ieee80211_sdata_init(local, sdata);
-
+	ieee80211_vif_txq_init(sdata, size, txq_size, 1);
 	ieee80211_set_default_queues(sdata);
 
 	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
@@ -2077,8 +2129,12 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 {
 	struct net_device *ndev = NULL;
 	struct ieee80211_sub_if_data *sdata = NULL;
-	struct txq_info *txqi;
-	int ret, i;
+	int size = ALIGN(sizeof(*sdata) + local->hw.vif_data_size,
+			 sizeof(void *));
+	int txq_size = ALIGN(sizeof(struct txq_info) + local->hw.txq_data_size,
+			     sizeof(void *));
+	int num_txqs = 2;
+	int ret;
 
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2086,8 +2142,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	if (type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN) {
 		struct wireless_dev *wdev;
 
-		sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size,
-				GFP_KERNEL);
+		sdata = kzalloc(size + 2 * txq_size, GFP_KERNEL);
 		if (!sdata)
 			return -ENOMEM;
 		wdev = &sdata->wdev;
@@ -2098,17 +2153,14 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 		memcpy(sdata->vif.addr, wdev->address, ETH_ALEN);
 		ether_addr_copy(sdata->vif.bss_conf.addr, sdata->vif.addr);
 	} else {
-		int size = ALIGN(sizeof(*sdata) + local->hw.vif_data_size,
-				 sizeof(void *));
-		int txq_size = 0;
-
-		if (type != NL80211_IFTYPE_AP_VLAN &&
-		    (type != NL80211_IFTYPE_MONITOR ||
-		     (params->flags & MONITOR_FLAG_ACTIVE)))
-			txq_size += sizeof(struct txq_info) +
-				    local->hw.txq_data_size;
+		if (type == NL80211_IFTYPE_AP_VLAN)
+			num_txqs = 0;
+		else if (type == NL80211_IFTYPE_MONITOR)
+			num_txqs = 1;
+		else
+			num_txqs = 3;
 
-		ndev = alloc_netdev_mqs(size + txq_size,
+		ndev = alloc_netdev_mqs(size + num_txqs * txq_size,
 					name, name_assign_type,
 					ieee80211_if_setup, 1, 1);
 		if (!ndev)
@@ -2147,14 +2199,12 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 		ether_addr_copy(sdata->vif.bss_conf.addr, sdata->vif.addr);
 		memcpy(sdata->name, ndev->name, IFNAMSIZ);
 
-		if (txq_size) {
-			txqi = netdev_priv(ndev) + size;
-			ieee80211_txq_init(sdata, NULL, txqi, 0);
-		}
-
 		sdata->dev = ndev;
 	}
 
+	if (num_txqs)
+		ieee80211_vif_txq_init(sdata, size, txq_size, num_txqs);
+
 	/* initialise type-independent data */
 	sdata->wdev.wiphy = local->hw.wiphy;
 
@@ -2167,30 +2217,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	wiphy_delayed_work_init(&sdata->dec_tailroom_needed_wk,
 				ieee80211_delayed_tailroom_dec);
 
-	for (i = 0; i < NUM_NL80211_BANDS; i++) {
-		struct ieee80211_supported_band *sband;
-		sband = local->hw.wiphy->bands[i];
-		sdata->rc_rateidx_mask[i] =
-			sband ? (1 << sband->n_bitrates) - 1 : 0;
-		if (sband) {
-			__le16 cap;
-			u16 *vht_rate_mask;
-
-			memcpy(sdata->rc_rateidx_mcs_mask[i],
-			       sband->ht_cap.mcs.rx_mask,
-			       sizeof(sdata->rc_rateidx_mcs_mask[i]));
-
-			cap = sband->vht_cap.vht_mcs.rx_mcs_map;
-			vht_rate_mask = sdata->rc_rateidx_vht_mcs_mask[i];
-			ieee80211_get_vht_mask_from_cap(cap, vht_rate_mask);
-		} else {
-			memset(sdata->rc_rateidx_mcs_mask[i], 0,
-			       sizeof(sdata->rc_rateidx_mcs_mask[i]));
-			memset(sdata->rc_rateidx_vht_mcs_mask[i], 0,
-			       sizeof(sdata->rc_rateidx_vht_mcs_mask[i]));
-		}
-	}
-
 	ieee80211_set_default_queues(sdata);
 
 	/* setup type-dependent data */
@@ -2237,10 +2263,29 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	return 0;
 }
 
-void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
+static void ieee80211_purge_txqs(struct ieee80211_sub_if_data *sdata)
 {
-	struct ieee80211_txq *txq = sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST];
+	struct sta_info *sta;
 
+	list_for_each_entry(sta, &sdata->local->sta_list, list) {
+		if (sdata != sta->sdata)
+			continue;
+		ieee80211_purge_sta_txqs(sta);
+	}
+
+	for (int i = IEEE80211_VIF_TXQ_MULTICAST;
+	     i <= IEEE80211_VIF_TXQ_FALLBACK;
+	     i++) {
+		if (sdata->vif.txq[i])
+			ieee80211_txq_purge(sdata->local,
+					    to_txq_info(sdata->vif.txq[i]));
+	}
+
+	synchronize_rcu();
+}
+
+void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
+{
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -2248,10 +2293,7 @@ void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
-	if (txq)
-		ieee80211_txq_purge(sdata->local, to_txq_info(txq));
-
-	synchronize_rcu();
+	ieee80211_purge_txqs(sdata);
 
 	cfg80211_unregister_wdev(&sdata->wdev);
 
@@ -2300,6 +2342,8 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 	list_for_each_entry_safe(sdata, tmp, &unreg_list, list) {
 		bool netdev = sdata->dev;
 
+		ieee80211_purge_txqs(sdata);
+
 		/*
 		 * Remove IP addresses explicitly, since the notifier will
 		 * skip the callbacks if wdev->registered is false, since
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 581b3d97e278..c59cebc66ac6 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1300,31 +1300,37 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_txq *txq = NULL;
 
-	if ((info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM) ||
-	    (info->control.flags & IEEE80211_TX_CTRL_PS_RESPONSE))
+	if (unlikely(info->flags & IEEE80211_TX_INTFL_OFFCHAN_TX_OK))
+		/* Offchannel queue can't be used, yet */
 		return NULL;
 
-	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
-	    unlikely(!ieee80211_is_data_present(hdr->frame_control))) {
+	if (unlikely(vif->type == NL80211_IFTYPE_MONITOR ||
+		     info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM ||
+		     info->control.flags & IEEE80211_TX_CTRL_PS_RESPONSE))
+		goto out;
+
+	if (unlikely(!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
+		     !ieee80211_is_data_present(hdr->frame_control))) {
 		if ((!ieee80211_is_mgmt(hdr->frame_control) ||
 		     ieee80211_is_bufferable_mmpdu(skb) ||
 		     vif->type == NL80211_IFTYPE_STATION) &&
 		    sta && sta->uploaded) {
 			txq = sta->sta.txq[IEEE80211_NUM_TIDS];
 		}
-	} else if (sta) {
+	} else if (likely(sta)) {
 		u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 
-		if (!sta->uploaded)
-			return NULL;
+		if (unlikely(!sta->uploaded))
+			goto out;
 
 		txq = sta->sta.txq[tid];
 	} else {
 		txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	}
 
+out:
 	if (!txq)
-		return NULL;
+		txq = vif->txq[IEEE80211_VIF_TXQ_FALLBACK];
 
 	return to_txq_info(txq);
 }
@@ -1446,12 +1452,13 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 
 	spin_lock_bh(&fq->lock);
 	/*
-	 * For management frames, don't really apply codel etc.,
+	 * For management frames (tid set to IEEE80211_NUM_TIDS
+	 * or IEEE80211_TXQ_NOQUEUE), don't really apply codel etc.,
 	 * we don't want to apply any shaping or anything we just
-	 * want to simplify the driver API by having them on the
-	 * txqi.
+	 * want to simplify the driver API and mac80211 internal
+	 * handling by having them on the txqi.
 	 */
-	if (unlikely(txqi->txq.tid == IEEE80211_NUM_TIDS)) {
+	if (unlikely(txqi->txq.tid >= IEEE80211_NUM_TIDS)) {
 		IEEE80211_SKB_CB(skb)->control.flags |=
 			IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 		__skb_queue_tail(&txqi->frags, skb);
@@ -1509,14 +1516,26 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 	txqi->txq.vif = &sdata->vif;
 
 	if (!sta) {
-		sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST] = &txqi->txq;
-		txqi->txq.tid = 0;
-		txqi->txq.ac = IEEE80211_AC_BE;
+		if (tid == IEEE80211_TXQ_NOQUEUE) {
+			sdata->vif.txq[IEEE80211_VIF_TXQ_NOQUEUE] =
+				&txqi->txq;
+			txqi->txq.ac = IEEE80211_AC_VO;
+		} else if (tid == IEEE80211_NUM_TIDS) {
+			sdata->vif.txq[IEEE80211_VIF_TXQ_FALLBACK] =
+				&txqi->txq;
+			txqi->txq.ac = IEEE80211_AC_VO;
+		} else {
+			sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST] =
+				&txqi->txq;
+			txqi->txq.ac = IEEE80211_AC_BE;
+		}
 
+		txqi->txq.tid = tid;
 		return;
 	}
 
-	if (tid == IEEE80211_NUM_TIDS)
+	/* for %IEEE80211_NUM_TIDS and %IEEE80211_TXQ_NOQUEUE*/
+	if (tid >= IEEE80211_NUM_TIDS)
 		txqi->txq.ac = IEEE80211_AC_VO;
 	else
 		txqi->txq.ac = ieee80211_ac_from_tid(tid);
@@ -1628,16 +1647,13 @@ static bool ieee80211_queue_skb(struct ieee80211_local *local,
 				struct sta_info *sta,
 				struct sk_buff *skb)
 {
-	struct ieee80211_vif *vif;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = &sdata->vif;
 	struct txq_info *txqi;
 
-	if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
-		return false;
-
-	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
-		sdata = container_of(sdata->bss,
-				     struct ieee80211_sub_if_data, u.ap);
+	info->control.vif = vif;
 
+	sdata = ieee80211_get_tx_sdata(sdata);
 	vif = &sdata->vif;
 	txqi = ieee80211_get_txq(local, vif, sta, skb);
 
@@ -1645,7 +1661,6 @@ static bool ieee80211_queue_skb(struct ieee80211_local *local,
 		return false;
 
 	ieee80211_txq_enqueue(local, txqi, skb);
-
 	schedule_and_wake_txq(local, txqi);
 
 	return true;
@@ -3794,7 +3809,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct txq_info *txqi = container_of(txq, struct txq_info, txq);
 	struct ieee80211_hdr *hdr;
-	struct sk_buff *skb = NULL;
+	struct sk_buff *skb;
 	struct fq *fq = &local->fq;
 	struct fq_tin *tin = &txqi->tin;
 	struct ieee80211_tx_info *info;
@@ -3803,7 +3818,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	struct ieee80211_vif *vif = txq->vif;
 	int q = vif->hw_queue[txq->ac];
 	unsigned long flags;
-	bool q_stopped;
+	int qsr;
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
@@ -3812,10 +3827,21 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 
 begin:
 	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-	q_stopped = local->queue_stop_reasons[q];
+	qsr = local->queue_stop_reasons[q];
 	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
-	if (unlikely(q_stopped)) {
+	if (unlikely(qsr &&
+		     (txq->tid != IEEE80211_TXQ_NOQUEUE ||
+		      (qsr & ~BIT(IEEE80211_QUEUE_STOP_REASON_OFFCHANNEL))))) {
+		/* Drop off-channel frames if queues are stopped for any reason
+		 * other than off-channel operation. Never queue them.
+		 */
+		if (unlikely(txq->tid == IEEE80211_TXQ_NOQUEUE)) {
+			WARN(1, "mac80211: Drop noqueue TX. qsr=%i\n", qsr);
+			ieee80211_txq_purge(local, txqi);
+			return NULL;
+		}
+
 		/* mark for waking later */
 		set_bit(IEEE80211_TXQ_DIRTY, &txqi->flags);
 		return NULL;
@@ -3936,36 +3962,6 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 		}
 	}
 
-	switch (tx.sdata->vif.type) {
-	case NL80211_IFTYPE_MONITOR:
-		if ((tx.sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) ||
-		    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
-			vif = &tx.sdata->vif;
-			break;
-		}
-		tx.sdata = rcu_dereference(local->monitor_sdata);
-		if (tx.sdata &&
-		    ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
-			vif = &tx.sdata->vif;
-			info->hw_queue =
-				vif->hw_queue[skb_get_queue_mapping(skb)];
-		} else if (ieee80211_hw_check(&local->hw, QUEUE_CONTROL)) {
-			ieee80211_free_txskb(&local->hw, skb);
-			goto begin;
-		} else {
-			info->control.vif = NULL;
-			return skb;
-		}
-		break;
-	case NL80211_IFTYPE_AP_VLAN:
-		tx.sdata = container_of(tx.sdata->bss,
-					struct ieee80211_sub_if_data, u.ap);
-		fallthrough;
-	default:
-		vif = &tx.sdata->vif;
-		break;
-	}
-
 encap_out:
 	info->control.vif = vif;
 
@@ -4143,7 +4139,7 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 	if (!txq->sta)
 		return true;
 
-	if (unlikely(txq->tid == IEEE80211_NUM_TIDS))
+	if (unlikely(txq->tid >= IEEE80211_NUM_TIDS))
 		return true;
 
 	sta = container_of(txq->sta, struct sta_info, sta);
@@ -4636,7 +4632,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_sub_if_data, u.ap);
 
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
-	info->control.vif = &sdata->vif;
 
 	if (key)
 		info->control.hw_key = &key->conf;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b65e08de0a00..c5b4dfab09e5 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -320,65 +320,73 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_handle_wake_tx_queue);
 
+static void __ieee80211_wake_txq(struct ieee80211_local *local,
+				 struct ieee80211_txq *txq)
+{
+	struct txq_info *txqi = to_txq_info(txq);
+	struct fq *fq = &local->fq;
+
+	if (WARN_ON(!txq))
+		return;
+	if (test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags)) {
+		spin_unlock(&fq->lock);
+		drv_wake_tx_queue(local, txqi);
+		spin_lock(&fq->lock);
+	}
+}
+
 static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_vif *vif = &sdata->vif;
 	struct fq *fq = &local->fq;
+	struct ieee80211_vif *vif;
 	struct ps_data *ps = NULL;
-	struct txq_info *txqi;
 	struct sta_info *sta;
 	int i;
 
 	local_bh_disable();
 	spin_lock(&fq->lock);
 
+	if (WARN_ON(!sdata))
+		goto out;
 	if (!test_bit(SDATA_STATE_RUNNING, &sdata->state))
 		goto out;
 
+	sdata = ieee80211_get_tx_sdata(sdata);
+	vif = &sdata->vif;
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
 		ps = &sdata->bss->ps;
 
+	/* %IEEE80211_VIF_TXQ_NOQUEUE must be ignored here */
+
+	if (ac == IEEE80211_AC_VO) {
+		__ieee80211_wake_txq(local,
+				     vif->txq[IEEE80211_VIF_TXQ_FALLBACK]);
+	}
+
+	if (ac == IEEE80211_AC_BE && vif->txq[IEEE80211_VIF_TXQ_MULTICAST] &&
+	    (!ps || !atomic_read(&ps->num_sta_ps)))
+		__ieee80211_wake_txq(local,
+				     vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
+
 	list_for_each_entry_rcu(sta, &local->sta_list, list) {
 		if (sdata != sta->sdata)
 			continue;
 
-		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
+		/* IEEE80211_TXQ_NOQUEUE must be ignored here. */
+		for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
 			struct ieee80211_txq *txq = sta->sta.txq[i];
 
 			if (!txq)
 				continue;
 
-			txqi = to_txq_info(txq);
-
 			if (ac != txq->ac)
 				continue;
 
-			if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY,
-						&txqi->flags))
-				continue;
-
-			spin_unlock(&fq->lock);
-			drv_wake_tx_queue(local, txqi);
-			spin_lock(&fq->lock);
+			__ieee80211_wake_txq(local, txq);
 		}
 	}
-
-	if (!vif->txq[IEEE80211_VIF_TXQ_MULTICAST])
-		goto out;
-
-	txqi = to_txq_info(vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
-
-	if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
-	    (ps && atomic_read(&ps->num_sta_ps)) ||
-	     ac != vif->txq[IEEE80211_VIF_TXQ_MULTICAST]->ac)
-		goto out;
-
-	spin_unlock(&fq->lock);
-
-	drv_wake_tx_queue(local, txqi);
-	local_bh_enable();
-	return;
 out:
 	spin_unlock(&fq->lock);
 	local_bh_enable();
-- 
2.48.1


