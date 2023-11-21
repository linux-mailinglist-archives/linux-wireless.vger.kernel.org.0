Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106317F23BB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 03:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjKUCNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 21:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUCNv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 21:13:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA308C3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 18:13:47 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL0oXjf009348;
        Tue, 21 Nov 2023 02:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Ih0uQEnhGHcMN8/UhfrcmqA7We6XLQIwnrhm4DVW6us=;
 b=VfGTuGZdptJZv0ZO2j9BKJy+6pphisYr/ZkmDq9QqHBn5ZWt2dpPnRsnnsSyiUTOPJAw
 KEMsnmE9wEAMUzYn6o7jvssy0/aJGGKzl8TDIoLevd+b0HbFWCooSGWqgOUpxfK52cgL
 BWMWNI1414YLpuzQj/Ck9R+ENo8icYCpnWGRjldb/Aj+WJYXmFGfy0OMO6OXLM8TMl5t
 PgHUT1smxwi+ICSlA/7LKOJuMnalha93A0MCqUbyrMnh/f0bIAomcD8t0EbQ60iPV3c4
 Ora3lI6grqjnHy0HQpVeSAi3acj3EhkcAtuau8IiHvfkT/U01j9u9z8jsecIkzanmF+J Cw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug0ey2ssd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:13:44 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL2Dh3U028546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 02:13:43 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 18:13:42 -0800
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 7/7] wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector
Date:   Tue, 21 Nov 2023 10:13:03 +0800
Message-ID: <20231121021304.12966-8-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121021304.12966-1-quic_kangyang@quicinc.com>
References: <20231121021304.12966-1-quic_kangyang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hg6kypZ5zlr7budi7imYntFxPuU6l6zO
X-Proofpoint-ORIG-GUID: hg6kypZ5zlr7budi7imYntFxPuU6l6zO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With VT-d disabled on Intel platform, ath12k gets only one MSI
vector. In that case, ath12k does not free IRQ when doing suspend,
hence the kernel has to migrate it to CPU0 (if it was affine to
other CPUs) and allocates a new MSI vector. However, ath12k has
no chance to reconfig it to HW srngs during this phase, thus
ath12k fails to resume.

This issue can be fixed by setting IRQ affinity to CPU0 before
request_irq is called. With such affinity, migration will not
happen and thus the vector keeps unchanged during suspend/resume.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v2: No change from v1.

---
 drivers/net/wireless/ath/ath12k/pci.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 1508dd67ed8c..8a0e4f09a796 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -617,6 +617,15 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 	return 0;
 }
 
+static int ath12k_pci_set_irq_affinity_hint(struct ath12k_pci *ab_pci,
+					    const struct cpumask *m)
+{
+	if (test_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return 0;
+
+	return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+}
+
 static int ath12k_pci_config_irq(struct ath12k_base *ab)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
@@ -1359,10 +1368,16 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_pci_msi_free;
 
+	ret = ath12k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
+	if (ret) {
+		ath12k_err(ab, "failed to set irq affinity %d\n", ret);
+		goto err_pci_msi_free;
+	}
+
 	ret = ath12k_mhi_register(ab_pci);
 	if (ret) {
 		ath12k_err(ab, "failed to register mhi: %d\n", ret);
-		goto err_pci_msi_free;
+		goto err_irq_affinity_cleanup;
 	}
 
 	ret = ath12k_hal_srng_init(ab);
@@ -1416,6 +1431,9 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 err_pci_msi_free:
 	ath12k_pci_msi_free(ab_pci);
 
+err_irq_affinity_cleanup:
+	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
+
 err_pci_free_region:
 	ath12k_pci_free_region(ab_pci);
 
@@ -1430,6 +1448,8 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	struct ath12k_base *ab = pci_get_drvdata(pdev);
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 
+	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
+
 	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
 		ath12k_pci_power_down(ab);
 		ath12k_qmi_deinit_service(ab);
@@ -1456,7 +1476,9 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 static void ath12k_pci_shutdown(struct pci_dev *pdev)
 {
 	struct ath12k_base *ab = pci_get_drvdata(pdev);
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 
+	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
 	ath12k_pci_power_down(ab);
 }
 
-- 
2.34.1

