Return-Path: <linux-wireless+bounces-16439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6499F416D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 05:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D687A3012
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 04:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389DB149C42;
	Tue, 17 Dec 2024 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UKDvqUkH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37E12E1CD
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407988; cv=none; b=m4PikeLGK+CxBmxmZGfkaRJOAbyXpPVi4dtQZ/ZGXWZdO+Fnb7ZlMgtGt0L4IsYcfYEGSe+rCKfbq91op127Ry/khCoPvsCOlFjjamAP3f2LLaX64jB4du72ZnorbU5hZAjHyxPo49/vCfs1K5N2lhq04SyfLzKaxHP11oX2uBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407988; c=relaxed/simple;
	bh=HyuTwIS2oxYr7YzoL3menAyhMJ9rd8wKq1mgIVMe2Co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwGKFFZfGcTeMYCsBNvG/oX6+1UcBEFuhhUhtAOBO80NGuDuDHjbHPkSxUkSRGOV4HDEntvRUP5aCZSp0T7vQG/M6mmiHXWfsNTjEXBORap9MZnohVlNe6Ir4nl8CJ/sxzcHzmOs2b9YHtpt3lPQJkuO8ErZ39gUSkqtzFUb/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UKDvqUkH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGNs4DZ029742;
	Tue, 17 Dec 2024 03:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T8HVPdnyKeu87Vz1e6tZXwA1EGHkZ4aNE7FXvPCBSto=; b=UKDvqUkHGGQsYHhA
	k+MWcb2vZ6SGYPQTghjgPpg1V2sOoIrqulu7YawgE8o5QbUlBvGGdHkH4Zu1/LOo
	LB++VQfVK/qeqW1R2PJ6NtB3RMJ8oTS7SF+7G7xf9P4Ki1tCurhU61F6NVjnjlGh
	B4EbXa1BljX/XMSLGqHPKLVD3hJKR2NRaUk82UQh5Fyt+Z8V3KHXSia7d1UShSWf
	N6Di4proOQwl5Ez5Jb3gxzg8VDLY+3xxYKVPFAzThGtGz2XR26L1deyduYM0Agxz
	ajK8hORkaGLxWA2IoVmJTGeSQcHIOSQTdkMbl3teSTVdGjXP+usGADU8DVBolSdt
	kkolyA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jx9dgfwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 03:59:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH3xgsH025848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 03:59:42 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 19:59:40 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 3/4] wifi: ath12k: Refactor ath12k_get_num_hw() helper function argument
Date: Tue, 17 Dec 2024 09:29:19 +0530
Message-ID: <20241217035920.2683568-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
References: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: g4llMOBXVkQW-fPT2dTocc_6ScIVrhBj
X-Proofpoint-ORIG-GUID: g4llMOBXVkQW-fPT2dTocc_6ScIVrhBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412170030

Currently, the ath12k_get_num_hw() helper function takes the device handle
as an argument. Here, the number of hardware is retrieved from the group
handle. Demanding the device handle from the caller is unnecessary since
in some cases the group handle is already available. Therefore, change this
helper function argument from the device handle to the group handle. This
also fixes the below Smatch static checker warning.

Smatch warning:
ath12k_mac_destroy() error: we previously assumed 'ab' could be null

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/ath12k/3e705de0-67d1-4437-97ff-4828d83ae2af@stanley.mountain/
Closes: https://scan7.scan.coverity.com/#/project-view/52682/11354?selectedIssue=1602340
Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 8 ++++----
 drivers/net/wireless/ath/ath12k/core.h | 4 ++--
 drivers/net/wireless/ath/ath12k/mac.c  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index af49e7db4928..7b482637676a 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1183,7 +1183,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	rfkill_radio_on = ab->rfkill_radio_on;
 	spin_unlock_bh(&ab->base_lock);
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab->ag); i++) {
 		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah)
 			continue;
@@ -1235,7 +1235,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 	if (ab->is_reset)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab->ag); i++) {
 		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
@@ -1274,7 +1274,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	struct ath12k *ar;
 	int i, j;
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab->ag); i++) {
 		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
@@ -1336,7 +1336,7 @@ static void ath12k_core_restart(struct work_struct *work)
 			ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset success\n");
 		}
 
-		for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+		for (i = 0; i < ath12k_get_num_hw(ab->ag); i++) {
 			ah = ath12k_ag_to_ah(ab->ag, i);
 			ieee80211_restart_hw(ah->hw);
 		}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 6b31e053d6da..f37a50f3eabb 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1209,9 +1209,9 @@ static inline void ath12k_ag_set_ah(struct ath12k_hw_group *ag, int idx,
 	ag->ah[idx] = ah;
 }
 
-static inline int ath12k_get_num_hw(struct ath12k_base *ab)
+static inline int ath12k_get_num_hw(struct ath12k_hw_group *ag)
 {
-	return ab->ag->num_hw;
+	return ag->num_hw;
 }
 
 static inline struct ath12k_hw_group *ath12k_ab_to_ag(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 99159663ecad..c4eb54480ad1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11227,7 +11227,7 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 	int i;
 	int ret;
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+	for (i = 0; i < ath12k_get_num_hw(ag); i++) {
 		ah = ath12k_ag_to_ah(ag, i);
 
 		ret = ath12k_mac_hw_register(ah);
@@ -11259,7 +11259,7 @@ void ath12k_mac_unregister(struct ath12k_hw_group *ag)
 
 	clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 
-	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
+	for (i = ath12k_get_num_hw(ag) - 1; i >= 0; i--) {
 		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
@@ -11340,7 +11340,7 @@ void ath12k_mac_destroy(struct ath12k_hw_group *ag)
 		}
 	}
 
-	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
+	for (i = 0; i < ath12k_get_num_hw(ag); i++) {
 		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
-- 
2.34.1


