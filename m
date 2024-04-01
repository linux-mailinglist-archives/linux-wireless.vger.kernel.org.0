Return-Path: <linux-wireless+bounces-5726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9813E894536
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 21:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6701C2190E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B3535D9;
	Mon,  1 Apr 2024 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O2S7mQIn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF2524DD
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998320; cv=none; b=LlaKXSdZYzBYKRPNtHgPHgU46R99XmBfXUsVGhfqAq4VqifPcwFklKB3uZRhaBWwxKKwxijEbdV3TDeuQG0uMVJIyHrpx3li7hcUt24ese3nlYfa5NVkqSzhqfiCcK0tHA2twf3XGcWjHzv7DClrwGvdzjifOm/nLZP4N91uZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998320; c=relaxed/simple;
	bh=KKNWQQBOf6OgKkEnFCpXx0/jJ0zTT4bGBAsResDUhuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2DAmZ+iPm+sPzuc13gRf+1iX7z9+htpSWd8BGRitzwuVKlvDizJl1Q3Zc8Yi5iONjPxFRMvNwPtUEWC0+CMgCI73zc5Sv1wrwphTZooyq/9T8cMf8ncpSASBj4OY8zsUZEsKYHq3slB5fDIf8NuZg7QBM4DE5+1rgExvICdgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O2S7mQIn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431FVLsL014566;
	Mon, 1 Apr 2024 19:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=EKg6G6fo+zAFq5qFAoCa4u6fQIZ32EEy6OKC2RIcfiE=; b=O2
	S7mQInn2KS5HPRnYIRLBEobd1LwipeTfGfvHpMEUl/Kx2XWOOJT4JZCYchvPVqnO
	VbuFL4wc9izJEVwCofEBmFcqh14vDAt4vEGF4jNe70oQzDnm7gf91vjTELfE8esb
	shKoWrOiZLtSzNDTP9C3+gNqbd8x63hu7TTjynkcVjINmhxxrUk0u9pGk3+wGuto
	lG+h1er1RJHyPJLlRGuyku767EF3BxTCLPOpMWJd2NASFKhGBnsxCsR2ZzfgHHdB
	cSA5Awx0+o9IRStSe0IZ11bJYKacyU1RVDT1FoCUQMFhdpMXbEsyjBZ2pLELBbgI
	tWpDmIMV0BY/cvjg4QlA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7xrfgqe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:05:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431J5DJ1000629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 19:05:13 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Apr 2024 12:05:11 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v6 07/12] wifi: ath12k: Cache vdev configs before vdev create
Date: Tue, 2 Apr 2024 00:34:04 +0530
Message-ID: <20240401190409.2461819-8-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401190409.2461819-1-quic_ramess@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: veZjjkRETL87to8BQu_n1xP7tHJIl0wY
X-Proofpoint-ORIG-GUID: veZjjkRETL87to8BQu_n1xP7tHJIl0wY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_13,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=807 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010134

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
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  19 +++
 drivers/net/wireless/ath/ath12k/mac.c  | 160 +++++++++++++++++++------
 2 files changed, 145 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 507f08ab3ad5..dd6c474bd507 100644
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
+	struct ath12k_tx_conf tx_conf;
+	struct ath12k_key_conf key_conf;
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
+	struct ath12k_vif_cache *cache;
 };
 
 struct ath12k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 60095d876a43..3f2d1b00ae24 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3018,15 +3018,24 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif_cache *cache = arvif->cache;
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 
-	/* TODO if the vdev is not created on a certain radio,
+	/* if the vdev is not created on a certain radio,
 	 * cache the info to be updated later on vdev creation
 	 */
 
-	if (!ar)
+	if (!ar) {
+		if (!cache) {
+			cache = kzalloc(sizeof(*cache), GFP_KERNEL);
+			if (!cache)
+				return;
+			arvif->cache = cache;
+		}
+		arvif->cache->bss_conf_changed |= changed;
 		return;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3517,12 +3526,11 @@ static int ath12k_clear_peer_keys(struct ath12k_vif *arvif,
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
@@ -3530,28 +3538,11 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
@@ -3643,6 +3634,50 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
+	struct ath12k_vif_cache *cache = arvif->cache;
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
+		if (!cache) {
+			cache = kzalloc(sizeof(*cache), GFP_KERNEL);
+			if (!cache)
+				return -ENOSPC;
+			arvif->cache = cache;
+		}
+		cache->key_conf.cmd = cmd;
+		cache->key_conf.key = key;
+		cache->key_conf.changed = true;
+		return 0;
+	}
+
+	mutex_lock(&ar->conf_mutex);
+	ret = ath12k_mac_set_key(ar, cmd, vif, sta, key);
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
@@ -4473,12 +4508,22 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif_cache *cache = arvif->cache;
 	int ret;
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
-		/* TODO cache the info and apply after vdev is created */
-		return -EINVAL;
+		/* cache the info and apply after vdev is created */
+		if (!cache) {
+			cache = kzalloc(sizeof(*cache), GFP_KERNEL);
+			if (!cache)
+				return -ENOSPC;
+			arvif->cache = cache;
+		}
+		cache->tx_conf.changed = true;
+		cache->tx_conf.ac = ac;
+		cache->tx_conf.tx_queue_params = *params;
+		return 0;
 	}
 
 	mutex_lock(&ar->conf_mutex);
@@ -6121,6 +6166,44 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	return ret;
 }
 
+static void ath12k_mac_vif_cache_flush(struct ath12k *ar,  struct ieee80211_vif *vif)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif_cache *cache = arvif->cache;
+	struct ath12k_base *ab = ar->ab;
+
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (!cache)
+		return;
+
+	if (cache->tx_conf.changed) {
+		ret = ath12k_mac_conf_tx(arvif, 0, cache->tx_conf.ac,
+					 &cache->tx_conf.tx_queue_params);
+		if (ret)
+			ath12k_warn(ab,
+				    "unable to apply tx config parameters to vdev %d\n",
+				    ret);
+	}
+
+	if (cache->bss_conf_changed) {
+		ath12k_mac_bss_info_changed(ar, arvif, &vif->bss_conf,
+					    cache->bss_conf_changed);
+	}
+
+	if (cache->key_conf.changed) {
+		ret = ath12k_mac_set_key(ar, cache->key_conf.cmd, vif, NULL,
+					 cache->key_conf.key);
+		if (ret)
+			ath12k_warn(ab, "unable to apply set key param to vdev %d ret %d\n",
+				    arvif->vdev_id, ret);
+	}
+	kfree(cache);
+	arvif->cache = NULL;
+}
+
 static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 						    struct ieee80211_vif *vif,
 						    struct ieee80211_chanctx_conf *ctx)
@@ -6175,11 +6258,11 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 
 	ab = ar->ab;
 
-	if (arvif->is_created)
-		goto out;
-
 	mutex_lock(&ar->conf_mutex);
 
+	if (arvif->is_created)
+		goto flush;
+
 	if (vif->type == NL80211_IFTYPE_AP &&
 	    ar->num_peers > (ar->max_num_peers - 1)) {
 		ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
@@ -6198,13 +6281,14 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 		goto unlock;
 	}
 
-	/* TODO If the vdev is created during channel assign and not during
+flush:
+	/* If the vdev is created during channel assign and not during
 	 * add_interface(), Apply any parameters for the vdev which were received
 	 * after add_interface, corresponding to this vif.
 	 */
+	ath12k_mac_vif_cache_flush(ar, vif);
 unlock:
 	mutex_unlock(&ar->conf_mutex);
-out:
 	return arvif->ar;
 }
 
@@ -6313,6 +6397,8 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 	spin_unlock_bh(&ar->data_lock);
 
 	ath12k_peer_cleanup(ar, arvif->vdev_id);
+	kfree(arvif->cache);
+	arvif->cache = NULL;
 
 	idr_for_each(&ar->txmgmt_idr,
 		     ath12k_mac_vif_txmgmt_idr_remove, vif);
@@ -6339,8 +6425,14 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	int ret;
 
-	if (!arvif->is_created)
+	if (!arvif->is_created) {
+		/* if we cached some config but never received assign chanctx,
+		 * free the allocated cache.
+		 */
+		kfree(arvif->cache);
+		arvif->cache = NULL;
 		return;
+	}
 
 	ar = arvif->ar;
 	ab = ar->ab;
-- 
2.25.1


