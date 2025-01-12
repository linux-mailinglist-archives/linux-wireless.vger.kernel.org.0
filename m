Return-Path: <linux-wireless+bounces-17374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCAEA0A767
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C881D7A3A79
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 07:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5D1494D8;
	Sun, 12 Jan 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NucCj4lW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6814F9EB
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736666215; cv=none; b=i5W0f98qIAjRFbB2y3R3K9gtDNMNJyIpQb+tgIXb+Dzz2GoXuQxKmMqK/a81qODxYG/6NtAos6HlBdyT7Bl3blGgGbF07dLolDESjF5Oajdf5NtcCTGRo/qXSRo/Wn8Layr/q865vWdJ9M8CbCdMA4q0tAA/FmKeWl9ka5t9fKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736666215; c=relaxed/simple;
	bh=WTwhoY1im5K7j8mJEu5hoQuoGU+/E3d62DLErDx1Gi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0+2fKNic+sS7jN3n9+w+xc4VHKcoc3ej+ej8U7fCUJAwXbSsIU0zkA2Y0qSg2/A4iVPGS1hwTNiU3PDW9gKBvFIqfsypqFixKClwLOk/JNMjvfQMGiKVkh6eX5Glnzf3ghyl6U6wCGxGXEyWoCUHLBQOgqCdma3RoTjH5sdmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NucCj4lW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C7GQPb017106;
	Sun, 12 Jan 2025 07:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tXiaEYJZyP3oUoyUnjQ5V5vGNqVmGLpMPipY3C6eLto=; b=NucCj4lWu+1jXpX+
	e8xvPdX2EtfF3uLvj8Um+vclfzWn9Tm6Uwia1UzfFGV0dk2dOKYYD9VrBK0+sVw2
	PH6wa89CA7JPy/8kPQU0Smo8a22K6APVbWiGDqt9jsBUe7TqiZf1UWtV9XFYFhGx
	oUOsHFjFPZd7+bglSzzZ3vKmd3zZfg+kF3JNsMnFE35hB0j7xhCc7Xz23Bqbm1L0
	eTW0rxHi+J/+MpV0bdORw2Aefo36zZp5Y/tI0wg0Vi8VPJCEf2FkC3/GlWhomrmt
	7xSZ8rVhRQl/wLOCBl+5cXWWFkQQshkm4ci0kg/nQqyrMf10SeEcRVLjA/cjyrBH
	5dt/Vw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hkfhpp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 07:16:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C7Gn1s001090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 07:16:49 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 23:16:47 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH v4 2/4] wifi: ath12k: Refactor the ath12k_hw get helper function argument
Date: Sun, 12 Jan 2025 12:46:28 +0530
Message-ID: <20250112071630.4059410-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: ONtmxDnNbyg0L-WeJVWCQuL-9AStbbB7
X-Proofpoint-ORIG-GUID: ONtmxDnNbyg0L-WeJVWCQuL-9AStbbB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501120063

Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
ath12k_hw get helper function takes the device handle and the index as
parameters. Here, the index parameter is specific to the group handle.
Therefore, change this helper function argument from the device handle
to the group handle.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  8 ++++----
 drivers/net/wireless/ath/ath12k/core.h |  4 ++--
 drivers/net/wireless/ath/ath12k/mac.c  | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0c6b35aac96e..af49e7db4928 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1184,7 +1184,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	spin_unlock_bh(&ab->base_lock);
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah)
 			continue;
 
@@ -1236,7 +1236,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1275,7 +1275,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	int i, j;
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1337,7 +1337,7 @@ static void ath12k_core_restart(struct work_struct *work)
 		}
 
 		for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-			ah = ath12k_ab_to_ah(ab, i);
+			ah = ath12k_ag_to_ah(ab->ag, i);
 			ieee80211_restart_hw(ah->hw);
 		}
 	}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 9eb4eb410af2..4932bd1c2096 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1194,9 +1194,9 @@ static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
 	for ((index) = 0; ((index) < (ah)->num_radio && \
 	     ((ar) = &(ah)->radio[(index)])); (index)++)
 
-static inline struct ath12k_hw *ath12k_ab_to_ah(struct ath12k_base *ab, int idx)
+static inline struct ath12k_hw *ath12k_ag_to_ah(struct ath12k_hw_group *ag, int idx)
 {
-	return ab->ag->ah[idx];
+	return ag->ah[idx];
 }
 
 static inline void ath12k_ag_set_ah(struct ath12k_hw_group *ag, int idx,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6a7a01c35f02..285bb88acb90 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11244,7 +11244,7 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 	int ret;
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 
 		ret = ath12k_mac_hw_register(ah);
 		if (ret)
@@ -11257,7 +11257,7 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -11276,7 +11276,7 @@ void ath12k_mac_unregister(struct ath12k_hw_group *ag)
 	clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 
 	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -11357,7 +11357,7 @@ void ath12k_mac_destroy(struct ath12k_hw_group *ag)
 	}
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -11438,7 +11438,7 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
-- 
2.34.1


