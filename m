Return-Path: <linux-wireless+bounces-5925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D231689A52A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 21:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB58B21172
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0EC174ED0;
	Fri,  5 Apr 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RXkwPGn4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95536173352
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346357; cv=none; b=ZoPhfD2eTFNYnYhaqj0bLORJV1BqpOBVrnVvbznYS7/RUioDIP4ILgPqSiX7i+b/LzKXMon+4RxOw/uLuIfCOSDELrhzBO6INdlxoVDUNtW1FVA8KoFTltrjRgaAwjAcLKe/qotEDUAQREfJi39ryfPqR1x8M7vpm5YI4lGelMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346357; c=relaxed/simple;
	bh=rYahL+YDpKZuQ9xM3+Og/wyY8z79bnYvdHl7VGHQrf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRSdVmrRvFDOsNhBsxPyshjlHc4GQfKys7S49LIUDRiI9UNQ7tzUW5X/zdcMlHgZAFw9gSYuotiNhl+m3tOWwwHEZg8BV1fmB72onAqKi5TlR7Ufvd9DsbRuV+yhyUMU5NQOoBhQGVHwwDIHNNUlt4KEC6Vdbu+jkFaPqMGzBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RXkwPGn4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435JiQep018521;
	Fri, 5 Apr 2024 19:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+Ze1p9YSc8BFqBi1n6hTDGsX43jVnEscphEJBKRwUgI=; b=RX
	kwPGn4970tLpAWS+aYbP1ZZHoboEJOndHWLrDpBthje26OztUymkBEGbwSbLgIU3
	mzah6NM1I+s4YF1hTlzgCMpBT1BW2KZlgzKH/fmIAbPaJecdNuG26vP5GIpbIBWS
	F5awe3WZojkZOrIGkUPA8DgjiGPeUP6fb19p7Qef5xT/ov5VWUCOxDhb0cvPONm7
	CoWEZVyJmAsn3toFSXXrokgrx+Gg2eKmjxoSjVfNTlL5qIsSdpByGPzbEsLKk4JT
	jzbOR4CdYlnCoWuwAT/Dw+za5xuoWhwAu3P3DI0j9Mr+rdiUpPTf/sArtcc38k6Z
	IDsh8Wkj6WX+S7O88FfQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaaj19wt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:45:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435JjoAl025269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:45:50 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:45:48 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v7 07/12] wifi: ath12k: Cache vdev configs before vdev create
Date: Sat, 6 Apr 2024 01:15:14 +0530
Message-ID: <20240405194519.1337906-8-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405194519.1337906-1-quic_ramess@quicinc.com>
References: <20240405194519.1337906-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OKfb4UlT6crSJdxcizZCA6Du2bIOYThi
X-Proofpoint-GUID: OKfb4UlT6crSJdxcizZCA6Du2bIOYThi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_23,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=803 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050140

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
 drivers/net/wireless/ath/ath12k/mac.c  | 162 +++++++++++++++++++------
 2 files changed, 147 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4dca82da1683..79d2d9d5f720 100644
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
index be36c7d133da..fed9ce490b37 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3012,6 +3012,20 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 }
 
+static struct ath12k_vif_cache *ath12k_arvif_get_cache(struct ath12k_vif *arvif)
+{
+	if (!arvif->cache)
+		arvif->cache = kzalloc(sizeof(*arvif->cache), GFP_KERNEL);
+
+	return arvif->cache;
+}
+
+static void ath12k_arvif_put_cache(struct ath12k_vif *arvif)
+{
+	kfree(arvif->cache);
+	arvif->cache = NULL;
+}
+
 static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   struct ieee80211_bss_conf *info,
@@ -3019,15 +3033,21 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_vif_cache *cache;
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 
-	/* TODO if the vdev is not created on a certain radio,
+	/* if the vdev is not created on a certain radio,
 	 * cache the info to be updated later on vdev creation
 	 */
 
-	if (!ar)
+	if (!ar) {
+		cache = ath12k_arvif_get_cache(arvif);
+		if (!cache)
+			return;
+		arvif->cache->bss_conf_changed |= changed;
 		return;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3518,12 +3538,11 @@ static int ath12k_clear_peer_keys(struct ath12k_vif *arvif,
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
@@ -3531,28 +3550,11 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
@@ -3644,6 +3646,47 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
+	struct ath12k_vif_cache *cache;
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
+		cache = ath12k_arvif_get_cache(arvif);
+		if (!cache)
+			return -ENOSPC;
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
@@ -4474,12 +4517,19 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
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
+		cache = ath12k_arvif_get_cache(arvif);
+		if (!cache)
+			return -ENOSPC;
+		cache->tx_conf.changed = true;
+		cache->tx_conf.ac = ac;
+		cache->tx_conf.tx_queue_params = *params;
+		return 0;
 	}
 
 	mutex_lock(&ar->conf_mutex);
@@ -6122,6 +6172,43 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
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
+	ath12k_arvif_put_cache(arvif);
+}
+
 static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 						    struct ieee80211_vif *vif,
 						    struct ieee80211_chanctx_conf *ctx)
@@ -6176,11 +6263,11 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 
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
@@ -6199,13 +6286,14 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
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
 
@@ -6314,6 +6402,7 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 	spin_unlock_bh(&ar->data_lock);
 
 	ath12k_peer_cleanup(ar, arvif->vdev_id);
+	ath12k_arvif_put_cache(arvif);
 
 	idr_for_each(&ar->txmgmt_idr,
 		     ath12k_mac_vif_txmgmt_idr_remove, vif);
@@ -6340,8 +6429,13 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	int ret;
 
-	if (!arvif->is_created)
+	if (!arvif->is_created) {
+		/* if we cached some config but never received assign chanctx,
+		 * free the allocated cache.
+		 */
+		ath12k_arvif_put_cache(arvif);
 		return;
+	}
 
 	ar = arvif->ar;
 	ab = ar->ab;
-- 
2.25.1


