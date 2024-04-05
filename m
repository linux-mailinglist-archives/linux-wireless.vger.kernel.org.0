Return-Path: <linux-wireless+bounces-5922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E0489A527
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 21:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB3A1F22C27
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF444173345;
	Fri,  5 Apr 2024 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kwE8+qJ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07208174EC6
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346349; cv=none; b=VPiGxFxpbqae5fX/0cnguIC7hepWZ8xXYxP2c31Aqoo5jsDn0LUK5QCdts5V/yRIeLm1C2UoqKDGzLgftzPwry3eqUriiOqXEI8VLnF01VEVSzUtzG2ocmKuWbvTxi+akJ/ySQlXqEAQHsK7J1XsRIpP84JtqbvVQWzI5WOZw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346349; c=relaxed/simple;
	bh=a4iystIY54IjUCOygtpR1aBIUOI9Bxlz9PEdbePAg48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZVX0CdYflbblNQvvWR0glBl6ZH++wTfaRHmdM2fTKSD6cgJXLP66GE7ML528eQGTG+ZrYiWhqvrcrlBr3MrUnNMuuOtveY9V5Z6B93Wg8H5wXHPVRzPqmH78EHy5XPaveP3UO22Rr53+5cCQM2l1A20MCnhurAPcRlxQzRQ4tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kwE8+qJ4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435Iv29a018181;
	Fri, 5 Apr 2024 19:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=FlPDXNR/NwaV+9FAZo3EzpsGaUOe+QFq7RoMPpHeT7c=; b=kw
	E8+qJ4r2sdLrk7teJEVaZAEUNHIKydDAz654ggJzhm80yn80qSTr0MO2pkL9jYEJ
	xpq9Ppn/HpROH/j/7wjsmCzzJHIC/I4HijpqiU1gXp57+AFhkTPXXZI34cq4eevr
	xeiJ/k+3qEC6cIwPr3o6xcJLhrsabiAPE26Vn585a8i1SeQS+nQBE2I6VAbHxbHR
	3EY8xCD/Pdq+mv0mxgQ9C/R/dto0+9CsDRK74prAr0fuuMzHoFpDkO//n/ygVE3J
	hmy2AKOqA47b+WuWMO9i/K8uF7m+d+0OD5fSHC9BK08vWCaaggxFPwzegp0F6etv
	Bd0lzFxooGzCPEww5wqg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xahgt0y0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:45:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435JjhrP016622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:45:43 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:45:41 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v7 04/12] wifi: ath12k: vdev statemachine changes for single wiphy
Date: Sat, 6 Apr 2024 01:15:11 +0530
Message-ID: <20240405194519.1337906-5-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405194519.1337906-1-quic_ramess@quicinc.com>
References: <20240405194519.1337906-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S_2gYP1qF1tbG0tlrjMMwoHOJEPSfMDn
X-Proofpoint-ORIG-GUID: S_2gYP1qF1tbG0tlrjMMwoHOJEPSfMDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050138

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
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   1 +
 drivers/net/wireless/ath/ath12k/hw.h   |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 200 +++++++++++++++++--------
 3 files changed, 141 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d32b44a3439a..4dca82da1683 100644
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
index 87965980b938..e34c4f76c1ec 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -80,6 +80,7 @@
 #define TARGET_RX_PEER_METADATA_VER_V1A	2
 #define TARGET_RX_PEER_METADATA_VER_V1B	3
 
+#define ATH12K_HW_DEFAULT_QUEUE		0
 #define ATH12K_HW_MAX_QUEUES		4
 #define ATH12K_QUEUE_LEN		4096
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index acd7b07ee6bb..bd22d9d8f7d9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5781,64 +5781,24 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
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
+	int ret, vdev_id;
 
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
@@ -5862,7 +5822,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		arvif->vdev_type = WMI_VDEV_TYPE_MONITOR;
-		ar->monitor_vdev_id = bit;
+		ar->monitor_vdev_id = vdev_id;
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
 		arvif->vdev_type = WMI_VDEV_TYPE_STA;
@@ -5873,7 +5833,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 		break;
 	}
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac add interface id %d type %d subtype %d map %llx\n",
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev create id %d type %d subtype %d map %llx\n",
 		   arvif->vdev_id, arvif->vdev_type, arvif->vdev_subtype,
 		   ab->free_vdev_map);
 
@@ -5891,6 +5851,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ar->num_created_vdevs++;
+	arvif->is_created = true;
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM created, vdev_id %d\n",
 		   vif->addr, arvif->vdev_id);
 	ar->allocated_vdev_map |= 1LL << arvif->vdev_id;
@@ -5991,8 +5952,6 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
 		ath12k_mac_monitor_vdev_create(ar);
 
-	mutex_unlock(&ar->conf_mutex);
-
 	return ret;
 
 err_peer_del:
@@ -6018,6 +5977,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 err_vdev_del:
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
+	arvif->is_created = false;
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_map |= 1LL << arvif->vdev_id;
 	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
@@ -6026,9 +5986,101 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
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
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_hw *ah = hw->priv;
+	struct ath12k_base *ab;
+	struct ath12k *ar;
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
+		return NULL;
+
+	ab = ar->ab;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (vif->type == NL80211_IFTYPE_AP &&
+	    ar->num_peers > (ar->max_num_peers - 1)) {
+		ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
+		goto unlock;
+	}
+
+	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
+		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
+			    TARGET_NUM_VDEVS);
+		goto unlock;
+	}
+
+	ret = ath12k_mac_vdev_create(ar, vif);
+	if (ret) {
+		ath12k_warn(ab, "failed to create vdev %pM ret %d", vif->addr, ret);
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
@@ -6059,14 +6111,16 @@ static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif
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
@@ -6108,6 +6162,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
 	ar->num_created_vdevs--;
+	arvif->is_created = false;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
 		   vif->addr, arvif->vdev_id);
@@ -6760,14 +6815,21 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
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
@@ -6843,13 +6905,22 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
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
@@ -6901,13 +6972,20 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
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


