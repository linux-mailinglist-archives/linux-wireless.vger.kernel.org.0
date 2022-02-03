Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F98B4A7EB0
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 05:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiBCE3w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 23:29:52 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:43052 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiBCE3u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 23:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643862591; x=1675398591;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=v5swFtGr6+Gq7Uox/iBGYqc3ikIapfnH7Xq9a+jfTng=;
  b=J1vPyWt42avtm/tmCuPcsNsanAApot01jMegavyRxT+S8UGMU8PM8ysO
   +usyblBDCXj5P8UheOnSTC78UXpimy4Yiu81CDk+XqeRR1oYvHdMCjOZr
   vt1gj29X14v8/QruhYsxHbafMFnJJNjzdPEfOBbglpGiejbW5Qhw+gG2d
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Feb 2022 20:29:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 20:29:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 2 Feb 2022 20:29:50 -0800
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 2 Feb 2022 20:29:47 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v4] ath11k: Add peer rhash table support
Date:   Thu, 3 Feb 2022 09:59:35 +0530
Message-ID: <1643862575-18263-1-git-send-email-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
 v4:
   - Updated 2022 Copyright
 v3:
   - Fix "sleeping function called from invalid context" by
     replacing atomic lock by mutex lock in tbl write operation
 v2:
   - Rebase on ToT

 drivers/net/wireless/ath/ath11k/core.c |   3 +-
 drivers/net/wireless/ath/ath11k/core.h |  14 ++
 drivers/net/wireless/ath/ath11k/mac.c  |  16 +-
 drivers/net/wireless/ath/ath11k/peer.c | 344 +++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/peer.h |  10 +-
 5 files changed, 363 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7c508e9..3baeaa0 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -1435,6 +1435,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 		goto err_sc_free;
 
 	mutex_init(&ab->core_lock);
+	mutex_init(&ab->tbl_lock);
 	spin_lock_init(&ab->base_lock);
 	mutex_init(&ab->vdev_id_11d_lock);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 10846e9..ecc256b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
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
@@ -746,6 +748,18 @@ struct ath11k_base {
 	struct ath11k_pdev __rcu *pdevs_active[MAX_RADIOS];
 	struct ath11k_hal_reg_capabilities_ext hal_reg_cap[MAX_RADIOS];
 	unsigned long long free_vdev_map;
+
+	/* To synchronize rhash tbl write operation */
+	struct mutex tbl_lock;
+
+	/* The rhashtable containing struct ath11k_peer keyed by mac addr */
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
index ed89905..60e200d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -868,13 +868,16 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar)
 
 	lockdep_assert_held(&ar->conf_mutex);
 
+	mutex_lock(&ab->tbl_lock);
 	spin_lock_bh(&ab->base_lock);
 	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
 		ath11k_peer_rx_tid_cleanup(ar, peer);
+		ath11k_peer_rhash_delete(ab, peer);
 		list_del(&peer->list);
 		kfree(peer);
 	}
 	spin_unlock_bh(&ab->base_lock);
+	mutex_unlock(&ab->tbl_lock);
 
 	ar->num_peers = 0;
 	ar->num_stations = 0;
@@ -4531,6 +4534,7 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		}
 
 		ath11k_mac_dec_num_stations(arvif, sta);
+		mutex_lock(&ar->ab->tbl_lock);
 		spin_lock_bh(&ar->ab->base_lock);
 		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
 		if (skip_peer_delete && peer) {
@@ -4538,12 +4542,14 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		} else if (peer && peer->sta == sta) {
 			ath11k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
 				    vif->addr, arvif->vdev_id);
+			ath11k_peer_rhash_delete(ar->ab, peer);
 			peer->sta = NULL;
 			list_del(&peer->list);
 			kfree(peer);
 			ar->num_peers--;
 		}
 		spin_unlock_bh(&ar->ab->base_lock);
+		mutex_unlock(&ar->ab->tbl_lock);
 
 		kfree(arsta->tx_stats);
 		arsta->tx_stats = NULL;
@@ -8338,6 +8344,8 @@ void ath11k_mac_unregister(struct ath11k_base *ab)
 
 		__ath11k_mac_unregister(ar);
 	}
+
+	ath11k_peer_rhash_tbl_destroy(ab);
 }
 
 static int __ath11k_mac_register(struct ath11k *ar)
@@ -8548,6 +8556,10 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	ab->cc_freq_hz = IPQ8074_CC_FREQ_HERTZ;
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
+	ret = ath11k_peer_rhash_tbl_init(ab);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
@@ -8577,6 +8589,8 @@ int ath11k_mac_register(struct ath11k_base *ab)
 		__ath11k_mac_unregister(ar);
 	}
 
+	ath11k_peer_rhash_tbl_destroy(ab);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 332886b..e316428 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -1,23 +1,22 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
 #include "peer.h"
 #include "debug.h"
 
-struct ath11k_peer *ath11k_peer_find(struct ath11k_base *ab, int vdev_id,
-				     const u8 *addr)
+static struct ath11k_peer *ath11k_peer_find_list_by_id(struct ath11k_base *ab,
+						       int peer_id)
 {
 	struct ath11k_peer *peer;
 
 	lockdep_assert_held(&ab->base_lock);
 
 	list_for_each_entry(peer, &ab->peers, list) {
-		if (peer->vdev_id != vdev_id)
-			continue;
-		if (!ether_addr_equal(peer->addr, addr))
+		if (peer->peer_id != peer_id)
 			continue;
 
 		return peer;
@@ -26,15 +25,15 @@ struct ath11k_peer *ath11k_peer_find(struct ath11k_base *ab, int vdev_id,
 	return NULL;
 }
 
-static struct ath11k_peer *ath11k_peer_find_by_pdev_idx(struct ath11k_base *ab,
-							u8 pdev_idx, const u8 *addr)
+struct ath11k_peer *ath11k_peer_find(struct ath11k_base *ab, int vdev_id,
+				     const u8 *addr)
 {
 	struct ath11k_peer *peer;
 
 	lockdep_assert_held(&ab->base_lock);
 
 	list_for_each_entry(peer, &ab->peers, list) {
-		if (peer->pdev_idx != pdev_idx)
+		if (peer->vdev_id != vdev_id)
 			continue;
 		if (!ether_addr_equal(peer->addr, addr))
 			continue;
@@ -52,14 +51,13 @@ struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
 
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
@@ -69,11 +67,13 @@ struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab,
 
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
@@ -99,7 +99,7 @@ void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id)
 
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath11k_peer_find_by_id(ab, peer_id);
+	peer = ath11k_peer_find_list_by_id(ab, peer_id);
 	if (!peer) {
 		ath11k_warn(ab, "peer-unmap-event: unknown peer id %d\n",
 			    peer_id);
@@ -167,6 +167,76 @@ static int ath11k_wait_for_peer_common(struct ath11k_base *ab, int vdev_id,
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
+	lockdep_assert_held(&ab->tbl_lock);
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
+	lockdep_assert_held(&ab->tbl_lock);
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
+	lockdep_assert_held(&ab->tbl_lock);
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
@@ -174,6 +244,7 @@ void ath11k_peer_cleanup(struct ath11k *ar, u32 vdev_id)
 
 	lockdep_assert_held(&ar->conf_mutex);
 
+	mutex_lock(&ab->tbl_lock);
 	spin_lock_bh(&ab->base_lock);
 	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
 		if (peer->vdev_id != vdev_id)
@@ -182,12 +253,14 @@ void ath11k_peer_cleanup(struct ath11k *ar, u32 vdev_id)
 		ath11k_warn(ab, "removing stale peer %pM from vdev_id %d\n",
 			    peer->addr, vdev_id);
 
+		ath11k_peer_rhash_delete(ab, peer);
 		list_del(&peer->list);
 		kfree(peer);
 		ar->num_peers--;
 	}
 
 	spin_unlock_bh(&ab->base_lock);
+	mutex_unlock(&ab->tbl_lock);
 }
 
 static int ath11k_wait_for_peer_deleted(struct ath11k *ar, int vdev_id, const u8 *addr)
@@ -220,14 +293,35 @@ int ath11k_wait_for_peer_delete_done(struct ath11k *ar, u32 vdev_id,
 int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr)
 {
 	int ret;
+	struct ath11k_peer *peer;
+	struct ath11k_base *ab = ar->ab;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
+	mutex_lock(&ab->tbl_lock);
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath11k_peer_find_by_addr(ab, addr);
+	if (!peer) {
+		spin_unlock_bh(&ab->base_lock);
+		mutex_unlock(&ab->tbl_lock);
+
+		ath11k_warn(ab,
+			    "failed to find peer vdev_id %d addr %pM in delete\n",
+			    vdev_id, addr);
+		return -EINVAL;
+	}
+
+	ath11k_peer_rhash_delete(ab, peer);
+
+	spin_unlock_bh(&ab->base_lock);
+	mutex_unlock(&ab->tbl_lock);
+
 	reinit_completion(&ar->peer_delete_done);
 
 	ret = ath11k_wmi_send_peer_delete_cmd(ar, addr, vdev_id);
 	if (ret) {
-		ath11k_warn(ar->ab,
+		ath11k_warn(ab,
 			    "failed to delete peer vdev_id %d addr %pM ret %d\n",
 			    vdev_id, addr, ret);
 		return ret;
@@ -263,7 +357,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	}
 
 	spin_lock_bh(&ar->ab->base_lock);
-	peer = ath11k_peer_find_by_pdev_idx(ar->ab, ar->pdev_idx, param->peer_addr);
+	peer = ath11k_peer_find_by_addr(ar->ab, param->peer_addr);
 	if (peer) {
 		spin_unlock_bh(&ar->ab->base_lock);
 		return -EINVAL;
@@ -283,11 +377,13 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	if (ret)
 		return ret;
 
+	mutex_lock(&ar->ab->tbl_lock);
 	spin_lock_bh(&ar->ab->base_lock);
 
 	peer = ath11k_peer_find(ar->ab, param->vdev_id, param->peer_addr);
 	if (!peer) {
 		spin_unlock_bh(&ar->ab->base_lock);
+		mutex_unlock(&ar->ab->tbl_lock);
 		ath11k_warn(ar->ab, "failed to find peer %pM on vdev %i after creation\n",
 			    param->peer_addr, param->vdev_id);
 
@@ -295,6 +391,13 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		goto cleanup;
 	}
 
+	ret = ath11k_peer_rhash_add(ar->ab, peer);
+	if (ret) {
+		spin_unlock_bh(&ar->ab->base_lock);
+		mutex_unlock(&ar->ab->tbl_lock);
+		goto cleanup;
+	}
+
 	peer->pdev_idx = ar->pdev_idx;
 	peer->sta = sta;
 
@@ -319,6 +422,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	ar->num_peers++;
 
 	spin_unlock_bh(&ar->ab->base_lock);
+	mutex_unlock(&ar->ab->tbl_lock);
 
 	return 0;
 
@@ -342,3 +446,201 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 exit:
 	return ret;
 }
+
+int ath11k_peer_rhash_delete(struct ath11k_base *ab, struct ath11k_peer *peer)
+{
+	int ret;
+
+	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&ab->tbl_lock);
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
+	lockdep_assert_held(&ab->tbl_lock);
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
+	lockdep_assert_held(&ab->tbl_lock);
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
+	lockdep_assert_held(&ab->tbl_lock);
+
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
+	lockdep_assert_held(&ab->tbl_lock);
+
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
+	mutex_lock(&ab->tbl_lock);
+
+	ret = ath11k_peer_rhash_id_tbl_init(ab);
+	if (ret)
+		goto out;
+
+	ret = ath11k_peer_rhash_addr_tbl_init(ab);
+	if (ret)
+		goto cleanup_tbl;
+
+	mutex_unlock(&ab->tbl_lock);
+
+	return 0;
+
+cleanup_tbl:
+	ath11k_peer_rhash_id_tbl_destroy(ab);
+out:
+	mutex_unlock(&ab->tbl_lock);
+	return ret;
+}
+
+void ath11k_peer_rhash_tbl_destroy(struct ath11k_base *ab)
+{
+	mutex_lock(&ab->tbl_lock);
+
+	ath11k_peer_rhash_addr_tbl_destroy(ab);
+	ath11k_peer_rhash_id_tbl_destroy(ab);
+
+	mutex_unlock(&ab->tbl_lock);
+}
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 63fe566..6dd17ba 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
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

