Return-Path: <linux-wireless+bounces-8353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DEB8D68A3
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 20:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB02288700
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E58317C9EE;
	Fri, 31 May 2024 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QHVjgxai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0122E63B
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178672; cv=none; b=XVkhjEjS+7Z8niZUMHmlpFVGNoXxvTyFnB90j27MkQekl1M7NvXwLylyd14g4L1PjxsviihN3TmzSAZSsL1EvRtGp8LD+avnX0RUeJxu0EDNehsnpdjSQrmBdrWd9snZd+f7tgbnWAw1JyUVNeXIjuyZ+bTfvwIDp7y6fDCsD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178672; c=relaxed/simple;
	bh=H0vrRRoGak1HWTWRHl3BfnSTHHaVMSPX0oW9FjqMkIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIvN2qPvbJxPzzv/i0eW22NYr9FQiOXJPN8eMh0znKqY+MzqMA9dK0kDIPhiXa2KG767HUT28lQCePRt2SM6T73GtFQxB/Tk3moRWGQbo1gSN7eS2eeITbjfX1u2kK1zN0C8eTo2YRUhQSb9JOCtpE/qNqx2FUgxg14hA4lSz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QHVjgxai; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VI1FlB016761;
	Fri, 31 May 2024 18:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=saC54pH6gx5
	CQhnMfdlq3jn3DSwW03jFkbE6dagdcXI=; b=QHVjgxai83uqLgEu2JWThx9sXRc
	frGunbzfphw1qDsUsolLUMDNf6tGpg2A9aQ/pnEdnIds0gvzUH3NmUQQqk9eK8c1
	VDgivqTKgvC0B5JDJg/xFoWbygHTH+SXMQWtZx7FNDDONodLmypiwTrzdbpAIC7W
	v/j7ymYJ8p5zsEqJ78zd02xLcHDZChH0VcROpZtAL1ISIfWmYJsMk8MhBK1Cy8ky
	VPNwT3Y2xaJEcz+xe/dmVo0BKh38Uv76/yABSl07Cf55iKFtQiKJHvYIrgzFzXwJ
	oJ19DuPNa0LSGs9IxIpjGoJ+vddcFRQu0vdY3iYr5lI16g+gYpzQd//LCFw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yesw5kvex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44VI4Gox012042;
	Fri, 31 May 2024 18:04:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3yf34nn906-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:16 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44VI4F1r012021;
	Fri, 31 May 2024 18:04:16 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44VI4GaT012034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:16 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 3A0ED41137; Fri, 31 May 2024 23:34:15 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v8 2/8] wifi: ath12k: Add helpers to get or set ath12k_hw
Date: Fri, 31 May 2024 23:34:05 +0530
Message-Id: <20240531180411.1149605-3-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531180411.1149605-1-quic_hprem@quicinc.com>
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X-hQzqW9H1PGIGxCNMDh27NJznk9J6DN
X-Proofpoint-GUID: X-hQzqW9H1PGIGxCNMDh27NJznk9J6DN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=743 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310137

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, one or more ath12k_hw is part of a device (ath12k_base) but
in future, it would be part of device group abstraction (ath12k_hw_group),
i.e., when multiple radios (ar) across different devices can be combined
together in a device group (ath12k_hw_group).

In order to facilitate the above transition, introduce helpers such as
ath12k_ab_to_ah() and ath12k_ab_set_ah() to get and set values of ath12k_hw
respectively.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  6 +++---
 drivers/net/wireless/ath/ath12k/core.h | 11 +++++++++++
 drivers/net/wireless/ath/ath12k/mac.c  | 23 +++++++++++++----------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 342d0ab12105..3925bb70d479 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -947,7 +947,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	spin_unlock_bh(&ab->base_lock);
 
 	for (i = 0; i < ab->num_hw; i++) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
 
@@ -999,7 +999,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	for (i = 0; i < ab->num_hw; i++) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1038,7 +1038,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	int i, j;
 
 	for (i = 0; i < ab->num_hw; i++) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7d20b09c52e6..3f5c9fa9d04c 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1051,4 +1051,15 @@ static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
 #define for_each_ar(ah, ar, index) \
 	for ((index) = 0; ((index) < (ah)->num_radio && \
 	     ((ar) = &(ah)->radio[(index)])); (index)++)
+
+static inline struct ath12k_hw *ath12k_ab_to_ah(struct ath12k_base *ab, int idx)
+{
+	return ab->ah[idx];
+}
+
+static inline void ath12k_ab_set_ah(struct ath12k_base *ab, int idx,
+				    struct ath12k_hw *ah)
+{
+	ab->ah[idx] = ah;
+}
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 784964ae03ec..f8e8320b8598 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9158,7 +9158,7 @@ int ath12k_mac_register(struct ath12k_base *ab)
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
 
 	for (i = 0; i < ab->num_hw; i++) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 
 		ret = ath12k_mac_hw_register(ah);
 		if (ret)
@@ -9169,7 +9169,7 @@ int ath12k_mac_register(struct ath12k_base *ab)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
 
@@ -9185,7 +9185,7 @@ void ath12k_mac_unregister(struct ath12k_base *ab)
 	int i;
 
 	for (i = ab->num_hw - 1; i >= 0; i--) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
 
@@ -9243,6 +9243,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 void ath12k_mac_destroy(struct ath12k_base *ab)
 {
 	struct ath12k_pdev *pdev;
+	struct ath12k_hw *ah;
 	int i;
 
 	for (i = 0; i < ab->num_radios; i++) {
@@ -9254,11 +9255,12 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
 	}
 
 	for (i = 0; i < ab->num_hw; i++) {
-		if (!ab->ah[i])
+		ah = ath12k_ab_to_ah(ab, i);
+		if (!ah)
 			continue;
 
-		ath12k_mac_hw_destroy(ab->ah[i]);
-		ab->ah[i] = NULL;
+		ath12k_mac_hw_destroy(ah);
+		ath12k_ab_set_ah(ab, i, NULL);
 	}
 }
 
@@ -9289,7 +9291,7 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 			goto err;
 		}
 
-		ab->ah[i] = ah;
+		ath12k_ab_set_ah(ab, i, ah);
 	}
 
 	ath12k_dp_pdev_pre_alloc(ab);
@@ -9298,11 +9300,12 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		if (!ab->ah[i])
+		ah = ath12k_ab_to_ah(ab, i);
+		if (!ah)
 			continue;
 
-		ath12k_mac_hw_destroy(ab->ah[i]);
-		ab->ah[i] = NULL;
+		ath12k_mac_hw_destroy(ah);
+		ath12k_ab_set_ah(ab, i, NULL);
 	}
 
 	return ret;
-- 
2.34.1


