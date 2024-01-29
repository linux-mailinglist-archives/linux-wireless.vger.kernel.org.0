Return-Path: <linux-wireless+bounces-2639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DA783FEBC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47A71C211F4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C094F1F4;
	Mon, 29 Jan 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XD9572xX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F924F1E3
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511482; cv=none; b=GBN64K55J1R5pypvoiZG2oGv8OLDaNw/+l29dkTFoH/V5Qgz2wJMLg5hPglwIWtewUsNVOccTnis+aV0dtAT6mOaux/venOtAZ9vRHq7REXocLKTU3xM6X+zE2L2fwGtK835Uw3hB+7YiqqysSu9zFGaosVYN+W8zs5vQ11xhys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511482; c=relaxed/simple;
	bh=T8ppJOXqvViQY0PGjNeJ7mv7hteveUlIZN2Z1Hd5Bdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSmo5A7NPWyMGf9u1M0oIbCE1O4cclhaXCGzqP2zFzyAXcwsTtG9hpLu2wnBgmJHs6VgyuDKJy1bPWpFLh3RGcM7G1dy0ka2bpIAAWbEzRVFbUgrW5GkkEar+a76AQoG32QSUAVrNP5lDDlTkVaUIG4d2BYNGnCpYJ37G1+GJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XD9572xX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T2xg8Z015797;
	Mon, 29 Jan 2024 06:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=SY6wsvrSRfYbaw3l4v8N4nNul8tyVkUxjTVOne6cenE=; b=XD
	9572xX/LDBn1nMvK6pMWrOU0KqmvIb2HeE86lNR9tMZM0SgYM0eIaQXLh8oLSETh
	JLRYM/9TmihOo3fc7xDgrrYwpE1s08ayvqNGUDNJbuijH5pVm7gKoOmKNhXILcM2
	dqzQhtrkx6iB65nifmKT6pT0hjtemTZchGo6SVfH52Z/c4ESTLvPCQHG4tfs+/ud
	uRYwgj0TK3EJIKh6lvgpMfQPctrwyrCpvO+skCHtTBdE7JVKzIHXjeEPdgWEd9h5
	T66PRDJgHtBXySB6LH+HSmGDi35AQcxNGSsDAjz0GGYpjweTVI2d0tAdiweBwJWd
	ZHrktCUEei5wy1Ly9U7g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvqhmu6er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6vvs4006356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:57 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:57:55 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 05/13] wifi: ath12k: Add logic to write QRTR node id to scratch
Date: Mon, 29 Jan 2024 12:27:16 +0530
Message-ID: <20240129065724.2310207-6-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: zmdmR2v41dghOaw2q_jo-UYv-j1BEXoq
X-Proofpoint-ORIG-GUID: zmdmR2v41dghOaw2q_jo-UYv-j1BEXoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290049

From: P Praneesh <quic_ppranees@quicinc.com>

Currently only one MHI device is registered successfully on platform
having two or more identical MHI devices. This is beacuse QMI service
runs with identical QRTR node ID. And, qrtr-lookup cannot register
more than one QMI service with identical node ID.

Hence, generate a unique QRTR instance ID from PCIe domain number and
bus number. QMI allows node id to be written on scratch register.
Add logic to write QRTR node id to the register. It is available for
firmware to uniquely identify an instance.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Depends-On: wifi: ath12k: add firmware-2.bin support

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/fw.h  |  5 ++++
 drivers/net/wireless/ath/ath12k/pci.c | 39 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/pci.h |  3 ++-
 drivers/net/wireless/ath/ath12k/qmi.h |  1 -
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/fw.h b/drivers/net/wireless/ath/ath12k/fw.h
index d91d95fc5740..28dc1423df70 100644
--- a/drivers/net/wireless/ath/ath12k/fw.h
+++ b/drivers/net/wireless/ath/ath12k/fw.h
@@ -17,6 +17,11 @@ enum ath12k_fw_ie_type {
 };
 
 enum ath12k_fw_features {
+	/* The firmware supports setting the QRTR id via register
+	 * PCIE_LOCAL_REG_QRTR_NODE_ID
+	 */
+	ATH12K_FW_FEATURE_MULTI_QRTR_ID = 0,
+
 	/* keep last */
 	ATH12K_FW_FEATURE_COUNT,
 };
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 76438b3afd55..7a0ed7c9f5a2 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -39,6 +39,10 @@
 #define QCN9274_DEVICE_ID		0x1109
 #define WCN7850_DEVICE_ID		0x1107
 
+#define PCIE_LOCAL_REG_QRTR_NODE_ID	0x1E03164
+#define DOMAIN_NUMBER_MASK		GENMASK(7, 4)
+#define BUS_NUMBER_MASK			GENMASK(3, 0)
+
 static const struct pci_device_id ath12k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCN9274_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN7850_DEVICE_ID) },
@@ -682,12 +686,22 @@ static void ath12k_pci_init_qmi_ce_config(struct ath12k_base *ab)
 {
 	struct ath12k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
 
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+	struct pci_bus *bus = ab_pci->pdev->bus;
+
 	cfg->tgt_ce = ab->hw_params->target_ce_config;
 	cfg->tgt_ce_len = ab->hw_params->target_ce_count;
 
 	cfg->svc_to_ce_map = ab->hw_params->svc_to_ce_map;
 	cfg->svc_to_ce_map_len = ab->hw_params->svc_to_ce_map_len;
 	ab->qmi.service_ins_id = ab->hw_params->qmi_service_ins_id;
+
+	if (test_bit(ATH12K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features)) {
+		ab_pci->qmi_instance =
+			u32_encode_bits(pci_domain_nr(bus), DOMAIN_NUMBER_MASK) |
+			u32_encode_bits(bus->number, BUS_NUMBER_MASK);
+		ab->qmi.service_ins_id += ab_pci->qmi_instance;
+	}
 }
 
 static void ath12k_pci_ce_irqs_enable(struct ath12k_base *ab)
@@ -901,6 +915,26 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
 	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
 
+static void ath12k_pci_update_qrtr_node_id(struct ath12k_base *ab)
+{
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+	u32 reg;
+
+	/* On platforms with two or more identical mhi devices, qmi service run
+	 * with identical qrtr-node-id. Because of this identical ID qrtr-lookup
+	 * cannot register more than one qmi service with identical node ID.
+	 *
+	 * This generates a unique instance ID from PCIe domain number and bus number,
+	 * writes to the given register, it is available for firmware when the QMI service
+	 * is spawned.
+	 */
+	reg = PCIE_LOCAL_REG_QRTR_NODE_ID & WINDOW_RANGE_MASK;
+	ath12k_pci_write32(ab, reg, ab_pci->qmi_instance);
+
+	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci reg 0x%x instance 0x%x read val 0x%x\n",
+		   reg, ab_pci->qmi_instance, ath12k_pci_read32(ab, reg));
+}
+
 static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
@@ -1219,6 +1253,9 @@ int ath12k_pci_power_up(struct ath12k_base *ab)
 
 	ath12k_pci_msi_enable(ab_pci);
 
+	if (test_bit(ATH12K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features))
+		ath12k_pci_update_qrtr_node_id(ab);
+
 	ret = ath12k_mhi_start(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to start mhi: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index b2edf32ada20..023616928f03 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef ATH12K_PCI_H
 #define ATH12K_PCI_H
@@ -111,6 +111,7 @@ struct ath12k_pci {
 	u16 link_ctl;
 	unsigned long irq_flags;
 	const struct ath12k_pci_ops *pci_ops;
+	u32 qmi_instance;
 };
 
 static inline struct ath12k_pci *ath12k_pci_priv(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 828ab2bf037d..6ee33c9851c6 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -15,7 +15,6 @@
 #define ATH12K_QMI_MAX_BDF_FILE_NAME_SIZE	64
 #define ATH12K_QMI_CALDB_ADDRESS		0x4BA00000
 #define ATH12K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
-#define ATH12K_QMI_WLFW_NODE_ID_BASE		0x07
 #define ATH12K_QMI_WLFW_SERVICE_ID_V01		0x45
 #define ATH12K_QMI_WLFW_SERVICE_VERS_V01	0x01
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01	0x02
-- 
2.34.1


