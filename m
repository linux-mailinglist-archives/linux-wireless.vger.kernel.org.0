Return-Path: <linux-wireless+bounces-3209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62784B108
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06DC1C227EF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4D12CDBA;
	Tue,  6 Feb 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eem3tXvZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5712D142
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211341; cv=none; b=MmaUYrb/NOmOVM/fKVfsanADK3YyyhTh0Sx+K/JXjMoMbFnEghNUta3M6eUf9qGKvly6uf6krNykcsxXBugCQiOiWYVMi0pR5FZ+39v8sVWQ1R5QKSHIw+wzYu5K0xhpKj3LALPmC/6V+SEAlOXZWk7R/DcX3KUU4mcSgujZkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211341; c=relaxed/simple;
	bh=ZzBywG5LGb1uPSPzBX+TBbIFsbKjteoePHJjoPT7z8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUCh4ujnmRVcZEJyhJug8eelKgYcdYWBIXV6QzxQrn9jyzOKoY3coI+oFqip6ps0mK3CZX8DXpR9i8TM9CCzwfdwOZ6sqKQywry9+XSybBXouvIeT+xqcnON/fxLsPrT5ZQTa1UfoucDAZcWGiJMqjn2aTwJjSe0+AL5Tl9fS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eem3tXvZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4168Njmj018057;
	Tue, 6 Feb 2024 09:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=n2llYDBXyI1O0OXkzVAZFC1jrSCRk33f7gZ84YTG4ss=; b=ee
	m3tXvZf93qz97xibSQD8dLoBjnXZQ07z3doFetEIA9p4XJ9KDDOVm+1N6RDOa5/u
	0z1dB5gtj/8/8VunqfQbEa+TNSqjtdWb1Ka7t90e1l6/BCa5xGIh/gc3M93940xF
	opzmiZu3y4cSesSJb2OlZDp3jtVm8eZNXAOgdTR7cTgS+DBeCWGFV8vksADiw8JZ
	YTpEWVBhdIZy6CQKPTWxFHEYkvMVX3aQN/jLD+Z3yrbhBAQilCU9CMuET5wmYyPQ
	DZrPfLTIQqsSyNckGDq62cR2Ryw+RhVV6mQVc8gUDQgGipp0IG4ctwlwP9XZs3Ak
	igtflTB8/am9T0e8Ogeg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3h7hr3st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 09:22:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4169LkI0020892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 09:21:46 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 01:21:44 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 05/12] wifi: ath12k: scan statemachine changes for single wiphy
Date: Tue, 6 Feb 2024 14:49:47 +0530
Message-ID: <20240206091954.4144454-6-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: DjWGXZXfWL0qxvs7hcKe5Z34U7Gc57p5
X-Proofpoint-ORIG-GUID: DjWGXZXfWL0qxvs7hcKe5Z34U7Gc57p5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060066

From: Sriram R <quic_srirrama@quicinc.com>

When multiple radios are advertised as a single wiphy which
supports various bands, a default scan request to mac80211
from cfg80211 will split the driver request based on band,
so each request will have channels belonging to the same band.
With this supported by default, the ath12k driver on receiving
this request checks for one of the channels in the request and
selects the corresponding radio(ar) on which the scan is going
to be performed and creates a vdev on that radio.

Note that on scan completion this vdev is not deleted. If a new
scan request is seen on that same vif for a different band the
vdev will be deleted and created on the new radio supporting the
request. The vdev delete logic is refactored to have this done
dynamically.

The reason for not deleting the vdev on scan stop is to avoid
repeated delete-create sequence if the scan is on the same band.
Also, during channel assign, new vdev creation can be optimized
as well.

Also if the scan is requested when the vdev is in started state,
no switching to new radio is allowed and scan on channels only
within same radio is allowed.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 213 +++++++++++++++++++++-----
 1 file changed, 178 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b723226c7577..e576c2447a85 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -244,6 +244,8 @@ static const u32 ath12k_smps_map[] = {
 static int ath12k_start_vdev_delay(struct ath12k *ar,
 				   struct ath12k_vif *arvif);
 static void ath12k_mac_stop(struct ath12k *ar);
+static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif);
+static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif);
 
 static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
 {
@@ -2839,6 +2841,45 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
+static struct ath12k*
+ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_scan_request *req)
+{
+	struct ath12k_hw *ah = hw->priv;
+	enum nl80211_band band;
+	struct ath12k *ar;
+	int i;
+
+	if (ah->num_radio == 1)
+		return ah->radio;
+
+	/* Currently mac80211 supports splitting scan requests into
+	 * multiple scan requests per band.
+	 * Loop through first channel and determine the scan radio
+	 * TODO: There could be 5 GHz low/high channels in that case
+	 * split the hw request and perform multiple scans
+	 */
+
+	if (req->req.channels[0]->center_freq < ATH12K_MIN_5G_FREQ)
+		band = NL80211_BAND_2GHZ;
+	else if (req->req.channels[0]->center_freq < ATH12K_MIN_6G_FREQ)
+		band = NL80211_BAND_5GHZ;
+	else
+		band = NL80211_BAND_6GHZ;
+
+	ar = ah->radio;
+
+	for (i = 0; i < ah->num_radio; i++) {
+		/* TODO 5 GHz low high split changes */
+		if (ar->mac.sbands[band].channels)
+			return ar;
+		ar++;
+	}
+
+	return NULL;
+}
+
 void __ath12k_mac_scan_finish(struct ath12k *ar)
 {
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
@@ -3008,15 +3049,68 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				 struct ieee80211_scan_request *hw_req)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar;
+	struct ath12k *ar, *prev_ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_scan_request *req = &hw_req->req;
 	struct ath12k_wmi_scan_req_arg arg = {};
 	int ret;
 	int i;
+	bool create = true;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	if (ah->num_radio == 1) {
+		WARN_ON(!arvif->is_created);
+		ar = ath12k_ah_to_ar(ah, 0);
+		goto scan;
+	}
+
+	/* Since the targeted scan device could depend on the frequency
+	 * requested in the hw_req, select the corresponding radio
+	 */
+	ar = ath12k_mac_select_scan_device(hw, vif, hw_req);
+	if (!ar)
+		return -EINVAL;
 
+	/* If the vif is already assigned to a specific vdev of an ar,
+	 * check whether its already started, vdev which is started
+	 * are not allowed to switch to a new radio.
+	 * If the vdev is not started, but was earlier created on a
+	 * different ar, delete that vdev and create a new one. We don't
+	 * delete at the scan stop as an optimization to avoid reduntant
+	 * delete-create vdev's for the same ar, in case the request is
+	 * always on the same band for the vif
+	 */
+	if (arvif->is_created) {
+		if (WARN_ON(!arvif->ar))
+			return -EINVAL;
+
+		if (ar != arvif->ar && arvif->is_started)
+			return -EINVAL;
+
+		if (ar != arvif->ar) {
+			/* backup the previously used ar ptr, since the vdev delete
+			 * would assign the arvif->ar to NULL after the call
+			 */
+			prev_ar = arvif->ar;
+			mutex_lock(&prev_ar->conf_mutex);
+			ret = ath12k_mac_vdev_delete(prev_ar, vif);
+			mutex_unlock(&prev_ar->conf_mutex);
+			if (ret)
+				ath12k_warn(prev_ar->ab,
+					    "unable to delete scan vdev %d\n", ret);
+		} else {
+			create = false;
+		}
+	}
+	if (create) {
+		mutex_lock(&ar->conf_mutex);
+		ret = ath12k_mac_vdev_create(ar, vif);
+		mutex_unlock(&ar->conf_mutex);
+		if (ret) {
+			ath12k_warn(ar->ab, "unable to create scan vdev %d\n", ret);
+			return -EINVAL;
+		}
+	}
+scan:
 	mutex_lock(&ar->conf_mutex);
 
 	spin_lock_bh(&ar->data_lock);
@@ -3102,10 +3196,13 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	if (!arvif->is_created)
+		return;
+
+	ar = arvif->ar;
 
 	mutex_lock(&ar->conf_mutex);
 	ath12k_scan_abort(ar);
@@ -5768,6 +5865,7 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
 		ath12k_mac_monitor_vdev_create(ar);
 
+	arvif->ar = ar;
 	return ret;
 
 err_peer_del:
@@ -5794,6 +5892,7 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
 	arvif->is_created = false;
+	arvif->ar = NULL;
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_map |= 1LL << arvif->vdev_id;
 	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
@@ -5811,14 +5910,46 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 						    struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath12k_hw *ah = hw->priv;
-	struct ath12k *ar;
+	struct ath12k *ar, *prev_ar;
 	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	u8 bit;
 	int ret;
 
 	if (arvif->ar) {
-		WARN_ON(!arvif->is_created);
+		/* This is not expected really */
+		if (WARN_ON(!arvif->is_created)) {
+			arvif->ar = NULL;
+			return NULL;
+		}
+
+		if (ah->num_radio == 1)
+			goto out;
+
+		ar = ath12k_get_ar_by_ctx(hw, ctx);
+		/* This can happen as scan vdev gets created during multiple scans
+		 * across different radios before a vdev is brought up in
+		 * a certain radio
+		 */
+		if (ar != arvif->ar) {
+			if (WARN_ON(arvif->is_started))
+				return NULL;
+
+			/* backup the previously used ar ptr since arvif->ar would
+			 * be set to NULL after vdev delete is done
+			 */
+			prev_ar = arvif->ar;
+			mutex_lock(&prev_ar->conf_mutex);
+			ret = ath12k_mac_vdev_delete(prev_ar, vif);
+
+			if (ret)
+				ath12k_warn(prev_ar->ab, "unable to delete vdev %d\n", ret);
+			mutex_unlock(&prev_ar->conf_mutex);
+			ret = ath12k_mac_vdev_create(ar, vif);
+			if (ret)
+				ath12k_warn(ar->ab, "unable to create vdev %d\n", ret);
+			mutex_unlock(&ar->conf_mutex);
+		}
 		goto out;
 	}
 
@@ -5927,38 +6058,19 @@ static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif
 	}
 }
 
-static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif)
+static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 {
-	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
-	struct ath12k_base *ab;
+	struct ath12k_base *ab = ar->ab;
 	unsigned long time_left;
 	int ret;
 
-	if (!arvif->is_created)
-		return;
-
-	ar = arvif->ar;
-	ab = ar->ab;
-
-	mutex_lock(&ar->conf_mutex);
-
-	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
-		   arvif->vdev_id);
-
-	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
-		ret = ath12k_peer_delete(ar, arvif->vdev_id, vif->addr);
-		if (ret)
-			ath12k_warn(ab, "failed to submit AP self-peer removal on vdev %d: %d\n",
-				    arvif->vdev_id, ret);
-	}
-
+	lockdep_assert_held(&ar->conf_mutex);
 	reinit_completion(&ar->vdev_delete_done);
 
 	ret = ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	if (ret) {
-		ath12k_warn(ab, "failed to delete WMI vdev %d: %d\n",
+		ath12k_warn(ab, "failed to delete WMI scan vdev %d: %d\n",
 			    arvif->vdev_id, ret);
 		goto err_vdev_del;
 	}
@@ -5970,6 +6082,10 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 		goto err_vdev_del;
 	}
 
+	ab->free_vdev_map |= 1LL << arvif->vdev_id;
+	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
+	ar->num_created_vdevs--;
+
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ar->monitor_vdev_id = -1;
 		ar->monitor_vdev_created = false;
@@ -5977,12 +6093,6 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 		ret = ath12k_mac_monitor_vdev_delete(ar);
 	}
 
-	ab->free_vdev_map |= 1LL << (arvif->vdev_id);
-	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
-	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
-	ar->num_created_vdevs--;
-	arvif->is_created = false;
-
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
 		   vif->addr, arvif->vdev_id);
 
@@ -6004,6 +6114,39 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	clear_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
 
 	/* TODO: recal traffic pause state based on the available vdevs */
+	arvif->is_created = false;
+	arvif->ar = NULL;
+
+	return ret;
+}
+
+static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct ath12k *ar;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_base *ab;
+	int ret;
+
+	if (!arvif->is_created)
+		return;
+
+	ar = arvif->ar;
+	ab = ar->ab;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
+		   arvif->vdev_id);
+
+	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
+		ret = ath12k_peer_delete(ar, arvif->vdev_id, vif->addr);
+		if (ret)
+			ath12k_warn(ab, "failed to submit AP self-peer removal on vdev %d: %d\n",
+				    arvif->vdev_id, ret);
+	}
+
+	ath12k_mac_vdev_delete(ar, vif);
 
 	mutex_unlock(&ar->conf_mutex);
 }
-- 
2.25.1


