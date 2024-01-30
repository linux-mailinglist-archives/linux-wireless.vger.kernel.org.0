Return-Path: <linux-wireless+bounces-2774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C90841BBD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 07:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D27D1C2519A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 06:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F17381D3;
	Tue, 30 Jan 2024 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Suvwrmqs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9429381C1
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594942; cv=none; b=uj10/OL9MYW+tB0S50WRUXR3rHxRqd7qSkXp+YSRcTp1//rcC+lAxJvTS8jh2Qq7yKLsp2FSAnvl6Xy0yWS5hWp2ES76HPEVOH9Lfp8LNthA9myCGahrS9FOXMe9d5pc5XiKb4Ta+kD/s6Zwzf32K8KpYKrW5sntlwCdfJeIUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594942; c=relaxed/simple;
	bh=f5YFYMuuyzoDnKnd6eut08Wks2v5UZ0UMk4nX6l8GaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nj4qViKB55S2iC7rK7AgiXhtSxs2QIocpyF80iZrRXxIGTpKsfUXUKbxwSnUVK+CSPnYse4+oXs8tD6CoUU4svkKcdHlNzUNX1JZTDKvbsuiGjii6Q58Qv/x0lFRmqPmaMPQibEXuo/lbsmirjJn4tvgS7Jr4AzJCCr133K7jFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Suvwrmqs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U5qQMT009816;
	Tue, 30 Jan 2024 06:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=DN50dkFNzZHZO6mIFcXrtiDFRYOkaQUQ8s6SgKZiSd8=; b=Su
	vwrmqszBtI9RmluiE3U6pXPnkPaDUocM/seZgfD6ODtRoCwOaZ4JpwKtbYB96WMJ
	OTBvy1hTFH7xy0Vp9rCDUlS01nSuIEusuHb+KPwKCPyP3nj2jWIgp2otu8msppjv
	CvUutAhIDabSvBcrgKqMuNBH8ksa4hBciq3Cu5IZSlY4dubXjuoOWEWint2GMG+5
	MLVHbwJQdTguC2zST4kUNMszHYtoz5ExBNGxFQz/sl5u/tmkt53DPrmT7jFDTjs7
	1tUz8nSrgTJRXmnuew8UvSe8oYmJMfaFsyCSrz61fdw1L9dQE2GR0P81YoJuD6ca
	s7LPLU0OtWZldwxEK3Xg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxhjrs4um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 06:08:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U68uh0019701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 06:08:56 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 22:08:54 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/3] wifi: ath12k: Refactor the hardware recovery procedure
Date: Tue, 30 Jan 2024 11:38:36 +0530
Message-ID: <20240130060838.3895599-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
References: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 4yYgZzkqvkzeoEps0ksJJla0vI9O-sce
X-Proofpoint-ORIG-GUID: 4yYgZzkqvkzeoEps0ksJJla0vI9O-sce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300042

Currently, in multi-wiphy models, the recovery handler access mac80211
HW from the radio/link structure. This will be incorrect for single wiphy
model, as they will hold multiple link/radio structures. To fix this,
access mac80211 HW based on the number of hardware in the SoC/chip. This
approach makes the recovery handler compatible with both multi wiphy and
single wiphy models.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 119 +++++++++++++------------
 drivers/net/wireless/ath/ath12k/mac.c  |  25 ++++--
 2 files changed, 82 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 1baad3302157..feca204b82b9 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -922,9 +922,8 @@ void ath12k_core_halt(struct ath12k *ar)
 static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
 	struct ath12k_hw *ah;
-	int i;
+	int i, j;
 
 	spin_lock_bh(&ab->base_lock);
 	ab->stats.fw_crash_counter++;
@@ -934,34 +933,33 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	for (i = 0; i < ab->num_hw; i++) {
-		if (!ab->ah[i])
+		ah = ab->ah[i];
+		if (!ah)
 			continue;
 
-		ah = ab->ah[i];
 		ieee80211_stop_queues(ah->hw);
-	}
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		if (!ar || ar->state == ATH12K_STATE_OFF)
-			continue;
-
-		ath12k_mac_drain_tx(ar);
-		complete(&ar->scan.started);
-		complete(&ar->scan.completed);
-		complete(&ar->peer_assoc_done);
-		complete(&ar->peer_delete_done);
-		complete(&ar->install_key_done);
-		complete(&ar->vdev_setup_done);
-		complete(&ar->vdev_delete_done);
-		complete(&ar->bss_survey_done);
-
-		wake_up(&ar->dp.tx_empty_waitq);
-		idr_for_each(&ar->txmgmt_idr,
-			     ath12k_mac_tx_mgmt_pending_free, ar);
-		idr_destroy(&ar->txmgmt_idr);
-		wake_up(&ar->txmgmt_empty_waitq);
+		for (j = 0; j < ah->num_radio; j++) {
+			ar = &ah->radio[j];
+			if (!ar || ar->state == ATH12K_STATE_OFF)
+				continue;
+
+			ath12k_mac_drain_tx(ar);
+			complete(&ar->scan.started);
+			complete(&ar->scan.completed);
+			complete(&ar->peer_assoc_done);
+			complete(&ar->peer_delete_done);
+			complete(&ar->install_key_done);
+			complete(&ar->vdev_setup_done);
+			complete(&ar->vdev_delete_done);
+			complete(&ar->bss_survey_done);
+
+			wake_up(&ar->dp.tx_empty_waitq);
+			idr_for_each(&ar->txmgmt_idr,
+				     ath12k_mac_tx_mgmt_pending_free, ar);
+			idr_destroy(&ar->txmgmt_idr);
+			wake_up(&ar->txmgmt_empty_waitq);
+		}
 	}
 
 	wake_up(&ab->wmi_ab.tx_credits_wq);
@@ -970,41 +968,52 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 
 static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 {
+	struct ath12k_hw *ah;
 	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
-	int i;
+	int i, j;
+	u8 restart_count;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		if (!ar || ar->state == ATH12K_STATE_OFF)
+	for (i = 0; i < ab->num_hw; i++) {
+		ah = ab->ah[i];
+		if (!ah)
 			continue;
 
-		mutex_lock(&ar->conf_mutex);
-
-		switch (ar->state) {
-		case ATH12K_STATE_ON:
-			ar->state = ATH12K_STATE_RESTARTING;
-			ath12k_core_halt(ar);
-			ieee80211_restart_hw(ath12k_ar_to_hw(ar));
-			break;
-		case ATH12K_STATE_OFF:
-			ath12k_warn(ab,
-				    "cannot restart radio %d that hasn't been started\n",
-				    i);
-			break;
-		case ATH12K_STATE_RESTARTING:
-			break;
-		case ATH12K_STATE_RESTARTED:
-			ar->state = ATH12K_STATE_WEDGED;
-			fallthrough;
-		case ATH12K_STATE_WEDGED:
-			ath12k_warn(ab,
-				    "device is wedged, will not restart radio %d\n", i);
-			break;
+		for (j = 0, restart_count = 0; j < ah->num_radio; j++) {
+			ar = &ah->radio[j];
+			if (ar->state == ATH12K_STATE_OFF)
+				continue;
+
+			mutex_lock(&ar->conf_mutex);
+
+			switch (ar->state) {
+			case ATH12K_STATE_ON:
+				ar->state = ATH12K_STATE_RESTARTING;
+				ath12k_core_halt(ar);
+				restart_count++;
+				break;
+			case ATH12K_STATE_OFF:
+				ath12k_warn(ab,
+					    "cannot restart radio %d that hasn't been started\n",
+					    j);
+				break;
+			case ATH12K_STATE_RESTARTING:
+				break;
+			case ATH12K_STATE_RESTARTED:
+				ar->state = ATH12K_STATE_WEDGED;
+				fallthrough;
+			case ATH12K_STATE_WEDGED:
+				ath12k_warn(ab,
+					    "device is wedged, will not restart radio %d\n", j);
+				break;
+			}
+			mutex_unlock(&ar->conf_mutex);
 		}
-		mutex_unlock(&ar->conf_mutex);
+
+		/* Restart after all the link/radio got restart */
+		if (restart_count == ah->num_radio)
+			ieee80211_restart_hw(ah->hw);
 	}
+
 	complete(&ab->driver_recovery);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a27480a69b27..1b465f7fed7f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7114,26 +7114,35 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 	struct ath12k_vif *arvif;
-	int recovery_count;
+	int recovery_count, i;
 
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
-	ar = ath12k_ah_to_ar(ah);
-	ab = ar->ab;
+	for (i = 0; i < ah->num_radio; i++) {
+		ar = &ah->radio[i];
 
-	mutex_lock(&ar->conf_mutex);
+		mutex_lock(&ar->conf_mutex);
+
+		if (ar->state != ATH12K_STATE_RESTARTED) {
+			mutex_unlock(&ar->conf_mutex);
+			continue;
+		}
+
+		ab = ar->ab;
 
-	if (ar->state == ATH12K_STATE_RESTARTED) {
 		ath12k_warn(ar->ab, "pdev %d successfully recovered\n",
 			    ar->pdev->pdev_id);
+
 		ar->state = ATH12K_STATE_ON;
 		ieee80211_wake_queues(hw);
 
 		if (ab->is_reset) {
 			recovery_count = atomic_inc_return(&ab->recovery_count);
+
 			ath12k_dbg(ab, ATH12K_DBG_BOOT, "recovery count %d\n",
 				   recovery_count);
+
 			/* When there are multiple radios in an SOC,
 			 * the recovery has to be done for each radio
 			 */
@@ -7152,6 +7161,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				   arvif->key_cipher,
 				   arvif->is_up,
 				   arvif->vdev_type);
+
 			/* After trigger disconnect, then upper layer will
 			 * trigger connect again, then the PN number of
 			 * upper layer will be reset to keep up with AP
@@ -7161,13 +7171,14 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 			    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
 			    arvif->vdev_subtype == WMI_VDEV_SUBTYPE_NONE) {
 				ieee80211_hw_restart_disconnect(arvif->vif);
+
 				ath12k_dbg(ab, ATH12K_DBG_BOOT,
 					   "restart disconnect\n");
 			}
 		}
-	}
 
-	mutex_unlock(&ar->conf_mutex);
+		mutex_unlock(&ar->conf_mutex);
+	}
 }
 
 static void
-- 
2.34.1


