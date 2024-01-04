Return-Path: <linux-wireless+bounces-1468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F2823B04
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 04:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACEC1F2610F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 03:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98055257;
	Thu,  4 Jan 2024 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="navEqNiS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCA5258
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4042HF12026081;
	Thu, 4 Jan 2024 03:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=4EXNIawE3Ldt0bkjUUdacXxvpebkSLKHpan6L7kAnJY=; b=na
	vEqNiSfSANOY3UZHwheN8HVuTTVhX6CHvzPr7MlQPuF6syrJjdHLBF0LQ7uESGfx
	UucISAaxg9XSSAeak3AW8zNxEu6h5KYawtIKsls7T6xmg0VNbiJLGV7mI4xQWxh8
	CP/o/QvZrZjHdzGUr+rQai9qCqA1FJMtoU61dtknxlOciffSySulQpdX7w1WDqXO
	2zibeiwBi+wb7vbkz0jje0C4AoFggiv336jS2T7190BBp+iWp+5yOV27DBir1XUX
	kSTbIh+WqDklLz7kcspOB7S8n/DpaZ0g/EtKnV+G0mpS40gapS/ol4dZd2XxehQw
	NRjqirgVlbObc0Qh3/Xg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd3mb2cgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 03:15:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4043FQjg002229
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 03:15:27 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 19:15:24 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 1/3] wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
Date: Thu, 4 Jan 2024 08:45:07 +0530
Message-ID: <20240104031509.366302-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104031509.366302-1-quic_periyasa@quicinc.com>
References: <20240104031509.366302-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: bBr5uwowWZf0BH2XjAPeeSaIS8pKeje4
X-Proofpoint-ORIG-GUID: bBr5uwowWZf0BH2XjAPeeSaIS8pKeje4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040020

ENOTSUPP is not a standard error code, don't use it. Replace with
EOPNOTSUPP instead.

No functional changes, compile tested only.

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c  |  6 +++---
 drivers/net/wireless/ath/ath12k/hal_rx.c |  4 ++--
 drivers/net/wireless/ath/ath12k/mac.c    | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

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
index 88cec54c6c2e..5fe1d3e58981 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -5018,7 +5018,7 @@ void ath12k_mac_drain_tx(struct ath12k *ar)
 
 static int ath12k_mac_config_mon_status_default(struct ath12k *ar, bool enable)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 	/* TODO: Need to support new monitor mode */
 }
 
@@ -5130,13 +5130,13 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
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
 		ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 			   "monitor status config is not yet supported");
 
@@ -5234,7 +5234,7 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 
 	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_config_mon_status_default(ar, false);
-	if (ret && (ret != -ENOTSUPP))
+	if (ret && (ret != -EOPNOTSUPP))
 		ath12k_err(ar->ab, "failed to clear rx_filter for monitor status ring: (%d)\n",
 			   ret);
 
-- 
2.34.1


