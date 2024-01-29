Return-Path: <linux-wireless+bounces-2635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F783FEB8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BB5B23786
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA234E1BA;
	Mon, 29 Jan 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TXMIneqM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835A4D129
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511477; cv=none; b=bx/u9aH+qF1bwcMAeIgIbB+yWdzVC+o5FxeWPEEnRWWI8pGarr7MID6IgTuSi8RuOUwKX/fry3v9YEonfkndGqT1El0haa8nP1gTdJZna0G7YoRUDsqSNVaHnRsRV6OIoX+m1YNuCJqMwWz/uRlHvJx3LQ3xEp1YWWq+5RKR18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511477; c=relaxed/simple;
	bh=0817KlkuwJkZamIBWPgbW2j8gjsH+wl003hGmadqh6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFCN42in6w8dJMKPTzWNhOjlnAOSluGbaOA6K+Ls8ObcW1BoFLEXlejQ7GjqGbwCYq+XGtNzXz04Mz34DZr+ozoL/y8YgAtG8amYX60+Rbdx+dXXrSgmVRsabyHdXcDBg16PZEoVOo7aOI03jVLh0gsMizcymbi+BjNeUIN6YKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TXMIneqM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T3sXO5005136;
	Mon, 29 Jan 2024 06:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mrScs2RbdafVSLlMHk+yxNPPxf2zTQJl7K6yElPPvu4=; b=TX
	MIneqM1oqU+A2b+M0YbRRzMYFY1ocPRFnRcEbJ68wwjOH6hjNaJw7YlGVkrHpwIm
	riyowvI7SltQU4DuvHVs8Yi02a52TjmeJR4IItFB6M5nDZrITEGT5MJjeKxoajlq
	RAu1C/7Gqoxnb9A9um2yFhPxRXOVCFFoX4J8unprW1Cea8sb89ULQhOwsOyKSJ13
	8V8zX392W7uDkDOoOEia+4RlqYMuFAon3tgOuoEm+/Tm+SQmYyEd+mjKDgLY0BA0
	hoxKNFTFl6MBnlcsrLkzABuKnBm/foDELW5h3kWkFnRBBkP4hT2/jY8Iemlsub4K
	cDiLbCKcOMALukU0opig==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3rqgb9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6vmWB006260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:48 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:57:46 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 01/13] wifi: ath12k: indicate NON MBSSID vdev by default during vdev start
Date: Mon, 29 Jan 2024 12:27:12 +0530
Message-ID: <20240129065724.2310207-2-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SNvpmacX0mkAHJqOOHj1xvti8xHpSvkC
X-Proofpoint-ORIG-GUID: SNvpmacX0mkAHJqOOHj1xvti8xHpSvkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=762 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401290049

From: Sriram R <quic_srirrama@quicinc.com>

When any VDEV is started, MBSSID flags are passed to firmware to
indicate if its a MBSSID/EMA AP vdev. If the interface is not an AP
or if the AP doesn't support MBSSID, the vdev needs to be brought up
as a non MBSSID vdev. Set these flags as a non MBSSID AP by default
which can be updated as and when MBSSID support is added in ath12k.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 drivers/net/wireless/ath/ath12k/wmi.c | 1 +
 drivers/net/wireless/ath/ath12k/wmi.h | 8 ++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a27480a69b27..672c9d347097 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6153,6 +6153,11 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	arg.pref_tx_streams = ar->num_tx_chains;
 	arg.pref_rx_streams = ar->num_rx_chains;
 
+	/* Fill the MBSSID flags to indicate AP is non MBSSID by default
+	 * Corresponding flags would be updated with MBSSID support.
+	 */
+	arg.mbssid_flags = WMI_VDEV_MBSSID_FLAGS_NON_MBSSID_AP;
+
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		arg.ssid = arvif->u.ap.ssid;
 		arg.ssid_len = arvif->u.ap.ssid_len;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 2fa724e5851a..5f1cce16589f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1024,6 +1024,7 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 	cmd->regdomain = cpu_to_le32(arg->regdomain);
 	cmd->he_ops = cpu_to_le32(arg->he_ops);
 	cmd->punct_bitmap = cpu_to_le32(arg->punct_bitmap);
+	cmd->mbssid_flags = cpu_to_le32(arg->mbssid_flags);
 
 	if (!restart) {
 		if (arg->ssid) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 06e5b9b4049b..d8481c710021 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_WMI_H
@@ -2764,6 +2764,10 @@ struct ath12k_wmi_ssid_params {
 
 #define ATH12K_VDEV_SETUP_TIMEOUT_HZ (5 * HZ)
 
+enum wmi_vdev_mbssid_flags {
+	WMI_VDEV_MBSSID_FLAGS_NON_MBSSID_AP	= BIT(0),
+};
+
 struct wmi_vdev_start_request_cmd {
 	__le32 tlv_header;
 	__le32 vdev_id;
@@ -2782,7 +2786,7 @@ struct wmi_vdev_start_request_cmd {
 	__le32 cac_duration_ms;
 	__le32 regdomain;
 	__le32 min_data_rate;
-	__le32 mbssid_flags;
+	__le32 mbssid_flags; /* uses enum wmi_vdev_mbssid_flags */
 	__le32 mbssid_tx_vdev_id;
 	__le32 eht_ops;
 	__le32 punct_bitmap;
-- 
2.34.1


