Return-Path: <linux-wireless+bounces-9691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85891BBE6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 11:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB7C1F2207C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75A15383A;
	Fri, 28 Jun 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CsCNtqMk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ADE2139A8
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568333; cv=none; b=ecG0lcr1b23VOXE8QRBYOtnMvAnyLjPluwhEc+ZzuFdK+epi4xdsmfp4jjAj0GeDMrnDSmLKbdQoMIHFRJ/8OAWWBCj1kQPEtIRrMlOpCj4JSP5k1E9JWNOAidAkLGRzIQ43DHZXpMxmPnbnLbgWrytrHXljOdTKlOr0IGFBGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568333; c=relaxed/simple;
	bh=3ZQ664DMaEhb9/CM1oBa67YfTyNI/AW76sk/5RJp/iI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pP2bMfm+yaBhEXQpCGRIJwL5HLSHMYyqv2aSFoDvKo07x9QgVTYrNW0kLVKt1THDnGa2nE+LNxumryU8+77Y/qiGwxbgxKz51lXKGL7rcWzmF9zmjGal07qRHkAvEGpgkao6D7z0PTx/mP/rZ25ZAiJlkSFIv/UZqfuG3IkIgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CsCNtqMk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8qm4c011470;
	Fri, 28 Jun 2024 09:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Dekaps9oFog
	cEKDa7jpmS968SeNyOL1iWhUKfbeTCV8=; b=CsCNtqMk13iaS08psyrw1Frz8bI
	004XSDr/mNuPClYZOR1y7hXlbuUZR7WZ5ZKp79fTSU/asPA7pj5HsuJ4FqB7YQt2
	sME9HsBandUqVbXI8fpSUBQ0Tq9fa7A+XvyMnqPuiTVY73J9wGLIBwrS9/rBta8c
	IY5k7/1s0SHLQhSEYMqcNIKvInkbHfiw72AfYcktVIwQDC47gM39P9TFDWBwgtGb
	afjAjua9lOI3RI6nTEmsNrAD5z/+PULPELYoIYNMZQaENvLI+HMl16YpzDEVOe7z
	RpW2axPv8om6Mh+To/xmqpaZu7jkmx1RILwHzAp026zzCYZZ32fcmN2aoAA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdqf4ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:52:08 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S9q5tM017518;
	Fri, 28 Jun 2024 09:52:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3ywqpmmm2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:52:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45S9q4sV017506;
	Fri, 28 Jun 2024 09:52:04 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45S9q4w1017505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:52:04 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id F3FDD410E0; Fri, 28 Jun 2024 15:22:03 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v9 3/8] wifi: ath12k: Add ath12k_get_num_hw api
Date: Fri, 28 Jun 2024 15:21:34 +0530
Message-Id: <20240628095139.292952-4-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628095139.292952-1-quic_hprem@quicinc.com>
References: <20240628095139.292952-1-quic_hprem@quicinc.com>
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
X-Proofpoint-ORIG-GUID: phbgjVaazTDdgPcgYpdvxHXPjWWJ5xrr
X-Proofpoint-GUID: phbgjVaazTDdgPcgYpdvxHXPjWWJ5xrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=883
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280072

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
---
 drivers/net/wireless/ath/ath12k/core.c | 8 ++++----
 drivers/net/wireless/ath/ath12k/core.h | 5 +++++
 drivers/net/wireless/ath/ath12k/mac.c  | 8 ++++----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 75ed1df397f7..690896c1cca1 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -979,7 +979,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	rfkill_radio_on = ab->rfkill_radio_on;
 	spin_unlock_bh(&ab->base_lock);
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
@@ -1031,7 +1031,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 	if (ab->is_reset)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
@@ -1070,7 +1070,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	struct ath12k *ar;
 	int i, j;
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
@@ -1125,7 +1125,7 @@ static void ath12k_core_restart(struct work_struct *work)
 	}
 
 	if (ab->is_reset) {
-		for (i = 0; i < ab->num_hw; i++) {
+		for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 			ah = ath12k_ab_to_ah(ab, i);
 			ieee80211_restart_hw(ah->hw);
 		}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index bb767a562559..e7238dab16a0 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1081,4 +1081,9 @@ static inline void ath12k_ab_set_ah(struct ath12k_base *ab, int idx,
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
index 693a2ee9d541..b18cc4dfbf44 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9345,7 +9345,7 @@ int ath12k_mac_register(struct ath12k_base *ab)
 	ab->cc_freq_hz = 320000;
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 
 		ret = ath12k_mac_hw_register(ah);
@@ -9372,7 +9372,7 @@ void ath12k_mac_unregister(struct ath12k_base *ab)
 	struct ath12k_hw *ah;
 	int i;
 
-	for (i = ab->num_hw - 1; i >= 0; i--) {
+	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
@@ -9441,7 +9441,7 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
 		pdev->ar = NULL;
 	}
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
@@ -9464,7 +9464,7 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 	ab->num_hw = ab->num_radios;
 	radio_per_hw = 1;
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		for (j = 0; j < radio_per_hw; j++) {
 			pdev_map[j].ab = ab;
 			pdev_map[j].pdev_idx = (i * radio_per_hw) + j;
-- 
2.34.1


