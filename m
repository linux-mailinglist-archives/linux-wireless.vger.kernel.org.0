Return-Path: <linux-wireless+bounces-18315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11FAA26589
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB3018838E3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE2D20E71F;
	Mon,  3 Feb 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OLtPeFEg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044F20F094
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618027; cv=none; b=kUa6hL7RgrkQ9hccmwAc/SAPphe2qBP3n8KPn8NrGIAgP8jIRvY3iNYvW5SdwaGiKfuc5o6e0euz5sVvX7PX58iOsHfv919mv4A7FEmDhRQL+y0W2bo4B2vAaCmNrE21j6M40+hu2c3Q94gra1gI5TyzCxNUahvaEluDQ5R1AxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618027; c=relaxed/simple;
	bh=Nv4SkPrQfayM6wrLWVOhomoGpp+1e4L3qGg88ms28To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSGlIQParry3dKicLh0Ft5k+peQlXi/yfmMII+fgcRtOAzL9Held+2JnnnQ0xPjY4l7vhTDyvufotG700A0yAN9Yzod3OkpV88vyBe7k3eadcVBQn6tiEolA+sy649XG05eqFK0WMvhuFJ/GWUeQ/2pHfrkysxwszyERSYVbUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OLtPeFEg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513Ipr0H006227;
	Mon, 3 Feb 2025 21:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FhDHqm9IUrs8AzuNKd3eOD3KWQ5i6UGj3hd52m98PHE=; b=OLtPeFEgYrQbpUZK
	KMU5esSZeRnkwTZAos+CNbqfUC8NlZ68qJzYn54Y7uqskHVEbVuEWazqNqu17ULe
	UD/wS/ZRELP3Me4JCPC4ZEnCNwMwnBoJIbCZOLOVCmALHp/Kk1AXAgndXgjPm1eD
	zlcTcaPf6iwviibrKNtNLmOdUb3gs9dHgudQQuTGdclCOR0+vg6X4CGq/sgTKae8
	HMtzx31j00BXPs2a0EdGJLoXNrn+q3yV48ubYSAQy25NPRbeyTfTuq8WD//ygX02
	WOMqXmhdAOQkLsnPuUs6oJWSrqqH0geUYCCD/y0lxuXMQD6Cy1TkALGWGIqTkseD
	796+6Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k3ex09wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 21:26:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 513LQwIa031107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 21:26:58 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 13:26:58 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH v4 1/2] wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
Date: Mon, 3 Feb 2025 13:26:46 -0800
Message-ID: <20250203212647.2694566-2-quic_bmahalin@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203212647.2694566-1-quic_bmahalin@quicinc.com>
References: <20250203212647.2694566-1-quic_bmahalin@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BzCWVYGzEGnAyvHjXp9nrEfD31d5bP0_
X-Proofpoint-GUID: BzCWVYGzEGnAyvHjXp9nrEfD31d5bP0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030155

Update the HTT_TCL_METADATA version to the latest version (2)
as the bit definitions have changed a little to support more
features. This new version allows the host to submit a packet with
more information to the firmware. Firmware uses this additional
information to do special processing for certain frames.

All the firmware binaries available in upstream/public are compatible with
this HTT version update.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h    | 21 ++++++++++++++-------
 drivers/net/wireless/ath/ath12k/dp_tx.c | 11 +++++++++--
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index f68bb78d4a11..7cdc62aa35be 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_DP_H
@@ -372,17 +372,18 @@ struct ath12k_dp {
 };
 
 /* HTT definitions */
+#define HTT_TAG_TCL_METADATA_VERSION		5
 
-#define HTT_TCL_META_DATA_TYPE			BIT(0)
-#define HTT_TCL_META_DATA_VALID_HTT		BIT(1)
+#define HTT_TCL_META_DATA_TYPE			GENMASK(1, 0)
+#define HTT_TCL_META_DATA_VALID_HTT		BIT(2)
 
 /* vdev meta data */
-#define HTT_TCL_META_DATA_VDEV_ID		GENMASK(9, 2)
-#define HTT_TCL_META_DATA_PDEV_ID		GENMASK(11, 10)
-#define HTT_TCL_META_DATA_HOST_INSPECTED	BIT(12)
+#define HTT_TCL_META_DATA_VDEV_ID		 GENMASK(10, 3)
+#define HTT_TCL_META_DATA_PDEV_ID		 GENMASK(12, 11)
+#define HTT_TCL_META_DATA_HOST_INSPECTED_MISSION BIT(13)
 
 /* peer meta data */
-#define HTT_TCL_META_DATA_PEER_ID		GENMASK(15, 2)
+#define HTT_TCL_META_DATA_PEER_ID		GENMASK(15, 3)
 
 /* HTT tx completion is overlaid in wbm_release_ring */
 #define HTT_TX_WBM_COMP_INFO0_STATUS		GENMASK(16, 13)
@@ -413,9 +414,15 @@ enum htt_h2t_msg_type {
 };
 
 #define HTT_VER_REQ_INFO_MSG_ID		GENMASK(7, 0)
+#define HTT_OPTION_TCL_METADATA_VER_V2	2
+#define HTT_OPTION_TAG			GENMASK(7, 0)
+#define HTT_OPTION_LEN			GENMASK(15, 8)
+#define HTT_OPTION_VALUE		GENMASK(31, 16)
+#define HTT_TCL_METADATA_VER_SZ		4
 
 struct htt_ver_req_cmd {
 	__le32 ver_reg_info;
+	__le32 tcl_metadata_version;
 } __packed;
 
 enum htt_srng_ring_type {
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index aa8058dd2da6..a7fb1e0b31ff 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -1103,7 +1103,14 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
 	skb_put(skb, len);
 	cmd = (struct htt_ver_req_cmd *)skb->data;
 	cmd->ver_reg_info = le32_encode_bits(HTT_H2T_MSG_TYPE_VERSION_REQ,
-					     HTT_VER_REQ_INFO_MSG_ID);
+					     HTT_OPTION_TAG);
+
+	cmd->tcl_metadata_version = le32_encode_bits(HTT_TAG_TCL_METADATA_VERSION,
+						     HTT_OPTION_TAG) |
+				    le32_encode_bits(HTT_TCL_METADATA_VER_SZ,
+						     HTT_OPTION_LEN) |
+				    le32_encode_bits(HTT_OPTION_TCL_METADATA_VER_V2,
+						     HTT_OPTION_VALUE);
 
 	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
 	if (ret) {
-- 
2.34.1


