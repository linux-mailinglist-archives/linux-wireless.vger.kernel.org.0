Return-Path: <linux-wireless+bounces-1606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FEA827CC9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 03:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236CE285642
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7423D9;
	Tue,  9 Jan 2024 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eHRKsGkz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485420F2
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40921Rvc016009;
	Tue, 9 Jan 2024 02:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=FWtpL1TaS8qiKvaqjOxIID7r7ptXpFh52y2NTCudRok=; b=eH
	RKsGkz5+BikxX9D90pdWXz6VNmsim9SSApZAgICufSEuxkB/zMWUTTTjoCx5hpcA
	6VNaMMpYCTht1vC6mkAGMCEtzJ1I5jdSNf8S5ALzgNA2ar/IS59yZOL1BehV2qhn
	RMcCuw5QgLdJGYKxnVjnwKpVPz/qreq12FPfML1OBzRvnnen1aMUz+FqbCRAXsoF
	eiYZ9D+Kz38xwA4Q7KCkapokGCimnnh4jsZk8qCUqsHcusbErN26M3uJIQrA6UTX
	gbztCh/k/KOYm+eU+3rGzWXnVLrHAhaOuneyMPahcII1jNexzIxVACwv9PSykkCd
	DgbLBy9dc0Hh9KQFOBhA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbjyjb29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 02:13:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4092Dvfu002397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 02:13:57 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 18:13:55 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 1/2] wifi: ath11k: move pci.ops registration ahead
Date: Tue, 9 Jan 2024 10:13:35 +0800
Message-ID: <20240109021336.4143-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109021336.4143-1-quic_bqiang@quicinc.com>
References: <20240109021336.4143-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: HeLXcGBXBeFk_Fqp3Oxz3qC2_raINsxC
X-Proofpoint-ORIG-GUID: HeLXcGBXBeFk_Fqp3Oxz3qC2_raINsxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090011

In ath11k_pci_probe() there is a switch statement that, based
upon the PCI device ID, assigns pci_ops. After the switch,
ath11k_pcic_register_pci_ops() is called to register the pci_ops.

Unfortunately, this registration is too late if any of the cases
in the switch need to perform operations that require the pci_ops
to already be registered. In particular, an upcoming patch for
QCA2066 needs to call ath11k_pcic_read32().

To address this issue, call ath11k_pcic_register_pci_ops() from
each case instead of doing so after the switch. That way the ops
will be registered if any subsequent operations within the case
processing require the ops to be present.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
 - Rebased on ToT.

 drivers/net/wireless/ath/ath11k/pci.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 09e65c5e55c4..1159c00f9411 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -731,7 +731,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	struct ath11k_base *ab;
 	struct ath11k_pci *ab_pci;
 	u32 soc_hw_version_major, soc_hw_version_minor, addr;
-	const struct ath11k_pci_ops *pci_ops;
 	int ret;
 
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI);
@@ -777,6 +776,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 
 	switch (pci_dev->device) {
 	case QCA6390_DEVICE_ID:
+		ret = ath11k_pcic_register_pci_ops(ab, &ath11k_pci_ops_qca6390);
+		if (ret) {
+			ath11k_err(ab, "failed to register PCI ops: %d\n", ret);
+			goto err_pci_free_region;
+		}
+
 		ath11k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
@@ -790,13 +795,21 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 			goto err_pci_free_region;
 		}
 
-		pci_ops = &ath11k_pci_ops_qca6390;
 		break;
 	case QCN9074_DEVICE_ID:
-		pci_ops = &ath11k_pci_ops_qcn9074;
+		ret = ath11k_pcic_register_pci_ops(ab, &ath11k_pci_ops_qcn9074);
+		if (ret) {
+			ath11k_err(ab, "failed to register PCI ops: %d\n", ret);
+			goto err_pci_free_region;
+		}
 		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
 		break;
 	case WCN6855_DEVICE_ID:
+		ret = ath11k_pcic_register_pci_ops(ab, &ath11k_pci_ops_qca6390);
+		if (ret) {
+			ath11k_err(ab, "failed to register PCI ops: %d\n", ret);
+			goto err_pci_free_region;
+		}
 		ab->id.bdf_search = ATH11K_BDF_SEARCH_BUS_AND_BOARD;
 		ath11k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
@@ -823,7 +836,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 			goto err_pci_free_region;
 		}
 
-		pci_ops = &ath11k_pci_ops_qca6390;
 		break;
 	default:
 		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
@@ -832,12 +844,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_pci_free_region;
 	}
 
-	ret = ath11k_pcic_register_pci_ops(ab, pci_ops);
-	if (ret) {
-		ath11k_err(ab, "failed to register PCI ops: %d\n", ret);
-		goto err_pci_free_region;
-	}
-
 	ret = ath11k_pcic_init_msi_config(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init msi config: %d\n", ret);
-- 
2.25.1


