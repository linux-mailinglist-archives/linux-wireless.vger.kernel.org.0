Return-Path: <linux-wireless+bounces-4598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4FD879050
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 10:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12CDB2173E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64278294;
	Tue, 12 Mar 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gSVF/m5U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932077F11
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234277; cv=none; b=LKPWExGVn34R7oGB9CoW+PU8xRKWZYDlizn+pH1nYEHv18Vfb8loUeTvhaxozTyZi9qdtGZkZCeQXqHzcKUVCxBCDQ+PNU+tECip6DE3QNP6n+HDbwrdJu8Ypew8x5+UMtHPTVkSmccJWdEkA+6pjFHcKC8jH9EPj6Bcliuirik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234277; c=relaxed/simple;
	bh=YjldYlN1TiV91trTzakMe51FalDfiZS2lyqc40tvHHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1A9rHNwL6Dw7b7TzWwKwHpjGd8/A9Flu3Nrn3hHzwVjTSPW9ckJjyJ8Vk44AC6h89o+eAQheCaCGQV7n92PkHBzCdglIas4RzQrtb5RhkKcnhbV4e4k/wRpGBU7whKfMg9PN9Tz7k4rjgm1tL5H4Mm37PCEoXa9xcklF+IFcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gSVF/m5U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C57qsB029587;
	Tue, 12 Mar 2024 09:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=DvjfdcTrjYKphBrQKCuUq1u72/zj3phU2mx/GW37wxM=; b=gS
	VF/m5UohrZbzAA0w36UmCYWnulHPn0zdv707b3FxAKHxriuNiR6HmoRVEpPUmKcA
	UnLuOGPGfPwaOC6amGKspz1baN7sj7OzKujW3pRpIIRy5RXxojg+F2Bax1NqdwH4
	l0w2kZ5mfKZ5PuZKlJu+ajEfwoS7+b54cZQRbdlMNz1KeJ5T/ejSw9kuakqj/KkP
	JBLGVTgdPTWFuhHI6tQSI4OPF7WLSFcCX1ZXDWfJQXyXjlDHkuzXtY8exIgYCUAF
	r0Q2K9DDCAFevf0WOnqImTHW2S4bgPPdUxPYS5rbQ+Hvf2mAc8UrG0AiFLG6Zhvl
	hP/cmXp8XyWQe3K1u7Dg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtd508sbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:04:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C94WDr022946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:04:32 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 02:04:29 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v3 06/12] wifi: ath12k: fetch correct radio based on vdev status
Date: Tue, 12 Mar 2024 14:33:45 +0530
Message-ID: <20240312090351.1620218-7-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312090351.1620218-1-quic_ramess@quicinc.com>
References: <20240312090351.1620218-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: IKNE87NbVKCVQkz7DwmUub-PIPNcorq5
X-Proofpoint-ORIG-GUID: IKNE87NbVKCVQkz7DwmUub-PIPNcorq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=979 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403120070

From: Sriram R <quic_srirrama@quicinc.com>

For ops which passes the vif info, fetch the radio(ar)
to be used for corresponding functions based on the
the vdev creation status. If the vdev is not created yet,
which could happen when the ops are called before channel
is assigned for the vif, the data needs to be cached and this
is done in followup changes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 75 +++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 3ce1407e0e5f..6d2176b0a556 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -645,6 +645,24 @@ static struct ath12k *ath12k_get_ar_by_ctx(struct ieee80211_hw *hw,
 	return ath12k_mac_get_ar_by_chan(hw, ctx->def.chan);
 }
 
+static struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
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
@@ -2998,11 +3016,17 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_bss_conf *info,
 					   u64 changed)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+
+	/* TODO if the vdev is not created on a certain radio,
+	 * cache the info to be updated later on vdev creation
+	 */
+
+	if (!ar)
+		return;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3497,7 +3521,6 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
@@ -3514,7 +3537,11 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
 		return 1;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 	ab = ar->ab;
 
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
@@ -4092,7 +4119,6 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   enum ieee80211_sta_state old_state,
 				   enum ieee80211_sta_state new_state)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
@@ -4104,7 +4130,11 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	     new_state == IEEE80211_STA_NOTEXIST))
 		cancel_work_sync(&arsta->update_wk);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -4255,14 +4285,17 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					struct ieee80211_sta *sta,
 					u32 changed)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_peer *peer;
 	u32 bw, smps;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		WARN_ON_ONCE(1);
+		return;
+	}
 
 	spin_lock_bh(&ar->ab->base_lock);
 
@@ -4438,12 +4471,15 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 				 unsigned int link_id, u16 ac,
 				 const struct ieee80211_tx_queue_params *params)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		/* TODO cache the info and apply after vdev is created */
+		return -EINVAL;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_conf_tx(arvif, link_id, ac, params);
@@ -6459,6 +6495,10 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret = -EINVAL;
 
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar)
+		return -EINVAL;
+
 	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
@@ -7214,11 +7254,24 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
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
+		for_each_ar(i, ah, ar)
+			ath12k_mac_flush(ar);
+		return;
+	}
+
+	ar = ath12k_get_ar_by_vif(hw, vif);
+
+	if (!ar)
+		return;
+
 	ath12k_mac_flush(ar);
 }
 
-- 
2.25.1


