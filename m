Return-Path: <linux-wireless+bounces-6756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7E8B02BA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 08:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691FA283D8E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 06:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468BF157A42;
	Wed, 24 Apr 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JHNWFCQD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB408157499
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941830; cv=none; b=pxInGOiXxzG6ELyZ+COerguK9PI84f9RNQUQKEzePbMZQsi0tTLYH5O0afvyre62v9Z0Z69t8O1Uto8qqvpop+hneUJ7OlUDdjC/lVl3TLE1ndMfGrKsTra5c2s4FDLZ9jk/O0X1Y0n0ek2SoxzWxmTbhtkcJLc5PU92p/Mfzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941830; c=relaxed/simple;
	bh=JD2p7s7kbhtUhW0mrBF2kw+fCe/LnrPk8XX6gkJs+ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+7rQdeMADcvYgpa16v/7/+sK9srffeTWaS9cKXGj0aqrx6DkTwXBP6/xAC7jH2mtLA9sw7aKCB/WAJToiLby/yKnBcx45YwwWTSzs+s4e5sT2BtB2wqS618j/ctU44CR/Oryg9zYFh157aYxyxgdHLUpRvTVTgCa4TTD/lnf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JHNWFCQD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6Ysuq025418;
	Wed, 24 Apr 2024 06:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ScvVLPyizI7eI5s8b8MzmiX/YNpdyAW+i7m4edc+tUE=; b=JH
	NWFCQD0NyaIj1qN/WB5bw418QSnOpal8LNHNLaiHtIiB4Nmh3DGwGsNfuRObsC3e
	/t20o2lqb6srROt79uEb0t4kEkmaZAmo2y2gOzJEbsL0K3kup1tPOqf+HNFtc3og
	qEnsFoCah18sg/j2uC490WrPSc3tcB+DlmOIseg8D4+pY4XV7DFQYRfut/MeG1Dj
	qJAvxvYF02HqGxXfgkG9upJdnMEVFc7AqRBmNCy4mN9LR0HFcmKEvLRTic4S2bcf
	2U6zBEPFsPsabsxg6VB8tdJm6H/TPg0aSaAPVR8dzJVwyuqvALsXuWh13jTK/eul
	l9O+BxAdi6XSEiypQMUw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fg40x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 06:57:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O6v4SY002306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 06:57:04 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 23:57:02 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 1/3] wifi: ath12k: Refactor the hardware recovery procedure
Date: Wed, 24 Apr 2024 12:26:44 +0530
Message-ID: <20240424065646.1666166-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
References: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: qdEyR6ceMIOTEhM1P5Qu_3NptliM8YmR
X-Proofpoint-ORIG-GUID: qdEyR6ceMIOTEhM1P5Qu_3NptliM8YmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_04,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240030

Currently, in multi-wiphy models, the recovery handler access mac80211
HW from the radio/link structure. This will be incorrect for single wiphy
model, as they will hold multiple link/radio structures. To fix this,
access mac80211 HW based on the number of hardware in the SoC/chip. This
approach makes the recovery handler compatible with both multi wiphy and
single wiphy models.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 119 +++++++++++++------------
 drivers/net/wireless/ath/ath12k/mac.c  |  23 +++--
 2 files changed, 80 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 6663f4e1792d..5fed86a0cedf 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -994,9 +994,8 @@ void ath12k_core_halt(struct ath12k *ar)
 static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
-	struct ath12k_pdev *pdev;
 	struct ath12k_hw *ah;
-	int i;
+	int i, j;
 
 	spin_lock_bh(&ab->base_lock);
 	ab->stats.fw_crash_counter++;
@@ -1006,35 +1005,34 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
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
+		for (j = 0; j < ah->num_radio; j++) {
+			ar = &ah->radio[j];
+			if (!ar || ar->state == ATH12K_STATE_OFF)
+				continue;
 
-		ath12k_mac_drain_tx(ar);
-		complete(&ar->scan.started);
-		complete(&ar->scan.completed);
-		complete(&ar->scan.on_channel);
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
+			ath12k_mac_drain_tx(ar);
+			complete(&ar->scan.started);
+			complete(&ar->scan.completed);
+			complete(&ar->scan.on_channel);
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
@@ -1043,41 +1041,52 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 
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
index f6cf8b8c4b18..ba594d87e26e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7837,26 +7837,33 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 	struct ath12k_vif *arvif;
-	int recovery_count;
+	int recovery_count, i;
 
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
-	ar = ath12k_ah_to_ar(ah, 0);
-	ab = ar->ab;
+	for_each_ar(ah, ar, i) {
+		mutex_lock(&ar->conf_mutex);
 
-	mutex_lock(&ar->conf_mutex);
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
@@ -7875,6 +7882,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				   arvif->key_cipher,
 				   arvif->is_up,
 				   arvif->vdev_type);
+
 			/* After trigger disconnect, then upper layer will
 			 * trigger connect again, then the PN number of
 			 * upper layer will be reset to keep up with AP
@@ -7884,13 +7892,14 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
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


