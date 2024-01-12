Return-Path: <linux-wireless+bounces-1772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0902482B9AC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFC31F21A26
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 02:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11014A14;
	Fri, 12 Jan 2024 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NxtCBFUG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9A46B7
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C1NjES007263;
	Fri, 12 Jan 2024 02:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=dbEG8MRBPz9eDNgHO3VQBThqlcADjLC+sbakQPIxjmQ=; b=Nx
	tCBFUGmTxAQgDhpa9hwUPzhbNG+47mSWKzBmwFJTeWVCBPnjaXGC0NuNBwLYzH57
	62l7WMYFch00Ac6YcOD6yy+l+ZhENHr9yjlhKHICnuMikb70h97twz0o9cn/r4zC
	C99YDiZbvGyB+xU+g7HFt+e763sOFXXiEh9kVZ9iGmBES0abx/CE68wDGEgYT483
	z+oHh9DwkdBm78I4TOKgqWRJ9XacaJGFSGna08O+0D9mjHcgeR1+BmaYMMHzNZai
	y0OnnQKdl1+ueWAKTu68Ep4UuoGDhfiHpZyElWN+jKd+MCCI48eFDmw+P/zN3Kyd
	HWbLA6nt6HPws9lLnL+Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjmkd1322-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:42:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C2gY7a019845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:42:34 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 18:42:32 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 2/2] wifi: ath12k: Introduce the container for mac80211 hw
Date: Fri, 12 Jan 2024 08:12:14 +0530
Message-ID: <20240112024214.3481840-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112024214.3481840-1-quic_periyasa@quicinc.com>
References: <20240112024214.3481840-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: df5_TlYoqXyQnttSvGA77UzqhWS-ClOf
X-Proofpoint-ORIG-GUID: df5_TlYoqXyQnttSvGA77UzqhWS-ClOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120018

To support multi link operation, we need to combine all the link/pdev
under a single wiphy. This avoids the overhead of synchronization
across multiple hardware instances in both the cfg80211 and mac80211
layers. Currently, each link/pdev is registered as separate wiphy,
tightly coupled with link/pdev/radio (ar) structure. To enable single
wiphy registration within the chip, we decouple the wiphy data entity from
the link/pdev/radio (ar) structure and move it under the chip (ab)
structure with a new data container (ath12k_hw) structure. This approach
improves scalability for future multi link operation support.

		mac80211 hw private data structure diagram
		------------------------------------------

	Now						After

 +---------------------+                          +---------------------+
 |mac80211 hw priv data|                          |mac80211 hw priv data|
 |                     |                          |                     |
 |                     |                          |                     |
 |                     |                          |                     |
 |                     |                          |   ath12k_hw (ah)    |
 |                     |                          |                     |
 |                     |  +------------------->   |                     |
 |    ath12k (ar)      |                          |   +-------------+   |
 |                     |                          |   |             |   |
 |                     |                          |   | ath12k (ar) |   |
 |                     |                          |   |             |   |
 |                     |                          |   |             |   |
 |                     |                          |   +-------------+   |
 |                     |                          |                     |
 |                     |                          |                     |
 +---------------------+                          +---------------------+

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 100 ++++--
 drivers/net/wireless/ath/ath12k/core.h |  43 ++-
 drivers/net/wireless/ath/ath12k/mac.c  | 437 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/mac.h  |  14 +-
 drivers/net/wireless/ath/ath12k/reg.c  |   3 +-
 5 files changed, 455 insertions(+), 142 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 4870c7672e9d..a85109b4e7a8 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -622,8 +622,7 @@ static void ath12k_core_soc_destroy(struct ath12k_base *ab)
 
 static int ath12k_core_mac_register(struct ath12k_base *ab)
 {
-	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
+	struct ath12k_hw *ah;
 	int i;
 	int ret;
 
@@ -634,22 +633,23 @@ static int ath12k_core_mac_register(struct ath12k_base *ab)
 	ab->cc_freq_hz = 320000;
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
+	for (i = 0; i < ab->num_hw; i++) {
+		ah = ab->ah[i];
 
-		ret = ath12k_mac_hw_register(ar);
+		ret = ath12k_mac_hw_register(ah);
 		if (ret)
-			goto err_cleanup;
+			goto err;
 	}
 
 	return 0;
 
-err_cleanup:
+err:
 	for (i = i - 1; i >= 0; i--) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		ath12k_mac_hw_unregister(ar);
+		ah = ab->ah[i];
+		if (!ah)
+			continue;
+
+		ath12k_mac_hw_unregister(ah);
 	}
 
 	return ret;
@@ -657,17 +657,15 @@ static int ath12k_core_mac_register(struct ath12k_base *ab)
 
 static void ath12k_core_mac_unregister(struct ath12k_base *ab)
 {
-	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
+	struct ath12k_hw *ah;
 	int i;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		if (!ar)
+	for (i = ab->num_hw - 1; i >= 0; i--) {
+		ah = ab->ah[i];
+		if (!ah)
 			continue;
 
-		ath12k_mac_hw_unregister(ar);
+		ath12k_mac_hw_unregister(ah);
 	}
 }
 
@@ -704,23 +702,69 @@ static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
 
 static void ath12k_core_mac_destroy(struct ath12k_base *ab)
 {
-	ath12k_mac_hw_destroy(ab);
+	struct ath12k_pdev *pdev;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		if (!pdev->ar)
+			continue;
+
+		pdev->ar = NULL;
+	}
+
+	for (i = 0; i < ab->num_hw; i++) {
+		if (!ab->ah[i])
+			continue;
+
+		ath12k_mac_hw_destroy(ab->ah[i]);
+		ab->ah[i] = NULL;
+	}
 }
 
 static int ath12k_core_mac_allocate(struct ath12k_base *ab)
 {
-	int ret;
+	struct ath12k_hw *ah;
+	struct ath12k_pdev_map pdev_map[MAX_RADIOS];
+	int ret, i, j;
+	u8 radio_per_hw;
 
 	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
 
-	ret = ath12k_mac_hw_allocate(ab);
-	if (ret)
-		return ret;
+	ab->num_hw = ab->num_radios;
+	radio_per_hw = 1;
+
+	for (i = 0; i < ab->num_hw; i++) {
+		for (j = 0; j < radio_per_hw; j++) {
+			pdev_map[j].ab = ab;
+			pdev_map[j].pdev_idx = (i * radio_per_hw) + j;
+		}
+
+		ah = ath12k_mac_hw_allocate(ab, pdev_map, radio_per_hw);
+		if (!ah) {
+			ath12k_warn(ab, "failed to allocate mac80211 hw device for hw_idx %d\n",
+				    i);
+			goto err;
+		}
+
+		ab->ah[i] = ah;
+	}
 
 	ath12k_dp_pdev_pre_alloc(ab);
 
 	return 0;
+
+err:
+	for (i = i - 1; i >= 0; i--) {
+		if (!ab->ah[i])
+			continue;
+
+		ath12k_mac_hw_destroy(ab->ah[i]);
+		ab->ah[i] = NULL;
+	}
+
+	return ret;
 }
 
 static int ath12k_core_start(struct ath12k_base *ab,
@@ -995,6 +1039,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
 	struct ath12k_pdev *pdev;
+	struct ath12k_hw *ah;
 	int i;
 
 	spin_lock_bh(&ab->base_lock);
@@ -1004,13 +1049,20 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 	if (ab->is_reset)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
+	for (i = 0; i < ab->num_hw; i++) {
+		if (!ab->ah[i])
+			continue;
+
+		ah = ab->ah[i];
+		ieee80211_stop_queues(ah->hw);
+	}
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 		if (!ar || ar->state == ATH12K_STATE_OFF)
 			continue;
 
-		ieee80211_stop_queues(ath12k_ar_to_hw(ar));
 		ath12k_mac_drain_tx(ar);
 		complete(&ar->scan.started);
 		complete(&ar->scan.completed);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 96295b0260e0..9d26481e8af5 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -474,7 +474,7 @@ struct ath12k_per_peer_tx_stats {
 struct ath12k {
 	struct ath12k_base *ab;
 	struct ath12k_pdev *pdev;
-	struct ieee80211_hw *hw;
+	struct ath12k_hw *ah;
 	struct ath12k_wmi_pdev *wmi;
 	struct ath12k_pdev_dp dp;
 	u8 mac_addr[ETH_ALEN];
@@ -538,6 +538,7 @@ struct ath12k {
 	/* pdev_idx starts from 0 whereas pdev->pdev_id starts with 1 */
 	u8 pdev_idx;
 	u8 lmac_id;
+	u8 hw_link_id;
 
 	struct completion peer_assoc_done;
 	struct completion peer_delete_done;
@@ -597,6 +598,18 @@ struct ath12k {
 	int monitor_vdev_id;
 };
 
+struct ath12k_hw {
+	struct ieee80211_hw *hw;
+
+	/* To synchronize concurrent synchronous mac80211 callback operations,
+	 * concurrent debugfs configuration and concurrent FW statistics events.
+	 */
+	struct mutex conf_mutex;
+
+	u8 num_radio;
+	struct ath12k radio[] __aligned(sizeof(void *));
+};
+
 struct ath12k_band_cap {
 	u32 phy_id;
 	u32 max_bw_supported;
@@ -730,6 +743,17 @@ struct ath12k_base {
 	u8 fw_pdev_count;
 
 	struct ath12k_pdev __rcu *pdevs_active[MAX_RADIOS];
+
+	/* Holds information of wiphy (hw) registration.
+	 *
+	 * In Multi/Single Link Operation case, all pdevs are registered as a
+	 * single wiphy.
+	 * In other (legacy/Non-MLO) cases, each pdev is registered as separate
+	 * wiphys.
+	 */
+	struct ath12k_hw *ah[MAX_RADIOS];
+	u8 num_hw;
+
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg hal_reg_cap[MAX_RADIOS];
 	unsigned long long free_vdev_map;
 	unsigned long long free_vdev_stats_id_map;
@@ -811,6 +835,11 @@ struct ath12k_base {
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
 
+struct ath12k_pdev_map {
+	struct ath12k_base *ab;
+	u8 pdev_idx;
+};
+
 int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab);
 int ath12k_core_pre_init(struct ath12k_base *ab);
 int ath12k_core_init(struct ath12k_base *ath12k);
@@ -897,8 +926,18 @@ static inline const char *ath12k_bus_str(enum ath12k_bus bus)
 	return "unknown";
 }
 
+static inline struct ath12k_hw *ath12k_hw_to_ah(struct ieee80211_hw  *hw)
+{
+	return hw->priv;
+}
+
+static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah)
+{
+	return ah->radio;
+}
+
 static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
 {
-	return ar->hw;
+	return ar->ah->hw;
 }
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 293440193374..ef8077c06cb1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1124,14 +1124,21 @@ static int ath12k_mac_config(struct ath12k *ar, u32 changed)
 
 static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	int ret;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+
 	ret = ath12k_mac_config(ar, changed);
 	if (ret)
 		ath12k_warn(ar->ab, "failed to update config pdev idx %d: %d\n",
 			    ar->pdev_idx, ret);
 
+	mutex_unlock(&ah->conf_mutex);
+
 	return ret;
 }
 
@@ -2796,14 +2803,21 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_bss_conf *info,
 					   u64 changed)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
 
 	mutex_unlock(&ar->conf_mutex);
+
+	mutex_unlock(&ah->conf_mutex);
 }
 
 void __ath12k_mac_scan_finish(struct ath12k *ar)
@@ -2974,13 +2988,18 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_scan_request *hw_req)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_scan_request *req = &hw_req->req;
 	struct ath12k_wmi_scan_req_arg arg = {};
 	int ret;
 	int i;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 
 	spin_lock_bh(&ar->data_lock);
@@ -3059,18 +3078,28 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		kfree(arg.extraie.ptr);
 
 	mutex_unlock(&ar->conf_mutex);
+
+	mutex_unlock(&ah->conf_mutex);
+
 	return ret;
 }
 
 static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
 
 	mutex_lock(&ar->conf_mutex);
 	ath12k_scan_abort(ar);
 	mutex_unlock(&ar->conf_mutex);
 
+	mutex_unlock(&ah->conf_mutex);
+
 	cancel_delayed_work_sync(&ar->scan.timeout);
 }
 
@@ -3193,8 +3222,9 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_peer *peer;
 	struct ath12k_sta *arsta;
@@ -3209,11 +3239,20 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
 		return 1;
 
-	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
+	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags)) {
+		mutex_unlock(&ah->conf_mutex);
 		return 1;
+	}
 
-	if (key->keyidx > WMI_MAX_KEY_INDEX)
+	if (key->keyidx > WMI_MAX_KEY_INDEX) {
+		mutex_unlock(&ah->conf_mutex);
 		return -ENOSPC;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3309,6 +3348,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 exit:
 	mutex_unlock(&ar->conf_mutex);
+	mutex_unlock(&ah->conf_mutex);
 	return ret;
 }
 
@@ -3784,7 +3824,8 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   enum ieee80211_sta_state old_state,
 				   enum ieee80211_sta_state new_state)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_peer *peer;
@@ -3795,6 +3836,10 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	     new_state == IEEE80211_STA_NOTEXIST))
 		cancel_work_sync(&arsta->update_wk);
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 
 	if (old_state == IEEE80211_STA_NOTEXIST &&
@@ -3890,6 +3935,9 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	}
 
 	mutex_unlock(&ar->conf_mutex);
+
+	mutex_unlock(&ah->conf_mutex);
+
 	return ret;
 }
 
@@ -3897,7 +3945,8 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *sta)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 	s16 txpwr;
@@ -3913,6 +3962,10 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	if (txpwr > ATH12K_TX_POWER_MAX_VAL || txpwr < ATH12K_TX_POWER_MIN_VAL)
 		return -EINVAL;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 
 	ret = ath12k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
@@ -3925,6 +3978,7 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 
 out:
 	mutex_unlock(&ar->conf_mutex);
+	mutex_unlock(&ah->conf_mutex);
 	return ret;
 }
 
@@ -3933,12 +3987,15 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					struct ieee80211_sta *sta,
 					u32 changed)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_peer *peer;
 	u32 bw, smps;
 
+	ar = ath12k_ah_to_ar(ah);
+
 	spin_lock_bh(&ar->ab->base_lock);
 
 	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
@@ -4113,14 +4170,21 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 				 unsigned int link_id, u16 ac,
 				 const struct ieee80211_tx_queue_params *params)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_conf_tx(arvif, link_id, ac, params);
 	mutex_unlock(&ar->conf_mutex);
 
+	mutex_unlock(&ah->conf_mutex);
+
 	return ret;
 }
 
@@ -5018,10 +5082,10 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			     struct sk_buff *skb)
 {
 	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
-	struct ath12k *ar = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k *ar = arvif->ar;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	u32 info_flags = info->flags;
@@ -5215,19 +5279,25 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 	struct ath12k_base *ab = ar->ab;
 	int ret;
 
 	ath12k_mac_drain_tx(ar);
 
+	mutex_lock(&ah->conf_mutex);
+
 	ret = ath12k_mac_start(ar);
 	if (ret) {
 		ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
 			   ar->pdev_idx, ret);
+		mutex_unlock(&ah->conf_mutex);
 		return ret;
 	}
 
+	mutex_unlock(&ah->conf_mutex);
+
 	return 0;
 }
 
@@ -5323,11 +5393,16 @@ static void ath12k_mac_stop(struct ath12k *ar)
 
 static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 
 	ath12k_mac_drain_tx(ar);
 
+	mutex_lock(&ah->conf_mutex);
+
 	ath12k_mac_stop(ar);
+
+	mutex_unlock(&ah->conf_mutex);
 }
 
 static u8
@@ -5503,8 +5578,9 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
 	struct ath12k_wmi_peer_create_arg peer_param;
@@ -5516,6 +5592,11 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	if (vif->type == NL80211_IFTYPE_AP &&
@@ -5695,6 +5776,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 		ath12k_mac_monitor_vdev_create(ar);
 
 	mutex_unlock(&ar->conf_mutex);
+	mutex_unlock(&ah->conf_mutex);
 
 	return ret;
 
@@ -5730,6 +5812,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 err:
 	mutex_unlock(&ar->conf_mutex);
+	mutex_unlock(&ah->conf_mutex);
 
 	return ret;
 }
@@ -5762,12 +5845,18 @@ static void ath12k_mac_vif_unref(struct ath12k_dp *dp, struct ieee80211_vif *vif
 static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_base *ab;
 	unsigned long time_left;
 	int ret;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
@@ -5831,6 +5920,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	/* TODO: recal traffic pause state based on the available vdevs */
 
 	mutex_unlock(&ar->conf_mutex);
+	mutex_unlock(&ah->conf_mutex);
 }
 
 /* FIXME: Has to be verified. */
@@ -5877,7 +5967,12 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 					   unsigned int *total_flags,
 					   u64 multicast)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5885,11 +5980,18 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 	ath12k_mac_configure_filter(ar, *total_flags);
 
 	mutex_unlock(&ar->conf_mutex);
+
+	mutex_unlock(&ah->conf_mutex);
 }
 
 static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5898,18 +6000,27 @@ static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *
 
 	mutex_unlock(&ar->conf_mutex);
 
+	mutex_unlock(&ah->conf_mutex);
+
 	return 0;
 }
 
 static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	int ret;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 	ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
 	mutex_unlock(&ar->conf_mutex);
 
+	mutex_unlock(&ah->conf_mutex);
+
 	return ret;
 }
 
@@ -5947,10 +6058,15 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_ampdu_params *params)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret = -EINVAL;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_ampdu_action(arvif, params);
 	mutex_unlock(&ar->conf_mutex);
@@ -5959,14 +6075,22 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 		ath12k_warn(ar->ab, "pdev idx %d unable to perform ampdu action %d ret %d\n",
 			    ar->pdev_idx, params->action, ret);
 
+	mutex_unlock(&ah->conf_mutex);
+
 	return ret;
 }
 
 static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 				     struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
+
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac chanctx add freq %u width %d ptr %pK\n",
@@ -5983,14 +6107,22 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 
 	mutex_unlock(&ar->conf_mutex);
 
+	mutex_unlock(&ah->conf_mutex);
+
 	return 0;
 }
 
 static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 					 struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
+
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac chanctx remove freq %u width %d ptr %pK\n",
@@ -6006,6 +6138,8 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 	mutex_unlock(&ar->conf_mutex);
+
+	mutex_unlock(&ah->conf_mutex);
 }
 
 static enum wmi_phy_mode
@@ -6398,8 +6532,14 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 					 struct ieee80211_chanctx_conf *ctx,
 					 u32 changed)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
+
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -6421,6 +6561,7 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 
 unlock:
 	mutex_unlock(&ar->conf_mutex);
+	mutex_unlock(&ah->conf_mutex);
 }
 
 static int ath12k_start_vdev_delay(struct ath12k *ar,
@@ -6461,12 +6602,18 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_bss_conf *link_conf,
 				 struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 	struct ath12k_wmi_peer_create_arg param;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6530,6 +6677,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 out:
 	mutex_unlock(&ar->conf_mutex);
+	mutex_unlock(&ah->conf_mutex);
 
 	return ret;
 }
@@ -6540,11 +6688,17 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				   struct ieee80211_bss_conf *link_conf,
 				   struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6562,6 +6716,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		ret = ath12k_mac_monitor_stop(ar);
 		if (ret) {
 			mutex_unlock(&ar->conf_mutex);
+			mutex_unlock(&ah->conf_mutex);
 			return;
 		}
 
@@ -6584,6 +6739,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		ath12k_mac_monitor_stop(ar);
 
 	mutex_unlock(&ar->conf_mutex);
+	mutex_unlock(&ah->conf_mutex);
 }
 
 static int
@@ -6592,7 +6748,12 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 				 int n_vifs,
 				 enum ieee80211_chanctx_switch_mode mode)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -6603,6 +6764,8 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 
 	mutex_unlock(&ar->conf_mutex);
 
+	mutex_unlock(&ah->conf_mutex);
+
 	return 0;
 }
 
@@ -6634,10 +6797,19 @@ ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
  */
 static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 {
-	struct ath12k *ar = hw->priv;
-	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD, ret;
+
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
 
-	return ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
+	ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
+
+	mutex_unlock(&ah->conf_mutex);
+
+	return ret;
 }
 
 static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
@@ -6676,7 +6848,8 @@ static void ath12k_mac_flush(struct ath12k *ar)
 static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				u32 queues, bool drop)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 
 	if (drop)
 		return;
@@ -6911,6 +7084,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
 			       const struct cfg80211_bitrate_mask *mask)
 {
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_chan_def def;
 	struct ath12k *ar = arvif->ar;
@@ -6928,14 +7102,18 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	if (ath12k_mac_vif_chan(vif, &def))
 		return -EPERM;
 
+	mutex_lock(&ah->conf_mutex);
+
 	band = def.chan->band;
 	ht_mcs_mask = mask->control[band].ht_mcs;
 	vht_mcs_mask = mask->control[band].vht_mcs;
 	ldpc = !!(ar->ht_cap_info & WMI_HT_CAP_LDPC);
 
 	sgi = mask->control[band].gi;
-	if (sgi == NL80211_TXRATE_FORCE_LGI)
-		return -EINVAL;
+	if (sgi == NL80211_TXRATE_FORCE_LGI) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
 	 * requires passing at least one of used basic rates along with them.
@@ -6951,7 +7129,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to get single legacy rate for vdev %i: %d\n",
 				    arvif->vdev_id, ret);
-			return ret;
+			goto out;
 		}
 		ieee80211_iterate_stations_atomic(hw,
 						  ath12k_mac_disable_peer_fixed_rate,
@@ -6996,7 +7174,8 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			 */
 			ath12k_warn(ar->ab,
 				    "Setting more than one MCS Value in bitrate mask not supported\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 
 		ieee80211_iterate_stations_atomic(hw,
@@ -7023,6 +7202,9 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 
 	mutex_unlock(&ar->conf_mutex);
 
+out:
+	mutex_unlock(&ah->conf_mutex);
+
 	return ret;
 }
 
@@ -7030,14 +7212,20 @@ static void
 ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				enum ieee80211_reconfig_type reconfig_type)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_base *ab;
 	struct ath12k_vif *arvif;
 	int recovery_count;
 
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+	ab = ar->ab;
+
 	mutex_lock(&ar->conf_mutex);
 
 	if (ar->state == ATH12K_STATE_RESTARTED) {
@@ -7084,6 +7272,8 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	}
 
 	mutex_unlock(&ar->conf_mutex);
+
+	mutex_unlock(&ah->conf_mutex);
 }
 
 static void
@@ -7121,7 +7311,8 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
 static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 				    struct survey_info *survey)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
 	struct ieee80211_supported_band *sband;
 	struct survey_info *ar_survey;
 	int ret = 0;
@@ -7129,6 +7320,10 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	if (idx >= ATH12K_NUM_CHANS)
 		return -ENOENT;
 
+	mutex_lock(&ah->conf_mutex);
+
+	ar = ath12k_ah_to_ar(ah);
+
 	ar_survey = &ar->survey[idx];
 
 	mutex_lock(&ar->conf_mutex);
@@ -7160,6 +7355,8 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 exit:
 	mutex_unlock(&ar->conf_mutex);
+	mutex_unlock(&ah->conf_mutex);
+
 	return ret;
 }
 
@@ -7359,20 +7556,44 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
+static u16 ath12k_mac_get_ifmodes(struct ath12k_hw *ah)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
-	struct wiphy *wiphy = hw->wiphy;
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	u16 interface_modes = U16_MAX;
+
+	interface_modes &= ar->ab->hw_params->interface_modes;
+
+	return interface_modes == U16_MAX ? 0 : interface_modes;
+}
+
+static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
+					    enum nl80211_iftype type)
+{
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	u16 interface_modes, mode;
+	bool is_enable = true;
+
+	mode = BIT(type);
+
+	interface_modes = ar->ab->hw_params->interface_modes;
+	if (!(interface_modes & mode))
+		is_enable = false;
+
+	return is_enable;
+}
+
+static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
 	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
 	int n_limits, max_interfaces;
 	bool ap, mesh;
 
-	ap = ab->hw_params->interface_modes & BIT(NL80211_IFTYPE_AP);
+	ap = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_AP);
 
 	mesh = IS_ENABLED(CONFIG_MAC80211_MESH) &&
-		ab->hw_params->interface_modes & BIT(NL80211_IFTYPE_MESH_POINT);
+		ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_MESH_POINT);
 
 	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
 	if (!combinations)
@@ -7467,10 +7688,11 @@ static void ath12k_mac_cleanup_unregister(struct ath12k *ar)
 	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
 }
 
-void ath12k_mac_hw_unregister(struct ath12k *ar)
+void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 {
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ieee80211_hw *hw = ah->hw;
 	struct wiphy *wiphy = hw->wiphy;
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 
 	cancel_work_sync(&ar->regd_update_work);
 
@@ -7512,13 +7734,14 @@ static int ath12k_mac_setup_register(struct ath12k *ar,
 	return 0;
 }
 
-int ath12k_mac_hw_register(struct ath12k *ar)
+int ath12k_mac_hw_register(struct ath12k_hw *ah)
 {
-	struct ath12k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ieee80211_hw *hw = ah->hw;
 	struct wiphy *wiphy = hw->wiphy;
-	struct ath12k_pdev *pdev = ar->pdev;
-	struct ath12k_pdev_cap *cap = &pdev->cap;
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_pdev *pdev;
+	struct ath12k_pdev_cap *cap;
 	static const u32 cipher_suites[] = {
 		WLAN_CIPHER_SUITE_TKIP,
 		WLAN_CIPHER_SUITE_CCMP,
@@ -7533,30 +7756,34 @@ int ath12k_mac_hw_register(struct ath12k *ar)
 	int ret;
 	u32 ht_cap = 0;
 
-	if (ab->pdevs_macaddr_valid) {
+	pdev = ar->pdev;
+
+	if (ab->pdevs_macaddr_valid)
 		ether_addr_copy(ar->mac_addr, pdev->mac_addr);
-	} else {
+	else
 		ether_addr_copy(ar->mac_addr, ab->mac_addr);
-		ar->mac_addr[4] += ar->pdev_idx;
-	}
 
 	ret = ath12k_mac_setup_register(ar, &ht_cap, hw->wiphy->bands);
 	if (ret)
 		goto out;
 
+	wiphy->max_ap_assoc_sta = ar->max_num_stations;
+
+	cap = &pdev->cap;
+
+	wiphy->available_antennas_rx = cap->rx_chain_mask;
+	wiphy->available_antennas_tx = cap->tx_chain_mask;
+
 	SET_IEEE80211_PERM_ADDR(hw, ar->mac_addr);
 	SET_IEEE80211_DEV(hw, ab->dev);
 
-	ret = ath12k_mac_setup_iface_combinations(ar);
+	ret = ath12k_mac_setup_iface_combinations(ah);
 	if (ret) {
-		ath12k_err(ar->ab, "failed to setup interface combinations: %d\n", ret);
-		goto err_setup_unregister;
+		ath12k_err(ab, "failed to setup interface combinations: %d\n", ret);
+		goto err_cleanup_unregister;
 	}
 
-	wiphy->available_antennas_rx = cap->rx_chain_mask;
-	wiphy->available_antennas_tx = cap->tx_chain_mask;
-
-	wiphy->interface_modes = ab->hw_params->interface_modes;
+	wiphy->interface_modes = ath12k_mac_get_ifmodes(ah);
 
 	if (wiphy->bands[NL80211_BAND_2GHZ] &&
 	    wiphy->bands[NL80211_BAND_5GHZ] &&
@@ -7609,8 +7836,6 @@ int ath12k_mac_hw_register(struct ath12k *ar)
 	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
-	wiphy->max_ap_assoc_sta = ar->max_num_stations;
-
 	hw->queues = ATH12K_HW_MAX_QUEUES;
 	wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
 	hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
@@ -7647,7 +7872,7 @@ int ath12k_mac_hw_register(struct ath12k *ar)
 
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
-		ath12k_err(ar->ab, "ieee80211 registration failed: %d\n", ret);
+		ath12k_err(ab, "ieee80211 registration failed: %d\n", ret);
 		goto err_free_if_combs;
 	}
 
@@ -7675,14 +7900,12 @@ int ath12k_mac_hw_register(struct ath12k *ar)
 	kfree(wiphy->iface_combinations[0].limits);
 	kfree(wiphy->iface_combinations);
 
-err_setup_unregister:
-	kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
-	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
-	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
+err_cleanup_unregister:
+	ath12k_mac_cleanup_unregister(ar);
 
+out:
 	SET_IEEE80211_DEV(hw, NULL);
 
-out:
 	return ret;
 }
 
@@ -7726,56 +7949,50 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	clear_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
 }
 
-int ath12k_mac_hw_allocate(struct ath12k_base *ab)
+struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
+					 struct ath12k_pdev_map *pdev_map,
+					 u8 num_pdev_map)
 {
 	struct ieee80211_hw *hw;
 	struct ath12k *ar;
 	struct ath12k_pdev *pdev;
-	int ret;
+	struct ath12k_hw *ah;
 	int i;
+	u8 pdev_idx;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		hw = ieee80211_alloc_hw(sizeof(struct ath12k), &ath12k_ops);
-		if (!hw) {
-			ath12k_warn(ab, "failed to allocate mac80211 hw device\n");
-			ret = -ENOMEM;
-			goto err_free_mac;
-		}
+	hw = ieee80211_alloc_hw(struct_size(ah, radio, num_pdev_map),
+				&ath12k_ops);
+	if (!hw)
+		return NULL;
+
+	ah = ath12k_hw_to_ah(hw);
+	ah->hw = hw;
+	ah->num_radio = num_pdev_map;
+
+	mutex_init(&ah->conf_mutex);
 
-		ar = hw->priv;
-		ar->hw = hw;
+	for (i = 0; i < num_pdev_map; i++) {
+		ab = pdev_map[i].ab;
+		pdev_idx = pdev_map[i].pdev_idx;
+		pdev = &ab->pdevs[pdev_idx];
+
+		ar = ath12k_ah_to_ar(ah);
+		ar->ah = ah;
 		ar->ab = ab;
+		ar->hw_link_id = i;
 		ar->pdev = pdev;
-		ar->pdev_idx = i;
+		ar->pdev_idx = pdev_idx;
 		pdev->ar = ar;
 
 		ath12k_mac_setup(ar);
 	}
 
-	return 0;
-
-err_free_mac:
-	ath12k_mac_hw_destroy(ab);
-
-	return ret;
+	return ah;
 }
 
-void ath12k_mac_hw_destroy(struct ath12k_base *ab)
+void ath12k_mac_hw_destroy(struct ath12k_hw *ah)
 {
-	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
-	int i;
-
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		if (!ar)
-			continue;
-
-		ieee80211_free_hw(ath12k_ar_to_hw(ar));
-		pdev->ar = NULL;
-	}
+	ieee80211_free_hw(ah->hw);
 }
 
 enum nl80211_he_ru_alloc ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy)
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index f71dd905a5d5..3ad1c112b08b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_MAC_H
@@ -12,6 +12,8 @@
 
 struct ath12k;
 struct ath12k_base;
+struct ath12k_hw;
+struct ath12k_pdev_map;
 
 struct ath12k_generic_iter {
 	struct ath12k *ar;
@@ -48,10 +50,12 @@ enum ath12k_supported_bw {
 
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
 
-void ath12k_mac_hw_destroy(struct ath12k_base *ab);
-void ath12k_mac_hw_unregister(struct ath12k *ar);
-int ath12k_mac_hw_register(struct ath12k *ar);
-int ath12k_mac_hw_allocate(struct ath12k_base *ab);
+void ath12k_mac_hw_destroy(struct ath12k_hw *ah);
+void ath12k_mac_hw_unregister(struct ath12k_hw *ah);
+int ath12k_mac_hw_register(struct ath12k_hw *ah);
+struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
+					 struct ath12k_pdev_map *pdev_map,
+					 u8 num_pdev_map);
 int ath12k_mac_hw_ratecode_to_legacy_rate(u8 hw_rc, u8 preamble, u8 *rateidx,
 					  u16 *rate);
 u8 ath12k_mac_bitrate_to_idx(const struct ieee80211_supported_band *sband,
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 88e71d171355..a164f15d1e2b 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -48,7 +48,8 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct ath12k_wmi_init_country_arg arg;
-	struct ath12k *ar = hw->priv;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar = ath12k_ah_to_ar(ah);
 	int ret;
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-- 
2.34.1


