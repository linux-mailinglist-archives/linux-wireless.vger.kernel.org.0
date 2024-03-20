Return-Path: <linux-wireless+bounces-5021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886248817B2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4161C21449
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC785955;
	Wed, 20 Mar 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FnMXYR7m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F185941
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961846; cv=none; b=V6O/JymUw672uVo+8EsiHE61+Yk9QiUoh3cdETQW7YA2YOWHCWFlu+O8nBDtADHQ38bHwsmN18tnQlJl9uraDscBgAo4kNFJ+PlaX6uB/Mr7SVMvNyF/VzvdSjWXce8KX3nCormRxxGD3B9d3g48nsUVtvzOoXc9y2MSQi7lrHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961846; c=relaxed/simple;
	bh=iq73mT6Dw8r2V4mDGiqgcHeezTxntt21+NERzvGFiMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQCu6cT7spySVqDUKr11a2Whjtt+Cfe6gNEQN6QfqM1VFppxHTluI0bQKiQC7jWptqIK0c7oVm7JZZ9MerpCgvY5o1pRPLFuBUhEH5HCwQs/D2u2xRKNqVqJNh34NR62staF1jLeiphSvnxSx/sVtOR/VHZsAT9i3zEbbZXN4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FnMXYR7m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KFnw8G001396;
	Wed, 20 Mar 2024 19:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2qMj74M1LlJE/jYfcAQUpq8VuDSQpxkn3wN+8/iPoCk=; b=Fn
	MXYR7mPtuhbc2vqmtnUAHhC5WYEoA9w71WVX8JKjRN/jbwklQSlkAdJtRtvEb7gH
	4YIX+BHsW+jyBXFTV26ikbyAnHnrUWpINyNVGvRI/i5/RwfFtDw2H0W+1/7jDXZ1
	Gfonnynuw3VcwsgID3N/30rIu6tMwY7IWiBMLI2gBFDZkit36IKDvhGMysoQzPM0
	S7vFViuxdHLmEO+2O1/vw6qlca0o8AOc0kFWqPJu0aysH2J7WY/gNkyJkq9zBxvt
	T/EQZKWeE/aIgXN+D9yGFGw7jH8q63UzjUNsBHZmnKSerlio6rxoK1zMAyyqxMUI
	aOV4HeIPh05yEW1SwraA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyy76h2mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:10:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KJADaN017523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:10:13 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 12:10:11 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v5 07/12] wifi: ath12k: Cache vdev configs before vdev create
Date: Thu, 21 Mar 2024 00:39:38 +0530
Message-ID: <20240320190943.3850106-8-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320190943.3850106-1-quic_ramess@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: hJ16yRx61ENULM_H50xKH8nkuXS8ocoX
X-Proofpoint-ORIG-GUID: hJ16yRx61ENULM_H50xKH8nkuXS8ocoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=802 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200154

From: Sriram R <quic_srirrama@quicinc.com>

Since the vdev create for a corresponding vif is deferred
until a channel is assigned, cache the information which
are received through mac80211 ops between add_interface()
and assign_vif_chanctx() and set them once the vdev is
created on one of the ath12k radios as the channel gets
assigned via assign_vif_chanctx().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  19 ++++
 drivers/net/wireless/ath/ath12k/mac.c  | 149 ++++++++++++++++++++-----
 2 files changed, 140 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 507f08ab3ad5..fa0606c460c6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -214,6 +214,24 @@ enum ath12k_monitor_flags {
 	ATH12K_FLAG_MONITOR_ENABLED,
 };
 
+struct ath12k_tx_conf {
+	bool changed;
+	u16 ac;
+	struct ieee80211_tx_queue_params tx_queue_params;
+};
+
+struct ath12k_key_conf {
+	bool changed;
+	enum set_key_cmd cmd;
+	struct ieee80211_key_conf *key;
+};
+
+struct ath12k_vif_cache {
+	struct ath12k_tx_conf *tx_conf;
+	struct ath12k_key_conf *key_conf;
+	u32 bss_conf_changed;
+};
+
 struct ath12k_vif {
 	u32 vdev_id;
 	enum wmi_vdev_type vdev_type;
@@ -268,6 +286,7 @@ struct ath12k_vif {
 	u8 vdev_stats_id;
 	u32 punct_bitmap;
 	bool ps;
+	struct ath12k_vif_cache cache;
 };
 
 struct ath12k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 50c8c6ddc167..0274eac33b1f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3021,12 +3021,14 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 
-	/* TODO if the vdev is not created on a certain radio,
+	/* if the vdev is not created on a certain radio,
 	 * cache the info to be updated later on vdev creation
 	 */
 
-	if (!ar)
+	if (!ar) {
+		arvif->cache.bss_conf_changed |= changed;
 		return;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3517,12 +3519,11 @@ static int ath12k_clear_peer_keys(struct ath12k_vif *arvif,
 	return first_errno;
 }
 
-static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-				 struct ieee80211_key_conf *key)
+static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
+			      struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			      struct ieee80211_key_conf *key)
 {
-	struct ath12k *ar;
-	struct ath12k_base *ab;
+	struct ath12k_base *ab = ar->ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_peer *peer;
 	struct ath12k_sta *arsta;
@@ -3530,28 +3531,11 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	int ret = 0;
 	u32 flags = 0;
 
-	/* BIP needs to be done in software */
-	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
-	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
-	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
-	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
-		return 1;
-
-	ar = ath12k_get_ar_by_vif(hw, vif);
-	if (!ar) {
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
-	ab = ar->ab;
+	lockdep_assert_held(&ar->conf_mutex);
 
-	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
+	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		return 1;
 
-	if (key->keyidx > WMI_MAX_KEY_INDEX)
-		return -ENOSPC;
-
-	mutex_lock(&ar->conf_mutex);
-
 	if (sta)
 		peer_addr = sta->addr;
 	else if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
@@ -3643,6 +3627,51 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	spin_unlock_bh(&ab->base_lock);
 
 exit:
+	return ret;
+}
+
+static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+				 struct ieee80211_key_conf *key)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_key_conf *key_conf;
+	struct ath12k *ar;
+	int ret;
+
+	/* BIP needs to be done in software */
+	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
+	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
+	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
+	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
+		return 1;
+
+	if (key->keyidx > WMI_MAX_KEY_INDEX)
+		return -ENOSPC;
+
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		/* ar is expected to be valid when sta ptr is available */
+		if (sta) {
+			WARN_ON_ONCE(1);
+			return -EINVAL;
+		}
+
+		key_conf = arvif->cache.key_conf;
+		if (!key_conf) {
+			key_conf = kzalloc(sizeof(*key_conf), GFP_KERNEL);
+			if (!key_conf)
+				return -ENOSPC;
+			arvif->cache.key_conf = key_conf;
+		}
+		key_conf->cmd = cmd;
+		key_conf->key = key;
+		key_conf->changed = true;
+		return 0;
+	}
+
+	mutex_lock(&ar->conf_mutex);
+	ret = ath12k_mac_set_key(ar, cmd, vif, sta, key);
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
@@ -4473,11 +4502,22 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_tx_conf *tx_conf;
 	int ret;
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
-		/* TODO cache the info and apply after vdev is created */
+		/* cache the info and apply after vdev is created */
+		tx_conf = arvif->cache.tx_conf;
+		if (!tx_conf) {
+			tx_conf = kzalloc(sizeof(*tx_conf), GFP_KERNEL);
+			if (!tx_conf)
+				return -ENOSPC;
+			arvif->cache.tx_conf = tx_conf;
+		}
+		tx_conf->changed = true;
+		tx_conf->ac = ac;
+		tx_conf->tx_queue_params = *params;
 		return -EINVAL;
 	}
 
@@ -6121,6 +6161,57 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	return ret;
 }
 
+static void ath12k_mac_vif_cache_free(struct ath12k *ar, struct ath12k_vif *arvif)
+{
+	struct ath12k_key_conf *key_conf = arvif->cache.key_conf;
+	struct ath12k_tx_conf *tx_conf = arvif->cache.tx_conf;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	kfree(tx_conf);
+	arvif->cache.tx_conf = NULL;
+	kfree(key_conf);
+	arvif->cache.key_conf = NULL;
+	arvif->cache.bss_conf_changed = 0;
+}
+
+static void ath12k_mac_vif_cache_flush(struct ath12k *ar,  struct ieee80211_vif *vif)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_key_conf *key_conf = arvif->cache.key_conf;
+	struct ath12k_tx_conf *tx_conf = arvif->cache.tx_conf;
+	struct ath12k_base *ab = ar->ab;
+
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (tx_conf && tx_conf->changed) {
+		ret = ath12k_mac_conf_tx(arvif, 0, tx_conf->ac,
+					 &tx_conf->tx_queue_params);
+		if (ret)
+			ath12k_warn(ab,
+				    "unable to apply tx config parameters to vdev %d\n",
+				    ret);
+	}
+
+	if (arvif->cache.bss_conf_changed) {
+		ath12k_mac_bss_info_changed(ar, arvif, &vif->bss_conf,
+					    arvif->cache.bss_conf_changed);
+	}
+
+	if (key_conf && key_conf->changed) {
+		ret = ath12k_mac_set_key(ar, key_conf->cmd, vif, NULL,
+					 key_conf->key);
+		if (ret) {
+			WARN_ON_ONCE(1);
+			ath12k_warn(ab, "unable to apply set key param to vdev %d ret %d\n",
+				    arvif->vdev_id, ret);
+		}
+	}
+	ath12k_mac_vif_cache_free(ar, arvif);
+}
+
 static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 						    struct ieee80211_vif *vif,
 						    struct ieee80211_chanctx_conf *ctx)
@@ -6201,10 +6292,11 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 		goto unlock;
 	}
 
-	/* TODO If the vdev is created during channel assign and not during
+	/* If the vdev is created during channel assign and not during
 	 * add_interface(), Apply any parameters for the vdev which were received
 	 * after add_interface, corresponding to this vif.
 	 */
+	ath12k_mac_vif_cache_flush(ar, vif);
 unlock:
 	mutex_unlock(&ar->conf_mutex);
 out:
@@ -6316,6 +6408,7 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 	spin_unlock_bh(&ar->data_lock);
 
 	ath12k_peer_cleanup(ar, arvif->vdev_id);
+	ath12k_mac_vif_cache_free(ar, arvif);
 
 	idr_for_each(&ar->txmgmt_idr,
 		     ath12k_mac_vif_txmgmt_idr_remove, vif);
-- 
2.25.1


