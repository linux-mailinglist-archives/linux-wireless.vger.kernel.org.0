Return-Path: <linux-wireless+bounces-2079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8388300FB
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 09:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574F22895B0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520BED272;
	Wed, 17 Jan 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EKgse0hN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6395CA47
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478696; cv=none; b=rg8gV2HfJxEN1fb5h3w+pR0rP0zHYbAEvBppFnzfT4dc01G4X/hfOx5Z/Ad2EEcI5G5epGCcCztUwVpWP7kVzmKaZK+cpbljGCMfb8TqToaWu11UpYjKKBs3CTgfSgreCjS74bR8hH33w9xpbXnrUDJffCmH83RoEgKcRAZo9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478696; c=relaxed/simple;
	bh=iuDrxpUJU4YqgsT7bigNb4kDpe1uguJS1smT4MN3BWQ=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=G3e/zh+1UFRS6MFLtSVnqSkMMuVwVEtdZtBDyLG8x1rT8rRzhspR3Yimyo+YFN/Xzd6DiFqWSmKEzxJxWzBTo9kMV4l+7K42hSYgmRpDWXz4ZylIZtIHIBlTvg0Rb9CPxdxq6GCEIAt+zpOHuym4nXjEpeMFtSQbkP4kvVaDN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EKgse0hN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H4dQc6014350;
	Wed, 17 Jan 2024 08:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yp1GrzFAhJmTEfF0DH8+vf/AoRSU8H2Ic5Gx8W+xIB0=; b=EK
	gse0hNXzBMv6eyFwCNVVIoemrcYIO0vTHnyFeIJr/FlC5PDBwQaSxdFMisZXl36R
	d7l2izsefrspcnf24CIKLKg7qlvGnqGU78daZCjHZ6BP4z/xh22wCD4VrpV2kXzQ
	b2PLm6zAwitZNmNnY9g9XG8PuK+zZpU/+ZPg1AyJDKYptlwmxbZ9Z9ilDyd8qx3n
	ojQDYt0oWtQkgltTfFEj6Ro8WZS1iLXmZOjeMFZy0JaYAS4qDQGx71KAK8MvxSKy
	gU3qDn/a7Z2E8Ahb1coCuKJ32D4JXWbHfJgPDt+RpXGFwOYDE/2P9PGfsMggpR0R
	0RC97AL5OO8guJaPzaew==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnrndaq3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:04:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H84p6t009700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:04:51 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 00:04:48 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v3 1/3] wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
Date: Wed, 17 Jan 2024 13:34:29 +0530
Message-ID: <20240117080431.2907471-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117080431.2907471-1-quic_periyasa@quicinc.com>
References: <20240117080431.2907471-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: PX4OCgmr2p07Rvn7yK2RoGjsOdpgSssh
X-Proofpoint-ORIG-GUID: PX4OCgmr2p07Rvn7yK2RoGjsOdpgSssh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170054

ENOTSUPP is not a standard error code, don't use it. Replace with
EOPNOTSUPP instead.

No functional changes, compile tested only.

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 6 +++---
 drivers/net/wireless/ath/ath12k/hal_rx.c | 4 ++--
 drivers/net/wireless/ath/ath12k/mac.c    | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 62f9cdbb811c..05d5f14cdfa1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -151,7 +151,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 
 	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 	    !ieee80211_is_data(hdr->frame_control))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	pool_id = skb_get_queue_mapping(skb) & (ATH12K_HW_MAX_QUEUES - 1);
 
@@ -837,7 +837,7 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
 	if (dp->htt_tgt_ver_major != HTT_TARGET_VERSION_MAJOR) {
 		ath12k_err(ab, "unsupported htt major version %d supported version is %d\n",
 			   dp->htt_tgt_ver_major, HTT_TARGET_VERSION_MAJOR);
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index 4f25eb9f7745..4fc08d4f85b5 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "debug.h"
@@ -247,7 +247,7 @@ int ath12k_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
 	case HAL_REO_CMD_UNBLOCK_CACHE:
 	case HAL_REO_CMD_FLUSH_TIMEOUT_LIST:
 		ath12k_warn(ab, "Unsupported reo command %d\n", type);
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 		break;
 	default:
 		ath12k_warn(ab, "Unknown reo command %d\n", type);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a90c0309230a..d453e4165228 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5055,7 +5055,7 @@ void ath12k_mac_drain_tx(struct ath12k *ar)
 
 static int ath12k_mac_config_mon_status_default(struct ath12k *ar, bool enable)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 	/* TODO: Need to support new monitor mode */
 }
 
@@ -5165,13 +5165,13 @@ static int ath12k_mac_start(struct ath12k *ar)
 	 * such as rssi, rx_duration.
 	 */
 	ret = ath12k_mac_config_mon_status_default(ar, true);
-	if (ret && (ret != -ENOTSUPP)) {
+	if (ret && (ret != -EOPNOTSUPP)) {
 		ath12k_err(ab, "failed to configure monitor status ring with default rx_filter: (%d)\n",
 			   ret);
 		goto err;
 	}
 
-	if (ret == -ENOTSUPP)
+	if (ret == -EOPNOTSUPP)
 		ath12k_dbg(ab, ATH12K_DBG_MAC,
 			   "monitor status config is not yet supported");
 
@@ -5283,7 +5283,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_config_mon_status_default(ar, false);
-	if (ret && (ret != -ENOTSUPP))
+	if (ret && (ret != -EOPNOTSUPP))
 		ath12k_err(ar->ab, "failed to clear rx_filter for monitor status ring: (%d)\n",
 			   ret);
 
-- 
2.34.1


