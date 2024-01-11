Return-Path: <linux-wireless+bounces-1694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFAE82A712
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 05:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23C61F2291B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 04:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8304A63B3;
	Thu, 11 Jan 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VeB25yaQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380563B2
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B3rPSN023368;
	Thu, 11 Jan 2024 04:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=CzY31OSUZ7ZaGtpcFOkz
	9EQWaVfEadynsxJwp4f59cc=; b=VeB25yaQIig/aFQeBb62t4D5FFJKXL9OK+4Q
	oPHh4xTca7HOYKgdq7FzDJfqAhI/oM3XjnP2uJcf3TCslkjkjyYOaDj8X9etBTJJ
	Caac0bU+ogOR40KdfT+pP3SJWyRGu4SKn/XEq/LqHRLpZnveDfU5nb4FQF66jgWK
	Z7EnXWv9KfWmEAI075qdBHgif1JVSGVq/obrtMMGrmrWvNw8sdYzJIDOJIDSAoCp
	dW46ObEKfzVSHSrCCIBhacriJ+4a0kwwaVv+4r7Fd4soKhpKkpSzNr+CZN95wnFD
	gFK/iMfkHfLw/XrS2vk5v1niWIM9CTjCUcOHO0iz9NMJXdcWog==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj16k8wc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B4pZQh010133
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:35 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 20:51:33 -0800
From: Sriram R <quic_srirrama@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 08/12] wifi: ath12k: Add additional checks for vif and sta iterators
Date: Thu, 11 Jan 2024 10:20:41 +0530
Message-ID: <20240111045045.28377-9-quic_srirrama@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Lnodp3kSrIW_9i5bPWvzPzdYl-NkS3WQ
X-Proofpoint-GUID: Lnodp3kSrIW_9i5bPWvzPzdYl-NkS3WQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=562 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110035

Since vif and sta objects of different radios are added to same
local hw list in mac80211, additional checks need to be done
in driver to ensure we are processing the intended vif
and sta corresponding to the radio when the vif and sta mac80211
iterator utils are used from driver.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 0b55a3f533cd..883556313fb0 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -288,6 +288,7 @@ struct ath12k_vif {
 
 struct ath12k_vif_iter {
 	u32 vdev_id;
+	struct ath12k *ar;
 	struct ath12k_vif *arvif;
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 91d378c5f2cf..25d82c6fe89a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -533,7 +533,8 @@ static void ath12k_get_arvif_iter(void *data, u8 *mac,
 	struct ath12k_vif_iter *arvif_iter = data;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
-	if (arvif->vdev_id == arvif_iter->vdev_id)
+	if (arvif->vdev_id == arvif_iter->vdev_id &&
+	    arvif->ar == arvif_iter->ar)
 		arvif_iter->arvif = arvif;
 }
 
@@ -543,6 +544,7 @@ struct ath12k_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
 	u32 flags;
 
 	arvif_iter.vdev_id = vdev_id;
+	arvif_iter.ar = ar;
 
 	flags = IEEE80211_IFACE_ITER_RESUME_ALL;
 	ieee80211_iterate_active_interfaces_atomic(ath12k_ar_to_hw(ar),
@@ -6770,14 +6772,19 @@ struct ath12k_mac_change_chanctx_arg {
 	struct ieee80211_vif_chanctx_switch *vifs;
 	int n_vifs;
 	int next_vif;
+	struct ath12k *ar;
 };
 
 static void
 ath12k_mac_change_chanctx_cnt_iter(void *data, u8 *mac,
 				   struct ieee80211_vif *vif)
 {
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_mac_change_chanctx_arg *arg = data;
 
+	if (arvif->ar != arg->ar)
+		return;
+
 	if (rcu_access_pointer(vif->bss_conf.chanctx_conf) != arg->ctx)
 		return;
 
@@ -6788,9 +6795,13 @@ static void
 ath12k_mac_change_chanctx_fill_iter(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_mac_change_chanctx_arg *arg = data;
 	struct ieee80211_chanctx_conf *ctx;
 
+	if (arvif->ar != arg->ar)
+		return;
+
 	ctx = rcu_access_pointer(vif->bss_conf.chanctx_conf);
 	if (ctx != arg->ctx)
 		return;
@@ -6907,7 +6918,7 @@ static void
 ath12k_mac_update_active_vif_chan(struct ath12k *ar,
 				  struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k_mac_change_chanctx_arg arg = { .ctx = ctx };
+	struct ath12k_mac_change_chanctx_arg arg = { .ctx = ctx, .ar = ar };
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -7512,6 +7523,9 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k *ar = arvif->ar;
 
+	if (arsta->arvif != arvif)
+		return;
+
 	spin_lock_bh(&ar->data_lock);
 	arsta->changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	spin_unlock_bh(&ar->data_lock);
@@ -7522,10 +7536,14 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 static void ath12k_mac_disable_peer_fixed_rate(void *data,
 					       struct ieee80211_sta *sta)
 {
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_vif *arvif = data;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
+	if (arsta->arvif != arvif)
+		return;
+
 	ret = ath12k_wmi_set_peer_param(ar, sta->addr,
 					arvif->vdev_id,
 					WMI_PEER_PARAM_FIXED_RATE,
-- 
2.17.1


