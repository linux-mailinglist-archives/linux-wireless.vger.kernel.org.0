Return-Path: <linux-wireless+bounces-14679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBCD9B50F4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 18:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7082C1C22C3D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9322F20A5E1;
	Tue, 29 Oct 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nd+No7Wc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE2209F5C;
	Tue, 29 Oct 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223102; cv=none; b=YIxz7nvLYrectOPhBn7cSmD1Yio/+CSwDuxZFozxWlGCYgVarT77DNJZ3MC7XKmkTq8z56Um3B1ZHr81Xgq7bnENkmCkv2MTq3TE9XiO3DB6Ylow63zxI04C3zdiK/DFzKDtr5cf+ZD/GANccKO0d6vSmkqA8iEcMcvrQMYpj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223102; c=relaxed/simple;
	bh=mLQ+TLAvaM4YrTLMKHG+Hs2KCbCz/kmO0agxJu+IMnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRzyGURYSceBNsPZ8I2iFUBkE8o++rmgP8aVSAU+kdeZYxNhwiO3/DlVheU5Et+4usIVZ+UqqdTKj2jwGx1sxpGaw3+hr+WiJ9fMDtBNfT8nh+OaUyXV03BlZK05Ak49B38ebBU0d+tIT4BbtBFmLBOeEqMvaXmObusPiEkaY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nd+No7Wc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T91x8K025437;
	Tue, 29 Oct 2024 17:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gqoCXZKM8qva/zeHoKoQD0B0r7y7M1nqa2ZEdcXkf1M=; b=Nd+No7WcxeIH9Ba+
	zOkwvvvHI68f22RtEtB013FAHzjUCwEJThsmyf3dpXmjosoUTS5gnk4wopfNNLji
	uPnxBzj4DVDQmEXD/IHxXwnUpsm5+5Kf1EmS8NPR+vIUWxEnubiasu7z4rdqDuBp
	p5C5M4SeH2cUmDa8jBkzDQ0GplRxUgtPHMrFaiyaoris7WsazhbSJExQOKIN2AbT
	5Iq71jLTHthZhEMTrn1Qt+9AIOv9leSHys+gWgQ/uDkPtxyjZtXkMYiQCwUJofHL
	g1b3zTQ050qhFea+dX2FooxXANODFr/xLBCpYmO+XtdtIfG86nNmQiWa0OEBGazA
	GqkhBQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8h7cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:31:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49THVYOO014400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:31:34 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Oct 2024 10:31:29 -0700
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
Subject: [RFC PATCH v2 2/5] wifi: ath12k: parse multiple device information from device tree
Date: Tue, 29 Oct 2024 23:00:47 +0530
Message-ID: <20241029173050.2188150-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
References: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: y_0fJK20BVlxY6NaDtJ3Uo952n0uLcvh
X-Proofpoint-ORIG-GUID: y_0fJK20BVlxY6NaDtJ3Uo952n0uLcvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290132

From: Harshitha Prem <quic_hprem@quicinc.com>

Currently, single device is part of device group abstraction but for multi
link operation, multiple devices have to be combined together. Information
of how many devices involved in grouping can be parsed from device tree and
it would have the valid group id information as well.

Add changes to parse devices involved and group id from device tree file
to form device group

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Co-developed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 154 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/core.h |   8 ++
 2 files changed, 151 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3f0f44cbdb4c..91950ee50bf3 100644
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
@@ -1403,6 +1404,7 @@ ath12k_core_hw_group_alloc(u8 id, u8 max_devices)
 	ag->num_devices = max_devices;
 	list_add(&ag->list, &ath12k_hw_group_list);
 	mutex_init(&ag->mutex_lock);
+	ag->mlo_capable = false;
 
 	return ag;
 }
@@ -1417,34 +1419,156 @@ static void ath12k_core_hw_group_free(struct ath12k_hw_group *ag)
 	mutex_unlock(&ath12k_ag_list_lock);
 }
 
+/* This function needs to be used only when dt has multi chip grouping information */
+static struct ath12k_hw_group *ath12k_core_hw_group_find_by_id(u8 group_id)
+{
+	struct ath12k_hw_group *ag;
+
+	/* group ids will be unique only for multi chip group */
+	list_for_each_entry(ag, &ath12k_hw_group_list, list) {
+		if (group_id == ag->id && ag->num_devices > 1)
+			return ag;
+	}
+
+	return NULL;
+}
+
+static int ath12k_core_get_wsi_info(struct ath12k_base *ab,
+				    struct ath12k_wsi_info *wsi_info)
+{
+	struct device_node *wsi_dev, *next_wsi_dev;
+	struct device_node *tx_endpoint, *next_rx_endpoint;
+	int device_count = 0, wsi_master_index = -1;
+
+	wsi_dev = of_get_child_by_name(ab->dev->of_node, "wsi");
+	if (!wsi_dev)
+		return -ENODEV;
+
+	if (of_property_read_u32(wsi_dev, "qcom,wsi-group-id",
+				 &wsi_info->group_id)) {
+		of_node_put(wsi_dev);
+		return -EINVAL;
+	}
+
+	next_wsi_dev = wsi_dev;
+
+	do {
+		if (of_property_read_bool(next_wsi_dev, "qcom,wsi-master"))
+			wsi_master_index = device_count;
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
+	if (wsi_master_index == -1) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "no WSI master defined in DT");
+		return -EINVAL;
+	}
+
+	wsi_info->num_devices = device_count;
+	wsi_info->index = (device_count - wsi_master_index) % device_count;
+	return 0;
+}
+
 static struct ath12k_hw_group *ath12k_core_assign_hw_group(struct ath12k_base *ab)
 {
 	struct ath12k_hw_group *ag;
-	u32 group_id = ATH12K_INVALID_GROUP_ID;
+	struct ath12k_wsi_info *wsi = &ab->wsi_info;
+	int ret;
 
 	lockdep_assert_held(&ath12k_ag_list_lock);
 
-	/* The grouping of multiple devices will be done based on device tree file.
-	 * TODO: device tree file parsing to know about the devices involved in group.
-	 *
-	 * The platforms that do not have any valid group information would have each
-	 * device to be part of its own invalid group.
+	/* The grouping of multiple devices will be done based on device
+	 * tree file.
 	 *
-	 * Currently, we are not parsing any device tree information and hence, grouping
-	 * of multiple devices is not involved. Thus, single device is added to device
-	 * group.
+	 * The platforms that do not have any valid group information would
+	 * have each device to be part of its own invalid group.
+	 */
+	ret = ath12k_core_get_wsi_info(ab, wsi);
+	if (ret) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+			   "unable to get complete WSI Info from DT, err = %d", ret);
+		wsi->group_id = ATH12K_INVALID_GROUP_ID;
+		wsi->num_devices = 1;
+		wsi->index = 0;
+		goto invalid_group;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT,
+		   "WSI info: group-id: %d, num-devices: %d, index: %d",
+		   wsi->group_id, wsi->num_devices, wsi->index);
+
+	/* Currently only one group of multiple devices are supported,
+	 * since we use group id ATH12K_INVALID_GROUP_ID for single
+	 * device group which didn't have dt entry, there could be many
+	 * groups with same group id, i.e ATH12K_INVALID_GROUP_ID. So
+	 * default group id of ATH12K_INVALID_GROUP_ID combined with
+	 * num devices in ath12k_hw_group determines if the group is
+	 * multi device or single device group
 	 */
-	ag = ath12k_core_hw_group_alloc(group_id, 1);
+	ag = ath12k_core_hw_group_find_by_id(wsi->group_id);
+	if (!ag) {
+		ag = ath12k_core_hw_group_alloc(wsi->group_id, wsi->num_devices);
+		if (!ag) {
+			ath12k_warn(ab, "unable to create new hw group\n");
+			return NULL;
+		}
+		goto exit;
+	} else if (test_bit(ATH12K_GROUP_FLAG_UNREGISTER, &ag->flags)) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "group id %d in unregister state\n",
+			   ag->id);
+		wsi->group_id = ATH12K_INVALID_GROUP_ID;
+		goto invalid_group;
+	} else {
+		goto exit;
+	}
+
+invalid_group:
+	ag = ath12k_core_hw_group_alloc(wsi->group_id, 1);
 	if (!ag) {
 		ath12k_warn(ab, "unable to create new hw group\n");
 		return NULL;
 	}
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "Single device is added to hardware group\n");
 
+exit:
+	if (ag->num_probed >= ag->num_devices) {
+		ath12k_warn(ab, "unable to add new device to group, max limit reached\n");
+		wsi->group_id = ATH12K_INVALID_GROUP_ID;
+		goto invalid_group;
+	}
+
 	ab->device_id = ag->num_probed++;
 	ag->ab[ab->device_id] = ab;
 	ab->ag = ag;
-	ag->mlo_capable = false;
 
 	return ag;
 }
@@ -1511,6 +1635,14 @@ static void ath12k_core_hw_group_cleanup(struct ath12k_hw_group *ag)
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
index cde35616ba56..6ade7a3cf6ff 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -211,6 +211,7 @@ enum ath12k_scan_state {
 
 enum ath12k_hw_group_flags {
 	ATH12K_GROUP_FLAG_REGISTERED,
+	ATH12K_GROUP_FLAG_UNREGISTER,
 };
 
 enum ath12k_dev_flags {
@@ -845,6 +846,12 @@ struct ath12k_hw_group {
 	bool mlo_capable;
 };
 
+struct ath12k_wsi_info {
+	u32 group_id;
+	u32 num_devices;
+	u32 index;
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath12k_base {
 	enum ath12k_hw_rev hw_rev;
@@ -1026,6 +1033,7 @@ struct ath12k_base {
 	struct notifier_block panic_nb;
 
 	struct ath12k_hw_group *ag;
+	struct ath12k_wsi_info wsi_info;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
-- 
2.34.1


