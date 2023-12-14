Return-Path: <linux-wireless+bounces-778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4A8126F1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 06:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3F91C21335
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 05:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBB28BEA;
	Thu, 14 Dec 2023 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JAY0EWb8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B605BD
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 21:32:55 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE3Q3NN005018;
	Thu, 14 Dec 2023 05:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=GXybb6u
	k/eH8EBBh+orHfVRpkb7PKAXLtFvnwBKl2Zo=; b=JAY0EWb84khR/UzCYbaz8Oq
	/npxXMsjZWmGUbMJNbIPFLDIq3xdlFuYsK8h73YzvjymU6YvHSojGZ/72/c7y+P4
	MCrvZCID6hzc3Zd3+IkO0sY5F6kbUwRMx3jEAtZHIBC93jcL3Tc9DVaWd2jpR+mD
	j5WWRpNyD8kFOmhFL6yrcUZcXLdPVuCYofunk88yY0kwG86l/HcmZ8j0zfmSGEfi
	jYUn2Pzuh/hdj+0tlNcOmvU/vNGYrgE1bG3Qv43HSo48tPYdi7DV7UETb6gz1ZT+
	9Ld+kq3ShW7TwCEaQZT5vWoFgp3N6tJ+sX1NgeGbh7XZxLalozUqn4/Em/pklXQ=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp4xgmad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 05:32:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE5WVfT009236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 05:32:31 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 21:32:29 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>,
        "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>
Subject: [PATCH] Revert "wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ"
Date: Thu, 14 Dec 2023 11:02:15 +0530
Message-ID: <20231214053215.2087308-1-quic_periyasa@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LhsZyb17WbGrUj9LFMPxmNcOVy6uDFOx
X-Proofpoint-ORIG-GUID: LhsZyb17WbGrUj9LFMPxmNcOVy6uDFOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312140032

This reverts commit 1f1f7d548a00ebe50808cb1f580df9693e194a7c. The commit
caused bootup failure on QCN9274 hw2.0 platform. Incorrect hardcode DP
irq offset overwrite the CE irq, which caused the driver to miss the
mandatory bootup message from the firmware through the CE interrupt. This
occurs because the CE count differs between platforms. The revert has no
impact since the original change was based on an incorrect assumption.

Log:

ath12k_pci 0000:06:00.0: fw_version 0x1011001d fw_build_timestamp 2022-12-02 01:16 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
ath12k_pci 0000:06:00.0: failed to receive control response completion, polling..
ath12k_pci 0000:06:00.0: Service connect timeout
ath12k_pci 0000:06:00.0: failed to connect to HTT: -110
ath12k_pci 0000:06:00.0: failed to start core: -110

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index b11563754d16..f0d2e2d8719c 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -17,8 +17,7 @@
 #define ATH12K_PCI_BAR_NUM		0
 #define ATH12K_PCI_DMA_MASK		32
 
-#define ATH12K_PCI_IRQ_CE0_OFFSET	3
-#define ATH12K_PCI_IRQ_DP_OFFSET	14
+#define ATH12K_PCI_IRQ_CE0_OFFSET		3
 
 #define WINDOW_ENABLE_BIT		0x40000000
 #define WINDOW_REG_ADDRESS		0x310c
@@ -559,8 +558,9 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	int i, j, ret, num_vectors = 0;
-	u32 user_base_data = 0, base_vector = 0;
+	u32 user_base_data = 0, base_vector = 0, base_idx;
 
+	base_idx = ATH12K_PCI_IRQ_CE0_OFFSET + CE_COUNT_MAX;
 	ret = ath12k_pci_get_user_msi_assignment(ab, "DP",
 						 &num_vectors,
 						 &user_base_data,
@@ -589,7 +589,7 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 		}
 
 		irq_grp->num_irq = num_irq;
-		irq_grp->irqs[0] = ATH12K_PCI_IRQ_DP_OFFSET + i;
+		irq_grp->irqs[0] = base_idx + i;
 
 		for (j = 0; j < irq_grp->num_irq; j++) {
 			int irq_idx = irq_grp->irqs[j];

base-commit: d1579581279132cab0d58e90ac2e3d5284d4cf26
-- 
2.34.1


