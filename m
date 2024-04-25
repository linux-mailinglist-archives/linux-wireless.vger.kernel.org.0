Return-Path: <linux-wireless+bounces-6824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D82B8B1D57
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0EC1C22C44
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 09:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984584A31;
	Thu, 25 Apr 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eOT8aeBk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13984D0E
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035814; cv=none; b=fF0OqyckXs+AX88e2Z1+BockhXWOTcfuVCi4G7fEo+Gcuui2XNS6mRD6ePSoZViggey4qrCdgzDz1k67EoZrPEwUtkjpa59rMs1h1EdrI5MaPvKAlvV27yt/owZXgYwzpvdtjQF7XkDA7AEV6aVU696FG6xp6li9now9M8eCrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035814; c=relaxed/simple;
	bh=wONvwaQHU0falPX8nmRhH52zgYkHClyqGeGPQe/j9+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXAYq2fpJJlPVgwXqvIg2c5anbyhA3ieVIiqoVX4heVjswIg/TWx/xRPKAxXY5fTRnL7lpT9rpr44SSpyjibW53lN81RKzMzyZRncAZR5CBGkmkjWb8bTSUhiLZw9lIrYAyKFpDhUtmD3JcyLLhegh3dk/xj7ZPPicgg2Pqcl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eOT8aeBk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P84qnL024296;
	Thu, 25 Apr 2024 09:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=zsHjv04qDE/+0VQVNuH2rrg4LLOp8V8XxZ5z/DGPlKc=; b=eO
	T8aeBk0voakr2Tp3+TA885CVpPibLhD1cGIKSmhgf2Qboln6snjDG1S/43Kj1w5g
	Oa+e4/SFgg4xalk1WwOLDiXTKYNXkiDinZPitJ846llysLLdFNfJUTsfI0auVoWZ
	A/KGLjCAf8+ieUaIQsDRROoU8N8ELVwib32aZXkKuUyeAwkzSeP8XBpfQ8FSpVLP
	CV/naYUoBoVLI/sNoCXGQJ4Sx95h2X1fP8YkPG04PYMc8/lpRIiMMkP7wYqhdBgl
	EFNNgA8O7Mhfd1fsnh6l6XbhGakyM/2aNBYIe/2FBLbEdas9NapoTJZhZ/7TwLav
	TgaEOhKJK/19oFu8dt/w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenp9ft8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:03:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P93RYG012717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:03:27 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 02:03:25 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 3/3] wifi: ath12k: Add lock to protect the hardware state
Date: Thu, 25 Apr 2024 14:33:07 +0530
Message-ID: <20240425090307.3233434-4-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: rbCqvXsdgjj34qZUhFczliS8kaxLT7xM
X-Proofpoint-ORIG-GUID: rbCqvXsdgjj34qZUhFczliS8kaxLT7xM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250063

Currently, hardware state is not protected across the reconfigure
operations. However, in single wiphy models, multiple radio/links is
exposed as a MAC hardware (ieee80211_hw) through the driver hardware
abstraction (ath12k_hw) layer. In such scenario, we need to protect
hardware state across the multiple radio/link at the driver hardware
abstraction (ath12k_hw) layer. Therefore, introduce a new mutex in
the ath12k_hw layer.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  4 ++++
 drivers/net/wireless/ath/ath12k/core.h |  6 ++++++
 drivers/net/wireless/ath/ath12k/mac.c  | 16 ++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index a685cfd6fd92..e9aabdb9341c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1048,6 +1048,8 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
+		mutex_lock(&ah->hw_mutex);
+
 		switch (ah->state) {
 		case ATH12K_HW_STATE_ON:
 			ah->state = ATH12K_HW_STATE_RESTARTING;
@@ -1078,6 +1080,8 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 				    "device is wedged, will not restart hw %d\n", i);
 			break;
 		}
+
+		mutex_unlock(&ah->hw_mutex);
 	}
 
 	complete(&ab->driver_recovery);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index c4eb8b25398c..d833361948b7 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -636,11 +636,17 @@ struct ath12k {
 struct ath12k_hw {
 	struct ieee80211_hw *hw;
 	struct ath12k_base *ab;
+
+	/* Protect the write operation of the hardware state ath12k_hw::state
+	 * between hardware start<=>reconfigure<=>stop transitions.
+	 */
+	struct mutex hw_mutex;
 	enum ath12k_hw_state state;
 	bool regd_updated;
 	bool use_6ghz_regd;
 	u8 num_radio;
 
+	/* Keep last */
 	struct ath12k radio[] __aligned(sizeof(void *));
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 710ed8fa79fd..2626328056dd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5615,10 +5615,13 @@ static void ath12k_mac_wait_reconfigure(struct ath12k_base *ab)
 
 static int ath12k_mac_start(struct ath12k *ar)
 {
+	struct ath12k_hw *ah = ar->ah;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev *pdev = ar->pdev;
 	int ret;
 
+	lockdep_assert_held(&ah->hw_mutex);
+
 	mutex_lock(&ar->conf_mutex);
 
 	ret = ath12k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_PMF_QOS,
@@ -5733,6 +5736,8 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 
 	ath12k_drain_tx(ah);
 
+	guard(mutex)(&ah->hw_mutex);
+
 	switch (ah->state) {
 	case ATH12K_HW_STATE_OFF:
 		ah->state = ATH12K_HW_STATE_ON;
@@ -5831,9 +5836,12 @@ int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable)
 
 static void ath12k_mac_stop(struct ath12k *ar)
 {
+	struct ath12k_hw *ah = ar->ah;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
 	int ret;
 
+	lockdep_assert_held(&ah->hw_mutex);
+
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_config_mon_status_default(ar, false);
 	if (ret && (ret != -EOPNOTSUPP))
@@ -5869,10 +5877,14 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 
 	ath12k_drain_tx(ah);
 
+	mutex_lock(&ah->hw_mutex);
+
 	ah->state = ATH12K_HW_STATE_OFF;
 
 	for_each_ar(ah, ar, i)
 		ath12k_mac_stop(ar);
+
+	mutex_unlock(&ah->hw_mutex);
 }
 
 static u8
@@ -7921,6 +7933,8 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
+	guard(mutex)(&ah->hw_mutex);
+
 	if (ah->state != ATH12K_HW_STATE_RESTARTED)
 		return;
 
@@ -8923,6 +8937,8 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 	ah->ab = ab;
 	ah->num_radio = num_pdev_map;
 
+	mutex_init(&ah->hw_mutex);
+
 	for (i = 0; i < num_pdev_map; i++) {
 		ab = pdev_map[i].ab;
 		pdev_idx = pdev_map[i].pdev_idx;
-- 
2.34.1


