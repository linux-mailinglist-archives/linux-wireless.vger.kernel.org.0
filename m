Return-Path: <linux-wireless+bounces-2776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2121841BBF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 07:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D6C284D5E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 06:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6317383A0;
	Tue, 30 Jan 2024 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jQpT9/eJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64B38384
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594944; cv=none; b=FXTonS3tJgiTUXctNHZKnVmJ7E0sMyhJHx7eTGyTyHM3bNPnz6hDXc0TJE2oy3iraL9dFFaUPGbpaYMrH0RAM21kcrKSMjr7C/bU8bGMOgOkdlPkS1Nj+3Y2QJwTJCzMo1rDZifHCO1VM4aUd+SIV4+Kg7rl+RXn09iMGb6sRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594944; c=relaxed/simple;
	bh=hKT7DJ1msfKu+uIT95mg3Vu6dJ0Cln26XWc2OK0FaAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYCe36A2o1VAfqikMLh6qQZnH8NU6RjvER+5DOmo0MKVvwu9O2GEbUvNWB6tbt4uFH2AnTKxo5CEeSv/DE0DOCqkWEXjLp7xZlL1TVSPxd+vd1juj+l70MTh9wTF6pw71yBa2CSsk4PR3Ndt2GzqnMTC0kEu6XrJGD7/Wspcn4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jQpT9/eJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U5KkM5026446;
	Tue, 30 Jan 2024 06:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=wdEMmto+Z8Qs5ZH4jeox/Uh86zL8uwIjP+oWJ0vSKZ0=; b=jQ
	pT9/eJedT7QtaTfq+onew9kQILIPUzjDq9dSR2eZK54MdlV2EunykBfYrWdtwJWb
	kiP5MBECGAblaQ7EVkz9RPSBcNd8gUV6uIoLnZU/oD+gOXItN5h5ALl2A+h2alkG
	96e/f3vQxXNB2pEeWCuumBjADuTpvbMDryT5f5QztukVVqrtN5vLtlKv9hNhmJvp
	LRposXr2oVQhYrubFb0+VfsHTgkPEuQGmDbr668zZ5rv0BxhU4Lrf6RQF5oq3LtQ
	vLDud5RlacfiJwARMyvnA1vIrjc6XNw+DXq60gWM8v/LmJ0kz+/7xfaNyuwix162
	/Qa1kAbkjS1BcsByyA1w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxr2v0bwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 06:09:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U69084027106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 06:09:00 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 22:08:58 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: Refactor the hardware state
Date: Tue, 30 Jan 2024 11:38:38 +0530
Message-ID: <20240130060838.3895599-4-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: A-NSGJ5oiH8XvAVcQdETdZ0WDoWMpNA-
X-Proofpoint-ORIG-GUID: A-NSGJ5oiH8XvAVcQdETdZ0WDoWMpNA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300042

Currently, in multi wiphy models, the mac80211 hardware state is maintained
within the radio/link structure. However, in single wiphy models, the
mac80211 hardware state is needed at the hardware abstraction layer
(ath12k_hw). Therefore, move the hardware state from the radio/link
structure to the hardware abstraction layer (ath12k_hw). Additionally,
update the naming convention of the state enums to enhance clarity and
consistency.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 58 +++++++++------------
 drivers/net/wireless/ath/ath12k/core.h | 20 ++++---
 drivers/net/wireless/ath/ath12k/mac.c  | 72 ++++++++++++++------------
 drivers/net/wireless/ath/ath12k/reg.c  |  5 +-
 4 files changed, 80 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 4ea5eacc1342..48134aa1dac7 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -934,15 +934,13 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 
 	for (i = 0; i < ab->num_hw; i++) {
 		ah = ab->ah[i];
-		if (!ah)
+		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
 		ieee80211_stop_queues(ah->hw);
 
 		for (j = 0; j < ah->num_radio; j++) {
 			ar = &ah->radio[j];
-			if (!ar || ar->state == ATH12K_STATE_OFF)
-				continue;
 
 			ath12k_mac_drain_tx(ar);
 			complete(&ar->scan.started);
@@ -971,49 +969,43 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	struct ath12k_hw *ah;
 	struct ath12k *ar;
 	int i, j;
-	u8 restart_count;
 
 	for (i = 0; i < ab->num_hw; i++) {
 		ah = ab->ah[i];
-		if (!ah)
+		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
 		mutex_lock(&ah->conf_mutex);
 
-		for (j = 0, restart_count = 0; j < ah->num_radio; j++) {
-			ar = &ah->radio[j];
-			if (ar->state == ATH12K_STATE_OFF)
-				continue;
+		switch (ah->state) {
+		case ATH12K_HW_STATE_ON:
+			ah->state = ATH12K_HW_STATE_RESTARTING;
 
-			mutex_lock(&ar->conf_mutex);
+			for (j = 0; j < ah->num_radio; j++) {
+				ar = &ah->radio[j];
 
-			switch (ar->state) {
-			case ATH12K_STATE_ON:
-				ar->state = ATH12K_STATE_RESTARTING;
+				mutex_lock(&ar->conf_mutex);
 				ath12k_core_halt(ar);
-				restart_count++;
-				break;
-			case ATH12K_STATE_OFF:
-				ath12k_warn(ab,
-					    "cannot restart radio %d that hasn't been started\n",
-					    j);
-				break;
-			case ATH12K_STATE_RESTARTING:
-				break;
-			case ATH12K_STATE_RESTARTED:
-				ar->state = ATH12K_STATE_WEDGED;
-				fallthrough;
-			case ATH12K_STATE_WEDGED:
-				ath12k_warn(ab,
-					    "device is wedged, will not restart radio %d\n", j);
-				break;
+				mutex_unlock(&ar->conf_mutex);
 			}
-			mutex_unlock(&ar->conf_mutex);
-		}
 
-		/* Restart after all the link/radio got restart */
-		if (restart_count == ah->num_radio)
 			ieee80211_restart_hw(ah->hw);
+			break;
+		case ATH12K_HW_STATE_OFF:
+			ath12k_warn(ab,
+				    "cannot restart hw %d that hasn't been started\n",
+				    i);
+			break;
+		case ATH12K_HW_STATE_RESTARTING:
+			break;
+		case ATH12K_HW_STATE_RESTARTED:
+			ah->state = ATH12K_HW_STATE_WEDGED;
+			fallthrough;
+		case ATH12K_HW_STATE_WEDGED:
+			ath12k_warn(ab,
+				    "device is wedged, will not restart hw %d\n", i);
+			break;
+		}
 
 		mutex_unlock(&ah->conf_mutex);
 	}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 660c1b260201..64d1bd4898e5 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -430,12 +430,12 @@ struct ath12k_sta {
 #define ATH12K_NUM_CHANS 100
 #define ATH12K_MAX_5G_CHAN 173
 
-enum ath12k_state {
-	ATH12K_STATE_OFF,
-	ATH12K_STATE_ON,
-	ATH12K_STATE_RESTARTING,
-	ATH12K_STATE_RESTARTED,
-	ATH12K_STATE_WEDGED,
+enum ath12k_hw_state {
+	ATH12K_HW_STATE_OFF,
+	ATH12K_HW_STATE_ON,
+	ATH12K_HW_STATE_RESTARTING,
+	ATH12K_HW_STATE_RESTARTED,
+	ATH12K_HW_STATE_WEDGED,
 	/* Add other states as required */
 };
 
@@ -480,7 +480,6 @@ struct ath12k {
 	u32 ht_cap_info;
 	u32 vht_cap_info;
 	struct ath12k_he ar_he;
-	enum ath12k_state state;
 	bool supports_6ghz;
 	struct {
 		struct completion started;
@@ -599,9 +598,11 @@ struct ath12k {
 
 struct ath12k_hw {
 	struct ieee80211_hw *hw;
+	struct ath12k_base *ab;
 
 	/* To synchronize hardware restart operation */
 	struct mutex conf_mutex;
+	enum ath12k_hw_state state;
 
 	u8 num_radio;
 
@@ -934,6 +935,11 @@ static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah)
 	return ah->radio;
 }
 
+static inline struct ath12k_hw *ath12k_ar_to_ah(struct ath12k *ar)
+{
+	return ar->ah;
+}
+
 static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
 {
 	return ar->ah->hw;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4c9a591778a2..de6b1f357fbb 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4808,6 +4808,7 @@ static void ath12k_mac_setup_sband_iftype_data(struct ath12k *ar,
 
 static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
 {
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -4821,8 +4822,8 @@ static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
 	ar->cfg_tx_chainmask = tx_ant;
 	ar->cfg_rx_chainmask = rx_ant;
 
-	if (ar->state != ATH12K_STATE_ON &&
-	    ar->state != ATH12K_STATE_RESTARTED)
+	if (ah->state != ATH12K_HW_STATE_ON &&
+	    ah->state != ATH12K_HW_STATE_RESTARTED)
 		return 0;
 
 	ret = ath12k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_TX_CHAIN_MASK,
@@ -5120,7 +5121,7 @@ static void ath12k_mac_wait_reconfigure(struct ath12k_base *ab)
 
 static int ath12k_mac_start(struct ath12k *ar)
 {
-	struct ath12k_hw *ah = ar->ah;
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev *pdev = ar->pdev;
 	int ret;
@@ -5129,22 +5130,6 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 	mutex_lock(&ar->conf_mutex);
 
-	switch (ar->state) {
-	case ATH12K_STATE_OFF:
-		ar->state = ATH12K_STATE_ON;
-		break;
-	case ATH12K_STATE_RESTARTING:
-		ar->state = ATH12K_STATE_RESTARTED;
-		ath12k_mac_wait_reconfigure(ab);
-		break;
-	case ATH12K_STATE_RESTARTED:
-	case ATH12K_STATE_WEDGED:
-	case ATH12K_STATE_ON:
-		WARN_ON(1);
-		ret = -EINVAL;
-		goto err;
-	}
-
 	ret = ath12k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_PMF_QOS,
 					1, pdev->pdev_id);
 
@@ -5235,7 +5220,6 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 	return 0;
 err:
-	ar->state = ATH12K_STATE_OFF;
 	mutex_unlock(&ar->conf_mutex);
 
 	return ret;
@@ -5252,11 +5236,33 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 
 	mutex_lock(&ah->conf_mutex);
 
+	switch (ah->state) {
+	case ATH12K_HW_STATE_OFF:
+		ah->state = ATH12K_HW_STATE_ON;
+		break;
+	case ATH12K_HW_STATE_RESTARTING:
+		ah->state = ATH12K_HW_STATE_RESTARTED;
+		ath12k_mac_wait_reconfigure(ah->ab);
+		break;
+	case ATH12K_HW_STATE_RESTARTED:
+	case ATH12K_HW_STATE_WEDGED:
+	case ATH12K_HW_STATE_ON:
+		ah->state = ATH12K_HW_STATE_OFF;
+
+		WARN_ON(1);
+		ret = -EINVAL;
+		goto err;
+	}
+
 	ret = ath12k_mac_start(ar);
-	if (ret)
+	if (ret) {
+		ah->state = ATH12K_HW_STATE_OFF;
+
 		ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
 			   ar->pdev_idx, ret);
+	}
 
+err:
 	mutex_unlock(&ah->conf_mutex);
 
 	return ret;
@@ -5321,7 +5327,7 @@ int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable)
 
 static void ath12k_mac_stop(struct ath12k *ar)
 {
-	struct ath12k_hw *ah = ar->ah;
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
 	int ret;
 
@@ -5334,7 +5340,6 @@ static void ath12k_mac_stop(struct ath12k *ar)
 			   ret);
 
 	clear_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
-	ar->state = ATH12K_STATE_OFF;
 	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
@@ -5364,6 +5369,7 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 
 	mutex_lock(&ah->conf_mutex);
 
+	ah->state = ATH12K_HW_STATE_OFF;
 	ath12k_mac_stop(ar);
 
 	mutex_unlock(&ah->conf_mutex);
@@ -7133,24 +7139,23 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
+	if (ah->state != ATH12K_HW_STATE_RESTARTED) {
+		mutex_unlock(&ah->conf_mutex);
+		return;
+	}
+
+	ah->state = ATH12K_HW_STATE_ON;
+	ieee80211_wake_queues(hw);
+
 	for (i = 0; i < ah->num_radio; i++) {
 		ar = &ah->radio[i];
+		ab = ar->ab;
 
 		mutex_lock(&ar->conf_mutex);
 
-		if (ar->state != ATH12K_STATE_RESTARTED) {
-			mutex_unlock(&ar->conf_mutex);
-			continue;
-		}
-
-		ab = ar->ab;
-
 		ath12k_warn(ar->ab, "pdev %d successfully recovered\n",
 			    ar->pdev->pdev_id);
 
-		ar->state = ATH12K_STATE_ON;
-		ieee80211_wake_queues(hw);
-
 		if (ab->is_reset) {
 			recovery_count = atomic_inc_return(&ab->recovery_count);
 
@@ -7939,6 +7944,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 
 	ah = ath12k_hw_to_ah(hw);
 	ah->hw = hw;
+	ah->ab = ab;
 	ah->num_radio = num_pdev_map;
 
 	mutex_init(&ah->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index f308e9a6ed55..4fcd6af3696e 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -200,7 +200,8 @@ static void ath12k_copy_regd(struct ieee80211_regdomain *regd_orig,
 
 int ath12k_regd_update(struct ath12k *ar, bool init)
 {
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	struct ieee80211_hw *hw = ah->hw;
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
 	int ret, regd_len, pdev_id;
 	struct ath12k_base *ab;
@@ -258,7 +259,7 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	if (ret)
 		goto err;
 
-	if (ar->state == ATH12K_STATE_ON) {
+	if (ah->state == ATH12K_HW_STATE_ON) {
 		ret = ath12k_reg_update_chan_list(ar);
 		if (ret)
 			goto err;
-- 
2.34.1


