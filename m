Return-Path: <linux-wireless+bounces-7499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6938C2F39
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 05:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6951B1F22834
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 03:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B6E22F1C;
	Sat, 11 May 2024 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eDtrDfg3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319A24205
	for <linux-wireless@vger.kernel.org>; Sat, 11 May 2024 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397013; cv=none; b=kGWw7Fu40K80Onpv0qiStVGXoXH32IYiiiahtA4dQFHads9as5t5xq+gj9rWE9ly8IVrGLcchUG2kVCN1UK7Tkp2Yep2TY41mBp38X2RteNGi0bWIvDqrRhhXFrPE5p7M2Ft4uPWF6IXJj/IgF/1/6kc8mMAi+r33lybltIKNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397013; c=relaxed/simple;
	bh=VorbdE/x38/O3ZQY3iYAzXxGnGhLxYlmfKxk3GcOdLg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T00gCxFqqgsCHb0hjAMk2jrBJIYLyMN46ILT+SOphKck4SnkD/Fd2Gv2Q9huswXf/WmdM8DvNkj7o1wm0YDCNHS76GEhqtNeGdhq5LOiA1Q6fSlBslY/ZKOZ/Fz9FJ7/1Uy4o3cCVzNPls8/Qq0K1QiOx17pfFBh6KiNOpgazEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eDtrDfg3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44B1jOr4026729;
	Sat, 11 May 2024 03:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Xk2cGdM
	d7Ex2FhBzTUBvKQRUUuz9cmQUhT7TWmA3yqk=; b=eDtrDfg38tkQIgqqA2oTZk2
	ah/nZXcIzhiFwJoC/hXHMn+W1sW4DVk6R3oYga6OHRLdGF9b5RQc96G/aAMymB9Z
	RPrlU7pk5t2sStB4+jTGvvculzMX+mVIdTNricpl6Qc/F7OUSeuAw+nt6FlrjUpI
	0iBK54Msh/yHKAEQzbFMR8hlIV/xsG2XN+7rbXY5VbOD0DmdK9zZEqSKFrxGM7Xv
	Gqsm5pkIlUlRgqcY17PshWATeZDmerXLG5yrCVlq8iODMUMW+gp0bOLe6H2sHt4y
	M9TDHkP8bHd+pIuSAYqdmKVwqzEjuDrsiyc8kg8nfDwQJBv6dq+LUdwb/g+4wHw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1y9kr2ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 03:10:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44B3A5Vm022017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 03:10:05 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 10 May 2024 20:10:04 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix the issue that calculation of ack signal strength
Date: Sat, 11 May 2024 11:09:17 +0800
Message-ID: <20240511030917.65811-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 63CQD_hcXsaRlQoW1gyxvpSyx8oysLEt
X-Proofpoint-GUID: 63CQD_hcXsaRlQoW1gyxvpSyx8oysLEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_18,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405110023

Currently, the calculation of ack signal strength is incorrect.

This is because before calculating the ack signal strength, ath12k need
to determine whether the hardware and firmware support db2dbm, if the
hardware and firmware support db2dbm, do not need to add noise floor,
otherwise, need to add noise floor.

Besides, the value of ack_rssi passed by firmware to ath12k should be a
signed number, so change its type to s8.

This patch affects QCN9274 and WCN7850 because they have the same issue.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 14 ++++++++++----
 drivers/net/wireless/ath/ath12k/dp_tx.h  |  2 +-
 drivers/net/wireless/ath/ath12k/hal_tx.h |  4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index a22fa43c87ec..57bfa1b54655 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -374,6 +374,8 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	struct ieee80211_tx_info *info;
 	struct ath12k_skb_cb *skb_cb;
 	struct ath12k *ar;
+	bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+			       ab->wmi_ab.svc_map);
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	info = IEEE80211_SKB_CB(msdu);
@@ -393,8 +395,9 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	if (ts->acked) {
 		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
 			info->flags |= IEEE80211_TX_STAT_ACK;
-			info->status.ack_signal = ATH12K_DEFAULT_NOISE_FLOOR +
-						  ts->ack_rssi;
+			info->status.ack_signal = ts->ack_rssi;
+			if (!db2dbm)
+				info->status.ack_signal += ATH12K_DEFAULT_NOISE_FLOOR;
 			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 		} else {
 			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
@@ -451,6 +454,8 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	struct ath12k_hw *ah = ar->ah;
 	struct ieee80211_tx_info *info;
 	struct ath12k_skb_cb *skb_cb;
+	bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+			       ab->wmi_ab.svc_map);
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -486,8 +491,9 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	case HAL_WBM_TQM_REL_REASON_FRAME_ACKED:
 		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
 			info->flags |= IEEE80211_TX_STAT_ACK;
-			info->status.ack_signal = ATH12K_DEFAULT_NOISE_FLOOR +
-						  ts->ack_rssi;
+			info->status.ack_signal = ts->ack_rssi;
+			if (!db2dbm)
+				info->status.ack_signal += ATH12K_DEFAULT_NOISE_FLOOR;
 			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 		}
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index 7faa81faf6a7..55ff8cc721e3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -12,7 +12,7 @@
 
 struct ath12k_dp_htt_wbm_tx_status {
 	bool acked;
-	int ack_rssi;
+	s8 ack_rssi;
 };
 
 int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.h b/drivers/net/wireless/ath/ath12k/hal_tx.h
index 7c837094a6f7..3cf5973771d7 100644
--- a/drivers/net/wireless/ath/ath12k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_tx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HAL_TX_H
@@ -57,7 +57,7 @@ struct hal_tx_info {
 struct hal_tx_status {
 	enum hal_wbm_rel_src_module buf_rel_source;
 	enum hal_wbm_tqm_rel_reason status;
-	u8 ack_rssi;
+	s8 ack_rssi;
 	u32 flags; /* %HAL_TX_STATUS_FLAGS_ */
 	u32 ppdu_id;
 	u8 try_cnt;

base-commit: 1025c616ee13372f3803b158abb1d87ef368ae3d
-- 
2.34.1


