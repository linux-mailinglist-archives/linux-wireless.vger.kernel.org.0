Return-Path: <linux-wireless+bounces-18270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE9EA25174
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF373A1825
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 02:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAAE1172A;
	Mon,  3 Feb 2025 02:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JcfLqQAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18F25A630
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738551046; cv=none; b=Gj0EFojSB766a2ABeUYvjIg1eWavBH/oz6kK7y+RB2+svolNiQVDOQlsxmjBjUtxCFABOIDhe2yA3lIBzCnjq0KmD6/U+Zmdfyv6uR/9uIZ0xcwf/oBrBFKW52mAkLvcMwxZnO/U1VxLx95NFHjRjN4H7a0l0Y8oxriye0GrWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738551046; c=relaxed/simple;
	bh=jAtztAYWecVo31N3IrGz1LqGshbxwQ+pv2e58Oqb/uY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGPxoi1urGh0gGlsiyFWWa3TyAhbZq+JabzzROtsvV6i37PJbzgwvpqv3lhy4uWgMACLi15/Odv0diBZaTOlem8/Xi6H+jcZg68M5+gy80yG8+WqNVZzA3199rudUEbfNQxbgP4ERLciMFCZzEdBbnJQTpLYg/KxspRhNVRIU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JcfLqQAC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 512NS2hE009267;
	Mon, 3 Feb 2025 02:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	losvfwiy+oxSC//U9hZClq2UjaEKhbLny1GwfnJpMyM=; b=JcfLqQACbE77LN05
	WHw6JS25+QuZ1jYRZQi9dZ/wrqXb/3R3DwBpOVbvbYVJ5TsTihp2TsfGNnyPQvKQ
	7St6H/DsaTaKb555epxp1+tN8gaewQpZMTwaT8EHnYxtvKymEbMi2bFR3IKOZ1cE
	7Mrv83C/QiqN5+kfxhwr6kuO3vogu99XYsfC70+zOYrzuKgn7rs8lF392vc7+V6o
	IkKqxi7iSZw8goXC6VuUnwcF4oWNGuKfw/0fWeC5K8rLWzA8oaTS2VrTlQnW5aVF
	QR9p3punRNG90+ZPotcLkfHJuVeFNk0KOaGVcLxDnjOnhl9pvOXQruDdhDOzumIR
	PnSvmw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jc0t0jtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 02:50:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5132oeE9017866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 02:50:40 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 2 Feb 2025 18:50:39 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH v2 1/2] wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
Date: Sun, 2 Feb 2025 18:50:15 -0800
Message-ID: <20250203025016.3851279-2-quic_bmahalin@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203025016.3851279-1-quic_bmahalin@quicinc.com>
References: <20250203025016.3851279-1-quic_bmahalin@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jeh7q9_FJHiK7VbcjQK0GD64SQB-7bNP
X-Proofpoint-GUID: jeh7q9_FJHiK7VbcjQK0GD64SQB-7bNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-02_11,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030022

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
 drivers/net/wireless/ath/ath12k/dp_tx.c | 12 ++++++++++--
 2 files changed, 24 insertions(+), 9 deletions(-)

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
index aa8058dd2da6..5ed41783d039 100644
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
@@ -1103,7 +1103,15 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
 	skb_put(skb, len);
 	cmd = (struct htt_ver_req_cmd *)skb->data;
 	cmd->ver_reg_info = le32_encode_bits(HTT_H2T_MSG_TYPE_VERSION_REQ,
-					     HTT_VER_REQ_INFO_MSG_ID);
+					     HTT_OPTION_TAG);
+
+	cmd->tcl_metadata_version = le32_encode_bits(HTT_TAG_TCL_METADATA_VERSION,
+						     HTT_OPTION_TAG);
+	cmd->tcl_metadata_version |= le32_encode_bits(HTT_TCL_METADATA_VER_SZ,
+						      HTT_OPTION_LEN);
+	cmd->tcl_metadata_version |=
+			le32_encode_bits(HTT_OPTION_TCL_METADATA_VER_V2,
+					 HTT_OPTION_VALUE);
 
 	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
 	if (ret) {
-- 
2.34.1


