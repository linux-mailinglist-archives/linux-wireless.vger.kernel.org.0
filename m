Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF39B7DC26F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjJ3W1x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjJ3W1x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:27:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FCFC6
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:27:50 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ULhVUV012470;
        Mon, 30 Oct 2023 22:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NVYPsvt3VVKF79+2JvIzdKEPc/X0twfo4hkWow0gSOo=;
 b=UsM1We9jCEFO2PY6Ss/2muoEoIzSLl6ejAp3e2Dpl1WJWmcDyf9GVmx3HHkbmTvagD/A
 wmkRJh7FZOF7va7we4D8mxdK85EBdk9A/9iNh1toyL1fHmU0I5JUp+QR93wYVPfQnVcK
 aMYkPOSy5BkENZpZaJg6OdqxsTEAx3mr+S/KmaN3YDlgo2nvgdU/q2EDeZO2EXkYBwrl
 9Uj9Q/TcSd6nZCcaEaSpRSinS9nX0qTQRDU9La78g0LvMVym2DLFtUqWgcyZ0fRbVzmJ
 mGx3W0m3OM16srnH5iimIB2zhcuA+sbC38xdX+Pal/vYDTp8nDo69N26BG+e+oRtXXHP tA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey175x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMRkXN007052
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:46 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:44 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 06/13] wifi: ath12k: Add logic to write QRTR node id to scratch
Date:   Tue, 31 Oct 2023 03:56:53 +0530
Message-ID: <20231030222700.18914-7-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D-lXkByHgXN0NUAbP0qkIDtqHRYeHt_q
X-Proofpoint-GUID: D-lXkByHgXN0NUAbP0qkIDtqHRYeHt_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=939
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 33 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/pci.h |  1 +
 drivers/net/wireless/ath/ath12k/qmi.h |  1 -
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 3006cd3fb..9567251d1 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
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
@@ -614,12 +618,19 @@ static void ath12k_pci_init_qmi_ce_config(struct ath12k_base *ab)
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
+	ab_pci->qmi_instance = u32_encode_bits(pci_domain_nr(bus), DOMAIN_NUMBER_MASK) |
+			       u32_encode_bits(bus->number, BUS_NUMBER_MASK);
+	ab->qmi.service_ins_id += ab_pci->qmi_instance;
 }
 
 static void ath12k_pci_ce_irqs_enable(struct ath12k_base *ab)
@@ -800,6 +811,26 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
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
@@ -1113,6 +1144,8 @@ int ath12k_pci_power_up(struct ath12k_base *ab)
 
 	ath12k_pci_msi_enable(ab_pci);
 
+	ath12k_pci_update_qrtr_node_id(ab);
+
 	ret = ath12k_mhi_start(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to start mhi: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 0f24fd939..6d971a367 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -109,6 +109,7 @@ struct ath12k_pci {
 	unsigned long flags;
 	u16 link_ctl;
 	const struct ath12k_pci_ops *pci_ops;
+	u32 qmi_instance;
 };
 
 static inline struct ath12k_pci *ath12k_pci_priv(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index e20d6511d..ee95299ab 100644
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
2.17.1

