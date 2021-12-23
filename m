Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7747E067
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 09:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347202AbhLWI2L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 03:28:11 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:22660 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242789AbhLWI2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 03:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640248091; x=1671784091;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=NbnBJxUWzpP2+5jaPoc56EGj/bYmn0MMIrPy3bEMlsY=;
  b=a/TR3fdTtpmhdokOfc4o7m6qFguBL8DwHz+Qib3B+fxA+dHiPUXC/cVR
   vyWAckIfo8SkK4LWbvLKJp9oe5WN6rTNvJS9ZAa61qDQhtRjgMqwnaffM
   PxLVIqpUB2jqB217r8RPmKq4QCieBdg1Q4pBNoM28jJvB8salKHKE6jGo
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Dec 2021 00:28:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 00:28:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 00:28:10 -0800
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 00:28:08 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH] ath11k: Add peer rhash table support
Date:   Thu, 23 Dec 2021 13:57:57 +0530
Message-ID: <1640248077-14075-1-git-send-email-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When more clients (128) are connected, the UL data traffic
KPI measurement is low compared to single client. This issue
is due to more CPU cycles spent on the peer lookup operation
with more clients. So reduce the peer lookup operation by
modifying the linear based lookup operation into the rhash
based lookup operation. This improve the peak throughput
measurement. Since this is a software algorithm change, it is
applicable for all the platforms.

TCP UL 128 Clients test case Observation (64bit system):
Previous: ~550 Mbps
Now	: ~860 Mbps

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |  13 ++
 drivers/net/wireless/ath/ath11k/mac.c  |  10 ++
 drivers/net/wireless/ath/ath11k/peer.c | 304 +++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/peer.h |  10 +-
 4 files changed, 306 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9e88ccc..5a75d94 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_CORE_H
@@ -10,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/bitfield.h>
+#include <linux/rhashtable.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -737,6 +739,17 @@ struct ath11k_base {
 	struct ath11k_pdev __rcu *pdevs_active[MAX_RADIOS];
 	struct ath11k_hal_reg_capabilities_ext hal_reg_cap[MAX_RADIOS];
 	unsigned long long free_vdev_map;
+
+	/* The rhashtable containing struct ath11k_peer keyed by mac addr
+	 * protected under ab->base_lock spin lock
+	 */
+	struct rhashtable *rhead_peer_addr;
+	struct rhashtable_params rhash_peer_addr_param;
+
+	/* The rhashtable containing struct ath11k_peer keyed by id  */
+	struct rhashtable *rhead_peer_id;
+	struct rhashtable_params rhash_peer_id_param;
+
 	struct list_head peers;
 	wait_queue_head_t peer_mapping_wq;
 	u8 mac_addr[ETH_ALEN];
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07f499d..34e041a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -871,6 +871,7 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar)
 	spin_lock_bh(&ab->base_lock);
 	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
 		ath11k_peer_rx_tid_cleanup(ar, peer);
+		ath11k_peer_rhash_delete(ab, peer);
 		list_del(&peer->list);
 		kfree(peer);
 	}
@@ -4524,6 +4525,7 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		if (peer && peer->sta == sta) {
 			ath11k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
 				    vif->addr, arvif->vdev_id);
+			ath11k_peer_rhash_delete(ar->ab, peer);
 			peer->sta = NULL;
 			list_del(&peer->list);
 			kfree(peer);
@@ -8305,6 +8307,8 @@ void ath11k_mac_unregister(struct ath11k_base *ab)
 
 		__ath11k_mac_unregister(ar);
 	}
+
+	ath11k_peer_rhash_tbl_destroy(ab);
 }
 
 static int __ath11k_mac_register(struct ath11k *ar)
@@ -8515,6 +8519,10 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	ab->cc_freq_hz = IPQ8074_CC_FREQ_HERTZ;
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
+	ret = ath11k_peer_rhash_tbl_init(ab);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
@@ -8544,6 +8552,8 @@ int ath11k_mac_register(struct ath11k_base *ab)
 		__ath11k_mac_unregister(ar);
 	}
 
+	ath11k_peer_rhash_tbl_destroy(ab);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 332886b..f2b5fc2 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -26,25 +27,6 @@ struct ath11k_peer *ath11k_peer_find(struct ath11k_base *ab, int vdev_id,
 	return NULL;
 }
 
-static struct ath11k_peer *ath11k_peer_find_by_pdev_idx(struct ath11k_base *ab,
-							u8 pdev_idx, const u8 *addr)
-{
-	struct ath11k_peer *peer;
-
-	lockdep_assert_held(&ab->base_lock);
-
-	list_for_each_entry(peer, &ab->peers, list) {
-		if (peer->pdev_idx != pdev_idx)
-			continue;
-		if (!ether_addr_equal(peer->addr, addr))
-			continue;
-
-		return peer;
-	}
-
-	return NULL;
-}
-
 struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
 					     const u8 *addr)
 {
@@ -52,14 +34,13 @@ struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
 
 	lockdep_assert_held(&ab->base_lock);
 
-	list_for_each_entry(peer, &ab->peers, list) {
-		if (!ether_addr_equal(peer->addr, addr))
-			continue;
+	if (!ab->rhead_peer_addr)
+		return NULL;
 
-		return peer;
-	}
+	peer = rhashtable_lookup_fast(ab->rhead_peer_addr, addr,
+				      ab->rhash_peer_addr_param);
 
-	return NULL;
+	return peer;
 }
 
 struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab,
@@ -69,11 +50,13 @@ struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab,
 
 	lockdep_assert_held(&ab->base_lock);
 
-	list_for_each_entry(peer, &ab->peers, list)
-		if (peer_id == peer->peer_id)
-			return peer;
+	if (!ab->rhead_peer_id)
+		return NULL;
 
-	return NULL;
+	peer = rhashtable_lookup_fast(ab->rhead_peer_id, &peer_id,
+				      ab->rhash_peer_id_param);
+
+	return peer;
 }
 
 struct ath11k_peer *ath11k_peer_find_by_vdev_id(struct ath11k_base *ab,
@@ -109,6 +92,7 @@ void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id)
 	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "htt peer unmap vdev %d peer %pM id %d\n",
 		   peer->vdev_id, peer->addr, peer_id);
 
+	ath11k_peer_rhash_delete(ab, peer);
 	list_del(&peer->list);
 	kfree(peer);
 	wake_up(&ab->peer_mapping_wq);
@@ -167,6 +151,75 @@ static int ath11k_wait_for_peer_common(struct ath11k_base *ab, int vdev_id,
 	return 0;
 }
 
+static inline int ath11k_peer_rhash_insert(struct ath11k_base *ab,
+					   struct rhashtable *rtbl,
+					   struct rhash_head *rhead,
+					   struct rhashtable_params *params,
+					   void *key)
+{
+	struct ath11k_peer *tmp;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	tmp = rhashtable_lookup_get_insert_fast(rtbl, rhead, *params);
+
+	if (!tmp)
+		return 0;
+	else if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	else
+		return -EEXIST;
+}
+
+static inline int ath11k_peer_rhash_remove(struct ath11k_base *ab,
+					   struct rhashtable *rtbl,
+					   struct rhash_head *rhead,
+					   struct rhashtable_params *params)
+{
+	int ret;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	ret = rhashtable_remove_fast(rtbl, rhead, *params);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	return 0;
+}
+
+static int ath11k_peer_rhash_add(struct ath11k_base *ab, struct ath11k_peer *peer)
+{
+	int ret;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	if (!ab->rhead_peer_id || !ab->rhead_peer_addr)
+		return -EPERM;
+
+	ret = ath11k_peer_rhash_insert(ab, ab->rhead_peer_id, &peer->rhash_id,
+				       &ab->rhash_peer_id_param, &peer->peer_id);
+	if (ret) {
+		ath11k_warn(ab, "failed to add peer %pM with id %d in rhash_id ret %d\n",
+			    peer->addr, peer->peer_id, ret);
+		return ret;
+	}
+
+	ret = ath11k_peer_rhash_insert(ab, ab->rhead_peer_addr, &peer->rhash_addr,
+				       &ab->rhash_peer_addr_param, &peer->addr);
+	if (ret) {
+		ath11k_warn(ab, "failed to add peer %pM with id %d in rhash_addr ret %d\n",
+			    peer->addr, peer->peer_id, ret);
+		goto err_clean;
+	}
+
+	return 0;
+
+err_clean:
+	ath11k_peer_rhash_remove(ab, ab->rhead_peer_id, &peer->rhash_id,
+				 &ab->rhash_peer_id_param);
+	return ret;
+}
+
 void ath11k_peer_cleanup(struct ath11k *ar, u32 vdev_id)
 {
 	struct ath11k_peer *peer, *tmp;
@@ -182,6 +235,7 @@ void ath11k_peer_cleanup(struct ath11k *ar, u32 vdev_id)
 		ath11k_warn(ab, "removing stale peer %pM from vdev_id %d\n",
 			    peer->addr, vdev_id);
 
+		ath11k_peer_rhash_delete(ab, peer);
 		list_del(&peer->list);
 		kfree(peer);
 		ar->num_peers--;
@@ -263,7 +317,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	}
 
 	spin_lock_bh(&ar->ab->base_lock);
-	peer = ath11k_peer_find_by_pdev_idx(ar->ab, ar->pdev_idx, param->peer_addr);
+	peer = ath11k_peer_find_by_addr(ar->ab, param->peer_addr);
 	if (peer) {
 		spin_unlock_bh(&ar->ab->base_lock);
 		return -EINVAL;
@@ -295,6 +349,12 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		goto cleanup;
 	}
 
+	ret = ath11k_peer_rhash_add(ar->ab, peer);
+	if (ret) {
+		spin_unlock_bh(&ar->ab->base_lock);
+		goto cleanup;
+	}
+
 	peer->pdev_idx = ar->pdev_idx;
 	peer->sta = sta;
 
@@ -342,3 +402,187 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 exit:
 	return ret;
 }
+
+int ath11k_peer_rhash_delete(struct ath11k_base *ab, struct ath11k_peer *peer)
+{
+	int ret;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	if (!ab->rhead_peer_id || !ab->rhead_peer_addr)
+		return -EPERM;
+
+	ret = ath11k_peer_rhash_remove(ab, ab->rhead_peer_addr, &peer->rhash_addr,
+				       &ab->rhash_peer_addr_param);
+	if (ret) {
+		ath11k_warn(ab, "failed to remove peer %pM id %d in rhash_addr ret %d\n",
+			    peer->addr, peer->peer_id, ret);
+		return ret;
+	}
+
+	ret = ath11k_peer_rhash_remove(ab, ab->rhead_peer_id, &peer->rhash_id,
+				       &ab->rhash_peer_id_param);
+	if (ret) {
+		ath11k_warn(ab, "failed to remove peer %pM id %d in rhash_id ret %d\n",
+			    peer->addr, peer->peer_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ath11k_peer_rhash_id_tbl_init(struct ath11k_base *ab)
+{
+	struct rhashtable_params *param;
+	struct rhashtable *rhash_id_tbl;
+	int ret;
+	size_t size;
+
+	if (ab->rhead_peer_id)
+		return 0;
+
+	size = sizeof(*ab->rhead_peer_id);
+	rhash_id_tbl = kzalloc(size, GFP_KERNEL);
+	if (!rhash_id_tbl) {
+		ath11k_warn(ab, "failed to init rhash id table due to no mem (size %zu)\n",
+			    size);
+		return -ENOMEM;
+	}
+
+	param = &ab->rhash_peer_id_param;
+
+	param->key_offset = offsetof(struct ath11k_peer, peer_id);
+	param->head_offset = offsetof(struct ath11k_peer, rhash_id);
+	param->key_len = sizeof_field(struct ath11k_peer, peer_id);
+	param->automatic_shrinking = true;
+	param->nelem_hint = ab->num_radios * TARGET_NUM_PEERS_PDEV(ab);
+
+	ret = rhashtable_init(rhash_id_tbl, param);
+	if (ret) {
+		ath11k_warn(ab, "failed to init peer id rhash table %d\n", ret);
+		goto err_free;
+	}
+
+	spin_lock_bh(&ab->base_lock);
+
+	if (!ab->rhead_peer_id) {
+		ab->rhead_peer_id = rhash_id_tbl;
+	} else {
+		spin_unlock_bh(&ab->base_lock);
+		goto cleanup_tbl;
+	}
+
+	spin_unlock_bh(&ab->base_lock);
+
+	return 0;
+
+cleanup_tbl:
+	rhashtable_destroy(rhash_id_tbl);
+err_free:
+	kfree(rhash_id_tbl);
+
+	return ret;
+}
+
+static int ath11k_peer_rhash_addr_tbl_init(struct ath11k_base *ab)
+{
+	struct rhashtable_params *param;
+	struct rhashtable *rhash_addr_tbl;
+	int ret;
+	size_t size;
+
+	if (ab->rhead_peer_addr)
+		return 0;
+
+	size = sizeof(*ab->rhead_peer_addr);
+	rhash_addr_tbl = kzalloc(size, GFP_KERNEL);
+	if (!rhash_addr_tbl) {
+		ath11k_warn(ab, "failed to init rhash addr table due to no mem (size %zu)\n",
+			    size);
+		return -ENOMEM;
+	}
+
+	param = &ab->rhash_peer_addr_param;
+
+	param->key_offset = offsetof(struct ath11k_peer, addr);
+	param->head_offset = offsetof(struct ath11k_peer, rhash_addr);
+	param->key_len = sizeof_field(struct ath11k_peer, addr);
+	param->automatic_shrinking = true;
+	param->nelem_hint = ab->num_radios * TARGET_NUM_PEERS_PDEV(ab);
+
+	ret = rhashtable_init(rhash_addr_tbl, param);
+	if (ret) {
+		ath11k_warn(ab, "failed to init peer addr rhash table %d\n", ret);
+		goto err_free;
+	}
+
+	spin_lock_bh(&ab->base_lock);
+
+	if (!ab->rhead_peer_addr) {
+		ab->rhead_peer_addr = rhash_addr_tbl;
+	} else {
+		spin_unlock_bh(&ab->base_lock);
+		goto cleanup_tbl;
+	}
+
+	spin_unlock_bh(&ab->base_lock);
+
+	return 0;
+
+cleanup_tbl:
+	rhashtable_destroy(rhash_addr_tbl);
+err_free:
+	kfree(rhash_addr_tbl);
+
+	return ret;
+}
+
+static inline void ath11k_peer_rhash_id_tbl_destroy(struct ath11k_base *ab)
+{
+	if (!ab->rhead_peer_id)
+		return;
+
+	rhashtable_destroy(ab->rhead_peer_id);
+	kfree(ab->rhead_peer_id);
+	ab->rhead_peer_id = NULL;
+}
+
+static inline void ath11k_peer_rhash_addr_tbl_destroy(struct ath11k_base *ab)
+{
+	if (!ab->rhead_peer_addr)
+		return;
+
+	rhashtable_destroy(ab->rhead_peer_addr);
+	kfree(ab->rhead_peer_addr);
+	ab->rhead_peer_addr = NULL;
+}
+
+int ath11k_peer_rhash_tbl_init(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_peer_rhash_id_tbl_init(ab);
+	if (ret)
+		return ret;
+
+	ret = ath11k_peer_rhash_addr_tbl_init(ab);
+	if (ret)
+		goto cleanup_tbl;
+
+	return 0;
+
+cleanup_tbl:
+	ath11k_peer_rhash_id_tbl_destroy(ab);
+
+	return ret;
+}
+
+void ath11k_peer_rhash_tbl_destroy(struct ath11k_base *ab)
+{
+	spin_lock_bh(&ab->base_lock);
+
+	ath11k_peer_rhash_addr_tbl_destroy(ab);
+	ath11k_peer_rhash_id_tbl_destroy(ab);
+
+	spin_unlock_bh(&ab->base_lock);
+}
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 63fe566..b687fa9 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_PEER_H
@@ -20,6 +21,11 @@ struct ath11k_peer {
 	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
 	struct dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
 
+	/* peer id based rhashtable list pointer */
+	struct rhash_head rhash_id;
+	/* peer addr based rhashtable list pointer */
+	struct rhash_head rhash_addr;
+
 	/* Info used in MMIC verification of
 	 * RX fragments
 	 */
@@ -47,5 +53,7 @@ int ath11k_wait_for_peer_delete_done(struct ath11k *ar, u32 vdev_id,
 				     const u8 *addr);
 struct ath11k_peer *ath11k_peer_find_by_vdev_id(struct ath11k_base *ab,
 						int vdev_id);
-
+int ath11k_peer_rhash_tbl_init(struct ath11k_base *ab);
+void ath11k_peer_rhash_tbl_destroy(struct ath11k_base *ab);
+int ath11k_peer_rhash_delete(struct ath11k_base *ab, struct ath11k_peer *peer);
 #endif /* _PEER_H_ */
-- 
2.7.4

