Return-Path: <linux-wireless+bounces-8352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA78D68A2
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 20:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359CF1F24FDC
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 18:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F415B99F;
	Fri, 31 May 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a+yepiUr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0547711B
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178671; cv=none; b=ONILWpGF3AbByYHwhWx1DP4vRnAO8CyY6OLaHpbU11zicPm/rLwEH+r+tLRMFwuB0A19QHcE4rL5cm6Pa1kFqx1yXbxFQD9DIwzWFApcIOTGh5LDKWtMQcmwA60UkwlmlzVwL3V/Qz2yTep30kN6e4LOs34Zfx5mpQNylZ2JHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178671; c=relaxed/simple;
	bh=hEUZUNvfog/L5XqwmaI3S0w3b7ld5b/Ssk9RrZgZAQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDD+K8XHEee3c96Zth/zpGm9Vl4Ktx0R4WuHwjsMcNS3GE0WgNB0Zwq6KVbKhkvcJ4XGUD+MGGCvHJ6LefNxBlpuWSawa14pc3qbfVManjNMlQke5OZZIxbMN4Oini5YhmLZDbPuqvN96tJYk2JpN7OszDhcdUeRiO6p+v7yAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a+yepiUr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VHH0DG012837;
	Fri, 31 May 2024 18:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PsWkVlbWOWC
	AFADPZTEIXLFgeVn8IL2OgXC2nvopReA=; b=a+yepiUrjRd5tBAz07S9LHaHxMu
	BHPd04ihx7i68F1t/D6D5DbnWzBBtNTHavaPkR3wc3n8jqVKYR0jQgtBrQlszWlk
	GHqxoHJM9NZ94fzaP6kOoQN/FpVWKtmDGbleSAX0r4P+g0bKMAzio6hh6kQuxJ8Q
	h1qKq/8bsbUx9SLKlEo6eu2QW12cmDz1wroJlOZ98Uj0UAAN+zTV2Xp0nPNNieoW
	SAXBYYExpHQFzCv8rSP0IBKbwoxwdhagjn1NHAPVPmgK/Xprgi+18PD6VcQ7Mm0J
	bmSd5W2iKDMMGCFedhm06WN/whSmXq1Z1pf74Aku97fdp/XK/zBr5rdsgMA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qqvhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44VI4FgU012029;
	Fri, 31 May 2024 18:04:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3yf34nn90c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:16 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44VI0slV009515;
	Fri, 31 May 2024 18:04:16 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44VI4G87012054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:16 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id E1AC841174; Fri, 31 May 2024 23:34:15 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v8 3/8] wifi: ath12k: Add ath12k_get_num_hw api
Date: Fri, 31 May 2024 23:34:06 +0530
Message-Id: <20240531180411.1149605-4-quic_hprem@quicinc.com>
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
X-Proofpoint-GUID: J6t_9Q8kYE9ON4Uw5AYJAVZ_UUmCbczh
X-Proofpoint-ORIG-GUID: J6t_9Q8kYE9ON4Uw5AYJAVZ_UUmCbczh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=853 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310137

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, one or more ath12k_hw is part of device (ath12k_base) but
in future, ath12k_hw would be part of device group (ath12k_hw_group).
Hence, num_hw under device would be moved to device group.

To facilitate above transition, add helper ath12k_get_num_hw() api to
get the number of radios per device. In future, this helper would be
able to get the number of radios in a device group.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 6 +++---
 drivers/net/wireless/ath/ath12k/core.h | 5 +++++
 drivers/net/wireless/ath/ath12k/mac.c  | 8 ++++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3925bb70d479..7ad65ace7123 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -946,7 +946,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	rfkill_radio_on = ab->rfkill_radio_on;
 	spin_unlock_bh(&ab->base_lock);
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
@@ -998,7 +998,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 	if (ab->is_reset)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
@@ -1037,7 +1037,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	struct ath12k *ar;
 	int i, j;
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3f5c9fa9d04c..a22f3561deb0 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1062,4 +1062,9 @@ static inline void ath12k_ab_set_ah(struct ath12k_base *ab, int idx,
 {
 	ab->ah[idx] = ah;
 }
+
+static inline int ath12k_get_num_hw(struct ath12k_base *ab)
+{
+	return ab->num_hw;
+}
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f8e8320b8598..66587c5ea8fd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9157,7 +9157,7 @@ int ath12k_mac_register(struct ath12k_base *ab)
 	ab->cc_freq_hz = 320000;
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 
 		ret = ath12k_mac_hw_register(ah);
@@ -9184,7 +9184,7 @@ void ath12k_mac_unregister(struct ath12k_base *ab)
 	struct ath12k_hw *ah;
 	int i;
 
-	for (i = ab->num_hw - 1; i >= 0; i--) {
+	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
@@ -9254,7 +9254,7 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
 		pdev->ar = NULL;
 	}
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
@@ -9277,7 +9277,7 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 	ab->num_hw = ab->num_radios;
 	radio_per_hw = 1;
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		for (j = 0; j < radio_per_hw; j++) {
 			pdev_map[j].ab = ab;
 			pdev_map[j].pdev_idx = (i * radio_per_hw) + j;
-- 
2.34.1


