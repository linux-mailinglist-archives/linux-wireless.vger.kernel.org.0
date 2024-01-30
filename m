Return-Path: <linux-wireless+bounces-2775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0C2841BBE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 07:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBD2284E75
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 06:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE83838C;
	Tue, 30 Jan 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="epBkIZNh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB3381B6
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594943; cv=none; b=tB3ArvezCXMhNT8pVRPHCbFk522hpHyNksZIIg1ZgaTbbT4syzBFvxLN/UVAzLbw8V5rQmWzBK6q8R03MV/FV0w2wKE9yaZjoniQiKo6lu2OFe5nQxMpeNMjvNESbYiKoz/XWapFemIIot8FyjDiv8imy3VTNlAEXsZHVAdoRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594943; c=relaxed/simple;
	bh=DFodpnHVr6EulceQcUzE468sHeiFhyTwXYUofudWA1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPCSKxWRe95lWurIB6n+ALf229vZwWs8yQ/KwpTkjW+rIAOjRMkzWHWcrDgHV6Hl3Vl5LKzePKfN7EvkzTJcgtC2IJqDYgLYxfvKkEpC7vlp1UPdZ+wFEcyFLTfK2l5DV4HwrBiyq7VcT830OTOPM8iOhrxg6UDNOwNLPHOEcRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=epBkIZNh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U5NLiX032478;
	Tue, 30 Jan 2024 06:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vLIono0pNdoIBngJxpMD6yQEQgaN6AK6q3l2lJqndNs=; b=ep
	BkIZNhMf6Vc0bxK2DkFf4zyolz+iCxlMkntPKbf/BxO9jmN76eF1mXpWnYjdjyW9
	SSisDaAep8pQwJO9xzI4xC7x4BMOI5dttROTc09QOcPwNErH25M2wFGVZXR54aVx
	nhJA73vdCyv+hau/z41v3dYFUNET8Kyu2NhUEq3J6/1V20og6X6kvkNJ5iGl90Q/
	njHzbnN7Qq0m/0aZLObwxQfcTyQNutALFhT8aWgeoxc4MG3WdnnKVZJ06VaBdu3X
	YhGb+TuOaIuOMpCOvqOj/X6fVh/ox2Sf2eCy6w0HzYRNY6h1Zuy3RxSncu3nn1Z3
	v2kccNrjmEXoBczKoNPw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxr2v0bwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 06:08:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U68we2027090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 06:08:58 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 22:08:56 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: Refactor hardware recovery synchronous
Date: Tue, 30 Jan 2024 11:38:37 +0530
Message-ID: <20240130060838.3895599-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
References: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: q8kWO5tSUdZEWyv7wZDAX4kg-B6gaHsg
X-Proofpoint-ORIG-GUID: q8kWO5tSUdZEWyv7wZDAX4kg-B6gaHsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=901
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300042

Currently, in multi wiphy models, radio/link level synchronization is
sufficient for MAC hardware (ieee80211_hw) reconfigure/recovery procedures
since each radio/link is exposed as a MAC hardware (ieee80211_hw). However,
in single wiphy models, multiple radio/links is exposed as a MAC hardware
(ieee80211_hw) through the driver hardware abstraction (ath12k_hw) layer.
In such scenario, we need synchronization between the reconfigure/recovery
callback operations (i.e., ath12k_core_post_reconfigure_recovery(),
ieee80211_ops->start(), ieee80211_ops->reconfig_complete(),
ieee80211_ops->stop()) at the driver hardware abstraction (ath12k_hw) layer
instead of radio/link (ath12k) layer. Therefore, introduce a new mutex in
the ath12k_hw layer. This approach ensures compatibility of the hardware
recovery procedure with both multi wiphy models and future single wiphy
models.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  4 ++++
 drivers/net/wireless/ath/ath12k/core.h |  5 +++++
 drivers/net/wireless/ath/ath12k/mac.c  | 26 ++++++++++++++++++++++----
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index feca204b82b9..4ea5eacc1342 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -978,6 +978,8 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 		if (!ah)
 			continue;
 
+		mutex_lock(&ah->conf_mutex);
+
 		for (j = 0, restart_count = 0; j < ah->num_radio; j++) {
 			ar = &ah->radio[j];
 			if (ar->state == ATH12K_STATE_OFF)
@@ -1012,6 +1014,8 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 		/* Restart after all the link/radio got restart */
 		if (restart_count == ah->num_radio)
 			ieee80211_restart_hw(ah->hw);
+
+		mutex_unlock(&ah->conf_mutex);
 	}
 
 	complete(&ab->driver_recovery);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 5c6c1e2eddb6..660c1b260201 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -600,7 +600,12 @@ struct ath12k {
 struct ath12k_hw {
 	struct ieee80211_hw *hw;
 
+	/* To synchronize hardware restart operation */
+	struct mutex conf_mutex;
+
 	u8 num_radio;
+
+	/* Keep last */
 	struct ath12k radio[] __aligned(sizeof(void *));
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1b465f7fed7f..4c9a591778a2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5120,10 +5120,13 @@ static void ath12k_mac_wait_reconfigure(struct ath12k_base *ab)
 
 static int ath12k_mac_start(struct ath12k *ar)
 {
+	struct ath12k_hw *ah = ar->ah;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev *pdev = ar->pdev;
 	int ret;
 
+	lockdep_assert_held(&ah->conf_mutex);
+
 	mutex_lock(&ar->conf_mutex);
 
 	switch (ar->state) {
@@ -5247,14 +5250,16 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 
 	ath12k_mac_drain_tx(ar);
 
+	mutex_lock(&ah->conf_mutex);
+
 	ret = ath12k_mac_start(ar);
-	if (ret) {
+	if (ret)
 		ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
 			   ar->pdev_idx, ret);
-		return ret;
-	}
 
-	return 0;
+	mutex_unlock(&ah->conf_mutex);
+
+	return ret;
 }
 
 int ath12k_mac_rfkill_config(struct ath12k *ar)
@@ -5316,9 +5321,12 @@ int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable)
 
 static void ath12k_mac_stop(struct ath12k *ar)
 {
+	struct ath12k_hw *ah = ar->ah;
 	struct htt_ppdu_stats_info *ppdu_stats, *tmp;
 	int ret;
 
+	lockdep_assert_held(&ah->conf_mutex);
+
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_config_mon_status_default(ar, false);
 	if (ret && (ret != -EOPNOTSUPP))
@@ -5354,7 +5362,11 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 
 	ath12k_mac_drain_tx(ar);
 
+	mutex_lock(&ah->conf_mutex);
+
 	ath12k_mac_stop(ar);
+
+	mutex_unlock(&ah->conf_mutex);
 }
 
 static u8
@@ -7119,6 +7131,8 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
+	mutex_lock(&ah->conf_mutex);
+
 	for (i = 0; i < ah->num_radio; i++) {
 		ar = &ah->radio[i];
 
@@ -7179,6 +7193,8 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 
 		mutex_unlock(&ar->conf_mutex);
 	}
+
+	mutex_unlock(&ah->conf_mutex);
 }
 
 static void
@@ -7925,6 +7941,8 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 	ah->hw = hw;
 	ah->num_radio = num_pdev_map;
 
+	mutex_init(&ah->conf_mutex);
+
 	for (i = 0; i < num_pdev_map; i++) {
 		ab = pdev_map[i].ab;
 		pdev_idx = pdev_map[i].pdev_idx;
-- 
2.34.1


