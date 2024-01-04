Return-Path: <linux-wireless+bounces-1470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B02DF823B06
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 04:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AABFB24A33
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 03:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733ED12B79;
	Thu,  4 Jan 2024 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TBc5fqGj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E75684
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4040BpwB022623;
	Thu, 4 Jan 2024 03:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=s088hwG+aMnDtVz0nGMNSb13jBlIIKc4cAlJQMw8eNk=; b=TB
	c5fqGj/gP23tlKghIrxyLSpX08ih4cxI5CTGBcHko8eRsLPQCY0XHQJZqoT6oBRs
	7+w/Lb/P/K+YjKrnefI3rZ14lNrdsA/wLub+1BBA3HM4pN8dne45WH63ku02xNSr
	3pn/yiT3vSXxsarzzbDkttze7NPeL6f93Qe5P19lLg3KmaYbQlmWVIKI/npC5Wba
	INH88w0dltHvIi8OdxPJbPQERJtkIMw0ZTcPep8r3UgqXu/ZywGP4iHts06LKAna
	Tv4YV4hO8TTNt1Z25+gurR84/bhevb+CbbjkgIeQlEwz/RGk/vhoA7XF7ok/8hZZ
	lV+PIwNCAVcKDZ6xebLQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vdchngxmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 03:15:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4043FTot002241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 03:15:29 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 19:15:27 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 2/3] wifi: ath11k: replace ENOTSUPP with EOPNOTSUPP
Date: Thu, 4 Jan 2024 08:45:08 +0530
Message-ID: <20240104031509.366302-3-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: M3ByrS8Rjkei32uv8180sJPePhYHip7z
X-Proofpoint-GUID: M3ByrS8Rjkei32uv8180sJPePhYHip7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=835 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401040020

ENOTSUPP is not a standard error code, don't use it. Replace with
EOPNOTSUPP instead.

No functional changes, compile tested only.

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c  | 6 +++---
 drivers/net/wireless/ath/ath11k/hal_rx.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index c1072e66e3e8..272b1c35f98d 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -103,7 +103,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	if (unlikely(!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 		     !ieee80211_is_data(hdr->frame_control)))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	pool_id = skb_get_queue_mapping(skb) & (ATH11K_HW_MAX_QUEUES - 1);
 
@@ -1018,7 +1018,7 @@ int ath11k_dp_tx_htt_h2t_ver_req_msg(struct ath11k_base *ab)
 	if (dp->htt_tgt_ver_major != HTT_TARGET_VERSION_MAJOR) {
 		ath11k_err(ab, "unsupported htt major version %d supported version is %d\n",
 			   dp->htt_tgt_ver_major, HTT_TARGET_VERSION_MAJOR);
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index e758ee8e17c9..8f7dd43dc1bd 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "debug.h"
@@ -246,7 +246,7 @@ int ath11k_hal_reo_cmd_send(struct ath11k_base *ab, struct hal_srng *srng,
 	case HAL_REO_CMD_UNBLOCK_CACHE:
 	case HAL_REO_CMD_FLUSH_TIMEOUT_LIST:
 		ath11k_warn(ab, "Unsupported reo command %d\n", type);
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 		break;
 	default:
 		ath11k_warn(ab, "Unknown reo command %d\n", type);
-- 
2.34.1


