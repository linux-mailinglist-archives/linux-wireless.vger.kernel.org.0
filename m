Return-Path: <linux-wireless+bounces-7032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D78B6C06
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 09:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFD01C21DD2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 07:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322063EA98;
	Tue, 30 Apr 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HTPvUCye"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E04179A7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463028; cv=none; b=HJqpii9SQ/YEA2pN1K/OSWfFtU1CxDH+VYGiMkrkuTB8QLX63GDluPQhBUac0ZHZv7nhTXQ+cAOD8gfG/6GCIjbFO/o2NgiIkZvp/OKD6yIy0gF+Wd4TpTAIrhQzdwBcg/ymB5nRXCNPeUygeWRXi2Eh5RowhHC+4cS+QcrehDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463028; c=relaxed/simple;
	bh=Dm+GI7TequZKD25687hrMzlni8b+tl1LEpF2tK48Iy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HU3p5DSJ3HEnuTzrQwX5Ir0SX+nfk1HcNbbEeYLgPrLWyeFd645FY5EP6geYxTN0fJSAB+12Y/f0gA0zhd3gSXTk+hHIzAYNZJAdWBpJuycV4ENEpjKu3j3O3Kx4905WLYLApyYqucCKUcHtvXLNcNaPsIZkQQr9mWijKoJGzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HTPvUCye; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U7B9CX031374;
	Tue, 30 Apr 2024 07:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Q2jZ71VIGL2SerWbgNiaBLTMrinKnWkmI2SfSwCHT4w=; b=HT
	PvUCye0B/iQXYkuS2DQrbJn0ArpXHi1LDjhc255dnWRB1OHu7kZs8A//x4zYZGjQ
	npSSJmruJC0auCQEIWFJoZzlL2VNfTGmWR9lXYfM8opI3Vq9779/Mb6nnX6VYOrv
	iCkSSUNYhdYcfp1tl8xU8jEX6LwL7CkI8yAVGAu3xYRkkwZ9r49V9DxLNRhy3Yau
	5/uyG2GD5/a8qdwrnXMoQeA0u3xhEoxbcJ5Jp6cvduamiGJU11+/1b9p+O8QJYeO
	1tRcVcWeJlYitvW+Bc2Um/BhK0Mc+6IqqNsIRj9Wq5+9GJgNW1XONR+z31bRbamK
	zQRC0JUJH0uRwdxkwTJA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtv1hr23j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 07:43:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U7hhWT021742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 07:43:43 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 00:43:41 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
Subject: [PATCH v4 2/2] wifi: ath12k: drop failed transmitted frames from metric calculation.
Date: Tue, 30 Apr 2024 13:13:13 +0530
Message-ID: <20240430074313.885807-3-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430074313.885807-1-quic_kathirve@quicinc.com>
References: <20240430074313.885807-1-quic_kathirve@quicinc.com>
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
X-Proofpoint-GUID: cIu_G3Neof0RQSpBQSKG01WtvE8PfBgp
X-Proofpoint-ORIG-GUID: cIu_G3Neof0RQSpBQSKG01WtvE8PfBgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300055

In mesh node traffic, internal firmware-transmitted failures are
reported as transmitted failures in mesh metric calculation, leading
to the breakage of the mesh link.

Fix the issue by dropping the internal firmware-transmitted failures
before updating the TX completion status to mac80211, in order to
prevent false failure averaging in mesh metric calculation.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c    | 38 ++++++++++++++++------
 drivers/net/wireless/ath/ath12k/hal_desc.h | 22 ++++++++++++-
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 81a85d5946f5..a7c7a868c14c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -482,18 +482,36 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	/* skip tx rate update from ieee80211_status*/
 	info->status.rates[0].idx = -1;
 
-	if (ts->status == HAL_WBM_TQM_REL_REASON_FRAME_ACKED &&
-	    !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
-		info->flags |= IEEE80211_TX_STAT_ACK;
-		info->status.ack_signal = ATH12K_DEFAULT_NOISE_FLOOR +
-					  ts->ack_rssi;
-		info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
+	switch (ts->status) {
+	case HAL_WBM_TQM_REL_REASON_FRAME_ACKED:
+		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
+			info->flags |= IEEE80211_TX_STAT_ACK;
+			info->status.ack_signal = ATH12K_DEFAULT_NOISE_FLOOR +
+						  ts->ack_rssi;
+			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
+		}
+		break;
+	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX:
+		if (info->flags & IEEE80211_TX_CTL_NO_ACK) {
+			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+			break;
+		}
+		fallthrough;
+	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_MPDU:
+	case HAL_WBM_TQM_REL_REASON_DROP_THRESHOLD:
+	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_AGED_FRAMES:
+		/* The failure status is due to internal firmware tx failure
+		 * hence drop the frame; do not update the status of frame to
+		 * the upper layer
+		 */
+		ieee80211_free_txskb(ah->hw, msdu);
+		goto exit;
+	default:
+		ath12k_dbg(ab, ATH12K_DBG_DP_TX, "tx frame is not acked status %d\n",
+			   ts->status);
+		break;
 	}
 
-	if (ts->status == HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX &&
-	    (info->flags & IEEE80211_TX_CTL_NO_ACK))
-		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
-
 	/* NOTE: Tx rate status reporting. Tx completion status does not have
 	 * necessary information (for example nss) to build the tx rate.
 	 * Might end up reporting it out-of-band from HTT stats.
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 63340256d3f6..71e8c8a091ae 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include "core.h"
 
@@ -2048,6 +2048,19 @@ struct hal_wbm_release_ring {
  *	fw with fw_reason2.
  * @HAL_WBM_TQM_REL_REASON_CMD_REMOVE_RESEAON3: Remove command initiated by
  *	fw with fw_reason3.
+ * @HAL_WBM_TQM_REL_REASON_CMD_DISABLE_QUEUE: Remove command initiated by
+ *	fw with disable queue.
+ * @HAL_WBM_TQM_REL_REASON_CMD_TILL_NONMATCHING: Remove command initiated by
+ *	fw to remove all mpdu until 1st non-match.
+ * @HAL_WBM_TQM_REL_REASON_DROP_THRESHOLD: Dropped due to drop threshold
+ *	criteria
+ * @HAL_WBM_TQM_REL_REASON_DROP_LINK_DESC_UNAVAIL: Dropped due to link desc
+ *	not available
+ * @HAL_WBM_TQM_REL_REASON_DROP_OR_INVALID_MSDU: Dropped due drop bit set or
+ *	null flow
+ * @HAL_WBM_TQM_REL_REASON_MULTICAST_DROP: Dropped due mcast drop set for VDEV
+ * @HAL_WBM_TQM_REL_REASON_VDEV_MISMATCH_DROP: Dropped due to being set with
+ *	'TCL_drop_reason'
  */
 enum hal_wbm_tqm_rel_reason {
 	HAL_WBM_TQM_REL_REASON_FRAME_ACKED,
@@ -2058,6 +2071,13 @@ enum hal_wbm_tqm_rel_reason {
 	HAL_WBM_TQM_REL_REASON_CMD_REMOVE_RESEAON1,
 	HAL_WBM_TQM_REL_REASON_CMD_REMOVE_RESEAON2,
 	HAL_WBM_TQM_REL_REASON_CMD_REMOVE_RESEAON3,
+	HAL_WBM_TQM_REL_REASON_CMD_DISABLE_QUEUE,
+	HAL_WBM_TQM_REL_REASON_CMD_TILL_NONMATCHING,
+	HAL_WBM_TQM_REL_REASON_DROP_THRESHOLD,
+	HAL_WBM_TQM_REL_REASON_DROP_LINK_DESC_UNAVAIL,
+	HAL_WBM_TQM_REL_REASON_DROP_OR_INVALID_MSDU,
+	HAL_WBM_TQM_REL_REASON_MULTICAST_DROP,
+	HAL_WBM_TQM_REL_REASON_VDEV_MISMATCH_DROP,
 };
 
 struct hal_wbm_buffer_ring {
-- 
2.34.1


