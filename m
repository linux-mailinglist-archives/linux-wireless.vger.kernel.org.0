Return-Path: <linux-wireless+bounces-17261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C10A08022
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 19:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F87167D05
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B11A8F97;
	Thu,  9 Jan 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pPFRxX77"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28A19995B
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448591; cv=none; b=JD+9HEx1yxsvhL1obr6L+L9Py3JvDEEobmzzr+kZJ4oDkdcg0qvcTXPKFEX1PsnACdvplRQdhAGuvPVs7neif4C0A9Mn00bINOPcwsRVkakUDZKQG6h2rPa9KqbT4zjvfsX4zn3dD0rN8KoIK6CclmUzLZWp+6k7OEurFVSfv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448591; c=relaxed/simple;
	bh=4IwRc5E7Vl0cJ3Se66Jxi7qjXqWenQozkZPH5HuMFWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WydDaMCf9HjBqb5x4j00zz5iXn6C0+qkv/q7UuXvkmi+mPxwCz2M2ukJONBldGkQHSeTbnlNIgMw83fJdqRRojM80AUZ3eRDAAM/o9pj9SBedYgLD9eYETLPHKluD+pLQZU1oBA2gjcvb/n2lf+y7SrsrmXTSeEc6XC3H8Nq04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pPFRxX77; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509E83fv007902;
	Thu, 9 Jan 2025 18:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aJyOR62nOrjGFEPbSSHXykBNS9eBKY1kw0pAUKmOFCs=; b=pPFRxX77cd+L3VnN
	H35PNZe0JEJS/kyg94EN9pZ0ZszCz0Ao3VZaFJHHRjSDQFHcPD4yUGPMQa+NoY5i
	p12jMoOdkJ43L8Xpw+/dnH3VH6NemOPoBTSIqwOGjC2Utbl+OQJmqWJ4Gx025fsn
	XiAdgk77NoHBN6+opjxKFqNfRz/fByA/B5+Fnpes/D61lcQJDLo/C2r27TEwFLUF
	M8MPSwqJZRLGwI2CYgdpy23/EdOo5wLiQ/AEJ0lbp2qAmh4ZgJ0yl2p/o4PvJqvT
	0e0jQFBgbyXSu04lWSpBlS8LthtDChDDkrFWeD/U7b8VKIYtPpUue2R7b+HN+aNY
	ai1e5Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442fxs0q1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 18:49:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 509Ini5D025318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 18:49:45 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 10:49:44 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
Date: Thu, 9 Jan 2025 10:49:31 -0800
Message-ID: <20250109184932.1593157-2-quic_bmahalin@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
References: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6mIidknqHcTwLM4j7vGFNRkznenkjiD0
X-Proofpoint-ORIG-GUID: 6mIidknqHcTwLM4j7vGFNRkznenkjiD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090149

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
index b178921aaf1d..98012e8cb30d 100644
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
@@ -373,17 +373,18 @@ struct ath12k_dp {
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
@@ -414,9 +415,15 @@ enum htt_h2t_msg_type {
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
index a8d341a6df01..76626d925adf 100644
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
@@ -971,7 +971,15 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
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


