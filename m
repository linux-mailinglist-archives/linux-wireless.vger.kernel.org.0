Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E4771A17
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Aug 2023 08:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjHGGSN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Aug 2023 02:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHGGSN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Aug 2023 02:18:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588E510FA
        for <linux-wireless@vger.kernel.org>; Sun,  6 Aug 2023 23:18:12 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37752Bpq008430;
        Mon, 7 Aug 2023 06:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=mUiJWqprxDa8fWZUCHEMGy6EDw1/oHMnap/6yKA7P4c=;
 b=oEgMqhFFvmSMmtFB89SPELrFQgr6XfYDzlL8KdeTkhZUCwWuJcVklmrFEv+9dyEdBPK8
 geYcLoJAXElXWDwcMlSPel3/IFKvyoziItXBMFrjC11gu+/5IOckzge34DvZCOOYP0k3
 Wk1kgeeDJbCsaWahA2oA4kWJsfudLrBUhQJ/0m/5Ul+Jds7QFf+DTDUKjnorLyfb1F9Q
 e8lYnPrYODUp2xoZaYE8fWRCRZc6amVAvWKBZ0wq1DJG/cLQw+LnYD9emcxvV0nmT3QS
 lUVqtFfPKhcealzYBnzA6WjLJtJv1OedC2+TRGwLyyeaEGSi28P+49f+1kdXjif7DYZF Zw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9fqfan1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:18:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3776I7vY032734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 06:18:07 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 6 Aug 2023 23:18:06 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: ath11k: move pci.ops registration ahead
Date:   Mon, 7 Aug 2023 14:17:48 +0800
Message-ID: <20230807061749.9404-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807061749.9404-1-quic_bqiang@quicinc.com>
References: <20230807061749.9404-1-quic_bqiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EEaJytrmEe-WUvnlxRNfFsdMiS8nvizd
X-Proofpoint-ORIG-GUID: EEaJytrmEe-WUvnlxRNfFsdMiS8nvizd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
 drivers/net/wireless/ath/ath11k/pci.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 5fd08ffc2a9f..dace2835719d 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -729,7 +729,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	struct ath11k_base *ab;
 	struct ath11k_pci *ab_pci;
 	u32 soc_hw_version_major, soc_hw_version_minor, addr;
-	const struct ath11k_pci_ops *pci_ops;
 	int ret;
 
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI);
@@ -775,6 +774,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 
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
@@ -788,13 +793,21 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
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
@@ -821,7 +834,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 			goto err_pci_free_region;
 		}
 
-		pci_ops = &ath11k_pci_ops_qca6390;
 		break;
 	default:
 		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
@@ -830,12 +842,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
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

