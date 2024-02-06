Return-Path: <linux-wireless+bounces-3202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C363F84B101
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70061C22561
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044512E1C8;
	Tue,  6 Feb 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Btkj8Bos"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50012DDB4
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211316; cv=none; b=ZZ2tngl2geU6P3oGE6oCNSwIUdG4er2nrq4rwfgxMBSpMpC46MEDubu1duGBZPEg00HcKW8L+6roaKv9SOO0GOxyCcPldtb744KMVZnBfjv7qdDfEj8r3HRrkPid0Szi01fVxBHSFPUmnScTcJEtg6BpSqq+vXtULlaykHnMTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211316; c=relaxed/simple;
	bh=2XTK4GP5y5lI0BoBLxlwPJJ4g6BVTpOHMIcpmBl4qJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnloAWWKVwB3wPDHESMntKhoYYz2Evd3Jf+9mj6zd3drt63yOn0FGxwCqwBMGko3qI0RNu/C/XUc6RT+qFwLIwlbaJLo7XAA3uGZ606qAP5pWJ15XeHVgx1Saob4HZXrYYRyN52nLpaO2Ma5mabChvIDRcDqT/w/Bj5/dsnpGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Btkj8Bos; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41691rKd024302;
	Tue, 6 Feb 2024 09:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=snWRUMj0S9ERKf1RO1rGoae91W8s7cguuoEnnW9aAB8=; b=Bt
	kj8Bos2coiytyJdKJWS0xl1RGknEnh6p4xnQEJNI/XDS1tRkqaQOw2fIh7RdY9wX
	wM6Q5fb5RDVAX0JLe79vaq3f+AZec9QD8M5GD3i8yiGDKBbjrw2zYRdIAybY9vOa
	wp52ZDvK5GvaXT7j12gt5f7lY72/Tjj/3tQnXVQquzP0MaDhggNNy0XXsRGwmhhV
	JmHMxchvKxFmkwY1/qol5nuk6mDeVnuA1VLUQcONDNZ+IDZ75wznLWAOt5DhSRfz
	s/X1WpDqY7Tv2nSogYq8tNTk97IWBShVNOw6PbRyW8iemCVDT9qpnMXyly8uFNbV
	/3krGmF4AkeUKzwHAzcQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3hser1c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 09:21:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4169Liup020470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 09:21:44 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 01:21:42 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 04/12] wifi: ath12k: vdev statemachine changes for single wiphy
Date: Tue, 6 Feb 2024 14:49:46 +0530
Message-ID: <20240206091954.4144454-5-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206091954.4144454-1-quic_ramess@quicinc.com>
References: <20240206091954.4144454-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pFXfp1-a2WxkSdRhhj8R-agCzZPOCW_9
X-Proofpoint-GUID: pFXfp1-a2WxkSdRhhj8R-agCzZPOCW_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060065

From: Sriram R <quic_srirrama@quicinc.com>

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
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   1 +
 drivers/net/wireless/ath/ath12k/hw.h   |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 203 +++++++++++++++++--------
 3 files changed, 144 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 18269aa0264b..8088b797419d 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -251,6 +251,7 @@ struct ath12k_vif {
 		} ap;
 	} u;
 
+	bool is_created;
 	bool is_started;
 	bool is_up;
 	u32 aid;
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 2e9c3b05d75a..64d116ef8745 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -80,6 +80,7 @@
 #define TARGET_RX_PEER_METADATA_VER_V1A	2
 #define TARGET_RX_PEER_METADATA_VER_V1B	3
 
+#define ATH12K_HW_DEFAULT_QUEUE		0
 #define ATH12K_HW_MAX_QUEUES		4
 #define ATH12K_QUEUE_LEN		4096
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ef952e8e4086..b723226c7577 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5609,64 +5609,24 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
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
@@ -5682,14 +5642,14 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
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
 
@@ -5707,6 +5667,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ar->num_created_vdevs++;
+	arvif->is_created = true;
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM created, vdev_id %d\n",
 		   vif->addr, arvif->vdev_id);
 	ar->allocated_vdev_map |= 1LL << arvif->vdev_id;
@@ -5807,8 +5768,6 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
 		ath12k_mac_monitor_vdev_create(ar);
 
-	mutex_unlock(&ar->conf_mutex);
-
 	return ret;
 
 err_peer_del:
@@ -5834,6 +5793,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 err_vdev_del:
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
+	arvif->is_created = false;
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_map |= 1LL << arvif->vdev_id;
 	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
@@ -5842,9 +5802,104 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
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
+unlock:
 	mutex_unlock(&ar->conf_mutex);
+out:
+	return arvif->ar;
+}
 
-	return ret;
+static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	int i;
+
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
+	return 0;
 }
 
 static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif)
@@ -5875,14 +5930,16 @@ static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif
 static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_base *ab;
 	unsigned long time_left;
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	if (!arvif->is_created)
+		return;
+
+	ar = arvif->ar;
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -5924,6 +5981,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
 	ar->num_created_vdevs--;
+	arvif->is_created = false;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
 		   vif->addr, arvif->vdev_id);
@@ -6613,14 +6671,21 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_bss_conf *link_conf,
 				 struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 	struct ath12k_wmi_peer_create_arg param;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	/* For multi radio wiphy, the vdev was not created during add_interface
+	 * create now since we have a channel ctx now to assign to a specific ar/fw
+	 */
+	ar = ath12k_mac_assign_vif_to_vdev(hw, vif, ctx);
+	if (!ar) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6696,13 +6761,22 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				   struct ieee80211_bss_conf *link_conf,
 				   struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	/* The vif is expected to be attached to an ar's VDEV.
+	 * We leave the vif/vdev in this function as is
+	 * and not delete the vdev symmetric to assign_vif_chanctx()
+	 * the VDEV will be deleted and unassigned either during
+	 * remove_interface() or when there is a change in channel
+	 * that moves the vif to a new ar
+	 */
+	if (!arvif->is_created)
+		return;
+
+	ar = arvif->ar;
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -6752,13 +6826,20 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 				 int n_vifs,
 				 enum ieee80211_chanctx_switch_mode mode)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_ctx(hw, vifs->old_ctx);
+	if (!ar)
+		return -EINVAL;
 
 	mutex_lock(&ar->conf_mutex);
 
+	/* Switching channels across radio is not allowed */
+	if (ar != ath12k_get_ar_by_ctx(hw, vifs->new_ctx)) {
+		mutex_unlock(&ar->conf_mutex);
+		return -EINVAL;
+	}
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "mac chanctx switch n_vifs %d mode %d\n",
 		   n_vifs, mode);
-- 
2.25.1


