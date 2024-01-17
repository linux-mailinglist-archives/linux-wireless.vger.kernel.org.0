Return-Path: <linux-wireless+bounces-2080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2D98300FD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 09:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9591F255B9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 08:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243161118C;
	Wed, 17 Jan 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YNwmB4Id"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF01ED510
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478698; cv=none; b=IwxFwqkO2I5ptAtSM+RsIpQsFhbnVSa0DGJVPnSyzq8MPikd4hQm9MKryAvjHsC1LB/YcconzkerCMMNEZKSHcpYPxDsWaVsspprCXdSJwTyeoVZIUz7nCm6b5pS6XEJ1ljdiDM/IcYII24FuVsWorORnXpXDvY+SuqsgsusWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478698; c=relaxed/simple;
	bh=ToSB4gvwTpZeE33OT55yeaboo5tsFHOi6mBHN5Vq444=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=En8Ue515wqycluIe7ba2P3qE+5qIn9lR0kMvkl+vwsaSrdOg3PVqbAz6PiJSQdSKGl7RPmAVaU7GL1pLC73nmYAE9IvymMoY3Zk4aMLKdFfPuT9mYhFmU6lZtLpvOn+WROreRJgDE9zxvrNIAA7AT3N93IsZq+bzWtq+d9EhgF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YNwmB4Id; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7x4qr006503;
	Wed, 17 Jan 2024 08:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jgrlDuvh6Ngyi/GJTm8MM2sQ2v9YxC97VGIK16ztQ9Y=; b=YN
	wmB4Id+bL8/T1uBe9n5sLiU0i/dWNNGXk0voyTC/YnfFwVTRi0M1KKymoCwQSVF2
	UEsodwUzFTGULzTKBTwiLPKXzGAkyAAHjDp26O+osqyGM5DMDocb30PnJ541XvjL
	h5UyvS8FTaNCUlQyqYH8LpoOSjQv5PD7TLvXgFltE4ogV6+PIHFNLDcuyT3/P0h2
	LKwHxJ7oZIj+rm29Nd5W3sjtdRvi07TR87Fx0J0konxYt9HpvSH4gFL1oeIH3a32
	oHf4U9Zy4X+3q3hIp9yDMeqzTBJovBN/ZmTXxSfvhBtrJxlkRr6hjj5+OHXpu8N1
	nAfvUodpuQZfLE/5KPHA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp4ak0sa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:04:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H84r3a024525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:04:53 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 00:04:51 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v3 2/3] wifi: ath11k: replace ENOTSUPP with EOPNOTSUPP
Date: Wed, 17 Jan 2024 13:34:30 +0530
Message-ID: <20240117080431.2907471-3-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xuO_wD5QcD1AAAOEi2oW04a3Wq5gMZ89
X-Proofpoint-GUID: xuO_wD5QcD1AAAOEi2oW04a3Wq5gMZ89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=836 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170054

ENOTSUPP is not a standard error code, don't use it. Replace with
EOPNOTSUPP instead.

No functional changes, compile tested only.

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
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


