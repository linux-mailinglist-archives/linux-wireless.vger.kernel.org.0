Return-Path: <linux-wireless+bounces-6758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8198B02BB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 08:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1198A1F21E01
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 06:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F47D15820F;
	Wed, 24 Apr 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N4DqlRI2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A7157499
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941836; cv=none; b=AGVHhnUa04HHtdkpzvmCPCRvueJuCSgwt28eR8l9JPJzLaktjMPjAbBLL+gn1cqd/8esN2SfkKN7VA1iv/opxvAMz4XbTnGAh9zVJtlaJt1muMtLluVfkoJJvT6V1SvrftODfB1FUzg23e9nSFit9n7G3XO2CMJo4M+BwbCfJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941836; c=relaxed/simple;
	bh=+CHQWo/zsaBSdg4nAdBs/FmeToDwo6cNxmZwP9B04/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gl6OKWZ4GeMLoYm+NnJVu18Ug0uIFR0G7wn0ga0POsEWkunjP6FMEc3ZnRKIdpgu7efixV5Dzx99KzJbD1QinzKZYejt9WOkOOsL6+ITsloAphkdEFsG5/TSYqlzpg3laBbol7q/9RUU9yPw+Chm28nh0Xbh36D3/qFbPYFTK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N4DqlRI2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6Y0kR017665;
	Wed, 24 Apr 2024 06:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=6vyMwt/tR7TvJ6IEDMp+XT2nviPHFdf9JgFwe7zHNqk=; b=N4
	DqlRI2J/MkJIL5capg8lfHfzWvyplohpPHTJ4BmCmUFsQDIanbZ9hpPkpKAGw80N
	cS8XR5iLPIzdXn21PVz6jmw+79J5VKRkZG6eeG5clzCBdSSs/irDPsWVPcdALSbn
	eid7KL2HCb9Y11zYifV1vQ/SMzftP24FIQIKKwKgGayZrE0MNmZqTuYLhNq27iwm
	jjVcHTJ/2cE9XuPZTYe+7l3tH0ynU0GO7mP4kyrzYq3CzMLwakZyI+L2mSWKsv7U
	xD3D5IsgrKuvv3G4wV0M8JBasU6QI9/56hJk9Eg22eXuZnjTNXW9nLwXDuLAT8J6
	1ue2c3Lszeqmih10TeIw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fg4am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 06:57:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O6v7Wx010204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 06:57:07 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 23:57:06 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 3/3] wifi: ath12k: Add lock to protect the hardware state
Date: Wed, 24 Apr 2024 12:26:46 +0530
Message-ID: <20240424065646.1666166-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
References: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Uzx3GAmVtB0wZV_FghVQnq97gLQFwRi2
X-Proofpoint-GUID: Uzx3GAmVtB0wZV_FghVQnq97gLQFwRi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_04,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240029

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
 drivers/net/wireless/ath/ath12k/mac.c  | 29 ++++++++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

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
index eff1093fbb6e..3e3e157b6c56 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -634,11 +634,17 @@ struct ath12k {
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
index 8b003c18796d..3dc95d36b6a2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5546,10 +5546,13 @@ static void ath12k_mac_wait_reconfigure(struct ath12k_base *ab)
 
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
@@ -5664,6 +5667,8 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 
 	ath12k_drain_tx(ah);
 
+	mutex_lock(&ah->hw_mutex);
+
 	switch (ah->state) {
 	case ATH12K_HW_STATE_OFF:
 		ah->state = ATH12K_HW_STATE_ON;
@@ -5678,7 +5683,8 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 		ah->state = ATH12K_HW_STATE_OFF;
 
 		WARN_ON(1);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	for_each_ar(ah, ar, i) {
@@ -5692,6 +5698,8 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 		}
 	}
 
+	mutex_unlock(&ah->hw_mutex);
+
 	return 0;
 
 fail_start:
@@ -5700,6 +5708,8 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 		ath12k_mac_stop(ar);
 	}
 
+err:
+	mutex_unlock(&ah->hw_mutex);
 	return ret;
 }
 
@@ -5762,9 +5772,12 @@ int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable)
 
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
@@ -5800,10 +5813,14 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 
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
@@ -7848,8 +7865,12 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
-	if (ah->state != ATH12K_HW_STATE_RESTARTED)
+	mutex_lock(&ah->hw_mutex);
+
+	if (ah->state != ATH12K_HW_STATE_RESTARTED) {
+		mutex_unlock(&ah->hw_mutex);
 		return;
+	}
 
 	ah->state = ATH12K_HW_STATE_ON;
 	ieee80211_wake_queues(hw);
@@ -7904,6 +7925,8 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 
 		mutex_unlock(&ar->conf_mutex);
 	}
+
+	mutex_unlock(&ah->hw_mutex);
 }
 
 static void
@@ -8850,6 +8873,8 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 	ah->ab = ab;
 	ah->num_radio = num_pdev_map;
 
+	mutex_init(&ah->hw_mutex);
+
 	for (i = 0; i < num_pdev_map; i++) {
 		ab = pdev_map[i].ab;
 		pdev_idx = pdev_map[i].pdev_idx;
-- 
2.34.1


