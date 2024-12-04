Return-Path: <linux-wireless+bounces-15895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506369E3FB6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07793282A8F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672620CCC9;
	Wed,  4 Dec 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8UgreYk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213020CCD7
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329943; cv=none; b=rLkLWVny7x/Jk7wsc7KYTtO+j7P0NiiY7h2O/b8fiWTmW6NkxGckK+vTJcdYj4k1Qm1Bu1J84ETM/4dc3iDZmfDZj2qlMyh93RN3jGTa+QZ3FbfRMxSO9Gz2Ln3Ffl7HOulzJB1Z/Iz7aKJGz99mNlliy5lcbKdqw6ygl1cwbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329943; c=relaxed/simple;
	bh=eOwBX+tMPFKV/Z+PuXHK2DnM5Hw8dvGaA7Y4eazG6YM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pUGSoxOVA1nGGa65+eXYClVixx48ZogX9Xia2eHC7KqkfjiKSKolsAmzonlFDzfUc5C/k696f6qk7kSlB+J7I3BUDpK/qhIBb+9/xoEAlo0IeJfP5vS3a3ANEJm3fA1qjOXR2jh2WyLNXTnIL8aBII1deaTZnQkgazCzj6DWAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8UgreYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256A1C4CED1;
	Wed,  4 Dec 2024 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733329942;
	bh=eOwBX+tMPFKV/Z+PuXHK2DnM5Hw8dvGaA7Y4eazG6YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8UgreYkqZwy1KNtSJZ9MQyU/lrU4chGgFuOKmp/qHITZux96DFh7D9WKeuGIgZpR
	 0iTJPeX85+IPzmKDT9Ut5vI8Vxl4dFvRFI1CjobKYBDkVDjEy97blDll3jkPxtHGJ6
	 7+14KUAbNpK10B/eORVQR2GHUyMyeP7qfv5Pvhbdz9CRZMKr8U4BuKk57trhweDatu
	 dYhfGetD2+iin3tRdStSy+b6dC5lR4kQC71kjJxVL2kHyHysm3ttcTlG1IhdYNlEOh
	 KK/svsdyhP7F94c3K8gZo+p2TPFmF/jgVJRuLA9orN53RcMrRv5ESh3Kxi8zz8l2/v
	 ThXW5HIZCbLtg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/7] wifi: ath12k: introduce device group abstraction
Date: Wed,  4 Dec 2024 18:32:12 +0200
Message-Id: <20241204163216.433795-4-kvalo@kernel.org>
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

Currently, single device is probed, and once firmware is ready, the device
is registered to mac80211. For Multi-Link Operation, different bands of
different devices or same device are part of a single wiphy and for
this, hardware device group abstraction is needed.

Hardware device group abstraction - when there are multiple devices (with
single radio or dual radio) that are connected by any means of interface
for communicating between them, then these devices can be combined
together as a single group using a group id to form a group abstraction
and register to mac80211.

The grouping information of multiple devices would be based on device tree
during device probe (will be implemented in future patches). If no such
information is available, then a single device will be part of group abstraction
and registered to mac80211, else multiple devices advertised in device tree are
combined and then registered to mac80211.

For device group abstraction, a base structure ath12k_hw_group (ag) and the
helpers are implemented. These helpers are used during device probe and mapping
the group to the devices involved.

An illustration of how multiple devices might be combined together in
future based on group id:

+------------------------------------------------------------------------+
|  +-------------------------------------+       +-------------------+   |
|  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
|  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
|  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
|  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
|  |         (Dual band device)          |       |                   |   |
|  +-------------------------------------+       +-------------------+   |
|                 ath12k_hw_group (ag) based on group id                 |
+------------------------------------------------------------------------+

In the above representation, two devices are combined into single group
based on group id.

Add base code changes where single device would be part of a group with an
invalid group id forming an group abstraction. Multi device grouping will
be introduced in future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 237 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/core.h |  17 ++
 drivers/net/wireless/ath/ath12k/pci.c  |   1 +
 3 files changed, 239 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 568c9b6e2c1c..41e3454b60f5 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -22,6 +22,11 @@ unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
+/* protected with ath12k_hw_group_mutex */
+static struct list_head ath12k_hw_group_list = LIST_HEAD_INIT(ath12k_hw_group_list);
+
+static DEFINE_MUTEX(ath12k_hw_group_mutex);
+
 static int ath12k_core_rfkill_config(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
@@ -1244,27 +1249,112 @@ static void ath12k_core_panic_notifier_unregister(struct ath12k_base *ab)
 					 &ab->panic_nb);
 }
 
-int ath12k_core_init(struct ath12k_base *ab)
+static inline
+bool ath12k_core_hw_group_create_ready(struct ath12k_hw_group *ag)
 {
-	int ret;
+	lockdep_assert_held(&ag->mutex);
 
-	ret = ath12k_core_soc_create(ab);
-	if (ret) {
-		ath12k_err(ab, "failed to create soc core: %d\n", ret);
-		return ret;
-	}
-
-	ret = ath12k_core_panic_notifier_register(ab);
-	if (ret)
-		ath12k_warn(ab, "failed to register panic handler: %d\n", ret);
-
-	return 0;
+	return (ag->num_probed == ag->num_devices);
 }
 
-void ath12k_core_deinit(struct ath12k_base *ab)
+static struct ath12k_hw_group *ath12k_core_hw_group_alloc(u8 id, u8 max_devices)
 {
-	ath12k_core_panic_notifier_unregister(ab);
+	struct ath12k_hw_group *ag;
 
+	lockdep_assert_held(&ath12k_hw_group_mutex);
+
+	ag = kzalloc(sizeof(*ag), GFP_KERNEL);
+	if (!ag)
+		return NULL;
+
+	ag->id = id;
+	ag->num_devices = max_devices;
+	list_add(&ag->list, &ath12k_hw_group_list);
+	mutex_init(&ag->mutex);
+
+	return ag;
+}
+
+static void ath12k_core_hw_group_free(struct ath12k_hw_group *ag)
+{
+	mutex_lock(&ath12k_hw_group_mutex);
+
+	list_del(&ag->list);
+	kfree(ag);
+
+	mutex_unlock(&ath12k_hw_group_mutex);
+}
+
+static struct ath12k_hw_group *ath12k_core_hw_group_assign(struct ath12k_base *ab)
+{
+	u32 group_id = ATH12K_INVALID_GROUP_ID;
+	struct ath12k_hw_group *ag;
+
+	lockdep_assert_held(&ath12k_hw_group_mutex);
+
+	/* The grouping of multiple devices will be done based on device tree file.
+	 * TODO: device tree file parsing to know about the devices involved in group.
+	 *
+	 * The platforms that do not have any valid group information would have each
+	 * device to be part of its own invalid group.
+	 *
+	 * Currently, we are not parsing any device tree information and hence, grouping
+	 * of multiple devices is not involved. Thus, single device is added to device
+	 * group.
+	 */
+	ag = ath12k_core_hw_group_alloc(group_id, 1);
+	if (!ag) {
+		ath12k_warn(ab, "unable to create new hw group\n");
+		return NULL;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "single device added to hardware group\n");
+
+	ab->device_id = ag->num_probed++;
+	ag->ab[ab->device_id] = ab;
+	ab->ag = ag;
+
+	return ag;
+}
+
+void ath12k_core_hw_group_unassign(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+	u8 device_id = ab->device_id;
+	int num_probed;
+
+	if (!ag)
+		return;
+
+	mutex_lock(&ag->mutex);
+
+	if (WARN_ON(device_id >= ag->num_devices)) {
+		mutex_unlock(&ag->mutex);
+		return;
+	}
+
+	if (WARN_ON(ag->ab[device_id] != ab)) {
+		mutex_unlock(&ag->mutex);
+		return;
+	}
+
+	ag->ab[device_id] = NULL;
+	ab->ag = NULL;
+	ab->device_id = ATH12K_INVALID_DEVICE_ID;
+
+	if (ag->num_probed)
+		ag->num_probed--;
+
+	num_probed = ag->num_probed;
+
+	mutex_unlock(&ag->mutex);
+
+	if (!num_probed)
+		ath12k_core_hw_group_free(ag);
+}
+
+static void ath12k_core_device_cleanup(struct ath12k_base *ab)
+{
 	mutex_lock(&ab->core_lock);
 
 	ath12k_hif_irq_disable(ab);
@@ -1274,8 +1364,123 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 	ath12k_core_stop(ab);
 
 	mutex_unlock(&ab->core_lock);
+}
 
-	ath12k_core_soc_destroy(ab);
+static void ath12k_core_hw_group_destroy(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab;
+	int i;
+
+	if (WARN_ON(!ag))
+		return;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		ath12k_core_soc_destroy(ab);
+	}
+}
+
+static void ath12k_core_hw_group_cleanup(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab;
+	int i;
+
+	if (!ag)
+		return;
+
+	mutex_lock(&ag->mutex);
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		ath12k_core_device_cleanup(ab);
+	}
+
+	mutex_unlock(&ag->mutex);
+}
+
+static int ath12k_core_hw_group_create(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab;
+	int i, ret;
+
+	lockdep_assert_held(&ag->mutex);
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		mutex_lock(&ab->core_lock);
+
+		ret = ath12k_core_soc_create(ab);
+		if (ret) {
+			mutex_unlock(&ab->core_lock);
+			ath12k_err(ab, "failed to create soc core: %d\n", ret);
+			return ret;
+		}
+
+		mutex_unlock(&ab->core_lock);
+	}
+
+	return 0;
+}
+
+int ath12k_core_init(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag;
+	int ret;
+
+	ret = ath12k_core_panic_notifier_register(ab);
+	if (ret)
+		ath12k_warn(ab, "failed to register panic handler: %d\n", ret);
+
+	mutex_lock(&ath12k_hw_group_mutex);
+
+	ag = ath12k_core_hw_group_assign(ab);
+	if (!ag) {
+		mutex_unlock(&ath12k_hw_group_mutex);
+		ath12k_warn(ab, "unable to get hw group\n");
+		return -ENODEV;
+	}
+
+	mutex_unlock(&ath12k_hw_group_mutex);
+
+	mutex_lock(&ag->mutex);
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "num devices %d num probed %d\n",
+		   ag->num_devices, ag->num_probed);
+
+	if (ath12k_core_hw_group_create_ready(ag)) {
+		ret = ath12k_core_hw_group_create(ag);
+		if (ret) {
+			mutex_unlock(&ag->mutex);
+			ath12k_warn(ab, "unable to create hw group\n");
+			goto err;
+		}
+	}
+
+	mutex_unlock(&ag->mutex);
+
+	return 0;
+
+err:
+	ath12k_core_hw_group_destroy(ab->ag);
+	ath12k_core_hw_group_unassign(ab);
+	return ret;
+}
+
+void ath12k_core_deinit(struct ath12k_base *ab)
+{
+	ath12k_core_panic_notifier_unregister(ab);
+	ath12k_core_hw_group_cleanup(ab->ag);
+	ath12k_core_hw_group_destroy(ab->ag);
+	ath12k_core_hw_group_unassign(ab);
 }
 
 void ath12k_core_free(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d93ba844f61d..dca4b9a3538f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -816,6 +816,20 @@ struct ath12k_soc_dp_stats {
 	struct ath12k_soc_dp_tx_err_stats tx_err;
 };
 
+/* Holds info on the group of devices that are registered as a single
+ * wiphy, protected with struct ath12k_hw_group::mutex.
+ */
+struct ath12k_hw_group {
+	struct list_head list;
+	u8 id;
+	u8 num_devices;
+	u8 num_probed;
+	struct ath12k_base *ab[ATH12K_MAX_SOCS];
+
+	/* protects access to this struct */
+	struct mutex mutex;
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath12k_base {
 	enum ath12k_hw_rev hw_rev;
@@ -1005,6 +1019,8 @@ struct ath12k_base {
 
 	struct notifier_block panic_nb;
 
+	struct ath12k_hw_group *ag;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -1035,6 +1051,7 @@ int ath12k_core_resume_early(struct ath12k_base *ab);
 int ath12k_core_resume(struct ath12k_base *ab);
 int ath12k_core_suspend(struct ath12k_base *ab);
 int ath12k_core_suspend_late(struct ath12k_base *ab);
+void ath12k_core_hw_group_unassign(struct ath12k_base *ab);
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 8dbc7377ae7c..06cff3849ab8 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1725,6 +1725,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
 		ath12k_pci_power_down(ab, false);
 		ath12k_qmi_deinit_service(ab);
+		ath12k_core_hw_group_unassign(ab);
 		goto qmi_fail;
 	}
 
-- 
2.39.5


