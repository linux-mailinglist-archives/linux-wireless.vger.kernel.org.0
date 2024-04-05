Return-Path: <linux-wireless+bounces-5924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854789A529
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 21:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4C62838C2
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922C173354;
	Fri,  5 Apr 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ThuKqmm8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC5173351
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346357; cv=none; b=kVOC0ocxZlaysFO3fxiYC4x3QL8LIl5xdm/oAeyLKJ+Cr440RaIrs6bqi9eoOooQtW+NO1RCOgF34u7UmcJ6QPI0jnC8U86aGbgz6fQoU7vNqf0Jxa2+m8gyyn4onrjZBCBPpPsZ9Hn24qdbs1CrWX9kSBxdvdgon44wzxxdVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346357; c=relaxed/simple;
	bh=P92VT+rTY99HF6m3fMGdg7lS0nwma7fBH7ChT9cHfUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAoO60vyYBmK3E1GswE64jX1T5B5Vo1/vGb06Ay6zrxTV3fMmDfXtQADxQLOEQmpqvUyDfQkz+0M4NGuv+pyt1jxcptlpUywmglOHU6eOfSMW9/O03/Nl6/377BZyvPgzdkuTJEJy+v95QU1TDFyq+ASjtg2veUezSo0gUPlPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ThuKqmm8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435BQeIR011666;
	Fri, 5 Apr 2024 19:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=95dMvmGJJ1sDCfIq/yJglgz83R8BYycma5jpsngKC2s=; b=Th
	uKqmm8LIzZ3YgLEnt63Orr51Hk306h3AgoTu3Os/D3hSsoy+auF7Z4tDpr41Pcm9
	REkp7rQpXhNoZDt5nWERmnR/Lz5rU2qEQpeY0eXSZ+Gyp4JKVu6+phbjMQOdKHN4
	YnNHv9d+8LmT2UqxmECwpRZWPWkRVNIFFC3LQFTgPVraxLMBXX6duAYswnOYzeHH
	Spy7gZcM+Y2aNu51vb39M6IUxNX+pEYCai5QlzKH1sJes8ihbVIEpKJXGv/y1CIl
	9WC6NU3DveB8Nv7e5WMTOKyrqlAuGprKaOFytSnJ+VOLZXe5IkvLbjXpEoUF+gQm
	FwLgKxHbWzCCJpU48bFQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xafe3s7s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:45:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435JjliR029903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:45:47 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:45:45 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v7 06/12] wifi: ath12k: fetch correct radio based on vdev status
Date: Sat, 6 Apr 2024 01:15:13 +0530
Message-ID: <20240405194519.1337906-7-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: 1mhIszKINIn1-IW7-Yey1Y8KYPKJgKxK
X-Proofpoint-ORIG-GUID: 1mhIszKINIn1-IW7-Yey1Y8KYPKJgKxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_23,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=998 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050140

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
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 75 +++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f1c1d3030e74..be36c7d133da 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -646,6 +646,24 @@ static struct ath12k *ath12k_get_ar_by_ctx(struct ieee80211_hw *hw,
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
@@ -2999,11 +3017,17 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
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
 
@@ -3498,7 +3522,6 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
@@ -3515,7 +3538,11 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
@@ -4093,7 +4120,6 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   enum ieee80211_sta_state old_state,
 				   enum ieee80211_sta_state new_state)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
@@ -4105,7 +4131,11 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	     new_state == IEEE80211_STA_NOTEXIST))
 		cancel_work_sync(&arsta->update_wk);
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar) {
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -4256,14 +4286,17 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
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
 
@@ -4439,12 +4472,15 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
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
@@ -6455,6 +6491,10 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret = -EINVAL;
 
+	ar = ath12k_get_ar_by_vif(hw, vif);
+	if (!ar)
+		return -EINVAL;
+
 	ar = ath12k_ah_to_ar(ah, 0);
 
 	mutex_lock(&ar->conf_mutex);
@@ -7210,11 +7250,24 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
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
+		for_each_ar(ah, ar, i)
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


