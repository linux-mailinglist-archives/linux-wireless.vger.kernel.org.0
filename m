Return-Path: <linux-wireless+bounces-16275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 978CB9EDCD6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 01:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E2816898E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 00:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FA654723;
	Thu, 12 Dec 2024 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k3DNAs4n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14355C29
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964572; cv=none; b=hxG62KgKh+JI//iXlfsfxqGC2iD6IvfA5XT2ofk86X7+yIgiCHX7aLYUCW2YyqN1V/7imhBsKKE8gspZJcBDK7LYZF2e0TpexjvCGBDdfmZR7TyeZR8juckWGPUuHDIUPaZThpDvO64aGC9qrMvyoZq8Nt8yTxk0xLo3DNgte8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964572; c=relaxed/simple;
	bh=YUWP2t3bTAfpSQ956fbqKuZYsTs3A/la2OdGxuC/x4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwz/AjZJoV6zyUxoGvcDQ7RYMLs9KdCE7n5mYwUrxgExw95jLKSwMyPaG1n9lEdc86Ec4Ik6X9ZpaXuVM5dWTumTUkhjTHBiVSer/kcHVOP66CZwWhSoSdP+g6pXhlJ8BULjVk6oo/cFQqXviFWaYyaICJsNVln9IyBEPvzh6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k3DNAs4n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHD5nP002087;
	Thu, 12 Dec 2024 00:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XC9rAb9zCKZkZsLnw6isWKQVA7rvKja8/xZGMta4lLc=; b=k3DNAs4nepCo9n2F
	JZgdgR7bCrOk7dBATo7yiCxOYqWVl1Gm9LK756t4dueyzel8PMWM8uxg+IxU80uU
	AxQRdMCg8W8Fy4YwWUIs51QoyWgIqxxCMuzTyDVHto/XoHEH6JzIT1PJzTCDzGd+
	078cLr9Qz2Y1ylO+WYYcD1ki877nUfBf5w5PkPn3AnA+okZDfeJEHE8Cjn2jwfaW
	Z4h1dz+V4nv6D2ZcT6/chGdkzRCHH6bs4WynNFJgUvUtUo+hzbgv7EdEnotSugKN
	oFCiF45lWQZu2PYrfBSXozYfnjEDfXDCImVYdD70aisb9uHfSOcnh2ldqZQbOj19
	Oa+13w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f0r9un7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 00:49:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC0nQbf032238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 00:49:26 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 16:49:24 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/4] wifi: ath12k: Refactor the ath12k_hw get helper function argument
Date: Thu, 12 Dec 2024 06:19:04 +0530
Message-ID: <20241212004906.3087425-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: nnYMb81efKayg07ZJLZBK07n-gNQDMxy
X-Proofpoint-GUID: nnYMb81efKayg07ZJLZBK07n-gNQDMxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=964
 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120004

Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
ath12k_hw get helper function takes the device handle and the index as
parameters. Here, the index parameter is specific to the group handle.
Therefore, change this helper function argument from the device handle
to the group handle.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  8 ++++----
 drivers/net/wireless/ath/ath12k/core.h |  4 ++--
 drivers/net/wireless/ath/ath12k/mac.c  | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 49d1ac15cb7a..bf391e6e8f72 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1109,7 +1109,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	spin_unlock_bh(&ab->base_lock);
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah)
 			continue;
 
@@ -1161,7 +1161,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1200,7 +1200,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	int i, j;
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ab->ag, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1262,7 +1262,7 @@ static void ath12k_core_restart(struct work_struct *work)
 		}
 
 		for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-			ah = ath12k_ab_to_ah(ab, i);
+			ah = ath12k_ag_to_ah(ab->ag, i);
 			ieee80211_restart_hw(ah->hw);
 		}
 	}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3173d94989c9..56e740ec61e8 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1170,9 +1170,9 @@ static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
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
index 8f2ca05617e6..7116516b4c01 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10826,7 +10826,7 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 	int ret;
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 
 		ret = ath12k_mac_hw_register(ah);
 		if (ret)
@@ -10839,7 +10839,7 @@ int ath12k_mac_register(struct ath12k_hw_group *ag)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -10858,7 +10858,7 @@ void ath12k_mac_unregister(struct ath12k_hw_group *ag)
 	clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 
 	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -10936,7 +10936,7 @@ void ath12k_mac_destroy(struct ath12k_hw_group *ag)
 	}
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
@@ -11017,7 +11017,7 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		ah = ath12k_ab_to_ah(ab, i);
+		ah = ath12k_ag_to_ah(ag, i);
 		if (!ah)
 			continue;
 
-- 
2.34.1


