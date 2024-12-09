Return-Path: <linux-wireless+bounces-16063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E3A9E9A8C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7FB162420
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B831E9B34;
	Mon,  9 Dec 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvpPDm1Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A461E9B32;
	Mon,  9 Dec 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758241; cv=none; b=RKfitI4W+M+Jmf2HDCMuW4K0vY6Uqk1S9cW4j5wiR5ruBivxfxcw8u53yrYfJN4YgH1dt7q9uXlPoA9uPvgOrLYaNUGG4VZit/OhVF+SqtavpA7nq4z/t7ZiWaxmwq8bdQ2k/uSQOqr7CJGGCQA6rWaeCcqxBe138oxfvpUStHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758241; c=relaxed/simple;
	bh=4Q8+H2y5FnU0Zo2LpMai5VHA+mQYFkZLKUDC/zyQpog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h16mP25/drcbUJLBrctml55Xj8Y7C+aRSsm6aN23QPs/76MHdFLUxoAkZv8tMYG4yfLcfqzrWc/uMYxzosUVQ2d5yeB6tuIh4lzIkB4WUB3kwd2AE1/I9cWIjtVI0BDOcekRNwd0i7mUbQNWRWzx9AJjchfHFqYpFpojSh42n7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvpPDm1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1C4C4CEDE;
	Mon,  9 Dec 2024 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733758240;
	bh=4Q8+H2y5FnU0Zo2LpMai5VHA+mQYFkZLKUDC/zyQpog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvpPDm1YgW0+a0V2RpNlJ9oM6d9ELnOU1/TnNM3o3N05X898KzGMklyBUQRz+mxor
	 5IRc4fMzIO5JwcR4Im5P/3uKhiKrdy6zbqUV2qFqae7+V9O/nCoxDkdnXgAMRXKwyQ
	 rz9k/cc1LKrI2/BU673XoVWc7X6SZcWgjivbuOJ926ZIYAz9CTiOSDnBxHVvBtAAbJ
	 01BWaJybt6Gd1Kcf2FgR3bDadZ/sZY3964SL4SEplWC0wddQZTLjmDC8+/HrEZ5Yrp
	 RM4tNlNVLXnavOr2Vgy/7yCwtFfUV3L+IpOv+fo7+lwSUGpjHTznihY+bJRW09wuV4
	 mFuupiEGdiBtA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/8] wifi: ath12k: parse multiple device information from Device Tree
Date: Mon,  9 Dec 2024 17:30:28 +0200
Message-Id: <20241209153034.50558-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209153034.50558-1-kvalo@kernel.org>
References: <20241209153034.50558-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Currently, a single device is part of the device group abstraction. However,
for multi-link operations, multiple devices need to be combined. This
multi-device grouping is done via WSI (WLAN Serial Interface), which is
described in the Device Tree. Information about different WSI groups and the
number of devices involved in each group can be parsed from the Device Tree.

Add changes to parse the Device Tree and determine WSI information, such as the
different WSI groups and the number of devices per WSI group. Assign WSI index
zero to the WSI controller device (to synchronize the clock among the devices
within the WSI group), and increment the WSI index of each device in the order
of the WSI connection.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 183 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/core.h |   8 ++
 2 files changed, 178 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 49d1ac15cb7a..1a43e00cffb2 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -9,6 +9,7 @@
 #include <linux/remoteproc.h>
 #include <linux/firmware.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include "core.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
@@ -1383,20 +1384,24 @@ bool ath12k_core_hw_group_create_ready(struct ath12k_hw_group *ag)
 	return (ag->num_probed == ag->num_devices);
 }
 
-static struct ath12k_hw_group *ath12k_core_hw_group_alloc(u8 id, u8 max_devices)
+static struct ath12k_hw_group *ath12k_core_hw_group_alloc(struct ath12k_base *ab)
 {
 	struct ath12k_hw_group *ag;
+	int count = 0;
 
 	lockdep_assert_held(&ath12k_hw_group_mutex);
 
+	list_for_each_entry(ag, &ath12k_hw_group_list, list)
+		count++;
+
 	ag = kzalloc(sizeof(*ag), GFP_KERNEL);
 	if (!ag)
 		return NULL;
 
-	ag->id = id;
-	ag->num_devices = max_devices;
+	ag->id = count;
 	list_add(&ag->list, &ath12k_hw_group_list);
 	mutex_init(&ag->mutex);
+	ag->mlo_capable = false;
 
 	return ag;
 }
@@ -1411,35 +1416,180 @@ static void ath12k_core_hw_group_free(struct ath12k_hw_group *ag)
 	mutex_unlock(&ath12k_hw_group_mutex);
 }
 
+static struct ath12k_hw_group *ath12k_core_hw_group_find_by_dt(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag;
+	int i;
+
+	if (!ab->dev->of_node)
+		return NULL;
+
+	list_for_each_entry(ag, &ath12k_hw_group_list, list)
+		for (i = 0; i < ag->num_devices; i++)
+			if (ag->wsi_node[i] == ab->dev->of_node)
+				return ag;
+
+	return NULL;
+}
+
+static int ath12k_core_get_wsi_info(struct ath12k_hw_group *ag,
+				    struct ath12k_base *ab)
+{
+	struct device_node *wsi_dev = ab->dev->of_node, *next_wsi_dev;
+	struct device_node *tx_endpoint, *next_rx_endpoint;
+	int device_count = 0;
+
+	next_wsi_dev = wsi_dev;
+
+	if (!next_wsi_dev)
+		return -ENODEV;
+
+	do {
+		ag->wsi_node[device_count] = next_wsi_dev;
+
+		tx_endpoint = of_graph_get_endpoint_by_regs(next_wsi_dev, 0, -1);
+		if (!tx_endpoint) {
+			of_node_put(next_wsi_dev);
+			return -ENODEV;
+		}
+
+		next_rx_endpoint = of_graph_get_remote_endpoint(tx_endpoint);
+		if (!next_rx_endpoint) {
+			of_node_put(next_wsi_dev);
+			of_node_put(tx_endpoint);
+			return -ENODEV;
+		}
+
+		of_node_put(tx_endpoint);
+		of_node_put(next_wsi_dev);
+
+		next_wsi_dev = of_graph_get_port_parent(next_rx_endpoint);
+		if (!next_wsi_dev) {
+			of_node_put(next_rx_endpoint);
+			return -ENODEV;
+		}
+
+		of_node_put(next_rx_endpoint);
+
+		device_count++;
+		if (device_count > ATH12K_MAX_SOCS) {
+			ath12k_warn(ab, "device count in DT %d is more than limit %d\n",
+				    device_count, ATH12K_MAX_SOCS);
+			of_node_put(next_wsi_dev);
+			return -EINVAL;
+		}
+	} while (wsi_dev != next_wsi_dev);
+
+	of_node_put(next_wsi_dev);
+	ag->num_devices = device_count;
+
+	return 0;
+}
+
+static int ath12k_core_get_wsi_index(struct ath12k_hw_group *ag,
+				     struct ath12k_base *ab)
+{
+	int i, wsi_controller_index = -1, node_index = -1;
+	bool control;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		control = of_property_read_bool(ag->wsi_node[i], "qcom,wsi-controller");
+		if (control)
+			wsi_controller_index = i;
+
+		if (ag->wsi_node[i] == ab->dev->of_node)
+			node_index = i;
+	}
+
+	if (wsi_controller_index == -1) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "wsi controller is not defined in dt");
+		return -EINVAL;
+	}
+
+	if (node_index == -1) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "unable to get WSI node index");
+		return -EINVAL;
+	}
+
+	ab->wsi_info.index = (ag->num_devices + node_index - wsi_controller_index) %
+		ag->num_devices;
+
+	return 0;
+}
+
 static struct ath12k_hw_group *ath12k_core_hw_group_assign(struct ath12k_base *ab)
 {
-	u32 group_id = ATH12K_INVALID_GROUP_ID;
+	struct ath12k_wsi_info *wsi = &ab->wsi_info;
 	struct ath12k_hw_group *ag;
 
 	lockdep_assert_held(&ath12k_hw_group_mutex);
 
 	/* The grouping of multiple devices will be done based on device tree file.
-	 * TODO: device tree file parsing to know about the devices involved in group.
+	 * The platforms that do not have any valid group information would have
+	 * each device to be part of its own invalid group.
 	 *
-	 * The platforms that do not have any valid group information would have each
-	 * device to be part of its own invalid group.
-	 *
-	 * Currently, we are not parsing any device tree information and hence, grouping
-	 * of multiple devices is not involved. Thus, single device is added to device
-	 * group.
+	 * We use group id ATH12K_INVALID_GROUP_ID for single device group
+	 * which didn't have dt entry or wrong dt entry, there could be many
+	 * groups with same group id, i.e ATH12K_INVALID_GROUP_ID. So
+	 * default group id of ATH12K_INVALID_GROUP_ID combined with
+	 * num devices in ath12k_hw_group determines if the group is
+	 * multi device or single device group
 	 */
-	ag = ath12k_core_hw_group_alloc(group_id, 1);
+
+	ag = ath12k_core_hw_group_find_by_dt(ab);
+	if (!ag) {
+		ag = ath12k_core_hw_group_alloc(ab);
+		if (!ag) {
+			ath12k_warn(ab, "unable to create new hw group\n");
+			return NULL;
+		}
+
+		if (ath12k_core_get_wsi_info(ag, ab) ||
+		    ath12k_core_get_wsi_index(ag, ab)) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "unable to get wsi info from dt, grouping single device");
+			ag->id = ATH12K_INVALID_GROUP_ID;
+			ag->num_devices = 1;
+			memset(ag->wsi_node, 0, sizeof(ag->wsi_node));
+			wsi->index = 0;
+		}
+
+		goto exit;
+	} else if (test_bit(ATH12K_GROUP_FLAG_UNREGISTER, &ag->flags)) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "group id %d in unregister state\n",
+			   ag->id);
+		goto invalid_group;
+	} else {
+		if (ath12k_core_get_wsi_index(ag, ab))
+			goto invalid_group;
+		goto exit;
+	}
+
+invalid_group:
+	ag = ath12k_core_hw_group_alloc(ab);
 	if (!ag) {
 		ath12k_warn(ab, "unable to create new hw group\n");
 		return NULL;
 	}
 
+	ag->id = ATH12K_INVALID_GROUP_ID;
+	ag->num_devices = 1;
+	wsi->index = 0;
+
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "single device added to hardware group\n");
 
+exit:
+	if (ag->num_probed >= ag->num_devices) {
+		ath12k_warn(ab, "unable to add new device to group, max limit reached\n");
+		goto invalid_group;
+	}
+
 	ab->device_id = ag->num_probed++;
 	ag->ab[ab->device_id] = ab;
 	ab->ag = ag;
-	ag->mlo_capable = false;
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "wsi group-id %d num-devices %d index %d",
+		   ag->id, ag->num_devices, wsi->index);
 
 	return ag;
 }
@@ -1507,6 +1657,13 @@ static void ath12k_core_hw_group_cleanup(struct ath12k_hw_group *ag)
 
 	mutex_lock(&ag->mutex);
 
+	if (test_bit(ATH12K_GROUP_FLAG_UNREGISTER, &ag->flags)) {
+		mutex_unlock(&ag->mutex);
+		return;
+	}
+
+	set_bit(ATH12K_GROUP_FLAG_UNREGISTER, &ag->flags);
+
 	ath12k_core_hw_group_stop(ag);
 
 	for (i = 0; i < ag->num_devices; i++) {
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 458e3d0071a8..d0e466819036 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -219,6 +219,7 @@ enum ath12k_scan_state {
 
 enum ath12k_hw_group_flags {
 	ATH12K_GROUP_FLAG_REGISTERED,
+	ATH12K_GROUP_FLAG_UNREGISTER,
 };
 
 enum ath12k_dev_flags {
@@ -845,6 +846,12 @@ struct ath12k_hw_group {
 	struct ath12k_hw *ah[ATH12K_GROUP_MAX_RADIO];
 	u8 num_hw;
 	bool mlo_capable;
+	struct device_node *wsi_node[ATH12K_MAX_SOCS];
+};
+
+/* Holds WSI info specific to each device, excluding WSI group info */
+struct ath12k_wsi_info {
+	u32 index;
 };
 
 /* Master structure to hold the hw data which may be used in core module */
@@ -1028,6 +1035,7 @@ struct ath12k_base {
 	struct notifier_block panic_nb;
 
 	struct ath12k_hw_group *ag;
+	struct ath12k_wsi_info wsi_info;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
-- 
2.39.5


