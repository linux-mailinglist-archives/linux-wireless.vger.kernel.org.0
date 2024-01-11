Return-Path: <linux-wireless+bounces-1701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F882A816
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 08:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A511F245B4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 07:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B81D299;
	Thu, 11 Jan 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ScFY+dnX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7635633ED
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B2ox3t010259;
	Thu, 11 Jan 2024 07:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=jl+MKBY
	mW+kyZ418WJCRg06t9JiWFR9GIRHnSbNIk/0=; b=ScFY+dnXkx3SS8yrDhsuiL2
	6deM+WPVDtBR4fbBQHiqz4uN2/wlAngLRHzToZBITgCIU6CD2KHk/4NFSKsWQgPs
	Tp1Ep39monc72Rd6jP4LLR9qDzopBPzqLUaOQmZFZcvQAYeaHAcCf8ZekPt/1ozr
	FK892olMUwXRazFnZXK+DE2mZ8396YL+Ic8GaKwiTMuV7asKkiChoMtbpzuKbN94
	esMnv/Jh3d6wwXFMxeWonXFIDLKFKxZO5qGhBFJQXgt9m2wEiXdAbvoZc6bDKmc/
	LcgUVK+IXojdzxkLrlfZ9BAKK5HCOFcgwP+1N5HCDFIqjeZbOi3iA924cukuySw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj7w58hq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 07:14:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B7EHG3011874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 07:14:17 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 23:14:16 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath11k: do not process consecutive RDDM event
Date: Thu, 11 Jan 2024 15:14:06 +0800
Message-ID: <20240111071406.14053-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: uloIw6YI5HipxFai4kaTwWe-LQhf8YJs
X-Proofpoint-GUID: uloIw6YI5HipxFai4kaTwWe-LQhf8YJs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110057

Currently we do reset for each RDDM event from MHI, however there are
cases, see below log, that we get two or more consecutive events, and
it is pointless to do reset for the subsequent ones. What's more, it
makes reset process more likely to fail.

[ 1502.115876] ath11k_pci 0000:04:00.0: boot notify status reason MHI_CB_EE_RDDM
[ 1502.115884] ath11k_pci 0000:04:00.0: firmware crashed: MHI_CB_EE_RDDM
[ 1502.224041] ath11k_pci 0000:04:00.0: boot notify status reason MHI_CB_EE_RDDM
[ 1502.224050] ath11k_pci 0000:04:00.0: firmware crashed: MHI_CB_EE_RDDM

Add a check to avoid reset again and again. This is done by tracking previous
MHI status: if we receive a new RDDM event while the previous one is
also the same, we treat it as duplicate and ignore it, because normally
we should receive a MHI_CB_EE_MISSION_MODE event between them.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 14 +++++++++++++-
 drivers/net/wireless/ath/ath11k/pci.h |  3 ++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 6835c14b82cc..855ab4d5983f 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/msi.h>
@@ -19,6 +19,7 @@
 
 #define MHI_TIMEOUT_DEFAULT_MS	20000
 #define RDDM_DUMP_SIZE	0x420000
+#define MHI_CB_INVALID	0xff
 
 static struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
 	{
@@ -325,6 +326,7 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 				    enum mhi_callback cb)
 {
 	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
 		   ath11k_mhi_op_callback_to_str(cb));
@@ -335,12 +337,21 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 		break;
 	case MHI_CB_EE_RDDM:
 		ath11k_warn(ab, "firmware crashed: MHI_CB_EE_RDDM\n");
+		if (ab_pci->mhi_pre_cb == MHI_CB_EE_RDDM) {
+			ath11k_dbg(ab, ATH11K_DBG_BOOT,
+				   "do not queue again for consecutive RDDM event\n");
+			break;
+		}
+
 		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
 			queue_work(ab->workqueue_aux, &ab->reset_work);
+
 		break;
 	default:
 		break;
 	}
+
+	ab_pci->mhi_pre_cb = cb;
 }
 
 static int ath11k_mhi_op_read_reg(struct mhi_controller *mhi_cntrl,
@@ -452,6 +463,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 		goto free_controller;
 	}
 
+	ab_pci->mhi_pre_cb = MHI_CB_INVALID;
 	ret = mhi_register_controller(mhi_ctrl, ath11k_mhi_config);
 	if (ret) {
 		ath11k_err(ab, "failed to register to mhi bus, err = %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index e9a01f344ec6..fc328142b60c 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef _ATH11K_PCI_H
 #define _ATH11K_PCI_H
@@ -64,6 +64,7 @@ struct ath11k_pci {
 	char amss_path[100];
 	struct mhi_controller *mhi_ctrl;
 	const struct ath11k_msi_config *msi_config;
+	enum mhi_callback mhi_pre_cb;
 	u32 register_window;
 
 	/* protects register_window above */

base-commit: 2cd4e3f91f264926a6b11df948417b74d52ca9b9
-- 
2.25.1


