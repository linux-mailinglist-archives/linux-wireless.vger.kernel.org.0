Return-Path: <linux-wireless+bounces-8773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 750DB902E54
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 04:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0091A1F21BD6
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F071315B0E2;
	Tue, 11 Jun 2024 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="irXyWc0s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8915B12A
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072813; cv=none; b=INatyXOXgOW6a43h/jaeaDE7Nh3rJpiJfHpYsKKWmRIRcGau9vOfa1ULcO63Vi2ggLcMzhd9Iy0ZXMRF58ZB0PD0SzYJRt/g2rf4BRQ5YC819OfvYtLLRgC1kXZ8TTJZtKGgthRkm0/Y58UpUUvk04nRzsUCUpsz2WbyLDTxoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072813; c=relaxed/simple;
	bh=o8Av+hpaZfj4y7q94TGD4EH05VjIXxqRO9miBror3Sc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RHrhZr8n8wIxXEjXWhFTxmnCwbn3kBw65Ud8EYR2yLn9jaeDivqcGsxCpjn6AJNS1lI5RjttGo2gooxkkuraZmUpScb0Y3i1QrBEIDfZVg0Lz1NrF1VDGVoRGq7IwNHfu79T0gZy+FXNQj2POyc/U1T83Z7+NeGmS7z7GjX5w0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=irXyWc0s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AFDfst003639;
	Tue, 11 Jun 2024 02:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t010cDgqIyI0/nit8U6+G+
	Zyo1bhMYMnfCJPFrmxqOw=; b=irXyWc0sroqzSBgXK354ECnJfZP/2EPBjViFpg
	PyZtfwv0cuDxOhtOIyL0K/xhhZa2cJmQo29HjBRsxL66QAUmgv/iUnn4wCVHtSoq
	1lasaTpb722VAs3F5twdO0RWHFNB0aEdYCzh8p8puRNQvdywpWV+31ImbBzrYG/D
	t50cn4D3aheiRUSzQpP9LafP+0V2PtLQO498VyrnjJrS8tCGDTbfF0/0xjWvm6ej
	OqMmciq6InrzwQFR+xH6Zn4BksMF/Hk/f4hrFDTfbEVkv7OVjU/S+cUOgX1OeI/X
	lmQDaG1FxG3mLAg64OSIE1JboxTevJyqpbpLJVrmO7ThBE0Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymg2en6me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 02:26:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B2QlN2004039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 02:26:47 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Jun 2024 19:26:46 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix ack signal strength calculation
Date: Tue, 11 Jun 2024 10:25:50 +0800
Message-ID: <20240611022550.59078-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wZjoPvS090cCzltfJQx3K8WmOWH9ovKo
X-Proofpoint-GUID: wZjoPvS090cCzltfJQx3K8WmOWH9ovKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_08,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110017

Currently, the calculation of ack signal strength is incorrect.

This is because before calculating the ack signal strength, ath11k need
to determine whether the hardware and firmware support db2dbm. If the
hardware and firmware support db2dbm, do not need to add noise floor,
otherwise, need to add noise floor.

Besides, the value of ack_rssi passed by firmware to ath11k should be a
signed number, so change its type to s8.

After that, "iw wlan0 station dump" show the correct ack signal strength.

Such as:
root@CDCCSTEX0799733-LIN:~# iw wlp88s0 station dump
Station 00:03:7f:12:df:df (on wlp88s0)
        inactive time:  75 ms
        rx bytes:       11599
        rx packets:     99
        tx bytes:       9029
        tx packets:     81
        tx retries:     4
        tx failed:      0
        rx drop misc:   2
        signal:         -16 dBm
        signal avg:     -24 dBm
        tx bitrate:     1560.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 4
        tx duration:    9230 us
        rx bitrate:     1560.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 4
        rx duration:    7201 us
        last ack signal:-23 dBm
        avg ack signal: -22 dBm

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c  | 16 ++++++++++++----
 drivers/net/wireless/ath/ath11k/dp_tx.h  |  4 ++--
 drivers/net/wireless/ath/ath11k/hal_tx.h |  4 ++--
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 21819b741701..8522c67baabf 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -353,8 +353,12 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 	if (ts->acked) {
 		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
 			info->flags |= IEEE80211_TX_STAT_ACK;
-			info->status.ack_signal = ATH11K_DEFAULT_NOISE_FLOOR +
-						  ts->ack_rssi;
+			info->status.ack_signal = ts->ack_rssi;
+
+			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+				      ab->wmi_ab.svc_map))
+				info->status.ack_signal += ATH11K_DEFAULT_NOISE_FLOOR;
+
 			info->status.flags |=
 				IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 		} else {
@@ -584,8 +588,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 	if (ts->status == HAL_WBM_TQM_REL_REASON_FRAME_ACKED &&
 	    !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
 		info->flags |= IEEE80211_TX_STAT_ACK;
-		info->status.ack_signal = ATH11K_DEFAULT_NOISE_FLOOR +
-					  ts->ack_rssi;
+		info->status.ack_signal = ts->ack_rssi;
+
+		if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+			      ab->wmi_ab.svc_map))
+			info->status.ack_signal += ATH11K_DEFAULT_NOISE_FLOOR;
+
 		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
index 61be2265e09f..795fe3b8fa0d 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021, 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_DP_TX_H
@@ -13,7 +13,7 @@
 struct ath11k_dp_htt_wbm_tx_status {
 	u32 msdu_id;
 	bool acked;
-	int ack_rssi;
+	s8 ack_rssi;
 	u16 peer_id;
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
index c5e88364afe5..46d17abd808b 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HAL_TX_H
@@ -54,7 +54,7 @@ struct hal_tx_info {
 struct hal_tx_status {
 	enum hal_wbm_rel_src_module buf_rel_source;
 	enum hal_wbm_tqm_rel_reason status;
-	u8 ack_rssi;
+	s8 ack_rssi;
 	u32 flags; /* %HAL_TX_STATUS_FLAGS_ */
 	u32 ppdu_id;
 	u8 try_cnt;

base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6
-- 
2.34.1


