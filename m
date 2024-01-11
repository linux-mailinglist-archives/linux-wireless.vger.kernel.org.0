Return-Path: <linux-wireless+bounces-1690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569082A70E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 05:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAF928821A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C305A46B1;
	Thu, 11 Jan 2024 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nM8kgPnq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004384693
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 04:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B4auf9029420;
	Thu, 11 Jan 2024 04:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=XY1d2kprwokibz0b05Vh
	K9Iy2pGc+FmGisUxCcIZ4oE=; b=nM8kgPnqmYpTRRwxkyVF+Z10alMuLuw1itTL
	92eSKwWN4VW6HZvpv/1gphJXdrW/j4KoEJ2BYVgYoCMFS+NGzRziLj1KnwrwtpOg
	/mVkfvvSOV2rTHFyl70iO6wobfSKPXFuw+XCzTKAUiP5D3Sa+bGJPe9iaZW3uMid
	DE8MJT4Q4TKi6dvImfTMAQJq9ndrGRliEbJaoOJce0puGUXjmuNIV3W7QLoL+XQe
	aJm9m5+8JQiZiTgpMH002ld+ehnt69VRT/OZJQ7OXrkoUK+V6ByRN1Jz/F1Lf+EI
	eFtg3SZXMeZuKDe7PLxZn6y+BFWTTuSPQ2pVGZZ+t5fU78OC4w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhuak1vge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B4pR2Z017319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:27 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 20:51:26 -0800
From: Sriram R <quic_srirrama@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 04/12] wifi: ath12k: vdev statemachine changes for single wiphy
Date: Thu, 11 Jan 2024 10:20:37 +0530
Message-ID: <20240111045045.28377-5-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111045045.28377-1-quic_srirrama@quicinc.com>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -yKqPl_q4yww0IW2IoIQRLY1gwl28SNJ
X-Proofpoint-ORIG-GUID: -yKqPl_q4yww0IW2IoIQRLY1gwl28SNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110035

With single wiphy, multiple radios are combined into a single wiphy.
Since any channel can be assigned to a vif being brought up,
the vdev cannot be created during add_interface(). Hence defer the
vdev creation till channel assignment.

If only one radio is part of the wiphy, then the existing logic
is maintained, i.e vdevs are created during add interface and
started during channel assignment. This ensures no functional changes
to single pdev devices which has only one radio in the SoC.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   1 +
 drivers/net/wireless/ath/ath12k/hw.h   |   3 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 215 ++++++++++++++++++-------
 3 files changed, 157 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 69c926ba0e73..8c107565905b 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -249,6 +249,7 @@ struct ath12k_vif {
 		} ap;
 	} u;
 
+	bool is_created;
 	bool is_started;
 	bool is_up;
 	u32 aid;
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index fa8230def22b..aaf68b3e9304 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HW_H
@@ -67,6 +67,7 @@
 #define TARGET_DMA_BURST_SIZE		1
 #define TARGET_RX_BATCHMODE		1
 
+#define ATH12K_HW_DEFAULT_QUEUE		0
 #define ATH12K_HW_MAX_QUEUES		4
 #define ATH12K_QUEUE_LEN		4096
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7933d5993519..2dcd049009fe 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5633,66 +5633,25 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 	ath12k_mac_update_vif_offload(arvif);
 }
 
-static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif)
+static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar;
-	struct ath12k_base *ab;
+	struct ath12k_hw *ah = ar->ah;
+	struct ath12k_base *ab = ar->ab;
+	struct ieee80211_hw *hw = ah->hw;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
 	struct ath12k_wmi_peer_create_arg peer_param;
 	u32 param_id, param_value;
 	u16 nss;
 	int i;
-	int ret;
-	int bit;
-
-	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
+	int ret, vdev_id;
 
-	mutex_lock(&ah->conf_mutex);
-
-	ar = ath12k_ah_to_ar(ah, 0);
-	ab = ar->ab;
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (vif->type == NL80211_IFTYPE_AP &&
-	    ar->num_peers > (ar->max_num_peers - 1)) {
-		ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
-		ret = -ENOBUFS;
-		goto err;
-	}
-
-	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
-		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
-			    TARGET_NUM_VDEVS);
-		ret = -EBUSY;
-		goto err;
-	}
-
-	memset(arvif, 0, sizeof(*arvif));
+	lockdep_assert_held(&ah->conf_mutex);
+	lockdep_assert_held(&ar->conf_mutex);
 
 	arvif->ar = ar;
-	arvif->vif = vif;
-
-	INIT_LIST_HEAD(&arvif->list);
-
-	/* Should we initialize any worker to handle connection loss indication
-	 * from firmware in sta mode?
-	 */
-
-	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
-		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
-		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
-		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
-		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
-		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
-	}
-
-	bit = __ffs64(ab->free_vdev_map);
-
-	arvif->vdev_id = bit;
+	vdev_id = __ffs64(ab->free_vdev_map);
+	arvif->vdev_id = vdev_id;
 	arvif->vdev_subtype = WMI_VDEV_SUBTYPE_NONE;
 
 	switch (vif->type) {
@@ -5708,14 +5667,14 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		arvif->vdev_type = WMI_VDEV_TYPE_MONITOR;
-		ar->monitor_vdev_id = bit;
+		ar->monitor_vdev_id = vdev_id;
 		break;
 	default:
 		WARN_ON(1);
 		break;
 	}
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac add interface id %d type %d subtype %d map %llx\n",
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev create id %d type %d subtype %d map %llx\n",
 		   arvif->vdev_id, arvif->vdev_type, arvif->vdev_subtype,
 		   ab->free_vdev_map);
 
@@ -5733,6 +5692,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ar->num_created_vdevs++;
+	arvif->is_created = true;
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM created, vdev_id %d\n",
 		   vif->addr, arvif->vdev_id);
 	ar->allocated_vdev_map |= 1LL << arvif->vdev_id;
@@ -5833,9 +5793,6 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
 		ath12k_mac_monitor_vdev_create(ar);
 
-	mutex_unlock(&ar->conf_mutex);
-	mutex_unlock(&ah->conf_mutex);
-
 	return ret;
 
 err_peer_del:
@@ -5861,6 +5818,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 err_vdev_del:
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
+	arvif->is_created = false;
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_map |= 1LL << arvif->vdev_id;
 	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
@@ -5869,10 +5827,110 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 err:
+	arvif->ar = NULL;
+	return ret;
+}
+
+static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
+						    struct ieee80211_vif *vif,
+						    struct ieee80211_chanctx_conf *ctx)
+{
+	struct ath12k_hw *ah = hw->priv;
+	struct ath12k *ar;
+	struct ath12k_base *ab;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	u8 bit;
+	int ret;
+
+	lockdep_assert_held(&ah->conf_mutex);
+
+	if (arvif->ar) {
+		WARN_ON(!arvif->is_created);
+		goto out;
+	}
+
+	if (ah->num_radio == 1)
+		ar = ah->radio;
+	else if (ctx)
+		ar = ath12k_get_ar_by_ctx(hw, ctx);
+	else
+		return NULL;
+
+	if (!ar)
+		goto out;
+
+	ab = ar->ab;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (vif->type == NL80211_IFTYPE_AP &&
+	    ar->num_peers > (ar->max_num_peers - 1)) {
+		ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
+		ret = -ENOBUFS;
+		goto unlock;
+	}
+
+	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
+		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
+			    TARGET_NUM_VDEVS);
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = ath12k_mac_vdev_create(ar, vif);
+	if (ret) {
+		ath12k_warn(ab, "failed to create vdev %d ret %d", bit, ret);
+		goto unlock;
+	}
+
+	/* TODO If the vdev is created during channel assign and not during
+	 * add_interface(), Apply any parameters for the vdev which were received
+	 * after add_interface, corresponding to this vif.
+	 */
+
+unlock:
 	mutex_unlock(&ar->conf_mutex);
-	mutex_unlock(&ah->conf_mutex);
+out:
+	return arvif->ar;
+}
 
-	return ret;
+static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_hw *ah = hw->priv;
+	int i;
+
+	mutex_lock(&ah->conf_mutex);
+	memset(arvif, 0, sizeof(*arvif));
+
+	arvif->vif = vif;
+
+	INIT_LIST_HEAD(&arvif->list);
+
+	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
+		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
+		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
+		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
+	}
+
+	/* Allocate Default Queue now and reassign during actual vdev create */
+	vif->cab_queue = ATH12K_HW_DEFAULT_QUEUE;
+	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
+		vif->hw_queue[i] = ATH12K_HW_DEFAULT_QUEUE;
+
+	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
+
+	/* For single radio wiphy(i.e ah->num_radio is 1), create the vdev
+	 * during add_interface itself, for multi radio wiphy, defer the vdev
+	 * creation until channel_assign to determine the radio on which the
+	 * vdev needs to be created
+	 */
+	ath12k_mac_assign_vif_to_vdev(hw, vif, NULL);
+	mutex_unlock(&ah->conf_mutex);
+	return 0;
 }
 
 static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif)
@@ -5912,7 +5970,12 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	if (!arvif->is_created) {
+		mutex_unlock(&ah->conf_mutex);
+		return;
+	}
+
+	ar = arvif->ar;
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -5954,6 +6017,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
 	ar->num_created_vdevs--;
+	arvif->is_created = false;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
 		   vif->addr, arvif->vdev_id);
@@ -6684,7 +6748,17 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	/* For multi radio wiphy, the vdev was not created during add_interface
+	 * create now since we have a channel ctx now to assign to a specific ar/fw
+	 */
+	ar = ath12k_mac_assign_vif_to_vdev(hw, vif, ctx);
+
+	if (!ar) {
+		WARN_ON(1);
+		mutex_unlock(&ah->conf_mutex);
+		return -EINVAL;
+	}
+
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6768,8 +6842,19 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	int ret;
 
 	mutex_lock(&ah->conf_mutex);
+	/* The vif is expected to be attached to an ar's VDEV.
+	 * We leave the vif/vdev in this function as is
+	 * and not delete the vdev symmetric to assign_vif_chanctx()
+	 * the VDEV will be deleted and unassigned either during
+	 * remove_interface() or when there is a change in channel
+	 * that moves the vif to a new ar
+	 */
+	if (!arvif->is_created) {
+		mutex_unlock(&ah->conf_mutex);
+		return;
+	}
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = arvif->ar;
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6824,9 +6909,17 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 
+	ar = ath12k_get_ar_by_ctx(hw, vifs->old_ctx);
+	if (!ar)
+		return -EINVAL;
+
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	/* Switching channels across radio is not allowed */
+	if (ar != ath12k_get_ar_by_ctx(hw, vifs->new_ctx))
+		return -EINVAL;
+
+	mutex_lock(&ah->conf_mutex);
 
 	mutex_lock(&ar->conf_mutex);
 
-- 
2.17.1


