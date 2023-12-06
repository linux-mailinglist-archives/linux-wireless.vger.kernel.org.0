Return-Path: <linux-wireless+bounces-454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D08065D7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 04:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AB128209B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0F5DF68;
	Wed,  6 Dec 2023 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="juiyvBeU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9160C188
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 19:49:49 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B62rboO018822;
	Wed, 6 Dec 2023 03:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=N2nIRoLKAXoosbXd279VpLYQR1tyn5Tkat+4SJYmXSw=;
 b=juiyvBeUyRjmbCPv7hdDpx4felQQU0NkYmGv77/S6Q/LfIsF6hv9H11xV6b6cMZ172m7
 DIfvfjUGyT3FfBJYuaR6N3FS3azfZVJOL/pUpEZt1DFyi2laevp03lHZdCiDqMkk865F
 3k51P6OFTVqAO94RcV6RRXuPzZOosj8bZvS4bsL7wm50AZSO8Vd7f905bKuN1cZqDvbJ
 DSyLUj4lVxNl3KuC2ukStW9rowgf+tWwTqMf49dT5r6ROPQiF9bmUGQwcedpN1WfLTwV
 3qj/0NJ1vtIihHmtn0e0UgBk9Sz9CjAXMBJU4kzmCX3uhYygFCIU4qGM0zp+7pPd2Br+ Pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utd1n0fjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 03:49:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B63niF9027498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Dec 2023 03:49:44 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 19:49:43 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/4] wifi: ath12k: Refactor the MAC allocation and destroy
Date: Wed, 6 Dec 2023 09:19:18 +0530
Message-ID: <20231206034920.1037449-3-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1tT572snyuG6H7wausXU9Mri5qUys5HK
X-Proofpoint-GUID: 1tT572snyuG6H7wausXU9Mri5qUys5HK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312060030

Currently, the MAC allocation and destroy helper functions are tightly
coupled with the link/radio (ar) structure. In the future, to support
single/Multi link operations, need to refactor these helper functions
across the core and mac sub modules, so that it can be easy to scale
these functions to support single/Multi link operations.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 33 ++++++++--
 drivers/net/wireless/ath/ath12k/mac.c  | 83 ++++++++++++++------------
 drivers/net/wireless/ath/ath12k/mac.h  |  4 +-
 3 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 6f634b57dde8..e10c5f2cd8eb 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -529,6 +529,27 @@ static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
 	ath12k_dp_pdev_free(ab);
 }
 
+static void ath12k_core_mac_destroy(struct ath12k_base *ab)
+{
+	ath12k_mac_hw_destroy(ab);
+}
+
+static int ath12k_core_mac_allocate(struct ath12k_base *ab)
+{
+	int ret;
+
+	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
+		return 0;
+
+	ret = ath12k_mac_hw_allocate(ab);
+	if (ret)
+		return ret;
+
+	ath12k_dp_pdev_pre_alloc(ab);
+
+	return 0;
+}
+
 static int ath12k_core_start(struct ath12k_base *ab,
 			     enum ath12k_firmware_mode mode)
 {
@@ -583,7 +604,7 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		goto err_hif_stop;
 	}
 
-	ret = ath12k_mac_allocate(ab);
+	ret = ath12k_core_mac_allocate(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to create new hw device with mac80211 :%d\n",
 			   ret);
@@ -595,7 +616,7 @@ static int ath12k_core_start(struct ath12k_base *ab,
 	ret = ath12k_dp_rx_pdev_reo_setup(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to initialize reo destination rings: %d\n", ret);
-		goto err_mac_destroy;
+		goto err_core_mac_destroy;
 	}
 
 	ret = ath12k_wmi_cmd_init(ab);
@@ -631,8 +652,8 @@ static int ath12k_core_start(struct ath12k_base *ab,
 
 err_reo_cleanup:
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
-err_mac_destroy:
-	ath12k_mac_destroy(ab);
+err_core_mac_destroy:
+	ath12k_core_mac_destroy(ab);
 err_hif_stop:
 	ath12k_hif_stop(ab);
 err_wmi_detach:
@@ -707,7 +728,7 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 	ath12k_core_pdev_destroy(ab);
 err_core_stop:
 	ath12k_core_stop(ab);
-	ath12k_mac_destroy(ab);
+	ath12k_core_mac_destroy(ab);
 err_dp_free:
 	ath12k_dp_free(ab);
 	mutex_unlock(&ab->core_lock);
@@ -1003,7 +1024,7 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 	mutex_unlock(&ab->core_lock);
 
 	ath12k_hif_power_down(ab);
-	ath12k_mac_destroy(ab);
+	ath12k_core_mac_destroy(ab);
 	ath12k_core_soc_destroy(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 49d56f5d8896..a110119ad701 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7607,7 +7607,47 @@ int ath12k_mac_register(struct ath12k_base *ab)
 	return ret;
 }
 
-int ath12k_mac_allocate(struct ath12k_base *ab)
+static void ath12k_mac_setup(struct ath12k *ar)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_pdev *pdev = ar->pdev;
+	u8 pdev_idx = ar->pdev_idx;
+
+	ar->lmac_id = ath12k_hw_get_mac_from_pdev_id(ab->hw_params, pdev_idx);
+
+	ar->wmi = &ab->wmi_ab.wmi[pdev_idx];
+	/* FIXME: wmi[0] is already initialized during attach,
+	 * Should we do this again?
+	 */
+	ath12k_wmi_pdev_attach(ab, pdev_idx);
+
+	ar->cfg_tx_chainmask = pdev->cap.tx_chain_mask;
+	ar->cfg_rx_chainmask = pdev->cap.rx_chain_mask;
+	ar->num_tx_chains = hweight32(pdev->cap.tx_chain_mask);
+	ar->num_rx_chains = hweight32(pdev->cap.rx_chain_mask);
+
+	spin_lock_init(&ar->data_lock);
+	INIT_LIST_HEAD(&ar->arvifs);
+	INIT_LIST_HEAD(&ar->ppdu_stats_info);
+	mutex_init(&ar->conf_mutex);
+	init_completion(&ar->vdev_setup_done);
+	init_completion(&ar->vdev_delete_done);
+	init_completion(&ar->peer_assoc_done);
+	init_completion(&ar->peer_delete_done);
+	init_completion(&ar->install_key_done);
+	init_completion(&ar->bss_survey_done);
+	init_completion(&ar->scan.started);
+	init_completion(&ar->scan.completed);
+
+	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
+	INIT_WORK(&ar->regd_update_work, ath12k_regd_update_work);
+
+	INIT_WORK(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
+	skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
+	clear_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
+}
+
+int ath12k_mac_hw_allocate(struct ath12k_base *ab)
 {
 	struct ieee80211_hw *hw;
 	struct ath12k *ar;
@@ -7615,9 +7655,6 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 	int ret;
 	int i;
 
-	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
-		return 0;
-
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		hw = ieee80211_alloc_hw(sizeof(struct ath12k), &ath12k_ops);
@@ -7632,52 +7669,20 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 		ar->ab = ab;
 		ar->pdev = pdev;
 		ar->pdev_idx = i;
-		ar->lmac_id = ath12k_hw_get_mac_from_pdev_id(ab->hw_params, i);
-
-		ar->wmi = &ab->wmi_ab.wmi[i];
-		/* FIXME: wmi[0] is already initialized during attach,
-		 * Should we do this again?
-		 */
-		ath12k_wmi_pdev_attach(ab, i);
-
-		ar->cfg_tx_chainmask = pdev->cap.tx_chain_mask;
-		ar->cfg_rx_chainmask = pdev->cap.rx_chain_mask;
-		ar->num_tx_chains = hweight32(pdev->cap.tx_chain_mask);
-		ar->num_rx_chains = hweight32(pdev->cap.rx_chain_mask);
-
 		pdev->ar = ar;
-		spin_lock_init(&ar->data_lock);
-		INIT_LIST_HEAD(&ar->arvifs);
-		INIT_LIST_HEAD(&ar->ppdu_stats_info);
-		mutex_init(&ar->conf_mutex);
-		init_completion(&ar->vdev_setup_done);
-		init_completion(&ar->vdev_delete_done);
-		init_completion(&ar->peer_assoc_done);
-		init_completion(&ar->peer_delete_done);
-		init_completion(&ar->install_key_done);
-		init_completion(&ar->bss_survey_done);
-		init_completion(&ar->scan.started);
-		init_completion(&ar->scan.completed);
 
-		INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
-		INIT_WORK(&ar->regd_update_work, ath12k_regd_update_work);
-
-		INIT_WORK(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
-		skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
-		clear_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
+		ath12k_mac_setup(ar);
 	}
 
-	ath12k_dp_pdev_pre_alloc(ab);
-
 	return 0;
 
 err_free_mac:
-	ath12k_mac_destroy(ab);
+	ath12k_mac_hw_destroy(ab);
 
 	return ret;
 }
 
-void ath12k_mac_destroy(struct ath12k_base *ab)
+void ath12k_mac_hw_destroy(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
 	struct ath12k_pdev *pdev;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 7c63bb628adc..fb4c0662581b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -48,10 +48,10 @@ enum ath12k_supported_bw {
 
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
 
-void ath12k_mac_destroy(struct ath12k_base *ab);
+void ath12k_mac_hw_destroy(struct ath12k_base *ab);
 void ath12k_mac_unregister(struct ath12k_base *ab);
 int ath12k_mac_register(struct ath12k_base *ab);
-int ath12k_mac_allocate(struct ath12k_base *ab);
+int ath12k_mac_hw_allocate(struct ath12k_base *ab);
 int ath12k_mac_hw_ratecode_to_legacy_rate(u8 hw_rc, u8 preamble, u8 *rateidx,
 					  u16 *rate);
 u8 ath12k_mac_bitrate_to_idx(const struct ieee80211_supported_band *sband,
-- 
2.34.1


