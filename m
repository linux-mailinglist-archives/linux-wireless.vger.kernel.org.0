Return-Path: <linux-wireless+bounces-1692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2AD82A710
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 05:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5562887BF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 04:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC99568D;
	Thu, 11 Jan 2024 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZY8sJqOn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143FC5677
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B3B1uP008827;
	Thu, 11 Jan 2024 04:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=fgCdLovwfV7ruXGF2yxe
	Y8X7MzpsosEPVW576V1vHr4=; b=ZY8sJqOnWwzfiEJ5wmKV5i7JmPON2hAmqTp+
	RyyQ45XSzuDTwUnQxp9XRSPP6MBSt0wa5YKBhlimhZT4Ox3EH7ZVQbli8pUqH4Yx
	NvuK3yJkgOJna7PbR2Kn10GcdA4lKoBomv184YRVbOGWYLFv2rbhILRmUOAlesi5
	21tYEtFbghgZktf6FvB4EyJR+r8bdnp/WNFlmrVUZ/molQps2Q8IM++UQBIx0/RK
	3qAxgR7O69YZ9yJlXA88T8NppkD1b6141ecY0Ny56ZYHpSR72guqV8xEQpi1/VxU
	70/71d2nWu+oaF3QXmfT5JKJ4gwD3GB60E8Ig6OpbMLhbmuS1g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj16k8wc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B4pVgb017383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:31 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 20:51:29 -0800
From: Sriram R <quic_srirrama@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 06/12] wifi: ath12k: fetch correct radio based on vdev status
Date: Thu, 11 Jan 2024 10:20:39 +0530
Message-ID: <20240111045045.28377-7-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111045045.28377-1-quic_srirrama@quicinc.com>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n_zlCCl_W6A6PUYWvXHvglc7wG4Fy3Q2
X-Proofpoint-GUID: n_zlCCl_W6A6PUYWvXHvglc7wG4Fy3Q2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=624 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110035

For ops which passes the vif info, fetch the radio(ar)
to be used for corresponding functions based on the
the vdev creation status. If the vdev is not created yet,
which could happen when the ops are called before channel
is assigned for the vif, the data needs to be cached and this
is done in followup changes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 84 ++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c20567db1e35..13203ca500f2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -645,6 +645,26 @@ static struct ath12k *ath12k_get_ar_by_ctx(struct ieee80211_hw *hw,
 	return ath12k_mac_get_ar_by_chan(hw, ctx->def.chan);
 }
 
+static struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+
+	lockdep_assert_held(&ah->conf_mutex);
+
+	/* If there is one pdev within ah, then we return
+	 * ar directly.
+	 */
+	if (ah->num_radio == 1)
+		return ah->radio;
+
+	if (arvif->is_created)
+		return arvif->ar;
+
+	return NULL;
+}
+
 static void ath12k_pdev_caps_update(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -2837,7 +2857,15 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+
+	/* TODO if the vdev is not created on a certain radio,
+	 * cache the info to be updated later on vdev creation
+	 */
+	if (!ar) {
+		mutex_unlock(&ah->conf_mutex);
+		return;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3376,7 +3404,12 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		mutex_unlock(&ah->conf_mutex);
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 	ab = ar->ab;
 
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags)) {
@@ -3973,7 +4006,12 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		mutex_unlock(&ah->conf_mutex);
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -4129,7 +4167,12 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	struct ath12k_peer *peer;
 	u32 bw, smps;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		mutex_unlock(&ah->conf_mutex);
+		WARN_ON_ONCE(1);
+		return;
+	}
 
 	spin_lock_bh(&ar->ab->base_lock);
 
@@ -4312,7 +4355,12 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		/* TODO cache the info and apply after vdev is created */
+		mutex_unlock(&ah->conf_mutex);
+		return -EINVAL;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_conf_tx(arvif, link_id, ac, params);
@@ -6348,7 +6396,11 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 
 	mutex_lock(&ah->conf_mutex);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		mutex_unlock(&ah->conf_mutex);
+		return -EINVAL;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_ampdu_action(arvif, params);
@@ -7176,11 +7228,29 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 				u32 queues, bool drop)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+	struct ath12k *ar;
+	int i;
 
 	if (drop)
 		return;
 
+	/* vif can be NULL when flush() is considered for hw */
+	if (!vif) {
+		ar = ath12k_ah_to_ar(ah, 0);
+		for (i = 0; i < ah->num_radio; i++) {
+			ath12k_mac_flush(ar);
+			ar++;
+		}
+		return;
+	}
+
+	mutex_lock(&ah->conf_mutex);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	mutex_unlock(&ah->conf_mutex);
+
+	if (!ar)
+		return;
+
 	ath12k_mac_flush(ar);
 }
 
-- 
2.17.1


