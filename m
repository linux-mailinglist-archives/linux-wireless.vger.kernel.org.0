Return-Path: <linux-wireless+bounces-6825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957338B1D58
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5384D283C88
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35E84E17;
	Thu, 25 Apr 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AKhwbsi/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F68120A
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035814; cv=none; b=sjYDF1Kl9D+tRJSdrPoSFA4pRQ/akAig1c63O5oz1svWEbEHgXEuS0na78WrQIYzEqHX83qeW+O+Ecao6x0SPQ42EX5BDFpG6wSoca93NHDwaL6LEwVA/iN/HJj1rI0GRCYtEdfXkXtym9aX/FFU9NcxyneVDT7NDkQ6MZlR6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035814; c=relaxed/simple;
	bh=uoGJpkbCXh82yA5PI41yaDxvfwfdB+tM8Qf3Stc2sb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbWZK0X6Z+khoKIz9BraQrYuqWzpe5B9K9QdV6WpF0iKx8yrgxdqu978vAHpNfTdFhMxHeprbvIa46Th9ShT2z8O5TvAvngT/K/PW0MfS9rKQxkwTekhI4zoE8I09htc72vt8VCyfkMh5dfgUPJ3Yc4lyLAHqttmylztJ/99lco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AKhwbsi/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P6wfJ1026776;
	Thu, 25 Apr 2024 09:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9pBS6CRAdzAZVR7RJhs/+GKpJ6CSpJ9MvpPb+rSj12A=; b=AK
	hwbsi/bGRl6Ve9Rc+V06ILDzDK+TD6l8zIPaN1OZtqVcnUxdWJ3xa0+64tHzwTY8
	OrhB/1bm42C8cldlbMWTJi2XqA7r6UDfFIIc1SGNRvmOL5NA96uUpc4d6VnLEkoA
	Kd4PVL+AYm2tL3oXMeLnDf6nySSW5FRWd0dIwhexhEnyc1hQurBstRqwNcTYRjPv
	aOjpnN/BidAsknbJaCyZSAhWj1+issCRMDwpbRddrEiqvCl7XbK/tmo6KzyizxZ1
	uUiaHjKqQYxjS1VgcToqkj/7XJmG3gd/uAmB4UdTsGmxdPu6+ST/bktwt1DqR7O0
	oOC225eGPaRkbL79l1ag==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenp9ft3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:03:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P93P0U014630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:03:25 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 02:03:23 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 2/3] wifi: ath12k: Refactor the hardware state
Date: Thu, 25 Apr 2024 14:33:06 +0530
Message-ID: <20240425090307.3233434-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425090307.3233434-1-quic_periyasa@quicinc.com>
References: <20240425090307.3233434-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: pRYG1nDLVaRwHAsSmGF-qaUen9eABQjp
X-Proofpoint-ORIG-GUID: pRYG1nDLVaRwHAsSmGF-qaUen9eABQjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250063

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
 drivers/net/wireless/ath/ath12k/core.c | 59 +++++++++++--------------
 drivers/net/wireless/ath/ath12k/core.h | 22 ++++++----
 drivers/net/wireless/ath/ath12k/mac.c  | 61 ++++++++++++++------------
 drivers/net/wireless/ath/ath12k/reg.c  | 19 ++++----
 4 files changed, 83 insertions(+), 78 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ae14614c3568..a685cfd6fd92 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1006,15 +1006,13 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 
 	for (i = 0; i < ab->num_hw; i++) {
 		ah = ab->ah[i];
-		if (!ah)
+		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
 		ieee80211_stop_queues(ah->hw);
 
 		for (j = 0; j < ah->num_radio; j++) {
 			ar = &ah->radio[j];
-			if (ar->state == ATH12K_STATE_OFF)
-				continue;
 
 			ath12k_mac_drain_tx(ar);
 			complete(&ar->scan.started);
@@ -1044,47 +1042,42 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	struct ath12k_hw *ah;
 	struct ath12k *ar;
 	int i, j;
-	u8 restart_count;
 
 	for (i = 0; i < ab->num_hw; i++) {
 		ah = ab->ah[i];
-		if (!ah)
+		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
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
+			/* Restart after all the link/radio halt */
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
 	}
 
 	complete(&ab->driver_recovery);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 47dde4401210..c4eb8b25398c 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -457,12 +457,12 @@ struct ath12k_sta {
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
 
@@ -511,7 +511,6 @@ struct ath12k {
 	u32 ht_cap_info;
 	u32 vht_cap_info;
 	struct ath12k_he ar_he;
-	enum ath12k_state state;
 	bool supports_6ghz;
 	struct {
 		struct completion started;
@@ -636,10 +635,12 @@ struct ath12k {
 
 struct ath12k_hw {
 	struct ieee80211_hw *hw;
+	struct ath12k_base *ab;
+	enum ath12k_hw_state state;
 	bool regd_updated;
 	bool use_6ghz_regd;
-
 	u8 num_radio;
+
 	struct ath12k radio[] __aligned(sizeof(void *));
 };
 
@@ -1037,6 +1038,11 @@ static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah, u8 hw_link_id
 	return &ah->radio[hw_link_id];
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
index 27664845e990..710ed8fa79fd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5269,6 +5269,7 @@ static void ath12k_mac_setup_sband_iftype_data(struct ath12k *ar,
 
 static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
 {
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -5289,8 +5290,8 @@ static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
 	ar->cfg_tx_chainmask = tx_ant;
 	ar->cfg_rx_chainmask = rx_ant;
 
-	if (ar->state != ATH12K_STATE_ON &&
-	    ar->state != ATH12K_STATE_RESTARTED)
+	if (ah->state != ATH12K_HW_STATE_ON &&
+	    ah->state != ATH12K_HW_STATE_RESTARTED)
 		return 0;
 
 	ret = ath12k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_TX_CHAIN_MASK,
@@ -5620,22 +5621,6 @@ static int ath12k_mac_start(struct ath12k *ar)
 
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
 
@@ -5726,7 +5711,6 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 	return 0;
 err:
-	ar->state = ATH12K_STATE_OFF;
 	mutex_unlock(&ar->conf_mutex);
 
 	return ret;
@@ -5749,9 +5733,28 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 
 	ath12k_drain_tx(ah);
 
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
+		return -EINVAL;
+	}
+
 	for_each_ar(ah, ar, i) {
 		ret = ath12k_mac_start(ar);
 		if (ret) {
+			ah->state = ATH12K_HW_STATE_OFF;
+
 			ath12k_err(ar->ab, "fail to start mac operations in pdev idx %d ret %d\n",
 				   ar->pdev_idx, ret);
 			goto fail_start;
@@ -5759,11 +5762,13 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 	}
 
 	return 0;
+
 fail_start:
 	for (; i > 0; i--) {
 		ar = ath12k_ah_to_ar(ah, i - 1);
 		ath12k_mac_stop(ar);
 	}
+
 	return ret;
 }
 
@@ -5836,7 +5841,6 @@ static void ath12k_mac_stop(struct ath12k *ar)
 			   ret);
 
 	clear_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
-	ar->state = ATH12K_STATE_OFF;
 	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
@@ -5865,6 +5869,8 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 
 	ath12k_drain_tx(ah);
 
+	ah->state = ATH12K_HW_STATE_OFF;
+
 	for_each_ar(ah, ar, i)
 		ath12k_mac_stop(ar);
 }
@@ -7915,22 +7921,20 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
+	if (ah->state != ATH12K_HW_STATE_RESTARTED)
+		return;
+
+	ah->state = ATH12K_HW_STATE_ON;
+	ieee80211_wake_queues(hw);
+
 	for_each_ar(ah, ar, i) {
 		mutex_lock(&ar->conf_mutex);
 
-		if (ar->state != ATH12K_STATE_RESTARTED) {
-			mutex_unlock(&ar->conf_mutex);
-			continue;
-		}
-
 		ab = ar->ab;
 
 		ath12k_warn(ar->ab, "pdev %d successfully recovered\n",
 			    ar->pdev->pdev_id);
 
-		ar->state = ATH12K_STATE_ON;
-		ieee80211_wake_queues(hw);
-
 		if (ab->is_reset) {
 			recovery_count = atomic_inc_return(&ab->recovery_count);
 
@@ -8916,6 +8920,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 
 	ah = ath12k_hw_to_ah(hw);
 	ah->hw = hw;
+	ah->ab = ab;
 	ah->num_radio = num_pdev_map;
 
 	for (i = 0; i < num_pdev_map; i++) {
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index fbf38044938c..439d61f284d8 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -206,9 +206,9 @@ static void ath12k_copy_regd(struct ieee80211_regdomain *regd_orig,
 
 int ath12k_regd_update(struct ath12k *ar, bool init)
 {
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	struct ieee80211_hw *hw = ah->hw;
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
-	struct ath12k_hw *ah = ar->ah;
 	int ret, regd_len, pdev_id;
 	struct ath12k_base *ab;
 	int i;
@@ -286,19 +286,20 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	if (ret)
 		goto err;
 
+	if (ah->state != ATH12K_HW_STATE_ON)
+		goto skip;
+
 	ah->regd_updated = true;
 	/* Apply the new regd to all the radios, this is expected to be received only once
 	 * since we check for ah->regd_updated and allow here only once.
 	 */
 	for_each_ar(ah, ar, i) {
-		if (ar->state == ATH12K_STATE_ON) {
-			ab = ar->ab;
-			ret = ath12k_reg_update_chan_list(ar);
-			if (ret)
-				goto err;
-		}
+		ab = ar->ab;
+		ret = ath12k_reg_update_chan_list(ar);
+		if (ret)
+			goto err;
 	}
-
+skip:
 	return 0;
 err:
 	ath12k_warn(ab, "failed to perform regd update : %d\n", ret);
-- 
2.34.1


