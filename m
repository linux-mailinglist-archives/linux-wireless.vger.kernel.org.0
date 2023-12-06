Return-Path: <linux-wireless+bounces-455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FE8065D8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 04:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77CF1F2163D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4BACA7A;
	Wed,  6 Dec 2023 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LO4W3sgZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE091BF
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 19:49:51 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B62TDL5011754;
	Wed, 6 Dec 2023 03:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gcHnisN0ZzLo00s3Vlki9fl/iZRS8NOFIuSI1PeuHbQ=;
 b=LO4W3sgZ4e/NLm7uAlWo/n0fvZuPFvwzMyHs/dGzwqb4wiCVjNbzndem429LapDDDdah
 BU+gg7Fh2MWQuEbbbcDlTQKd51ykpcxJ3yw2leUNwXlB6m1xrAIlLp584QnTdOOTV18R
 B28uSY+DqBedHsYJ5PXXFlXhCHoea7+F2gz76xFrSpRbWZ6+EUT6ezBdYwFJlNbwnoIS
 CCEnSPAhNeF9NO2gkM6e4OUszBoHAr4AQflkwEJ5eoJXjxHwcA8yy1uhojZDmXDrHtCW
 T1Fx7UD3tcRdNCQp+ToTd5n8MGu/o5ycl1lhMR0ScBFWfbxB5n8r98b3NLS5JH9zm02T RA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utd0qggk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 03:49:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B63nmok019858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Dec 2023 03:49:48 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 19:49:46 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: Refactor MAC un/register helper function
Date: Wed, 6 Dec 2023 09:19:20 +0530
Message-ID: <20231206034920.1037449-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: hUXjj6fL-3WBSQ9_nNMy8Mtw2HJRpq23
X-Proofpoint-ORIG-GUID: hUXjj6fL-3WBSQ9_nNMy8Mtw2HJRpq23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=931 lowpriorityscore=0 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060031

Currently, the mac80211 hw registration procedure is tightly coupled with
the handling of link/radio (ar). Define a new helper function to separate
the link/radio handling from the mac80211 hw registration procedure for
improved code readability. Also, it can be easy to scale these
functionality to support single/multi link operation in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  61 +++++++++++-
 drivers/net/wireless/ath/ath12k/mac.c  | 132 ++++++++++---------------
 drivers/net/wireless/ath/ath12k/mac.h  |   4 +-
 3 files changed, 109 insertions(+), 88 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index e10c5f2cd8eb..d1ac00c59b8c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -498,11 +498,62 @@ static void ath12k_core_soc_destroy(struct ath12k_base *ab)
 	ath12k_qmi_deinit_service(ab);
 }
 
+static int ath12k_core_mac_register(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	struct ath12k_pdev *pdev;
+	int i;
+	int ret;
+
+	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
+		return 0;
+
+	/* Initialize channel counters frequency value in hertz */
+	ab->cc_freq_hz = 320000;
+	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		ret = ath12k_mac_hw_register(ar);
+		if (ret)
+			goto err_cleanup;
+	}
+
+	return 0;
+
+err_cleanup:
+	for (i = i - 1; i >= 0; i--) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		ath12k_mac_hw_unregister(ar);
+	}
+
+	return ret;
+}
+
+static void ath12k_core_mac_unregister(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	struct ath12k_pdev *pdev;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		if (!ar)
+			continue;
+
+		ath12k_mac_hw_unregister(ar);
+	}
+}
+
 static int ath12k_core_pdev_create(struct ath12k_base *ab)
 {
 	int ret;
 
-	ret = ath12k_mac_register(ab);
+	ret = ath12k_core_mac_register(ab);
 	if (ret) {
 		ath12k_err(ab, "failed register the radio with mac80211: %d\n", ret);
 		return ret;
@@ -511,20 +562,20 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
 	ret = ath12k_dp_pdev_alloc(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to attach DP pdev: %d\n", ret);
-		goto err_mac_unregister;
+		goto err_core_mac_unregister;
 	}
 
 	return 0;
 
-err_mac_unregister:
-	ath12k_mac_unregister(ab);
+err_core_mac_unregister:
+	ath12k_core_mac_unregister(ab);
 
 	return ret;
 }
 
 static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
 {
-	ath12k_mac_unregister(ab);
+	ath12k_core_mac_unregister(ab);
 	ath12k_hif_irq_disable(ab);
 	ath12k_dp_pdev_free(ab);
 }
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index be3ef388e9aa..27f6067fd3fc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7349,7 +7349,17 @@ static const struct wiphy_iftype_ext_capab ath12k_iftypes_ext_capa[] = {
 	},
 };
 
-static void __ath12k_mac_unregister(struct ath12k *ar)
+static void ath12k_mac_cleanup_unregister(struct ath12k *ar)
+{
+	idr_for_each(&ar->txmgmt_idr, ath12k_mac_tx_mgmt_pending_free, ar);
+	idr_destroy(&ar->txmgmt_idr);
+
+	kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
+	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
+	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
+}
+
+void ath12k_mac_hw_unregister(struct ath12k *ar)
 {
 	struct ieee80211_hw *hw = ar->hw;
 	struct wiphy *wiphy = hw->wiphy;
@@ -7358,12 +7368,7 @@ static void __ath12k_mac_unregister(struct ath12k *ar)
 
 	ieee80211_unregister_hw(hw);
 
-	idr_for_each(&ar->txmgmt_idr, ath12k_mac_tx_mgmt_pending_free, ar);
-	idr_destroy(&ar->txmgmt_idr);
-
-	kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
-	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
-	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
+	ath12k_mac_cleanup_unregister(ar);
 
 	kfree(wiphy->iface_combinations[0].limits);
 	kfree(wiphy->iface_combinations);
@@ -7371,28 +7376,41 @@ static void __ath12k_mac_unregister(struct ath12k *ar)
 	SET_IEEE80211_DEV(hw, NULL);
 }
 
-void ath12k_mac_unregister(struct ath12k_base *ab)
+static int ath12k_mac_setup_register(struct ath12k *ar,
+				     u32 *ht_cap,
+				     struct ieee80211_supported_band *bands[])
 {
-	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
-	int i;
+	struct ath12k_pdev_cap *cap = &ar->pdev->cap;
+	int ret;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		if (!ar)
-			continue;
+	init_waitqueue_head(&ar->txmgmt_empty_waitq);
+	idr_init(&ar->txmgmt_idr);
+	spin_lock_init(&ar->txmgmt_idr_lock);
 
-		__ath12k_mac_unregister(ar);
-	}
+	ath12k_pdev_caps_update(ar);
+
+	ret = ath12k_mac_setup_channels_rates(ar,
+					      cap->supported_bands,
+					      bands);
+	if (ret)
+		return ret;
+
+	ath12k_mac_setup_ht_vht_cap(ar, cap, ht_cap);
+	ath12k_mac_setup_sband_iftype_data(ar, cap);
+
+	ar->max_num_stations = TARGET_NUM_STATIONS;
+	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
+
+	return 0;
 }
 
-static int __ath12k_mac_register(struct ath12k *ar)
+int ath12k_mac_hw_register(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hw *hw = ar->hw;
 	struct wiphy *wiphy = hw->wiphy;
-	struct ath12k_pdev_cap *cap = &ar->pdev->cap;
+	struct ath12k_pdev *pdev = ar->pdev;
+	struct ath12k_pdev_cap *cap = &pdev->cap;
 	static const u32 cipher_suites[] = {
 		WLAN_CIPHER_SUITE_TKIP,
 		WLAN_CIPHER_SUITE_CCMP,
@@ -7407,25 +7425,24 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	int ret;
 	u32 ht_cap = 0;
 
-	ath12k_pdev_caps_update(ar);
-
-	SET_IEEE80211_PERM_ADDR(hw, ar->mac_addr);
-
-	SET_IEEE80211_DEV(hw, ab->dev);
+	if (ab->pdevs_macaddr_valid) {
+		ether_addr_copy(ar->mac_addr, pdev->mac_addr);
+	} else {
+		ether_addr_copy(ar->mac_addr, ab->mac_addr);
+		ar->mac_addr[4] += ar->pdev_idx;
+	}
 
-	ret = ath12k_mac_setup_channels_rates(ar,
-					      cap->supported_bands,
-					      hw->wiphy->bands);
+	ret = ath12k_mac_setup_register(ar, &ht_cap, hw->wiphy->bands);
 	if (ret)
-		goto err;
+		goto out;
 
-	ath12k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
-	ath12k_mac_setup_sband_iftype_data(ar, cap);
+	SET_IEEE80211_PERM_ADDR(hw, ar->mac_addr);
+	SET_IEEE80211_DEV(hw, ab->dev);
 
 	ret = ath12k_mac_setup_iface_combinations(ar);
 	if (ret) {
 		ath12k_err(ar->ab, "failed to setup interface combinations: %d\n", ret);
-		goto err_free_channels;
+		goto err_setup_unregister;
 	}
 
 	wiphy->available_antennas_rx = cap->rx_chain_mask;
@@ -7484,9 +7501,6 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
-	ar->max_num_stations = TARGET_NUM_STATIONS;
-	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
-
 	wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
 	hw->queues = ATH12K_HW_MAX_QUEUES;
@@ -7553,58 +7567,14 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	kfree(wiphy->iface_combinations[0].limits);
 	kfree(wiphy->iface_combinations);
 
-err_free_channels:
+err_setup_unregister:
 	kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
 	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
 	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
 
-err:
 	SET_IEEE80211_DEV(hw, NULL);
-	return ret;
-}
-
-int ath12k_mac_register(struct ath12k_base *ab)
-{
-	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
-	int i;
-	int ret;
-
-	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
-		return 0;
-
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		if (ab->pdevs_macaddr_valid) {
-			ether_addr_copy(ar->mac_addr, pdev->mac_addr);
-		} else {
-			ether_addr_copy(ar->mac_addr, ab->mac_addr);
-			ar->mac_addr[4] += i;
-		}
-
-		ret = __ath12k_mac_register(ar);
-		if (ret)
-			goto err_cleanup;
-
-		init_waitqueue_head(&ar->txmgmt_empty_waitq);
-		idr_init(&ar->txmgmt_idr);
-		spin_lock_init(&ar->txmgmt_idr_lock);
-	}
-
-	/* Initialize channel counters frequency value in hertz */
-	ab->cc_freq_hz = 320000;
-	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
-
-	return 0;
-
-err_cleanup:
-	for (i = i - 1; i >= 0; i--) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		__ath12k_mac_unregister(ar);
-	}
 
+out:
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index fb4c0662581b..c30ebda77b0a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -49,8 +49,8 @@ enum ath12k_supported_bw {
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
 
 void ath12k_mac_hw_destroy(struct ath12k_base *ab);
-void ath12k_mac_unregister(struct ath12k_base *ab);
-int ath12k_mac_register(struct ath12k_base *ab);
+void ath12k_mac_hw_unregister(struct ath12k *ar);
+int ath12k_mac_hw_register(struct ath12k *ar);
 int ath12k_mac_hw_allocate(struct ath12k_base *ab);
 int ath12k_mac_hw_ratecode_to_legacy_rate(u8 hw_rc, u8 preamble, u8 *rateidx,
 					  u16 *rate);
-- 
2.34.1


