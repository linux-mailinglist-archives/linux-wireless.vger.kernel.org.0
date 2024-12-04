Return-Path: <linux-wireless+bounces-15897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8C9E3FB8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EB128297A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D0D20CCE2;
	Wed,  4 Dec 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzftGJLP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0820CCFB
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329945; cv=none; b=FxlWj7rtnMsvnVaKzOezbcV+Pr/Bp2DtA30NdsPa1Qe1KH9EWe7AIMJdtdvLpchxRprCTcwjN93qM7NDUcuhgq+kHEsYXoGrdPVfx6sP7OTYa6pyYWWEvI45rhDTGxYPWTCZNzThEHlHln7XBEtI5AgqKJu4wi2BIZ6qcVmFHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329945; c=relaxed/simple;
	bh=3gyXssl1Da6F82cyxFqcclJf+2FSUsY14Gf6RHS6UXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEUp7Dt4w2xOXDei9G+nPqbnz5cPmv1mzAcQq5s2GehsEs+jcWAEOGn7zEdp1R4gGJJOVQ7QBtmgdG5pQXXTLCa2LIa1iPuYo68p+aNhoXp0IigJeCLmdxPR6ibcUoPnm7zyY7YWciMrZZ5LV17qD/EV8eby3KNeWWlCfN0VBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzftGJLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346C2C4CED2;
	Wed,  4 Dec 2024 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733329944;
	bh=3gyXssl1Da6F82cyxFqcclJf+2FSUsY14Gf6RHS6UXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CzftGJLPhMZ2D9YAeFOfgtMSmJl4+3ENUkZH8vyodZonFQV9/+ljobQ+JzSpW4ekH
	 +qxyNvfcYiAhiNK4r9PlzcgzgQZH7hpclYV9DDc5C3PxMzaDFnqvzsCnImBS0dh5yR
	 eifejKF41QJCmGnqTWLlx9ndbrvfHe87rA+pGHhnjmtVpLqm2gmalLnGl1+3Mdmgj9
	 7DvhEojKEJgo9wtnjFetmN5neuEL3gxqe5svUQS6zqkddR1uH/ROcE8sppJj/Z2b1p
	 7+yx3vq+2PaF4MI3L4ddWQq3QGmcbNAhJHH8VXMuov0BGve0zGU9QKYVv0/1a3q5ag
	 ZPzhLb3ZNnViw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 5/7] wifi: ath12k: move struct ath12k_hw from per device to group
Date: Wed,  4 Dec 2024 18:32:14 +0200
Message-Id: <20241204163216.433795-6-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204163216.433795-1-kvalo@kernel.org>
References: <20241204163216.433795-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, hardware abstractions (ah) of different radio bands are tightly
coupled to a single device (ab). But, with hardware device group abstraction
(ag), multiple radios across different devices in a group can form different
combinations of hardware abstractions (ah) within the group. Hence, the mapping
between ah to ab can be removed and instead it can be mapped with struct
ath12k_hw_group (ag).

Current mapping between struct ath12k_hw (ah), struct ath12k_base (ab) and struct
ath12k_hw_group (ag):

            +------------------------------------------------+
            |  +-------------------------------------+       |
            |  | +---------------+ +---------------+ |       |
            |  | |ath12k_hw (ah) | |ath12k_hw (ah) | |       |
            |  | +---------------+ +---------------+ |       |
            |  |                                     |       |
            |  |  +-----------+ |   +-----------+    |       |
            |  |  | ar (2GHz) | |   | ar (5GHz) |    |       |
            |  |  +-----------+ |   +-----------+    |       |
            |  |          Dual band device-1 (ab)    |       |
            |  +-------------------------------------+       |
            |    ath12k_hw_group (ag) based on group id      |
            +------------------------------------------------+

After hardware device group abstraction moving ah array out of ab to ag:

            +----------------------------------------------+
            |   +---------------+  +---------------+       |
            |   |ath12k_hw (ah) |  |ath12k_hw (ah) |       |
            |   +---------------+  +---------------+       |
            |  +-------------------------------------+     |
            |  | +-----------+     +-----------+     |     |
            |  | | ar (2GHz) |     | ar (5GHz) |     |     |
            |  | +-----------+     +-----------+     |     |
            |  |     Dual band device-1 (ab)         |     |
            |  +-------------------------------------+     |
            |   ath12k_hw_group (ag) based on group id     |
            +----------------------------------------------+

This decoupling of struct ath12k_hw (ah) from struct ath12k_base (ab) and
mapping it to struct ath12k_hw_group (ag) will help in forming different
combinations of multi-link devices.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 49 +++++++-------
 drivers/net/wireless/ath/ath12k/core.h | 29 +++++----
 drivers/net/wireless/ath/ath12k/dp.c   | 19 ++----
 drivers/net/wireless/ath/ath12k/dp.h   |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 89 ++++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/mac.h  |  9 +--
 6 files changed, 115 insertions(+), 82 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index dea2c53bcc07..bbfa57d097af 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -861,8 +861,6 @@ static void ath12k_core_device_cleanup(struct ath12k_base *ab)
 
 	ath12k_hif_irq_disable(ab);
 	ath12k_core_pdev_destroy(ab);
-	ath12k_mac_unregister(ab);
-	ath12k_mac_destroy(ab);
 
 	mutex_unlock(&ab->core_lock);
 }
@@ -874,12 +872,18 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 
 	lockdep_assert_held(&ag->mutex);
 
+	clear_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags);
+
+	ath12k_mac_unregister(ag);
+
 	for (i = ag->num_devices - 1; i >= 0; i--) {
 		ab = ag->ab[i];
 		if (!ab)
 			continue;
 		ath12k_core_device_cleanup(ab);
 	}
+
+	ath12k_mac_destroy(ag);
 }
 
 static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
@@ -889,6 +893,20 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 
 	lockdep_assert_held(&ag->mutex);
 
+	if (test_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags))
+		goto core_pdev_create;
+
+	ret = ath12k_mac_allocate(ag);
+	if (WARN_ON(ret))
+		return ret;
+
+	ret = ath12k_mac_register(ag);
+	if (WARN_ON(ret))
+		goto err_mac_destroy;
+
+	set_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags);
+
+core_pdev_create:
 	for (i = 0; i < ag->num_devices; i++) {
 		ab = ag->ab[i];
 		if (!ab)
@@ -896,29 +914,6 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 
 		mutex_lock(&ab->core_lock);
 
-		/* Check if already registered or not, since same flow
-		 * execute for HW restart case.
-		 */
-		if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
-			goto core_pdev_create;
-
-		ret = ath12k_mac_allocate(ab);
-		if (ret) {
-			ath12k_err(ab, "failed to create new hw device with mac80211 :%d\n",
-				   ret);
-			mutex_unlock(&ab->core_lock);
-			return ret;
-		}
-
-		ret = ath12k_mac_register(ab);
-		if (ret) {
-			ath12k_err(ab, "failed to register radio with mac80211: %d\n",
-				   ret);
-			mutex_unlock(&ab->core_lock);
-			goto err;
-		}
-
-core_pdev_create:
 		ret = ath12k_core_pdev_create(ab);
 		if (ret) {
 			ath12k_err(ab, "failed to create pdev core %d\n", ret);
@@ -941,6 +936,10 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 
 err:
 	ath12k_core_hw_group_stop(ag);
+	return ret;
+
+err_mac_destroy:
+	ath12k_mac_destroy(ag);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index b8b1ee8d3302..64252d6491cd 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -64,6 +64,7 @@
 #define ATH12K_RECOVER_START_TIMEOUT_HZ		(20 * HZ)
 
 #define ATH12K_MAX_SOCS 3
+#define ATH12K_GROUP_MAX_RADIO (ATH12K_MAX_SOCS * MAX_RADIOS)
 #define ATH12K_INVALID_GROUP_ID  0xFF
 #define ATH12K_INVALID_DEVICE_ID 0xFF
 
@@ -216,6 +217,10 @@ enum ath12k_scan_state {
 	ATH12K_SCAN_ABORTING,
 };
 
+enum ath12k_hw_group_flags {
+	ATH12K_GROUP_FLAG_REGISTERED,
+};
+
 enum ath12k_dev_flags {
 	ATH12K_CAC_RUNNING,
 	ATH12K_FLAG_CRASH_FLUSH,
@@ -830,6 +835,15 @@ struct ath12k_hw_group {
 
 	/* protects access to this struct */
 	struct mutex mutex;
+
+	/* Holds information of wiphy (hw) registration.
+	 *
+	 * In Multi/Single Link Operation case, all pdevs are registered as
+	 * a single wiphy. In other (legacy/Non-MLO) cases, each pdev is
+	 * registered as separate wiphys.
+	 */
+	struct ath12k_hw *ah[ATH12K_GROUP_MAX_RADIO];
+	u8 num_hw;
 };
 
 /* Master structure to hold the hw data which may be used in core module */
@@ -895,15 +909,6 @@ struct ath12k_base {
 
 	struct ath12k_pdev __rcu *pdevs_active[MAX_RADIOS];
 
-	/* Holds information of wiphy (hw) registration.
-	 *
-	 * In Multi/Single Link Operation case, all pdevs are registered as
-	 * a single wiphy. In other (legacy/Non-MLO) cases, each pdev is
-	 * registered as separate wiphys.
-	 */
-	struct ath12k_hw *ah[MAX_RADIOS];
-	u8 num_hw;
-
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg hal_reg_cap[MAX_RADIOS];
 	unsigned long long free_vdev_map;
 	unsigned long long free_vdev_stats_id_map;
@@ -1164,18 +1169,18 @@ static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
 
 static inline struct ath12k_hw *ath12k_ab_to_ah(struct ath12k_base *ab, int idx)
 {
-	return ab->ah[idx];
+	return ab->ag->ah[idx];
 }
 
 static inline void ath12k_ab_set_ah(struct ath12k_base *ab, int idx,
 				    struct ath12k_hw *ah)
 {
-	ab->ah[idx] = ah;
+	ab->ag->ah[idx] = ah;
 }
 
 static inline int ath12k_get_num_hw(struct ath12k_base *ab)
 {
-	return ab->num_hw;
+	return ab->ag->num_hw;
 }
 
 static inline struct ath12k_hw_group *ath12k_ab_to_ag(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index ce823b1c175f..68abe9d4ab45 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -991,21 +991,14 @@ void ath12k_dp_pdev_free(struct ath12k_base *ab)
 		ath12k_dp_rx_pdev_free(ab, i);
 }
 
-void ath12k_dp_pdev_pre_alloc(struct ath12k_base *ab)
+void ath12k_dp_pdev_pre_alloc(struct ath12k *ar)
 {
-	struct ath12k *ar;
-	struct ath12k_pdev_dp *dp;
-	int i;
+	struct ath12k_pdev_dp *dp = &ar->dp;
 
-	for (i = 0; i <  ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-		dp = &ar->dp;
-		dp->mac_id = i;
-		atomic_set(&dp->num_tx_pending, 0);
-		init_waitqueue_head(&dp->tx_empty_waitq);
-
-		/* TODO: Add any RXDMA setup required per pdev */
-	}
+	dp->mac_id = ar->pdev_idx;
+	atomic_set(&dp->num_tx_pending, 0);
+	init_waitqueue_head(&dp->tx_empty_waitq);
+	/* TODO: Add any RXDMA setup required per pdev */
 }
 
 bool ath12k_dp_wmask_compaction_rx_tlv_supported(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index a120b7a8477d..021cd9e8ee1d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1806,7 +1806,7 @@ void ath12k_dp_free(struct ath12k_base *ab);
 int ath12k_dp_alloc(struct ath12k_base *ab);
 void ath12k_dp_cc_config(struct ath12k_base *ab);
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab);
-void ath12k_dp_pdev_pre_alloc(struct ath12k_base *ab);
+void ath12k_dp_pdev_pre_alloc(struct ath12k *ar);
 void ath12k_dp_pdev_free(struct ath12k_base *ab);
 int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
 				int mac_id, enum hal_ring_type ring_type);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1180070278da..1cf724a530b5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10818,19 +10818,13 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
 }
 
-int ath12k_mac_register(struct ath12k_base *ab)
+int ath12k_mac_register(struct ath12k_hw_group *ag)
 {
+	struct ath12k_base *ab = ag->ab[0];
 	struct ath12k_hw *ah;
 	int i;
 	int ret;
 
-	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
-		return 0;
-
-	/* Initialize channel counters frequency value in hertz */
-	ab->cc_freq_hz = 320000;
-	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
-
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 
@@ -10855,8 +10849,9 @@ int ath12k_mac_register(struct ath12k_base *ab)
 	return ret;
 }
 
-void ath12k_mac_unregister(struct ath12k_base *ab)
+void ath12k_mac_unregister(struct ath12k_hw_group *ag)
 {
+	struct ath12k_base *ab = ag->ab[0];
 	struct ath12k_hw *ah;
 	int i;
 
@@ -10876,12 +10871,13 @@ static void ath12k_mac_hw_destroy(struct ath12k_hw *ah)
 	ieee80211_free_hw(ah->hw);
 }
 
-static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
+static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
 						struct ath12k_pdev_map *pdev_map,
 						u8 num_pdev_map)
 {
 	struct ieee80211_hw *hw;
 	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_pdev *pdev;
 	struct ath12k_hw *ah;
 	int i;
@@ -10913,23 +10909,30 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 		pdev->ar = ar;
 
 		ath12k_mac_setup(ar);
+		ath12k_dp_pdev_pre_alloc(ar);
 	}
 
 	return ah;
 }
 
-void ath12k_mac_destroy(struct ath12k_base *ab)
+void ath12k_mac_destroy(struct ath12k_hw_group *ag)
 {
 	struct ath12k_pdev *pdev;
+	struct ath12k_base *ab = ag->ab[0];
+	int i, j;
 	struct ath12k_hw *ah;
-	int i;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		if (!pdev->ar)
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
 			continue;
 
-		pdev->ar = NULL;
+		for (j = 0; j < ab->num_radios; j++) {
+			pdev = &ab->pdevs[j];
+			if (!pdev->ar)
+				continue;
+			pdev->ar = NULL;
+		}
 	}
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
@@ -10942,26 +10945,59 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
 	}
 }
 
-int ath12k_mac_allocate(struct ath12k_base *ab)
+static void ath12k_mac_set_device_defaults(struct ath12k_base *ab)
 {
+	/* Initialize channel counters frequency value in hertz */
+	ab->cc_freq_hz = 320000;
+	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
+}
+
+int ath12k_mac_allocate(struct ath12k_hw_group *ag)
+{
+	struct ath12k_pdev_map pdev_map[ATH12K_GROUP_MAX_RADIO];
+	int mac_id, device_id, total_radio, num_hw;
+	struct ath12k_base *ab;
 	struct ath12k_hw *ah;
-	struct ath12k_pdev_map pdev_map[MAX_RADIOS];
 	int ret, i, j;
 	u8 radio_per_hw;
 
-	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
-		return 0;
+	total_radio = 0;
+	for (i = 0; i < ag->num_devices; i++)
+		total_radio += ag->ab[i]->num_radios;
 
-	ab->num_hw = ab->num_radios;
+	/* All pdev get combined and register as single wiphy based on
+	 * hardware group which participate in multi-link operation else
+	 * each pdev get register separately.
+	 *
+	 * Currently, registering as single pdevs.
+	 */
 	radio_per_hw = 1;
+	num_hw = total_radio / radio_per_hw;
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+	if (WARN_ON(num_hw >= ATH12K_GROUP_MAX_RADIO))
+		return -ENOSPC;
+
+	ag->num_hw = 0;
+	device_id = 0;
+	mac_id = 0;
+	for (i = 0; i < num_hw; i++) {
 		for (j = 0; j < radio_per_hw; j++) {
+			ab = ag->ab[device_id];
 			pdev_map[j].ab = ab;
-			pdev_map[j].pdev_idx = (i * radio_per_hw) + j;
+			pdev_map[j].pdev_idx = mac_id;
+			mac_id++;
+
+			/* If mac_id falls beyond the current device MACs then
+			 * move to next device
+			 */
+			if (mac_id >= ab->num_radios) {
+				mac_id = 0;
+				device_id++;
+				ath12k_mac_set_device_defaults(ab);
+			}
 		}
 
-		ah = ath12k_mac_hw_allocate(ab, pdev_map, radio_per_hw);
+		ah = ath12k_mac_hw_allocate(ag, pdev_map, radio_per_hw);
 		if (!ah) {
 			ath12k_warn(ab, "failed to allocate mac80211 hw device for hw_idx %d\n",
 				    i);
@@ -10971,11 +11007,10 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 
 		ah->dev = ab->dev;
 
-		ath12k_ab_set_ah(ab, i, ah);
+		ag->ah[i] = ah;
+		ag->num_hw++;
 	}
 
-	ath12k_dp_pdev_pre_alloc(ab);
-
 	return 0;
 
 err:
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index abdc9a6c0740..ccfc215d83ff 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -14,6 +14,7 @@
 struct ath12k;
 struct ath12k_base;
 struct ath12k_hw;
+struct ath12k_hw_group;
 struct ath12k_pdev_map;
 
 struct ath12k_generic_iter {
@@ -60,10 +61,10 @@ enum ath12k_supported_bw {
 
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
 
-void ath12k_mac_destroy(struct ath12k_base *ab);
-void ath12k_mac_unregister(struct ath12k_base *ab);
-int ath12k_mac_register(struct ath12k_base *ab);
-int ath12k_mac_allocate(struct ath12k_base *ab);
+void ath12k_mac_destroy(struct ath12k_hw_group *ag);
+void ath12k_mac_unregister(struct ath12k_hw_group *ag);
+int ath12k_mac_register(struct ath12k_hw_group *ag);
+int ath12k_mac_allocate(struct ath12k_hw_group *ag);
 int ath12k_mac_hw_ratecode_to_legacy_rate(u8 hw_rc, u8 preamble, u8 *rateidx,
 					  u16 *rate);
 u8 ath12k_mac_bitrate_to_idx(const struct ieee80211_supported_band *sband,
-- 
2.39.5


