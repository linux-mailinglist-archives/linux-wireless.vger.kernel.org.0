Return-Path: <linux-wireless+bounces-14934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D428F9BD418
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 19:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED78B223A0
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F11E9082;
	Tue,  5 Nov 2024 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kYaoqOR3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D551E8857;
	Tue,  5 Nov 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829940; cv=none; b=rGJg0mmG1ieQu1vhlg5p8C0w1yc3lZXYBA1kLeYovPgG9lq9dh7Gk2COrzt06nh79V+28oLSXMOGrgS810ttD+V8bhUwWcVSmMXP6vhS5Mc8izQzK82EMA6m0bTBPnoGqPjDW0ByIj3MHHUCXlUB4eOzLpgSgZodHPoTt3Xp6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829940; c=relaxed/simple;
	bh=oz6d/jWJLZpE1WOmutrj1/O6ovWJPDRP+QZmmksxAC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kh27TLzb0N1ZzJup90sKtnRqNjIS2EIpfvHSbGFXdh89+B0nBkfxl3hvlOMmS7SQ43A9iKVmVeRlnrF5m8Q7q/nN3kArlQhjQgjtM+g2DnbNHXR0EzTR5misqj4J21YgTEsf8tVsfaZCH44BvT440VseeZSwVrLXUSUhENt3ZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kYaoqOR3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A59cDm0009331;
	Tue, 5 Nov 2024 18:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EDNJWPTCdrXeNEdrAJyKZXzGzAiq1Z4H2g2Bwj3ax98=; b=kYaoqOR3tRxTbstK
	w3MsUjwaQSF6UGhMTc95ZFiBWNUz/OV78FFPQIkyYrckMoz939f1KtK2brNXVBfH
	+nGdP+4uHzjOxU7eXit2rK4ZAqIhVQhDfiaHeGnGa+nvp91Khpt8qWkY3CUyPwoy
	CuzEG39iXm+OgNQg+uAPsonK7zAqTqyB/m2YMZYiSYJO3v2Q9Ufse6/VDaBSVsJv
	jQj0t2W0ooi+2tClLY0WEZ35ghyaeXZyKcRi8XqBRvyWOVhmFak/f3k2iSdhP9t4
	OtXW6LKCniEMkB6n0eIti9r8wYcufxD1Qp/dFwnsBV4QaAxaIpVnaEApNO6vKNsD
	moWTcA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4urmw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 18:05:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A5I5Ukm022917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 18:05:30 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 5 Nov 2024 10:05:26 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH v3 2/5] wifi: ath12k: Parse multiple device information from device tree
Date: Tue, 5 Nov 2024 23:34:41 +0530
Message-ID: <20241105180444.770951-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L9v7LEHckbNyi83G3d-Whk8vsPNU504D
X-Proofpoint-ORIG-GUID: L9v7LEHckbNyi83G3d-Whk8vsPNU504D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050139

From: Harshitha Prem <quic_hprem@quicinc.com>

Currently, a single device is part of the device group abstraction.
However, for multi-link operations, multiple devices need to be combined.
This multi-device grouping is done via WSI (WLAN Serial Interface), which
is described in the device tree. Information about different WSI groups
and the number of devices involved in each group can be parsed from the
device tree.

Add changes to parse the device tree and determine WSI information, such
as the different WSI groups and the number of devices per WSI group.
Assign WSI index zero to the WSI controller device (to synchronize the
clock among the devices within the WSI group), and increment the WSI index
of each device in the order of the WSI connection.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Co-developed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 178 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/core.h |   8 ++
 2 files changed, 173 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3f0f44cbdb4c..4170d7fcd438 100644
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
@@ -1389,20 +1390,24 @@ bool ath12k_core_hw_group_create_ready(struct ath12k_hw_group *ag)
 }
 
 static struct ath12k_hw_group *
-ath12k_core_hw_group_alloc(u8 id, u8 max_devices)
+ath12k_core_hw_group_alloc(struct ath12k_base *ab)
 {
 	struct ath12k_hw_group *ag;
+	int count = 0;
 
 	lockdep_assert_held(&ath12k_ag_list_lock);
 
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
 	mutex_init(&ag->mutex_lock);
+	ag->mlo_capable = false;
 
 	return ag;
 }
@@ -1417,34 +1422,173 @@ static void ath12k_core_hw_group_free(struct ath12k_hw_group *ag)
 	mutex_unlock(&ath12k_ag_list_lock);
 }
 
+static struct ath12k_hw_group *
+ath12k_core_hw_group_find_by_DT(struct ath12k_base *ab)
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
+		next_wsi_dev = of_graph_get_port_parent(next_rx_endpoint);
+		if (!next_wsi_dev) {
+			of_node_put(next_rx_endpoint);
+			return -ENODEV;
+		}
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
+
+	for (i = 0; i < ag->num_devices; i++) {
+		if (of_property_read_bool(ag->wsi_node[i], "qcom,wsi-controller"))
+			wsi_controller_index = i;
+		if (ag->wsi_node[i] == ab->dev->of_node)
+			node_index = i;
+	}
+
+	if (wsi_controller_index == -1) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "WSI controller is not defined in DT");
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
 static struct ath12k_hw_group *ath12k_core_assign_hw_group(struct ath12k_base *ab)
 {
 	struct ath12k_hw_group *ag;
-	u32 group_id = ATH12K_INVALID_GROUP_ID;
+	struct ath12k_wsi_info *wsi = &ab->wsi_info;
 
 	lockdep_assert_held(&ath12k_ag_list_lock);
 
 	/* The grouping of multiple devices will be done based on device tree file.
-	 * TODO: device tree file parsing to know about the devices involved in group.
-	 *
-	 * The platforms that do not have any valid group information would have each
-	 * device to be part of its own invalid group.
+	 * The platforms that do not have any valid group information would have
+	 * each device to be part of its own invalid group.
 	 *
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
+	ag = ath12k_core_hw_group_find_by_DT(ab);
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
+				   "unable to get WSI Info from DT, grouping single device");
+			ag->id = ATH12K_INVALID_GROUP_ID;
+			ag->num_devices = 1;
+			memset(ag->wsi_node, 0, sizeof(ag->wsi_node));
+			wsi->index = 0;
+		}
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
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "Single device is added to hardware group\n");
 
+exit:
+	if (ag->num_probed >= ag->num_devices) {
+		ath12k_warn(ab, "unable to add new device to group, max limit reached\n");
+		goto invalid_group;
+	}
 	ab->device_id = ag->num_probed++;
 	ag->ab[ab->device_id] = ab;
 	ab->ag = ag;
-	ag->mlo_capable = false;
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT,
+		   "WSI info: group-id: %d, num-devices: %d, index: %d",
+		   ag->id, ag->num_devices, wsi->index);
 
 	return ag;
 }
@@ -1511,6 +1655,14 @@ static void ath12k_core_hw_group_cleanup(struct ath12k_hw_group *ag)
 		return;
 
 	mutex_lock(&ag->mutex_lock);
+
+	if (test_bit(ATH12K_GROUP_FLAG_UNREGISTER, &ag->flags)) {
+		mutex_unlock(&ag->mutex_lock);
+		return;
+	}
+
+	set_bit(ATH12K_GROUP_FLAG_UNREGISTER, &ag->flags);
+
 	ath12k_core_hw_group_stop(ag);
 
 	for (i = 0; i < ag->num_devices; i++) {
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cde35616ba56..619407398a99 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -211,6 +211,7 @@ enum ath12k_scan_state {
 
 enum ath12k_hw_group_flags {
 	ATH12K_GROUP_FLAG_REGISTERED,
+	ATH12K_GROUP_FLAG_UNREGISTER,
 };
 
 enum ath12k_dev_flags {
@@ -843,6 +844,12 @@ struct ath12k_hw_group {
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
@@ -1026,6 +1033,7 @@ struct ath12k_base {
 	struct notifier_block panic_nb;
 
 	struct ath12k_hw_group *ag;
+	struct ath12k_wsi_info wsi_info;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
-- 
2.34.1


