Return-Path: <linux-wireless+bounces-7951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8B98CBE9E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAFC1C21157
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE981751;
	Wed, 22 May 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="izIwOvW3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C581ABF
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371725; cv=none; b=M0nQSSkvUpLhZw1SRy4NK6hxcgrgj4aFYzbZCYOtYqXuoKx7wpiryZTm8fuSJopPbZF9yacd63nbSoLIa32apEqOX3wG9P4podQcu3PDjiO2R7mjQxi/QRg+GwCkhSbjwYXfupW2D85oghddxx8TsYHKwzHSgF+lmCWnNuHVyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371725; c=relaxed/simple;
	bh=95JxtwVCOBjn2YmHCV46mv2EI7/460fiWIgFHSTm0nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJmvQ7X0aiTaG+w6DrIpDFCSbFICt+Cw2rRCtBlvwoWWmFhDYYooNgAn5uOWVqpBg/qVaFu6/eeloduxYhAY3rb1L+Ut5EFk8IbwCy11S5JZp1sU9UeYAWAl6qFbZX223RTSVUYoVMErnDXAFxQ9B585g/SzutIxW67OavUP3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=izIwOvW3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M50PPI005035;
	Wed, 22 May 2024 09:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=XKkYY+f
	xG0JFx6qzdH8OY27raY2dKZT7t1X6YeLzNuk=; b=izIwOvW3mH22a65hFN2jhKZ
	4+u7b2U5UMn4hhwMjx0DSpz56xXZ4c5PFq1FjCHkes4MON30+WwGsHQN70NozFR9
	aG0zywBIcok6fxotiJpwODkuuhOACQsmA2S8MGBkt61WFxi4YJdlj4osm7Xns2M2
	q0CTzENV/iymKSpUOYjMs3oMXolSBeh+oYGmFdhwgewAeSr+jhvclBKasGmPpAP6
	tOwmvnNc3NXb5pTddXjs9+AymWLBlVOBhlIv08Qvl1QTaZmKmFwSqv/7bhR7VyP9
	46dnpuOHFry2NNPE3hz2En4ZZxPn1luTnCXJ+4BKI4dmRJmI6WMlY/hqGfwnCiQ=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pr2rh0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:55:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44M9o6Ac020639;
	Wed, 22 May 2024 09:55:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3y6ndkfpvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:55:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44M9tEuV024937;
	Wed, 22 May 2024 09:55:17 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44M9tHpZ024994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:55:17 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id A10F9410F2; Wed, 22 May 2024 15:25:16 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v5 6/8] wifi: ath12k: Introduce device group abstraction
Date: Wed, 22 May 2024 15:24:37 +0530
Message-Id: <20240522095439.2596989-7-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522095439.2596989-1-quic_hprem@quicinc.com>
References: <20240522095439.2596989-1-quic_hprem@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CNp099kLOBXqnDXZcL-sv5Ots36A4xDI
X-Proofpoint-GUID: CNp099kLOBXqnDXZcL-sv5Ots36A4xDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220070

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, single device is probed and once firmware is ready, the device
is registered to mac80211. For multi-link operation, different bands of
different devices or same device would be part of a single wiphy and for
this, hardware device group abstraction would be helpful.

Hardware device group abstraction - when there are multiple devices (with
single radio or dual radio) that are connected by any means of interface
for communicating between them, then these devices can be combined
together as a single group using a group id to form a group abstraction
and register to mac80211.

The grouping information of multiple devices would be based on device tree
during device probe. If no such information is available then a single
device will be part of group abstraction and registered to mac80211 else
multiple devices advertised in device tree are combined and then registered
to mac80211.

For device group abstraction, a base structure named ath12k_hw_group (ag)
and the following helpers are introduced:
        ath12k_core_hw_group_alloc()    : allocate ath12k_hw_group (ag)
                                          based on group id and number
                                          of devices that are going to
                                          be part of this group.
        ath12k_core_hw_group_free()     : free ag during deinit.
        ath12k_core_assign_hw_group()   : assign/map the details of group
                                          to ath12k_base (ab).
        ath12k_core_unassign_hw_group() : unassign/unmap the details of ag
                                          in ath12k_base (ab).
        ath12k_core_hw_group_create()   : create the devices which are part
                                          of group (ag).
        ath12k_core_hw_group_destroy()  : cleanup the devices in ag

These helpers are used during device probe and mapping the group to the
devices involved.

Please find the illustration of how multiple devices might be combined
together in future based on group id.

                Grouping of multiple devices (in future)

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

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 218 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/core.h |  19 +++
 drivers/net/wireless/ath/ath12k/pci.c  |   1 +
 3 files changed, 229 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 7ad65ace7123..ebe31cbb6435 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -21,6 +21,9 @@ unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
+static DEFINE_MUTEX(ath12k_hw_lock);
+static struct list_head ath12k_hw_groups = LIST_HEAD_INIT(ath12k_hw_groups);
+
 static int ath12k_core_rfkill_config(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
@@ -1185,20 +1188,111 @@ int ath12k_core_pre_init(struct ath12k_base *ab)
 	return 0;
 }
 
-int ath12k_core_init(struct ath12k_base *ab)
+static inline
+bool ath12k_core_hw_group_create_ready(struct ath12k_hw_group *ag)
 {
-	int ret;
+	lockdep_assert_held(&ag->mutex_lock);
 
-	ret = ath12k_core_soc_create(ab);
-	if (ret) {
-		ath12k_err(ab, "failed to create soc core: %d\n", ret);
-		return ret;
+	return (ag->num_probed == ag->num_devices);
+}
+
+static struct ath12k_hw_group *
+ath12k_core_hw_group_alloc(u8 id, u8 max_devices)
+{
+	struct ath12k_hw_group *ag;
+
+	lockdep_assert_held(&ath12k_hw_lock);
+
+	ag = kzalloc(sizeof(*ag), GFP_KERNEL);
+	if (!ag)
+		return NULL;
+
+	ag->id = id;
+	ag->num_devices = max_devices;
+	list_add(&ag->list, &ath12k_hw_groups);
+	mutex_init(&ag->mutex_lock);
+
+	return ag;
+}
+
+static void ath12k_core_hw_group_free(struct ath12k_hw_group *ag)
+{
+	mutex_lock(&ath12k_hw_lock);
+
+	list_del(&ag->list);
+	kfree(ag);
+
+	mutex_unlock(&ath12k_hw_lock);
+}
+
+static struct ath12k_hw_group *ath12k_core_assign_hw_group(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag;
+	u32 group_id = ATH12K_INVALID_GROUP_ID;
+
+	lockdep_assert_held(&ath12k_hw_lock);
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
 	}
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "Single device is added to hardware group\n");
 
-	return 0;
+	ab->device_id = ag->num_probed++;
+	ag->ab[ab->device_id] = ab;
+	ab->ag = ag;
+
+	return ag;
 }
 
-void ath12k_core_deinit(struct ath12k_base *ab)
+void ath12k_core_unassign_hw_group(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+	u8 device_id = ab->device_id;
+	int num_probed;
+
+	if (!ag)
+		return;
+
+	mutex_lock(&ag->mutex_lock);
+
+	if (WARN_ON(device_id >= ag->num_devices)) {
+		mutex_unlock(&ag->mutex_lock);
+		return;
+	}
+
+	if (WARN_ON(ag->ab[device_id] != ab)) {
+		mutex_unlock(&ag->mutex_lock);
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
+	mutex_unlock(&ag->mutex_lock);
+
+	if (!num_probed)
+		ath12k_core_hw_group_free(ag);
+}
+
+static void ath12k_core_device_cleanup(struct ath12k_base *ab)
 {
 	mutex_lock(&ab->core_lock);
 
@@ -1209,8 +1303,114 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 	ath12k_core_stop(ab);
 
 	mutex_unlock(&ab->core_lock);
+}
+
+static void ath12k_core_hw_group_destroy(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab;
+	int i;
 
-	ath12k_core_soc_destroy(ab);
+	if (WARN_ON(!ag))
+		return;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		if (test_and_clear_bit(ATH12K_FLAG_HW_GROUP_ATTACHED, &ab->dev_flags))
+			ath12k_core_soc_destroy(ab);
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
+	mutex_lock(&ag->mutex_lock);
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		if (test_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE, &ab->dev_flags))
+			ath12k_core_device_cleanup(ab);
+	}
+	mutex_unlock(&ag->mutex_lock);
+}
+
+static int ath12k_core_hw_group_create(struct ath12k_hw_group *ag)
+{
+	int i, ret;
+	struct ath12k_base *ab;
+
+	lockdep_assert_held(&ag->mutex_lock);
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		mutex_lock(&ab->core_lock);
+		ret = ath12k_core_soc_create(ab);
+		if (ret) {
+			mutex_unlock(&ab->core_lock);
+			ath12k_err(ab, "failed to create soc core: %d\n", ret);
+			return ret;
+		}
+		set_bit(ATH12K_FLAG_HW_GROUP_ATTACHED, &ab->dev_flags);
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
+	mutex_lock(&ath12k_hw_lock);
+	ag = ath12k_core_assign_hw_group(ab);
+	if (!ag) {
+		mutex_unlock(&ath12k_hw_lock);
+		ath12k_warn(ab, "unable to get hw group\n");
+		return -ENODEV;
+	}
+	mutex_unlock(&ath12k_hw_lock);
+
+	mutex_lock(&ag->mutex_lock);
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "num devices in group %d, num probed %d\n",
+		   ag->num_devices, ag->num_probed);
+
+	if (ath12k_core_hw_group_create_ready(ag)) {
+		ret = ath12k_core_hw_group_create(ag);
+		if (ret) {
+			mutex_unlock(&ag->mutex_lock);
+			ath12k_warn(ab, "unable to create hw group\n");
+			goto err_hw_group;
+		}
+	}
+	mutex_unlock(&ag->mutex_lock);
+
+	return 0;
+
+err_hw_group:
+	ath12k_core_hw_group_destroy(ab->ag);
+	ath12k_core_unassign_hw_group(ab);
+	return ret;
+}
+
+void ath12k_core_deinit(struct ath12k_base *ab)
+{
+	ath12k_core_hw_group_cleanup(ab->ag);
+	ath12k_core_hw_group_destroy(ab->ag);
+	ath12k_core_unassign_hw_group(ab);
 }
 
 void ath12k_core_free(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index bc2a9e1b1885..a6b8c100ebc8 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -59,6 +59,10 @@
 #define ATH12K_RECONFIGURE_TIMEOUT_HZ		(10 * HZ)
 #define ATH12K_RECOVER_START_TIMEOUT_HZ		(20 * HZ)
 
+#define ATH12K_MAX_SOCS 3
+#define ATH12K_INVALID_GROUP_ID  0xFF
+#define ATH12K_INVALID_DEVICE_ID 0xFF
+
 enum ath12k_bdf_search {
 	ATH12K_BDF_SEARCH_DEFAULT,
 	ATH12K_BDF_SEARCH_BUS_AND_BOARD,
@@ -209,6 +213,7 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_CE_IRQ_ENABLED,
 	ATH12K_FLAG_EXT_IRQ_ENABLED,
 	ATH12K_FLAG_QMI_FW_READY_COMPLETE,
+	ATH12K_FLAG_HW_GROUP_ATTACHED,
 };
 
 struct ath12k_tx_conf {
@@ -725,6 +730,17 @@ struct ath12k_soc_dp_stats {
 	struct ath12k_soc_dp_tx_err_stats tx_err;
 };
 
+/* Holds info on the group of devices that are registered as a single wiphy */
+struct ath12k_hw_group {
+	struct list_head list;
+	u8 id;
+	u8 num_devices;
+	u8 num_probed;
+	struct ath12k_base *ab[ATH12K_MAX_SOCS];
+	/* To synchronize group create, assign, start, stop */
+	struct mutex mutex_lock;
+};
+
 /**
  * enum ath12k_link_capable_flags - link capable flags
  *
@@ -925,6 +941,8 @@ struct ath12k_base {
 
 #endif /* CONFIG_ACPI */
 
+	struct ath12k_hw_group *ag;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -955,6 +973,7 @@ int ath12k_core_resume_early(struct ath12k_base *ab);
 int ath12k_core_resume(struct ath12k_base *ab);
 int ath12k_core_suspend(struct ath12k_base *ab);
 int ath12k_core_suspend_late(struct ath12k_base *ab);
+void ath12k_core_unassign_hw_group(struct ath12k_base *ab);
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 8f37f6efb8a2..82d6aedb0963 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1522,6 +1522,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
 		ath12k_pci_power_down(ab, false);
 		ath12k_qmi_deinit_service(ab);
+		ath12k_core_unassign_hw_group(ab);
 		goto qmi_fail;
 	}
 
-- 
2.34.1


